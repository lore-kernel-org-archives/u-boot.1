Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040ECC52D6D
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 12:55:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C08288BBA;
	Fri,  2 Aug 2024 14:54:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="vD2TSSW3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CBA9888A4; Fri,  2 Aug 2024 11:31:36 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B435C88BC7
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 11:31:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ef2fccca2cso90249391fa.1
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 02:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1722591089; x=1723195889;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+2olUrUQfYiu12F66P91k0rynBskiCCb0nwH3rge9yY=;
 b=vD2TSSW3EChOfAleaL+BkWDK5m1XhY3rOxRSP22w2Y5GJZq2tWWkqEaXhXaPDIaTzm
 NLfbAONZmfnyiQerZlUT+V/mCDyrUtPXYbIJRGG3XCZmSZhKUBHShWoEoXM+0SYeBfa0
 j38CLSZUh2Vchu5ZUp9NwaPS+BPxN4xsh4UsRvQMIuH8E5VD299ep1faruO7bi97cchl
 h8WqapWjIJlDv1T1DQdgNB5KgGZjl4IVWWlYe9L7s0dnkckVcSSJLWE1UW7R4fCUPFXL
 LgNIaby3N8wmFoeXyojrOb14N8KqmeFEpxVpn7oYE+ZGUE5U3MylZ4sCPF9e+xGKcB+p
 V2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722591089; x=1723195889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+2olUrUQfYiu12F66P91k0rynBskiCCb0nwH3rge9yY=;
 b=vMwntItFJNdm2ZkdUx+klF9lSpvRAfaGmdflMGv3E1HWx+B/Rg5IX8o3F2guXJKaQe
 XyOdsvF1NOGgiA9PTlSgxPSTIGjcACrdQxfB1vdsg2I5zGi5lF063NQwE8u2waKllTCj
 npVX2HJDENc4izNrMq1O9rVofgfp3bmSK9UKXzQJgtOrzCbRvPRgVgG9xxoMGXHGx1rO
 G7cR9yg4F9V5Y1zxnFBsFgb06Ug7zy3W54nJuTyZmcrNdGneQzhO0Pzcg2ibTAf2D6MC
 rOFHlr66Z3MnHAmRfzGLQlhOciASslh0+gk6jEgCwLYeAMKBuVF3/1xD3F3g6tINBDrj
 z9/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNb2LTrNRiobl1EzO0xzCVT3UC1KYUHgrEjqYUfQJ3FGJ0IYGvYFo+Ddxgt2TfA1oiabaQefLFhq0ll7kDGvG27sy+2Q==
X-Gm-Message-State: AOJu0Yzf1vTR1xchUt7olgk+iW7gRKf9jphnG+jXTjL3sYMR2urcFqTa
 JeSyznv5HeZj5cbDt9cPlb9R3rEr0opLv4uqM/mEa2x3abph1j7zACPpbmZOyEQ=
X-Google-Smtp-Source: AGHT+IGpaKQe4J3c/876BH3w79l9D3E3qrlVNeMqguolDPOsPg+ken9OmlJMGpcS9JNyem4E4R9TQg==
X-Received: by 2002:a2e:2e03:0:b0:2ef:2543:457c with SMTP id
 38308e7fff4ca-2f15aab06f2mr18794781fa.24.1722591088755; 
 Fri, 02 Aug 2024 02:31:28 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-42824130e43sm83671905e9.0.2024.08.02.02.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 02:31:28 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [PATCH] cmd: bind: Use device sequence instead for driver bind/unbind
Date: Fri,  2 Aug 2024 11:28:13 +0200
Message-ID: <20240802092820.917450-3-admin@hifiphile.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802092820.917450-1-admin@hifiphile.com>
References: <20240802092820.917450-1-admin@hifiphile.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 Aug 2024 14:54:36 +0200
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

Currently uclass index is used for bind/unbind which ignores alias
sequence numbering. Use device sequence number instead as it's
the number explicitly set in the DT.

Also update documentation to use sequence number.

Signed-off-by: Zixun LI <admin@hifiphile.com>
---
 cmd/bind.c               | 46 ++++++++++++++++++++--------------------
 doc/usage/cmd/bind.rst   | 12 +++++------
 doc/usage/cmd/unbind.rst | 14 ++++++------
 3 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/cmd/bind.c b/cmd/bind.c
index 3a59eefd5c..c0d31f5eb1 100644
--- a/cmd/bind.c
+++ b/cmd/bind.c
@@ -10,8 +10,8 @@
 #include <dm/root.h>
 #include <dm/uclass-internal.h>

-static int bind_by_class_index(const char *uclass, int index,
-			       const char *drv_name)
+static int bind_by_class_seq(const char *uclass, int seq,
+			     const char *drv_name)
 {
 	static enum uclass_id uclass_id;
 	struct udevice *dev;
@@ -31,9 +31,9 @@ static int bind_by_class_index(const char *uclass, int index,
 		return -EINVAL;
 	}

-	ret = uclass_find_device(uclass_id, index, &parent);
+	ret = uclass_find_device_by_seq(uclass_id, seq, &parent);
 	if (!parent || ret) {
-		printf("Cannot find device %d of class %s\n", index, uclass);
+		printf("Cannot find device %d of class %s\n", seq, uclass);
 		return ret;
 	}

@@ -47,7 +47,7 @@ static int bind_by_class_index(const char *uclass, int index,
 	return 0;
 }

-static int find_dev(const char *uclass, int index, struct udevice **devp)
+static int find_dev(const char *uclass, int seq, struct udevice **devp)
 {
 	static enum uclass_id uclass_id;
 	int rc;
@@ -58,21 +58,21 @@ static int find_dev(const char *uclass, int index, struct udevice **devp)
 		return -EINVAL;
 	}

-	rc = uclass_find_device(uclass_id, index, devp);
+	rc = uclass_find_device_by_seq(uclass_id, seq, devp);
 	if (!*devp || rc) {
-		printf("Cannot find device %d of class %s\n", index, uclass);
+		printf("Cannot find device %d of class %s\n", seq, uclass);
 		return rc;
 	}

 	return 0;
 }

-static int unbind_by_class_index(const char *uclass, int index)
+static int unbind_by_class_seq(const char *uclass, int seq)
 {
 	int ret;
 	struct udevice *dev;

-	ret = find_dev(uclass, index, &dev);
+	ret = find_dev(uclass, seq, &dev);
 	if (ret)
 		return ret;

@@ -91,8 +91,8 @@ static int unbind_by_class_index(const char *uclass, int index)
 	return 0;
 }

-static int unbind_child_by_class_index(const char *uclass, int index,
-				       const char *drv_name)
+static int unbind_child_by_class_seq(const char *uclass, int seq,
+				     const char *drv_name)
 {
 	struct udevice *parent;
 	int ret;
@@ -104,7 +104,7 @@ static int unbind_child_by_class_index(const char *uclass, int index,
 		return -ENOENT;
 	}

-	ret = find_dev(uclass, index, &parent);
+	ret = find_dev(uclass, seq, &parent);
 	if (ret)
 		return ret;

@@ -217,19 +217,19 @@ static int do_bind_unbind(struct cmd_tbl *cmdtp, int flag, int argc,
 			return CMD_RET_USAGE;
 		ret = unbind_by_node_path(argv[1]);
 	} else if (!by_node && bind) {
-		int index = (argc > 2) ? dectoul(argv[2], NULL) : 0;
+		int seq = (argc > 2) ? dectoul(argv[2], NULL) : 0;

 		if (argc != 4)
 			return CMD_RET_USAGE;
-		ret = bind_by_class_index(argv[1], index, argv[3]);
+		ret = bind_by_class_seq(argv[1], seq, argv[3]);
 	} else if (!by_node && !bind) {
-		int index = (argc > 2) ? dectoul(argv[2], NULL) : 0;
+		int seq = (argc > 2) ? dectoul(argv[2], NULL) : 0;

 		if (argc == 3)
-			ret = unbind_by_class_index(argv[1], index);
+			ret = unbind_by_class_seq(argv[1], seq);
 		else if (argc == 4)
-			ret = unbind_child_by_class_index(argv[1], index,
-							  argv[3]);
+			ret = unbind_child_by_class_seq(argv[1], seq,
+							argv[3]);
 		else
 			return CMD_RET_USAGE;
 	}
@@ -244,17 +244,17 @@ U_BOOT_CMD(
 	bind,	4,	0,	do_bind_unbind,
 	"Bind a device to a driver",
 	"<node path> <driver>\n"
-	"bind <class> <index> <driver>\n"
+	"bind <class> <seq> <driver>\n"
 	"Use 'dm tree' to list all devices registered in the driver model,\n"
-	"their path, class, index and current driver.\n"
+	"their path, class, sequence and current driver.\n"
 );

 U_BOOT_CMD(
 	unbind,	4,	0,	do_bind_unbind,
 	"Unbind a device from a driver",
 	"<node path>\n"
-	"unbind <class> <index>\n"
-	"unbind <class> <index> <driver>\n"
+	"unbind <class> <seq>\n"
+	"unbind <class> <seq> <driver>\n"
 	"Use 'dm tree' to list all devices registered in the driver model,\n"
-	"their path, class, index and current driver.\n"
+	"their path, class, sequence and current driver.\n"
 );
diff --git a/doc/usage/cmd/bind.rst b/doc/usage/cmd/bind.rst
index 2345778366..67a0405bab 100644
--- a/doc/usage/cmd/bind.rst
+++ b/doc/usage/cmd/bind.rst
@@ -12,7 +12,7 @@ Synopsis
 ::

     bind <node path> <driver>
-    bind <class> <index> <driver>
+    bind <class> <seq> <driver>

 Description
 -----------
@@ -30,8 +30,8 @@ node path
 class
     device class name

-index
-    index of the parent device in the device class
+seq
+    sequence number of the parent device in the device class

 driver
     device driver name
@@ -46,7 +46,7 @@ using the two alternative bind syntaxes.
 .. code-block::

     => dm tree
-     Class     Index  Probed  Driver                Name
+     Class     Seq    Probed  Driver                Name
     -----------------------------------------------------------
      root          0  [ + ]   root_driver           root_driver
     ...
@@ -75,13 +75,13 @@ using the two alternative bind syntaxes.
     => date
     Cannot find RTC: err=-19
     => dm tree
-     Class     Index  Probed  Driver                Name
+     Class     Seq    Probed  Driver                Name
     -----------------------------------------------------------
      root          0  [ + ]   root_driver           root_driver
     ...
     => bind /pl031@9010000 rtc-pl031
     => dm tree
-     Class     Index  Probed  Driver                Name
+     Class     Seq    Probed  Driver                Name
     -----------------------------------------------------------
      root          0  [ + ]   root_driver           root_driver
     ...
diff --git a/doc/usage/cmd/unbind.rst b/doc/usage/cmd/unbind.rst
index 0309e90f6e..1ae9c1b172 100644
--- a/doc/usage/cmd/unbind.rst
+++ b/doc/usage/cmd/unbind.rst
@@ -12,8 +12,8 @@ Synopsis
 ::

     unbind <node path>
-    unbind <class> <index>
-    unbind <class> <index> <driver>
+    unbind <class> <seq>
+    unbind <class> <seq> <driver>

 Description
 -----------
@@ -27,8 +27,8 @@ node path
 class
     device class name

-index
-    index of the device in the device class
+seq
+    sequence number of the device in the device class

 driver
     device driver name
@@ -43,7 +43,7 @@ using the three alternative unbind syntaxes.
 .. code-block::

     => dm tree
-     Class     Index  Probed  Driver                Name
+     Class     Seq    Probed  Driver                Name
     -----------------------------------------------------------
      root          0  [ + ]   root_driver           root_driver
     ...
@@ -70,7 +70,7 @@ using the three alternative unbind syntaxes.
     }
     => unbind /pl031@9010000
     => dm tree
-     Class     Index  Probed  Driver                Name
+     Class     Seq    Probed  Driver                Name
     -----------------------------------------------------------
      root          0  [ + ]   root_driver           root_driver
     ...
@@ -78,7 +78,7 @@ using the three alternative unbind syntaxes.
     Cannot find a device with path /pl031@9010000
     => bind /pl031@9010000 rtc-pl031
     => dm tree
-     Class     Index  Probed  Driver                Name
+     Class     Seq    Probed  Driver                Name
     -----------------------------------------------------------
      root          0  [ + ]   root_driver           root_driver
     ...
--
2.45.2

