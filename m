Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A84C54798
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 10:54:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 007F287DC1;
	Sat,  2 Mar 2024 11:54:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QVnNHiV+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D2CD87DCA; Sat,  2 Mar 2024 11:54:37 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A21A87DAF
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 11:54:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5640fef9fa6so4076665a12.0
 for <u-boot@lists.denx.de>; Sat, 02 Mar 2024 02:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709376875; x=1709981675; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CJDYUAUAo6ken4yr4Svz6RVeo5HUzeZcRBSLN6yMU10=;
 b=QVnNHiV+b2TJlwnFPHBQhDnj6k96n89wYJj54pop0oSxrkS+Ue4PSfz1ALm2XW8H9B
 xNMZstMH1d4H8Yjmkkcrpcx/Sc0v+PA23CF5SsaVRJ8a9LxT1yPg9RWgX8orDs3BqFMv
 GupcGoWvT7cBs1dH4LlU7JoUEIxcpjHQhQMkcd6414rgR8aoDaVh0rbWlug5Gn9TEMlT
 iWz7Ye4gpYVBFzqJ4ElMbOgr8bBxwv8h455ZsfcuMIS+fbbB577q3e7sBdPeuiWj8vCP
 oypzmfstyjFIedTCGdrM7wjJnrczOtuciYHIB2ZE7CXei6WNBT258kwVJb3tlRrx1+Sr
 Xk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709376875; x=1709981675;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CJDYUAUAo6ken4yr4Svz6RVeo5HUzeZcRBSLN6yMU10=;
 b=fucu69+AmaKsJsGX8xuZGBXOD7b9BhHxWU74SJwlEGa1BWxLqYClegwbizohJQA16c
 WcWm2DsgyYE/gNH0JpDYa8AuR5CdbgSGseqpKWfeqK4b9X3rwJrG/lX00Nv+MbkWJB/j
 96GqLMx2WE8uaT88SITLdGl4BdJVf1w9JnO6UPurXxs9ZK6GG62AL7HbNC/waFZMxmAa
 edqQBUVHqvJ4cl3dJUEh0SaDLz8YUzoH0Crs99uV67sJXF6lznLgbOJ1NbozaqQ1PpeM
 J5IZg1mJVmEsEZnK8KllgHRxyBXv9zE+d8IpQSQ9vRb6NyUD8haKYHTFmQHOOQhxzpQs
 DsYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTCkcu4WzcnwHMJGdl0M8Shc4rXLzYUp1yTq8z2SExyWr3a3M18SUxtAi5Y8qA2K40756rPcRNqdImAqPTzqgzbvFD2w==
X-Gm-Message-State: AOJu0YxfC6F3oDiHreXdbW7MOOyq7yKFUHy30RqYoZVtk3/i99le2lVt
 MuBAgKh5lSkc2FXgLOhH0/2ytSKRb+BSGgSRyv1ivp3yT/e3aPgvdtgPFRJGL83G5HSSz5iCczV
 4asn4FeEQbcpV4uhWVvNqSqquiOg=
X-Google-Smtp-Source: AGHT+IFwNnb8wXjn8sF2Bi2UKdSS0AvKlV9ciLuDhcpS1PvKP5dDOm3mQtc3wgw5612yNs34D8wqxIpUAi0J4yLrkP0=
X-Received: by 2002:a50:c8cb:0:b0:566:a235:9355 with SMTP id
 k11-20020a50c8cb000000b00566a2359355mr3131087edh.33.1709376874529; Sat, 02
 Mar 2024 02:54:34 -0800 (PST)
MIME-Version: 1.0
References: <20240225141457.48209-1-pbrobinson@gmail.com>
 <87h6hwk4g9.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87h6hwk4g9.fsf@bloch.sibelius.xs4all.nl>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 2 Mar 2024 10:54:23 +0000
Message-ID: <CALeDE9Oo-8c93=EKqm7O9P3eMLYWz_VV5xaqDbbm8uW7r_Sk2A@mail.gmail.com>
Subject: Re: [PATCH v2] disk: dos: Add all options for EFI System Partitions
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

On Sun, 25 Feb 2024 at 14:23, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
> > From: Peter Robinson <pbrobinson@gmail.com>
> > Date: Sun, 25 Feb 2024 14:14:55 +0000
> >
> > The EFI spec states that the ESP can be any of FAT12/16/32 but for
> > compatibility doesn't necssarily require the partition to be the
> > EFI partition table ID of 0xef. A number of arm devices will not
> > find their firmware on a FAT partition with an ID of 0xef so also
> > allow the original FAT12/16/32 partition IDs as they are also
> > permissable for an ESP.
> >
> > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> > ---
> >
> > v2:
> > - Add 0x0c option
> > - Make hex constants consistent
> > - Move from if to switch statement
>
> Erh...
>
> >  disk/part_dos.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/disk/part_dos.c b/disk/part_dos.c
> > index 567ead7511d..ab855adf347 100644
> > --- a/disk/part_dos.c
> > +++ b/disk/part_dos.c
> > @@ -40,10 +40,23 @@ static int get_bootable(dos_partition_t *p)
> >  {
> >       int ret = 0;
> >
> > -     if (p->sys_ind == 0xef)
> > +     switch (p->sys_ind){
> > +     case 0x01:
> >               ret |= PART_EFI_SYSTEM_PARTITION;
> > -     if (p->boot_ind == 0x80)
> > +     case 0x06:
> > +             ret |= PART_EFI_SYSTEM_PARTITION;
> > +     case 0x0b:
> > +             ret |= PART_EFI_SYSTEM_PARTITION;
> > +     case 0x0c:
> > +             ret |= PART_EFI_SYSTEM_PARTITION;
> > +     case 0xef:
> > +             ret |= PART_EFI_SYSTEM_PARTITION;
> > +     case 0x80:
> >               ret |= PART_BOOTABLE;
> > +     default:
> > +             break;
> > +     }
> > +
>
> That really didn't go well.  The 0x80 check was for a different struct
> member and there are missing break statements.  And I suppose the
> suggestion to use a switch was to bunch up the EFI partition type
> cases.
>
> ENOCOFFEE?

It  was worse, no coffee and an early start for a flight.... OOPS!

> >       return ret;
> >  }
> >
> > --
> > 2.43.2
> >
> >
