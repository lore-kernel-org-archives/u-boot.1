Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40540C25B6B
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 23:05:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16F1887AD2;
	Thu, 26 Oct 2023 01:05:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PuX8xpZ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91BEC87ACD; Thu, 26 Oct 2023 01:05:13 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1384D87AD6
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 01:05:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-778925998cbso22745285a.0
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 16:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698275105; x=1698879905; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZzLlIo1iSMh3ZMaHBfKCNmO9k4cHWzIkuH21zmYubNA=;
 b=PuX8xpZ01dUYUvvydRu2MDi5xnaEs4G+IozDa4zR4Moys+pajfbIhJ0R/rBcWev0jk
 4oDw32J8qt/0cnf1rxRG9BLUobxWSGoo3ayHNmJe9JGW1WHbd9wzVdDfQwieMOlJ01qG
 RIUN3v65g8VopKP/saOCOmtzEjlWQqgkEJkHFiGb2sCCQGT+YAjXdN/VHH+yMl4+84qR
 aqXVyOPf0upHcAw16L4zzzR4h9d4XLNiHvDOiwi7R2eVRpGPlUFQ8yYCBxkhCFy1Z51t
 Zw5w1Crj35obO4x9cgLdualtz00eVuEcAzpn/B3xRIyOyXMQngX6eeRVvQDbo1397IXg
 DxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698275105; x=1698879905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZzLlIo1iSMh3ZMaHBfKCNmO9k4cHWzIkuH21zmYubNA=;
 b=Nj592gSVnKPtmQpZL/K95hvTwyLL9/DsXS39BdGIFyuYXBik/07b2z3QutMyIuCZyl
 j0EwmmqTsb3FWc3X7m3RcLl21WQalDacPN4peV/pcVfd0bavMACgxvqBf/TUy4JlwnPW
 OwWH3igtJNgpPB0x+PdM1JXr3Sx/p0/8ip3TAu4Tx50LUpLlBJl0X32tStyKD7bsiSl7
 az2zqFwA6hUqQOLR2Pb7XdRymC4kdbRbCiO7FG+U4ZKgRbkw1zNPsZTy7AdBNuNbxWXg
 wX+g35VIXzNxJTaHV2zGO/AcryWILlvJRXFkgb18N1qDCOMeZeDxcK/gw6Vss8npc0Hx
 q9cA==
X-Gm-Message-State: AOJu0Yy4m4VsiQlBsI4n5gAzF7MDc4FQX1Kn6YVKyOnWBjL68gyEydT4
 /t7muFWgDrdH93zTyiWCCyapaE1cz08=
X-Google-Smtp-Source: AGHT+IGcDHq5xSHmKpARjO5XBeoyK0r+1DZ8GuNzk7NlfkH22f8Mzn/0EheekZk8R6BSA3zbirvl0A==
X-Received: by 2002:a05:620a:a14:b0:76d:bb77:b295 with SMTP id
 i20-20020a05620a0a1400b0076dbb77b295mr16153666qka.78.1698275105371; 
 Wed, 25 Oct 2023 16:05:05 -0700 (PDT)
Received: from aford-System-Version.lan
 ([2601:447:d002:5be:449a:a220:d0aa:3d6a])
 by smtp.gmail.com with ESMTPSA id
 a24-20020a05620a103800b00767da10efb6sm4559567qkk.97.2023.10.25.16.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:05:04 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: sbabic@denx.de, aford@beaconembedded.com, Adam Ford <aford173@gmail.com>
Subject: [PATCH 4/5] configs: imx8mn_beacon: Do not set SYS_CONSOLE_IS_IN_ENV
Date: Wed, 25 Oct 2023 18:04:55 -0500
Message-Id: <20231025230456.7924-4-aford173@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231025230456.7924-1-aford173@gmail.com>
References: <20231025230456.7924-1-aford173@gmail.com>
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

The hardware only supports a specific console port, so  remove the
option to change the console location in the environment.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 configs/imx8mn_beacon_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx8mn_beacon_defconfig b/configs/imx8mn_beacon_defconfig
index 9409d5142c..cfff20f84f 100644
--- a/configs/imx8mn_beacon_defconfig
+++ b/configs/imx8mn_beacon_defconfig
@@ -34,6 +34,7 @@ CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_USE_BOOTCOMMAND=y
 CONFIG_BOOTCOMMAND="mmc dev ${mmcdev}; if mmc rescan; then if run loadbootscript; then run bootscript; else if run loadimage; then run mmcboot; else run netboot; fi; fi; else booti ${loadaddr} - ${fdt_addr}; fi"
 CONFIG_DEFAULT_FDT_FILE="imx8mn-beacon-kit.dtb"
+# CONFIG_SYS_CONSOLE_IS_IN_ENV is not set
 CONFIG_SPL_MAX_SIZE=0x25000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x950000
-- 
2.40.1

