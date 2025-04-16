Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40958C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 13:35:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A99AC82DB4;
	Wed, 16 Apr 2025 15:35:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744810533;
	bh=8i4pNUO3xizHr4kcLhxvtNNqv7M1W0JA/dxy3dX9V8s=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AIQ0gcxknbt0glVyjzI63Q+C2LnP6Ouf/60FYAfH9uCwUObqlApEctvQiwpYnAp7m
	 h0CY9TtesExQhHyzma6QnFUSDbsBwR65bIRHL7pprRA7qPajypn6sjN4f0KkdZnJnV
	 jzG9cGhBgimcFIoa4selpR1N2XvUPf5BfzrELR3/RE1O+D05pvc1OpoaFEzFOZgY20
	 +XuGdArtqNXJGL7BFdFuUt5ZsBugigqvxM2nv+wM1OPd7sTC8ZsYWUN1yRP2CMgiKg
	 ISLuN83gaZSgHiM8a9mWmVFLbMVbtbrwlDT2v/NNnQf4UFBUmugOpol/UyLiFlcZcB
	 dLg/vhRuGVCpA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0D0E82E9F; Wed, 16 Apr 2025 15:35:32 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23D3D82B5B
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 15:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4Zd28Z3bY7z9sw7;
 Wed, 16 Apr 2025 15:35:26 +0200 (CEST)
Message-ID: <b42d26fc-263f-45c0-aede-783a401ec724@denx.de>
Date: Wed, 16 Apr 2025 15:35:25 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
From: Stefan Roese <sr@denx.de>
Subject: Please pull u-boot-marvell/master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4Zd28Z3bY7z9sw7
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

Hi Tom,

please pull this next batch of mostly Marvell related patches:

----------------------------------------------------------------
- mvebu_espressobin_ultra-88f3720_defconfig: disable SATA
- helios4: enable ddr odt0 on write for both chip-select
- clearfog,helios4: disable sdhci sdma
- mvebu/bubt: Correct usage of IS_ENABLED() macro
- mvebu: Correct SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR usage
----------------------------------------------------------------

Here the Azure build, without any issues:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=390&view=results

Thanks,
Stefan


The following changes since commit a08425586799374ccded78eb5fdef6e2235e1ad9:

   Merge tag 'tpm-master-14042025' of 
https://source.denx.de/u-boot/custodians/u-boot-tpm (2025-04-15 07:36:25 
-0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-marvell.git 
tags/u-boot-marvell-20250516

for you to fetch changes up to 9af45190d6dbe4d7369c01c34b6fe40dc00d8663:

   ARM: mvebu: Correct SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR usage 
(2025-04-16 08:05:15 +0200)

----------------------------------------------------------------
Benjamin Schneider (1):
       configs: mvebu_espressobin_ultra-88f3720_defconfig: disable SATA

Chris Packham (1):
       arm: mvebu: Fix typos in Kconfig help text

Josua Mayer (2):
       board: kobol: helios4: enable ddr odt0 on write for both chip-select
       configs: clearfog,helios4: disable sdhci sdma

Tom Rini (2):
       cmd: mvebu/bubt: Correct usage of IS_ENABLED() macro
       ARM: mvebu: Correct SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR usage

  arch/arm/mach-mvebu/Kconfig                       | 5 ++---
  board/kobol/helios4/helios4.c                     | 6 +++++-
  cmd/mvebu/bubt.c                                  | 2 +-
  common/spl/Kconfig                                | 1 +
  configs/clearfog_defconfig                        | 1 -
  configs/clearfog_sata_defconfig                   | 1 -
  configs/clearfog_spi_defconfig                    | 1 -
  configs/helios4_defconfig                         | 1 -
  configs/mvebu_espressobin_ultra-88f3720_defconfig | 1 -
  9 files changed, 9 insertions(+), 10 deletions(-)

