Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C112C48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 10:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFFF7876A9;
	Mon, 19 Feb 2024 11:53:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HO5ewQ74";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 596E7876BA; Mon, 19 Feb 2024 11:53:40 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E1B586FB2
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 11:53:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-563c403719cso4057347a12.2
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 02:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708340014; x=1708944814; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jsG2wdpl5e38ovTd6PrATmvXtKk90lAMa8V7xK6FCH8=;
 b=HO5ewQ74y+EAq0myLK+aeoEkxzR2XDatdjv6WdN8pqGRgryFD7YnDpki5HDELzWjx6
 6W/ZaALX1rv3KF0oK20cjU2N3lhbByy/q88pKGvGoKT1dUFd0rULxp4XRYo6dKr6S5+t
 ss13ZFXPMPPJQ2lBhZSlDslOmQrOBqTtr10JXbUs0Zj72lZLjMd9xMEW13Nb5UoFytMb
 1ITiEFvfI48tU3B6PrKYXJ87i8Ca61aT384TomYjdVhA0oXeBeOp8UyeaVtZDj1rUq9u
 2Knjx36rbFutn7FGUFoz0LC0+N/f5t8y4fBdOxeydwond5uUF2clGU2rlPBAYLCtrysJ
 8dXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708340014; x=1708944814;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jsG2wdpl5e38ovTd6PrATmvXtKk90lAMa8V7xK6FCH8=;
 b=Q6zg4Uufu8Al9cpRgnfcw2+8onCEPbLx1Ad+avpOKlNMvTeiEKWVIms7TrQx4Qe9YR
 8kWNDQ3aBaZUo+V1M717+ejkHIZdARSc+hJWjmU1g1TxsfSrug2JpFJ/rwQiJFxRPUq8
 x/HbD7pfjPWBodkeJnMVBW5hMH+ASA4w52/NzzhbpwtKWjSSybZHUTv873yalRZY1Hct
 OqqneGV4naB6HVCUJiVkWM4iLKPbzKdFuTzL2MhIRiFloUUBe1UjrhN0AjuHwXhqxUay
 ZUiHMKi3dt+nNvFyaX6Txp28pkc9jAoqwaRWNNUgjI1hC3wD8YpDb13ZX7dgOJrqnjeP
 HAsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4Wah5QIWk6Yc1q/5T/vKCJPNo6U3x8XTk3NTIZ1cQOuh/ZPjJkU6xnll/cXJ3HCjp1mGZUm0TK/d1T4A7P+LdmtIgRw==
X-Gm-Message-State: AOJu0Yzk+ewm58yi9Ft+6X2rfQXL1KbJStR8r7/+2AAVy+uiWMqkO42V
 /u1E3R+ijG5jDR52dIWeBdhhGELvix1IWx8u9iq2LUdGvU1803w7XZabzUoCBCO24eYid2Obsne
 8wukWl6HnZD1+GuHnYrU3Nz/Nhxo=
X-Google-Smtp-Source: AGHT+IHc4PtBXIM5jq32I9YKfpjwzedcgNB5PhvrUx23rKbOZRLCB+HXK8fA8kWCmpgeu7e9OR48rkQRuC0TYZ5Ky2k=
X-Received: by 2002:a05:6402:5d93:b0:564:5bc2:a866 with SMTP id
 if19-20020a0564025d9300b005645bc2a866mr2175377edb.41.1708340014057; Mon, 19
 Feb 2024 02:53:34 -0800 (PST)
MIME-Version: 1.0
References: <20240219091220.1022422-1-pbrobinson@gmail.com>
 <878r3gn44l.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <878r3gn44l.fsf@bloch.sibelius.xs4all.nl>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 19 Feb 2024 10:53:22 +0000
Message-ID: <CALeDE9OPB5XSPvHKXJd-TXgd+gkBTBeji-hWpRTNQBppLz1OEw@mail.gmail.com>
Subject: Re: [PATCH] disk: dos: Add all options for EFI System Partitions
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: trini@konsulko.com, sjg@chromium.org, ilias.apalodimas@linaro.org, 
 u-boot@lists.denx.de
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

On Mon, 19 Feb 2024 at 10:24, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Peter Robinson <pbrobinson@gmail.com>
> > Date: Mon, 19 Feb 2024 09:12:15 +0000
> >
> > The EFI spec states that the ESP can be any of FAT12/16/32 but for
> > compatibility doesn't necssarily require the partition to be the
> > EFI partition table ID of 0xef. A number of arm devices will not
> > find their firmware on a FAT partition with an ID of 0xef so also
> > allow the original FAT12/16/32 partition IDs as they are also
> > permissable for an ESP.
>
> Hi Peter,
>
> Any reason not to include 0x0c as well?  That is what we use on
> OpenBSD/armv7 and OpenBSD/arm64.  And as far as I know all UEFI
> implementations (on arm64 at least) boot from such a partition.

I wasn't 100% the support with LBA so I erred with caution, but no
reason I can't add it.

> (And yes, we use that partition type because we want to have a
> bootable image that works on the various Raspberry Pi models).

Yes, that is the same reason for us, plus a few other random other Arm
devices that won't recognise EF as VFAT and won't boot.

> That said, what problem does this fix?  And what happens if we have
> both a 0xea and a 0x01/0x06/0x0b/0x0c partition?  In that case U-Boot
> should probably prefer the 0xea over the others as the ESP.

The reason is because the support to write EFI vars on ESP, and yes I
realise it's got security issues but for most boards it's the least of
their problem, as the support won't do that without the flag and you
get a bunch of these on boot:

No EFI system partition
Failed to persist EFI variables

As for multiple partitions UEFI should handle that and I believe the
EFI var support has logic around which partition it chooses.

> Oh, and while your're at it, the hex constants are a bit inconsistent
> (0x1/0x6 vs. 0x0b).

Will fix with v2 when I add 0x0c, I'll await other feedback for a bit.

Thanks,
Peter

> Cheers,
>
> Mark
>
> > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> > ---
> >  disk/part_dos.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/disk/part_dos.c b/disk/part_dos.c
> > index 567ead7511d..303eb1d13ee 100644
> > --- a/disk/part_dos.c
> > +++ b/disk/part_dos.c
> > @@ -40,6 +40,12 @@ static int get_bootable(dos_partition_t *p)
> >  {
> >       int ret = 0;
> >
> > +     if (p->sys_ind == 0x1)
> > +             ret |= PART_EFI_SYSTEM_PARTITION;
> > +     if (p->sys_ind == 0x6)
> > +             ret |= PART_EFI_SYSTEM_PARTITION;
> > +     if (p->sys_ind == 0x0b)
> > +             ret |= PART_EFI_SYSTEM_PARTITION;
> >       if (p->sys_ind == 0xef)
> >               ret |= PART_EFI_SYSTEM_PARTITION;
> >       if (p->boot_ind == 0x80)
> > --
> > 2.43.1
> >
> >
