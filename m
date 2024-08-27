Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34044C5472F
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 14:22:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F9E688A8E;
	Tue, 27 Aug 2024 16:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="2p4SHVHs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA5A888A7D; Tue, 27 Aug 2024 16:22:05 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC7A285B66
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 16:22:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5343d2af735so4141919e87.1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 07:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1724768523; x=1725373323;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OR6042Kgiwvjr/1hxcjwFNGZzcyXFDjqeM9SksElBvA=;
 b=2p4SHVHsIMjtzcU/EFrPIb9cS6mYPitZFY3jTWLttHLwUM6YUhtP1lQiHf6fouzKpH
 iNv5VNdwWm+vFUqL8rI8jKwBYvJr3Rp3cahUunlMHF/ugorU29srmKtUu5A28+gEGxi1
 PoKkP6H6GKebBK1LxoNmEtIH//TQTqnclMRUdt5E0BhPZoo3dFraGeHoaERAupVmhGFC
 gwGI5Jmp0evuRKOdtk6VeOrRdPct1APmVdK1/N9Njpb2uqu0yHJ+RpgLt6XTW+fkHaRq
 C0XZda/5KPJ/kB+nKhaurkeCE8osIkq4UjbsFobpfH2gdCbjTn/Zw3sZNRDQiSmMdPJr
 +MKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724768523; x=1725373323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OR6042Kgiwvjr/1hxcjwFNGZzcyXFDjqeM9SksElBvA=;
 b=EhiZ2I6eXBz9E4qkgvZHq45fcrhqCFMJJdJniWGFzCFmRb1yo9993+mZtaSPUEP9B2
 4yHMRTSPMlWlIWfS8T9CkeNRRO4zV2aIarYGgJGo8cNxEVIROvvDMVwXHXmF394SYltg
 NtSLNrubzQIKQbgOV0HH+qFlJs1MXDn46Zx4Pt+Oj8yRcgTdBJ60UrVrd3S2AiUCatZ/
 N/G5LhyWXVec16E4THm0G+pIygDHkSNJeNbr6SSpBuTOenSGaeh+VL92PNR4GNmHdCs6
 PuMhnE5nCHkjb8mH/o1XJxlRzarEjccfZ0bNShnEsUh/OvXwtrCrOlytrhbIFRbbcgWO
 xMBQ==
X-Gm-Message-State: AOJu0Yz2bwfqKFBnZrIMchjElXE9yjAylAg/PXSq1sIsySrM6Jfw4c5I
 av8SbNpC+9uU0pMgDcgRZWpO++89Xt9jlqHQUwDXowOErPd/5+pJa9q1Tr4L1FrCadzmKLgKzXf
 S
X-Google-Smtp-Source: AGHT+IFUmD0GXJwPH2Qm/Im7g8zx0s32/djsFYBcpGbJlVEvo0j/wn4BPBeH27d6VPFiKFmcQipTHQ==
X-Received: by 2002:a05:6512:3987:b0:533:d3e:170a with SMTP id
 2adb3069b0e04-5344e4faf40mr2097377e87.38.1724768522747; 
 Tue, 27 Aug 2024 07:22:02 -0700 (PDT)
Received: from localhost.localdomain ([91.90.172.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e594e809sm114854366b.219.2024.08.27.07.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 07:22:02 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, quentin.schulz@cherry.de,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH 4/4] arm: rockchip: PX30: Fix hard dependency to
 DEBUG_UART_BOARD_INIT
Date: Tue, 27 Aug 2024 16:20:58 +0200
Message-ID: <20240827142058.594556-5-lukasz.czechowski@thaumatec.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827142058.594556-1-lukasz.czechowski@thaumatec.com>
References: <20240827142058.594556-1-lukasz.czechowski@thaumatec.com>
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

Because DEBUG_UART_BOARD_INIT depends on DEBUG_UART, hard dependency
to DEBUG_UART_BOARD_INIT in ROCKCHIP_PX30 can cause warnings if
DEBUG_UART is disabled.
The DEBUG_UART_BOARD_INIT is already implied by ARCH_ROCKCHIP entry.
Remove hard dependency from ROCKCHIP_PX30, so that it will be
consistent with other rockchip boards.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
---
 arch/arm/mach-rockchip/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 47a6275d45f..c9aaf6d3476 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -13,7 +13,6 @@ config ROCKCHIP_PX30
 	imply SPL_SEPARATE_BSS
 	imply SPL_SERIAL
 	imply TPL_SERIAL
-	select DEBUG_UART_BOARD_INIT
 	imply ROCKCHIP_COMMON_BOARD
 	imply SPL_ROCKCHIP_COMMON_BOARD
 	imply ARMV8_CRYPTO
-- 
2.43.0

