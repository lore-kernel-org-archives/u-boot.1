Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EF9C3ABBC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 15:57:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E75AE8210D;
	Tue,  6 May 2025 17:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Mrno1Ty4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC40D82153; Tue,  6 May 2025 17:57:06 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2345E820F6
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 17:57:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-7082ce1e47cso44355377b3.2
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 08:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746547023; x=1747151823; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qSnI81PkhFJc7teB539G+1fM0AcacJ2HmHFSWq6rUmg=;
 b=Mrno1Ty42+o52B+asT6PgCWMrnX7LNjjBnPh6LKTvO9E8tvp4z2n8rjfqVheo+f7wm
 kzvuTEZ6z7/CmmmsFMKDxmkSnkn29libdVM7AFwz8lo14iLQrf1saQLGQCkqIlzf17Q9
 S4nMdj5shwIiqWw3jwjEpIAGtTcFnBvKn30P4XuymM3WWBxdcbwv87/budkoOY4zLtJ9
 IDfh6G5HAevVmbBd5TMpo4fJCOh/2g+3SRuVWiRlK0+y0o8mmcy/debgAvVmhcErm3JY
 4ZYorhYa82ILDBwMAzJ3tNBoRnwDW2Z2tqtliqxia4X5AzoyttBP55NtLbYSs7fQJ8j2
 PGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746547023; x=1747151823;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qSnI81PkhFJc7teB539G+1fM0AcacJ2HmHFSWq6rUmg=;
 b=aSv6cqpoo+SiYbd2Y7qIQUuHoyogr6RGC1ddRNXg1jy0OGynQ6slKNdL2IMSgqoSwQ
 LZ682WBRSTm9pvJZeK5yaYFgvQQBNjRdPaauf95jGJzbR5zWcxd4jutNYJVYaDMPPYtQ
 tnc0lx9nbKAM9MgJSZLTBS9I4KVXkrUQcy7ygifQGD7dn/8Q+KmjZQwowKuDtOAJO5Z9
 z/86Za5A/+oCD0mQtd7OO+3wKD5yQ8eBoC+hp/VKQXhyuwFK+VrLifE3Tg4pkJNr+ibL
 8yqx1+Hbxdtq+yUYfjalcv6oQi+DJKEzkPnSf0ChcJELAyJLvwGeDA2BQ1Uoy+0Zpqf8
 mYEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVglyrDrcy9rgrTmNmSE7dbr/LeAUu1h5ViBqJkQGAn09kHgEi28S05dh1MQEuumXL+G92Mdi8=@lists.denx.de
X-Gm-Message-State: AOJu0YwlUSOBr1+VdQS4+NfmBPfEhPGiPldW4xtxgDElUjBMO4ht3QZa
 KrmlcuveTSgaHt193QTgShY8Gwq5rS65Np3dnqTYrZtfia/HkYEogV/KC9lB/1E/r+WWRR+S77/
 t+aWJykTglLV76fGofLh0UBeYwvULRxTqdLo1Ew==
X-Gm-Gg: ASbGnctvjwblL+SdKjie6d74pEry4wzOXoXCt2TFqB3NrnCWmOkQzgXSf2O+gIdDZMe
 g/xvGnRXOxIH7ckYcxVS4vRwMZJ8vbLvcp17bzwDv4dLqt8Rz5jTCj9qOYNpUGXgcbbWqi8grSV
 0fkaPtxK02NPM+SNanM+qevaU51YqLJhriNg==
X-Google-Smtp-Source: AGHT+IFqzKSwASvRPRmiRhOOJNzkymgatweYMkatpMcES5q6wLGnT9BMdDaasw+JRd86qErxyf66fTMWjaLoXGJvuaE=
X-Received: by 2002:a05:690c:6f84:b0:6f7:5a46:fe5f with SMTP id
 00721157ae682-709197aa3b2mr52035197b3.1.1746547022814; Tue, 06 May 2025
 08:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTiVuNqAzQ=hi5_Uq6Jo2EUJkDtE6_gDaU=LY8hAXiL8ww@mail.gmail.com>
 <279d1706-d140-409e-a74a-4f1d9eaef311@canonical.com>
 <875xieanhm.fsf@bloch.sibelius.xs4all.nl>
 <CAM=mAOnFrM_wa5SSWYWROoY+839L87A0cSx8-X=Hr=cHB9y3Tw@mail.gmail.com>
 <20250505195452.GK5430@bill-the-cat>
 <CAM=mAOkXoXZm8Bag3SN0DYD0NG_UeYub_vkhnF6X5ODurbrttw@mail.gmail.com>
 <20250505221024.GR5430@bill-the-cat>
 <c0c51cdb-107b-4ebb-abae-8494d9fc63ae@canonical.com>
 <20250505234319.GT5430@bill-the-cat> <87v7qe82av.fsf@bloch.sibelius.xs4all.nl>
 <20250506142950.GV5430@bill-the-cat>
In-Reply-To: <20250506142950.GV5430@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 6 May 2025 18:56:27 +0300
X-Gm-Features: ATxdqUEipZhUU-knxJAKBopmOvjMKhxDkN7cIAjtnmKu9wqO7wRB_6ZuqSydKRA
Message-ID: <CAC_iWjLvo3wAhzLCRHdV5f=GPrcS=5sVUcKRPUcCxJeYRYz-zQ@mail.gmail.com>
Subject: Re: [RFC 1/8] boot: EFI boot manager does not depend on BootOrder
To: Tom Rini <trini@konsulko.com>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, heinrich.schuchardt@canonical.com,
 sjg@chromium.org, tuomas.tynkkynen@iki.fi, patrick.rudolph@9elements.com, 
 mkorpershoek@kernel.org, u-boot@lists.denx.de
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

On Tue, 6 May 2025 at 17:29, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, May 06, 2025 at 12:24:24PM +0200, Mark Kettenis wrote:
> > > Date: Mon, 5 May 2025 17:43:19 -0600
> > > From: Tom Rini <trini@konsulko.com>
> > >
> > > On Tue, May 06, 2025 at 01:18:16AM +0200, Heinrich Schuchardt wrote:
> > > > On 5/6/25 00:10, Tom Rini wrote:
> > > > > On Tue, May 06, 2025 at 12:07:20AM +0200, Heinrich Schuchardt wrote:
> > > > > > Tom Rini <trini@konsulko.com> schrieb am Mo., 5. Mai 2025, 21:54:
> > > > > >
> > > > > > > On Mon, May 05, 2025 at 09:51:52PM +0200, Heinrich Schuchardt wrote:
> > > > > > > > Mark Kettenis <mark.kettenis@xs4all.nl> schrieb am Mo., 5. Mai 2025,
> > > > > > > 21:03:
> > > > > > > >
> > > > > > > > > > Date: Fri, 2 May 2025 18:08:56 +0200
> > > > > > > > > > From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > > > > > > > >
> > > > > > > > > > On 5/2/25 16:49, Simon Glass wrote:
> > > > > > > > > > > Hi Heinrich,
> > > > > > > > > > >
> > > > > > > > > > > On Mon, 21 Apr 2025 at 10:26, Heinrich Schuchardt
> > > > > > > > > > > <heinrich.schuchardt@canonical.com> wrote:
> > > > > > > > > > > >
> > > > > > > > > > > > The EFI boot manager bootmeth does not require variable BootOrder
> > > > > > > to
> > > > > > > > > be
> > > > > > > > > > > > preexisting. It creates this variable.
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Heinrich Schuchardt <
> > > > > > > heinrich.schuchardt@canonical.com
> > > > > > > > > >
> > > > > > > > > > > > ---
> > > > > > > > > > > >    boot/bootmeth_efi_mgr.c | 21 +++------------------
> > > > > > > > > > > >    1 file changed, 3 insertions(+), 18 deletions(-)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
> > > > > > > > > > > > index 42b8863815e..1669cbed5bd 100644
> > > > > > > > > > > > --- a/boot/bootmeth_efi_mgr.c
> > > > > > > > > > > > +++ b/boot/bootmeth_efi_mgr.c
> > > > > > > > > > > > @@ -47,30 +47,15 @@ static int efi_mgr_check(struct udevice *dev,
> > > > > > > > > struct bootflow_iter *iter)
> > > > > > > > > > > >
> > > > > > > > > > > >    static int efi_mgr_read_bootflow(struct udevice *dev, struct
> > > > > > > > > bootflow *bflow)
> > > > > > > > > > > >    {
> > > > > > > > > > > > -       struct efi_mgr_priv *priv = dev_get_priv(dev);
> > > > > > > > > > > > -       efi_status_t ret;
> > > > > > > > > > > > -       efi_uintn_t size;
> > > > > > > > > > > > -       u16 *bootorder;
> > > > > > > > > > > > -
> > > > > > > > > > > > -       if (priv->fake_dev) {
> > > > > > > > > > > > -               bflow->state = BOOTFLOWST_READY;
> > > > > > > > > > > > -               return 0;
> > > > > > > > > > > > -       }
> > > > > > > > > > > > +       int ret
> > > > > > > > > > > >
> > > > > > > > > > > >           ret = efi_init_obj_list();
> > > > > > > > > > > >           if (ret)
> > > > > > > > > > > >                   return log_msg_ret("init", ret);
> > > > > > > > > > > >
> > > > > > > > > > > > -       /* Enable this method if the "BootOrder" UEFI exists. */
> > > > > > > > > > > > -       bootorder = efi_get_var(u"BootOrder",
> > > > > > > > > &efi_global_variable_guid,
> > > > > > > > > > > > -                               &size);
> > > > > > > > > > > > -       if (bootorder) {
> > > > > > > > > > > > -               free(bootorder);
> > > > > > > > > > > > -               bflow->state = BOOTFLOWST_READY;
> > > > > > > > > > > > -               return 0;
> > > > > > > > > > > > -       }
> > > > > > > > > > > > +       bflow->state = BOOTFLOWST_READY;
> > > > > > > > > > > >
> > > > > > > > > > > > -       return -EINVAL;
> > > > > > > > > > > > +       return 0;
> > > > > > > > > > > >    }
> > > > > > > > > > > >
> > > > > > > > > > > >    static int efi_mgr_read_file(struct udevice *dev, struct
> > > > > > > bootflow
> > > > > > > > > *bflow,
> > > > > > > > > > > > --
> > > > > > > > > > > > 2.48.1
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > How do we know if the board is using EFI bootmgr? My understanding
> > > > > > > was
> > > > > > > > > > > that this was a way to find out?
> > > > > > > > > >
> > > > > > > > > > The boot manager must always run.
> > > > > > > > > >
> > > > > > > > > > The check for the BootOrder variable introduced in commit
> > > > > > > f2bfa0cb1794
> > > > > > > > > > is a bug.
> > > > > > > > >
> > > > > > > > > Well, at the time the boot manager did not attempt to boot the default
> > > > > > > > > path.  So there was no point in running the boot manager code unless
> > > > > > > > > BootOrder (or BootNext) was set.  And of course before that commit the
> > > > > > > > > boot manager didn't run at all on non-sandbox builds that had the
> > > > > > > > > standard boot stuff enebaled.
> > > > > > > > >
> > > > > > > > > Anyway, I believe the thinking behind that commit is still sound.  As
> > > > > > > > > I explained earlier, I think that...
> > > > > > > > >
> > > > > > > > > > The boot manager handles in sequence:
> > > > > > > > > >
> > > > > > > > > > * Try to boot as indicated by BootNext.
> > > > > > > > > > * Try to boot as indicated by BootOrder.
> > > > > > > > > > * Try to boot default path for available media.
> > > > > > > > > >     This will add Boot#### entries and update BootOrder.
> > > > > > > > >
> > > > > > > > > ...doing this all in a monolithic sequence isn't the best way to
> > > > > > > > > handle EFI boot in the u-boot ecosystem.
> > > > > > > > >
> > > > > > > > > Your series moves the boot manager further down the list because the
> > > > > > > > > third step in the sequence has to happen late.  But as a result
> > > > > > > > > BootNext and BootOrder processing will also happen late.  So what
> > > > > > > > > happens if you have a board with two OS installations:
> > > > > > > > >
> > > > > > > > > 1. A generic Linux distro that boots via EFI.
> > > > > > > > >
> > > > > > > > > 2. Something like Armbian that provides an extlinux.conf file.
> > > > > > > > >
> > > > > > > > > Currently such a system will probably boot OS #1.  But after your
> > > > > > > > >
> > > > > > > >
> > > > > > > > This did not happen with distoboot. So migration from distroboot to
> > > > > > > > standard boot results in a change that you want to avoid.
> > > > > > > >
> > > > > > > > changes it will probably boot OS #2.  And if OS #1 sets BootOrder or
> > > > > > > > > BootNext that will not change anything.
> > > > > > > > >
> > > > > > > > > So I think we need a solution where BootNext and BootOrder processing
> > > > > > > > > happens early, like we do now.
> > > > > > > > >
> > > > > > > >
> > > > > > > > As of today BootNext does not invoke the boot manager.
> > > > > > > >
> > > > > > > > If BootOrder is set the boot manager may fail because not all devices are
> > > > > > > > detected as "hunters" have not been running. E.g. nvme scan and usb start
> > > > > > > > are only invoked after the EFI boot manager.
> > > > > > > >
> > > > > > > > I originally suggested to probe all boot devices before the boot manager
> > > > > > > > runs, but users complained that this slows down their non-EFI boot flows.
> > > > > > > > This is why I now move it after all boot methods but PXE.
> > > > > > >
> > > > > > > Can we not see what BootOrder is and then ensure it's been "hunted" ?
> > > > > > >
> > > > > > > --
> > > > > > > Tom
> > > > > > >
> > > > > >
> > > > > > A load option may only contain the partition GUID and the file path. In
> > > > > > this case you wouldn't be able to tell whether it is for an NVMe drive, or
> > > > > > a USB stick.
> > > > > >
> > > > > > As numbering of devices cannot be expected to be stable, it is preferable
> > > > > > to use this short form of device paths for load options.
> > > > >
> > > > > Ah, OK. So could we check and if not found print a human understandable
> > > > > error message, and continue on? I want to figure out some path that does
> > > > > not change the pre-bootstd behavior.
> > > > >
> > > >
> > > > In distroboot scan_dev_for_efi is invoked for every boot device and each
> > > > time calls the boot manager. As usb start is only called in usb_boot this
> > > > will result in behavior that is as non-compliant with the UEFI
> > > > specification.
> > > >
> > > > We should reach a behavior that complies with the UEFI specification.
> > > > Not changing former distro boot behavior is not a valid option.
> > >
> > > Can we also not figure out some way to boot promptly? I was thinking
> > > something along the lines of if we know BootOrder (or similar), we try
> > > it. If we don't find it, we try again a bit later on when we can run all
> > > the hunting that might be slow. If the only option is slow-but-compliant
> > > I feel like a lot of use cases will opt out of using EFI boot instead.
> >
> > I think that is possible.  But it will require tighter integration
> > integration between the EFI loader and the standard boot device
> > hunting code such that devices are probed as we walk to options
> > specified by the BootOrder.
> >
> > A complication here is that a Boot#### option doesn't necessearily
> > have the device encoded into the boot option.  An option can reference
> > just the GUID of a partition and many OS installers create such
> > options.  So if we see such an option we do need to probe devices
> > until we find the right partition.
>
> Right, I recall Heinrich mentioned it could (might often be?) a GUID
> instead and so we might need to hunt, check what we found for a GUID,
> repeat. I am assuming that would not be an expensive operation however.

Yes and that's the main problem here.
In EFI you have long and short options. The long one is the full
device path, which we can easily map to a device. The short is a bit
trickier as Heinrich described -- but because it's more flexible
that's what people tend to use.

Thanks
/Ilias

>
> --
> Tom
