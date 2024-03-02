Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3ABC5478C
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 19:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19CBF87DB3;
	Sat,  2 Mar 2024 20:17:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="vEHVtCHb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25B0187DDE; Sat,  2 Mar 2024 20:17:22 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B395487D97
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 20:17:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8beb=KJ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1709407020;
 bh=xxu7/EQOW4gEgnb3qMa7PY7tWf8efASWKM/hhyRIRs0=;
 b=vEHVtCHbktHUa0t+DMNEES7V25rqXCcAElIwRgUeAT5JhM54Gqfsvn/CmPx3zRzjABuYsSqAf
 ZUk2nAaLI5/gFcd/8ENh719nkQEyJZysFhhlRGDcAbeDPL7LisxbW3fEy4Arq7YjKkrvY5hcknQ
 Uyj8g8hCkau1gE82CDUFq6/NSnHD4RAfq9teG82HiD3xsv34LCyxCIK4RHfHMp6Xwx7v+hfZD0L
 fCqUq2o3eOK3FFSVbvnwuaqp/aU/10U47fgyhr07M/VU69iNNnbE6IDgWR3ndHVjqNUZgawVtIL
 etmz7HAAkAkDUQRB6KthDs544EfUKc/QTwbV4MupO1Sg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Christopher
 Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH v3 0/6] rockchip: Update stack and bss addresses on RK3308,
 RK3328, RK3399, RK356x and RK3588
Date: Sat,  2 Mar 2024 19:16:10 +0000
Message-ID: <20240302191629.322562-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65e37b29aae288b7577bf25f
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

Trying to run U-Boot proper close to 1 MiB in size with debug logging
something similar to following can be observed:

  FDT 00000000002fc4e0 gd 00000000002fddf0
  FDT overlap
  resetting ...
  System reset not supported on this platform
  ### ERROR ### Please RESET the board ###

Fix this by changing stack and bss addresses used on RK3328 and RK3399.
The addresses chosen for stack and bss is a combination from both boards.

In v3 the implementation is changed to introduce a new Kconfig flag that
will help set default addresses and sizes that prevent code, heap and
stack from overlapping, see first patch for more details.

Other Rockchip aarch64 SoCs can also be migrated to use these defaults.
However, I only have devices using these SoCs to test and verify on.

TEXT_BASE for U-Boot proper can be changed to start at 0x200000 (2 M)
for migrated SoCs, I however opted to keep the existing TEXT_BASE used
on each migrated SoC.

The malloc heap sizes chosen is almost double of what current affected
SoCs are using. RK35xx was using an unusual large malloc heap for
pre-reloc, so these was reduced to use more sane values. There should be
plenty of room to increase bss and malloc heap sizes without risk of
overlapping if there is ever any need for that in the future.

Four RK3399 boards have been left untouched because they use SRAM for
SPL stack:
- chromebook_bob_defconfig
- chromebook_kevin_defconfig
- ficus-rk3399_defconfig
- puma-rk3399_defconfig

The following steps have been performed to migrate SoCs and boards to
use the common bss and stack addresses.

In SoC Kconfig:
- Add ROCKCHIP_COMMON_STACK_ADDR
- Set TPL malloc heap size
- Set custom TEXT_BASE to use for SoC
- Remove defaults any of the Kconfig options that now have default
  values defined 

In board defconfig:
- Enable CONFIG_SPL_SHARES_INIT_SP_ADDR
- Remove any of the Kconfig options that now have default values defined
- Refresh defconfig using make savedefconfig (or using qconfig.py)
- Verify using a clean build of U-Boot

Changes in v3:
- Rework to use a new Kconfig option to enable use of common bss and
  stack addresses.
- Migrate RK3308, RK356x and RK3588 in addition to RK3328 and RK3399
- Drop r-b tags because of major changes

Changes in v2:
- Rebase on v2 of "rockchip: rk3328: Update defconfigs, DTs and enable
  boot from SPI" [1]
- Use correct address 0x04000000 for 64 MiB offset in commit message
- Collect r-b tag

The RK3328 patch in this series depends on v2 of the following two series:
- rockchip: rk3328: Update defconfigs, DTs and enable boot from SPI [1]
- rockchip: Read cpuid and generate MAC address from efuse for RK3328
  and RK3399 [2]

A copy of this series and its two depends can be found at [3].

[1] https://patchwork.ozlabs.org/cover/1900345/
[2] https://patchwork.ozlabs.org/cover/1897743/
[3] https://github.com/Kwiboo/u-boot-rockchip/commits/rk3xxx-stack-v3

Jonas Karlman (6):
  rockchip: Add common default bss and stack addresses
  rockchip: Use common bss and stack addresses on RK3308
  rockchip: Use common bss and stack addresses on RK3328
  rockchip: Use common bss and stack addresses on RK3399
  rockchip: Use common bss and stack addresses on RK356x
  rockchip: Use common bss and stack addresses on RK3588

 Kconfig                                       |  2 +-
 arch/arm/mach-rockchip/Kconfig                | 55 +++++++++++++++++++
 arch/arm/mach-rockchip/rk3308/Kconfig         |  7 ++-
 arch/arm/mach-rockchip/rk3328/Kconfig         | 11 ++--
 arch/arm/mach-rockchip/rk3399/Kconfig         |  7 ++-
 arch/arm/mach-rockchip/rk3568/Kconfig         |  7 ++-
 arch/arm/mach-rockchip/rk3588/Kconfig         |  7 ++-
 configs/anbernic-rgxx3-rk3566_defconfig       | 13 -----
 configs/bpi-r2-pro-rk3568_defconfig           | 13 -----
 configs/eaidk-610-rk3399_defconfig            | 10 ----
 configs/evb-rk3308_defconfig                  | 13 -----
 configs/evb-rk3328_defconfig                  | 17 ------
 configs/evb-rk3399_defconfig                  | 10 ----
 configs/evb-rk3568_defconfig                  | 13 -----
 configs/evb-rk3588_defconfig                  | 13 -----
 configs/firefly-rk3399_defconfig              | 10 ----
 configs/generic-rk3568_defconfig              | 13 -----
 configs/khadas-edge-captain-rk3399_defconfig  | 10 ----
 configs/khadas-edge-rk3399_defconfig          | 10 ----
 configs/khadas-edge-v-rk3399_defconfig        | 10 ----
 configs/leez-rk3399_defconfig                 | 10 ----
 configs/lubancat-2-rk3568_defconfig           | 13 -----
 configs/nanopc-t4-rk3399_defconfig            | 10 ----
 configs/nanopc-t6-rk3588_defconfig            | 13 -----
 configs/nanopi-m4-2gb-rk3399_defconfig        | 10 ----
 configs/nanopi-m4-rk3399_defconfig            | 10 ----
 configs/nanopi-m4b-rk3399_defconfig           | 10 ----
 configs/nanopi-neo4-rk3399_defconfig          | 10 ----
 configs/nanopi-r2c-plus-rk3328_defconfig      | 15 -----
 configs/nanopi-r2c-rk3328_defconfig           | 15 -----
 configs/nanopi-r2s-rk3328_defconfig           | 15 -----
 configs/nanopi-r4s-rk3399_defconfig           | 10 ----
 configs/nanopi-r5c-rk3568_defconfig           | 13 -----
 configs/nanopi-r5s-rk3568_defconfig           | 13 -----
 configs/neu6a-io-rk3588_defconfig             | 13 -----
 configs/neu6b-io-rk3588_defconfig             | 13 -----
 configs/odroid-m1-rk3568_defconfig            | 13 -----
 configs/orangepi-5-plus-rk3588_defconfig      | 13 -----
 configs/orangepi-5-rk3588s_defconfig          | 13 -----
 configs/orangepi-r1-plus-lts-rk3328_defconfig | 15 -----
 configs/orangepi-r1-plus-rk3328_defconfig     | 15 -----
 configs/orangepi-rk3399_defconfig             | 10 ----
 configs/pinebook-pro-rk3399_defconfig         | 10 ----
 configs/pinephone-pro-rk3399_defconfig        | 10 ----
 configs/quartz64-a-rk3566_defconfig           | 13 -----
 configs/quartz64-b-rk3566_defconfig           | 13 -----
 configs/quartzpro64-rk3588_defconfig          | 13 -----
 configs/radxa-cm3-io-rk3566_defconfig         | 13 -----
 configs/radxa-e25-rk3568_defconfig            | 13 -----
 configs/roc-cc-rk3308_defconfig               | 13 -----
 configs/roc-cc-rk3328_defconfig               | 15 -----
 configs/roc-pc-mezzanine-rk3399_defconfig     | 10 ----
 configs/roc-pc-rk3399_defconfig               | 10 ----
 configs/rock-3a-rk3568_defconfig              | 13 -----
 configs/rock-4c-plus-rk3399_defconfig         | 10 ----
 configs/rock-4se-rk3399_defconfig             | 10 ----
 configs/rock-pi-4-rk3399_defconfig            | 10 ----
 configs/rock-pi-4c-rk3399_defconfig           | 10 ----
 configs/rock-pi-e-rk3328_defconfig            | 17 ------
 configs/rock-pi-n10-rk3399pro_defconfig       | 10 ----
 configs/rock-pi-s-rk3308_defconfig            | 13 -----
 configs/rock5a-rk3588s_defconfig              | 13 -----
 configs/rock5b-rk3588_defconfig               | 13 -----
 configs/rock64-rk3328_defconfig               | 15 -----
 configs/rock960-rk3399_defconfig              | 10 ----
 configs/rockpro64-rk3399_defconfig            | 10 ----
 configs/soquartz-blade-rk3566_defconfig       | 13 -----
 configs/soquartz-cm4-rk3566_defconfig         | 13 -----
 configs/soquartz-model-a-rk3566_defconfig     | 13 -----
 configs/turing-rk1-rk3588_defconfig           | 13 -----
 70 files changed, 80 insertions(+), 782 deletions(-)

-- 
2.43.0

