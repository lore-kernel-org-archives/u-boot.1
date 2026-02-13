Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A113DEDF152
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 10:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D228680FA1;
	Fri, 13 Feb 2026 11:59:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nzJl6cA9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3AAF83015; Fri, 13 Feb 2026 11:59:54 +0100 (CET)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 186B380B98
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:59:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-649df3c22d4so649261d50.3
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 02:59:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770980390; cv=none;
 d=google.com; s=arc-20240605;
 b=f/qsohBdHM3Q6Xj6x+2N0FGJAZjrjKRJAd19XeQLag45+pKmrLWJBp2dPxBZqcd2IZ
 E0SDblco6ABmLV9UKtECK+ky7shUOtg7mLjeFFaoX2q1yo2MMDyAWLSiIw00ZHv28PWj
 atJVyR937KYF+DBqQDPaxJc/A1ElGSxa9KTpBKv5Xd+SF6INXaFpw3tuK2KW9dpg59F1
 bgCdFDJViiBwcTvpXSCcx738/XacZ+m6NxxfeS5AkGcvN5r6JU1uVOtMJ82FjdOC8lnE
 zioFKydnw113psFhZ/aeszSTtHDXxZL+lJgldDpQjvCYTvcYZFhIFDGC7sky89J0sXAP
 wonQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gY2cwLSBAjOf7MFo+IxXVsCOVBkkl5xq2Pvj/0id8CA=;
 fh=vyfbts51IeL9YqiXEXChvJnWUKQFbZdi8gERlNYTnqw=;
 b=fX3n5qi7TyygftixKwXCLT1XQV9lHeGa+3rECtk52KZFJ7pnEg+dTrGuvDd4oWIYJz
 IDyLk86YL0pfZMeE3YeNQtcz7dgd0Wxaxr+e9gZm+ZpjVEO4EtCeRsB4Ud4PWwLePnzW
 JjowCSo95jYVRFV/d9ajd25AfU+UT4IeaMpdVwISaLcSsx2AqmYqRGMzRy7bQ6ROBoj+
 klrNUeVRmwtJdjE/dwI/pg6at3AJKdPgvrL+QyP0RsHUBtvQUGkkreiEPfC24pFRlbV8
 xz2tXBLZPzcp3hmZsbbGfw/snWwxHQIh/m6fcdBiDozn0bQDYGcm1YbDL2IbuWoo+m0n
 q77g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770980390; x=1771585190; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gY2cwLSBAjOf7MFo+IxXVsCOVBkkl5xq2Pvj/0id8CA=;
 b=nzJl6cA94KmztZiBv1Vm23j2f2jsG9R0Nq5QuyYiTdtlkdnjOsOcm4NO+IXcZq+IFU
 XUO6v3f9aXePh5YRvou4y3ldZpnA8wkHDpM/HI6U1U6MzgvWvD0/wes8gB0QKdGSxd3w
 S/ga7TTRxHGwVfEqwR0J6uVTD8OdoKIAgX9pVCGr88dJMYVw3woSL0UAod7nGZq8nXHz
 xge6+WK3fyoSz7CvbaJ9prjxS2JpdeaDZPFUmna3macsvxH4GgAclocTUUxmyC3WDmT7
 EXEqxUOBVxrjLyYOyi3GWd8wzkYMDVmAnpxXbgDgbnALnvsimC4MhvA7VLe2uG08TlrB
 NSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770980390; x=1771585190;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gY2cwLSBAjOf7MFo+IxXVsCOVBkkl5xq2Pvj/0id8CA=;
 b=KyNIEC2v1e6ZwK1a1OLY76ZR6jQLWVhveUyl1OIGUF5n1uNVRscNTRSQJmy+m2Eq2Y
 0cLjokApIvNK/s5E/YY+NUhvnAAvjRbFD2X3fk55Z5DQHFcNOLBN1P/mvBDeHt2xUWsT
 J8g+wSIGMQG78rIoyAryMyknUMyoIXmrS7fNyn2SluOP+og86c4DRyhqe1Vb3lgsLpzY
 dx8NEWE4M7pWftJZ6e5Yoc7tAR4vjA0/T4qC3Q6kWDsMlkSe+zQutaYtNPM0VuWMQZjW
 V7yMtmU9iR5SyAhnaRP7DJk4lA4AQfLbNDBul5/5gHakuleU5Nz2hTunm/93SR1CFUQf
 1+HQ==
X-Gm-Message-State: AOJu0Yxd3pcqWnFxzR0QAbg7NHNXM6uCge2X31K624rYiIUjwerwxlzU
 gVqATlceWiD7gfmHm3x2pevP4YkC8zKImVy/uQrE3voywX8r8fjeFYnVxAPzZm0FgGpr/uIFpxo
 N5q9cRQ5OzPBTc8woit8bkyTcb0og5ccjPmRZhjVhgg==
X-Gm-Gg: AZuq6aLoRLnksTRAisi9XRoHdAB2IfK9DxTyi9HLy3iTA7fLqcsJtO+jyypwyLQaRzg
 NCYSw+/vU3VXi3Qpk1QF0WEPNd3IIXZQm/nBEkG78eSYL6FOGRW3db1Iz2Pq2Sk3eR67/49dZT6
 QJiXvDW+oZPZ5JzdBsF4PwJRgl/FKvatD/5ERmkPL7ryav890irX6GSuF0w3K+bhqPit+beFIKX
 mGeKIbULJYmsxvRIXDKxmo0spqlL/z9IMJXhaBgvyQNe1QCD9QdO8H94vN86Ag7YEOJV7oSwHw/
 kmIeLqUw7jAG+nMYxbFr/sptjzzMxz1rqCoerIpSa73TPkDZThjhvwoFYedyDfcP84QQASgdCvg
 iO5aRDoukVKKuaBX+XfsIVGqjKAvZm09LaefKeEwsWHFvoB16LC5bk2C1sITWhkDDiqmeQJAt0c
 yKQg+MI8O0qQcuRtha3Jbvgvuq1I2Fkf5Bz4fUqhqdPcewztvDBcVeI7NDFKbpQ3RAJ7BfF2a+3
 iknd2dm7nmrHC6FZwU3KJ9OcbnB0YPTw4lRnViWKFHjVPzoBPl8V/FJE0eD/zJIsDlbylcPLjP3
 PJLBlMt0OterGG2DQI0C8MflAGpzew9aQ5IxwRpLV9+8yw==
X-Received: by 2002:a05:690e:d07:b0:649:5423:c10e with SMTP id
 956f58d0204a3-64c198cee2amr822147d50.38.1770980390571; Fri, 13 Feb 2026
 02:59:50 -0800 (PST)
MIME-Version: 1.0
References: <20260212204511.619392-1-javierm@redhat.com>
 <20260212204511.619392-3-javierm@redhat.com>
 <CAC_iWjJysPTkCTJ10qR8FmNxSBYT6mK7YWoqvxxwez+6H8Yf1w@mail.gmail.com>
 <87ldgx6kcw.fsf@ocarina.mail-host-address-is-not-set>
In-Reply-To: <87ldgx6kcw.fsf@ocarina.mail-host-address-is-not-set>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 13 Feb 2026 12:59:14 +0200
X-Gm-Features: AZwV_QhXbsf1W8YVB_C-DOPZjo-2TZa3shu15803iX_AVJ8sA4b9_V5IsJIzbTo
Message-ID: <CAC_iWj+F6+U2HhesN_sKxLXPHzSX_J0seK9QT0fxV_agxhkDag@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] disk: part_dos: Align dos_partition_t with struct
 partition
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 eballetb@redhat.com, Tom Rini <trini@konsulko.com>
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

On Fri, 13 Feb 2026 at 11:52, Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Ilias Apalodimas <ilias.apalodimas@linaro.org> writes:
>
> Hello Ilias,
>
> > Hi Javier
> >
> > [...]
> >
> >>         unsigned char end_head;         /* end head                             */
> >>         unsigned char end_sector;       /* end sector                           */
> >>         unsigned char end_cyl;          /* end cylinder                         */
> >> -       unsigned char start4[4];        /* starting sector counting from 0      */
> >> -       unsigned char size4[4];         /* nr of sectors in partition           */
> >> -} dos_partition_t;
> >> +       __le32 start_sect;              /* starting sector counting from 0      */
> >> +       __le32 nr_sects;                /* nr of sectors in partition           */
> >> +} __packed dos_partition_t;
> >
> > This always has to be packed and the part_dos.h definition had this
> > wrong all along?
> >
>
> I wondered exactly the same when working on these patches and did a bit
> of code archaeology, so I'm glad that you asked!
>
> It wasn't wrong because it was using unsigned char arrays for the start
> and number of sectors struct fields, instead of __le32 types.
>
> Given the alignment of a char array is 1-byte (and all the other fields
> are unsigned chars), the structure was naturally aligned.
>
> But I agree that using __le32 and __packed is preferred, and in fact is
> how Linux defines this data structure in include/linux/msdos_partition.h:
>
> struct msdos_partition {
>         u8 boot_ind;            /* 0x80 - active */
>         u8 head;                /* starting head */
>         u8 sector;              /* starting sector */
>         u8 cyl;                 /* starting cylinder */
>         u8 sys_ind;             /* What partition type */
>         u8 end_head;            /* end head */
>         u8 end_sector;          /* end sector */
>         u8 end_cyl;             /* end cylinder */
>         __le32 start_sect;      /* starting sector counting from 0 */
>         __le32 nr_sects;        /* nr of sectors in partition */
> } __packed;
>
> The struct_partition in disk/part_efi.c is said to be taken from Linux's
> linux/include/genhd.h, which was the old location before commit 1442f76d4317b
> ("1442f76d4317 block: move struct partition out of genhd.h").
>
> My guess is that the old data structure defined in part_dos.h was copied from
> Linux, and that at the time of the copy it was using unsigned char arrays too.

Ok that makes sense and yes, the alignment is not affected by le32 or
a a 4b char.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> But the struct definition has been like this since the original Linux git
> import, so I couldn't check if my guess was correct.
>
> In any case, now this single data structure definition is aligned with how
> both  the Linux kernel and edk2 define it.
>
> --
> Best regards,
>
> Javier Martinez Canillas
> Core Platforms
> Red Hat
>
