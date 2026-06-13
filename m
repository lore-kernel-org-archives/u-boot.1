Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1864CD98C5
	for <u-boot@archiver.kernel.org>; Sat, 13 Jun 2026 13:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DDDE84908;
	Sat, 13 Jun 2026 15:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="tC2wwVvL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D2CC8063E; Sat, 13 Jun 2026 10:50:21 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A40AA80287
 for <u-boot@lists.denx.de>; Sat, 13 Jun 2026 10:50:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=1df1=EJ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1781340617;
 bh=wc+bD3ZGFP6qbVuprSYvJOMd/eqxbCB2Iq4RKegaiOk=;
 b=tC2wwVvLUKnc4Cx6fSt6GzTtZNya2QUZTee8QSa3vzGjXyHoWl8fpQxWj6J2Z5PDvsx956Qwh
 vu2v0X6F0veAx+M2Tr9IIT72rMCDXgOIQUx91lT9+8EheE2CaQEiIU+FV8wdXEnvnTfzEX8mMhB
 uQZIvj1X755raUxaFIYOjlx6Q7VaxKGAydLbq3jQk6a6VJJsWqQGWVAdgAy6CVj6KOc9ITs9C7v
 Pq+liw7IkCuBEbdchPxN4+No4Z9b8HK1edJdpIzyWGEq5i7jH4iplgWAN5UcgzMSWnI+ZA6RgQm
 Mpc0VhJKWzouRs6eO3afFZ+tSWfeD/8BpicUpo81nPJA==
X-Forward-Email-ID: 6a2d19c79b8e0435f022bdc0
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.8.26
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c158dc50-0082-4404-bba4-a4bc21761587@kwiboo.se>
Date: Sat, 13 Jun 2026 10:50:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/22] VBE serial part H: Implement VBE on Rockchip
 RK3399
To: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Adriano Cordova <adrianox@gmail.com>, Alexey Charkov <alchark@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Chris Morgan <macromorgan@hotmail.com>, FUKAUMI Naoki <naoki@radxa.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Klaus Goger <klaus.goger@cherry.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Niu Zhihong <zhihong@nzhnb.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Raymond Mao <raymondmaoca@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Tianling Shen <cnsztl@gmail.com>, Tien Fong Chee
 <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
References: <20260528171043.910264-1-sjg@chromium.org>
 <CAFLszTgQaFpgixZKie9aURFvC3D7bW2AcvBB6XGdGht_JDSWHA@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAFLszTgQaFpgixZKie9aURFvC3D7bW2AcvBB6XGdGht_JDSWHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sat, 13 Jun 2026 15:22:52 +0200
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

Hi Simon,

On 6/12/2026 9:39 PM, Simon Glass wrote:
> Hi Jonas and Quentin,
> 
> On Thu, 28 May 2026 at 11:10, Simon Glass <sjg@chromium.org> wrote:
>>
>> This series largely completes the work to enable VBE on a suitable
>> board. Most of it is rockchip-specific patches to support the VPL phase,
>> i.e. the one which decides which boot patch to take (A, B or recovery).
>>
>> A good chunk of this series is adding an image for VBE, by creating a
>> new Binman image. Future work in Binman may make this more automated /
>> easier, but for now it is written out in full. The work is undertaken
>> piecemeal so it is easier to review the steps.
>>
>> VBE allows similar boards to share firmware images, with perhaps just
>> TPL (around 75K) being different for each board. Using a common image
>> for VPL, SPL and U-Boot saves a lot of space in the image and makes
>> builds easier. Perhaps more importantly it means that both SPL and
>> U-Boot proper can be safely updated (with VBE's A/B mechanism) in the
>> field.
>>
>> Of course, each board still needs a separate devicetree.
>>
>> The current bloblist implementation has a few problems which need to be
>> resolved. I will sort this out separately so as to coordinate with
>> Ilias' global_data changes.
>>
>> Here is the layout of the image:
>>
>> Name                          Image-pos  Size      Entry-type          Offset    Uncomp-size
>> ----------------------------------------------------------------------------------------------
>> image                                 0   1b960cf  section                    0
>>   alternates-fdt                   8000     31000  alternates-fdt          8000
>>     mkimage                        8000     31000  mkimage                    0
>>       u-boot-tpl                   8048     12a11  u-boot-tpl                48
>>   vpl                            208000     16200  fit                   208000
>>     image-vpl                    209400      a5a3  section                 1400
>>       section                    209400      a5a3  section                    0
>>         u-boot-vpl-nodtb                    10348  u-boot-vpl-nodtb           0
>>         u-boot-vpl-bss-pad                     20  u-boot-vpl-bss-pad     10348
>>     @fdt-SEQ                          0         0  section                    0
>>   vbe-a                          800000    39b200  section               800000
>>     spl-a                        800000    100000  fit                        0
>>       spl                        801400     10c97  section                 1400
>>         section                  801400     10c97  section                    0
>>           u-boot-spl-nodtb                  1a908  u-boot-spl-nodtb           0
>>           u-boot-spl-bss-pad                  1b0  u-boot-spl-bss-pad     1a908
>>       @fdt-SEQ                        0         0  section                    0
>>     u-boot-a                     900000    29b200  fit                   100000
>>       spl                        902400     10c97  section                 2400
>>         section                  902400     10c97  section                    0
>>           u-boot-spl-nodtb                  1a908  u-boot-spl-nodtb           0
>>           u-boot-spl-bss-pad                  1b0  u-boot-spl-bss-pad     1a908
>>       u-boot                     913200     e4250  section                13200
>>         u-boot-nodtb             913200     e4250  u-boot-nodtb               0
>>       @atf-SEQ                        0         0  section                    0
>>         atf-bl31                      0         0  atf-bl31                   0
>>       @tee-SEQ                        0         0  section                    0
>>         tee-os                        0         0  tee-os                     0
>>       @fdt-SEQ                        0         0  section                    0
>>   vbe-b                         1000000    39b200  section              1000000
>>     spl-b                       1000000    100000  fit                        0
>>       spl                       1001400     10c97  section                 1400
>>         section                 1001400     10c97  section                    0
>>           u-boot-spl-nodtb                  1a908  u-boot-spl-nodtb           0
>>           u-boot-spl-bss-pad                  1b0  u-boot-spl-bss-pad     1a908
>>       @fdt-SEQ                        0         0  section                    0
>>     u-boot-b                    1100000    29b200  fit                   100000
>>       spl                       1102400     10c97  section                 2400
>>         section                 1102400     10c97  section                    0
>>           u-boot-spl-nodtb                  1a908  u-boot-spl-nodtb           0
>>           u-boot-spl-bss-pad                  1b0  u-boot-spl-bss-pad     1a908
>>       u-boot                    1113200     e4250  section                13200
>>         u-boot-nodtb            1113200     e4250  u-boot-nodtb               0
>>       @atf-SEQ                        0         0  section                    0
>>         atf-bl31                      0         0  atf-bl31                   0
>>       @tee-SEQ                        0         0  section                    0
>>         tee-os                        0         0  tee-os                     0
>>       @fdt-SEQ                        0         0  section                    0
>>   vbe-recovery                  1800000    39b200  section              1800000
>>     spl-recovery                1800000    100000  fit                        0
>>       spl                       1801400     10c97  section                 1400
>>         section                 1801400     10c97  section                    0
>>           u-boot-spl-nodtb                  1a908  u-boot-spl-nodtb           0
>>           u-boot-spl-bss-pad                  1b0  u-boot-spl-bss-pad     1a908
>>       @fdt-SEQ                        0         0  section                    0
>>     u-boot-recovery             1900000    29b200  fit                   100000
>>       spl                       1902400     10c97  section                 2400
>>         section                 1902400     10c97  section                    0
>>           u-boot-spl-nodtb                  1a908  u-boot-spl-nodtb           0
>>           u-boot-spl-bss-pad                  1b0  u-boot-spl-bss-pad     1a908
>>       u-boot                    1913200     e4250  section                13200
>>         u-boot-nodtb            1913200     e4250  u-boot-nodtb               0
>>       @atf-SEQ                        0         0  section                    0
>>         atf-bl31                      0         0  atf-bl31                   0
>>       @tee-SEQ                        0         0  section                    0
>>         tee-os                        0         0  tee-os                     0
>>       @fdt-SEQ                        0         0  section                    0
>>   fdtmap                        1b9b200      2ecf  fdtmap               1b9b200
>>
>> Here is an example boot:
>>
>>   $ ub-int vbe
>>   Building U-Boot in sourcedir for rk3399-generic-ddr3
>>   Bootstrapping U-Boot from dir /tmp/b/rk3399-generic-ddr3
>>   Writing U-Boot using method rockchip
>>
>>   U-Boot TPL 2026.07-rc3-00184-g311970460601 (May 28 2026 - 09:23:10)
>>   Trying to boot from vbe_abrec
>>   load: Firefly-RK3399 Board
>>   ## Loading firmware (any) from FIT Image at ff8ecb38 ...
>>      Using 'config-7' configuration
>>      Trying 'image-vpl' firmware subimage
>>   ## Loading fdt (any) from FIT Image at ff8ecb38 ...
>>      Using 'config-7' configuration
>>      Trying 'fdt-7' fdt subimage
>>
>>   U-Boot VPL 2026.07-rc3-00184-g311970460601 (May 28 2026 - 09:23:10)
>>   Trying to boot from vbe_abrec
>>   load: Firefly-RK3399 Board
>>   Starting with empty state
>>   VBE: Firmware pick A at 800000
>>   ## Loading firmware (SPL Phase) from FIT Image at ff8ec858 ...
>>      Using 'config-7' configuration
>>      Trying 'spl' firmware subimage
>>   ## Loading fdt (SPL Phase) from FIT Image at ff8ec858 ...
>>      Using 'config-7' configuration
>>      Trying 'fdt-7' fdt subimage
>>   Channel 0: DDR3, 800MHz
>>   BW=32 Col=10 Bk=8 CS0 Row=15 CS1 Row=15 CS=2 Die BW=16 Size=2048MB
>>   Channel 1: DDR3, 800MHz
>>   BW=32 Col=10 Bk=8 CS0 Row=15 CS1 Row=15 CS=2 Die BW=16 Size=2048MB
>>   256B stride
>>
>>   U-Boot SPL 2026.07-rc3-00184-g311970460601 (May 28 2026 - 09:23:10 -0600)
>>   Trying to boot from vbe_abrec
>>   load: Firefly-RK3399 Board
>>   VBE: Firmware pick A at 900000
>>   ## Checking hash(es) for config config-7 ... OK
>>   ## Checking hash(es) for Image atf-1 ... sha256+ OK
>>   ## Checking hash(es) for Image u-boot ... sha256+ OK
>>   ## Checking hash(es) for Image fdt-7 ... sha256+ OK
>>   ## Checking hash(es) for Image fdt-7 ... sha256+ OK
>>   ## Checking hash(es) for Image atf-2 ... sha256+ OK
>>   ## Checking hash(es) for Image atf-3 ... sha256+ OK
>>   ## Checking hash(es) for Image atf-4 ... sha256+ OK
>>   load_simple_fit: Skip load 'atf-5': image size is 0!
>>   ## Checking hash(es) for Image tee-1 ... sha256+ OK
>>   ns16550_serial serial@ff1a0000: pinctrl_select_state_full: uclass_get_device_by_phandle_id: err=-19
>>
>>   U-Boot 2026.07-rc3-00184-g311970460601 (May 28 2026 - 09:23:10 -0600)
>>
>>   SoC: Rockchip rk3399
>>   Reset cause: POR
>>   Model: Firefly-RK3399 Board
>>   DRAM:  4 GiB (total 3.9 GiB)
>>   PMIC:  RK808
>>   Core:  307 devices, 32 uclasses, devicetree: separate
>>   MMC:   mmc@fe310000: 3, mmc@fe320000: 1, mmc@fe330000: 0
>>   Loading Environment from MMC... Reading from MMC(0)... *** Warning - bad CRC, using default environment
>>
>>   In:    serial,usbkbd
>>   Out:   serial,vidconsole
>>   Err:   serial,vidconsole
>>   Model: Firefly-RK3399 Board
>>   Net:   eth0: ethernet@fe300000
>>
>>   Hit any key to stop autoboot: 0
>>   Scanning for bootflows in all bootdevs
>>   Seq  Method       State   Uclass    Part  Name                      Filename
>>   ---  -----------  ------  --------  ----  ------------------------  ----------------
>>   Scanning global bootmeth 'firmware0':
>>   Scanning bootdev 'mmc@fe320000.bootdev':
>>   Scanning bootdev 'mmc@fe330000.bootdev':
>>   rockchip_pcie pcie@f8000000: PCIe link training gen1 timeout!
>>   Unknown uclass 'scsi' in label
>>   USB EHCI 1.00
>>   USB EHCI 1.00
>>   USB XHCI 1.10
>>   Bus usb@fe380000: 1 USB Device(s) found
>>   Bus usb@fe3c0000: 2 USB Device(s) found
>>   Bus usb@fe900000: 1 USB Device(s) found
>>   rockchip_pcie pcie@f8000000: PCIe link training gen1 timeout!
>>   Scanning bootdev 'ethernet@fe300000.bootdev':
>>   Scanning bootdev 'ethernet@fe300000.bootdev':
>>   Scanning global bootmeth 'firmware0':
>>   ---  -----------  ------  --------  ----  ------------------------  ----------------
>>   (0 bootflows, 0 valid)
>>   => vbe state
>>   Phases: TPL (margin 91bb)  VPL (margin 231e)  SPL
>>
>> This is (mostly) the final VBE series, but there are a few loose ends to
>> tidy up:
>>
>> - pinctrl init needs to be tidied up to avoid warnings
>> - bloblist logic as mentioned above
>>
>> Other things may become apparently after more usage / testing.
>>
>> Changes in v8:
>> - Drop bloblist changes
>> - Update cover letter and add an example boot
>>
>> Changes in v6:
>> - Update CONFIG_SPL_PAD_TO for puma-rk3399 and ringneck-px30
>>
>> Changes in v5:
>> - Drop stray #endif
>> - Drop removal of stray #ifdef
>> - Mention VBE in the first paragraph of the commit message
>> - Wrap the entire simple-bin node and add the properties to vpl
>> - Expand commit message to mention VBE
>> - Move  SUPPORT_VPL next to other SUPPORT_xxx options
>> - Put TPL_DM_MMC in alpha order
>> - Move VPL_ROCKCHIP_COMMON_BOARD up a bit
>> - Move VPL_LDSCRIPT up a bit
>> - Drop config SPL_STACK_R_ADDR
>> - Use if() instead of ? in spl_boot_device()
>> - Drop mention of SPL_RAW_IMAGE_SUPPORT since it is already the default
>> - Drop mention of SPL_SEPARATE_BSS since VPL doesn't need it
>> - Drop duplicate __image_copy_start and __image_copy_end
>> - Drop unwanted comment in script
>> - Reword first paragraph to mention bloblist instead of other stacks
>> - Add value for CONFIG_SPL_STACK_R_ADDR
>> - Add to VPL file also
>>
>> Changes in v4:
>> - Use FIT_ARCH instead of ARCH
>> - Use FIT_ARCH instead of ARCH
>> - Use FIT_ARCH instead of ARCH
>> - Use fit_template instead of common_part
>> - Put the fdtmap at the end of the image
>> - Update the comment at the end of the '#ifndef CONFIG_VPL' block
>> - Add a value for SPL_STACK_R_ADDR
>> - Drop SPL_PAD_TO value since the default is fine
>> - Drop ROCKCHIP_IODOMAIN since it is the default
>> - Add SPL_LIBCOMMON_SUPPORT and SPL_LIBGENERIC_SUPPORT
>>
>> Changes in v3:
>> - Add blank lines before the node
>> - Add a comment about the offsets
>> - Move template to the vpl file
>> - Unindent bootph tags
>>
>> Changes in v2:
>> - Move VPL things into a separate file
>> - Move VPL things into a separate file
>> - Move VPL things into a separate file
>> - Mention RK3399 with respect to the memory limit
>> - Move VPL things into a separate file
>> - Only enable MMC when VPM is in use.
>> - Rewrite help for VPL_ROCKCHIP_COMMON_BOARD
>> - Skip spl-boot-order.c for VPL (rather than modifying it)
>> - Reword commit to mention comments from Jonas
>> - Rename to rk3399-generic-ddr3
>> - Update devicetree to match firefly-rk3399
>> - Use the firefly devicetree as the default for this board
>> - Move this patch to the end of the series
>> - Drop 0x8000 offset for SPI
>> - Add new patch with a bootmeth driver for abrec
>> - Split out the fixes for skip-at-start into a new patch
>>
>> Simon Glass (22):
>>   spl: Adjust xPL symbols
>>   spl: Allow VBE to handle xPL size
>>   vbe: Show the margin when using SPL_RELOC
>>   rockchip: Allow RAM init to happen in SPL on rk3399
>>   rockchip: dts: Add an fdtmap
>>   rockchip: dts: Specify the phase in the image
>>   rockchip: Provide a bootstd configuration
>>   rockchip: Add SPL into the main FIT
>>   rockchip: Add a template for SPL
>>   rockchip: Add a VPL image
>>   rockchip: Add TPL alternatives
>>   rockchip: Update rk3399 bootph-tags for VPL
>>   rockchip: Provide a VPL phase on rk3399
>>   rockchip: Add symbols for spl_reloc
>>   rockchip: rk3399: Adjust TPL stack to allow for bloblist
>>   rockchip: Allow SPL to set up SDRAM
>>   rockchip: Add a generic-ddr3 rk3399 board
>>   rockchip: Add documentation for VBE
>>   gitlab: Add an VBE board to the sjg lab
>>   rockchip: Set the skip-at-start property correctly
>>   vbe: Add a bootmeth driver for abrec
>>   rockchip: Update binman image for new skip-at-start setup
>>
>>  .gitlab-ci.yml                           |   6 +
>>  arch/arm/dts/rk3399-u-boot.dtsi          |   9 +
>>  arch/arm/dts/rockchip-u-boot.dtsi        |  17 ++
>>  arch/arm/dts/rockchip-vpl-u-boot.dtsi    | 224 +++++++++++++++++++++++
>>  arch/arm/include/asm/spl.h               |   1 +
>>  arch/arm/mach-rockchip/Kconfig           |  23 ++-
>>  arch/arm/mach-rockchip/Makefile          |  11 +-
>>  arch/arm/mach-rockchip/rk3399/Kconfig    |  11 +-
>>  arch/arm/mach-rockchip/spl.c             |   3 +
>>  arch/arm/mach-rockchip/tpl.c             |  13 +-
>>  arch/arm/mach-rockchip/u-boot-tpl-v8.lds |  10 +
>>  arch/arm/mach-rockchip/u-boot-vpl-v8.lds | 107 +++++++++++
>>  arch/arm/mach-rockchip/vpl.c             |  53 ++++++
>>  board/rockchip/evb_rk3399/MAINTAINERS    |   6 +
>>  boot/vbe_abrec.c                         |  99 ++++++++++
>>  cmd/vbe.c                                |   8 +-
>>  common/spl/Kconfig                       |   3 +-
>>  common/spl/spl.c                         |   2 +
>>  common/spl/spl_reloc.c                   |  14 +-
>>  configs/puma-rk3399_defconfig            |   2 +-
>>  configs/ringneck-px30_defconfig          |   2 +-
>>  configs/rk3399-generic-ddr3_defconfig    | 126 +++++++++++++
>>  doc/board/rockchip/rockchip.rst          |  13 ++
>>  drivers/ram/rockchip/sdram_rk3399.c      |   6 +-
>>  include/vbe.h                            |   3 +
>>  25 files changed, 753 insertions(+), 19 deletions(-)
>>  create mode 100644 arch/arm/dts/rockchip-vpl-u-boot.dtsi
>>  create mode 100644 arch/arm/mach-rockchip/u-boot-vpl-v8.lds
>>  create mode 100644 arch/arm/mach-rockchip/vpl.c
>>  create mode 100644 configs/rk3399-generic-ddr3_defconfig
>>
>> ---
>> base-commit: 746a986fe247fc0b3d52ad7ae7027e0a6d57d12c
>> branch: vbi-us7
>>
>> --
>> 2.43.0
>>
> 
> Do you have any thoughts on this series? I would very much like to get
> an example VBE implementation into mainline, if possible.

I should be able take a deeper look next week or the week after that.
At least this version applied cleanly on mainline U-Boot ;-)

Regards,
Jonas

> 
> Regards,
> Simon

