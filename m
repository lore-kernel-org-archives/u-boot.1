Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA05EC3271E
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 07:36:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BABF38852E;
	Thu, 11 Jul 2024 09:36:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J9URU/li";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7431588790; Thu, 11 Jul 2024 07:50:43 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CA9583989
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 07:50:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=indrek.kruusa@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52e99060b0dso525020e87.1
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 22:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720677041; x=1721281841; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ysNk2grdCZSaxbKtvUBxf9dTah9VE1dA73Gx3AeZKAE=;
 b=J9URU/li2jwRM9axZIEVIgGsOwF+es8fD8MgMj9G+HzuRQr4KSI6bypt38qoMAX6um
 KpOVsrRXbPm2DZLOAYaJDGEabKFlwB/K3nqtrAqxf+nrMWN+b5JSA4rc03429I/vi3w9
 0kNJEdy2pKAI0MkumzhgKgdBMKMrKfxRkPIfOXHzWSjxZfMN/gC57+Pn8U31vGa2pvsJ
 FZZj2yL6hpRpFl+QHRh1dJHaqtph/MVKC9Dg1cuVN+g+msFRyY5HG5sLVos9W5/oIgJo
 ZQvvuWclewAaTNtCCKxycLBrRJujWglNILGCUHc5HHFzCwvpFd3d2uQf4tY499nzSeVV
 F/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720677041; x=1721281841;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ysNk2grdCZSaxbKtvUBxf9dTah9VE1dA73Gx3AeZKAE=;
 b=lBVw4f6oXxSTEx3JG4IcLds+Pfdt/f4fLoAVZVwK+USVgTn64M3hmrPxhqiYNr+Uq3
 mimaA6VDYfPVjz6bpx9UbBisx4TL32136wxcmqKC6+dXPE6Uv9t3RTc287MWqpHrB72S
 SwnaYmIpYIK2k/lDkw8BvRMu1CKLt96B3PXgmPd3Is5h3zMVshk7dfNusT5uvCNFa44g
 wzMK6vLrPcL60L5F+iRwg+Ad/UmOvzbZIouFwLV2r8Hqe5SHxKjAQFQRmXKxmgYUu3Im
 oveqqTw8vMDZsdUvAuEeopy9DFct5gRk4pcGkR/6jVjSEls/EcSQQM6AXQEMU7vhWVpe
 m5YQ==
X-Gm-Message-State: AOJu0Yzjhi8UTpE1Hm6ltY+/CkAU10BRYsjnKYg8qnG7hBN6DZh1n2ur
 rIc7RkwDWcrZDtexWz/ELsVbPtuSK2gNBAbrEQtH4Rq+OYMK/hruFhUQfL0W
X-Google-Smtp-Source: AGHT+IHuAw63kwdsprhzu7IQs8sb6OhEnhkxYLiJm8nzGHMZpUoz0K7bQ6qDVJwY0n+XUxB4dif35g==
X-Received: by 2002:ac2:5b01:0:b0:52c:dc6f:75a3 with SMTP id
 2adb3069b0e04-52eb99a310bmr4382260e87.40.1720677040591; 
 Wed, 10 Jul 2024 22:50:40 -0700 (PDT)
Received: from localhost.localdomain (145.14.21.104.cable.starman.ee.
 [145.14.21.104]) by smtp.googlemail.com with ESMTPSA id
 2adb3069b0e04-52eb8e34595sm863795e87.54.2024.07.10.22.50.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 22:50:40 -0700 (PDT)
From: indrek.kruusa@gmail.com
To: indrek.kruusa@gmail.com
Cc: u-boot@lists.denx.de, andre.przywara@arm.com, cfsworks@gmail.com,
 samuel@sholland.org, uwu@icenowy.me
Subject: sunxi DRAM init: Allwinner D1s: auto scan dram rank & width failed
Date: Thu, 11 Jul 2024 08:50:35 +0300
Message-Id: <20240711055035.16270-1-indrek.kruusa@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jul 2024 09:36:17 +0200
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

Hi,

I am testing this new unified sunxi DRAM initialization on my Mangopi MQ board (Allwinner D1s) and can't get it working.
I'm on S. Holland's u-boot branch d1-wip. I created a config for the board and modified dram_sun20i_d1.c with values Andre suggested here:

"
According to the dump of some MangoPi MQ-1 firmware, the D1s should work with:
CONFIG_SUNXI_DRAM_DDR2=y
CONFIG_DRAM_CLK=528
CONFIG_DRAM_ZQ=8092665
CONFIG_DRAM_SUNXI_ODT_EN=0
CONFIG_DRAM_SUNXI_TPR0=0x00471992
CONFIG_DRAM_SUNXI_TPR11=0x30010
CONFIG_DRAM_SUNXI_TPR12=0x35
CONFIG_DRAM_SUNXI_TPR13=0x34000000
"

Boot fails like this:

U-Boot SPL 2024.01-rc1 (Jul 11 2024 - 06:29:02 +0300)
sunxi_ram_probe: dram-controller@3102000: probing
DRAM BOOT DRIVE INFO: V0.24
DRAM CLK = 528 MHz
DRAM Type = 2 (2:DDR2,3:DDR3)
DRAMC read ODT off
ZQ value = 0x30
DDR efuse: 0xa
DX0 state: 3
DX1 state: 0
ERROR: auto scan dram rank & width failed
auto_scan_dram_config() FAILED
DRAM init failed
spl_board_init_f() failed: -19

resetting ...
reset not supported yet
### ERROR ### Please RESET the board ###

Am I the only one who is facing such problem? :) When I'm switching to this old asm based init code then the DRAM init works.

br,
Indrek
