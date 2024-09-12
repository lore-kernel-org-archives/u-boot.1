Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E93EE57FB
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:05:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E623488E71;
	Thu, 12 Sep 2024 03:02:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c3+OLs+1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 013FC88E70; Thu, 12 Sep 2024 03:02:07 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76B7E88D09
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:02:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-718f4fd89e5so326050b3a.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102921; x=1726707721; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0OOZlv+/JtZYO/IoFzOPMFHegm3baRh9xpd1jzedPFs=;
 b=c3+OLs+1pkUoq20A17fM7F1EoywPscNFqGO6XwEYw7VS4bfadC7yugqWCT7c36bj4q
 326HL/7mSWq3gZNKkMTafc6WtmZF+MKHh3N8TFcHsaVuEXS4tJddbKScmyOV1tvvHzJW
 Py36eXj4ChfGnLWoB+sOvDMMFYuuqXjVMW2ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102921; x=1726707721;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0OOZlv+/JtZYO/IoFzOPMFHegm3baRh9xpd1jzedPFs=;
 b=xJLx3Vmjq/r3GWyEnXcOAjaFTNroC8XbbO9JpRNvKYk7YJAhAijm+njlw50ii/V6P9
 KQA4XfqHl5OQnb6P+9KXyZv7BCb5VzuzR1hMH+gKEG2fUDFR42MdE8cMmu6CQT+KIFjh
 pgcp5svm8LT5jeAyR3Fi8kBACePPWRpiz9ofIDWpSkDlzBSrFV45nM7ZsmoTmNhx8VGk
 vgXeG9ScMAd20X+msskihpXvfFwPsYfNJMv+4+TgqgE4xG75kOFBQN43J1eomKap7RVf
 C7Gla+9tCXhDJY9LThN23J37U7lFLr73fcPVBGjRyi4Uq9OOtLN3zTpfthE8XVDoflSv
 6y2w==
X-Gm-Message-State: AOJu0Yw14WMpyl2uCCmF75JT/1Dti0blrGNFeULE4ziSW+s23wfi3sla
 z0cStKy494Wv6OXIWIIOgS5O6hlXlEpfKhOFFexDVs+eHN8et4PI4NbsGM+VfowBHu9FsLA7jys
 wke5am8pGaFUKgEGItYwl3igXyFO/j1Uri7m5XgVFUF4p+J4=
X-Google-Smtp-Source: AGHT+IGMWqBjNtS1tuQ3LOexzQJMwqsY9UPfqKMkY2O5XotB7bZ1dbLn0HwA3OZ6GlHNeyDYKHJd6oO/MEQQ+/FAtlc=
X-Received: by 2002:a05:6a00:1790:b0:706:a931:20da with SMTP id
 d2e1a72fcca58-719260654f6mr2116838b3a.3.1726102920472; Wed, 11 Sep 2024
 18:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAN2hA0TreEPtpCoqo+gDwvhEp=5xwzhL=Qq+89sHGv=OKFdV3Q@mail.gmail.com>
In-Reply-To: <CAN2hA0TreEPtpCoqo+gDwvhEp=5xwzhL=Qq+89sHGv=OKFdV3Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 19:01:43 -0600
Message-ID: <CAFLszTgdQfn5MaaGZ8BPEA41FRvj9PLybsEhCFpAOU5wih-r+w@mail.gmail.com>
Subject: Re: Assistance Required: U-Boot Access Issues on Amlogic A113X SoC
To: Mike <zamorozov.di5454@gmail.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Mike,

On Fri, 6 Sept 2024 at 11:06, Mike <zamorozov.di5454@gmail.com> wrote:
>
> Dear U-Boot Community,
>
> I am working on a project involving the Amlogic A113X SoC and have
> encountered an issue with U-Boot during the boot process over UART. While I
> am able to connect via UART and observe the boot log, the system does not
> allow any interaction or command input. It seems that the manufacturer may
> have restricted this access, potentially violating the GNU GPL license.
>
> Here are the details:
>
>    - *SoC:* Amlogic A113X
>    - *Bootloader:* U-Boot 2015.01 (Jan 13 2023 - 10:30:19)
>    - *Issue:* The device does not respond to input during the boot process
>    over UART (no response to Ctrl+C, Enter, etc.)
>    - *UART Log:*
>
>    AXG:BL1:d1dbf2:a4926f;FEAT:F0DC31BC:2000;POC:F;EMMC:800;NAND:0;READ:0;0.0;0.0;CHK:0;
>    sdio debug board detected
>    TE: 139689
>
>    BL2 Built : 10:38:43, Apr 14 2020. axg gf27ed33 - jenkins@walle02-sh
>
>    set vcck to 1100 mv
>    set vddee to 950 mv
>    Board ID = 3
>    CPU clk: 1200MHz
>    DDR low power enabled
>    DDR3 chl: Rank0 16bit @ 912MHz
>    bist_test rank: 0 1c 07 32 26 10 3c 1e 06 36 27 10 3f 00 00 00 00 00 00
>    00 00 00 00 00 00 772   - PASS
>    Rank0: 256MB(auto)-2T-13
>    AddrBus test pass!
>    NAND init
>    Load FIP HDR from NAND, src: 0x0000c000, des: 0x01700000, size:
>    0x00004000, part: 0
>    Load BL3x from NAND, src: 0x00010000, des: 0x01704000, size: 0x000b7c00,
>    part: 0
>    NOTICE:  BL31: v1.3(release):3edeb02
>    NOTICE:  BL31: Built : 16:43:54, Apr 14 2020
>    NOTICE:  BL31: AXG secure boot!
>    NOTICE:  BL31: BL33 decompress pass
>    OPS=0x43
>    [Image: axg_v1.1.3494-9ec8345 2020-04-17 18:16:39 jenkins@walle02-sh]
>    25 0c 43 00 c3 ac bf b3 9f 7a e1 5b 3a 07 57 99
>    bl30:axg ver: 9 mode: 0
>    bl30:axg thermal0
>    [0.015883 Inits done]
>    secure task start!
>    high task start!
>    low task start!
>    ERROR:   Error initializing runtime service opteed_fast
>
>
>    U-Boot 2015.01 (Jan 13 2023 - 10:30:19)
>
>    DRAM:  256 MiB
>    Relocation Offset is: 0eeb0000
>    mmu cfg end: 0x20000000
>    mmu cfg end: 0x20000000
>    register usb cfg[0][1] = 000000000ff6e198
>    aml_i2c_init_port init regs for 2
>    NAND:  get_sys_clk_rate_mtd() 292, clock setting 200!
>    bus cycle0: 6,timing: 7
>    NAND device id: 98 da 90 15 76 16
>    NAND device: Manufacturer ID: 0x98, Chip ID: 0x98 (Toshiba A revision
>    NAND 2Gib TC58NVG1S3HBAI4 )
>    get_sys_clk_rate_mtd() 292, clock setting 200!
>    m3_nand_adjust_timing() sys_clk_rate 200, bus_c 6, bus_t 7
>    oob_fill_cnt =32 oob_size =64, bch_bytes =14
>    ecc mode:6 ecc_page_num=2 eep_need_oobsize=16
>    plane_num=1 writesize=0x800 ecc.size=0x200 bch_mode=1
>    oob avail size 6
>    Creating 1 MTD partitions on "A revision NAND 2Gib TC58NVG1S3HBAI4 ":
>    0x000000000000-0x000000200000 : "bootloader"
>    A revision NAND 2Gib TC58NVG1S3HBAI4  initialized ok
>    get_sys_clk_rate_mtd() 292, clock setting 200!
>    bus cycle0: 6,timing: 7
>    NAND device id: 98 da 90 15 76 16
>    NAND device: Manufacturer ID: 0x98, Chip ID: 0x98 (Toshiba A revision
>    NAND 2Gib TC58NVG1S3HBAI4 )
>    get_sys_clk_rate_mtd() 292, clock setting 200!
>    m3_nand_adjust_timing() sys_clk_rate 200, bus_c 6, bus_t 7
>    oob_fill_cnt =32 oob_size =64, bch_bytes =14
>    ecc mode:6 ecc_page_num=2 eep_need_oobsize=16
>    PLANE change!
>    plane_num=1 writesize=0x800 ecc.size=0x200 bch_mode=1
>    aml_nand_init :oobmul=1,oobfree.length=8,
>    - oob_size=64
>    oob avail size 8
>    nbbt=20
>    nenv=24
>    nkey=32
>    ndtb=40
>    nddr=44
>    bbt_start=20 env_start=24 key_start=32 dtb_start=40 ddr_start=44
>    nbbt: info size=0x800 max_scan_blk=24, start_blk=20
>    nbbt : phy_blk_addr=20, ec=0, phy_page_addr=0, timestamp=1
>    nbbt free list:
>    blockN=21, ec=-1, dirty_flag=0
>    blockN=22, ec=-1, dirty_flag=0
>    blockN=23, ec=-1, dirty_flag=0
>    aml_nand_scan_rsv_info 1134: page_num=1
>    aml_nand_scan_rsv_info 1137
>    nbbt valid addr: 280000
>    aml_nand_bbt_check 1258 bbt is valid, reading.
>    aml_nand_read_rsv_info:446,read nbbt info to 280000
>    nenv: info size=0x10000 max_scan_blk=32, start_blk=24
>    nenv : phy_blk_addr=24, ec=0, phy_page_addr=0, timestamp=5
>    nenv free list:
>    blockN=25, ec=0, dirty_flag=1
>    blockN=26, ec=-1, dirty_flag=0
>    blockN=27, ec=-1, dirty_flag=0
>    blockN=28, ec=-1, dirty_flag=0
>    blockN=29, ec=-1, dirty_flag=0
>    blockN=30, ec=-1, dirty_flag=0
>    blockN=31, ec=-1, dirty_flag=0
>    aml_nand_scan_rsv_info 1134: page_num=32
>    aml_nand_scan_rsv_info 1137
>    nenv valid addr: 310000
>    nkey: info size=0x8000 max_scan_blk=40, start_blk=32
>    nkey : phy_blk_addr=33, ec=0, phy_page_addr=0, timestamp=2
>    nkey free list:
>    blockN=32, ec=0, dirty_flag=1
>    blockN=34, ec=-1, dirty_flag=0
>    blockN=35, ec=-1, dirty_flag=0
>    blockN=36, ec=-1, dirty_flag=0
>    blockN=37, ec=-1, dirty_flag=0
>    blockN=38, ec=-1, dirty_flag=0
>    blockN=39, ec=-1, dirty_flag=0
>    aml_nand_scan_rsv_info 1134: page_num=16
>    aml_nand_scan_rsv_info 1137
>    nkey valid addr: 430000
>    ndtb: info size=0x20000 max_scan_blk=44, start_blk=40
>    ndtb : phy_blk_addr=41, ec=0, phy_page_addr=0, timestamp=2
>    ndtb free list:
>    blockN=40, ec=-1, dirty_flag=0
>    blockN=42, ec=-1, dirty_flag=0
>    blockN=43, ec=-1, dirty_flag=0
>    aml_nand_scan_rsv_info 1134: page_num=64
>    aml_nand_scan_rsv_info 1137
>    ndtb valid addr: 520000
>    nddr: info size=0x800 max_scan_blk=46, start_blk=44
>    nddr : phy_blk_addr=-1, ec=0, phy_page_addr=0, timestamp=0
>    nddr free list:
>    blockN=44, ec=-1, dirty_flag=0
>    blockN=45, ec=-1, dirty_flag=0
>    aml_nand_scan_rsv_info 1134: page_num=1
>    nddr valid addr: fffffffffffe0000
>    aml_nand_rsv_info_check_except_bbt 1228 NO nddr exist
>    tpl: off 8388608, size 8388608
>     NAND bbt detect factory Bad block at c000000
>     NAND bbt detect factory Bad block at c020000
>    Creating 7 MTD partitions on "A revision NAND 2Gib TC58NVG1S3HBAI4 ":
>    0x000000800000-0x000001000000 : "tpl"
>    0x000001000000-0x000001200000 : "misc"
>    0x000001200000-0x000002200000 : "boot_a"
>    0x000002200000-0x000003200000 : "boot_b"
>    0x000003200000-0x000007200000 : "system_a"
>    0x000007200000-0x00000b200000 : "system_b"
>    0x00000b200000-0x000010000000 : "data"
>     NAND bbt detect factory Bad block at c000000
>     NAND bbt detect factory Bad block at c020000
>    A revision NAND 2Gib TC58NVG1S3HBAI4  initialized ok
>    MMC:   aml_priv->desc_buf = 0x000000000deae760
>    aml_priv->desc_buf = 0x000000000deb0aa0
>    SDIO Port B: 0, SDIO Port C: 1
>    uboot env amlnf_env_read : ####
>    aml_nand_read_rsv_info:446,read nenv info to 310000
>    In:    serial
>    Out:   serial
>    Err:   serial
>    aml log : internal sys error!
>    reboot_mode=cold_boot
>    Start read misc partition datas!
>    [burnup]Rd:Up sz 0x440 to align 0x1000
>    info->attemp_times = 12
>    info->active_slot = 0
>    info->slot_info[0].bootable = 1
>    info->slot_info[0].online = 1
>    info->slot_info[1].bootable = 1
>    info->slot_info[1].online = 0
>    info->attemp_times = 12
>    active slot = 0
>    cmd: imgread dtb boot_a ${dtb_mem_addr}
>    [imgread]szTimeStamp[2024071615081273]
>    [imgread]MTD pageShift 11, writesz 0x800
>    aml log : R-2048 check pass!
>    aml log : R2048 check pass!
>    [imgread]Enc dtb sz 0xe000
>          Amlogic multi-DTB tool
>          Single DTB detected
>    Net:   sysnopsys gmac3.7
>    Phy 0 not found
>    dwmac.ff3f0000amlkey_init() enter!
>    amlnf_key_read: ####
>    amlnf_key_read key data len too much
>    aml_nand_read_rsv_info:446,read nkey info to 430000
>    [EFUSE_MSG]keynum is 4
>    MACADDR:*(from chipid)
>
>    Start read misc partition datas!
>    [burnup]Rd:Up sz 0x440 to align 0x1000
>    info->attemp_times = 12
>    info->active_slot = 0
>    info->slot_info[0].bootable = 1
>    info->slot_info[0].online = 1
>    info->slot_info[1].bootable = 1
>    info->slot_info[1].online = 0
>    info->attemp_times = 12
>    active slot = 0
>    wipe_data=successful
>    wipe_cache=successful
>    Setting bus to 2
>    i2c_set_bus_num i2c sel 2 bus
>    aml_i2c_init_port init regs for 2
>    gpio: pin GPIOZ_4 (gpio 18) value is 1
>    recovery_status=
>    upgrade_step=2
>    s_version: U-Boot 2015.01
>    amlkey_init() enter!
>    amlkey_init() 71: already init!
>    [EFUSE_MSG]keynum is 4
>    [KM]Error:f[key_manage_query_size]L515:key[usid] not programed yet
>    [KM]Error:f[key_manage_query_size]L515:key[mac] not programed yet
>    InUsbBurn
>    noSof
>
>    CONFIG_SYSTEM_AS_ROOT: null
>    system_mode: 0
>    [imgread]szTimeStamp[2024071615081273]
>    [imgread]secureKernelImgSz=0x609800
>    [burnup]Rd:Up sz 0x509800 to align 0x1000
>    aml log : R-2048 check pass!
>    aml log : R2048 check pass!
>    aml log : R2048 check pass!
>    aml log : R2048 check pass!
>    avb2: 0
>    save_power_post ...
>    avb2: 0
>    ## Booting Android Image at 0x01080000 ...
>    reloc_addr =ded9810
>    copy done
>    Kernel command line: init=/sbin/init rootfstype=ubifs
>    [store]Is good fdt check header, no need decrypt!
>    load dtb from 0x1000000 ......
>          Amlogic multi-DTB tool
>          Single DTB detected
>       Uncompressing Kernel Image ... OK
>       kernel loaded at 0x01080000, end = 0x01a5b200
>       Loading Ramdisk to 0dcf0000, end 0de9d800 ... OK
>       Loading Device Tree to 000000000dce0000, end 000000000dceffe6 ... OK
>    fdt_fixup_memory_banks, reg:0000000000000000
>
>    Starting kernel ...
>
>    uboot time: 2751820 us
>
> I understand that U-Boot has been modified by the manufacturer, which
> complicates the situation. I am seeking advice on the following:
>
>    - Are there any known methods or workarounds to regain control over the
>    U-Boot environment in such scenarios?
>    - Are there any specific forums or community resources where I might
>    find additional help or similar cases?
>
> Any guidance or suggestions would be greatly appreciated. Thank you in
> advance for your assistance!

Can you get an up-to-date version? That is 9 years old?!!

Once you boot into Linux it is hard. You could use a JTAG debugger.
There is also earlycon and keep_bootcon which might help with
early-Linux debugging.

Regards,
Simon
