Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74262EEC2B3
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 00:13:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 789BA83642;
	Tue, 24 Feb 2026 01:13:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 458BE83935; Tue, 24 Feb 2026 01:13:29 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 989AE8063E
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 01:13:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vug2n-000000001Qu-1JFR; Tue, 24 Feb 2026 00:12:53 +0000
Date: Tue, 24 Feb 2026 00:12:48 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
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
Subject: Re: [RFC PATCH 08/20] boot: image-loader: add UBI volume backend
Message-ID: <aZztAL-RQ1LSf0-j@makrotopia.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
 <47725c58588200f631c918a56b770454d5721954.1771275704.git.daniel@makrotopia.org>
 <CAFLszThSKbRjufnj4z4xunn-OEUv8kNRngNQ3=EpaNyvyV5ncg@mail.gmail.com>
 <aZc_f3lrmRdE9c3Z@makrotopia.org>
 <CAFLszTgxMeFvKx8nkVUa_PADiVFnv1UB69SyD+C3OiLY_7ku8w@mail.gmail.com>
 <aZypXx3liLvvB4zr@makrotopia.org>
 <a1d06225-bc17-411a-80ed-f39e0450dc29@iopsys.eu>
 <64a12e61-8e04-472e-8493-90b2e4a41d50@iopsys.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64a12e61-8e04-472e-8493-90b2e4a41d50@iopsys.eu>
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

On Mon, Feb 23, 2026 at 10:32:32PM +0300, Mikhail Kshevetskiy wrote:
> 
> On 2/23/26 22:30, Mikhail Kshevetskiy wrote:
> > There are UBI based block storage emulation, see CONFIG_UBI_BLOCK
> > commits: 
> > * 9daad11ad178646c288aca3615a7ba1e6039aed3 ("drivers: introduce UBI
> > block abstraction")
> > * aa5b67ce226267440e64fadc57d3a21e5842027c ("disk: support UBI partitions")
> >
> There is the block storage abstraction for mtd devices as well.

During my evening walk outside I thought about this a bit more, and if
it would be possible to use the ubiblock and mtdblock devices instead of
introducing dedicated bootdevs and imagemap backends for both of them.
In the simple case of only a single boot option this would probably
work: bootmeth_openwrt detects the uImage.FIT on the raw block device
and may go ahead, load and launch it.

However, there is often more than one of them. And as they are stored in
directly on MTD partitions or UBI volumes, knowing the name of the
partition or volume, and which device it sits on is crucial for
bootmeth_openwrt, which should support also complex multi-slot dual-boot
arrangement, typically identifying the slots by UBI volume name or MTD
partition name. When using the mtdblock or ubiblock devices this
information is hidden, and can only be accessed in a very tricky way,
especially for ubiblock devices, which lack a device parent. Matching
the UCLASS type of the device parent of a block device in the bootmeth
also feels sketchy and inappropriate.

So while having mtdblock and ubiblock devices is generally nice,
especially if U-Boot has to access a filesystem (eg. squashfs) stored on
them, for the case of OpenWrt it would at least be a bit ugly, as the
metadata of the actual storage backend (MTD or UBI) is crucial. We need
the UBI volume name or the label of the MTD partition.

In a way you could say that OpenWrt uses block devices (eg. MMC) it
boots from more like MTD, and not the other way around. And in some way,
bootmeth_openwrt will do some extra lifting when started on a block
device (extract the GPT partition name and present it as the bootflow's
fname), while the imagemap API provides an abstraction to read raw
images from all three storage backends (blk, mtd, ubi).

That being said, I'm happy we have overcome things like block2mtd or
gluebi, and do use the appropriate APIs (and filesystem types) on each
class of storage devices in OpenWrt nowadays. Some of the helpful
patterns borrowed from our MTD and UBI boot flows (avoiding a boot
filesystem, identifying storage volumes, ...) remain, however, and are
applied equally also on block storage (ie. MMC).

tl;dr: We'd rather use block2mtd than using mtdblock ;)
