Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07879E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 065FE87236;
	Mon,  2 Oct 2023 03:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ThztSO4L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CBAD87135; Mon,  2 Oct 2023 03:18:44 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD452872AD
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:18:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3513fa06bafso39328195ab.3
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209394; x=1696814194; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n8BV9m61QvUY5NcRfZ/+1HTYuSII0pJHLzchhd2Ig1g=;
 b=ThztSO4LMDetAbzV2VNj7cTdU0t7EkTOPI3VdQBx4XGEXmT5nbno0xmYqARL6kPcui
 cANK3cHd+S4XXrwbRH7Ry4cId+Tu/oUAgZIIXOiQOAJLlEei/3E9Rp7e0ckd6v9ZnuoY
 TpKJF3rVnpdTR0YEyhDm06U3RznEb4dqallZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209394; x=1696814194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n8BV9m61QvUY5NcRfZ/+1HTYuSII0pJHLzchhd2Ig1g=;
 b=ib/zRHTLSSkGCZHFrJLyXSCUCltJWGVmp6YVlXy9FYhPlnaeSVC73sMQKsSA6YyqaR
 tRxHZVHq5eueboR1JqsXCrkChv9zv38vAJ5pQiPwsLvlFrPA6ir1HHLZcirg03ZNcG3D
 MxSxsFwtJn5zJd2Xk2madk5nVXjlB1Tw+KBu9zstvt80m1twMLsDfg9doR4iKlkwHXNq
 K3sHhSBNgCKZPqkONANTyeDVuGXYUk0wuci2/BeJurwiF0NT7p0d9oj1PiFL9kRsLtfy
 sqn3ItYMKF4rXj0YzFmHusxaMyzTwusXa/x/DHp+jP72mLM19GrJJviIfjAxVLodDOsE
 XnWA==
X-Gm-Message-State: AOJu0YzkeYG715kg4yByKnOrRTxCuJRiyj9kXMOOAXbFXJGsr3fgP1Db
 Pqhv/biXVhOss4dtzT8gIUJjEJStPbacS3iVs2s=
X-Google-Smtp-Source: AGHT+IHMBnwpI5DdiDrq0heFG67xHJ6SapFqGUw2OruM8IiMQP07jHoeWrArmgCrTuUl8WPblWuNLg==
X-Received: by 2002:a05:6e02:ee8:b0:34f:1e9c:45e0 with SMTP id
 j8-20020a056e020ee800b0034f1e9c45e0mr9612228ilk.3.1696209394147; 
 Sun, 01 Oct 2023 18:16:34 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 31/34] x86: coreboot: Enable support for the configuration
 editor
Date: Sun,  1 Oct 2023 19:15:41 -0600
Message-ID: <20231002011553.463514-32-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
References: <20231002011553.463514-1-sjg@chromium.org>
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

Enable cedit support along with required options and a simple style.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/dts/coreboot.dts    | 7 +++++++
 configs/coreboot64_defconfig | 2 ++
 configs/coreboot_defconfig   | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/arch/x86/dts/coreboot.dts b/arch/x86/dts/coreboot.dts
index 83beb82f37c7..78ca00d64db4 100644
--- a/arch/x86/dts/coreboot.dts
+++ b/arch/x86/dts/coreboot.dts
@@ -54,5 +54,12 @@
 			menu-inset = <3>;
 			menuitem-gap-y = <1>;
 		};
+
+		cedit-theme {
+			font-size = <30>;
+			menu-inset = <3>;
+			menuitem-gap-y = <1>;
+			menu-title-margin-x = <30>;
+		};
 	};
 };
diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index 42b46ba0d9b9..23b88b55663f 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -18,6 +18,7 @@ CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
 CONFIG_BOOTCOMMAND="bootflow scan -l; if bootflow menu; then cls; bootflow boot; fi"
+CONFIG_CEDIT=y
 CONFIG_PRE_CONSOLE_BUFFER=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_LOG=y
@@ -47,6 +48,7 @@ CONFIG_TFTP_TSIZE=y
 CONFIG_USE_ROOTPATH=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
+CONFIG_OFNODE_MULTI_TREE=y
 # CONFIG_ACPIGEN is not set
 CONFIG_SYS_IDE_MAXDEVICE=4
 CONFIG_SYS_ATA_DATA_OFFSET=0
diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index 5433a5ae0c2d..d4e44e00dcab 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -17,6 +17,7 @@ CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
 CONFIG_BOOTCOMMAND="bootflow scan -l; if bootflow menu; then cls; bootflow boot; fi"
+CONFIG_CEDIT=y
 CONFIG_CONSOLE_RECORD=y
 CONFIG_CONSOLE_RECORD_OUT_SIZE=0x1000
 CONFIG_PRE_CONSOLE_BUFFER=y
@@ -44,6 +45,7 @@ CONFIG_TFTP_TSIZE=y
 CONFIG_USE_ROOTPATH=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
+CONFIG_OFNODE_MULTI_TREE=y
 # CONFIG_ACPIGEN is not set
 CONFIG_SYS_IDE_MAXDEVICE=4
 CONFIG_SYS_ATA_DATA_OFFSET=0
-- 
2.42.0.582.g8ccd20d70d-goog

