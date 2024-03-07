Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873FEC54798
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 22:10:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB027878E2;
	Thu,  7 Mar 2024 23:10:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HWIpS5hc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FDA087811; Thu,  7 Mar 2024 23:10:34 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FEE487947
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 23:10:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chuckmeade@gmail.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5132181d54bso1832595e87.3
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 14:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709849428; x=1710454228; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L6PKJgRSizLeUf1nuaxvQL7x+8B3MvHs13mGjCdIeP0=;
 b=HWIpS5hch64QSyXeoUsF23Sg65nkXm9nfeFdbQZA1/ROxrRD3MC9mT5ZAmXAHm+ql/
 54aIgb9BiE5gAx/X7l9cXA2CPQK0ouq4nxlnxEs/X//VHHshENzUVm3sVW7ImbngQ3O2
 9zovplTRU6kiA8CofWOq6JpfYCgR7rETFXzduhtt+IbmJPXpk43XMinNI1iw0RReSZQ/
 VtN2o3uaD8Z3ajVr/1UCP2J2lGX9hwU1qFjzXYTHWOAzbHylcEqNI49lv+O/evEBBlQB
 ceRJjWswWraM3FHvmMxfAhHLcjYJLc1Poy2tWCSh/jFKambEr3jGvzta/sHk8/zPrzUT
 X4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709849428; x=1710454228;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L6PKJgRSizLeUf1nuaxvQL7x+8B3MvHs13mGjCdIeP0=;
 b=TZ4GoLOqrjskXFz3aVSgfyPpTnMLY8knSXSI02jMAl25RyYQBYT/w4sCFRPjomevIL
 87LMOt0tco/xpiYPLGEh5vqXiNrP6GSgZ9lH0XmJQsIte2GdP0shRnFTKQuKcM8fukFe
 G/b+a4LFUhqojNL6okfjpr2HIGIHFPBmUHEn2VSwnrvn4KPYkiglbUq3fUMOL5/6zkqc
 ebYq25eu2btpeMOUaxJoHNC5gTCRjhG0rOV1dXNBFgnj6r8A1T40jU4uH/qYSuOUNL2a
 sIaFnTlDjU4cl79kbaJEv5ZS/pxiJMzi75n/CmDU0UZa2HwG5Hg/d35CqA8CZUD05stb
 YW/A==
X-Gm-Message-State: AOJu0YwxqhXk0ic7CwRKiVcySFbmZ+A23nKfTS8cX1QylKUwRKiJRB33
 /SqHfJa0PxpT4LQND3inx+dWJAE6c73pWSefb5u0+Fe1+1XlTNeOfFG0knKZoLmAbSi+iekv2RI
 ykktRmrMgSDrpwfvZXEYHsulAc970Yz9r
X-Google-Smtp-Source: AGHT+IFvXf7HidphNSxM1qP1k2a10AxMBuqvOn8dEZGuRS9UriKDXTVI1Fyk33hDsINDpUgmT/0KEJ/2CWaArxgmrwI=
X-Received: by 2002:ac2:5e27:0:b0:513:2cb8:b959 with SMTP id
 o7-20020ac25e27000000b005132cb8b959mr1747176lfg.21.1709849427974; Thu, 07 Mar
 2024 14:10:27 -0800 (PST)
MIME-Version: 1.0
References: <29244d1c-ec74-4d98-8137-aefabf4fe253@gmail.com>
 <20240307-expenses-trustable-b320aca2e2d6@thorsis.com>
In-Reply-To: <20240307-expenses-trustable-b320aca2e2d6@thorsis.com>
From: Chuck Meade <chuckmeade@gmail.com>
Date: Thu, 7 Mar 2024 17:10:16 -0500
Message-ID: <CAMibdzLkkhB24agemXnCLSWVksDhtom0LQq0O=-Ev+=g78usVw@mail.gmail.com>
Subject: Re: Can U-Boot create mtdparts from device tree partition info?
To: u-boot@lists.denx.de
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

Hi Alex,

On Thu, Mar 7, 2024 at 4:17=E2=80=AFAM Alexander Dahl <ada@thorsis.com> wro=
te:

> Hello Chuck,
>
> Am Wed, Mar 06, 2024 at 11:48:39AM -0500 schrieb Chuck Meade:
> > Hello,
> >
> > In looking through the source, I'm not yet seeing logic that allows
> U-Boot
> > to actually use MTD partition information found in the device tree.  Do=
es
> > this logic exist and I'm just missing it?  Or do I need to parse the
> device
> > tree partitions manually and create the mtdparts env variable?
>
> U-Boot can use the partition information from device tree, but not
> with mtdparts.  Try enabling CMD_MTD and run `mtd list` and you will
> see those partitions.
>

Thanks very much for the info.  I am using a U-Boot source tree from a
Petalinux distro, and it turns out that there has been a patch to U-Boot
since this distro was created, involving flash_node in mtdparts.c.  I was
able to incorporate this patch into the U-Boot source tree here and the
"mtd list" version now works as you described.  I can see all of the MTD
partitions from my device tree.

I appreciate your help!  Thanks,
Chuck


>
> > Sorry if this is obvious, I'm just not seeing it yet.  Also, if the
> answer
> > is just to manually enter the mtdparts env variable, and keep it in lin=
e
> > with the partition information in the device tree as a manual operation=
,
> > please let me know that too.  I'm just hoping there is a way to have
> U-Boot
> > get the info from the device tree automatically.
>
> You could do that, but it is probably not necessary.  The 'nand'
> command has some nice ways to enter commands using those mtdparts
> labels, but the 'mtd' covers the basic features like read, write,
> erase too, also with names, but with a different calling syntax for
> the commands.
>
> Unfortunately the 'nand' command uses mtdparts only and does not work
> with partitions defined in DT.  The 'mtd' command is organized
> differently and you might not find all features the 'nand' command
> has.
>
> Greets
> Alex
>
> >
> > Thanks very much,
> > Chuck
>
