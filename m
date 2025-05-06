Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741DFC3ABBF
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 10:24:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9714800D7;
	Tue,  6 May 2025 12:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="sXzjwyPo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 957CE80BAE; Tue,  6 May 2025 12:24:29 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 477B7800C1
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 12:24:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: b3dd8283-2a64-11f0-beb8-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id b3dd8283-2a64-11f0-beb8-005056992ed3;
 Tue, 06 May 2025 12:27:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=R+wEW+ikNsakiSGHAPdY7uqCewDCbPbWCKcNvArSAxc=;
 b=sXzjwyPoLINqUMcYoE1Cey1MrGrl3QYqAkNbb8JeYG+aJwTlL9Vh/aZVhO8SHZ9tZQPZMs8Bmc5oL
 L0L0rYdE+Hm7pOVEnDpRAWyOkPlnAzwo/xRhsPJIOjOQpNgVFoZJC7EnCjhXM77/YsE/7OUd4rvQ4m
 wMuYUdeqnBta6xU5L3raO6BG/SNd/VI9aQV8qBW8CDkhjjc6RoBcZ6T2Bx82E8ckh8xBecWRcbZr9U
 mu7sI5eC52D6G8sJBl+yiV22qCkJGg36eh62ZO1JGgHu8yXLOrxREbPcXiRUfLnGQYG6uk70iLsdPH
 q9EtUe/TjRoPzpMTDjaTq0M2yVzyg4Q==
X-KPN-MID: 33|yfGRisgevrjubmFl9le5PLAWmdqkkqdpt+brEUXuCpzew87ycEejVCFiQZECeCg
 lrvw+wKPo6b2s3PahB6yuBei03csoZ9sG/tzgjAn58mY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|tX0Xp0mWx9mcd02upYmXvnPGIn/qfBRu+h1iYaWFafGcDwFW3+ZZj2xKwtwOb6m
 jXKVRT7ODoVm3Ks4x1J57Rw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 4860a936-2a64-11f0-9dba-00505699b758;
 Tue, 06 May 2025 12:24:26 +0200 (CEST)
Date: Tue, 06 May 2025 12:24:24 +0200
Message-Id: <87v7qe82av.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Tom Rini <trini@konsulko.com>
Cc: heinrich.schuchardt@canonical.com, sjg@chromium.org,
 ilias.apalodimas@linaro.org, tuomas.tynkkynen@iki.fi,
 patrick.rudolph@9elements.com, mkorpershoek@kernel.org,
 u-boot@lists.denx.de
In-Reply-To: <20250505234319.GT5430@bill-the-cat> (message from Tom Rini on
 Mon, 5 May 2025 17:43:19 -0600)
Subject: Re: [RFC 1/8] boot: EFI boot manager does not depend on BootOrder
References: <20250421162555.1200687-1-heinrich.schuchardt@canonical.com>
 <20250421162555.1200687-2-heinrich.schuchardt@canonical.com>
 <CAFLszTiVuNqAzQ=hi5_Uq6Jo2EUJkDtE6_gDaU=LY8hAXiL8ww@mail.gmail.com>
 <279d1706-d140-409e-a74a-4f1d9eaef311@canonical.com>
 <875xieanhm.fsf@bloch.sibelius.xs4all.nl>
 <CAM=mAOnFrM_wa5SSWYWROoY+839L87A0cSx8-X=Hr=cHB9y3Tw@mail.gmail.com>
 <20250505195452.GK5430@bill-the-cat>
 <CAM=mAOkXoXZm8Bag3SN0DYD0NG_UeYub_vkhnF6X5ODurbrttw@mail.gmail.com>
 <20250505221024.GR5430@bill-the-cat>
 <c0c51cdb-107b-4ebb-abae-8494d9fc63ae@canonical.com>
 <20250505234319.GT5430@bill-the-cat>
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

> Date: Mon, 5 May 2025 17:43:19 -0600
> From: Tom Rini <trini@konsulko.com>
> 
> On Tue, May 06, 2025 at 01:18:16AM +0200, Heinrich Schuchardt wrote:
> > On 5/6/25 00:10, Tom Rini wrote:
> > > On Tue, May 06, 2025 at 12:07:20AM +0200, Heinrich Schuchardt wrote:
> > > > Tom Rini <trini@konsulko.com> schrieb am Mo., 5. Mai 2025, 21:54:
> > > > 
> > > > > On Mon, May 05, 2025 at 09:51:52PM +0200, Heinrich Schuchardt wrote:
> > > > > > Mark Kettenis <mark.kettenis@xs4all.nl> schrieb am Mo., 5. Mai 2025,
> > > > > 21:03:
> > > > > > 
> > > > > > > > Date: Fri, 2 May 2025 18:08:56 +0200
> > > > > > > > From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > > > > > > 
> > > > > > > > On 5/2/25 16:49, Simon Glass wrote:
> > > > > > > > > Hi Heinrich,
> > > > > > > > > 
> > > > > > > > > On Mon, 21 Apr 2025 at 10:26, Heinrich Schuchardt
> > > > > > > > > <heinrich.schuchardt@canonical.com> wrote:
> > > > > > > > > > 
> > > > > > > > > > The EFI boot manager bootmeth does not require variable BootOrder
> > > > > to
> > > > > > > be
> > > > > > > > > > preexisting. It creates this variable.
> > > > > > > > > > 
> > > > > > > > > > Signed-off-by: Heinrich Schuchardt <
> > > > > heinrich.schuchardt@canonical.com
> > > > > > > > 
> > > > > > > > > > ---
> > > > > > > > > >    boot/bootmeth_efi_mgr.c | 21 +++------------------
> > > > > > > > > >    1 file changed, 3 insertions(+), 18 deletions(-)
> > > > > > > > > > 
> > > > > > > > > > diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> > > > > > > > > > index 42b8863815e..1669cbed5bd 100644
> > > > > > > > > > --- a/boot/bootmeth_efi_mgr.c
> > > > > > > > > > +++ b/boot/bootmeth_efi_mgr.c
> > > > > > > > > > @@ -47,30 +47,15 @@ static int efi_mgr_check(struct udevice *dev,
> > > > > > > struct bootflow_iter *iter)
> > > > > > > > > > 
> > > > > > > > > >    static int efi_mgr_read_bootflow(struct udevice *dev, struct
> > > > > > > bootflow *bflow)
> > > > > > > > > >    {
> > > > > > > > > > -       struct efi_mgr_priv *priv = dev_get_priv(dev);
> > > > > > > > > > -       efi_status_t ret;
> > > > > > > > > > -       efi_uintn_t size;
> > > > > > > > > > -       u16 *bootorder;
> > > > > > > > > > -
> > > > > > > > > > -       if (priv->fake_dev) {
> > > > > > > > > > -               bflow->state = BOOTFLOWST_READY;
> > > > > > > > > > -               return 0;
> > > > > > > > > > -       }
> > > > > > > > > > +       int ret
> > > > > > > > > > 
> > > > > > > > > >           ret = efi_init_obj_list();
> > > > > > > > > >           if (ret)
> > > > > > > > > >                   return log_msg_ret("init", ret);
> > > > > > > > > > 
> > > > > > > > > > -       /* Enable this method if the "BootOrder" UEFI exists. */
> > > > > > > > > > -       bootorder = efi_get_var(u"BootOrder",
> > > > > > > &efi_global_variable_guid,
> > > > > > > > > > -                               &size);
> > > > > > > > > > -       if (bootorder) {
> > > > > > > > > > -               free(bootorder);
> > > > > > > > > > -               bflow->state = BOOTFLOWST_READY;
> > > > > > > > > > -               return 0;
> > > > > > > > > > -       }
> > > > > > > > > > +       bflow->state = BOOTFLOWST_READY;
> > > > > > > > > > 
> > > > > > > > > > -       return -EINVAL;
> > > > > > > > > > +       return 0;
> > > > > > > > > >    }
> > > > > > > > > > 
> > > > > > > > > >    static int efi_mgr_read_file(struct udevice *dev, struct
> > > > > bootflow
> > > > > > > *bflow,
> > > > > > > > > > --
> > > > > > > > > > 2.48.1
> > > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > How do we know if the board is using EFI bootmgr? My understanding
> > > > > was
> > > > > > > > > that this was a way to find out?
> > > > > > > > 
> > > > > > > > The boot manager must always run.
> > > > > > > > 
> > > > > > > > The check for the BootOrder variable introduced in commit
> > > > > f2bfa0cb1794
> > > > > > > > is a bug.
> > > > > > > 
> > > > > > > Well, at the time the boot manager did not attempt to boot the default
> > > > > > > path.  So there was no point in running the boot manager code unless
> > > > > > > BootOrder (or BootNext) was set.  And of course before that commit the
> > > > > > > boot manager didn't run at all on non-sandbox builds that had the
> > > > > > > standard boot stuff enebaled.
> > > > > > > 
> > > > > > > Anyway, I believe the thinking behind that commit is still sound.  As
> > > > > > > I explained earlier, I think that...
> > > > > > > 
> > > > > > > > The boot manager handles in sequence:
> > > > > > > > 
> > > > > > > > * Try to boot as indicated by BootNext.
> > > > > > > > * Try to boot as indicated by BootOrder.
> > > > > > > > * Try to boot default path for available media.
> > > > > > > >     This will add Boot#### entries and update BootOrder.
> > > > > > > 
> > > > > > > ...doing this all in a monolithic sequence isn't the best way to
> > > > > > > handle EFI boot in the u-boot ecosystem.
> > > > > > > 
> > > > > > > Your series moves the boot manager further down the list because the
> > > > > > > third step in the sequence has to happen late.  But as a result
> > > > > > > BootNext and BootOrder processing will also happen late.  So what
> > > > > > > happens if you have a board with two OS installations:
> > > > > > > 
> > > > > > > 1. A generic Linux distro that boots via EFI.
> > > > > > > 
> > > > > > > 2. Something like Armbian that provides an extlinux.conf file.
> > > > > > > 
> > > > > > > Currently such a system will probably boot OS #1.  But after your
> > > > > > > 
> > > > > > 
> > > > > > This did not happen with distoboot. So migration from distroboot to
> > > > > > standard boot results in a change that you want to avoid.
> > > > > > 
> > > > > > changes it will probably boot OS #2.  And if OS #1 sets BootOrder or
> > > > > > > BootNext that will not change anything.
> > > > > > > 
> > > > > > > So I think we need a solution where BootNext and BootOrder processing
> > > > > > > happens early, like we do now.
> > > > > > > 
> > > > > > 
> > > > > > As of today BootNext does not invoke the boot manager.
> > > > > > 
> > > > > > If BootOrder is set the boot manager may fail because not all devices are
> > > > > > detected as "hunters" have not been running. E.g. nvme scan and usb start
> > > > > > are only invoked after the EFI boot manager.
> > > > > > 
> > > > > > I originally suggested to probe all boot devices before the boot manager
> > > > > > runs, but users complained that this slows down their non-EFI boot flows.
> > > > > > This is why I now move it after all boot methods but PXE.
> > > > > 
> > > > > Can we not see what BootOrder is and then ensure it's been "hunted" ?
> > > > > 
> > > > > --
> > > > > Tom
> > > > > 
> > > > 
> > > > A load option may only contain the partition GUID and the file path. In
> > > > this case you wouldn't be able to tell whether it is for an NVMe drive, or
> > > > a USB stick.
> > > > 
> > > > As numbering of devices cannot be expected to be stable, it is preferable
> > > > to use this short form of device paths for load options.
> > > 
> > > Ah, OK. So could we check and if not found print a human understandable
> > > error message, and continue on? I want to figure out some path that does
> > > not change the pre-bootstd behavior.
> > > 
> > 
> > In distroboot scan_dev_for_efi is invoked for every boot device and each
> > time calls the boot manager. As usb start is only called in usb_boot this
> > will result in behavior that is as non-compliant with the UEFI
> > specification.
> > 
> > We should reach a behavior that complies with the UEFI specification.
> > Not changing former distro boot behavior is not a valid option.
> 
> Can we also not figure out some way to boot promptly? I was thinking
> something along the lines of if we know BootOrder (or similar), we try
> it. If we don't find it, we try again a bit later on when we can run all
> the hunting that might be slow. If the only option is slow-but-compliant
> I feel like a lot of use cases will opt out of using EFI boot instead.

I think that is possible.  But it will require tighter integration
integration between the EFI loader and the standard boot device
hunting code such that devices are probed as we walk to options
specified by the BootOrder.

A complication here is that a Boot#### option doesn't necessearily
have the device encoded into the boot option.  An option can reference
just the GUID of a partition and many OS installers create such
options.  So if we see such an option we do need to probe devices
until we find the right partition.

Another complication is that currently the
efi_bootmgr_update_media_device_boot_option() function will append
Boot#### options it creates to the BootOrder variable.

This is used to implement the following requirement in the spec:

  The boot manager must also support booting from a short-form device
  path that starts with the first element being a File Path Media
  Device Path (File Path Media Device Path ). When the boot manager
  attempts to boot a short-form File Path Media Device Path, it will
  enumerate all removable media devices, followed by all fixed media
  devices, creating boot options for each device.

However, a the spec also says that:

  These new boot options must not be saved to non volatile storage,
  and may not be added to BootOrder.

But we we do add those options to BootOrder and we I believe we will
save those new Boot#### options as well.
