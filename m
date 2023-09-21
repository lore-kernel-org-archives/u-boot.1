Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C11AE71086
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 15:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C06D86377;
	Thu, 21 Sep 2023 17:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AqCDXvBO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DCD586429; Thu, 21 Sep 2023 17:04:10 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB0818615A
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 17:04:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahiroy@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0DA9F60B7D
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 15:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3F6C4E761
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 15:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695308645;
 bh=v/UXUlQM2o4IUFlP504e4uf9p/cLTlPizAFmLyo22oE=;
 h=From:Date:Subject:To:Cc:From;
 b=AqCDXvBOvHQfJrDCCTkhdhwoCQ7SZXPjOuzakv1wHlOYCb92Kp/Esu4bRWN4QBvEJ
 dZUMsGsOBK7uWPbbK2+km5sQKVSZMcEMnVBb3SPYv/qpNWnBbpnuPK9WAoLiZ0hP3f
 8mWxsIgDAsvwJUJn1I49YSwtaW43YWV+Z/KUoeLGtVMbIEdFrdwHoqfhEPh8Bux298
 BLCEo/XTcreBfVZXcz65V6Pct84pPQGN+vKj0ckQTS3ulD61s/mdV+AjW26397KoH/
 PUOdS1VbbkEpP7KOmxWCT9Jn6NoQ8bvMXYFFj5rQFOuh0A6dD0IPBrk7CsBlSKHxQo
 Sxzi6t7k86oEQ==
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-1d544a4a2f2so598647fac.3
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 08:04:05 -0700 (PDT)
X-Gm-Message-State: AOJu0YzIzE5I/3ISO8aFum9uX30jUmvVSSEEIkw05uEET7CXGGbFAk0c
 GfTKFR/RGSgprQwfkEYsu3tzoaQ1iZ3YttgRqVY=
X-Google-Smtp-Source: AGHT+IET8/xFNTajWEANT0SJvXDmZ00WxjlgoDr0fpSUQZ4vAiXNffUoHt5ME083Q1wG5pxxl7Rudh6nz+PySKuuCuQ=
X-Received: by 2002:a05:6870:56a4:b0:1ba:2c95:a168 with SMTP id
 p36-20020a05687056a400b001ba2c95a168mr6227251oao.35.1695308644629; Thu, 21
 Sep 2023 08:04:04 -0700 (PDT)
MIME-Version: 1.0
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 22 Sep 2023 00:03:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNASMF-E96ShdukjdBEyKhxByve7NwW21xJmWRC8i8eYC0A@mail.gmail.com>
Message-ID: <CAK7LNASMF-E96ShdukjdBEyKhxByve7NwW21xJmWRC8i8eYC0A@mail.gmail.com>
Subject: Question about boot failure of AM64-SK
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Nishanth Menon <nm@ti.com>, srk@ti.com, s-vadapalli@ti.com,
 n-francis@ti.com, m-chawdhry@ti.com
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

Hi.

I am seeing a boot failure on AM64-SK.


I got the following error in SPL of the main core.
Do you have any clue?


Error reading cluster
fit read sector 0, sectors=985528, dst=, count=18446744073709551615,
size=0xf09b8


The resulting count looks crazy, but I imagine it was just
that the negative error code was converted to ulong.



For debugging, I enabled debug() under common/spl/.
The rest is the same as the latest mainline.

The full log is as follows:



U-Boot SPL 2023.10-rc4-00047-gb9b83a86f0-dirty (Sep 21 2023 - 14:38:15 +0000)
SYSFW ABI: 3.1 (firmware rev 0x0009 '9.0.7--v09.00.07 (Kool Koala)')
EEPROM not available at 0x50, trying to read at 0x51
SPL initial stack usage: 13384 bytes
SPL malloc() before relocation used 0x32ec bytes (12 KB)
>>SPL: board_init_r()
spl_init
Trying to boot from MMC2
spl: mmc boot mode: fs
Found FIT
fit read sector 0, sectors=874340, dst=, count=874339, size=0xd5764
firmware: 'atf'
Embedded data: dst=701c0000, size=b2a8
Warning: Detected image signing certificate on GP device. Skipping
certificate to prevent boot failure. This will fail if the image was
also encrypted
Image OS is ARM Trusted Firmware
loadables: 'tee'
Embedded data: dst=9e800000, size=753e0
Warning: Detected image signing certificate on GP device. Skipping
certificate to prevent boot failure. This will fail if the image was
also encrypted
Loadable is Trusted Execution Environment
loadables: 'dm'
Embedded data: dst=89000000, size=0
Loadable is Unknown OS
loadables: 'spl'
Embedded data: dst=80080000, size=4ff18
Warning: Detected image signing certificate on GP device. Skipping
certificate to prevent boot failure. This will fail if the image was
also encrypted
Loadable is U-Boot
fdt: 'fdt-1'
Embedded data: dst=800cf888, size=2af2
Warning: Detected image signing certificate on GP device. Skipping
certificate to prevent boot failure. This will fail if the image was
also encrypted
loadables: 'spl'
no string for index 3
Unsupported OS image.. Jumping nevertheless..
Loading Environment from MMC... MMC Device 0 not found
*** Warning - No MMC card found, using default environment

Starting ATF on ARM64 core...

NOTICE:  BL31: v2.9(release):v2.9.0
NOTICE:  BL31: Built : 10:06:58, Sep 21 2023
I/TC:
I/TC: OP-TEE version: 3.22.0 (gcc version 11.4.0 (Ubuntu
11.4.0-1ubuntu1~22.04)) #1 Thu Sep 21 10:06:54 UTC 2023 aarch64
I/TC: WARNING: This OP-TEE configuration might be insecure!
I/TC: WARNING: Please check
https://optee.readthedocs.io/en/latest/architecture/porting_guidelines.html
I/TC: Primary CPU initializing
I/TC: SYSFW ABI: 3.1 (firmware rev 0x0009 '9.0.7--v09.00.07 (Kool Koala)')
I/TC: HUK Initialized
I/TC: Activated SA2UL device
I/TC: Fixing SA2UL firewall owner for GP device
I/TC: Enabled firewalls for SA2UL TRNG device
I/TC: SA2UL TRNG initialized
I/TC: SA2UL Drivers initialized
I/TC: Primary CPU switching to normal world boot

U-Boot SPL 2023.10-rc4-00047-gb9b83a86f0-dirty (Sep 21 2023 - 14:38:20 +0000)
SYSFW ABI: 3.1 (firmware rev 0x0009 '9.0.7--v09.00.07 (Kool Koala)')
SPL malloc() before relocation used 0x1f80 bytes (7 KB)
>>SPL: board_init_r()
spl_init
Trying to boot from MMC2
spl: mmc boot mode: fs
Found FIT
Error reading cluster
fit read sector 0, sectors=985528, dst=, count=18446744073709551615,
size=0xf09b8
SPL: failed to boot from all boot devices
### ERROR ### Please RESET the board ###





My build sequence is something like this:



      # for wakeup
      make -j "$(nproc)" O=build-wakeup CROSS_COMPILE=arm-linux-gnueabihf- \
          BINMAN_INDIRS="${SNAPCRAFT_STAGE}/ti-linux-firmware" \
          am64x_evm_r5_defconfig all
      cp build-wakeup/tiboot3-am64x-gp-evm.bin "${STAGE}/tiboot3.bin"

      # for main
      make -j "$(nproc)" O=build-main am64x_evm_a53_defconfig
      make -j "$(nproc)" O=build-main CROSS_COMPILE=aarch64-linux-gnu- \
          BINMAN_INDIRS="${STAGE}/ti-linux-firmware" \
          BL31="${STAGE}/bl31.bin" \
          TEE="${STAGE}/tee-raw.bin" \
          all
      cp build-main/tispl.bin build-main/u-boot.img "${STAGE}"






Strangely, AM62-SK booted successfully,
but AM64-SK failed.
I do not know why.


-- 
Best Regards
Masahiro Yamada
