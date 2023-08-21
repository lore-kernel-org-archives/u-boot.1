Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FA1EE49AA
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 11:35:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8794A8700E;
	Mon, 21 Aug 2023 13:35:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B49CA86BF8; Mon, 21 Aug 2023 13:35:00 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 943688704F
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 13:34:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D09D72F4;
 Mon, 21 Aug 2023 04:35:37 -0700 (PDT)
Received: from e130802.arm.com (unknown [10.57.33.216])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02B913F762;
 Mon, 21 Aug 2023 04:34:55 -0700 (PDT)
Date: Mon, 21 Aug 2023 12:34:49 +0100
From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: sjg@chromium.org, u-boot@lists.denx.de, nd@arm.com, trini@konsulko.com
Subject: Re: [PATCH 1/2] drivers/mtd/nvmxip: Rework the read accessor to
 support 32bit systems
Message-ID: <20230821113449.GA230855@e130802.arm.com>
References: <20230813214659.441964-1-marek.vasut+renesas@mailbox.org>
 <7c03ac40-44af-0da9-d968-7d00f7ae96e3@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c03ac40-44af-0da9-d968-7d00f7ae96e3@mailbox.org>
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

Hi,

On Sat, Aug 19, 2023 at 02:23:02AM +0200, Marek Vasut wrote:
> On 8/13/23 23:46, Marek Vasut wrote:
> > Get rid of nvmxip_mmio_rawread() and just implement the readl()/readq()
> > reader loop within nvmxip_blk_read(). Cast the destination buffer as
> > needed and increment the read by either 4 or 8 bytes depending on if
> > this is systemd with 32bit or 64bit physical address.
> > 
> > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > ---
> > Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> > Cc: Simon Glass <sjg@chromium.org>
> 
> Sandbox CI test fails with this series:
> 
> https://source.denx.de/u-boot/custodians/u-boot-sh/-/pipelines/17427
> 
> https://u-boot.source-pages.denx.de/-/custodians/u-boot-sh/-/jobs/679256/artifacts/test-log.html
> 

I run the {host , blk_usb, blk_iter, blk_foreach, blk_flags} tests using the commit [1] preceding the NVMXIP patchset.
The tests fail as shown below [3]. I think these issues are not related to NVMXIP.

Regarding your comments for [2], I'll address them as soon as I can. 

[1]: b197f1f05dee730e173a0756cb1a5f2be5d3ba5b
[2]: https://lore.kernel.org/all/20230816110551.86930-2-abdellatif.elkhlifi@arm.com/
[3]: tests results:

host:

test/dm/host.c:44, dm_test_host(): 0 == host_attach_file(dev, filename): Expected 0x0 (0), got 0xfffffffe (-2)
Segmentation fault (core dumped)

blk_usb:

test/dm/blk.c:88, dm_test_blk_usb(): 6 == count_blk_devices(): Expected 0x6 (6), got 0x1 (1)
Bus usb@1: scanning bus usb@1 for devices... 2 USB Device(s) found
test/dm/blk.c:93, dm_test_blk_usb(): 6 == count_blk_devices(): Expected 0x6 (6), got 0x1 (1)
Test blk_usb failed 4 times

blk_iter:

test/dm/blk.c:188, dm_test_blk_iter(): 0 == blk_first_device_err(BLKF_FIXED, &dev): Expected 0x0 (0), got 0xffffffed (-19)
Segmentation fault (core dumped)

blk_foreach:

test/dm/blk.c:305, dm_test_blk_foreach(): 7 == found: Expected 0x7 (7), got 0x0 (0)
test/dm/blk.c:316, dm_test_blk_foreach(): 7 == found: Expected 0x7 (7), got 0x0 (0)
test/dm/blk.c:322, dm_test_blk_foreach(): 7 == found: Expected 0x7 (7), got 0x0 (0)
test/dm/blk.c:323, dm_test_blk_foreach(): 3 == blk_count_devices(BLKF_BOTH): Expected 0x3 (3), got 0x0 (0)
test/dm/blk.c:328, dm_test_blk_foreach(): 4 == found: Expected 0x4 (4), got 0x0 (0)
test/dm/blk.c:329, dm_test_blk_foreach(): 1 == blk_count_devices(BLKF_FIXED): Expected 0x1 (1), got 0x0 (0)
test/dm/blk.c:334, dm_test_blk_foreach(): 3 == found: Expected 0x3 (3), got 0x0 (0)
test/dm/blk.c:335, dm_test_blk_foreach(): 2 == blk_count_devices(BLKF_REMOVABLE): Expected 0x2 (2), got 0x0 (0)
...

blk_flags:

test/dm/blk.c:236, dm_test_blk_flags(): 0 == blk_find_first(BLKF_BOTH, &dev): Expected 0x0 (0), got 0xffffffed (-19)
test/dm/blk.c:237, dm_test_blk_flags(): dev = NULL: Expected non-null, got NULL
Segmentation fault (core dumped)

Cheers,
Abdellatif
