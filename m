Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C707FC3DA6E
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 07:46:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E86D987250;
	Fri,  5 Jan 2024 08:46:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Xc74IX3b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 107768745E; Fri,  5 Jan 2024 08:46:24 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FD5D86A81
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 08:46:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4057kDlt048467;
 Fri, 5 Jan 2024 01:46:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704440773;
 bh=oHc5Tizx4uk9I+78HQw9Q9hexHncvrkoSC33QS6a9mA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Xc74IX3bne7W6ZyC/eiEoae7FklSvPJ1WiiOaxNjJwTT6NFJbKZrpXP+ekoaryk7D
 SbgZhVL8YntRSNtjGgckWCaauW+aCF86+zsJhL3vUnLyJLSx7QQejtyyL2aTDZI85I
 dpLpW3jYNxultqRLYg+5bW7uQfezTaosdbFOIIJY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4057kD5n125907
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 5 Jan 2024 01:46:13 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Jan 2024 01:46:12 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Jan 2024 01:46:12 -0600
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4057kCMr061354;
 Fri, 5 Jan 2024 01:46:12 -0600
Date: Fri, 5 Jan 2024 13:16:11 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Nishanth
 Menon <nm@ti.com>, Roger Quadros <rogerq@kernel.org>,
 <vigneshr@ti.com>, <jonas@kwiboo.se>, <srk@ti.com>, <bb@ti.com>,
 <praneeth@ti.com>, <u-boot@lists.denx.de>,
 MD Danish Anwar <danishanwar@ti.com>
Subject: Re: [PATCH 1/2] board: ti: am62x: am62x.env: Fix boot_targets
Message-ID: <20240105074611.vizlp3vcsau44gct@uda0497581>
References: <20231106055351.f2fny5ys6avi5qnk@ula0497581>
 <20231106153159.GH496310@bill-the-cat>
 <736c04ab-9c48-4957-b242-fcbde0ace68b@ti.com>
 <CAPnjgZ1JTcybX9sRFQtddcwefLum6_+ynQSWbQ=4NVdO6eAxhg@mail.gmail.com>
 <7df59596-ac84-4e26-844f-3f3ad4bb0b7f@ti.com>
 <CAPnjgZ06tDBGko7RxO_ec1hKYqOhfhY9D7FdPiaVcDxaomeUDA@mail.gmail.com>
 <CAFLszTiNruYVsRjAaKdtpvjuK3YfQN92DDArRofUOnWo-1jXUw@mail.gmail.com>
 <e6e305c1-a233-4b0c-9f2f-ae3339b9688f@ti.com>
 <20240104075245.wkirozn7ifoxinbn@uda0497581>
 <7e7dde90-0711-4cce-b2ca-ab7369f36ae4@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e7dde90-0711-4cce-b2ca-ab7369f36ae4@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Andrew,

On 09:55-20240104, Andrew Davis wrote:
> On 1/4/24 1:52 AM, Manorit Chawdhry wrote:
> > Hi Andrew, Simon,
> > 
> > On 08:58-20240102, Andrew Davis wrote:
> > > On 12/31/23 6:48 AM, Simon Glass wrote:
> > > > Hi,
> > > > 
> > > > On Wed, Nov 29, 2023 at 7:48 PM Simon Glass <sjg@chromium.org> wrote:
> > > > > 
> > > > > Hi Andrew,
> > > > > 
> > > > > On Mon, 6 Nov 2023 at 11:05, Andrew Davis <afd@ti.com> wrote:
> > > > > > 
> > > > > > On 11/6/23 11:47 AM, Simon Glass wrote:
> > > > > > > Hi Andrew,
> > > > > > > 
> > > > > > > On Mon, 6 Nov 2023 at 10:27, Andrew Davis <afd@ti.com> wrote:
> > > > > > > > 
> > > > > > > > On 11/6/23 9:31 AM, Tom Rini wrote:
> > > > > > > > > On Mon, Nov 06, 2023 at 11:23:51AM +0530, Manorit Chawdhry wrote:
> > > > > > > > > > Hi Simon,
> > > > > > > > > > 
> > > > > > > > > > On 11:22-20231005, Simon Glass wrote:
> > > > > > > > > > > Hi Nishanth,
> > > > > > > > > > > 
> > > > > > > > > > > On Thu, 5 Oct 2023 at 11:16, Nishanth Menon <nm@ti.com> wrote:
> > > > > > > > > > > > 
> > > > > > > > > > > > On 12:10-20231005, Nishanth Menon wrote:
> > > > > > > > > > > > > On 12:36-20231005, Tom Rini wrote:
> > > > > > > > > > > > > > On Thu, Oct 05, 2023 at 09:19:48AM -0500, Andrew Davis wrote:
> > > > > > > > > > > > > > > On 10/4/23 8:54 AM, Nishanth Menon wrote:
> > > > > > > > > > > > > > > > On 08:48-20231004, Andrew Davis wrote:
> > > > > > > > > > > > > > > > > On 10/4/23 8:23 AM, Roger Quadros wrote:
> > > > > > > > > > > > > > > > > > ti_mmc is not a valid boot_target for standard boot flow so
> > > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > > Is there some way to make it into a valid boot_target? Otherwise
> > > > > > > > > > > > > > > > > how do we use uEnv.txt files, or boot from FIT images with overlays?
> > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > envboot takes care of uEnv.txt file (see
> > > > > > > > > > > > > > > > https://lore.kernel.org/all/20231004132324.44198-3-rogerq@kernel.org/)
> > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > Early remote proc loading and FIT image is a question for stdboot itself.
> > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > If stdboot is missing these features then we shouldn't switch until it
> > > > > > > > > > > > > > > has them. I'm all for switching to this, but only if it is complete.
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > Depends on what you mean?  Did you mean an option to run scripts
> > > > > > > > > > > > > > (exists) or an option to do what TI needs done, via
> > > > > > > > > > > > > > boot/bootmeth_something.c ?  If the latter, someone from TI needs to
> > > > > > > > > > > > > > figure out what that should be and do (but plumbing-wise everything it
> > > > > > > > > > > > > > needs should exist).
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Andrew is generalizing here (on the wrong patch though).
> > > > > > > > > > > > > 
> > > > > > > > > > > > > On am62x platforms, there is nothing regressing with this series. The
> > > > > > > > > > > > > challenge is early remote_proc loading which is done for J7* platforms.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > How that is initiated as part of bootmethods is something of a gap.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > The other gap has been support for uEnv.txt -> which we can workaround
> > > > > > > > > > > > > at the moment by using CONFIG_BOOTCOMMAND="run envboot; bootflow scan
> > > > > > > > > > > > > -lb" in defconfig (This series from Roger already does that - hence I am
> > > > > > > > > > > > > saying that Andrew is complaining on the wrong series).
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Ideally, we should just have CONFIG_BOOTCOMMAND="bootflow scan-lb" and
> > > > > > > > > > > > > uEnv.txt remoteproc loads and the various standard bootmethods should
> > > > > > > > > > > > > "just work".
> > > > > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > I forgot to add: FIT image authenticated boot flow. That is really what
> > > > > > > > > > > > ti_mmc distroboot method was trying to solve.
> > > > > > > > > > > > 
> > > > > > > > > > > > Maybe Simon or someone know how the stdboot flow handles authenticated
> > > > > > > > > > > > kernel image and dtb boot flow with FIT image?
> > > > > > > > > > > 
> > > > > > > > > > > Yes you can use FIT configuration verification and things should work as normal.
> > > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > Could you give any reference documentation for this?
> > > > > > > > > 
> > > > > > > > > I suspect you should start with doc/usage/fit/beaglebone_vboot.rst
> > > > > > > > > 
> > > > > > > > 
> > > > > > > >     From that doc:
> > > > > > > > 
> > > > > > > > ```
> > > > > > > > Boot the board using the commands below::
> > > > > > > > 
> > > > > > > >         setenv bootargs console=ttyO0,115200n8 quiet root=/dev/mmcblk0p2 ro rootfstype=ext4 rootwait
> > > > > > > >         ext2load mmc 0:2 82000000 /boot/image.fit
> > > > > > > >         bootm 82000000
> > > > > > > > ```
> > > > > > > > 
> > > > > > > > This is very much not stdboot :( This doc has some good and current info on building
> > > > > > > > a secure FIT image, but much of it is showing its age. Stdboot is still missing
> > > > > > > > 
> > > > > > > >      * ability to limit boot mode search to only one image (FIT)
> > > > > > > 
> > > > > > > What does this mean? Can you please be more specific or give an example?
> > > > > > > 
> > > > > > 
> > > > > > Sure, for instance with secure boot we only want to search for FIT images
> > > > > > and if for each media this fails we do not want to fall back to other
> > > > > > image types or boot modes (like UART boot or net boot which would bypass
> > > > > > the signature checks).
> > > > > 
> > > > > We could have something like:
> > > > > 
> > > > > bootstd {
> > > > >      image-types = "fit", "uimage";
> > > > > }
> > > > > 
> > > > > to limit the supported types.
> > > > > 
> > > > > > 
> > > > > > Something similar is needed for searching for EFI compatible boot across
> > > > > > each enabled boot media first, before trying other methods on each media.
> > > > > > Basically breadth-first search on each media type not depth-first.
> > > > > 
> > > > > How about:
> > > > > 
> > > > > bootstd {
> > > > >      scan-order = "bootmeth,bootdev";   // instead of default "bootdev,bootmeth";
> > > > > };
> > > > > 
> > > 
> > > This along with the image-types above seem reasonable. Might also help with
> > > our EFI search order issue (we need to search all boot media for EFI parts
> > > first before trying all the other types of boot on each media, basically
> > > breadth-first search vs depth for EFI). We should be able to describe that
> > > pattern here if we think this through.
> > > 
> > 
> > This seems okay and will solve the problem of the FIT Image issues and
> > fallback that we were having with stdboot.
> > 
> > > > > 
> > > > > > 
> > > > > > > >      * fetching and applying FIT overlay/config strings
> > > > > > > 
> > > > > > > Re overlays, is this the 'extension' command? What are config strings?
> > > > > > > 
> > > > > > 
> > > > > > When we have DT overlays in our FIT image, we build a string to pass to
> > > > > > bootm to apply all the selected overlays[0]. If there is now another
> > > > > > mechanism for this please let me know (building this string today is messy).
> > > > > > 
> > > > > > https://source.denx.de/u-boot/u-boot/-/blob/master/include/env/ti/ti_common.env?ref_type=heads#L18
> > > > > 
> > > > > My proposal for this is to implement extensions in FIT. This would
> > > > > have a new extensions nodes, so you can specify what extensions are
> > > > > available for each FIT configuration.
> > > > > 
> > > > > configurations {
> > > > >      conf-1 {
> > > > >         compatible = ...
> > > > >         extensions = "ext1", "ext-2";
> > > > >      };
> > > > > 
> > > > > extensions {
> > > > >      ext-1 {
> > > > >         fdto = "fdt-1";   // fdt overlay for this 'cape'
> > > > >         compatible = "vendor,combined-device1";
> > > > >         extensions = "ext3";
> > > > >      };
> > > > > 
> > > > >      ext-2 {
> > > > >         fdto = "fdto-2";   // fdt overlay for this 'cape'
> > > > >         compatible = "vendor,device2";
> > > > >      };
> > > > > 
> > > > >      ext-3 {
> > > > >         fdto = "fdto-3";
> > > > >         compatible = "vendor,device3";
> > > > >      };
> > > > > 
> > > > > So FIT configurations now have a list of supported extensions. The
> > > > > extensions are hierarchical so that you can have ext1 which can
> > > > > optionally have ext-2 as well. This allows boards which share a lot of
> > > > > 'capes' to be specified only ones.
> > > > > 
> > > > > Extensions actually present are declared by a sysinfo driver for the
> > > > > board, with new methods:
> > > > > 
> > > > > get_compat() - determine the compatible strings for the current platform
> > > > > get_ext() - get a list of compatible strings for extensions which are
> > > > > actually present
> > > > > 
> > > > > The extension compatible strings are used to select the correct things
> > > > > from the FIT, apply the overlays and produce the final DT.
> > > > > 
> > 
> > This is something that is still concerning me, so previously we used to
> > have two methods of applying overlays, one was through FIT Image where
> > we have the overlays embedded and in another we used to use non FIT
> > boot where the overlays were present in the filesystem only and we used
> > to apply them, this might solve the problem with FIT Image booting overlays but
> > normal kernel boot and dtb with overlays is still something that I don't
> > know would be possible or not with this. Is there any way to do that?
> > 
> > > 
> > > If we have a list of compatible strings and extensions, then do we need
> > > the extensions nodes? Couldn't each extension string simply be the name
> > > of the overlay ftdo-x node to apply?
> > > 
> > > > > > 
> > > > > > > >      * remote proc loading
> > > > > > > 
> > > > > > > What command can do this?
> > > > > > > 
> > > > > > 
> > > > > > https://source.denx.de/u-boot/u-boot/-/blob/master/include/env/ti/ti_common.env?ref_type=heads#L28
> > > > > 
> > > > > This could be a new property in bootstd:
> > > > > 
> > > > > bootstd: {
> > > > >      probe-before = <&phandle of remoteproc>, ...
> > > > > };
> > 
> > I think this can also work, the firmware names we can get from the dt
> > nodes and I think modifying the names to signed firmwares that we used
> > to do in the scripts can be handled in the driver itself.
> > 
> 
> We need to also think about where the firmware blobs themselves come
> from in this case. In fact we are having that discussion in a different
> thread right now[0].
> 
> My suggestion would be to have the firmware inside the FIT. This is
> already supported to some degree for normal firmware (TFA/OP-TEE/etc.).
> This way drivers do not need to deal with all the complexity of finding
> and loading blobs (they would have to replicate all the logic of stdboot
> to find the blobs correctly in all cases if the blobs are not in the
> same FIT that stdboot finds for us).
> 

How would we handle people who use non-FIT boot? If you are telling us
to pack these in tispl.bin/u-boot.img then am not sure if size could be
an issue otherwise it does seem scalable but I would be against packing
these in the Kernel FIT image as that would make no sense at all to me
with the complexity that FIT building already has and having additional
things to pack with multiple projects involved while generating the FIT.
Also, I don't want people to depend on FIT image and the old method of
using Kernel + DTB should still work and this approach won't help in
solving that.

Regards,
Manorit

> > Andrew, do you see anything else in this that cannot work?
> > 
> > > > > 
> > > > > > 
> > > > > > > >      * uEnv.txt processing
> > > > > > > 
> > > > > > > What command can do this?
> > > > > > > 
> > > > > > 
> > > > > > run envboot;
> > > > > > 
> > > > > > https://source.denx.de/u-boot/u-boot/-/blob/master/include/env/ti/mmc.env?ref_type=heads#L20
> > > > > 
> > > > > This could be a new bootmeth which looks for uenv.txt on available
> > > > > devices. It might be better to put the env in a FIT or something with
> > > > > a checksum.
> > 
> > We use non-FIT boot as well for our non HS platforms, I think the new
> > bootmeth might be helpful as you mentioned, would have to look at this
> > more as I thought bootmeth is supposed to boot a platform at the end
> > only but it seems like here we'll be combining this bootmeth ( that'll
> > just import the env ) and then other bootmeth will actually boot Linux.
> > 
> 
> As long as bootmeths can perform an action then continue with other
> bootmeths that could work. This might require complex logic though.
> For instance the uenv.txt bootmeth would only need run on some subset
> of available bootdevs, and it should scan all those devs for uenv.txt
> first, before the Linux finding bootmeths start.
> 
> Andrew
> 
> [0] https://lore.kernel.org/all/64a18d0a-294d-4e11-a867-4191e99f2437@ti.com/
> 
> > Regards,
> > Manorit
> > 
> > > > > 
> > > > > > 
> > > > > > > > 
> > > > > > > > Last two can be solved by adding to CONFIG_BOOTCOMMAND before calling`bootflow scan`
> > > > > > > > as suggested above. Until we figure out the first two I don't see us ready to switch.
> > > > > > > 
> > > > > > > I'm happy to help figure this out.
> > > > > > > 
> > > > > > 
> > > > > > Thanks, we are eager to standardize our boot flows and stdboot seems like the
> > > > > > right way forward, very happy to have your guidance on these last few items :)
> > > > > 
> > > > 
> > > > I'm just checking whether there is any feedback on the above? I sent
> > > > the FIT part as a separate proposal.
> > > > 
> > > 
> > > Manorit,
> > > 
> > > Does the above all work for you?
> > > 
> > > Andrew
> > > 
> > > > Regards,
> > > > Simon
