Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF0FC48BC3
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 12:59:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEDDB87DE8;
	Mon, 19 Feb 2024 13:59:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iaTCnLrB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC44E87DE8; Mon, 19 Feb 2024 13:59:23 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D025987DE9
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 13:59:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-512be6fda52so294465e87.0
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 04:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708347542; x=1708952342; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Uz9bDrDXKrYCEujzY3ZB9qmYB7insuaI5VcWb3+7K0k=;
 b=iaTCnLrBGnmmIQamOE8Nc4AMAlOQrXEusETechomANTO2PeIpkrbrpnZGu5+doLB/8
 tDNjxNPkL2q43BIUEkejOzouJYn0i+r8bqAUh/BoLXQpYOj/XcXbKIPDiZ45VQ2yU+hQ
 ogjYspbo8vS8Rx/jXbMY6H1Fewx9mESpUJ+8coj1Z3zvmvLMwdJhOfxnwgWEyGA9GjXd
 MH9sTUVkHlyQy5wu6goJm2ELOYYmIz2OQuvX2Vm7KV8vyLn80g/QKQB9bJdLr7g+IaWk
 gC1oxd6j0zyts1xhBhpjHS4+1Rz4RURbkiIHCgKuDMgwQlFb0CWZ4vhIgHxgaNAgTdMv
 ncYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708347542; x=1708952342;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uz9bDrDXKrYCEujzY3ZB9qmYB7insuaI5VcWb3+7K0k=;
 b=OaJmz9KCKycwAw7P1KYtq03OVRVDIyOA+0NdsQXlJa/NHuC8g014QVL85SSXnzDBv3
 8BnxaFIxnBbPXV2tjWT3MyibczqPjEZoHiesiC3TfsUiMSkC90YBWUpBG3tldjXzoQcp
 T+Yl4eS37mGvLGetRU4JC+ZxthJ0saVfO9gz3XXxrLaUDM6EvhnZuDfcxpWFwcSavN3y
 EQCsxokMT3JP5MTYTnZSqnSN1K7UnGPOYhQEsA61yK+qxgBRT5mDlyWxuspwFuTSTZAV
 6G/4Cb+LmFRfaBCC5wRTSfXrrtDo4ZeQZHaVtuinjxPsjCneBfZA5WfvWi2IV/8dGlnA
 +8nQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX69mEKhecGA+Njp7/2+BpdZlKSBnodxe47bJe19Ck4HDRBDl1oVlIqpSY7ykArrZfILwza6KywxpfODQlPJ9miAViD5A==
X-Gm-Message-State: AOJu0YzPNKfV6/2WyG3gpwUwGpfO5zeRLLx+WEguFcE+UMJnOVH95/Wx
 iirmZVlpV1GGFrbKFq987AijGc0NiqUGBqU60Z1LNsJT00FKGJ9RcGYnG+eHSrGmSiOg9a6khgM
 vXCIzlRgOeIP2t1+poDf5ShF9j+0jjxwFIKyYuA==
X-Google-Smtp-Source: AGHT+IEWWiXzLPV7S6IjbUcAmXIQ8ZLJYgF8ioNkqASzYiRC01MoUzmYLp9NF0eOFoXTUnmV2D78rhwJcjn2Owgjy68=
X-Received: by 2002:a05:6512:304e:b0:512:b313:73ae with SMTP id
 b14-20020a056512304e00b00512b31373aemr1914501lfb.43.1708347542357; Mon, 19
 Feb 2024 04:59:02 -0800 (PST)
MIME-Version: 1.0
References: <20240219091220.1022422-1-pbrobinson@gmail.com>
 <878r3gn44l.fsf@bloch.sibelius.xs4all.nl>
 <CALeDE9OPB5XSPvHKXJd-TXgd+gkBTBeji-hWpRTNQBppLz1OEw@mail.gmail.com>
In-Reply-To: <CALeDE9OPB5XSPvHKXJd-TXgd+gkBTBeji-hWpRTNQBppLz1OEw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 19 Feb 2024 14:58:26 +0200
Message-ID: <CAC_iWjLMD_K4w2DuC0qi4PPXXvuySgGq1rEqJ6wEBRiWharU1Q@mail.gmail.com>
Subject: Re: [PATCH] disk: dos: Add all options for EFI System Partitions
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, trini@konsulko.com,
 sjg@chromium.org, u-boot@lists.denx.de
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

Hi all,

On Mon, 19 Feb 2024 at 12:53, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Mon, 19 Feb 2024 at 10:24, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> >
> > > From: Peter Robinson <pbrobinson@gmail.com>
> > > Date: Mon, 19 Feb 2024 09:12:15 +0000
> > >
> > > The EFI spec states that the ESP can be any of FAT12/16/32 but for
> > > compatibility doesn't necssarily require the partition to be the
> > > EFI partition table ID of 0xef. A number of arm devices will not
> > > find their firmware on a FAT partition with an ID of 0xef so also
> > > allow the original FAT12/16/32 partition IDs as they are also
> > > permissable for an ESP.
> >
> > Hi Peter,
> >
> > Any reason not to include 0x0c as well?  That is what we use on
> > OpenBSD/armv7 and OpenBSD/arm64.  And as far as I know all UEFI
> > implementations (on arm64 at least) boot from such a partition.
>
> I wasn't 100% the support with LBA so I erred with caution, but no
> reason I can't add it.
>
> > (And yes, we use that partition type because we want to have a
> > bootable image that works on the various Raspberry Pi models).
>
> Yes, that is the same reason for us, plus a few other random other Arm
> devices that won't recognise EF as VFAT and won't boot.
>
> > That said, what problem does this fix?  And what happens if we have
> > both a 0xea and a 0x01/0x06/0x0b/0x0c partition?  In that case U-Boot
> > should probably prefer the 0xea over the others as the ESP.
>
> The reason is because the support to write EFI vars on ESP, and yes I
> realise it's got security issues but for most boards it's the least of
> their problem, as the support won't do that without the flag and you
> get a bunch of these on boot:
>
> No EFI system partition
> Failed to persist EFI variables
>
> As for multiple partitions UEFI should handle that and I believe the
> EFI var support has logic around which partition it chooses.

For now we 'just' select the first ESP partition we scan while adding
disks on the EFI subsystem. But this patch doesn't change that logic.

That being said, I am pretty sure Mark is right here and this is going
to be a problem in the future (but it's still orthogonal to this
patch).

>
> > Oh, and while your're at it, the hex constants are a bit inconsistent
> > (0x1/0x6 vs. 0x0b).
>
> Will fix with v2 when I add 0x0c, I'll await other feedback for a bit.
>
> Thanks,
> Peter
>
> > Cheers,
> >
> > Mark
> >
> > > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> > > ---
> > >  disk/part_dos.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/disk/part_dos.c b/disk/part_dos.c
> > > index 567ead7511d..303eb1d13ee 100644
> > > --- a/disk/part_dos.c
> > > +++ b/disk/part_dos.c
> > > @@ -40,6 +40,12 @@ static int get_bootable(dos_partition_t *p)
> > >  {
> > >       int ret = 0;
> > >
> > > +     if (p->sys_ind == 0x1)
> > > +             ret |= PART_EFI_SYSTEM_PARTITION;
> > > +     if (p->sys_ind == 0x6)
> > > +             ret |= PART_EFI_SYSTEM_PARTITION;
> > > +     if (p->sys_ind == 0x0b)
> > > +             ret |= PART_EFI_SYSTEM_PARTITION;
> > >       if (p->sys_ind == 0xef)
> > >               ret |= PART_EFI_SYSTEM_PARTITION;


Can switch the many ifs to a switch statement? Going to make adding
more IDs easier.

Thanks
/Ilias
> > >       if (p->boot_ind == 0x80)
> > > --
> > > 2.43.1
> > >
> > >
