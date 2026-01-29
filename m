Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E5ED3566B
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 05:01:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C98083C51;
	Thu, 29 Jan 2026 06:01:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ak7Y8Fy5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 655C383BDD; Thu, 29 Jan 2026 04:19:50 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9FD183B97
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 04:19:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mateuslima.ti@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-385b6a15affso15661821fa.0
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 19:19:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769656787; cv=none;
 d=google.com; s=arc-20240605;
 b=RRIKOnfoF7azkb5x1WMlOLfQJkaSXAPe+s9r47rBhqk4d5hWs5meonsnY75XoG0p4X
 5gyuTCKgIWV2aOty3EHSzMWjBYvQZzpnAMpuLJpfMyvIwMWh6ghhpcG4smmFLilwtIJE
 CeqD2RUsUPR4ogHb7Eea0VJX4LlkJG00EUOZtksweuRvNPYd4yNtLIVX+D+vfyFnxb/3
 lm+D5JK50Yf0B8mfmwOjKXyoN2c6xcg9+CteMAev2TW5dz8v8x1K0fVlTMBTyXhQyCcO
 ZaNYtZgDhOxczYs+og1fIISO/OH1xv2jW1Y5spRgrvOB88ShcGWyjFvIzf6SHlT82H1L
 8S4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VgUWQ2IwkHIXB/PAfeOavMvWC3rDjGOOLHOSIUpQhak=;
 fh=pWROPrRRpFFL3l/rgyoH13cbpCNEhjyurkIAlh6w4dE=;
 b=I6VvVFd9hxVYj5aDwXYhp/76f6sFLPGskmHHltyZ9SvoqVrSOI5ads1oqYahmfkjux
 mCskJiYevKUUU/l6M0X9s3jG24o/KvYluT7saXUuw3U5e7uh1ytdLUovOVUM7VN67W7E
 YKxHkGAnirBygam5q8SUI2UYxvga4/jT12Cpt9ycwhff6f68qhS6JoSy1L8j4Zz393Ev
 Gu816E6ZGjbH11PNezluzCv0D//JazIP9c8BVpQ805VfQlXBEaHjtAoKQWFvlYMIbdtq
 cY2ATog+/rUavMZYorxaaaVPiYc2KgjHxGE7BB9ADz1TixnTtcUUzC3EmQoQCvyv5cYs
 r0sg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769656787; x=1770261587; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VgUWQ2IwkHIXB/PAfeOavMvWC3rDjGOOLHOSIUpQhak=;
 b=Ak7Y8Fy5sRVaIvbwQBRqZv0+lQoAk0b/vKBdPXnMA6tmYPkLgPhx2eVU72bITRUzly
 5T7S94A/bZAw/8Sb308csGcVVuzPLnkfI7njN7YQs9mrRiAWX6Yd+4oWVH1u7Bgj+vKi
 B0oVsUi1zxeBbh+p+2GK+s03NM6w5KrHjU6iywigidb1xbcvbMc04wvBOjwwjxrZfbGI
 23E/mpcesqGUMV1wes+6CMqotCBS/pbHxVXrxVD5LqVkSu9Z3KcRolITEyjDtwwlQl8s
 bmbby5C4Xy4qQ+Xo4DI8I8WO16BdHtF7i5MfXCZ88PND2/wD+aM32iaP9GKcGnwU0ukX
 7/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769656787; x=1770261587;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VgUWQ2IwkHIXB/PAfeOavMvWC3rDjGOOLHOSIUpQhak=;
 b=cN9/rughZruCQ1REgrICFmTOi4+a7TxXV9uOoQNB4BJBgg+5ySiufQWQ+GpoU+jTJk
 2niG4bgoeu9fSQjDb0ARBNJH2co536baxVUVJhSVf2NFvu05T0hRxdgwCobJFtvxzyS0
 cQ/n+6LIjtYg4ybLY7CIuL4sFB1ta4VlVnw7d+4GRWfAHSOdabo5V0X2Ay5GSk7esEtz
 d2cOsoozOTSRftz9NqgGIPalrLZVGOH7KVxggqkjGkBN3w4ronujWp807+m7CB4T+Fwg
 24aKDLGA7SI1Mws0+8S/IGcYHAPpqwO/gutwcepdrDEaAEcAIeH/O0ea6mxBUPUxbhvd
 E4OQ==
X-Gm-Message-State: AOJu0YzqmBoO/yFv3ZO2QmixjIo2GkX2VRk3xQulaxOqUi41C96O/JRg
 aVndsVnJ0gCYiTu4J+/vNhIiFKvcP6GMCydH1AfFfQyFPiKo38U65UZyzKi7/Ox3cMmgwlHTQyZ
 Hg/6ARvhO6zLQEFQIPZoUqDLNPcPBCtY=
X-Gm-Gg: AZuq6aIDKBXmW7v3BZDpo5kDr+Auk9VzrBpbGhpiLBWYGcMt4tuGR/jfpmrtax4pPKR
 Hw34uVbnO8XpvMuj+jG1Qmy5k1YiBUIkwyIaFMKuaKadPalCq3roFhtBK+qBS/v2cBrvEN4WMl4
 ZCip93fz511+9SheFOngCKZNXlzsM7pq76yMaf0INpfd2NZnRIfuS7gKXvfCE8riCi2KrXF+6QI
 e62En+Rn+M2HF7BmCi9COVSDckIpG9ziBLiqVEVYjkjZ23Bg8oQxelUSNOansGzttVN1C6f8g==
X-Received: by 2002:a05:651c:a0a:b0:382:4f57:e8d1 with SMTP id
 38308e7fff4ca-386349e43e4mr5889121fa.18.1769656786669; Wed, 28 Jan 2026
 19:19:46 -0800 (PST)
MIME-Version: 1.0
References: <20260128192617.1724570-1-trini@konsulko.com>
 <CAP8WwTETA8ZXSC19bhvtTRLP2t-nvcqa+ER3HrYpshQDr05iAA@mail.gmail.com>
 <20260128202105.GQ3416603@bill-the-cat>
In-Reply-To: <20260128202105.GQ3416603@bill-the-cat>
From: Mateus Lima <mateuslima.ti@gmail.com>
Date: Thu, 29 Jan 2026 00:19:34 -0300
X-Gm-Features: AZwV_Qj6PAd7SFkvIkkVzPZSah0RKpBawoHpOT09Sb3UKneLHu9MG32t364rC1o
Message-ID: <CAP8WwTE-q1S5S_QYja8OnjWvS_hhpdiMW274vxKhDrEBUuvh5w@mail.gmail.com>
Subject: Re: [PATCH] misc: Keep FSL_IFC available on PowerPC as well
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailman-Approved-At: Thu, 29 Jan 2026 06:01:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

I understand, Tom, I'm just asking Peng Fan if this won't break his build,
as he mentioned earlier.

And please, Tom and Peng Fan, forgive me if I made any mistakes in the
patch submission procedure, it's my first contribution to the project and I
truly admire you for maintaining such a large project.

I hope to learn from you and contribute more to the community.

BR,
Mateus

On Wed, Jan 28, 2026 at 5:21=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> On Wed, Jan 28, 2026 at 05:02:47PM -0300, Mateus Lima wrote:
>
> > Hi Tom,
> >
> > Indeed, there are a lot of PPC targets that try to use this symbol, but
> as
> > Peng Fan reported before, his CI reported a build failure.
>
> Yes, I'm not sure what the particular problem there was with your
> previous patch / Peng's setup:
> https://source.denx.de/u-boot/u-boot/-/pipelines/29116
> (the failure is because we need
> https://patchwork.ozlabs.org/project/uboot/list/?series=3D488348&state=3D=
*
> merged to master).
>
> >
> > On Wed, Jan 21, 2026 at 11:13=E2=80=AFPM Peng Fan <peng.fan@oss.nxp.com=
> wrote:
> >
> > > On Tue, Jan 13, 2026 at 11:23:01AM -0300, Mateus Lima Alves wrote:
> > > >This patch adds CPLD support via IFC to the ls1021a-iot board.
> > > >
> > > >Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>
> > >
> > > CI report build failure.
> > >
> > >   CC      drivers/video/hitachi-tx10d07vm0baa.o
> > > In file included from drivers/misc/fsl_ifc.c:8:
> > > include/fsl_ifc.h:16:10: fatal error: asm/ppc.h: No such file or
> directory
> > >    16 | #include <asm/ppc.h>
> > >       |          ^~~~~~~~~~~
> > > compilation terminated.
> > > make[3]: *** [scripts/Makefile.build:271: drivers/misc/fsl_ifc.o]
> Error 1
> > > make[2]: *** [scripts/Makefile.build:492: drivers/misc] Error 2
> > > make[2]: *** Waiting for unfinished jobs....
> > >   CC      drivers/rtc/ht1380.o
> > >   CC      drivers/video/hitachi_tx18d42vm_lcd.o
> > >   CC      drivers/rtc/i2c_rtc_emul.o
> > >
> > > make[1]: *** [Makefile:2191: drivers] Error 2
> > > make: *** [Makefile:362: __build_one_by_one] Error 2
> > > Cleaning up project directory and file based variables
> > >
> > > Regards
> > > Peng
> >
> >
> > Is that okay now Peng Fan?
> >
> > If so, then my v2 patch would have worked.
> >
> > BR,
> > Mateus
> >
> > On Wed, Jan 28, 2026 at 4:26=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> >
> > > This symbol is used on a number of PowerPC platforms as well, so make
> it
> > > available there again.
> > >
> > > Fixes: 424b324165ea ("armv7: Add CPLD support via IFC to the
> ls1021a-iot
> > > board.")
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > ---
> > > Cc: Mateus Lima Alves <mateuslima.ti@gmail.com>
> > > Cc: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/misc/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > > index be7fdab56d14..a0aa290480eb 100644
> > > --- a/drivers/misc/Kconfig
> > > +++ b/drivers/misc/Kconfig
> > > @@ -695,7 +695,7 @@ config ESM_PMIC
> > >
> > >  config FSL_IFC
> > >         bool "Freescale Integrated Flash Controller"
> > > -       depends on ARM
> > > +       depends on ARM || PPC
> > >         help
> > >           This driver is for the Integrated Flash Controller(IFC)
> module
> > >           available in Freescale SoCs. This controller allows to hand=
le
> > > --
> > > 2.43.0
> > >
> > >
>
> --
> Tom
>
