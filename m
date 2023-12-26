Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFF7C3DA6E
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 01:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 461CE87800;
	Tue, 26 Dec 2023 02:47:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YZWcFC9M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7EF687809; Tue, 26 Dec 2023 02:47:04 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F556877F3
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 02:46:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9fa45e75ed9so423830566b.1
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 17:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703555219; x=1704160019; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Kp0iO9MLpJ1htL+HnTxpbuwR7jrk45u/OCjiU3NMYz8=;
 b=YZWcFC9MkvXj0nQIhdMn1WrYbBfAxrYhjebvIJrGtzz39N1uYCtMT8ZT8vq6pxIpw4
 cBYlH6x3zD1N1Fwz4C1oHnff8ggWWaGgKFjVs2W6yU2umIh8h4fCJbc9rFzZWCiIreDD
 VwzH+X1dANGqE0fzTVRIwY9zJ3PDPNnZzZBC2Ss4//hiE03Z+4Hv2y0P+MrxV8wNScm4
 Xbr7jiueHGjY6wL0QibkflGzRIYRdIIx1VfzYQdlbbN66nakvIczfW8YOTkcysRtSLzb
 oLIc3bemyxRaCGusEOlFtniKNKJvcWxopZwDfoBJ6OfvdbTiYIr5Tq+pIYJLaGPFBh6f
 xBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703555219; x=1704160019;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kp0iO9MLpJ1htL+HnTxpbuwR7jrk45u/OCjiU3NMYz8=;
 b=Q5cFc8vbwbMm9/e/OZs5WsAYoJnTRXUlr9RtuvJOgvHA8P5uNeEatYT+++e4HTy7Vz
 mNVauW//pQg4ZiaC59i2IlpBwvJOAwicw/GfUNxTMeP1jnbKFNPioRxBaIx0Z6FTJkC1
 yr6duzKq7wbvukeC/QZ8Nss95npFs/nT+i2gs8gwwGJWEyC9hiZ/VZ1/Y71tlyD270us
 a8P+J3aJyPmB2rp899P6geLjbEqaiGf9UxKhTgYfI5xxKhRbTF31J7xpBG/lLEjt1p4v
 Qi3Vy2VQASx/dyjiZfvOQIfyt9kk9621v4Yq2M/MJGN9H8lgWO/q6Q7wLAstjAhZY9Ct
 jprA==
X-Gm-Message-State: AOJu0YwHu3oIG+4cB/Qcl2wwFMYeVh1zTHsSmyqmpx3GVy2hvRPcdmpu
 jf/oaY1GTq7NWyPp1db+ZY1SDUyHqVaV/49qp4JUEFfiYjy6EA==
X-Google-Smtp-Source: AGHT+IEU7SBygAQmUnPk5Kgxx2+DV9olYpDxtR3QDK3kIQYVfv1x/hM2Br2MX+e+g/gn7u1l3M43UsABifUwf/N0vEU=
X-Received: by 2002:a17:906:1d1:b0:a23:6c74:52cd with SMTP id
 17-20020a17090601d100b00a236c7452cdmr2050361ejj.3.1703555218959; Mon, 25 Dec
 2023 17:46:58 -0800 (PST)
MIME-Version: 1.0
References: <20231225044356.626900-1-masahisa.kojima@linaro.org>
 <20231225044356.626900-4-masahisa.kojima@linaro.org>
 <4a113752-6a6a-451e-a142-42fcfb0993a5@gmx.de>
In-Reply-To: <4a113752-6a6a-451e-a142-42fcfb0993a5@gmx.de>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Tue, 26 Dec 2023 10:46:47 +0900
Message-ID: <CADQ0-X8yWY9YH1NZG=MKC5-kK3OZR5LVQ16Dde+Y59mh=qZT-Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] efi_loader: create common function to free struct
 efi_disk_obj
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Takahiro Akashi <takahiro.akashi@linaro.org>, u-boot@lists.denx.de
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

On Mon, 25 Dec 2023 at 19:31, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 12/25/23 05:43, Masahisa Kojima wrote:
> > Current error handling of creating raw disk/partition has
> > following issues.
> >   - duplicate free for efi handle, efi handle is already freed
> >     in efi_delete_handle()
>
> I cannot see where this patch reduces the number of efi_delete_handle()
> invocations.

Duplicate free() calls occur here in the original code:
> > -     efi_delete_handle(&diskobj->header);
> > -     free(diskobj->volume);
> > -     free(diskobj);

efi_delete_handle(&diskobj->header) will free the handle(=
&diskobj->header, = diskobj).
So calling  free(diskobj) should be avoided.

>
> >   - missing free for struct efi_device_path and
> >     struct efi_simple_file_system_protocol in some error paths
> >
> > To address those issue, this commit creates the common function
> > to free the struct efi_disk_obj resources and calls it in case
> > of error.
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> >   lib/efi_loader/efi_disk.c | 23 ++++++++++++++++-------
> >   1 file changed, 16 insertions(+), 7 deletions(-)
> >
> > diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> > index 415d8601ba..d2ac2fab9b 100644
> > --- a/lib/efi_loader/efi_disk.c
> > +++ b/lib/efi_loader/efi_disk.c
> > @@ -372,6 +372,19 @@ static int efi_fs_exists(struct blk_desc *desc, int part)
> >       return 1;
> >   }
> >
> > +static void efi_disk_free_diskobj(struct efi_disk_obj *diskobj)
> > +{
> > +     struct efi_device_path *dp = NULL;
>
> This NULL value is never used.

Yes, initialize it with diskobj->dp.

>
> > +     struct efi_simple_file_system_protocol *volume = NULL;
>
> ditto

OK.

>
> > +
> > +     dp = diskobj->dp;
> > +     volume = diskobj->volume;
> > +
> > +     efi_delete_handle(&diskobj->header);
>
> efi_delete_handle() may fail.

I assume this function efi_disk_free_diskobj() is called only from
the error path.(I should note as a comment)
I think it is better to ignore errors in efi_delete_handle() and proceed to
free the other resources.

>
> > +     efi_free_pool(dp);
>
> The device path may only be freed if it has been uninstalled from the
> handle.

Sorry, I'm not sure if I understand this comment correctly, but device_path
is uninstalled in efi_delete_handle().

>
> > +     free(volume);
>
> The simple file protocol interface may only be freed if it has been
> uninstalled from the handle.

Same as above, all protocols on the handle are uninstalled in
efi_delete_handle().

>
> > +}
> > +
> >   /**
> >    * efi_disk_add_dev() - create a handle for a partition or disk
> >    *
> > @@ -529,9 +542,7 @@ static efi_status_t efi_disk_add_dev(
> >       }
> >       return EFI_SUCCESS;
> >   error:
> > -     efi_delete_handle(&diskobj->header);
> > -     free(diskobj->volume);
> > -     free(diskobj);
> > +     efi_disk_free_diskobj(diskobj);
> >       return ret;
> >   }
> >
> > @@ -570,8 +581,7 @@ static int efi_disk_create_raw(struct udevice *dev, efi_handle_t agent_handle)
> >               return ret;
> >       }
> >       if (efi_link_dev(&disk->header, dev)) {
> > -             efi_free_pool(disk->dp);
> > -             efi_delete_handle(&disk->header);
> > +             efi_disk_free_diskobj(disk);
> >
> >               return -EINVAL;
> >       }
> > @@ -625,8 +635,7 @@ static int efi_disk_create_part(struct udevice *dev, efi_handle_t agent_handle)
> >               return -1;
> >       }
> >       if (efi_link_dev(&disk->header, dev)) {
> > -             efi_free_pool(disk->dp);
> > -             efi_delete_handle(&disk->header);
> > +             efi_disk_free_diskobj(disk);
>
> In efi_disk_add_dev we have opened a protocol interface. We must close
> it before removing the partition handle otherwise the disk handle can
> never be removed.
>
> To do this all properly we will need to re-implement this code using
> proper EFI drivers which expose a driver binding protocol. Please, add a
> TODO: comment here that closing the protocol is missing.

OK, I will check on this.

Thanks,
Masahisa Kojima


>
> Best regards
>
> Heinrich
>
> >
> >               return -1;
> >       }
>
