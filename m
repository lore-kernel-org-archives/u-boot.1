Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C5AD5C0C3
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 13:06:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A4478910E;
	Fri,  8 Nov 2024 14:06:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N/9HazuX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA67F88DB6; Fri,  8 Nov 2024 04:44:53 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9CA788B8F
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 04:44:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71e8235f0b6so1421677b3a.3
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 19:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731037490; x=1731642290; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3smQ/dr0kpZX2NgGlaiaSGmnelhwmV0GUpA67VbGHmc=;
 b=N/9HazuX6VE+eVpTOGq9dSdLbXHgB+xDvfWHkxFpdZzjTfFXv6gQxBWBHwXN2nE6SK
 NKDjAXUJs9FHYuoTtpcvONw4lEpKQ3mhnCRQJgL0gA1yb8vYmp2nb7YnCHct9Mjc2ByS
 23Qy+cImuESoqrtFThyPUHjXmb634dAxkoZQ9jXRy8HKgtOwv0PjZ2Cp5jSKYbWlLDMF
 LRxEZ8/JT8trUcPVzuw0SrVLpwPdrien+iy5HtBWaWpSdij0izhedsVTtK9fhWML+j8m
 P71STNPBC4eKCPNPHkKHBTEQXqKgLQp0SD6Gv9Np8cCJ9IH0RHjwnPXkWaHOCkLcAive
 rHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731037490; x=1731642290;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3smQ/dr0kpZX2NgGlaiaSGmnelhwmV0GUpA67VbGHmc=;
 b=CKMRBLXUQ6Di57aPBc7/cb3o2L6lkTOWCL6p+nYTrlwOmUqsnWTnjbBPSoJoe0lBzM
 1g8/A54XQVD5c9XJpu5YgHzOPR3Rka8SW4e1+ER4ujxn7wJbIwcb/fWHe/Lf0rx7CEaG
 L/lnu5Y9W8adSKJ47m2CdLxWBhPN0UaIExFyc3/0fpEWfqqxQZKyW9S5XBjTZzpMbEY6
 KTY9YPJcs31k3dJlEv0JR3+oVt43k6d5LNST8VwS66o/nnclSxNwD2kErjVx2jI7zebZ
 cMU3p8Lq48hw+KiFKTq84avOtplBgl32AiQAWgxLtpfNeoe08MOSh+8+WaEjytLsOp31
 0t9g==
X-Gm-Message-State: AOJu0YzaJV+8z+NQm72W8hLSWeyFjYxaUUGZ8kpE4vpgSIAfUrfLXQSo
 2mpYdDwQ8PFi7x/zpRUr0lW2kbFCarJrA+dPcAyFuJhOL61v92LuIFChDMXqa3Y=
X-Google-Smtp-Source: AGHT+IF0bgVnPxCiZotqEJZMpkOLJ+sI7vcRmah8cglKxpTMwjVziXpDc9j1EncZONmbOv6AC4icbw==
X-Received: by 2002:a05:6a21:6d9f:b0:1db:dce8:c26f with SMTP id
 adf61e73a8af0-1dc22b575e4mr1832795637.33.1731037490199; 
 Thu, 07 Nov 2024 19:44:50 -0800 (PST)
Received: from adriano.. ([190.215.83.227]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724078a7e7asm2555659b3a.70.2024.11.07.19.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 19:44:49 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 01/15] net: net_utils: Move ip_to_string to lib/net_utils.c
Date: Fri,  8 Nov 2024 00:44:44 -0300
Message-ID: <20241108034444.346164-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Nov 2024 14:06:21 +0100
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
index 11c53766a3..5206b8346d 100644
--- a/include/net-common.h
+++ b/include/net-common.h
@@ -426,6 +426,16 @@ void string_to_enetaddr(const char *addr, uint8_t *enetaddr);
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

