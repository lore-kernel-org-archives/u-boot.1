Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18766606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 06:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sIxQSCPU;
	dkim=pass (2048-bit key, unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=Np8pg43W
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DFA6280D8A;
	Wed, 28 Oct 2026 06:13:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EorZIoZsb8b5; Wed, 28 Oct 2026 06:13:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 896A980D5C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793168007;
	b=MWVUJ9hrdxWFl2zV1Qb0K50MaQJ7DULw7idSd+yQgqgCi1AnUclR5RtBYtCLpBtMbgks
	 s06ACyIXOpNR/nzW+xXL7sr+lbhsCum5bBL1tRGogplxEpWJW/Bq8UjtBfpMOpDcQEnDp
	 ToPbHFLQgjcngKg1W+MHB7KjpO3XB0HJxx8lpi5G+Qgrzssb4uC+j3dbbpm0Pehr0CF4Q
	 f6VqENmlnyBbHpZbKmwngREW5Tety5kObYThhA7RQhA0WJgrmNMICSVD9afQg52oTp6bF
	 p+SM7y/7SxClfgp87dztH+xr38lsvnJdn6fCYK/F0XNyvdtWhRfyknuX8aik+XI60OQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793168007;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=e0iw4XAdxL4tr2TghLQuj3QSskA0uGzZUyPJIjJjnQI=;
	b=I+WtLGdr+aLz4IC202QZQhN7CEypiSx0GTgK50egVR2dRuKcaF4k4Gyyl7Q3dmd38sJf
	 dKuQ2q3EI8AYFuQjqH9jOisyaH1VIaxVV74Qo9lzaH4T7JA2Mr0AMAQnFiJTQvvJT+rOP
	 1MSLG+cIF1u2Omi5rOdyGSvIXV7dD/W6J+ZBOOiozColALoAjub2fRXq+egoR7FRi3P53
	 uM8cpvkpdffbCQNpO+KMSmW982wE7+AGX9+mQaevJm0LRqGSHRqsDHwuSi2dM23kCCvol
	 IlBeA3xiI+CGF8326NDuXJmxcFDV8pJ4LHZBKmiLtRfk2qUaNwRk1hs3WF4kRhVO7lA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793168007;
	bh=e0iw4XAdxL4tr2TghLQuj3QSskA0uGzZUyPJIjJjnQI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sIxQSCPU+op6BCjaGZHn9NFL9XezcflyFKwbROdDhtfFw/KmE5E1SNAd51SDPEWe0
	 0r15Ruayc4joc3rLU/fGkcyL1qm/WTMyDcd6EP0n1OHhi0WW/dWZV3xkPl8NtJc2sd
	 YUdcx2iDuTwAUatkavhzQ6MqJrWI38PXc3r61SQcoXUkf/LJ3BwxeQ+zrpj31A67j/
	 diR0mKvVHK1pKt5HuTpzFsMagDa32XSPt5Bb7oD4O7u1O2VIHv4snNH59nkQdSYGom
	 GN0JypcsiecZ1oiNX17fDoM3AHYb+o+Zo/J6HpjTQpC9jLl4ZCHVJukAU7C4ryFDSf
	 YDqkj48A5AqTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 896A980D5C;
	Wed, 28 Oct 2026 06:13:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EEB3DD1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:13:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E068D4016B
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:13:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rptVsBeaXjiD for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 06:13:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4C2774006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793168004;
 b=WldgOtdOFRXvwkb4GUnqtwzyFSXzxNVspVQVialrQS+7YdFX17JPt/5K7FCq4GvB0MWO
 ks8ithEleS/i7J1ElMcv/LBy1gFHWzrcrXk5l/ikmFwXaYr+D++7bfOyjGBxldeeqkKep
 xrUO77ldD5LWfJmoFExUqmtIFJ3eYFl1a48bl8Imrfg6H2d/DzkFuKsOEK9QNdU1nrCon
 E2JIH5wEZDaLbI8NboOuMFgeIeAUri3WYHnpWbMzp0o1E9b7y6EVeb9K/WVBDoPtFFicl
 sKwTLki31tj03+aotXwBKNKZYBPkIpFtNyUoR7ZL4PQ0i3c7i5+FzksWhD4KSebRCww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793168004;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
 X-Last-TLS-Session-Version;
 bh=e0iw4XAdxL4tr2TghLQuj3QSskA0uGzZUyPJIjJjnQI=;
 b=S9UbkHW8+msqnfxm7R+0icGcLGjXyvxCm8jRM024U/78PbNQc2KTajBwyuxKtsYZrXhs
 /jIYFclnFX5Y6j+tlETE3r1L/5mEwuEfAySLcdzm7oOBLEZ62wDJ40DCsgW2YTfZDaFV/
 GAo4JgoV/P+HKmCZvWl8e19guJLOf+XEG0La6N++jaMAe2EDIbaAQp0YhR78u6Q/Z7Hqk
 aLyDFhGtg/gK/N2jqQR1ErgQnuW3Dx6LmkMaTMDo17Fnjk3M+dlVOLKoHwANKJGZovc6T
 heQMld6/2The4xJhB9yQKftLQ7duwz7ZZISA/lbY/fy5JqhYQRUqEc+LNxDD4qZv40g==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=Np8pg43W; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=Np8pg43W
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4C2774006F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 06:13:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9A7B510BA4D; Wed, 28 Oct 2026 07:13:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1793167997; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=e0iw4XAdxL4tr2TghLQuj3QSskA0uGzZUyPJIjJjnQI=;
 b=Np8pg43Wg4v+G6AUTPqJbi5i0YR4kyCdjjlmfq25m0XXeuUrRxUqORN6uewE4LRsueA1Zs
 Bb8PSLk6bB7SVR5dDlwN2FjasNSQxpTYvLIgxZePVk8sJ+5uix8TJ/090RphHMnmbUYn39
 WLHNJOzFE71AmwIseKZYQRbDoOh9dj4X/oh+Jl94L6sfSTrxHe0gqMDCjrIHrlcVXmeuQT
 kRXxnKNm7+J/hzB/TgSageX0oYWJFLQT7D0gMJqlv6WfH5CvEWqrH7GXNsi20pgEGMX69P
 DX2Hp6DtqCXQFvx5nYrQp24f4f1dP4o6RMUKXYh0QuX8bWdEqYFUPmbFlLFIxA==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Johan Jonker <jbx6244@gmail.com>, Vignesh R <vigneshr@ti.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Simon Glass <sjg@chromium.org>, Heiko Schocher <hs@nabladev.com>,
 Alexey Charkov <alchark@flipper.net>,
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
Subject: [PATCH v3 0/7] mtd: Microchip 23K256 and 23LCV1024 SPI SRAM
Date: Wed, 28 Oct 2026 07:11:34 +0100
Message-ID: <20261028061231.39152-1-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The 23LCV1024 is a 1 Mbit serial SRAM with battery backup on an SPI
bus, used as non volatile scratch storage. This adds a driver for it
and for the 23K256 of the same family, plus a sandbox emulation and
unit tests.

The driver sits in UCLASS_MTD, the way the SPI NAND driver does, so
the device is reached through the mtd command. v1 put it in
UCLASS_SPI_FLASH to borrow the sf command, which meant shimming
struct spi_nor fields for a device with no flash semantics.

Patch 1 prepares the MTD core for devices which have no erase
function.

Patch 2 does the same for partitions on such a device, which are
aligned on the write size instead of the erase size the device does
not have. Without it "mtd list" divides by zero as soon as the device
tree gives the RAM partitions.

Patch 3 is the driver itself, now in drivers/mtd/devices/mchp23k256.c
without erase function, named after the Linux driver and with the
23K256 of the same family alongside the 23LCV1024.

Patch 4 is new in v3 and lets the imagemap test pick the SPI-NOR by the
partition it needs. It takes the first MTD block device today, which the
next patch takes away from it. Found by CI run:
https://dev.azure.com/hs0298/hs/_build/results?buildId=223&view=results

Patch 5 is the sandbox emulation and the tests. v2 had a patch before
it that taught the sandbox SPI bus to bind an emulation from a
sandbox,emul phandle. That patch is gone, mainline has the hook since
commit 3b748d780a37 ("sandbox: spi: Add SPI EEPROM emulator and DM
test"), so the emulation nodes sit at the root of test.dts the way the
EEPROM one does.

Patch 6 is new in v3 and does for the mtd command what patch 1 does
for the MTD core. Read, write and dump get through a device without an
erase size, and an erase is refused with a message.

Patch 7 is new in v3 as well and moves the transfers of the driver to
spi-mem, so that a controller which limits the transfer size or only
offers spi-mem operations works.

The series was tested on i.MX6 and i.MX8 hardware.

This series is now based on the current head of the main branch,
dfcfc4c9f78d ("Prepare v2027.01-rc1").

Azure build is clean:
https://dev.azure.com/hs0298/hs/_build/results?buildId=224&view=results

Changes in v3:
- Dropped the sentence saying nobody reads MTD_NO_ERASE, which is wrong,
  spi-nor sets it for SPI_NOR_NO_ERASE parts. Say instead why the check
  asks for erasesize and _erase (Simon)
- Mention the mtdpart.c hunk, a partition gets part_erase() only when
  its master has an _erase (Simon)
- Added Reviewed-by from Simon, as all comments are in, beside
  mtd_is_aligned_with_block_size() comment which is moved to patch
  "cmd: mtd: get through a device that has no erase size"
- The two alignment checks no longer rely on MTD_NO_ERASE being set
  correctly. An alignment of zero counts as 1 with a WARN_ON(), and the
  partition erase size is only taken when there is one (Simon)
- Updated the comment above the first check, which still spoke of the
  erase size alone (Simon)
- Added Reviewed-by from Simon
- Named after the Linux driver and moved to
  drivers/mtd/devices/mchp23k256.c, with CONFIG_MTD_MCHP23K256 and the
  driver name mchp23k256. drivers/mtd/devices/ is new in U-Boot, it is
  where the related parts of the family would go (Simon)
- Added the microchip,mchp23k256 compatible, 32 KiB with a two byte
  address, so that the name covers what the driver does. The address
  width comes from the per compatible data
- spi_ram_xfer() dropped, the driver calls spi_write_then_read(), which
  does the same two transfers (Simon)
- The message and the comment in the probe claimed the device powers up
  in byte operation. The data sheet (DS25156A, section 2.5) gives
  sequential as the default, and the Linux driver writes the MODE
  register all the same (Simon)
- Removed two comments in probe. The reason for selecting sequential
  operation is in the commit message, and mtd->_erase is set to NULL
  explicitly (even if that is redundant), so it is obvious that there
  is no erase function
- did not add Simons comment about the single 128k comment in this
  patch, instead moved that to a new patch:
  mtd: mchp23k256: move the transfers to spi-mem
- Added Reviewed-by from Simon
- New patch. Problem found on CI run:
  https://dev.azure.com/hs0298/hs/_build/results?buildId=223&view=results
  The next patch gives the test device tree two MTD devices of
  its own, one of which took the first mtd_blk away from this test
- The patch that taught the sandbox SPI bus to bind an emulation from a
  sandbox,emul phandle is gone. Mainline has that since commit
  3b748d780a37 ("sandbox: spi: Add SPI EEPROM emulator and DM test"),
  which looks the emulation up with uclass_get_device_by_phandle(). The
  emulation nodes therefore sit at the root of test.dts, bound by the
  device tree scan, and the tests no longer unbind anything by hand
- The emulation treats whatever follows the address in the first
  transfer as data, so it follows the data sheet rather than the way the
  driver splits its transfers. The test sends a write in a single
  transfer to cover it (Simon)
- The erase is asked for over the data that was written, so the check
  afterwards would see an erase that went through (Simon)
- spi_get_bus_and_cs() dropped, the emulation is looked up with the MTD
  device itself (Simon)
- The second partition sits at 0xa001, an offset no erase block boundary
  allows, and the comment says why that matters. 0xa000 was 8K aligned
  and proved nothing (Simon)
- The emulation powers up in sequential operation, as the data sheet
  says. The test puts it into byte operation and probes again to see the
  driver select the mode
- Added a test for the 23K256 with its own emulation instance, which is
  what the second compatible of the driver needs
- New patch. Patch 1 only covers mtd_erase(), the mtd command divides by
  the erase size before it ever gets there.
- New patch. Simon pointed out that a single spi_xfer() over the whole
  array fails where the SPI NAND driver would work

Changes in v2:
- New patch. The SRAM driver of patch 3 has no erase, which the old
  mtd_erase() would have turned into a NULL pointer jump
- New patch mtd: align a partition on the write size if the device cannot erase
  Testing on the board dropped for "mtd list" command:
  ### ERROR ### Please RESET the board ###
  This is because division by erase_size, which the SPI RAM driver
  sets to 0. Added for this case also sandbox test.
Added comments from Simon:
- Moved from UCLASS_SPI_FLASH to UCLASS_MTD, the way the SPI NAND
  driver sits. The struct spi_nor shim and the dm_spi_flash_ops are
  gone with it, and the device is reached through the mtd command
  rather than sf.
- Moved from drivers/mtd/spi/ to drivers/mtd/, where the other
  standalone MTD drivers live.
- Dropped the erase operation. v1 filled the range with 0xff from a
  malloc'd buffer and claimed the bus once per 1 KB chunk. A RAM needs
  no erase, and patch 1 makes mtd_erase() answer -EOPNOTSUPP.
- Dropped the linux/mtd/spi-nor.h include, spi_flash.h pulled it in
  anyway and it advertised a NOR driver.
- sprintf() into a fixed field replaced by snprintf() into a buffer the
  driver owns.
- Copyright: dropped the trailing full stop and added Stefan Bigler's
  address.
fixed checkpatch warning:
- Added a MAINTAINERS entry, as the move out of drivers/mtd/spi/
  dropped a checkpatch warning.
Added comments from Simon:
- The test drives the device through the MTD layer instead of the
  spi_flash uclass.
- Uses sandbox_spi_get_emul() rather than reaching into state->spi[][].
- Added a spi1 alias so that dev_seq() of the bus does not depend on
  probe order.
- The erase part checks for -EOPNOTSUPP now. The v1 comment about
  covering more than one staging step went with the erase loop.
- The emulation lives in its own node with its own compatible, which
  the sandbox SPI bus resolves the phandle to.
- Added the emulation and the test to the MAINTAINERS entry.
Found while Stefan Bigler tested the series on hardware:
- Added partitions to the device in the test device tree and a second
  test that writes through one of them, which is what "mtd list" on his
  board fell over.

Heiko Schocher (7):
  mtd: refuse an erase on a device that cannot erase
  mtd: align a partition on the write size if the device cannot erase
  mtd: add driver for the Microchip 23K256 and 23LCV1024 SPI SRAM
  test: boot: imagemap: pick the SPI-NOR by its partition
  test: dm: add a test for the Microchip 23K256 and 23LCV1024 SPI SRAM
  cmd: mtd: get through a device that has no erase size
  mtd: mchp23k256: move the transfers to spi-mem

 MAINTAINERS                              |   8 +
 arch/sandbox/dts/test.dts                |  49 ++++
 arch/sandbox/include/asm/test.h          |  18 ++
 cmd/mtd.c                                |  14 ++
 configs/sandbox_defconfig                |   2 +
 drivers/mtd/Kconfig                      |   2 +
 drivers/mtd/Makefile                     |   1 +
 drivers/mtd/devices/Kconfig              |  26 +++
 drivers/mtd/devices/Makefile             |   4 +
 drivers/mtd/devices/mchp23k256.c         | 220 ++++++++++++++++++
 drivers/mtd/devices/mchp23k256_sandbox.c | 268 ++++++++++++++++++++++
 drivers/mtd/mtdcore.c                    |   3 +
 drivers/mtd/mtdpart.c                    |  47 +++-
 drivers/spi/Kconfig                      |   2 +-
 test/boot/imagemap.c                     |  11 +-
 test/cmd/Makefile                        |   3 +
 test/cmd/mtd.c                           |  79 +++++++
 test/dm/Makefile                         |   1 +
 test/dm/mchp23k256.c                     | 272 +++++++++++++++++++++++
 19 files changed, 1015 insertions(+), 15 deletions(-)
 create mode 100644 drivers/mtd/devices/Kconfig
 create mode 100644 drivers/mtd/devices/Makefile
 create mode 100644 drivers/mtd/devices/mchp23k256.c
 create mode 100644 drivers/mtd/devices/mchp23k256_sandbox.c
 create mode 100644 test/cmd/mtd.c
 create mode 100644 test/dm/mchp23k256.c

---
base-commit: dfcfc4c9f78d1743f490a497082a4ec8e058aae8
branch: spi-ram-v3

-- 
2.55.0

