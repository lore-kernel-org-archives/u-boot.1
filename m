Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30E3CA5FA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 13:27:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9ED7D40755;
	Tue, 29 Sep 2026 13:27:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3Ff4YNkmLvm6; Tue, 29 Sep 2026 13:27:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A2D3D40732
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790688435;
	b=KaKcs/8qJhljB0XJknyFOOImgUW54ZLwYX6k7o65Q/Kw9S1igQU8O75e25RiKH42JrBe
	 MoWZ2sBA2VQ7IvoTPG+NQ+f1bVQQjx2Op7tsbYQ+dsrnQsv1ot8N1ufqeg+4EmGmlNwc4
	 N9hd44BmGjphlaG8fivnYVVYpGey8c+5wfkM3/1YQ433Nx44B6H+cOUnBkCPTq0mmr6CS
	 /v0L8PqnUcoBCaGTuDtrmlQGawiiLZSK/agqyMKAFFb2+aLXyTT5+CiEGnxbg6pN8FQeW
	 LuuKUSZq5h7x/JjhZvUXsnRkeEFSThQG4NzHaFf9IyCcnKiyKZ3eczU11Js/uAkKbZw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790688435;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vnI7T2ffyYRE3BHgd4ty4sQdZC0OJgpidTqQCy3RXh4=;
	b=ZmlolDG2UXdplLpP9gqZNNITEqrW7QU6j5UiF3I32iCrgEkh4j/MGKCqhhf1hIMDnezZ
	 fZfNru4Z3NL18chupsGnT98ZBFBSeW01wPo8x48mJqe/LwIjgpdw1ewS85HaFK6qkJ65f
	 yI9r4KDvdGoScbhKYyFHFFrty5PiarzodXpqpJ35zal5bl43p6xB6gy/hc08VyEmZsMfw
	 yqv2MOvR0I7QzUOzMqUm/DXAl/DHGIsKRzuh+Wv8Ry4jOmOL+s/IuM/0Pbom+diqmvNVG
	 W0odvyO4neNAXgzZUMHXtwJKf+T3JBe2d+1fiE/AlwN9/+pz3pBCCTEZYsnbgcJaYNA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790688435;
	bh=vnI7T2ffyYRE3BHgd4ty4sQdZC0OJgpidTqQCy3RXh4=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ARaPvrEuX/l7fMHLd07OugP/r8PCQ38lhqjx/UQSk9SSas+uzZsZbELRsq69b8Lct
	 bvwc2RMI8u83d9neORFY99M6tB8Ur/imDflkwBcXRPFtouqsXF+XC49GHpQX1S7MFP
	 h3zh3ho/iL6ia6qivDKzro6+MancP/ZnJZ4hj1xc6TOQxGi4xc1sV+wXNmTuy9ErWC
	 F5zvZglHN/Sgf+tsAr1IkO1/r11EKWbGl3RtPuqlgE1i4sli6E/lSAwfvArkgEI7TQ
	 UzXHS5PzndLLiFmpJjBmDKKXmHUrPlWv03Kf1cMrUDDZZ0z9TveWla1t1MSSS1REVV
	 hKZB3QIgJSzZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A2D3D40732;
	Tue, 29 Sep 2026 13:27:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E4212E5
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 13:27:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8E8E1802F0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 13:27:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m-xcAkzj6oQg for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 13:27:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 95A4B80EE3
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790688432;
 b=HIbBEJBsBu715uhObKxSzkMFn6X52PLu+UTga/XPMLU0+B20iJ+FEA62qvHIy6gk2xpA
 /uBil1I4leboMLhaWL5UBG/ibzraHzivu/V1Eue5Y7coNG1DKs9R+JUJxnAKziUe4TvIP
 WkJ56kxZjREnuZBOSGsn3+BBGb+kIwc6PETpVmQXFai+dOx793hZX8L23tnRESse4IsGG
 pHKphAd9sQQtXPgnG33FTRmONX5gSf1jjt/6kCFTlVlM3z/MqGDw0ExtJR8TqQcgHpa4f
 PiRdGVrmtaudohO9xS+2G7bjPVDjhSsoR9pd9PYeREH6SAlpfzSOxkwaXlyO3mhxlaw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790688432;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
 bh=vnI7T2ffyYRE3BHgd4ty4sQdZC0OJgpidTqQCy3RXh4=;
 b=LiCOSXqM9ttT0x0+P/pRpM7WAGUH8fbX7eIgG9lG0Yh8HFU8BQ3vaZpsMf1AWfwROq7x
 Lyqx85HHK3DwVjRFnCdQwYWK22k9WkU/omdvvs5UVRShj4EN+DpCw7BaPep71PZRbsjRV
 cZtmmZMHpzlaPipBS3F2nznQR828eyxl0y4eBc6y9//l5617QANRo7R0g9+z0RGXYv0J4
 tg19r9A+IWSQukTT3wDZN0cJFBnYqHsEX2EDOXcL5zavTan4ok3mt2xP/NcTR9250bK5V
 gqk6M1ng8YNirCPN1zh4CWv97UL6M97m54ev8EqpHrUNXhGm5kudjwo96hbjY2XVzIA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=XLed2iKz; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=XLed2iKz
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 95A4B80EE3
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 13:27:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DE0CD601FB;
 Tue, 29 Sep 2026 13:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FE41F00893;
 Tue, 29 Sep 2026 13:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790688430;
 bh=vnI7T2ffyYRE3BHgd4ty4sQdZC0OJgpidTqQCy3RXh4=;
 h=Date:From:To:Cc:Subject;
 b=XLed2iKz58IiHTxsioNrxv02JpeVFSc+neIz+KthkrYp+tsZ1p9aC8RrFWNCIWVJ6
 Se8chpbrQdiMnS2DFuGL1XCUOTDunsikbul2Tuf3hxajeDa6pIbl6hPnwVxgesXD1Z
 MpLwD5dx851OFD667vRJSpBAv5o/bAPH2MKSR059hJxjKARvPw3bTHmCPI72B340pk
 xNCG1b0b+jwORm3vEe2x0NERcEstseymD/JZdhzWNkLgsKzzuFSn/uPYEp5G8r8F+P
 A/kiT0ZuzEp9DKO/zo6/dZOW5ffE5Igz0pwk5kAcKtjdi+xESs69LrskNtHNbifZJk
 1ASALN+amXv9g==
Date: Tue, 29 Sep 2026 13:27:02 +0000
From: Yixun Lan <dlan@kernel.org>
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org, Eric Chung <eric.chung@riscstar.com>
Subject: [GIT PULL] Please pull U-Boot spacemit-next-20260929
Message-ID: <20260929132702-GKA27540@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Tom,

Please pull from u-boot-spacemit/next, thanks.

The following changes since commit 2b8902913c19eb581fb0d567201c09b8fa46ac74:

  Merge tag 'u-boot-imx-next-20260926' of https://git.u-boot-project.org/u-boot/custodians/u-boot-imx into next (2026-09-27 09:11:10 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit tags/spacemit-next-20260929

for you to fetch changes up to dfa681ec397aed90bd13aa5e0e887ee533d41988:

  MAINTAINER: add K1 PCIe driver to Spacemit entry (2026-09-29 09:08:57 +0000)

spacemit-next-20260929.
----------------------------------------------------------------

CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/pipelines/1397

K1 SoC:
- Fix pinctrl drive strength and power source
- Add eMMC/SD support
- Add PCIe support

----------------------------------------------------------------
Eric Chung (13):
      pinctrl: k1: fix drive strength configuration
      pinctrl: k1: add IO power domain configuration support
      spacemit: k1: select boot device via config registers
      mmc: k1: add sdhci platform driver
      dts: k1: enable mmc devices in SPL
      configs: k1: enable SD and eMMC support
      MAINTAINER: update Spacemit K1 entry
      doc: spacemit: flash on K1 SoC based boards
      spacemit: k1: fix product name detection and DTB matching in SPL
      phy: spacemit: add K1 PCIe/USB3 combo PHY driver
      pci: spacemit: add DesignWare PCIe host controller driver
      configs: k1: enable PCIe and NVMe support
      MAINTAINER: add K1 PCIe driver to Spacemit entry

Yixun Lan (2):
      MAINTAINERS: add new SpacemiT custodians
      pinctrl: spacemit: configure drive strength based on power source

 MAINTAINERS                               |   8 +
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi |  12 +-
 arch/riscv/dts/k1-musepi-pro-u-boot.dtsi  | 136 +-----
 board/spacemit/k1/MAINTAINERS             |   6 +-
 board/spacemit/k1/spl.c                   | 148 ++++++-
 configs/spacemit_k1_defconfig             |  32 ++
 doc/board/spacemit/index.rst              |   1 +
 doc/board/spacemit/k1-mmc.rst             | 268 ++++++++++++
 drivers/mmc/Kconfig                       |   7 +
 drivers/mmc/Makefile                      |   1 +
 drivers/mmc/spacemit_sdhci.c              | 684 ++++++++++++++++++++++++++++++
 drivers/pci/Kconfig                       |   7 +
 drivers/pci/Makefile                      |   1 +
 drivers/pci/pcie_dw_spacemit.c            | 391 +++++++++++++++++
 drivers/pci/pcie_dw_spacemit.h            |  78 ++++
 drivers/phy/Kconfig                       |   1 +
 drivers/phy/Makefile                      |   1 +
 drivers/phy/spacemit/Kconfig              |  11 +
 drivers/phy/spacemit/Makefile             |   1 +
 drivers/phy/spacemit/phy-k1-pcie.c        | 492 +++++++++++++++++++++
 drivers/pinctrl/spacemit/pinctrl-k1.c     | 261 ++++++++++--
 21 files changed, 2364 insertions(+), 183 deletions(-)
 create mode 100644 doc/board/spacemit/k1-mmc.rst
 create mode 100644 drivers/mmc/spacemit_sdhci.c
 create mode 100644 drivers/pci/pcie_dw_spacemit.c
 create mode 100644 drivers/pci/pcie_dw_spacemit.h
 create mode 100644 drivers/phy/spacemit/Kconfig
 create mode 100644 drivers/phy/spacemit/Makefile
 create mode 100644 drivers/phy/spacemit/phy-k1-pcie.c

-- 
Yixun Lan (dlan)
