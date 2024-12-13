Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71398E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 12:52:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDDD38012C;
	Fri, 13 Dec 2024 13:52:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dPCC+yWs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23A5B80141; Fri, 13 Dec 2024 09:52:36 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABE088012C
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 09:52:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xueweiwujxw@gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-216426b0865so13543325ad.0
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 00:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734079952; x=1734684752; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=91xiss0h7pdPdvvmLAlqMoejyL6aW2FUS2S3PBn7rpc=;
 b=dPCC+yWswXFFaG5NP1fpjXM+bjB4Qz//Y3eIEHcEKiCsANkmVhQ4PSaLC9VIc9bD4X
 NBDX2Rj9Fy0qKZ+U2njwqFz04S1xKn0XXHY4VY+XJ9/VS1QPrR5tG9xCKZAb2mo0BBOP
 JVBrj3E9nzOlXUeWPh0xieUsY3YSE3rtmadootFSI1X2zZuFjGqegQ69c6WFNUleuBkE
 PUDuuGANJqb8Nzp9hndpEGp4dtMwJLToXkAf/mAatjNYERR+2TYRpYu3mycikWxXxOCp
 qK7naIF3d+AE7H3/CfnoYXFobZMah4/wjFvtQCuEawVevH2wI3Kq305U/IQgEvkYrA8I
 PYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734079952; x=1734684752;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=91xiss0h7pdPdvvmLAlqMoejyL6aW2FUS2S3PBn7rpc=;
 b=qgJuqbkFWXSreiRaly7++rzAwLngnoXTf0SdX7XHiUAJCg4af1grWvn2KYaYPkFQ1U
 NiJPboKK8AQdQKySXMURuA+ucBtT6lZisBZGhKuBXgapFTL+Ltjf/t+wLF4ckLuacTeu
 gUHyMYgrpZHd6VGlsrjiczNhemODq18fkTF03aZliAlvNzg7XPT5q3uYReNYewmVn8jn
 MdF6j5vKiDJEWtr+gYmb9Ee8rH4Vt4T4H8j7CeNSZOxYs7Lo3yKfd78jqsNfseBilVds
 UiuttGGUn0lhfAfOaobNA9e4nVfFt4SNO6qnQ+f3ZmNVmBiBf3MqQ+rDCK7B8JJOuwOm
 jO5w==
X-Gm-Message-State: AOJu0YycIgl40YXo/ExmCPhcqGCE+XFWhHfapcbXlytx59imxuatJYAE
 J3XLoYAWliBQVdOPj1Zn0cffWzW34oGyblmdKl4sk1sUIk0uSfveWo9F12WEd6ZZVQ==
X-Gm-Gg: ASbGncsvp+FaidJML4U8tAZ1q32H5VWvbbV9JAvUhpRvmrHxhx3odKjf1uKFfOIusS6
 1sOjg7peYGjiGvZc2B25GDyRXve0zHQkGAoahDwu2q/XSenDQz7/i+3cHgm9dhgjg23pTBVlN2K
 Gi91mWiTCaiN6CEPYE0EXMXz2ElxYmEFgbdK9yQV2eUF4vhfsIceePUcsXBW15ox2gwW5nK2/sh
 oau0iP9Kxl3zKFDKMM6ZMPhxq6XiwxnfxGT1LaablvtCWAALqcqhk1Px3eWFx1y5JQk0mwl/xxH
 pp80
X-Google-Smtp-Source: AGHT+IH3bB5BbnfEW+Y4S1GAgcSB71xrmX8E85bnKT+WCWgdmapC7QJzhJYDDro4445+t91a4OskgA==
X-Received: by 2002:a17:902:ce85:b0:216:7cbf:951f with SMTP id
 d9443c01a7336-218929c72b5mr24064405ad.21.1734079951618; 
 Fri, 13 Dec 2024 00:52:31 -0800 (PST)
Received: from wlanxww-work.tsinghua.edu.cn
 ([2402:f000:4:1005:809:ffff:fffd:dc1f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21899c33ad2sm3182025ad.217.2024.12.13.00.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 00:52:31 -0800 (PST)
From: xueweiwujxw <xueweiwujxw@gmail.com>
To: u-boot@lists.denx.de
Cc: xueweiwujxw <xueweiwujxw@gmail.com>
Subject: [PATCH V1] board: xilinx: zynq: Add a new cmd to run postconfig
Date: Fri, 13 Dec 2024 16:52:25 +0800
Message-ID: <20241213085225.2800775-1-xueweiwujxw@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Dec 2024 13:52:46 +0100
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

This patch adds a new command named "post_config" to execute the
"ps7_post_config" function.

Signed-off-by: xueweiwujxw <xueweiwujxw@gmail.com>
---
 board/xilinx/zynq/Kconfig              | 17 +++++++++++++++++
 board/xilinx/zynq/Makefile             |  2 +-
 board/xilinx/zynq/cmds.c               | 20 ++++++++++++++++++++
 test/py/tests/test_zynq_post_config.py | 16 ++++++++++++++++
 4 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100644 test/py/tests/test_zynq_post_config.py

diff --git a/board/xilinx/zynq/Kconfig b/board/xilinx/zynq/Kconfig
index d6f40631cc..a1624c71c0 100644
--- a/board/xilinx/zynq/Kconfig
+++ b/board/xilinx/zynq/Kconfig
@@ -30,4 +30,21 @@ config CMD_ZYNQ_RSA
 	  and authentication feature enabled while generating
 	  BOOT.BIN using Xilinx bootgen tool.
 
+config CMD_POST_CONFIG
+	bool "Enable post_config command"
+	default y
+	help
+	  This option enables the 'post_config' command in U-Boot.
+	  The 'post_config' command is used to execute the PS7 post-configuration
+	  process after loading an FPGA bitstream file on Xilinx Zynq devices.
+	  This command ensures that the programmable logic (PL) and
+	  processing system (PS) are properly synchronized after
+	  FPGA configuration. It is specifically useful in designs where
+	  additional initialization steps are required for the PS to
+	  correctly interact with the configured PL.
+	  This option is only applicable to Xilinx Zynq platforms and
+	  has no effect on other architectures. If you are not using the
+	  PS7 subsystem or do not require post-configuration steps,
+	  this option can be disabled to reduce the size of the U-Boot binary.
+
 endif
diff --git a/board/xilinx/zynq/Makefile b/board/xilinx/zynq/Makefile
index f40fe382f5..366a4d931a 100644
--- a/board/xilinx/zynq/Makefile
+++ b/board/xilinx/zynq/Makefile
@@ -32,7 +32,7 @@ endif
 endif
 
 ifndef CONFIG_XPL_BUILD
-obj-$(CONFIG_CMD_ZYNQ) += cmds.o
+obj-$(CONFIG_CMD_ZYNQ) += $(init-objs) cmds.o
 obj-$(CONFIG_CMD_ZYNQ_RSA) += bootimg.o
 endif
 
diff --git a/board/xilinx/zynq/cmds.c b/board/xilinx/zynq/cmds.c
index 05ecb75406..60278fcdf6 100644
--- a/board/xilinx/zynq/cmds.c
+++ b/board/xilinx/zynq/cmds.c
@@ -18,6 +18,7 @@
 #include <zynqpl.h>
 #include <fpga.h>
 #include <zynq_bootimg.h>
+#include "ps7_init_gpl.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -548,3 +549,22 @@ U_BOOT_LONGHELP(zynq,
 U_BOOT_CMD(zynq,	6,	0,	do_zynq,
 	   "Zynq specific commands", zynq_help_text
 );
+
+static int do_ps7_fpga_post_config(struct cmd_tbl *cmdtp, int flag, int argc,
+				   char *const argv[])
+{
+	int ret = PS7_INIT_SUCCESS;
+
+	if (IS_ENABLED(CONFIG_CMD_POST_CONFIG))
+		ret = ps7_post_config();
+
+	if (ret != PS7_INIT_SUCCESS)
+		puts("ERROR:run board ps7 post config failed.\n");
+	else
+		puts("INFO: run board ps7 post config succeed.\n");
+	return ret;
+}
+
+U_BOOT_CMD(post_config,	1,	0,	do_ps7_fpga_post_config,
+	   "run ps7 post config after fpga load bin file",	""
+);
diff --git a/test/py/tests/test_zynq_post_config.py b/test/py/tests/test_zynq_post_config.py
new file mode 100644
index 0000000000..4493f8f190
--- /dev/null
+++ b/test/py/tests/test_zynq_post_config.py
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Test for the "post_config" command
+#
+# xueweiwujxw
+
+import pytest
+
+@pytest.mark.buildconfigspec('cmd_post_config')
+def test_post_config(u_boot_console):
+    """Test the 'post_config' command on Zynq platform"""
+
+    output = u_boot_console.run_command("post_config")
+
+    assert "INFO: run board ps7 post config succeed." in output
+
-- 
2.47.1

