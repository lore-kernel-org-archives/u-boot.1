Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB8A606A31A
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 06:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mgWFUAgP;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=NyE4eQNN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A78B4405AE;
	Mon, 23 Nov 2026 06:05:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FuSZycIQA4YT; Mon, 23 Nov 2026 06:05:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5CC6640519
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795413917;
	b=QllYBkgNvu4rPwx7cse0mdWMbIFf4t2+Afs8tpHNSRMtDxfhclY/QxFT7UGgKQfraTBi
	 A4DpLvJWM2/fdxXErmpVId5Y0QRW26sZ9phHigs9rnSG6L2kKRANSpQ8hA8uZxKdPwr5x
	 Cz/3kpCIqA7pEKTS+M7CYt+tF7Qk6FT8fS8AtRNh+QHkZ/wyYw4ALWtm972QgVQHs1eZP
	 p8eE1iEcPmGI5cPVQaBsE/gbqDOSTFlySfUv0Cp0jEusUBM99Js15jpCGhUBhMNaoRolM
	 NHHOk8sKoj8LwTNHgMzckbmml19yaoQxhobk/LAYBbdtrUm3bG+wMh44H7NYv3ZtLVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795413917;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kCpJCVchEn/N7ACdwWxEBUrIIGYv+pwzpkANGDB9+lI=;
	b=f8aC38UhhoCqh0A5KKKNAJSNgFyfXoyTV+h0F/MKpR0XDeULhtQtZ38UQG4mLwUx1PFI
	 OaUGEC0cngyn2SEzKNQSXa2Uqgc7AbtItPJyYRojyqGrxeMSD06FhUHVK5j8WGKYM6c0l
	 BYRRWLFleovusG/B2Qh1BgVOIGtp4Ub3kAOgF8MOTqTeBZbn8Hxi3r0EoTt2aNI+RRk6O
	 /SlO1z7/UWSLivxt3zA/Ad0MuIcQpDh8X10Ocagq4UJoY8t75ecmz4uS8gHbCde2wwo14
	 3ui3cFLWe1jtvp/OjQlkPWS08GvT6bPbwqOZfpvFQ3nI8c8yHlATYbXlB3ODCf+vMyw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795413917;
	bh=kCpJCVchEn/N7ACdwWxEBUrIIGYv+pwzpkANGDB9+lI=;
	h=Date:To:Cc:References:From:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mgWFUAgPiYw9hz65tdHaPfdmqfB/6hTFHzfCvyUwtCetsR44wGjB73MT/13RcwXH7
	 0Lmg3V1ybOp/+qG2sbpwkddYJqOzWLiM+mrlOmQTabDtWUlSkhQVZKG1rOw97VIQm3
	 HaLKiUsOO/OqOdc6/SaFB8oFBVCIAwG/JPnH+2ZxrHS3d0XTMM7meHIB47dLJANnaO
	 +l18YoRrLOAUaXxs2xXqbj15FCpcaQ6RmKf2sQqAbbC9hUsQ0J4bwiRgqGVdet2tfE
	 gzIV1luLhKBsjj3zOXEHPkv9i0p5DUCNw+jJQFstjI8Sfh2ZSO3LzZxjDixBar+mw0
	 Bx/heuKXOH5ZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CC6640519;
	Mon, 23 Nov 2026 06:05:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A4282260
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 06:05:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 95E2B60697
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 06:05:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b48ob2Qz3ATC for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 06:05:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EB2B56065A
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=NyE4eQNN
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EB2B56065A
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 06:05:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B946511030F; Mon, 23 Nov 2026 07:04:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1795413905;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=kCpJCVchEn/N7ACdwWxEBUrIIGYv+pwzpkANGDB9+lI=;
 b=NyE4eQNNGjcdAFyviuk2Eecblmc16pIlXW79T6q9BVjkIcdHzME+K4tBa4rCuUSRyW2zR8
 GwZDG3w9YXch+UjnTGtLv5BtyRx2p9pwadDDMs9HmnqUAje35L3++Fs5ZZTO/1xgAic2kn
 rXbgfWSqryRP0SXSYFsQC9BO6KoFAT7DkwYpdA7vaINcfrXEUTzz3kwXR7KCs52dug+rr8
 YyG6vIYYY8g4RbCTmgrWxANV6KEcKMhKgIYPAKEo3juVZ6Gzh97Xx6qSIusCJljYE5awy/
 nfnyBCbmHXcj9KzCYnLFE3o42Tnjpg3fclOEeWUX77AkucxMf40usN3tk2AfsA==
Message-ID: <43aea1e5-9ac0-3986-a17a-216783214f3a@nabladev.com>
Date: Mon, 23 Nov 2026 07:04:59 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Johan Jonker <jbx6244@gmail.com>, Vignesh R <vigneshr@ti.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Simon Glass <sjg@chromium.org>, Alexey Charkov <alchark@flipper.net>,
 Casey Connolly <casey.connolly@linaro.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Marek Vasut <marex@nabladev.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Romain Caritey <romain.caritey@microchip.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Stefan Bigler <stefan.bigler@securiton.ch>, Tom Rini <trini@konsulko.com>,
 openwrt-devel@lists.openwrt.org
References: <20261028061231.39152-1-hs@nabladev.com>
From: Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH v3 0/7] mtd: Microchip 23K256 and 23LCV1024 SPI SRAM
In-Reply-To: <20261028061231.39152-1-hs@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

On 28.10.26 07:11, Heiko Schocher wrote:
> The 23LCV1024 is a 1 Mbit serial SRAM with battery backup on an SPI
> bus, used as non volatile scratch storage. This adds a driver for it
> and for the 23K256 of the same family, plus a sandbox emulation and
> unit tests.
> 
> The driver sits in UCLASS_MTD, the way the SPI NAND driver does, so
> the device is reached through the mtd command. v1 put it in
> UCLASS_SPI_FLASH to borrow the sf command, which meant shimming
> struct spi_nor fields for a device with no flash semantics.
> 
> Patch 1 prepares the MTD core for devices which have no erase
> function.
> 
> Patch 2 does the same for partitions on such a device, which are
> aligned on the write size instead of the erase size the device does
> not have. Without it "mtd list" divides by zero as soon as the device
> tree gives the RAM partitions.
> 
> Patch 3 is the driver itself, now in drivers/mtd/devices/mchp23k256.c
> without erase function, named after the Linux driver and with the
> 23K256 of the same family alongside the 23LCV1024.
> 
> Patch 4 is new in v3 and lets the imagemap test pick the SPI-NOR by the
> partition it needs. It takes the first MTD block device today, which the
> next patch takes away from it. Found by CI run:
> https://dev.azure.com/hs0298/hs/_build/results?buildId=223&view=results
> 
> Patch 5 is the sandbox emulation and the tests. v2 had a patch before
> it that taught the sandbox SPI bus to bind an emulation from a
> sandbox,emul phandle. That patch is gone, mainline has the hook since
> commit 3b748d780a37 ("sandbox: spi: Add SPI EEPROM emulator and DM
> test"), so the emulation nodes sit at the root of test.dts the way the
> EEPROM one does.
> 
> Patch 6 is new in v3 and does for the mtd command what patch 1 does
> for the MTD core. Read, write and dump get through a device without an
> erase size, and an erase is refused with a message.
> 
> Patch 7 is new in v3 as well and moves the transfers of the driver to
> spi-mem, so that a controller which limits the transfer size or only
> offers spi-mem operations works.
> 
> The series was tested on i.MX6 and i.MX8 hardware.
> 
> This series is now based on the current head of the main branch,
> dfcfc4c9f78d ("Prepare v2027.01-rc1").
> 
> Azure build is clean:
> https://dev.azure.com/hs0298/hs/_build/results?buildId=224&view=results
> 
> Changes in v3:
> - Dropped the sentence saying nobody reads MTD_NO_ERASE, which is wrong,
>    spi-nor sets it for SPI_NOR_NO_ERASE parts. Say instead why the check
>    asks for erasesize and _erase (Simon)
> - Mention the mtdpart.c hunk, a partition gets part_erase() only when
>    its master has an _erase (Simon)
> - Added Reviewed-by from Simon, as all comments are in, beside
>    mtd_is_aligned_with_block_size() comment which is moved to patch
>    "cmd: mtd: get through a device that has no erase size"
> - The two alignment checks no longer rely on MTD_NO_ERASE being set
>    correctly. An alignment of zero counts as 1 with a WARN_ON(), and the
>    partition erase size is only taken when there is one (Simon)
> - Updated the comment above the first check, which still spoke of the
>    erase size alone (Simon)
> - Added Reviewed-by from Simon
> - Named after the Linux driver and moved to
>    drivers/mtd/devices/mchp23k256.c, with CONFIG_MTD_MCHP23K256 and the
>    driver name mchp23k256. drivers/mtd/devices/ is new in U-Boot, it is
>    where the related parts of the family would go (Simon)
> - Added the microchip,mchp23k256 compatible, 32 KiB with a two byte
>    address, so that the name covers what the driver does. The address
>    width comes from the per compatible data
> - spi_ram_xfer() dropped, the driver calls spi_write_then_read(), which
>    does the same two transfers (Simon)
> - The message and the comment in the probe claimed the device powers up
>    in byte operation. The data sheet (DS25156A, section 2.5) gives
>    sequential as the default, and the Linux driver writes the MODE
>    register all the same (Simon)
> - Removed two comments in probe. The reason for selecting sequential
>    operation is in the commit message, and mtd->_erase is set to NULL
>    explicitly (even if that is redundant), so it is obvious that there
>    is no erase function
> - did not add Simons comment about the single 128k comment in this
>    patch, instead moved that to a new patch:
>    mtd: mchp23k256: move the transfers to spi-mem
> - Added Reviewed-by from Simon
> - New patch. Problem found on CI run:
>    https://dev.azure.com/hs0298/hs/_build/results?buildId=223&view=results
>    The next patch gives the test device tree two MTD devices of
>    its own, one of which took the first mtd_blk away from this test
> - The patch that taught the sandbox SPI bus to bind an emulation from a
>    sandbox,emul phandle is gone. Mainline has that since commit
>    3b748d780a37 ("sandbox: spi: Add SPI EEPROM emulator and DM test"),
>    which looks the emulation up with uclass_get_device_by_phandle(). The
>    emulation nodes therefore sit at the root of test.dts, bound by the
>    device tree scan, and the tests no longer unbind anything by hand
> - The emulation treats whatever follows the address in the first
>    transfer as data, so it follows the data sheet rather than the way the
>    driver splits its transfers. The test sends a write in a single
>    transfer to cover it (Simon)
> - The erase is asked for over the data that was written, so the check
>    afterwards would see an erase that went through (Simon)
> - spi_get_bus_and_cs() dropped, the emulation is looked up with the MTD
>    device itself (Simon)
> - The second partition sits at 0xa001, an offset no erase block boundary
>    allows, and the comment says why that matters. 0xa000 was 8K aligned
>    and proved nothing (Simon)
> - The emulation powers up in sequential operation, as the data sheet
>    says. The test puts it into byte operation and probes again to see the
>    driver select the mode
> - Added a test for the 23K256 with its own emulation instance, which is
>    what the second compatible of the driver needs
> - New patch. Patch 1 only covers mtd_erase(), the mtd command divides by
>    the erase size before it ever gets there.
> - New patch. Simon pointed out that a single spi_xfer() over the whole
>    array fails where the SPI NAND driver would work
> 
> Changes in v2:
> - New patch. The SRAM driver of patch 3 has no erase, which the old
>    mtd_erase() would have turned into a NULL pointer jump
> - New patch mtd: align a partition on the write size if the device cannot erase
>    Testing on the board dropped for "mtd list" command:
>    ### ERROR ### Please RESET the board ###
>    This is because division by erase_size, which the SPI RAM driver
>    sets to 0. Added for this case also sandbox test.
> Added comments from Simon:
> - Moved from UCLASS_SPI_FLASH to UCLASS_MTD, the way the SPI NAND
>    driver sits. The struct spi_nor shim and the dm_spi_flash_ops are
>    gone with it, and the device is reached through the mtd command
>    rather than sf.
> - Moved from drivers/mtd/spi/ to drivers/mtd/, where the other
>    standalone MTD drivers live.
> - Dropped the erase operation. v1 filled the range with 0xff from a
>    malloc'd buffer and claimed the bus once per 1 KB chunk. A RAM needs
>    no erase, and patch 1 makes mtd_erase() answer -EOPNOTSUPP.
> - Dropped the linux/mtd/spi-nor.h include, spi_flash.h pulled it in
>    anyway and it advertised a NOR driver.
> - sprintf() into a fixed field replaced by snprintf() into a buffer the
>    driver owns.
> - Copyright: dropped the trailing full stop and added Stefan Bigler's
>    address.
> fixed checkpatch warning:
> - Added a MAINTAINERS entry, as the move out of drivers/mtd/spi/
>    dropped a checkpatch warning.
> Added comments from Simon:
> - The test drives the device through the MTD layer instead of the
>    spi_flash uclass.
> - Uses sandbox_spi_get_emul() rather than reaching into state->spi[][].
> - Added a spi1 alias so that dev_seq() of the bus does not depend on
>    probe order.
> - The erase part checks for -EOPNOTSUPP now. The v1 comment about
>    covering more than one staging step went with the erase loop.
> - The emulation lives in its own node with its own compatible, which
>    the sandbox SPI bus resolves the phandle to.
> - Added the emulation and the test to the MAINTAINERS entry.
> Found while Stefan Bigler tested the series on hardware:
> - Added partitions to the device in the test device tree and a second
>    test that writes through one of them, which is what "mtd list" on his
>    board fell over.
> 
> Heiko Schocher (7):
>    mtd: refuse an erase on a device that cannot erase
>    mtd: align a partition on the write size if the device cannot erase
>    mtd: add driver for the Microchip 23K256 and 23LCV1024 SPI SRAM
>    test: boot: imagemap: pick the SPI-NOR by its partition
>    test: dm: add a test for the Microchip 23K256 and 23LCV1024 SPI SRAM
>    cmd: mtd: get through a device that has no erase size
>    mtd: mchp23k256: move the transfers to spi-mem
> 
>   MAINTAINERS                              |   8 +
>   arch/sandbox/dts/test.dts                |  49 ++++
>   arch/sandbox/include/asm/test.h          |  18 ++
>   cmd/mtd.c                                |  14 ++
>   configs/sandbox_defconfig                |   2 +
>   drivers/mtd/Kconfig                      |   2 +
>   drivers/mtd/Makefile                     |   1 +
>   drivers/mtd/devices/Kconfig              |  26 +++
>   drivers/mtd/devices/Makefile             |   4 +
>   drivers/mtd/devices/mchp23k256.c         | 220 ++++++++++++++++++
>   drivers/mtd/devices/mchp23k256_sandbox.c | 268 ++++++++++++++++++++++
>   drivers/mtd/mtdcore.c                    |   3 +
>   drivers/mtd/mtdpart.c                    |  47 +++-
>   drivers/spi/Kconfig                      |   2 +-
>   test/boot/imagemap.c                     |  11 +-
>   test/cmd/Makefile                        |   3 +
>   test/cmd/mtd.c                           |  79 +++++++
>   test/dm/Makefile                         |   1 +
>   test/dm/mchp23k256.c                     | 272 +++++++++++++++++++++++
>   19 files changed, 1015 insertions(+), 15 deletions(-)
>   create mode 100644 drivers/mtd/devices/Kconfig
>   create mode 100644 drivers/mtd/devices/Makefile
>   create mode 100644 drivers/mtd/devices/mchp23k256.c
>   create mode 100644 drivers/mtd/devices/mchp23k256_sandbox.c
>   create mode 100644 test/cmd/mtd.c
>   create mode 100644 test/dm/mchp23k256.c
> 
> ---
> base-commit: dfcfc4c9f78d1743f490a497082a4ec8e058aae8
> branch: spi-ram-v3
> 

gentle ping!

Any issues with this series?

Thanks

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
