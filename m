Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771F4E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 23:57:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E64F3801BA;
	Fri, 13 Dec 2024 00:57:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="zDu4hMJT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16516801BA; Fri, 13 Dec 2024 00:57:55 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7BCD800B6
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 00:57:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e29f=TG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1734047865;
 bh=wewviibkcIYMGfm55JJsgOIgxW6NzfFptetLGW2zg6Y=;
 b=zDu4hMJTrzrYS3XxwuXFYqDE7MztP9UPDkcvTLvk3/Kypk6fW0i/MXaNHCAoTl/HjYWA+BqT2
 5SNJjjprVOjYHSo/GDagSjNY21P3TTMKL8D99QyUsmqhbpFYkqlCMnDRhQS+TKS6JeRpfqFF+Oc
 p5uX92txfNuEhEwUDGNlkU8oodYz/o80njq9g0F5feh5bJgWQo1rXxLFLrr/MqQeADzluVfkrzL
 G776B4D3Fbkf/KF8wWvNGzhsQQtivoKdc5Poo7mKBiBIz2SdXW0G01Gxw7zgzg4IbIVJze0RnBz
 1MvsBS3C8OXlecOlPEShWWMbkU0+MoEdXfRZkoKgHrwA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 00/12] rockchip: rk3399: Migrate to use TPL on bob and kevin
Date: Thu, 12 Dec 2024 23:57:07 +0000
Message-ID: <20241212235735.164272-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 675b7876a511ed8f0b3fe24a
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

This is a continuation of an RFC [1] sent back in August.

All Rockchip aarch64 boards, beside bob and kevin, use TPL to initialize
DRAM and SPL to load FIT with U-Boot proper and TF-A.

Bob and kevin currently does not use TPL and instead initialize DRAM
in SPL and directly after tries to load a FIT with only U-Boot proper.

This series migrate bob and kevin to also use TPL to uniform TPL/SPL use
for all Rockchip aarch64 boards.

Features and changes in this series:
- Use of Rockchip aarch64 common bss and stack addresses
- SHA256 checksum/signature check of FIT images in SPL
- Use of dcache to speed up checksum check in SPL
- SDMA use for eMMC access to speed up read/write in U-Boot proper
- FIT location moved from 0x40000 to 0xE0000 in SPI flash

Changes sinc RFC:
- Include pinctrl props and enable regulators based on DT in SPL
- Drop bob and kevin board specific code from common rk3399.c

Please note that I do not have any bob or kevin so this has only been
compile tested and the original RFC [1] was runtime tested by Simon.

[1] https://patchwork.ozlabs.org/patch/1967517/

Jonas Karlman (12):
  rockchip: rk3399: Fix TPL build of bob and kevin
  rockchip: rk3399-gru: Use SYS_SPI_U_BOOT_OFFS value in offset prop
  rockchip: rk3399-gru: Move SPI flash payload offset for bob and kevin
  rockchip: rk3399-gru: Fix include of TPL in u-boot.rom image
  rockchip: rk3399-gru: Use TPL with common bss and stack addresses
  rockchip: rk3399-gru: Include binman generated FIT in u-boot.rom image
  rockchip: rk3399: Drop common Kconfig options already implied
  rockchip: rk3399-gru: Remove unused nodes from xPL control FDT
  rockchip: rk3399-gru: Enable dcache and signature validation in SPL
  rockchip: rk3399-gru: Use SDMA mode to read from eMMC
  rockchip: rk3399-gru: Include pinctrl and regulators in SPL
  rockchip: rk3399: Drop unneeded bob and kevin board specific code

 arch/arm/dts/rk3399-gru-u-boot.dtsi    | 29 ++++++++++++++++++++++++--
 arch/arm/dts/rk3399-u-boot.dtsi        | 14 +++++++++++--
 arch/arm/mach-rockchip/rk3399/Kconfig  | 12 -----------
 arch/arm/mach-rockchip/rk3399/rk3399.c | 23 +-------------------
 configs/chromebook_bob_defconfig       | 23 ++++++--------------
 configs/chromebook_kevin_defconfig     | 23 ++++++--------------
 6 files changed, 52 insertions(+), 72 deletions(-)

-- 
2.47.1

