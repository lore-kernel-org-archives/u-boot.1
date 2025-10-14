Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E530DCCD187
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 09:01:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DB8C82BA7;
	Tue, 14 Oct 2025 11:01:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qpqzJuLS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A670882FC7; Tue, 14 Oct 2025 11:01:09 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75EA1807C0
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 11:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cm7VT0LKWz9tBF;
 Tue, 14 Oct 2025 11:01:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1760432465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=anf2uwehGW5z0u9vLbXQRaIKu/grFvVBXTYRWsRVca8=;
 b=qpqzJuLSvoduPbAY2G+CmZxzeuTteWt8C0wo6QgoYUsmGozylvAlCMcUyIUZnqkhpQzpoX
 KRkwglLW0ceOmrO9YC4dbEclHTQWDHL5jIepCIV/pHej2Mz+24tlwyWyeqD0XuLSyNgiRs
 MEqKmulOhjVXeuBVUqZjlYFZngTUOGw0Cab0jpEJJMsko7qajXHypAzGcOIq5iglp+1fnt
 yKQZ6yITawR6jlVNy9W2Wt5m0VmDZAQcJhHJy5KpeKcTJedPSnkle2mWkHzWTvFeJjUt+f
 IsGpEbH7wDwAanAwx/+eL51oTMK1U9YNiFrsIACpkaYp/LcdDNIZSaESeNVioQ==
Message-ID: <9f898b02-9d85-4e2a-9686-c59b1fcc16ae@mailbox.org>
Date: Tue, 14 Oct 2025 11:01:02 +0200
MIME-Version: 1.0
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
From: Stefan Roese <stefan.roese@mailbox.org>
Subject: Please pull u-boot-marvell/master
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 23ac03f3feeafbd8470
X-MBO-RS-META: eri1rcxwi6uxdg961yssy6e8eccjygeb
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

please pull this batch of Marvell related patches:

----------------------------------------------------------------
- sata_mv / octeontx_hsmmc: Smatch fixes / patches (Andrew)
- dts: pxa1908: convert to OF_UPSTREAM (Duje)
- phy: marvell: Tighten MVEBU_COMPHY_SUPPORT dependencies (Tom)
- pci: mvebu: Unable to assign mbus windows for 2nd pcie controller (Tony)
----------------------------------------------------------------

Here the Azure build, without any issues:

https://dev.azure.com/sr0718/u-boot/_build/results?buildId=398&view=results

Thanks,
Stefan

The following changes since commit 48f21e66e360552c75d70a50421d0e0ed1f59e90:

   fs: jffs2: Remove always true test (2025-10-10 14:27:59 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-marvell.git 
tags/u-boot-marvell-20251014

for you to fetch changes up to 81598d19ca7d60724c403a3ed4a10840e177288b:

   pci: mvebu: Unable to assign mbus windows for 2nd pcie controller 
(2025-10-13 16:13:21 +0200)

----------------------------------------------------------------
Andrew Goodbody (3):
       sata: sata_mv: Remove always true test
       mmc: octeontx_hsmmc: Need parens in expression
       mmc: octeontx_hsmmc: Remove impossible test

Duje Mihanović (1):
       ARM: dts: pxa1908: convert to OF_UPSTREAM

Tom Rini (1):
       phy: marvell: Tighten MVEBU_COMPHY_SUPPORT dependencies

Tony Dinh (1):
       pci: mvebu: Unable to assign mbus windows for 2nd pcie controller

  arch/arm/Kconfig                                   |   1 +
  .../dts/pxa1908-samsung-coreprimevelte-u-boot.dtsi |  20 ++++
  arch/arm/dts/pxa1908-samsung-coreprimevelte.dts    |  74 --------------
  arch/arm/dts/pxa1908.dtsi                          | 106 
---------------------
  configs/coreprimevelte_defconfig                   |   7 +-
  drivers/ata/sata_mv.c                              |  43 ++++-----
  drivers/mmc/octeontx_hsmmc.c                       |   5 +-
  drivers/pci/pci_mvebu.c                            |   2 +
  drivers/phy/marvell/Kconfig                        |   1 +
  9 files changed, 47 insertions(+), 212 deletions(-)
  create mode 100644 arch/arm/dts/pxa1908-samsung-coreprimevelte-u-boot.dtsi
  delete mode 100644 arch/arm/dts/pxa1908-samsung-coreprimevelte.dts
  delete mode 100644 arch/arm/dts/pxa1908.dtsi

