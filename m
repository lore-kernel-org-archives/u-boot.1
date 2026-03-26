Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3650310AB800
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 18:41:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76FAA81E18;
	Thu, 26 Mar 2026 19:41:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=online.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A87A83E76; Thu, 26 Mar 2026 19:36:04 +0100 (CET)
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [IPv6:2a01:e0c:1:1599::13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01FB180517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 19:36:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=online.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=legoll@online.fr
Received: from [10.0.0.2] (unknown [82.65.243.93])
 (Authenticated sender: legoll@free.fr)
 by smtp4-g21.free.fr (Postfix) with ESMTPSA id AB65719F5BE;
 Thu, 26 Mar 2026 19:35:37 +0100 (CET)
Message-ID: <87d4cc89-e60a-4365-b6c0-efe5b20d0c7f@online.fr>
Date: Thu, 26 Mar 2026 19:35:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
In-Reply-To: <20260325223232.1553212-1-raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
From: Vincent Legoll <legoll@online.fr>
Subject: Re: [PATCH v3 00/16] Add board support for Spacemit K1 SoC in SPL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Mar 2026 19:41:50 +0100
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

Hello,

I wanted to try this series (applied to upstream u-boot, next branch),
but it failed to boot properly.

Note that I tried to follow instructions from:
Subject: [PATCH] doc: spacemit: add K1 SPL build and test guide
https://lore.kernel.org/u-boot/20260311073741.80616-1-guodong@riscstar.com/

But they looked wrong at times so I tried to guess what was intended.

Can someone see why it failed like that ?

Find the detailed description of what I did below:

## Get the repos

git clone https://github.com/u-boot/u-boot
git clone https://github.com/spacemit-com/spacemit-firmware
git clone https://gitee.com/bianbu-linux/uboot-2022.10 bianbu-uboot-2022.10

## Build u-boot

BUILD_PATH=$(pwd)
UBOOT_UPSTREAM_DIR="${BUILD_PATH}/u-boot"
UBOOT_BIANBU_DIR="${BUILD_PATH}/bianbu-uboot-2022.10"
SPACEMIT_FW_DIR="${BUILD_PATH}/spacemit-firmware"

cd "${UBOOT_UPSTREAM_DIR}"

git checkout -b spacemit-k1 upstream/next

# Grab the series link from:
# 
https://patchwork.ozlabs.org/project/uboot/patch/20260325223232.1553212-2-raymondmaoca@gmail.com/

curl https://patchwork.ozlabs.org/series/497518/mbox/ > 
Add-board-support-for-Spacemit-K1-SoC-in-SPL.patch
git am < Add-board-support-for-Spacemit-K1-SoC-in-SPL.patch

export CROSS_COMPILE=riscv64-linux-musl-
export ARCH=riscv
export DDR_FW_FILE="${SPACEMIT_FW_DIR}/k1/v0.2/ddr_fw.bin"

make spacemit_k1_defconfig
make -j $(nproc)

# Here the path to fsbl.json was not right
# See: 
https://gitee.com/spacemit-buildroot/uboot-2022.10/blob/k1-bl-v2.2.y/board/spacemit/k1-x/configs/fsbl.json

mkdir -p "${UBOOT_BIANBU_DIR}/spl_bin/configs"
sed 's/u-boot-spl\.bin/u-boot-spl-ddr.bin/g' \
   < "${UBOOT_BIANBU_DIR}/board/spacemit/k1-x/configs/fsbl.json" \
   > "${UBOOT_BIANBU_DIR}/spl_bin/configs/fsbl_ddr.json"

echo "Clean binaries in ${UBOOT_BIANBU_DIR}/spl_bin"
rm -f "${UBOOT_BIANBU_DIR}/spl_bin/u-boot-spl-ddr.bin"
rm -f "${UBOOT_BIANBU_DIR}/spl_bin/u-boot-spl.bin"

cp "${UBOOT_UPSTREAM_DIR}/u-boot-spl-ddr.bin" "${UBOOT_BIANBU_DIR}/spl_bin"

python3 "${UBOOT_BIANBU_DIR}/tools/build_binary_file.py" \
   -c "${UBOOT_BIANBU_DIR}/spl_bin/configs/fsbl_ddr.json" \
   -o "${UBOOT_BIANBU_DIR}/spl_bin/FSBL.bin"

# This created a FSBL.bin in the specified directory.

## Setup serial console, boot with FDL button pressed, then USB upload:

FSBL="${UBOOT_BIANBU_DIR}/spl_bin/FSBL.bin"

fastboot stage "${FSBL}"
fastboot continue

## Serial console output

sys: 0x1000
bm:2
ROM: usb download handler
usb2d_initialize : enter
Controller Run
usb rst int
SETUP: 0x80 0x6 0x100
usb rst int
SETUP: 0x0 0x5 0x1
SETUP: 0x80 0x6 0x100
SETUP: 0x80 0x6 0x200
SETUP: 0x80 0x6 0x200
SETUP: 0x80 0x6 0x300
SETUP: 0x80 0x6 0x302
SETUP: 0x80 0x6 0x301
SETUP: 0x80 0x6 0x30a
SETUP: 0x0 0x9 0x1
usb_rx_bytes : len= 4096 pBuf= 0xc0838720
SETUP: 0x80 0x6 0x302
SETUP: 0x80 0x6 0x304
fastboot_handle_command: max-download-size
usb_tx_bytes : len= 65 pBuf= 0xc083fe88
usb_rx_bytes : len= 4096 pBuf= 0xc0838720
fastboot_handle_command: 0001e860
Starting download of 125024 bytes
usb_tx_bytes : len= 65 pBuf= 0xc083fe88
usb_rx_bytes : len= 125024 pBuf= 0xc0800000
usb_tx_bytes : len= 65 pBuf= 0xc083fe88
usb_rx_bytes : len= 4096 pBuf= 0xc0838720
fastboot_handle_command: continue
usb_tx_bytes : len= 65 pBuf= 0xc083fe88
j...

<debug_uart>

U-Boot SPL 2026.04-rc4-00543-g2ba03a569e61 (Mar 26 2026 - 16:48:44 +0100)
Fail to detect board:-2
vdd_core, value:900000
vdd_1v8, value:1800000
vdd_1v8_mmc, value:500000
DDR firmware: [0xc08159c0]:0xf0227179, size:0x8d98
DDR is ready
SPL: Unsupported Boot Device!
SPL: failed to boot from all boot devices
### ERROR ### Please RESET the board ###

## More details

[bianbu-uboot-2022.10]$ git log --oneline -1
d61c8c77 (HEAD -> k1-bl-v2.2.y, tag: k1-bl-v2.2.9-release, 
origin/k1-bl-v2.2.y, origin/HEAD) Update for v2.2.9

[spacemit-firmware]$ git log --oneline -1
3eca456 (HEAD -> master, origin/master, origin/HEAD) Merge pull request 
#1 from docularxu/add-readme

$ ls -la $DDR_FW_FILE
-rw-r--r-- 1 user user 36248 Mar 26 16:38 
.../spacemit-firmware/k1/v0.2/ddr_fw.bin
$ sha256sum $DDR_FW_FILE
4ca729dae39580fe6d52ff6a1ead95fd18cd6394c942cc4a323882ccf2840148 
.../spacemit-firmware/k1/v0.2/ddr_fw.bin

[u-boot]$ git remote -v | grep upstream
upstream        https://source.denx.de/u-boot/u-boot.git (fetch)
upstream        https://source.denx.de/u-boot/u-boot.git (push)

$ git log --oneline upstream/next^..HEAD
2ba03a569e6 (HEAD -> spacemit-k1) board: k1: enable pmic in spl
d4b07728ec7 power: regulator: add support for Spacemit P1 SoC
698e1dac98b power: pmic: add support for Spacemit P1 PMIC
76b9c476576 spacemit: k1: Add DDR firmware support to SPL
d8bc52c01f2 spacemit: k1: add TLV EEPROM support in SPL
06ac4c0cc55 i2c: k1: add I2C driver support
29c9f971bbe configs: k1: add default option for clock driver in SPL
66fd60bea6e board: k1: initialize clock and serial devices in SPL
1c69ee27980 dts: k1: enable clocks in SPL
fdad5fdcc0d clk: spacemit: Add support for K1 SoC
0e4f554b274 dts: k1: import dts file from upstream folder
a8cd1f828c4 dt-bindings: clock: import k1-syscon from upstream
0dd6c089190 reset: k1: remove TWSI8 reset restriction
a46bdb334d7 configs: k1: enable early timer support
052c15d331a spacemit: k1: enable SPL with debug UART
25905d01c7e spacemit: k1: support multi-board infrastructure
8813d74163e (upstream/next, upstream/WIP/25Mar2026-next, origin/next, 
origin/WIP/25Mar2026-next) Merge patch series "test/py: gpio: cleanups 
and improvement"
0f101dac8fb test/py: gpio: allow omitting gpio_op_pin
908db6c647c test/py: gpio: removing trailing semicolons
b02b0a0c6cb test/py: gpio: remove unused imports

Thanks

PS: I just (re-)subscribed to the list. I tried to get the email 
threading right, hopefully it'll work.
