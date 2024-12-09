Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8A8E7717F
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 02:29:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEBD789575;
	Mon,  9 Dec 2024 03:29:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XxrF1+ud";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED4C9893A7; Mon,  9 Dec 2024 03:29:02 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CF2D88E51
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 03:29:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aa689a37dd4so71269466b.3
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 18:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733711340; x=1734316140; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ky6Xf+uSOjKM4E5bf8dPDDAudiahszEDWCTgt/YiY6w=;
 b=XxrF1+udw4nsKXeBnRXMXSoJGLUydv2IN2GyZTtN0MoWafrDJAIqzjco1FMX8rgYTw
 WGi57oKNq4ZXtv2Cf4bY+5YzhTQihC+H69KupmAE0WVFNLiSDhKW0eyLJN9dlZmEBqu9
 54yTYkSEhfmojiAN9A/k0GzRYcfiI94gFrGdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733711340; x=1734316140;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ky6Xf+uSOjKM4E5bf8dPDDAudiahszEDWCTgt/YiY6w=;
 b=Ija5Bao49aJw5wVP5BTDBHG4TMUvdZ6qxKrp79vbS8dC/GodeLD43XwTSRpPP+xQgn
 mjhr7xU9fK3eb6SwDO0cyWbRcBWZKTqc3PaJmxObHu7LIqg1LgPM36UsxYFAN5zFIeLK
 lXt7UBN25HRTSs9S3WTO0q2zF6hhXa0Ksqet5MgCUo0+Bu3Xlvl9k/a6Iidda/mCsDr2
 kRLCSgaJxWTIP6mmUF0vv/xmDOb87Qg38eDmVY1Y7WjQSrmw2unRVTBx4ms10RA52VVk
 7/shDdFKBFo8+rY9ORuSHow66XVRjRuLththB0hhMDcTbQaUit3hixCNOLzHF3HgYWWN
 Aa2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvqLOt6XC+VDmszaSGq7Ne5Z4BePFHqGxV/EooGycGBnafsfXskvOLJxJzE/sFXK3eEVy00R8=@lists.denx.de
X-Gm-Message-State: AOJu0YxpqRtrSnRoZipBldMk1juGtQbQLm5xE1/OQmfuy0X+b9//f8yQ
 9Gyte98eH5NbGkDpp2wPL4S+F6mXOVPLRRyhns7EWKpgWkUw2ZQkecsrq8U5r0zgPov8GhbmP/y
 /40rCpGw74URMCttQmBwfhjxWdZi/E2OHNwdM
X-Gm-Gg: ASbGncvDCNqFgTDyVmnIFg17rpPl4au9Gy8d2r4zrUwGAl0yjXubosR6Xp/U95GS+OX
 oH7tTZDCA0wCIaAljy9M12G+f9JZfiu+D
X-Google-Smtp-Source: AGHT+IFIz8LyJIRzH8gl0+jZk5U+cibPA+UgcbwvX/I6D0M8Ys1y5uQqjVgSFEiLmxw+uC88gR47vPX3eCZo/h+35eA=
X-Received: by 2002:a17:907:7742:b0:aa6:762e:8c1c with SMTP id
 a640c23a62f3a-aa6762eaa97mr394113666b.48.1733711339867; Sun, 08 Dec 2024
 18:28:59 -0800 (PST)
MIME-Version: 1.0
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-10-mjg59@srcf.ucam.org>
 <CAC_iWj+-wS9Kc4PJCi07q+LuJ172wSD5S4-moEFkst236wOJsg@mail.gmail.com>
In-Reply-To: <CAC_iWj+-wS9Kc4PJCi07q+LuJ172wSD5S4-moEFkst236wOJsg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 8 Dec 2024 19:28:48 -0700
Message-ID: <CAFLszTjmP_X-g3n+s+N9H9-g8Y88t-DufgFQ1qgTG4D2-6ktuA@mail.gmail.com>
Subject: Re: [PATCH 09/10] Fix efi_bind_block.
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, u-boot@lists.denx.de, 
 Janis Danisevskis <jdanisevskis@aurora.tech>,
 Matthew Garrett <mgarrett@aurora.tech>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

Hi Ilias,

On Mon, 25 Nov 2024 at 06:41, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Matthew, Janis,
>
> On Sat, 23 Nov 2024 at 21:57, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> >
> > From: Janis Danisevskis <jdanisevskis@aurora.tech>
> >
> > efi_bind_block had two issues.
> > 1. A pointer to a the stack was inserted as plat structure and thus used
> > beyond its life time.
>
> Yep and I wonder how the device_unbind() code managed to survice since
> it free that stack allocated memory...
> Probably never called.

:-)

>
> > 2. Only the first segment of the device path was copied into the
> > platfom data structure resulting in an unterminated device path.
> >
> > Signed-off-by: Janis Danisevskis <jdanisevskis@aurora.tech>
> > Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
> > ---
> >
> >  lib/efi/efi_app_init.c | 29 +++++++++++++++++++++--------
> >  1 file changed, 21 insertions(+), 8 deletions(-)
> >
> > diff --git a/lib/efi/efi_app_init.c b/lib/efi/efi_app_init.c
> > index 9704020b749..cc91e1d74b8 100644
> > --- a/lib/efi/efi_app_init.c
> > +++ b/lib/efi/efi_app_init.c
> > @@ -19,6 +19,15 @@
> >
> >  DECLARE_GLOBAL_DATA_PTR;
> >
> > +static size_t device_path_length(const struct efi_device_path *device_path)
> > +{
> > +       const struct efi_device_path *d;
> > +
> > +       for (d = device_path; d->type != DEVICE_PATH_TYPE_END; d = (void *)d + d->length) {
> > +       }
> > +       return (void *)d - (void *)device_path + d->length;
> > +}
>
> We already define efi_dp_size(), you can use that here.

Unfortunately that is only available in EFI_LOADER. Should we try to
split some of the code out to lib/efi ?

>
> > +
> >  /**
> >   * efi_bind_block() - bind a new block device to an EFI device
> >   *
> > @@ -39,19 +48,23 @@ int efi_bind_block(efi_handle_t handle, struct efi_block_io *blkio,
> >                    struct efi_device_path *device_path, int len,
> >                    struct udevice **devp)
> >  {
> > -       struct efi_media_plat plat;
> > +       struct efi_media_plat *plat;
> >         struct udevice *dev;
> >         char name[18];
> >         int ret;
> > -
> > -       plat.handle = handle;
> > -       plat.blkio = blkio;
> > -       plat.device_path = malloc(device_path->length);
> > -       if (!plat.device_path)
> > +       size_t device_path_len = device_path_length(device_path);
> > +
> > +       plat = malloc(sizeof(struct efi_media_plat));
> > +       if (!plat)
> > +               return log_msg_ret("plat", -ENOMEM);
> > +       plat->handle = handle;
> > +       plat->blkio = blkio;
> > +       plat->device_path = malloc(device_path_len);
> > +       if (!plat->device_path)
>
> you need to free plat here now

I will send a patch.

>
> >                 return log_msg_ret("path", -ENOMEM);
> > -       memcpy(plat.device_path, device_path, device_path->length);
> > +       memcpy(plat->device_path, device_path, device_path_len);
> >         ret = device_bind(dm_root(), DM_DRIVER_GET(efi_media), "efi_media",
> > -                         &plat, ofnode_null(), &dev);
> > +                         plat, ofnode_null(), &dev);
> >         if (ret)
> >                 return log_msg_ret("bind", ret);
> >
> > --
> > 2.47.0
> >

Regards,
Simon
