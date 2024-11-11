Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BE4D41D44
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 02:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F5C8893D6;
	Tue, 12 Nov 2024 03:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MPhQl+ri";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D44BA89396; Mon, 11 Nov 2024 22:10:10 +0100 (CET)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F5AF89390
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 22:10:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20c805a0753so47253175ad.0
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 13:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731359407; x=1731964207; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aPoIDQjwyqTJMc9HLP4lUKeHVgijTrnZghSNcCzPR4Q=;
 b=MPhQl+rir4R9MfOtrkgOGmIIrP5eIu6s5N5YQd+QIBIuS2EwZ689M6+Bt0SC4C5oGU
 octb1tEysOe6vsgMViBCqAzrJdmZdll4qVU31Pe5M07gg7C2cc4v8Sp3P4sPta8CTyYi
 pK/HWmlJ90Dye0svFVKu21/8avMe+fDg0poY5FQsRPiIRwksJQT1bBILLnqEdYpNwOs6
 3GUiYQzVtcpGczzK0jSFl2BS7yeWtrEn/r11dXBkjo+3S9kWfKZrkXHUgVbmlLrQg2oI
 Lv78ZuIwrAa4PT6xUWTQRIWBh56Xu9nFkrdjskQ+RmpYVQ5LMnYav/L3aI2GgnnMRAOo
 /3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731359407; x=1731964207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aPoIDQjwyqTJMc9HLP4lUKeHVgijTrnZghSNcCzPR4Q=;
 b=fVepZ+GAqptaSq9tlAx8Xr/QtvwvCw34n3cWWwKPKyvF7NYeGl2zAikaLDVwPBQDdz
 s25Bd1RMT9ElRQvvUClXprUqn+e62BpranR1w03BWGMcVD0QZWe+xLEl3dAeMwGvVrtZ
 ysUUe7kejyrkIF1JnSeDY/eiDz3VWWXuLfVGWbgN2I4NIgFIF6dXWTN2wPzAh4PDlDrq
 xMFNGkdu2gF4hm04+4elXVu61h6p5TmZheGKVvei1tiYFKfq/Hvzv9F6LdL4msbpVNlo
 8IWDTW2dTAHmHL3Uq6jg4OGmPgkoGxeEVZTPPKXOXZ5LY8bu4dQQZokW+tV1ZUwJRO7N
 yOsQ==
X-Gm-Message-State: AOJu0YyTzXMDpl69OyntFhQz90ll2dYBpfRFPe2vGEWPWCIhiP8znlBt
 x3UssrnRncrFGFeSKhuaPx6Fgk4IjBa7RFF5vuLRupi1u2aKIKE0H2Qzswn0
X-Google-Smtp-Source: AGHT+IHvJo38RGFc6qpZZFv8clEawXjaNn7C4XDnC+wqLbiCSD9WBM3b9QOlLINLYlsOsy5dVPRscA==
X-Received: by 2002:a17:902:f685:b0:20b:951f:6dff with SMTP id
 d9443c01a7336-21183b91f73mr201642695ad.0.1731359407119; 
 Mon, 11 Nov 2024 13:10:07 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc9e25sm80031165ad.27.2024.11.11.13.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2024 13:10:06 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v3 01/15] net: net_utils: Move ip_to_string to lib/net_utils.c
Date: Mon, 11 Nov 2024 18:09:45 -0300
Message-ID: <20241111210959.560738-2-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241111210959.560738-1-adrianox@gmail.com>
References: <20241111210959.560738-1-adrianox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 12 Nov 2024 03:47:02 +0100
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

(no changes since v2)

 include/net-common.h | 10 ++++++++++
 lib/net_utils.c      | 11 +++++++++++
 net/net.c            | 11 -----------
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/include/net-common.h b/include/net-common.h
index 3cd0f34374..b7a519e36d 100644
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

