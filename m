Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA577C4725D
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 11:10:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4DA38785C;
	Mon, 22 Jan 2024 12:10:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dyeAXNbU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5B9D8780E; Mon, 22 Jan 2024 12:10:42 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E916087859
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 12:10:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7bed9f3ca97so116830039f.1
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 03:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705921838; x=1706526638; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=drAVwcROT8FMOPwbv/PL8JHfZZVzcWIdCBcGnxbOmyc=;
 b=dyeAXNbUtHvjE2qibFuGMZ6pSlgqJ2q/QeW2OWC5Uf4zIN8wQWRkBFdTK5TvS/R2V8
 0JyP0USS9an5JtXMtoDEP5I7rYd6GFKHomCNkGCl3bo3Le4hnwewNN1F45+/eavUlpte
 MdBdedd1ev8WqEM/C+7aX2AB+0K1sKkgyxHMPuWEuFVCPR1adwm4NJwvTYEGHxkreZHf
 JS6Ui0V9Sfexh0dzXRHUltRpLjzL/f4IzMdbHLpR98ggEszI9DzVXhwYCyqyYZUoL8qn
 0GvowyK3NPcmTaRxp/vrde25o874qGr+fWRFDMNIVyuLJDKpN2S2qMx33s3XkkRBp0pN
 ZNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705921838; x=1706526638;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=drAVwcROT8FMOPwbv/PL8JHfZZVzcWIdCBcGnxbOmyc=;
 b=t0Uwfntlrg94zI1OkQfG/2+XbvCdoF9kseyJrtcKTMBAYl4UEcQUz85uGPPzMuonOU
 FVM7YdPx1Tg3kzE0rADnMB3XKfHwbaLhmuEHFAvaXXtb1WDwPtPXLaBCg2UV2af2jpaG
 0+/NGo8SNBCO7BqX0aTug1T/T9I/YGRSmXpCYEb5plRuX6GkcweCFvZK1h1frnf56xCD
 2vsBk9iYAh0Bkdf/nOIbQWHUv6LUTq0T8LNs5qrM6VAjp5KHXL1q9XOxSb0WgDrWJBwV
 3X4dY5PNoonJU/K0rvh3P0SAjPbrJijWRjhcWMcFy0qHYKLzk/u2xVuOwTBaj3VzZd4V
 3dtw==
X-Gm-Message-State: AOJu0YznxBTNz9ltbUgwArxj4IjYYrsIfnWo8NCR2aKjq81RDAeXIVEt
 9LoVrAHOhZ7+OHTS7HTzTu1YdxTET/zyJ6ElhYvcxNgukWJ3GmX+iAyp34Kk3fKJSvgxgLRIXUW
 Vl1Ad8w==
X-Google-Smtp-Source: AGHT+IGWL19mdb1rFvo5zTii9OII/NLap9EhkucAtmdqSdmCQ9wiKqTZTUWS4Vh4vTQhY/zokd25uw==
X-Received: by 2002:a6b:e707:0:b0:7bf:5835:7971 with SMTP id
 b7-20020a6be707000000b007bf58357971mr5111134ioh.2.1705921838194; 
 Mon, 22 Jan 2024 03:10:38 -0800 (PST)
Received: from ThinkPad-T490.dc1.ventanamicro.com
 ([2401:4900:5306:c1c1:3bc5:9efa:4b71:9731])
 by smtp.googlemail.com with ESMTPSA id
 z16-20020a6b5c10000000b007bf2bfd2da7sm5206365ioh.28.2024.01.22.03.10.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 03:10:37 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bin Meng <bmeng@tinylab.org>, Johan Jonker <jbx6244@gmail.com>,
 Joshua Watt <jpewhacker@gmail.com>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Marek Vasut <marex@denx.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>
Subject: [PATCH v3 0/2] SPL EBBR - EFI System Partition support
Date: Mon, 22 Jan 2024 16:40:20 +0530
Message-Id: <20240122111022.229805-1-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
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

This series adds support to locate an EFI System Partition on a disk and
boot the next stage from such a parition if found. The next stage image
is expected to be under the FIRMWARE directory as described in the EBBR
specification [1]. Also update the spl_blk_fs and spl_fat drivers to
prefer booting from ESP and fall back to the configured parition in
case of a failure.

Changes in v3:
- Revert fallback change from v2
- Fix part_get_esp signature and header in part.h
- Add RB tag

Changes in v2:
- Rebase on latest next branch
- Enable SPL_ESP_BOOT by default
- For NVMe boot, remove fallback in case of ESP boot failure

Mayuresh Chitale (2):
  part: Add a function to find ESP partition
  spl: Add support for booting from ESP

 common/spl/Kconfig      |  8 ++++++
 common/spl/spl_blk_fs.c | 60 ++++++++++++++++++++++++++++++-----------
 common/spl/spl_fat.c    | 34 ++++++++++++++++++++---
 disk/part.c             | 16 +++++++++++
 include/part.h          | 13 +++++++++
 5 files changed, 111 insertions(+), 20 deletions(-)

-- 
2.34.1

