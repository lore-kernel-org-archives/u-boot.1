Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCDFD33A37
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 18:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C7E48900E;
	Tue,  5 Nov 2024 19:45:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="krNM9obz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 249A98917B; Tue,  5 Nov 2024 18:13:01 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E76D188A0A
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 18:12:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71e467c3996so4883976b3a.2
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 09:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730826777; x=1731431577; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ye/NHMeab3r+SM0LBWrrrwza8yEYfD+QMogHK+dyuhk=;
 b=krNM9obzFLAadtCU6IwApvhbv10dLdj8FiimtXaEzNH1OxtlQKy7BWNEWJysZiw+jQ
 +pAYgv7DsKnByB7nW+VkqPy8oVoTryIbTzFeB+UvWslEKsralOTtU8QWJGtF2oAYz34z
 RhkKdlaiA2MigmzFCOyBS4pNlq4HHkS4MKGRY642wEe7/vkl1YvrijRUpuVbbTnnk8E1
 QO3y3tLjnenNyC4XCzlJlh/tm7RePQ1AV3HX+d+04x5En5RrQVerup8dWpz6z1Cet3iH
 xWyqtI8TTm8+ME0hgsvtFYF1xHjw8f/5RrX8BEg+hMvUXb+2QJS6L/JeXaocEf4EyJUZ
 PqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730826777; x=1731431577;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ye/NHMeab3r+SM0LBWrrrwza8yEYfD+QMogHK+dyuhk=;
 b=OS/Re9jx9HR66FGVQdORF6gMMtjxYwcKOG7p53Pn759EEQCPWaaKXaqOhfe+I5TJ0D
 t0ykfV069HAXTPMXBY8TqZJJ0r3J04PvI4wcHpIAjd15fg/3NkmZyLkB/1Xkhi/BUzPp
 3ld9Wpq6I3FsGXpTf8YU5PmjRP5WqU/0jo3eR37eRkzzw2RRuJGnvOmmkhl1Qql1aOkl
 75sy6FvDaTWsKD1dQ0SVSNskuI3pbfyj0xZmlEh20CyAtT5voD/HqP2kVP4NVW/g7+Ag
 gXFGzrs4+d0wf6WeyB3Nqjb3sPX4ZDH9hYAl7bN+iJkNiZLbsSoTMENalycKzByvXT4Q
 OWxQ==
X-Gm-Message-State: AOJu0YyLv38PyDzk5lm8SQjtkWhRsOnh71HM5OwTD3MpEbtPfvfdOG/p
 glEhWzyTGEP5xSMuW2P6Vm7HvRlHSN4zgn3b9S0UDEOxmezLzPk11/lkEsI6iNo=
X-Google-Smtp-Source: AGHT+IFaPJpniElTk8zxX964H+oc2GmjYpFuliIgq15ZXgSRL4ou/+LkXSxgP7SnmdA+1PjDUuLOVA==
X-Received: by 2002:a05:6a21:38c:b0:1cf:4ad8:83b9 with SMTP id
 adf61e73a8af0-1d9a8514112mr50161261637.43.1730826777352; 
 Tue, 05 Nov 2024 09:12:57 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc2c4a8csm9921772b3a.120.2024.11.05.09.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 09:12:56 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH] net: net_utils: Move ip_to_string to lib/net_utils.c
Date: Tue,  5 Nov 2024 14:12:14 -0300
Message-ID: <20241105171214.120364-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 05 Nov 2024 19:45:54 +0100
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

The function string_to_ip is already in net_utils, which is
compiled unconditionally, but ip_to_string is currently only
accessible if the legacy network stack is selected. This
commit puts ip_to_string in net_utils.c and removes it from the
legacy network code.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 include/net-common.h | 10 ++++++++++
 lib/net_utils.c      | 11 +++++++++++
 net/net.c            | 11 -----------
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/net-common.h b/include/net-common.h
index fd7c5e7b48..cb55816ced 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -425,6 +425,16 @@ void string_to_enetaddr(const char *addr, uint8_t *enetaddr);
  */
 struct in_addr string_to_ip(const char *s);
 
+/**
+ * ip_to_string() - Convert a string to ip address
+ *
+ * Implemented in lib/net_utils.c (built unconditionally)
+ *
+ * @x: Input ip to parse
+ * @s: string containing the parsed ip address
+ */
+void ip_to_string(struct in_addr x, char *s);
+
 /* copy a filename (allow for "..." notation, limit length) */
 void copy_filename(char *dst, const char *src, int size);
 
diff --git a/lib/net_utils.c b/lib/net_utils.c
index c70fef0d99..621f6512b6 100644
--- a/lib/net_utils.c
+++ b/lib/net_utils.c
@@ -152,6 +152,17 @@ out_err:
 }
 #endif
 
+void ip_to_string(struct in_addr x, char *s)
+{
+	x.s_addr = ntohl(x.s_addr);
+	sprintf(s, "%d.%d.%d.%d",
+		(int) ((x.s_addr >> 24) & 0xff),
+		(int) ((x.s_addr >> 16) & 0xff),
+		(int) ((x.s_addr >> 8) & 0xff),
+		(int) ((x.s_addr >> 0) & 0xff)
+	);
+}
+
 void string_to_enetaddr(const char *addr, uint8_t *enetaddr)
 {
 	char *end;
diff --git a/net/net.c b/net/net.c
index f47e9fbe33..ca35704f66 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1723,17 +1723,6 @@ int net_parse_bootfile(struct in_addr *ipaddr, char *filename, int max_len)
 	return 1;
 }
 
-void ip_to_string(struct in_addr x, char *s)
-{
-	x.s_addr = ntohl(x.s_addr);
-	sprintf(s, "%d.%d.%d.%d",
-		(int) ((x.s_addr >> 24) & 0xff),
-		(int) ((x.s_addr >> 16) & 0xff),
-		(int) ((x.s_addr >> 8) & 0xff),
-		(int) ((x.s_addr >> 0) & 0xff)
-	);
-}
-
 void vlan_to_string(ushort x, char *s)
 {
 	x = ntohs(x);
-- 
2.43.0

