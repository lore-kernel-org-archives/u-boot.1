Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54068C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 15:59:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0E1984AAE;
	Fri, 10 Jul 2026 17:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="P4mCQVlj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E36284ACA; Fri, 10 Jul 2026 17:59:07 +0200 (CEST)
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch
 [84.16.66.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3D4284A73
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 17:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gxc2c2WwYz9Wx
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 17:59:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783699144;
 bh=XyipuoRAnllbXL8T1MdCjMAYkfHBXe2FtOX4RBG+YY8=;
 h=Date:To:From:Subject:From;
 b=P4mCQVljdCSN/YM3W0kzGUty1qDTav2yHcIBWnW87jU7JAgIeuo/EJUDtaNfkDd2H
 sKYhYkxGH4cvZoZKmgRy5KZNCPWUrPRD21+RcB/EtvKlELawBAJSX/a1rHqypCVLPf
 tPsbuwN+u8IrLXOycaP/mZFaoGxjt4n9Ldckdf5iKMD3JN5ULJl7Tsl2CQabCbkGRD
 OKIITW/7gt1260gVOJ+I1x2InZ/arak0DXygh0vi9ZYLDyKxjODJWkgD4hI1pkX3KF
 3pnPAYaAOgnfqS20ILQLAmBIdrX/vVu0J7Sh0fuXjDVUg4gqD8xKtn/ZzANny7Ypc/
 c1ZvmSGH8FxWg==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gxc2b5cKtzh5b; Fri, 10 Jul 2026 17:59:03 +0200 (CEST)
Message-ID: <471cfb20-03a3-43f3-a391-d9503d9e6a82@0leil.net>
Date: Fri, 10 Jul 2026 17:59:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
From: Quentin Schulz <u-boot@0leil.net>
Subject: [GIT PULL] Please pull u-boot-rockchip-2026.10-20260710 into main
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
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

The following changes since commit 913fedc816570c07bfc7f9c4046dc2a3a55e4099:

   Merge tag 'xilinx-for-v2026.10-rc1-v3' of 
https://git.u-boot-project.org/u-boot/custodians/u-boot-amd (2026-07-08 
10:13:24 -0600)

are available in the Git repository at:

   https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip.git 
tags/u-boot-rockchip-2026.10-20260710

for you to fetch changes up to b5deaa71fbe543d11644b6235d466b252587641f:

   board: rockchip: Add support for 9Tripod X3568 v4 (2026-07-10 
10:52:20 +0200)

----------------------------------------------------------------
- Add new rockchip custodian,
- Remove inactive rockchip custodian,
- Preemptively fix rk3528/rk356x DTS issue that will come with 7.1
   upstream DTS sync,
- Fix typo in doc,
- Fix variable used before being set in rockchip_nfc,
- Fix asm-operand-widths clang warning for RK3528, RK3576 and RK3588,
- Work around HW undefined state for NVMEs on RK3588 Jaguar,
- Added support for new devices:
   - LinkEase EasePi R1
   - 9Tripod X3568 v4

----------------------------------------------------------------

CI: 
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/pipelines/597

Coia Prant (1):
       board: rockchip: Add support for 9Tripod X3568 v4

Jakob Unterwurzacher (1):
       board: rockchip: set M.2 NVMe PERSTN low in spl_board_init on Jaguar

Johan Jonker (2):
       rockchip: doc: fix typo evb-rk3288-rk808_defconfig
       mtd: nand: raw: rockchip_nfc: fix oobfree length calculation

Jonas Karlman (1):
       arm: dts: rockchip: Align OTP nodes for RK3528/RK356x with Linux v7.1

Liangbin Lian (1):
       rockchip: rk3568: Add support for LinkEase EasePi R1

Quentin Schulz (13):
       MAINTAINERS: remove redundant entries for ARM ROCKCHIP
       MAINTAINERS: add rkmux.py to ARM ROCKCHIP
       MAINTAINERS: add N: px30 regex to ARM ROCKCHIP
       MAINTAINERS: add N: px5 regex to ARM ROCKCHIP
       MAINTAINERS: add N: rk3 regex to ARM ROCKCHIP
       MAINTAINERS: add N: rk8 regex to ARM ROCKCHIP
       MAINTAINERS: add N: rv11 regex to ARM ROCKCHIP
       MAINTAINERS: add N: rkmtd regex to ARM ROCKCHIP
       MAINTAINERS: add more Rockchip drivers to ARM ROCKCHIP
       MAINTAINERS: add rockusb to ARM ROCKCHIP
       MAINTAINERS: remove Philipp Tomsich from ARM ROCKCHIP maintainers
       MAINTAINERS: add myself as ARM ROCKCHIP maintainer
       rockchip: fix asm-operand-widths clang warning

  MAINTAINERS                                           | 46 
++++++++++++++++++---------------------------
  arch/arm/dts/rk3528-u-boot.dtsi                       |  2 +-
  arch/arm/dts/rk356x-u-boot.dtsi                       |  8 +-------
  arch/arm/dts/rk3588-jaguar-u-boot.dtsi                |  6 ++++++
  arch/arm/mach-rockchip/rk3528/rk3528.c                |  2 +-
  arch/arm/mach-rockchip/rk3576/rk3576.c                |  2 +-
  arch/arm/mach-rockchip/rk3588/rk3588.c                |  2 +-
  board/rockchip/evb_rk3568/MAINTAINERS                 | 10 ++++++++++
  board/theobroma-systems/jaguar_rk3588/jaguar_rk3588.c | 20 
++++++++++++++++++++
  configs/9tripod-x3568-v4-rk3568_defconfig             | 76 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  configs/easepi-r1-rk3568_defconfig                    | 82 
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  doc/board/rockchip/rockchip.rst                       |  4 +++-
  drivers/mtd/nand/raw/rockchip_nfc.c                   | 18 
+++++++++---------
  13 files changed, 229 insertions(+), 49 deletions(-)
  create mode 100644 configs/9tripod-x3568-v4-rk3568_defconfig
  create mode 100644 configs/easepi-r1-rk3568_defconfig
