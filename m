Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EFBC48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 11:07:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD00A87F97;
	Tue, 20 Feb 2024 12:04:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BeAiE1f6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B724887FA3; Tue, 20 Feb 2024 10:51:01 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F2E187D7E
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 10:50:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=blemouzy.ml@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-512b29f82d1so2795533e87.1
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 01:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708422653; x=1709027453; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:subject:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=hpq/SLFbA0ftMBg0H9iqWJOGqjWx7eRC2JI8LcexCII=;
 b=BeAiE1f6CtHFL923uA+/pfT4QW6lWWdTvANnJaBF9LyP2IH/hsS5cqhJUE9zgKZQ5I
 TV6EY0xX3oMstGO14J07kOdsC7G73Z+v1m1jFchRl7YRhEnwQgSDrYe90KsV28qXLW7q
 pHFXXQYdhxU+/RFhmFSE9lwd53A2aALBZVSQv3MB5bok2GLuy9tZW+AtziP9Zn1gvGYk
 Y510RmkZp0dp3kxKgsn1I77P3LFiv6L4+lXpdi8NE/4tUMwGBqcSCobakIwdB2TUgPQr
 yn7Aqkk8Do+59qtRQWkLH3LT5tzYIjEDYVQMPun8SV7NCpOmzCz5aPrd6muHkUbkJJdZ
 N9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708422653; x=1709027453;
 h=content-transfer-encoding:mime-version:message-id:subject:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hpq/SLFbA0ftMBg0H9iqWJOGqjWx7eRC2JI8LcexCII=;
 b=aQodK+xmC7mQRJVuFl0/Bpp/SDNwtKSmOw7gCQ3OKhxxqrTT4iDCPnkv86mUDKFv21
 L/ajs/XACDTaH/WXNf2S3S/uZ7JAMnLRz/C5ir4pTb51m5SeTAq/6US1f1/+nfdeZeLq
 Pf0S77UU0ftlz0Rfa8yepTY9szsJ/EHXxEMUVIRLHvjsGqjIeqtVOkbXrMkQVO5mO33W
 pGUWdFo6RXejw19JoDRZBkXvVDF5RcorbxoAGIn6RCtuLm/BSAXLw4z1axCOPB+lAmic
 pskxQNFYq96ep9U/EDKWgnD+qBGM8A/aEkWOUn0tOZiR1HTTr55EhyVBCeAuCwLIv2RJ
 J8xA==
X-Gm-Message-State: AOJu0Yyjjd84z4S6/z7v3NAsHyKyY84UHeKvy821SbjVH+Ak3CkkTtX9
 IjrpJ+LCcQXqhPi/hUqDnW1kPyY9rLWzcBB8DjUEuDZbZHb9ITbjERDkSjYqwt7WQg==
X-Google-Smtp-Source: AGHT+IG4UNydiGaVoaeqchWrt8wPBYpvi8xBwhH+4Tk8fF3V25IkcEaUMSXRrInFsNskfvoPwiyt6Q==
X-Received: by 2002:a19:761a:0:b0:512:b2b6:486d with SMTP id
 c26-20020a19761a000000b00512b2b6486dmr3702445lff.62.1708422652453; 
 Tue, 20 Feb 2024 01:50:52 -0800 (PST)
Received: from localhost ([37.174.24.210]) by smtp.gmail.com with ESMTPSA id
 bx14-20020a5d5b0e000000b0033d6bd4eab9sm1383089wrb.1.2024.02.20.01.50.51
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 01:50:52 -0800 (PST)
Date: Tue, 20 Feb 2024 10:50:49 +0100
From: Benjamin Lemouzy <blemouzy.ml@gmail.com>
To: u-boot@lists.denx.de
Subject: HABv4 with SPL and u-boot-dtb.img on i.MX6
Message-ID: <20240220105049.00000d3c@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 20 Feb 2024 12:03:24 +0100
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

I'm trying to make secure boot work on i.MX6 SABRE with SPL and u-boot-dtb.img files and I'm not sure how to do it.

I'm using the U-Boot vanilla master branch (2024.04-rc2) with the following configuration:

    # Remove some stuff to not exceed file size limit
    $ cat <<EOF >> configs/mx6sabresd_defconfig
    CONFIG_BOOTMETH_EFILOADER=n
    CONFIG_CMD_NET=n
    CONFIG_NET=n
    EOF

    # Enable secure boot
    $ cat <<EOF >> configs/mx6sabresd_defconfig
    CONFIG_IMX_HAB=y
    CONFIG_SPL_LOAD_FIT_ADDRESS=0x18000000
    EOF

    $ make ARCH=arm O=build mx6sabresd_defconfig

    $ make ARCH=arm O=build

I have no issue to generate a working SPL-signed file following doc/imx/habv4/guides/mx6_mx7_spl_secure_boot.txt instructions.

doc/imx/habv4/guides/mx6_mx7_spl_secure_boot.txt only gives instructions to sign u-boot-ivt.img but this file doesn't contain device trees listed in CONFIG_OF_LIST as u-boot-dtb.img does and I need them.



NXP AN4581 lists 2 possible formats to sign additional images:

- Image format:

            ------- +-----------------------------+ <-- *load_address
                ^   |                             |
                |   |                             |
                |   |          Image data         |
         Signed |   |                             |
          Data  |   |                             |
                |   +-----------------------------+
                |   |    Padding Next Boundary    |
                |   +-----------------------------+ <-- *ivt
                v   |     Image Vector Table      |
            ------- +-----------------------------+ <-- *csf
                    |                             |
                    | Command Sequence File (CSF) |
                    |                             |
                    +-----------------------------+
                    |     Padding (optional)      |
                    +-----------------------------+

- FIT image format:

            ------- +-----------------------------+ -------
                ^   |                             |    ^
                |   |                             |    |
                |   |           FDT FIT           |    |
                |   |                             |    |
    Signed data |   |                             |    |
                |   +-----------------------------+    |
                |   |    Padding Next Boundary    |    |
                |   +-----------------------------+    |
                v   |     Image Vector Table      |    |
            ------- +-----------------------------+    | FIT image
                    |                             |    |
                    | Command Sequence File (CSF) |    |
                    |                             |    |
                    +-----------------------------+    |
                    |     Padding (optional)      |    |
            ------- +-----------------------------+    |
                ^   |                             |    |
    Signed data |   |           U-Boot            |    |
                v   |                             |    v
            ------- +-----------------------------+ -------

And as u-boot-dtb.img is a FIT image, I probably have to use the FIT image format, right?



I manually craft the signed FIT image using doc/imx/habv4/csf_examples/mx8m/csf.sh as reference and everything looks fine:

    U-Boot SPL 2024.04-rc2-00025-g9e00b6993f-dirty (Feb 19 2024 - 13:17:31 +0100)
    >>SPL: board_init_r()
    spl_init
    Trying to boot from MMC1
    fit read offset 11400, size=12800, dst=18000000, count=12800
    spl_load_simple_fit_fix_load: ivt: 18001000 offset: 1000 size: 3060
    spl_load_simple_fit_fix_load: ivt self: 18001000
    hab fuse not enabled

    Authenticate image from DDR location 0x18000000...

    ivt_offset = 0x1000, ivt addr = 0x18001000
    ivt entry = 0x18000000, dcd = 0x00000000, csf = 0x18001020
    Dumping IVT
    .. @............
    ........ .......
    Dumping CSF Header
    ..PC...........P
    ................
    .......<........
    ...............8

    Calling authenticate_image in ROM
            ivt_offset = 0x1000
            start = 0x18000000
            bytes = 0x3060
    firmware: 'firmware-1'
    External data: dst=17800000, offset=3060, size=86138
    Image OS is U-Boot
    fdt: 'fdt-1'
    Can't get 'load' property from FIT 0x18000000, node: offset 464, name fdt-1 (FDT_ERR_NOTFOUND)
    External data: dst=17886140, offset=89198, size=ac00
    Can't get 'entry' property from FIT 0x18000000, node: offset 464, name fdt-1 (FDT_ERR_NOTFOUND)
    loadables: 'firmware-1'
    no string for index 1
    Jumping to U-Boot...
    SPL malloc() used 0x0 bytes (0 KB)
    image entry point: 0x


    U-Boot 2024.04-rc2-00025-g9e00b6993f-dirty (Feb 19 2024 - 13:17:31 +0100)

    CPU:   Freescale i.MX6Q rev1.2 996 MHz (running at 792 MHz)
    CPU:   Automotive temperature grade (-40C to 125C) at 35C
    Reset cause: POR
    Model: Freescale i.MX6 Quad SABRE Smart Device Board
    DRAM:  1 GiB
    Core:  94 devices, 23 uclasses, devicetree: separate
    WDT:   Started watchdog@20c0000 with servicing every 1000ms (128s timeout)
    MMC:   FSL_SDHC: 4, FSL_SDHC: 1, FSL_SDHC: 3
    Loading Environment from MMC... *** Warning - bad CRC, using default environment

    No panel detected: default to Hannstar-XGA
    Display: Hannstar-XGA (1024x768)
    In:    serial
    Out:   serial
    Err:   serial
    SEC0:  RNG instantiated
    Hit any key to stop autoboot:  0
    => hab_status

    Secure boot disabled

    HAB Configuration: 0xf0, HAB State: 0x66
    No HAB Events Found!

But as only the FDT part of the FIT image is checked through HAB, U-Boot and DTB are only protected by FIT image hashes, right?

Using fdtdump shows that crc32 is used as hash algorithm for FIT image which is a super weak one.
I tried to pass another algo (sha256) using mkimage -o option but that doesn't work.

  ./tools/mkimage -f auto -A arm -T firmware -C none -O u-boot -a 0x17800000 -e 0x17800000 -p 0x0 -n "U-Boot 2024.04-rc2-00025-g9e00b6993f-dirty for mx6sabresd board" -E -b arch/arm/dts/imx6q-sabresd.dtb -b arch/arm/dts/imx6qp-sabresd.dtb -b arch/arm/dts/imx6dl-sabresd.dtb -d u-boot-nodtb.bin -o sha256 u-boot-dtb.img

Is there any way to change U-Boot FIT image hash?



I also try to use image format and force the HAB to verify the whole u-boot-dtb.img file by patching the FIT image size:

    image_size=$(stat -tc %s u-boot-dtb.img)
    printf "00000004: %08x" "$image_size" | xxd -r - u-boot-dtb.img

SPL starts, authentication looks fine but the boot fails.
Is there any chance to make it work or is it insane to try to use this format?

Regards,

Benjamin
