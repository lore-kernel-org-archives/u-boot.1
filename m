Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FD0E9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 10:04:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4332583D5D;
	Thu, 19 Feb 2026 11:03:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I1C+48nv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B184C83D17; Thu, 19 Feb 2026 11:03:46 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F404783D0B
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 11:03:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4834826e555so6734905e9.2
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 02:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771495423; x=1772100223;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QS/e2S74d80oG0lqyLz4x/yCXdFxhXulBbENP6tPm1Y=;
 b=I1C+48nvG66vUJx14AQlzbmxDWYMiHjCD6dGDdkGgGv5589w6UA8gk92XJb4TsyLoR
 189aH+MuaOa+VOhrA17BHft9RLW9nCuMTCtDo3OyscYo4m4Hp8nngjF21f9bAizH+kEK
 JOowk5ScWo0VLU+VyPYyRe7BgeT1fRXjoXDGWZ6DPDs6H+05ocBXZ4MwsUt2sMD4MxXE
 hvuKuCWUWaFKoo7PBfBlOYTpr83gsqtZVDdzlQqMfII2dLbajBA0WvNQ4AjHN0hLKUr8
 Bg3wDuiyT6CcUfopbk29kD39u5rJumlgzabL7nBqRZ9XCijC7LgzI2TTgBJi7C/dJDfY
 tPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771495423; x=1772100223;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QS/e2S74d80oG0lqyLz4x/yCXdFxhXulBbENP6tPm1Y=;
 b=NS70u56xIedqlYYh4UA82kiS9sy6kX9TUSbo0iMYCIs6oKf/BgJi3evY2gj+DAMRMZ
 kDQW8jpRKVMZVZdUNZUDw/QyictWDt3sWIHE0iI+40kpsqp3aZXczj6OJ4w6VrS9FWav
 Jd3ybUQ+vnViwOlkn3ZgIwl7Kaua+MWnA1lglBUCmM+GR5kAIylPROcIkEtfMF824yX6
 dKZOChJjBO98PM3aettpGLXvJYVxpDEsszeq0k+l86+PZ0hj9VhaY6TOxezTl1Ezi3rw
 bbRHkTm0CJoygUIUeQqokRTFfD7Dj78zNcRpdSXhgRIPQw/HBpP8py9YIca2qSuPRLsU
 4APw==
X-Gm-Message-State: AOJu0YyHILHrlwvJJHM6lMim1a1/0pIZXtqTwdlTpePY1th2AjmEpPnD
 AxZyn6ywl/rH1c5POYifA4efuy05z6tXVrkpoEbvaVaNpfd/xySOc3bK9V+wN0K1lPc=
X-Gm-Gg: AZuq6aKnxP/jccC0NfCLoqHSfCtQTcHeOhsUllEnWn0SFVb9Ndl+i+S1jVEnijbihGa
 KdfrZP7QHJWNIgmgTbs0oPHt3A4j5GZ96EyhUuPwtWqNpX50QA0N9vNLhMt4yFJQd8IWywfahcR
 8s6LzkmPjhv5VyACSHHOER7g6ZqBpYGoTowa55UhYQVhAqJVk7u9N9R07ypKT8S/JKBOBFqu9cj
 dBLsGIedGUvnjPTzvtOhjp4m9BUhzkAaWTEh9XnNU1BVEbjjpKkr86jcEw/VmV7U9FBjHfs/r0W
 PkIbbM1cHSLagoMVwqv0Km18XRAIXkOT7AO2/SOA+yGmi6iBqDHSlhc3i+THopPSa4gcc+lGrpI
 lp7h7+6c1iOEYIxwG2IMZS2RsGPzmYHZX+OFFnxkz/jzTUc0M+6JgRbFXCLncISxFZXyGe+BLT7
 vmv8ZN3lkp6NZRgAUYECrbEU1Vt7MkOaFgRbg2gc/Q0vQU6F1D99Tb+b3YWYyrqClV5AudP0Ic/
 vKCTqPmedR1iVf8n8QGoA==
X-Received: by 2002:a05:6000:4282:b0:437:6d8c:c08b with SMTP id
 ffacd0b85a97d-4379dba32bcmr30804855f8f.49.1771495423328; 
 Thu, 19 Feb 2026 02:03:43 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a74918sm47885240f8f.17.2026.02.19.02.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:03:43 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 19 Feb 2026 11:03:38 +0100
Subject: [PATCH v2 2/2] board: mediatek: add MT8395 EVK board support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-add-mt8395-evk-v2-2-18b190d91cb6@baylibre.com>
References: <20260219-add-mt8395-evk-v2-0-18b190d91cb6@baylibre.com>
In-Reply-To: <20260219-add-mt8395-evk-v2-0-18b190d91cb6@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.3
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

This adds support for the MT8395_EVK board with the following
features enabled/tested: Boot, UART, Watchdog and MMC.

MT8395_EVK is based on MT8195.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 board/mediatek/MAINTAINERS   |  5 +++++
 configs/mt8395_evk_defconfig | 26 ++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
index 5954607439a..446a9e8e53c 100644
--- a/board/mediatek/MAINTAINERS
+++ b/board/mediatek/MAINTAINERS
@@ -13,3 +13,8 @@ M:	Julien Masson <jmasson@baylibre.com>
 M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
 S:	Maintained
 F:	configs/mt8390_evk_defconfig
+
+MT8395 EVK
+M:	Macpaul Lin <Macpaul.Lin@mediatek.com>
+S:	Maintained
+F:	configs/mt8395_evk_defconfig
diff --git a/configs/mt8395_evk_defconfig b/configs/mt8395_evk_defconfig
new file mode 100644
index 00000000000..2edf3cb3e35
--- /dev/null
+++ b/configs/mt8395_evk_defconfig
@@ -0,0 +1,26 @@
+CONFIG_ARM=y
+CONFIG_COUNTER_FREQUENCY=13000000
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_MEDIATEK=y
+CONFIG_TEXT_BASE=0x4c000000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt8395-genio-1200-evk"
+CONFIG_TARGET_MT8195=y
+CONFIG_SYS_LOAD_ADDR=0x60000000
+CONFIG_IDENT_STRING=" mt8395-evk"
+# CONFIG_BOARD_INIT is not set
+CONFIG_CMD_CLK=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_CLK=y
+CONFIG_MMC_MTK=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_MT8195=y
+CONFIG_BAUDRATE=921600
+CONFIG_DM_SERIAL=y
+CONFIG_MTK_SERIAL=y
+CONFIG_WDT=y
+CONFIG_WDT_MTK=y

-- 
2.52.0

