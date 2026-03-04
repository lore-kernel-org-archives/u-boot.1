Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAA0EFCE4C
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 22:26:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D206E83642;
	Wed,  4 Mar 2026 23:26:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D841838BB; Wed,  4 Mar 2026 23:26:11 +0100 (CET)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B8508063E
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 23:26:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 107)
 id 20BCA68C4E; Wed,  4 Mar 2026 23:26:07 +0100 (CET)
Received: from rocky.lan (dynamic-077-002-159-128.77.2.pool.telefonica.de
 [77.2.159.128])
 by verein.lst.de (Postfix) with ESMTPSA id A34CD6732A;
 Wed,  4 Mar 2026 23:25:53 +0100 (CET)
Date: Wed, 4 Mar 2026 23:25:48 +0100
From: Torsten Duwe <duwe@lst.de>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Pedro Falcato <pfalcato@suse.de>, Bin Meng <bmeng.cn@gmail.com>, Andrew
 Goodbody <andrew.goodbody@linaro.org>, Matthias Brugger
 <mbrugger@suse.com>, Andrea della Porta <andrea.porta@suse.com>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [hack] help U-Boot find the correct PCIe inbound offset for
 NVMe on Raspberry Pi 5
Message-ID: <20260304232548.630b15e3@rocky.lan>
In-Reply-To: <CALeDE9NK_KvEitadfcYJQXe7bjoM7JRH3gAh0UzrjtLyUjJjpQ@mail.gmail.com>
References: <20260302135940.550e6051@rocky.lan>
 <20260302164256.29af9995@rocky.lan>
 <khr5tpfjql6l5ide644d7x6v2km6m3u4jnlbxq5zsbqefui65i@dlwpybwg3fym>
 <CALeDE9NK_KvEitadfcYJQXe7bjoM7JRH3gAh0UzrjtLyUjJjpQ@mail.gmail.com>
Organization: LST e.V.
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; aarch64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 4 Mar 2026 20:24:35 +0000
Peter Robinson <pbrobinson@gmail.com> wrote:

> On Wed, 4 Mar 2026 at 19:43, Pedro Falcato <pfalcato@suse.de> wrote:
> >
> > Hi Torsten,
> >
> > On Mon, Mar 02, 2026 at 04:42:56PM +0100, Torsten Duwe wrote:
> > > On Mon, 2 Mar 2026 13:59:40 +0100
> > > Torsten Duwe <duwe@lst.de> wrote:
> > >
> > > > This proposed patch uses the already existent dev_phys_to_bus(),
> > > > which can dig up the correct offset from associated DT nodes and
> > > > subtract it.
> > >
> > > Just to make it clear, that patch is a necessary but not a sufficient
> > > condition to boot the RPi5 from NVMe. The PCIe bus node above
> > > the NVMe is generated dynamically has no DT node with dma-ranges and so
> > > dev_phys_to_bus() still returns zero. In order to test NVMe on the
> > > RPi5 you can either:
> > >
> >
> > Say I wanted to test NVMe booting on the pi5 (which I actually do).
> > I would need:
> > 1) this patch
> > 2) one of the two BUS_ADDR() related diffs
> > 3) the fixes posted in https://lore.kernel.org/u-boot/20251105163553.15F2A227AAC@verein.lst.de/
> 
> I believe that series has been replaced with:
> https://lore.kernel.org/u-boot/20260227152046.42DE068B05@verein.lst.de/T/#t

Yes. Or on patchwork: https://patchwork.ozlabs.org/project/uboot/list/?series=493779

> > 4) anything else?
> 
> Enable NVME support in the defconfig

NVME commands and NVME_PCI. CONFIG_NVME_PCI requires CONFIG_NVME.

	Torsten

