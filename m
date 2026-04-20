Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57723F588C1
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 12:54:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D20AB8435C;
	Mon, 20 Apr 2026 14:54:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="dmAQFPRa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23D9C84314; Mon, 20 Apr 2026 13:36:33 +0200 (CEST)
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::bc0d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83C5883E16
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 13:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fzk321BcGz19Xp;
 Mon, 20 Apr 2026 13:36:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1776684988;
 bh=AraFzYJrSTx7CiHhLSPO4a/Nql3YJst3F5wHLmj5ybA=;
 h=From:Subject:Date:To:Cc:From;
 b=dmAQFPRaoiCEs83PvpyuL9kkQEyeMbDoDF13vuztuyBvbnjPUfHyqqRuzIIwSO6Fh
 GoOVlx3rFHh8ZhPU8Xhr7EBltPylUGQjzA6tSCWq20NNXuKg50dKWcvmO23wjcf9iS
 DxCrORkNtzlcP3sItIx/YLBx+U23r+SsThKZyfQqnivQ1IpmXgOyzfyhiSc6JfnHPm
 zdcNLthVMgGkRjCzHNsei/x7QtMCTz+7qag2MvzRjMELPUe6CRV38LcJaaTy1i0fzb
 vh4NLA4AjZMzlHjCN9EdTSNLfR7YtxLmtnwrkpZpcybwmymBIUh4OwqJYneaXyh4ZR
 I57mf+Stt2ong==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4fzk2q2Zt5zTv0; Mon, 20 Apr 2026 13:36:19 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/6] net: migrate NO_NET out of the networking stack choice
Date: Mon, 20 Apr 2026 13:36:06 +0200
Message-Id: <20260420-net-kconfig-v1-0-9900002d8e72@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDI0Mz3bzUEt3s5Py8tMx0XYM0M+MUy5RUc0OzJCWgjoKi1LTMCrBp0bG
 1tQDDDeCPXQAAAA==
X-Change-ID: 20251216-net-kconfig-0f63d9de716b
To: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com, 
 Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Udit Kumar <u-kumar1@ti.com>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Adam Ford <aford173@gmail.com>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Matteo Lisi <matteo.lisi@engicam.com>, Tim Harvey <tharvey@gateworks.com>, 
 Mingkai Hu <mingkai.hu@nxp.com>, Pramod Kumar <pramod.kumar_1@nxp.com>, 
 Gilles Talis <gilles.talis@gmail.com>, Le Jin <le.jin@siemens.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, Stefan Roese <sr@denx.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, 
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marex@denx.de>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Yao Zi <me@ziyao.cc>, Fabio Estevam <festevam@gmail.com>, 
 Alice Guo <alice.guo@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Maarten Brock <Maarten.Brock@sttls.nl>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Padmarao Begari <padmarao.begari@amd.com>, 
 Matthias Brugger <mbrugger@suse.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Brian Sune <briansune@gmail.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Ben Dooks <ben.dooks@codethink.co.uk>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Anshul Dalal <anshuld@ti.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>, 
 Andreas Dannenberg <dannenberg@ti.com>, Chintan Vankar <c-vankar@ti.com>, 
 Martin Schwan <m.schwan@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>, 
 David Lechner <dlechner@baylibre.com>, 
 Ariel D'Alessandro <ariel.dalessandro@collabora.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Robert Marko <robert.marko@sartura.hr>, Beiyan Yun <root@infi.wang>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Benjamin ROBIN <dev@benjarobin.fr>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>, 
 Sean Edmond <seanedmond@microsoft.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Shantur Rathore <i@shantur.com>, 
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>, 
 Adriano Cordova <adrianox@gmail.com>, 
 Sky Huang <SkyLake.Huang@mediatek.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
X-Mailman-Approved-At: Mon, 20 Apr 2026 14:54:20 +0200
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

This migrates the net options away from the main Kconfig to net/Kconfig,
rename the current NET option to NET_LEGACY to really highlight what it
is and hopefully encourage more people to use lwIP, add a new NET
menuconfig (but keep NO_NET as an alias to NET=n for now) which then
allows us to replace all the "if legacy_stack || lwip_stack" checks with
"if net_support" which is easier to read and maintain.

The only doubt I have is wrt SYS_RX_ETH_BUFFER which seems to be needed
for now even when no network is configured? Likely due to
include/net-common.h with PKTBUFSRX?

No change in behavior is intended. Only change in defconfig including
other defconfigs where NO_NET=y or NET is not set, in which case NO_NET
is not set or NET=y should be set in the top defconfig. Similar change
required for config fragments. See commit log in patch adding NET
menuconfig for details.

This was tested based on 70fd0c3bb7c2 ("x86: there is no
CONFIG_UBOOT_ROMSIZE_KB_12288"), from within the GitLab CI container
trini/u-boot-gitlab-ci-runner:noble-20251013-23Jan2026 and set up
similarly as in "build all platforms in a single job" GitLab CI job.

 #!/usr/bin/env bash
 set -o pipefail
 set -eux
 
 ARGS="-BvelPEWM --reproducible-builds --step 0"
 ./tools/buildman/buildman -o ${O} --force-build $ARGS -CE $*
 ./tools/buildman/buildman -o ${O} $ARGS -Ssd $*

O=../build/u-boot/ ../u-boot.sh -b master^..b4/net-kconfig |& tee ../log.txt

I can't really decipher the log.txt, but there's no line starting with
+ which would be an error according to tools/buildman/builder.py help
text. Additionally, because I started the script with set -e set and
because buildman has an exit code != 0 when it fails to build a board,
and I have the summary printed (which is the second buildman call), I
believe it means all builds passed.

The summary is the following:
   aarch64: (for 537/537 boards) all +0.0 rodata +0.0
            uniphier_v8    : all +1 rodata +1
               u-boot: add: 0/0, grow: 1/0 bytes: 1/0 (1)
                 function                                   old     new   delta
                 data_gz                                  10640   10641      +1
       arm: (for 733/733 boards) all -0.0 rodata -0.0
            uniphier_v7    : all -1 rodata -1
               u-boot: add: 0/0, grow: 0/-1 bytes: 0/-1 (-1)
                 function                                   old     new   delta
                 data_gz                                  11919   11918      -1
            opos6uldev     : all -3 rodata -3
               u-boot: add: 0/0, grow: 0/-1 bytes: 0/-3 (-3)
                 function                                   old     new   delta
                 data_gz                                  18778   18775      -3
            uniphier_ld4_sld8: all -3 rodata -3
               u-boot: add: 0/0, grow: 0/-1 bytes: 0/-3 (-3)
                 function                                   old     new   delta
                 data_gz                                  11276   11273      -3
            stemmy         : all -20 rodata -20
               u-boot: add: 0/0, grow: 0/-1 bytes: 0/-20 (-20)
                 function                                   old     new   delta
                 data_gz                                  15783   15763     -20

As far as I could tell this data_gz is an automatically generated array
when CONFIG_CMD_CONFIG is enabled. It is the compressed .config stored
in binary form. Because I'm changing the name of symbols, replacing a
menu with a menuconfig, additional text makes it to .config and the
"# Networking" section in .config disappears.

Here is the diff for the 5 defconfigs listed above, generated with:

for f in build/*-m; do
	diff --unified=0 $f/.config $(dirname $f)/$(basename -a -s '-m' $f)/.config
done

(-m is the build directory for master, and without the suffix, it's the
top commit of this series)

"""
 --- build/opos6uldev-m/.config	2026-04-20 10:53:49.804528526 +0200
 +++ build/opos6uldev/.config	2026-04-20 11:03:37.430242767 +0200
 @@ -970,4 +969,0 @@
 -
 -#
 -# Networking
 -#
 @@ -975,0 +972 @@
 +CONFIG_NET_LEGACY=y
 --- build/stemmy-m/.config	2026-04-20 11:01:33.653698123 +0200
 +++ build/stemmy/.config	2026-04-20 11:04:53.452577311 +0200
 @@ -733,4 +732,0 @@
 -
 -#
 -# Networking
 -#
 @@ -738,2 +733,0 @@
 -# CONFIG_NET is not set
 -# CONFIG_NET_LWIP is not set
 --- build/uniphier_ld4_sld8-m/.config	2026-04-20 11:00:41.605469071 +0200
 +++ build/uniphier_ld4_sld8/.config	2026-04-20 11:04:22.226439899 +0200
 @@ -997,4 +996,0 @@
 -
 -#
 -# Networking
 -#
 @@ -1002,0 +999 @@
 +CONFIG_NET_LEGACY=y
 --- build/uniphier_v7-m/.config	2026-04-20 10:53:04.019307319 +0200
 +++ build/uniphier_v7/.config	2026-04-20 11:03:01.688085486 +0200
 @@ -1004,4 +1003,0 @@
 -
 -#
 -# Networking
 -#
 @@ -1009,0 +1006 @@
 +CONFIG_NET_LEGACY=y
 --- build/uniphier_v8-m/.config	2026-04-20 10:43:05.614441175 +0200
 +++ build/uniphier_v8/.config	2026-04-20 10:41:03.214852130 +0200
 @@ -875,4 +874,0 @@
 -
 -#
 -# Networking
 -#
 @@ -880,0 +877 @@
 +CONFIG_NET_LEGACY=y
"""

This is fine:
- Networking menu doesn't exist anymore so "#\n# Networking\n#\n" won't
  be in .config anymore.
- opos6uldev, uniphier_ld4_sld8, uniphier_v7 and uniphier_v8 all have
  (old) CONFIG_NET enabled, (new) CONFIG_NET will still be set but
  CONFIG_NET_LEGACY also needs to be defined now to reflect the stack
  choice (even if default),
- stemmy has CONFIG_NO_NET set, which means CONFIG_NET and
  CONFIG_NET_LWIP are not reachable anymore hence why they don't need to
  be part of .config,

GitLab CI was run on this series (well, not exactly, but it's only
changes to the git logs that were made):
https://source.denx.de/u-boot/contributors/qschulz/u-boot/-/pipelines/29849

It passes.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (6):
      move networking menu in net/Kconfig
      rename NET to NET_LEGACY
      net: make NET a menuconfig (and downgrade NO_NET to a simple config)
      simplify NET_LEGACY || NET_LWIP condition with NET condition
      doc: remove mention to non-existing TPL_NET
      boot: remove NO_NET use

 Kconfig                                            | 34 ----------------
 Makefile                                           |  4 +-
 arch/arm/mach-stm32mp/soc.c                        |  2 +-
 board/beacon/imx8mp/imx8mp_beacon.c                |  2 +-
 board/engicam/imx8mp/icore_mx8mp.c                 |  2 +-
 board/gateworks/venice/venice.c                    |  4 +-
 board/nxp/ls1043ardb/Makefile                      |  2 +-
 board/nxp/ls1046afrwy/Makefile                     |  2 +-
 board/nxp/ls1046ardb/Makefile                      |  2 +-
 .../imx8mp_debix_model_a/imx8mp_debix_model_a.c    |  2 +-
 board/siemens/iot2050/board.c                      |  2 +-
 board/sophgo/milkv_duo/Makefile                    |  2 +-
 board/sophgo/milkv_duo/board.c                     |  2 +-
 board/theadorable/theadorable.c                    |  4 +-
 board/ti/am335x/board.c                            |  2 +-
 board/toradex/verdin-imx8mp/verdin-imx8mp.c        |  2 +-
 board/xilinx/common/board.c                        |  3 +-
 boot/Kconfig                                       |  8 ++--
 cmd/Kconfig                                        | 12 +++---
 cmd/Makefile                                       |  2 +-
 cmd/bdinfo.c                                       |  7 ++--
 cmd/fastboot.c                                     |  4 +-
 cmd/ufetch.c                                       |  2 +-
 common/Kconfig                                     |  2 +-
 common/board_r.c                                   |  4 +-
 common/spl/Kconfig                                 |  5 ++-
 configs/am62px_evm_r5_ethboot_defconfig            |  2 +-
 configs/j722s_evm_r5_ethboot_defconfig             |  2 +-
 doc/develop/bootstd/overview.rst                   |  2 +-
 doc/develop/pytest/usage.rst                       |  4 +-
 doc/usage/cmd/bdinfo.rst                           |  7 ++--
 doc/usage/cmd/sntp.rst                             |  2 +-
 doc/usage/cmd/wget.rst                             |  2 +-
 doc/usage/spl_boot.rst                             |  2 +-
 drivers/dfu/Kconfig                                |  2 +-
 drivers/fastboot/Kconfig                           |  4 +-
 drivers/fastboot/fb_common.c                       |  4 +-
 drivers/net/Kconfig                                |  6 +--
 drivers/net/phy/Kconfig                            |  4 +-
 drivers/net/sandbox.c                              |  2 +-
 drivers/usb/gadget/Kconfig                         |  2 +-
 env/flags.c                                        | 10 ++---
 include/configs/stm32mp15_common.h                 |  2 +-
 include/configs/stm32mp23_common.h                 |  2 +-
 include/configs/stm32mp25_common.h                 |  2 +-
 include/env_callback.h                             |  2 +-
 include/env_flags.h                                |  6 +--
 include/net-common.h                               |  4 +-
 include/net-legacy.h                               |  2 +-
 lib/Kconfig                                        |  2 +-
 lib/efi_loader/Kconfig                             |  4 +-
 net/Kconfig                                        | 45 +++++++++++++++++++---
 net/Makefile                                       |  6 +--
 test/cmd/Makefile                                  |  2 +-
 test/cmd/bdinfo.c                                  |  6 +--
 test/dm/eth.c                                      |  6 +--
 test/py/tests/test_efi_fit.py                      |  2 +-
 test/py/tests/test_efi_loader.py                   |  2 +-
 test/py/tests/test_fpga.py                         |  4 +-
 test/py/tests/test_net.py                          |  2 +-
 60 files changed, 139 insertions(+), 138 deletions(-)
---
base-commit: 70fd0c3bb7c26d42f24d10145dd5f3168ac92eac
change-id: 20251216-net-kconfig-0f63d9de716b

Best regards,
--  
Quentin Schulz <quentin.schulz@cherry.de>

