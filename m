Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39017C47422
	for <u-boot@archiver.kernel.org>; Sun, 21 Jan 2024 22:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DFE4876F4;
	Sun, 21 Jan 2024 23:06:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="DCeKswck";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C10318780A; Sun, 21 Jan 2024 23:06:00 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB741876E5
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 23:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40e86a9fc4bso34002305e9.2
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 14:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1705874758; x=1706479558;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WA3UPM6TZwh5B4LYs8oWDINeGjZMIwKpiWHuWMYKnVE=;
 b=DCeKswckiToUnivN9Ye1rQw3rw0Grsw+IojqNVVhtTGYpE+pGTDHUWFOdD4HnWGvt9
 VTyyoVYbuFFLZHF/WhaVL3Iv4irtlE+ED/WBcrZZ3fUaURCXGFDDizoRpZoS3pfe38ww
 1wegmbt/g6y8Y7hbjik/qUBvV2X9xi/ZDEdgXvJovNP6lUwfyeBrPPC7ret15clWXesd
 qMrL9lWB5ZWzqcLMj2cWzelSiFcHlnvDSJqhIVJfKCD0kofCfwtCuRvbSRQTpvbEDFwM
 iS/MxD4P4Wg2JQ6rteIM76NFKpdCKE0be81LlGhl8Aap4VXJeXDieaHqyHRNWk8aUsbw
 6WMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705874758; x=1706479558;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WA3UPM6TZwh5B4LYs8oWDINeGjZMIwKpiWHuWMYKnVE=;
 b=shIxMWNyXtP4bZ28Kv9R4boSta+uTHRxC4v6mblIe0QXD6yRD2NsEIX67CFxy+ugie
 6j66Knij1CqnEj3oVogwP3VV9hPCNKWWsXlyNqyj2yrckhOPiXFeCbvYujMtNYy9lZ/a
 lsLscqbcC54kGobUD8LH4f6GVX1l6lV+qGGJvFZSCpSNeAOTSCvypFEzarwBo9KiYyWS
 ++4CnOTIxu5bOr8acSWP/LM+3A1ejavcDi9ELAEBS6cFX3I1XJ49wPuiuVLpbESp8R9M
 vrLKWfGgAzvFPbENdbvmaevIkC8Kndj/famKrIlIgeCriSuLBb9VTfcNdVzZ3vUFJ3MY
 sZvQ==
X-Gm-Message-State: AOJu0Yzf/qAAZf4RETh7FPo4imVahvUm8pfDH9pzrY8fggjLRg4lwtNT
 n0RT/AvNgL3sjjQva9bX7wquF9fcQ/Zr0jpDCAG6Du4Vs12i7+4w4KtnGMpaA/qWN0bM/PhjaML
 p6pY=
X-Google-Smtp-Source: AGHT+IF6OKBZh73nHEr2wIKu4l6eGdC8C0bSrzhlgRA0wAAqwX284NNPi8a9Yy8IJL0SFTSg+vlHPA==
X-Received: by 2002:a05:600c:3410:b0:40e:5128:ef91 with SMTP id
 y16-20020a05600c341000b0040e5128ef91mr1754080wmp.71.1705874757036; 
 Sun, 21 Jan 2024 14:05:57 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 g4-20020a05600c310400b0040e88d1422esm16736586wmo.31.2024.01.21.14.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jan 2024 14:05:56 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, kever.yang@rock-chips.com, trini@konsulko.com,
 jagan@amarulasolutions.com, jonas@kwiboo.se, pbrobinson@gmail.com,
 Shantur Rathore <i@shantur.com>, Jagan Teki <jagan@edgeble.ai>,
 Johan Jonker <jbx6244@gmail.com>, John Keeping <john@metanate.com>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>,
 Pegorer Massimo <Massimo.Pegorer@vimar.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH v5] arch: arm: mach-rockchip: Kconfig: Enable BOOTSTD_FULL for
 RK3399 and RK3588
Date: Sun, 21 Jan 2024 22:04:47 +0000
Message-Id: <20240121220447.663407-1-i@shantur.com>
X-Mailer: git-send-email 2.40.1
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

Rockchip RK3399 and RK3588 SoCs can support wide range of bootflows.
Without full bootflow commands, it can be difficult to
figure out issues if any, hence enable by default.

Reviewed-by: Simon Glass <sjg@chromium.org>

Signed-off-by: Shantur Rathore <i@shantur.com>
---

Changes in v5:
- Only enable it for RK3399 and RK3588 as suggested by Kever

Changes in v4:
- Replace BOOTSTD_DEFAULT with BOOTSTD_FULL as previous version
didn't apply on next

 arch/arm/mach-rockchip/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 6ff0aa6911..5a46c986ef 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -265,6 +265,7 @@ config ROCKCHIP_RK3399
 	imply TPL_TINY_MEMSET
 	imply TPL_ROCKCHIP_COMMON_BOARD
 	imply SYS_BOOTCOUNT_SINGLEWORD if BOOTCOUNT_LIMIT
+	imply BOOTSTD_FULL
 	imply CMD_BOOTCOUNT if BOOTCOUNT_LIMIT
 	help
 	  The Rockchip RK3399 is a ARM-based SoC with a dual-core Cortex-A72
@@ -319,6 +320,7 @@ config ROCKCHIP_RK3588
 	imply MISC_INIT_R
 	imply CLK_SCMI
 	imply SCMI_FIRMWARE
+	imply BOOTSTD_FULL
 	help
 	  The Rockchip RK3588 is a ARM-based SoC with quad-core Cortex-A76 and
 	  quad-core Cortex-A55 including NEON and GPU, 6TOPS NPU, Mali-G610 MP4,
-- 
2.40.1

