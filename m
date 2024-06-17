Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850F5C27C6E
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 08:56:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92CE587DC7;
	Mon, 17 Jun 2024 10:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RtD8tbOU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA91387E52; Mon, 17 Jun 2024 10:56:44 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A17E086784
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 10:56:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a63359aaacaso629502866b.1
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 01:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718614602; x=1719219402; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+TuMLTzlh/GvtdiyeSsducUjy4fM1iL405jRIFBU1Ms=;
 b=RtD8tbOU3MsrugxdJFUavPHUvFh8JuWBgMchSgglxSWZ7FDH5YZLT4dMYxm2fdGHYu
 9imsoNV2aQ3v5oFmJgGwrxyaiW+NNYinM9b8XctmB4aJgg+4Om42KiJSNpZMGo7FdwHz
 BtDCQLyHtI2gqa9jFIUTCITRXNTB2p250h0wqd530QyCvvTine6cxV8KvcSkaRRksMk2
 cZJRGNt/Juq1B2YGArdsT0I2HzY1eOmIhgzYd5P4mTSf9U+fPSKuNC0fqubwtLHCC7JH
 tper0Z+P2DtWBhiI91ajPIbtTKHouExTVEAynDAMa2kimDKpQitS3TYgM3lis8yHf0GP
 Jrbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718614602; x=1719219402;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+TuMLTzlh/GvtdiyeSsducUjy4fM1iL405jRIFBU1Ms=;
 b=B1hQSa68fGJ2hMmBsx/XChFKzSLd4wkglyK8g0y5yoz3NPQhNI6+I1hB/nxxrG8VYc
 VSgD/L+g+rer1vg72oqQwWIRyvp67sqNd040Lg/K/UtANPbe85vS4kXcH/nLbHk/tUCM
 FCoJjEo38r9ushzHQqWp/FbOAG3fpf8WcHdyd6EmYmJHv1YjwXwbKOprmsiJ723IJBvK
 JNZDPP8eSjbfX97TOUNk7ydmvPYZQNZiAQKvMsxVbsRExVOeq+JHJVefMKuZIIJJ0+GD
 i4S+b97VdU7TijbTX25A38VftHuaVEGqLIbaj1rD+7lpbOh8ovrvzYcW5OGik/yyUefV
 ODug==
X-Gm-Message-State: AOJu0YzIq/VpDO4tHFG9SruP3L+Yfx8XKbqRcs5D+z8x1/avRZ3yHex1
 EKlZr3mJk45/LW2zG2ZQqGsI0qyu3VvZDMUDf2ngY/8aJWOYW/pzacEtujnp+y0=
X-Google-Smtp-Source: AGHT+IHaUMSH0immUlXT4YKybwAevUio20Kw9RQgWBZPU/O0ZGzlS6aC0NQXosdal1Uxy1sQ5ikRwg==
X-Received: by 2002:a17:906:2503:b0:a6e:feb5:148e with SMTP id
 a640c23a62f3a-a6f60d29902mr631281466b.27.1718614601918; 
 Mon, 17 Jun 2024 01:56:41 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech ([2a02:8109:aa0d:be00::52af])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56f9978esm489125066b.200.2024.06.17.01.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 01:56:41 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	u-boot-qcom@groups.io
Subject: [PATCH] mach-snapdragon: move default environment to a file
Date: Mon, 17 Jun 2024 10:56:14 +0200
Message-ID: <20240617085629.1744017-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.45.0
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

Make use of CONFIG_DEFAULT_ENV_FILE and move the default qcom
environment to a file under board/qualcomm.

This is much cleaner and means we don't need to recompile on changing
the environment.

Additionally, extend the environment to include a boot menu and
auto-boot using EFI instead of bootm. Since we now support MMC and USB
on most platforms, these are much more useful defaults.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 board/qualcomm/default.env | 12 ++++++++++++
 configs/qcom_defconfig     |  2 ++
 include/configs/qcom.h     |  7 -------
 3 files changed, 14 insertions(+), 7 deletions(-)
 create mode 100644 board/qualcomm/default.env

diff --git a/board/qualcomm/default.env b/board/qualcomm/default.env
new file mode 100644
index 000000000000..243aede77be7
--- /dev/null
+++ b/board/qualcomm/default.env
@@ -0,0 +1,12 @@
+stdin=serial,button-kbd
+stdout=serial,vidconsole
+stderr=serial,vidconsole
+bootfile=/extlinux/extlinux.conf
+preboot=scsi scan; usb start
+fastboot=fastboot -l $fastboot_addr_r usb 0
+do_boot=bootefi bootmgr
+bootmenu_0=Boot first available device=run do_boot
+bootmenu_1=Enable fastboot mode=run fastboot
+bootmenu_2=Reset device=reset
+menucmd=bootmenu
+bootcmd=run do_boot
diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 80ad3b32e139..a9e3797bb39a 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -35,8 +35,10 @@ CONFIG_CMD_BMP=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_BOARD_SETUP=y
 CONFIG_BUTTON_QCOM_PMIC=y
+CONFIG_USE_DEFAULT_ENV_FILE=y
+CONFIG_DEFAULT_ENV_FILE="board/qualcomm/default.env"
 CONFIG_CLK=y
 CONFIG_CLK_QCOM_QCM2290=y
 CONFIG_CLK_QCOM_QCS404=y
 CONFIG_CLK_QCOM_SDM845=y
diff --git a/include/configs/qcom.h b/include/configs/qcom.h
index e50b3bce5cdd..5b5ebbd844df 100644
--- a/include/configs/qcom.h
+++ b/include/configs/qcom.h
@@ -10,12 +10,5 @@
 #define __CONFIGS_SNAPDRAGON_H
 
 #define CFG_SYS_BAUDRATE_TABLE	{ 115200, 230400, 460800, 921600 }
 
-/* Load addressed are calculated during board_late_init(). See arm/mach-snapdragon/board.c */
-#define CFG_EXTRA_ENV_SETTINGS \
-	"stdin=serial,button-kbd\0"	\
-	"stdout=serial,vidconsole\0"	\
-	"stderr=serial,vidconsole\0" \
-	"bootcmd=bootm $prevbl_initrd_start_addr\0"
-
 #endif
-- 
2.45.0

