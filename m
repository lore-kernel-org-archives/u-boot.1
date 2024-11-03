Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AD6D11195
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 22:42:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28F87890F8;
	Sun,  3 Nov 2024 23:42:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="N5ReezwL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BB0B88F94; Sun,  3 Nov 2024 23:42:38 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8136E88FB5
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 23:42:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-105-238.46.114.pool.telefonica.de
 [46.114.105.238])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id BB6343FE11; 
 Sun,  3 Nov 2024 22:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730673754;
 bh=gr82C8gSCi8IatpIQRjDzd+qQ0mrltjUXe2zd6beprw=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=N5ReezwLarcNv4AScltcTf9YfJez6Qc4C5V5TKw+1ONSMyytqyB8oGCT6xjBMYay2
 KGFrTtKKfO4HRT6QXYz6dKBF7ac4BfTGJikwbjJzFVu5ESQdkcWrgyGpsCS1Trn29h
 tyX+YRUzvn0+tjhiiaFBq3Zdq1fA/MbPSYU+9NLXy1ll49Vton5uzCiwQEDr8vKCsV
 lpjFdUyB4eWdvA1DRp6m5ZPnXTuD+Mc6wPJeAP5zeIeQQDERKgjqnlmg6SwxIWx4aK
 ojcOiMwPIEVbplUs6r8VSbrQL28VtW8ODBFFNE6Jk0QbCfascWUNFyPMKhtwWR8xqN
 7pkXIRRWX75tg==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/4] lib: provide function hextoull()
Date: Sun,  3 Nov 2024 23:42:20 +0100
Message-ID: <20241103224223.195255-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241103224223.195255-1-heinrich.schuchardt@canonical.com>
References: <20241103224223.195255-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

We often convert hexadecimal strings to hextoull(). Provide a wrapper
function to simple_strtoull() that does not require specifying the radix.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	no change
---
 include/vsprintf.h | 13 +++++++++++++
 lib/strto.c        |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/include/vsprintf.h b/include/vsprintf.h
index fe951471426..9da6ce7cc4d 100644
--- a/include/vsprintf.h
+++ b/include/vsprintf.h
@@ -44,6 +44,19 @@ ulong simple_strtoul(const char *cp, char **endp, unsigned int base);
  */
 unsigned long hextoul(const char *cp, char **endp);
 
+/**
+ * hex_strtoull - convert a string in hex to an unsigned long long
+ *
+ * @cp: The string to be converted
+ * @endp: Updated to point to the first character not converted
+ * Return: value decoded from string (0 if invalid)
+ *
+ * Converts a hex string to an unsigned long long. If there are invalid
+ * characters at the end these are ignored. In the worst case, if all characters
+ * are invalid, 0 is returned
+ */
+unsigned long long hextoull(const char *cp, char **endp);
+
 /**
  * dec_strtoul - convert a string in decimal to an unsigned long
  *
diff --git a/lib/strto.c b/lib/strto.c
index f83ac67c666..206d1e91847 100644
--- a/lib/strto.c
+++ b/lib/strto.c
@@ -78,6 +78,11 @@ ulong hextoul(const char *cp, char **endp)
 	return simple_strtoul(cp, endp, 16);
 }
 
+unsigned long long hextoull(const char *cp, char **endp)
+{
+	return simple_strtoull(cp, endp, 16);
+}
+
 ulong dectoul(const char *cp, char **endp)
 {
 	return simple_strtoul(cp, endp, 10);
-- 
2.45.2

