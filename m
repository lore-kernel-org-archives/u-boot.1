Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A74EC1452
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 13:53:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A70B383F2D;
	Tue,  3 Mar 2026 14:53:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5267783F4C; Tue,  3 Mar 2026 14:53:40 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B3C083E7F
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 14:53:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vxQBf-000000004zH-47lK; Tue, 03 Mar 2026 13:53:24 +0000
Date: Tue, 3 Mar 2026 13:53:16 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Harsha Vardhan V M <h-vm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Chen-Yu Tsai <wens@kernel.org>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Sky Huang <SkyLake.Huang@mediatek.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/5] misc: fs_loader: fix ubifs not unmounted on
 dev_get_priv error
Message-ID: <aabnzMx4LPEl-mjk@makrotopia.org>
References: <20260303132916.5502-1-ansuelsmth@gmail.com>
 <20260303132916.5502-2-ansuelsmth@gmail.com>
 <aabkOylaIZO0w7gF@makrotopia.org>
 <69a6e585.050a0220.1492ea.9245@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69a6e585.050a0220.1492ea.9245@mx.google.com>
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

On Tue, Mar 03, 2026 at 02:43:29PM +0100, Christian Marangi wrote:
> On Tue, Mar 03, 2026 at 01:38:03PM +0000, Daniel Golle wrote:
> > On Tue, Mar 03, 2026 at 02:29:08PM +0100, Christian Marangi wrote:
> > > When dev_get_priv errors out, the ubifs is not unbounted (if used)
> > 
> > I don't understand why or where UBIFS is being used here.
> > Did you mean to say "UBI is not attached"?
> > UBI != UBIFS.
> >
> 
> Function that is not called is umount_ubifs. That calls cmd_ubifs_umount.
> unbounted is a typo for unmounted.

Ok, so it *is* UBIFS, because you cannot mount UBI. You can only
"attach" an MTD partition to serve as UBI device (`ubi part ...` command
in U-Boot).

> 
> Probably the confusion is present already in the FS loader driver where ubi
> needed to be used instead of ubifs?

If you are loading a file from a directory and rely on full POSIX-like
permissions, file ownership, ... then you need a proper filesystem, like
UBIFS, or SquashFS, ...
If all you need is to load raw data early at boot, using a static UBI
volume to hold the raw data is probably better (see below).

> 
> There are mount_ubifs and umount_ubifs but they should have been mount_ubi and
> umount_ubi ? But then they use ubifs cmd OPs. I'm a bit confused here.

UBIFS is a read/write filesystem used on top of UBI.

UBI is a bit like a light version of LVM2, you can have multiple named
volumes, dynamically create them, rename or resize them.

Volumes can be static (ie. write-once, CRC32 over the whole volume
which is validated on access) or dynamic (no CRC validation, content
may change).

Inside dynamic volumes you may have either a filesystem or just raw
data. Any read-only filesystem can be used on top of UBI with the help
of ubiblock devices (eg. squashfs, erofs, ...).

In static volumes you typically store raw data, like it is the case
for U-Boot SPL loading U-Boot proper from UBI requires u-boot.bin
stored in a raw static volume, **not** inside a filesystem).

Imho using static volumes also makes a lot of sense for storing
those PHY or Ethernet firmware blobs, potentially even storing them
redundantly (ie. two static volumes, if one got broken CRC, move on
to the next one).


>  
> > > 
> > > Correctly handle this handle condition and while at it also return -EINVAL
> > > instead of -ENOMEM as a better error since no memory is allocated but is
> > > actually an invalid scenario for fw_get_filesystem_firmware().
> > > 
> > > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > > ---
> > >  drivers/misc/fs_loader.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
> > > index 2928cf75f89e..7e432a7ebd62 100644
> > > --- a/drivers/misc/fs_loader.c
> > > +++ b/drivers/misc/fs_loader.c
> > > @@ -178,8 +178,10 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
> > >  
> > >  	struct firmware *firmwarep = dev_get_priv(dev);
> > >  
> > > -	if (!firmwarep)
> > > -		return -ENOMEM;
> > > +	if (!firmwarep) {
> > > +		ret = -EINVAL;
> > > +		goto out;
> > > +	}
> > >  
> > >  	ret = fs_read(firmwarep->name, (ulong)map_to_sysmem(firmwarep->data),
> > >  			firmwarep->offset, firmwarep->size, &actread);
> > > -- 
> > > 2.51.0
> > > 
> 
> -- 
> 	Ansuel
