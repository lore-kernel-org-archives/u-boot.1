Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC77BC531C9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 12:40:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A7C6440B3A;
	Fri, 24 Jul 2026 12:40:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SCISLXc1zsJs; Fri, 24 Jul 2026 12:40:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 483A44076D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784896807;
	bh=mVHQniJ2NbdA4YtjvQOOwW5I61tbQZDZ0Np1f1bfLZQ=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=G4r6qiTAFf7IQFXgPOlA+zl6A6Ngoz/3OKgjmixu7o83thKPZL6A7jDUPIOb0U2YV
	 /NA07NO28RbRoWo1wsBa1uoBqhXBbZ+ocurBwMSv/lbQg0gX1tgxieif0gTpBQgHsK
	 YHmMUTR2vPPMRnI8b9+fPDlqbUT5dYk6vNzSsAVpr/ok0cCxJgvIcIT01X0OmdXx4p
	 gv5UyRDEqTnUQnWdsfLT9pNhYF7FVetNeC52nXBm7qr9wszBfoZMLOd1KKKvvfxIGV
	 oSOU1y51I45QwlfVA1MRmNoUjTJWPVSUXkoGlooVfykFNFtATupx1hXc44hAK68IPI
	 FoFxCBUk4qaVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 483A44076D;
	Fri, 24 Jul 2026 12:40:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EA9BC224
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:40:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D068660747
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:40:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kL3cfpwfA83E for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 12:40:05 +0000 (UTC)
X-Greylist: delayed 12245 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 24 Jul 2026 12:40:03 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 48CBE606A6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 48CBE606A6
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:fff0::190f; helo=smtp-190f.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Received: from smtp-190f.mail.infomaniak.ch (smtp-190f.mail.infomaniak.ch
 [IPv6:2001:1600:19:fff0::190f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 48CBE606A6
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 12:40:03 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h66yS5N2dz8bq;
 Fri, 24 Jul 2026 14:40:00 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4h66yS1lFCzbnj; Fri, 24 Jul 2026 14:40:00 +0200 (CEST)
Message-ID: <0c594f8b-e143-43bb-a2ec-760b79577ea1@0leil.net>
Date: Fri, 24 Jul 2026 14:39:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
Subject: [GIT PULL] Please pull u-boot-rockchip-2026.10-20260724 into main
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0leil.net; s=20231125; t=1784896800;
 bh=mVHQniJ2NbdA4YtjvQOOwW5I61tbQZDZ0Np1f1bfLZQ=;
 h=Date:To:From:Subject:From;
 b=acpigeonS2VIleF9gTytbYiKHB4isKMtApABjXVv2TzoaCMBE8gvtbG0EG+4oqnIY
 AelWMW39Q/0qfiC050jIstdXkhbH7b2b6TGW01lUVJKIbukgE9T5kDaOf2QnzDRLd1
 Bv1r08uVHKTLi6It6KH++gi33SaNIStRiL8m48VoDjSHidSoW1uFEPf9f60PwNNMFi
 NYAkK4pNWn7J6wAUfdL/6TBZqfGlEjqRstNJ3QTKGtUL4FPF5Lp7ePoBUXedwVHJck
 5CTE1sbuZShSIrbVqZdVbqdij96/yr8fsC7oG58zNyCgXmK6XrX0Ff1yRPrLCmei3h
 267f3jg24RoMA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=0leil.net
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=acpigeon
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <u-boot@0leil.net>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tom,

The following changes since commit fdfe2ec48d5c1c2ed03073d73edd3fdd3fe1ffa1:

   clk: airoha: fix off-by-one in clock ID boundary check (2026-07-17 
14:50:35 -0600)

are available in the Git repository at:

   https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip.git 
tags/u-boot-rockchip-2026.10-20260724

for you to fetch changes up to d97d3df79e7bd7021dac0a1974c314c5acb07ac3:

   mtd: nand: raw: rockchip_nfc: fix ecc setup (2026-07-23 17:43:33 +0200)

----------------------------------------------------------------
- Switched to use upstream pinctrl header include,
- Dropped SDHCI DT properties in U-Boot-specific DT for NanoPi R5 as
   most are present upstream and those which aren't are breaking devices,
- Fixed ECC strength mismatch between reading and writing on non-0
   NAND chips configured as boot medium (nand-is-boot-medium),
- Moved Simon to reviewer for ARM ROCKCHIP,
- Fixed build issue related to GPT capsule support accessing a struct
   member only present when CONFIG_PARTITION_TYPE_GUID is set,
- Added support for new devices:
   - Anbernic RG-DS
   - ROC-RK3588S-PC

----------------------------------------------------------------

CI: 
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/pipelines/722

Chris Morgan (1):
       board: rockchip: add Anbernic RG-DS

Daniel Golle (1):
       rockchip: only build GPT capsule update helpers with 
PARTITION_TYPE_GUID

Fabio Estevam (1):
       rockchip: rk3588s: Add support for ROC-RK3588S-PC

Johan Jonker (4):
       rockchip: pinctrl: replace RK_FUNC_n defines
       rockchip: pinctrl: replace RK_GPIOn defines
       rockchip: pinctrl: use include from dts/upstream
       mtd: nand: raw: rockchip_nfc: fix ecc setup

Peter Robinson (1):
       rockchip: rk3568-nanopi-r5: Drop duplicated/extra sdhci

Quentin Schulz (1):
       MAINTAINERS: update ARM ROCKCHIP entry to list Simon as reviewer

  MAINTAINERS                                    |   2 +-
  arch/arm/dts/rk3368-sheep.dts                  |   2 +-
  arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi |  41 
+++++++++++++++++++++++++++++++++++++++++
  arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi     |   8 --------
  arch/arm/mach-rockchip/board.c                 |   6 ++++--
  arch/arm/mach-rockchip/rk3568/Kconfig          |   7 +++++++
  arch/arm/mach-rockchip/rk3588/Kconfig          |   7 +++++++
  board/anbernic/rg-ds_rk3568/Kconfig            |  12 ++++++++++++
  board/anbernic/rg-ds_rk3568/MAINTAINERS        |   7 +++++++
  board/firefly/roc-pc-rk3588s/Kconfig           |  12 ++++++++++++
  board/firefly/roc-pc-rk3588s/MAINTAINERS       |   6 ++++++
  configs/anbernic-rg-ds-rk3568_defconfig        |  73 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  configs/roc-pc-rk3588s_defconfig               |  81 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  doc/board/rockchip/rockchip.rst                |   2 ++
  doc/develop/driver-model/serial-howto.rst      |   4 ++--
  drivers/mtd/nand/raw/rockchip_nfc.c            |  14 ++++++++------
  drivers/pinctrl/rockchip/pinctrl-rk3568.c      | 186 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------------------------------------------------------
  drivers/pinctrl/rockchip/pinctrl-rv1126.c      | 134 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------------------
  include/configs/anbernic-rg-ds-rk3568.h        |  12 ++++++++++++
  include/configs/roc-pc-rk3588s.h               |   8 ++++++++
  include/dt-bindings/pinctrl/rockchip.h         |  60 
------------------------------------------------------------
  21 files changed, 444 insertions(+), 240 deletions(-)
  create mode 100644 arch/arm/dts/rk3568-anbernic-rg-ds-u-boot.dtsi
  create mode 100644 board/anbernic/rg-ds_rk3568/Kconfig
  create mode 100644 board/anbernic/rg-ds_rk3568/MAINTAINERS
  create mode 100644 board/firefly/roc-pc-rk3588s/Kconfig
  create mode 100644 board/firefly/roc-pc-rk3588s/MAINTAINERS
  create mode 100644 configs/anbernic-rg-ds-rk3568_defconfig
  create mode 100644 configs/roc-pc-rk3588s_defconfig
  create mode 100644 include/configs/anbernic-rg-ds-rk3568.h
  create mode 100644 include/configs/roc-pc-rk3588s.h
  delete mode 100644 include/dt-bindings/pinctrl/rockchip.h
