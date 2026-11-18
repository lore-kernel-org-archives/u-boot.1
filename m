Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818E8606A33E
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 21:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=TzsNbmzB;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d+PCgISr
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DED1405C5;
	Wed, 18 Nov 2026 21:40:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kfqIzqZDUsKv; Wed, 18 Nov 2026 21:40:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6504F405C6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795038001;
	b=sl9yyjnAd1FfvaHwQGEbcJpciuvKuEBifyTKbxYK9VMolrxI3KryWmaUhVUa1eWHn4kk
	 bLBvMpD/+KwL0JeEG0WjxmfCUsojM5+Fr62QDg6fUXckcB15F1IA9y19XEAOCBaZAyfI0
	 IAjH5S2oWG1jjFf8au5+GwjDy6d0hPpvc9ZXqXQsqsLUPca3UKyrx1QFs1w6W3K6rs0ut
	 RBjMoayOIEFkqxPaRIy8nEBu8GakMQfnhPSPxMjCOZCWEv+aOd4Y6uTSFnjlBaRNH8dEQ
	 fcOKTVGN1ejW87CAShkZbbaV3k+0TMagYUINykF4iJFqwjYz9OHGvEVikBOttMhTEiQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795038001;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=khq3gQQa5VdfTMyoVzeAwCTXLEk69C5whpgfYzwtN+M=;
	b=hnrX4X2E9UGqT33j51gzhGmm5x3iqU7iGWMtqbsXLqilgBhLFfsro7FoEk+fy4gYVG2k
	 TQopB64sEirJiaFNg13pddWNLd71BPqIJMuLQ7Ah5vD+wyKO43B//KP06nF1l7iYLbmix
	 KWWAcAKccH78sGEQYOq385iO7e/T6ZUcvqPdQdmJuGf3ie+6qiahrVK92DWjpDInWL+WG
	 IjDlApOsbdmSUY7+zJVHvb6DxYtIXfOLNdjHJZNuv5FGoGdmTFxsiVX3eiSbOuHENRhD1
	 zx7Nm6KmVGC/ZwJmsxhJIzzltfrHU7bt7egQoLFqjtfFdKTDZVT29b+O1y8uKvMD4ug==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795038001;
	bh=khq3gQQa5VdfTMyoVzeAwCTXLEk69C5whpgfYzwtN+M=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TzsNbmzBFgjdeKKiIDisTK3p46St3FodJAzy/q16VDtvaCxcm0T/Iq6Whscz3H90N
	 FBH4WmGA9xecNbgEseLzn59Vs5J1oPK5rWA5eJ+gNQeYRZlZOERTaOKegn9j2r0MPL
	 SHjlbq5hChdYQ7/IJETntRTpP7QTUI7XurLZRwKvPBjHvz2p5gEUGkutf8vvfGihTO
	 t5wTDXU9JIbhbCQfma1VWpQJnREaQBNqFHgcqOX+2gXXOJl9VWRHX15smIaAaD4NEP
	 JS9QymM1sfvBfVOlL3hC0FzIarNvo3b2GpPiXL/oLwMJDeIEfpjZV3211pKaTpCapJ
	 bzE9+ncP1QWVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6504F405C6;
	Wed, 18 Nov 2026 21:40:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6CB3D9F8
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:39:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4C10D80DC3
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:39:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KHYKfkptuc_P for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 21:39:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 52EEA80DA9
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=d+PCgISr
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 52EEA80DA9
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 21:39:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5CF99469FD;
 Wed, 18 Nov 2026 21:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79181F000C5;
 Wed, 18 Nov 2026 21:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795037997;
 bh=khq3gQQa5VdfTMyoVzeAwCTXLEk69C5whpgfYzwtN+M=;
 h=Date:From:To:Cc:Subject;
 b=d+PCgISr68uC3lJdwnJb7l/j1yQUlk0KIXJLXvDSL71wonVd2KMzYEOTkaq+A1TtL
 6/MsgrhiJTtND0fFPyxprO7du7ZtsuyPiHS4oA2TI2IABfSZqmrdmBZlpgF1jdl5pJ
 mdXObuytJWqVks+CMlhGjOgeJDaRQK6Gx0Ea8dC6/C6ptHbtfXN4HySORRnBBoJEB6
 2NLbZOeY3XJXGeEeeNMPFvSH72DvcGeEPwzOdPqIx57JHvfeduHmZsb/6pqBl07vXo
 UeyIycIJSbd3ZPjNLlphk/358BsRbfpEEjqAyDiv5RgEePz14Csvhl5jBuLlOxNH3T
 M/4IYF1swte9g==
Date: Wed, 18 Nov 2026 21:39:54 +0000
From: Yixun Lan <dlan@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, E Shattow <e@freeshell.de>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Subject: [GIT PULL] Please pull U-Boot spacemit-main-20261118
Message-ID: <20261118213954-GKA165669@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

Please pull from u-boot-spacemit into main, thanks.

CI for this pull request is available here:
  https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/pipelines/2088


The following changes since commit 8ea02c99391d2d922810065206721ead2863f075:

  mailmap: update entry for Viacheslav Bocharov (2026-11-10 14:57:48 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit.git/ tags/spacemit-main-20261118

for you to fetch changes up to ffdf122644c936510b74a26390b694ed4cdfa1c6:

  riscv: dts: spacemit: k3: adopt com260/pico-itx 8gb memory override (2026-11-18 07:56:25 +0000)

----------------------------------------------------------------
Pull request spacemit-main-20261118.

K1 SoC:
- Enable onboard usb
- Fix SdCard Pin Detect
- Add GPIO bias support
- No assert MMC Reset
- Fix SD multi block
- FIX SD I/O rail

K3 SoC:
- Fix memory size
- Enable Linux boot

Misc:
- Update Maintainer info

----------------------------------------------------------------
Bruno Banelli (1):
      board: spacemit: k1: Add the M1 Jupiter's product name

Dave Klotz (2):
      mmc: k1: let the SPL read SD cards more than one block at a time
      mmc: k1: do not assert the shared AXI reset on probe failure

E Shattow (3):
      riscv: dts: spacemit: k3: override reserved status of mimsic and maplic
      configs: spacemit: k3: enable CONFIG_BOOTSTD_FULL
      riscv: dts: spacemit: k3: adopt com260/pico-itx 8gb memory override

Hung-Chun Tseng (2):
      MAINTAINERS: spacemit: k1: add Hung-Chun Tseng as reviewer
      configs: spacemit_k1: Enable onboard USB hub support

Junhui Liu (1):
      riscv: dts: spacemit: k3: Drop guest properties from M-level IMSIC

Tanmay Kathpalia (2):
      configs: k1: enable SPL_MMC_IO_VOLTAGE
      spacemit: k1: do not force the SD I/O rail to 1.8 V in SPL

Yixun Lan (5):
      gpio: spacemit: cache pinctrl dev
      gpio: spacemit: propagate GPIO bias flag
      spacemit: k1: fix SD Card Detection for MusePi Pro
      MAINTAINERS: spacemit: k1: drop Huan Zhou
      MAINTAINERS: update email for Yixun Lan

 .mailmap                                  |  2 ++
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 10 ++++-----
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  |  3 +--
 arch/riscv/dts/k3-com260-ifx-u-boot.dtsi  |  9 ++++++++
 arch/riscv/dts/k3-pico-itx-u-boot.dtsi    |  9 ++++++++
 arch/riscv/dts/spacemit-k3-u-boot.dtsi    |  4 ++++
 board/spacemit/k1/MAINTAINERS             |  2 +-
 board/spacemit/k1/spl.c                   | 22 +------------------
 configs/spacemit_k1_defconfig             |  2 ++
 configs/spacemit_k3_defconfig             |  9 +-------
 doc/board/spacemit/k1-spl.rst             |  1 -
 drivers/gpio/spacemit_gpio.c              | 36 ++++++++++++++++++++-----------
 drivers/mmc/spacemit_sdhci.c              | 28 +++++++++---------------
 dts/upstream/src/riscv/spacemit/k3.dtsi   |  2 --
 include/configs/spacemit-k3.h             |  6 ++++++
 15 files changed, 75 insertions(+), 70 deletions(-)
 create mode 100644 arch/riscv/dts/k3-com260-ifx-u-boot.dtsi
 create mode 100644 arch/riscv/dts/k3-pico-itx-u-boot.dtsi

-- 
Yixun Lan (dlan)
