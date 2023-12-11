Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC31C4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 11:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9323687730;
	Mon, 11 Dec 2023 12:46:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m+COSECP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 104848772D; Mon, 11 Dec 2023 12:46:12 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B583587725
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 12:46:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 983E7CE0B95;
 Mon, 11 Dec 2023 11:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5995CC433C7;
 Mon, 11 Dec 2023 11:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702295166;
 bh=wxx1jBRtTUdzUwENYmnZBozSUKWWO/5qag9eccQPH5E=;
 h=From:To:Cc:Subject:Date:From;
 b=m+COSECP4VNVzqC5ziL6oSH3XL07Nve4StbyBWsd5qOZY1GbhnX7tZyMrztVveq3O
 n/MOwmp+FOByEqdSgRp6Nmg4TXuGWYGdR5TCwNLGcPcPVy5kC+mpblpZ8PmGnKgnMX
 bF92bsEif1n7V3RPX+XP3DaBpG5yN+lijMsT3VipX5JVWyUgQYb6jxmua6TbF6/a+u
 R3lGAo5SyWN45lcWOootmNJiPYHLKi9EpqDWNn1CYp/TcBra1Tle8kCIic3TPYeWWL
 H3M1ztvAYdNzGsCj27cARMyJagu+uYE/Z6/EXRhbEny6ALBY267zuKdEViRx7Zmd+8
 bBaj6TIwKURLQ==
From: Roger Quadros <rogerq@kernel.org>
To: dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 hs@denx.de, enrico.leto@siemens.com
Cc: trini@konsulko.com, praneeth@ti.com, nm@ti.com, vigneshr@ti.com,
 u-boot@lists.denx.de, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 0/2] mtd: nand: omap_gpmc: Fix NAND for AM335x
Date: Mon, 11 Dec 2023 13:45:58 +0200
Message-Id: <20231211114600.4414-1-rogerq@kernel.org>
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

Hi,

These patches fix NAND and ELM for AM335x and related legacy platforms
that use HW BCH and ELM modules.

All CI tests pass: https://github.com/u-boot/u-boot/pull/453

Changelog:

v2:
- added __maybe_unused to omap_calculate_ecc_bch. fixes CI tests
- Added Tested-by Tags
- Explained about omap_elm single sector support in commit log 

cheers,
-roger

Roger Quadros (2):
  mtd: nand: omap_gpmc: Fix NAND in SPL for AM335x
  mtd: rawnand: omap_elm: Fix elm_init definition

 drivers/mtd/nand/raw/omap_elm.c  |  4 +-
 drivers/mtd/nand/raw/omap_elm.h  |  6 --
 drivers/mtd/nand/raw/omap_gpmc.c | 95 ++++++++++----------------------
 3 files changed, 31 insertions(+), 74 deletions(-)


base-commit: 2f0282922b2c458eea7f85c500a948a587437b63
-- 
2.34.1

