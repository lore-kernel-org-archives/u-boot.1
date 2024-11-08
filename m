Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE8BD5C0F5
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 15:56:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 746308910E;
	Fri,  8 Nov 2024 16:56:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lDcTiGAZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3328588ECB; Fri,  8 Nov 2024 14:39:55 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0427988D47
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 14:39:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20cb47387ceso23161695ad.1
 for <u-boot@lists.denx.de>; Fri, 08 Nov 2024 05:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731073191; x=1731677991; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3smQ/dr0kpZX2NgGlaiaSGmnelhwmV0GUpA67VbGHmc=;
 b=lDcTiGAZjk4cxifSgSwRvLXLOvGlIHCZW5+M6Tvj8cmeF1FfIBloYop2rddXTR3ahb
 9lwEzSOs26kHEaa1ZnwouIZSqyTwG/78+lvsoZM5XuC86MuFKPVE+6xYxUfZ/LO9EE/5
 RMnnh7yNLvWSieZXoM0Gp1wrO6nkviHoXteb5GuGa0Nv4DNc+pHMQ05rM1Z8MqOgW9LZ
 TL+IHl019rsXk2cx6seXLIqrOCOfFRqapHWN0IjhG4L6csOq0jzlyTxv/BC2Nuu9+7Yg
 8H4w/u53sWXD40qCACS62KXeam/z+QQE27n9M+b36AgsBq5uErnu6biZXv6omp+QXl5g
 8frQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731073191; x=1731677991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3smQ/dr0kpZX2NgGlaiaSGmnelhwmV0GUpA67VbGHmc=;
 b=Y9ZT1XcnmLILh5MtQqFN1K0vvLxb4quYWTiDvY3wYZvj0P6T5CLWja9qD1NpjniXVc
 ng2dEVF01g2j5xORX2t2pU5e2p2TS0QTmbkn4koefo4dqgqjC/8FxYIFge3GV84Vu9rn
 AQzOkztqQwPR9QJa9Ij7bE/6SRbeLWl5aSv+1HX3/KfKgcyTmsMpcZoXLT5kIz5n9z7g
 1OKW5F02sfOgTjAXjQYtTzPL96qegGGOT3u7dAndv5/Dqr7bX0eAxdkcg6FD8xTs6nzN
 FvbpY2NWb6t4r5WnMIHIXroJXzgTY9XTjuwaPXW47Qpo19gtTm9CJH+KupFfN6SjJYZ5
 sBRw==
X-Gm-Message-State: AOJu0YxEE8leiey6UTphFRExuFk8gaW0SZkuxp4T3g6syV2a4FcKWayE
 whGsVM7VxBg8xGwakVztWAkR+PPT4QaUwYXW/O0/CwBlWJGDVLeN6tDKNkmZ1RQ=
X-Google-Smtp-Source: AGHT+IFjAT7VPSuaKbF+eG27lLk5zcYl0HErdj9SLHes+31xFneaEcboO7dOfKt1D0E6nyyyrQXQCg==
X-Received: by 2002:a17:902:f681:b0:20c:7c09:b2ac with SMTP id
 d9443c01a7336-211835cca0emr32639175ad.52.1731073191163; 
 Fri, 08 Nov 2024 05:39:51 -0800 (PST)
Received: from adriano.. ([190.215.83.227]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc8376sm30296295ad.44.2024.11.08.05.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 05:39:50 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH v2 01/15] net: net_utils: Move ip_to_string to lib/net_utils.c
Date: Fri,  8 Nov 2024 10:38:36 -0300
Message-ID: <20241108133850.431075-2-adrianox@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241108133850.431075-1-adrianox@gmail.com>
References: <20241108133850.431075-1-adrianox@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Nov 2024 16:56:12 +0100
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

