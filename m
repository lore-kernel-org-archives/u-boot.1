Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6FEE9A03A
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 19:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49A1183AC5;
	Tue, 17 Feb 2026 20:28:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50E0483B99; Tue, 17 Feb 2026 20:28:38 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A73A83981
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 20:28:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vsQjz-000000008UA-0vfL; Tue, 17 Feb 2026 19:28:11 +0000
Date: Tue, 17 Feb 2026 19:28:03 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de,
 John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
Subject: Re: [RFC PATCH 00/20] boot: add OpenWrt boot method and on-demand
 FIT loading
Message-ID: <aZTBQykqCt7H8H4W@makrotopia.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <20260217181358.GE2747538@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217181358.GE2747538@bill-the-cat>
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

On Tue, Feb 17, 2026 at 12:13:58PM -0600, Tom Rini wrote:
> On Mon, Feb 16, 2026 at 09:21:14PM +0000, Daniel Golle wrote:
> > Hi all,
> > 
> > This RFC series adds a new boot method for OpenWrt's "uImage.FIT with
> > embedded rootfs" firmware model, along with the underlying infrastructure
> > to load FIT images on-demand directly from storage devices without copying
> > them entirely to RAM first.
> > 
> > I would like to discuss the design with U-Boot maintainers and fellow
> > OpenWrt developers before submitting a formal patch series.
> [snip]
> > Three storage backends:
> > 
> >   - Block device (eMMC, SD, SATA, NVMe, USB mass storage, virtio)
> >   - MTD (SPI-NOR, raw NOR, raw NAND with bad block skipping)
> >   - UBI volume (SPI-NAND, raw NAND)
> > 
> > The "bootm" command is extended to accept a storage device specification
> > instead of a RAM address:
> > 
> >   bootm mmc 0:4         # boot FIT from eMMC partition 4
> >   bootm mtd recovery    # boot FIT from MTD partition "recovery"
> >   bootm ubi recovery    # boot FIT from UBI volume "recovery"
> > 
> > This infrastructure is independently useful beyond the OpenWrt boot
> > method. Any board that stores a FIT image directly in a partition
> > (rather than as a file on a filesystem) can benefit from on-demand
> > subimage loading.
> 
> For the user interface portion of this, since this is implementing
> bootmeths, this should all be handled under bootflow/bootdev/etc
> commands, and not adding further options to bootm.

I thought it would be useful independently of bootmeth/bootflow/bootdev
for `bootm` to have these options, as it will allow to gradually migrate
a large number of our downstream boards. Many of them at this point
still require scripts to handle things like extracting MAC addresses
from flash (in ways the original vendor has decided to store them),
updating U-Boot or TF-A blobs, ... and migrating all of that to use
bootmeth/bootflow/... will take time.

In the meantime, already getting rid of (duplicate) scripts "read
firmware from mmc/ubi/mtd" would be feasible, is less of a burden and
easy to test for people who got the respective board at hand.

Also, testing loading (partial) images directly from storage outside
of bootmeth has been very useful during development.

Would it be an option to hide the new bootm cmdline features behind an
additional Kconfig option maybe?

> 
> Since you're also talking about an A/B mechanism, looking at the RAUC
> support may also be helpful as that's another widely deployed
> methodology we support now via standard boot.

Yes, I've looked into RAUC and it has (more or less) recently gained
support for UBI, which indeed brings it closer to being useful in the
context of OpenWrt.

Due to OpenWrt having a read/write overlayfs typically covering all
raiming space on flash, using a symmetric A/B mechanism is not feasible
in many cases, especially if space is limited (typical: 128 MB
SPI-NAND), as both A and B would require independent r/w overlayfs,
effectively halfing the space available for users. Configuration being
synced across A and B (which may be different versions) is another
non-trivial problem. Hence, OpenWrt has opted to implement a production
vs. recovery dual-boot model when ever we have the choice to do so. The
recovery system doesn't have any persistent state, hence elimintating
the need for finding an arrangement regarding the read/write overlay
filesystem, or keeping configuration in-sync across different versions
of the firmware.

RAUC also defines the firmware format, which for OpenWrt often isn't an
option as we like to remain compatible with the vendor/stock firmware
formats (in 90%+ of cases: uImage.FIT or legacy uImage, sometimes with
appended metadata)

Apart from that, the dependencies required for RAUC on the target
(OpenSSL, libglib2, libdbus, expat, ...) are overkill for many smaller
OpenWrt devices. We've made big efforts to avoid FreeDesktop-land and
have created userspace tools which require only a fraction of the
resources. We offer free choice of the TLS provider library (OpenSSL,
mbedTLS and wolfSSL are 1st class citizens; there is some support gnuTLS
as well), and having only one of them installed. A hard dependency on
OpenSSL alone is already a show-stopper for anything to be considered
becoming part of the core infrastructure. Requiring an XML parser would
end the conversation.

I consider it as extremely unlikely that this will ever change for
OpenWrt, and we do consider that as one of our strengths. The total size
of a fully usable OpenWrt installation currently starts at around 6 MiB
on low-end targets (that does include the kernel and all drivers, as
well as mbedTLS and everything else needed for a router or WiFi access
point, including a Web UI).

Random examples

- ultra low-end device: NEC Aterm WR8750N

https://downloads.openwrt.org/releases/24.10.5/targets/ath79/tiny/openwrt-24.10.5-ath79-tiny-nec_wr8750n-squashfs-sysupgrade.bin


- aforementioned BananaPi R3 WiFi 6 DBDC router:

https://downloads.openwrt.org/releases/24.10.5/targets/mediatek/filogic/openwrt-24.10.5-mediatek-filogic-bananapi_bpi-r3-sdcard.img.gz

(SD card image which can be used directly, or to install to SPI-NAND,
SPI-NOR or eMMC)
