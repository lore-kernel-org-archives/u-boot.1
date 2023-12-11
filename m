Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C9CC4332F
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 23:21:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DA32877D3;
	Tue, 12 Dec 2023 00:21:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RQXTIzu4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A44F877C8; Tue, 12 Dec 2023 00:21:39 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3371687773
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 00:21:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macroalpha82@gmail.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3b9e07690ccso2905431b6e.3
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 15:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702336892; x=1702941692; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=59cEnByCnQ9f1Q91nFYMAGFACcdbdIgdsz4B0zt2GSo=;
 b=RQXTIzu4vMzzrKfnJUqraHy/IBXsGQV5Is9EcsufR2chQt19FwUsxRuqP7ZX1DNrI3
 ptGiTQ/HhCIWFwLC2zDlsD0COu4WVIbhmD2QdOGCJpODF26wDAxSfzu6gnewJLHQgxEz
 BiqjCgCwJSaaq7BUpxMHqmcnbxYu/+XBzxxsIa8puAHlmcS9WMJLWv/WmMaPuUHkZYFh
 zK6qR5ny+UMQFI/RIzki1xblW3yD+0MR25T4SjskjuidAlBOyJbmL/Qh1S7k3TZelXMC
 qYDsj+uqlsG5ZH3ZDrK1UyTRR6TobldM1F6Ke2dObXomcGq2Bji8wDWjeUKQ4PnLhTHM
 Lzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702336892; x=1702941692;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=59cEnByCnQ9f1Q91nFYMAGFACcdbdIgdsz4B0zt2GSo=;
 b=UNDhWocuwL3M9VY5Qd2DKdopaAZjEOBL5hnsgnJyOZArnzkZQxGaKjWmCKn5Bhg1pL
 Co9iFi7QhIYWgmUH82zcG9UHkjxOftyksT5bxM43VXLSYWlXtrTwvxA//abY5LLpXE+k
 whJAN38Sat9VWwesvEA8PMfA8fUNyuXLm4aDv0z7rSLZMPch44FGhvAdTBmBSasrD0uS
 oe1Nixn570te9/GaM1vWQCeCBQgmhsIyorzPnH2XcWAeVpRc42IDBVN/bYzegOVVa2Pr
 rC0NAeSwOzFiT/k3fQWtQ9039SER8KBJGBNWft4XPjW/pVpbl5KxEyUCy03RGOczgfQv
 gklw==
X-Gm-Message-State: AOJu0Yz5oECo2w8/Y8ZNBTc2KrAXoM6NcC+sz7zPIi08ksIHzWcR53dD
 +Co0iWf8torjJBn05lc4r2WHPaxP3TM=
X-Google-Smtp-Source: AGHT+IEJFM3UOJIZx92zQI5wFOrhVWn00yZ6l5ep8gh0Vj7Cbpg6ZnGJq3uyEkjwyi4T0mM2YTfe/g==
X-Received: by 2002:a05:6808:2125:b0:3b8:9d44:8c3d with SMTP id
 r37-20020a056808212500b003b89d448c3dmr5778579oiw.31.1702336892072; 
 Mon, 11 Dec 2023 15:21:32 -0800 (PST)
Received: from localhost.localdomain ([75.28.21.198])
 by smtp.gmail.com with ESMTPSA id
 bl11-20020a056808308b00b003b9d0371517sm2059617oib.28.2023.12.11.15.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 15:21:31 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: u-boot@lists.denx.de
Cc: andre.przywara@arm.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V3 0/7] Add Additional Boards and Features to RGxx3
Date: Mon, 11 Dec 2023 17:21:18 -0600
Message-Id: <20231211232125.171438-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

The RGxx3 is a pseudo-device for U-Boot that works for every Anbernic
RGxx3 series device on the market. Add support for another series of
very similar devices from Powkiddy.

Changes since V2:
 - Modify the mach-rockchip level rockchip_dnl_key_pressed() so that
   we can also call it in SPL mode and eliminate the board specific
   function. This requires adding ADC support to SPL. Additionally,
   I had to change the regulator for the saradc to a fixed regulator
   and add GPIO and regulator support to SPL.
 - Move the board specific board_rng_seed to the mach-rockchip level
   board file so that other rockchip boards with a hardware RNG can
   benefit. This should only be called if both the Rockchip
   hardware RNG as well as the rng seed functions are enabled.
 - Add two new boards (the RG-ARC-D and RG-ARC-S). I removed the
   previous code review due to the extensive changes made.

Changes since V1:
 - Update verbiage around function button to say "recovery" mode
   instead of calling it "maskrom" mode, which has a specific
   meaning. Also note that recovery function was done in a board
   specific manner to ensure it can run early.
 - Update board level documentation for the RGxx3.

Chris Morgan (7):
  board: rockchip: Refactor panel auto-detect code
  spl: Add Kconfig options for ADC
  rockchip: boot_mode: Allow rockchip_dnl_key_pressed() in SPL
  board: rockchip: Add Recovery Button for Anbernic RGxx3
  rockchip: board: Add board_rng_seed() for all Rockchip devices
  board: rockchip: Add support for new boards to RGxx3
  doc: board: anbernic: Update rgxx3 to add new boards

 .../arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi |  11 +
 arch/arm/mach-rockchip/Makefile               |   4 +-
 arch/arm/mach-rockchip/board.c                |  32 +++
 arch/arm/mach-rockchip/boot_mode.c            |  11 +-
 board/anbernic/rgxx3_rk3566/rgxx3-rk3566.c    | 194 +++++++++++-------
 common/spl/Kconfig                            |   7 +
 configs/anbernic-rgxx3-rk3566_defconfig       |  16 +-
 doc/board/anbernic/rgxx3.rst                  |  20 +-
 drivers/Makefile                              |   1 +
 drivers/adc/Makefile                          |   2 +-
 include/configs/anbernic-rgxx3-rk3566.h       |   2 +
 11 files changed, 210 insertions(+), 90 deletions(-)

-- 
2.34.1

