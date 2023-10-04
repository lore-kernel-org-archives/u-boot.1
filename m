Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60F7E8FDBF
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 00:31:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28C8186E28;
	Wed,  4 Oct 2023 02:31:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XxVM+Up0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D51786E02; Wed,  4 Oct 2023 02:31:01 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDD4C86EA8
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 02:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-277317a0528so362416a91.0
 for <u-boot@lists.denx.de>; Tue, 03 Oct 2023 17:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696379457; x=1696984257; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ctawXCU7Akvs+j0tmXMWMgYbO5kkxRDctuZQYOzETFw=;
 b=XxVM+Up0f95NMh0QClhF+rYVS55r1zCQTxElOIIR3RyasS6tl8XKNDoLZQ2a0ZN1JX
 /xEC4Tmq59pAoVT8U4/IEo7/1FOabrJ+InnE7xTfzQEwWRfdboQd2wY6x3JP+RMWFoTL
 e8rUAv3/G17ZoP6mrpJyoRGbVk24Wzhqd2UcCRQj+TtwJtWv1qXLPZv/OOLAe0Eg0bNp
 FCvXcIjDGH+qWepKQ1kR782BAxXE4XKmc5NHct2mTyUikP2NvDTvSeeah9oxHwq+XeSg
 YNsD3JmMC5PxReEZmzDQ7rZROBdG39DHgCsYxTsJbeP6O/DmOEkFY+XbASIbvb3zNVxi
 qeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696379457; x=1696984257;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ctawXCU7Akvs+j0tmXMWMgYbO5kkxRDctuZQYOzETFw=;
 b=H7UJAmIAX2umkjYEO5K64PDX7UAuwb3aC9/NkyIbzqJ18/0YkoCPETdIlpiP83l6FC
 BalztvBeypLoSIXeatHTgsT1w8d7wAexjm/U41oSEgcHJKLTII4vhcbK4DhTzqS+2Ksb
 YOUqgt7gvrKO9sqP1oAXcHY8S93AiZq31YmgnO7joL7xPh6dHvYTWpZ9jtOBshvBW88W
 NWjMqLiknlB0y6OQJWlXcbBEwGLqnL/j1TmFP/7qN4EHPxEYFDjo8CJKpiMVX+ORzEYq
 yZWk8I1J9Hc1Ulj4soXjcuSU2IKh/EfOfrulIEbLsYAbsNxqMux/+SedZOp7Qzv6dIQs
 LtqQ==
X-Gm-Message-State: AOJu0YxR6R2jkTgekO9a0yaOn+cbRlHhdFIe+auI3XZwgrmsXHxmN99W
 oX2ttW+SGLGkpzJ1Cwx2fcc=
X-Google-Smtp-Source: AGHT+IEOZ8M8mk599IBUe7o94D7zXVsEFRixpnHm2oRH4Klg2ch7WFjO/lzA5ZbLYQPBZ6CSyP77ww==
X-Received: by 2002:a17:90a:13cb:b0:26d:1f75:7fa3 with SMTP id
 s11-20020a17090a13cb00b0026d1f757fa3mr755589pjf.4.1696379457102; 
 Tue, 03 Oct 2023 17:30:57 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:483f:6866:95b6:cf83])
 by smtp.gmail.com with ESMTPSA id
 w4-20020a170902e88400b001c736746d33sm2200614plg.217.2023.10.03.17.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 17:30:56 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH] pico-pi-imx7d: Unselect CONFIG_CONSOLE_MUX
Date: Tue,  3 Oct 2023 21:30:48 -0300
Message-Id: <20231004003048.2189743-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

Unselect CONFIG_CONSOLE_MUX to fix the following
error for the input, output and error interfaces:

U-Boot 2023.10 (Oct 03 2023 - 21:23:18 -0300)

CPU:   Freescale i.MX7D rev1.2 1000 MHz (running at 792 MHz)
CPU:   Commercial temperature grade (0C to 95C) at 42C
Reset cause: POR
Model: TechNexion PICO-IMX7D Board and PI baseboard
Board: i.MX7D PICOSOM
DRAM:  512 MiB
Core:  75 devices, 16 uclasses, devicetree: separate
PMIC: PFUZE3000 DEV_ID=0x30 REV_ID=0x11
MMC:   FSL_SDHC: 3, FSL_SDHC: 1, FSL_SDHC: 0
Loading Environment from MMC... OK
In:    No input devices available!
Out:   No output devices available!
Err:   No error devices available!
Net:   eth0: ethernet@30be0000
Hit any key to stop autoboot:  0 

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 configs/pico-pi-imx7d_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/pico-pi-imx7d_defconfig b/configs/pico-pi-imx7d_defconfig
index 3e26aae40053..5b479818d88e 100644
--- a/configs/pico-pi-imx7d_defconfig
+++ b/configs/pico-pi-imx7d_defconfig
@@ -22,6 +22,7 @@ CONFIG_BOARD_SIZE_LIMIT=715776
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTCOMMAND="run findfdt; run finduuid; run distro_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx7d-pico-pi.dtb"
+# CONFIG_CONSOLE_MUX is not set
 CONFIG_SPL_MAX_SIZE=0xe000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
-- 
2.34.1

