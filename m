Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F87D11195
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 22:43:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89B0689138;
	Sun,  3 Nov 2024 23:42:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="VXDqQBi9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D202F890D1; Sun,  3 Nov 2024 23:42:39 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE8E389110
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 23:42:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-105-238.46.114.pool.telefonica.de
 [46.114.105.238])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id EA1EE3FE13; 
 Sun,  3 Nov 2024 22:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730673755;
 bh=9pMgtYt1JJXWB1X4pgfVcsS5KGZQEtp2/J+otIi3Emc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=VXDqQBi9CHxGCft55IXxmKnklO9IybCZEXln1RgAnr2SMZdqFKAZwfh+g6GWdQKR4
 CXCebkCkiugWFN06yFCsgoQjI2Xwdxc5rQYzBnSj7gk4IRR4OaWm8wrwVj81rIHfJf
 szipTj7m48NaKSjpCVaXZzA90it3JtE69I3raguq1YYaSfZGec21ylHWhc37nvpSdj
 7Hl6o0Hd93WFO6TQL87mNLbD4Eqq+fOuZJXkdcAdFWJruHljr6rEKBVe/UKLrASdA+
 1f5OKfmO147ljT0TJ8N3DV/3iH/sGSVpRwHw0NxQLusq4fDJZdSYqtZDJzkC+3irhS
 S78ZOKj2OZXSA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH v2 3/4] lib: uuid: fix uuid_str_to_bin() on 32-bit
Date: Sun,  3 Nov 2024 23:42:22 +0100
Message-ID: <20241103224223.195255-4-heinrich.schuchardt@canonical.com>
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

hextoul() cannot convert a string to a 64-bit number on a 32-bit system.
Use function hextoull() instead.

Reported-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Fixes: 22c48a92cdce ("lib: uuid: supporting building as part of host tools")
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 lib/uuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/uuid.c b/lib/uuid.c
index 19f33dd1477..538a1ba6aa8 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -313,7 +313,7 @@ int uuid_str_to_bin(const char *uuid_str, unsigned char *uuid_bin,
 	tmp16 = cpu_to_be16(hextoul(uuid_str + 19, NULL));
 	memcpy(uuid_bin + 8, &tmp16, 2);
 
-	tmp64 = cpu_to_be64(hextoul(uuid_str + 24, NULL));
+	tmp64 = cpu_to_be64(hextoull(uuid_str + 24, NULL));
 	memcpy(uuid_bin + 10, (char *)&tmp64 + 2, 6);
 
 	return 0;
-- 
2.45.2

