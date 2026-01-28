Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCDED46BE0
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 17:49:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2B8E83F4C;
	Wed, 28 Jan 2026 18:49:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GcrTp+/6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F02AC84099; Wed, 28 Jan 2026 18:06:43 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8515C8401A
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 18:06:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mateuslima.ti@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-59de2d1fc2cso10215805e87.2
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 09:06:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769619996; cv=none;
 d=google.com; s=arc-20240605;
 b=fbYyjd+EksA12Cg8sjTPZYtKtYnlpYV1fURLuFVzfwVsYPLzvvGVGvoVEQwE0ZUhNW
 mfSjTT3AUbWE99vQhISwZGRk+iqwef+oZNnKXWBHrVkQxBvDfjobZh1POcZawYfZkfNy
 ROTpMRLaqRP6ROplniZnpROrMD3P24uA8JXIOu8itw5lkH7APG7cyyPKhEvbUg5gvw9l
 UtPWID3vFG+clmAZIthRId6XG4+7G9bEjlMKCmrR5SgGJ+5XAtSAcO2lr8hn1uCudWHe
 lLOWam9BbVBM50vsJebbhTPb/AQ/MXQ7q2AKS2iR9p4Nv4QOh7GjeYS/X4e8LSIwnkge
 F2AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hKNVvr/juovcW1QAOCOyLjnfOGraB9KyIV8XR4CD12E=;
 fh=fIZ5OWhRun3f+E+FD3+naBsgnHlm+T1VOtVGLuIauIc=;
 b=lSgs7rSf0Mny2hWulyYSJSOhDKYvc9I2VK9i4Itrd6v81rDj/FkcNrgTQFy4nLgMFs
 AjucfC6H2IQeGvDre6O76grqbLp0BFhjZYgwf11Ujyd48lrT6SinW1+/Zwpak46MdtnB
 82JcLVTWMK6nIuLoAMUOlNm+JQcLzDsZMXVfz7nsbYUB7zMI5LnRZdw2gjFnhBE963Nx
 B95Z5E6c81rAWzN8N9VBvyliCG5/enwE6LO/QtLMJL1pPxytyJ/GtlGImjM/4nsVraWv
 7gjw5TFQGTT7GDxTYgIyXps4q8M6xjjD31Tqsb9bZ53yyaGGgC0id8S2YDNkNWl2VBGC
 7cFA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769619996; x=1770224796; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hKNVvr/juovcW1QAOCOyLjnfOGraB9KyIV8XR4CD12E=;
 b=GcrTp+/6CrJS/k/MJj1NHSBWTdz8J49C5uEiwYBOCzPUzDFZA67tRFL61JVcJ1Q3qS
 MMfUVlrt69+ruwZRUjkTn03GziOUuU9wdycKS+aAzHtKNlO25T9R2f0gnj0ByUjLr9zP
 0roElH1R9ANc9yNHirJQP7sI8/iA0jSB5q8rPJxRUdJ1Mu8SqTvQmvdLoYZMqWBu6pKj
 vHDAIxlqhRyuFNUdqvTuMyrFamvAdboWt2K/NdMSeBRQIS782il4wogN8L/LJkYXttZV
 GBV4FMPR0LjicyPBLphq+/w8tl3Ir+mUqswA/DNgl0gQvu44izGBelVWnwGN4Q2vIe+k
 uZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769619996; x=1770224796;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hKNVvr/juovcW1QAOCOyLjnfOGraB9KyIV8XR4CD12E=;
 b=D6hMy998WDN/NlLlbCkCeZbtQhrU1dHiiyeaDi+bYc/6uyNxDXR+LdnR1absSgUYWQ
 /xA/ltCv82bVrhIL+LfGBCXevilywHujHw/qARTKy9JUYMO7CugbVYIOb4EkUm6cfMt2
 KOTqt+9Mra6osG9UgKqvhuSp7muHgyAB5wqw6cMGVLG5qQV967d93cdLlXWIudLzewqI
 8j7f/nXme3QJNpSmRNAODewDCVqPKK6DshnJbK2PC5VHWFjLsTVFBc9Sd9p9i6A1RAFb
 tsfhniJn0j6JS2SCr8Xn+pHwjm7lEPVTlI9kJwiTAj/dsJBf5poxvR0F8MCNUl+izM3I
 oAFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4Gn7kMV5Gs+G5sdnlgqUloKbGqbGhoGOZY31GIn0oidDuCjs0WKp3CARsZLj+K9Bfa1F5xws=@lists.denx.de
X-Gm-Message-State: AOJu0Yxxuz/4HLoOumJW6b4NnVsG61iWY3fOlx8QOT9KD6f/6y4Cha6B
 VRExOGoBlM+h8D4jhLmenpQ9PSdDxM/Imbi6XIyHhje4Mlg2RTYM1duESkQOCOliKUFNA0BZ9e2
 OuyiwI4PhfKJ4kpXgZd9X/g/UxyE+34M=
X-Gm-Gg: AZuq6aLHp6EOi4He698lEawS86xC8zGCnNSTVTvoG4filRjKET99Xle5iXprAf1mW0r
 xtPgNsJUok99WoNO6yh3mqBkDMA5LKlTbMI+vQXJ2GzA4P4THju8sZTMJ9UdOW78g+iig/tg903
 48ljAbFg887+uISrTgIUbLK3YuhxtkGWtFe+/6RiXhMH1XPMwHiHyhu/shSsidJmFMiatQ6CjiD
 Z8ToEEVfukDvYKpaVPnDjo/GdWSTj5wj9PHouQhT4jD9LAOCJvsVfTvF6SpBrKmVy3BRiRPtRaI
 wFDotrdVGqoWcy7Vw/LR7awHS/joh1VHsxN04XQ=
X-Received: by 2002:a05:6512:3ca8:b0:59e:9b0:bf46 with SMTP id
 2adb3069b0e04-59e09b0c05amr963814e87.42.1769619995275; Wed, 28 Jan 2026
 09:06:35 -0800 (PST)
MIME-Version: 1.0
References: <20260113142303.441190-1-mateuslima.ti@gmail.com>
 <aXGZVQhGzIrtXY86@nxa18884-linux.ap.freescale.net>
 <CAP8WwTH5=Aqy+QLLRv9QGJ3RTbwyMXA88BsO4eJOB-WawHfHMg@mail.gmail.com>
 <aXbNSAUDjG83gKsq@shlinux89> <20260128164704.GM3416603@bill-the-cat>
In-Reply-To: <20260128164704.GM3416603@bill-the-cat>
From: Mateus Lima <mateuslima.ti@gmail.com>
Date: Wed, 28 Jan 2026 14:06:22 -0300
X-Gm-Features: AZwV_QjPmWOZu0MKYMMk7320YvnafGUhZWNMaY0WtgeuCYZsyJbN_n7S1RIVP1M
Message-ID: <CAP8WwTG0VVR26QxEFtpDN2s7xH_L3dR2y4PkwfwFgeSv-yV-cw@mail.gmail.com>
Subject: Re: [PATCH v2] armv7: Add CPLD support via IFC to the ls1021a-iot
 board.
To: Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>, alison.wang@nxp.com, u-boot@lists.denx.de
X-Mailman-Approved-At: Wed, 28 Jan 2026 18:49:13 +0100
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

On Wed, Jan 28, 2026 at 1:47=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:

> On Mon, Jan 26, 2026 at 10:11:20AM +0800, Peng Fan wrote:
> > On Thu, Jan 22, 2026 at 10:12:36AM -0300, Mateus Lima wrote:
> > >On Wed, Jan 21, 2026 at 11:13=E2=80=AFPM Peng Fan <peng.fan@oss.nxp.co=
m> wrote:
> > >
> > >> On Tue, Jan 13, 2026 at 11:23:01AM -0300, Mateus Lima Alves wrote:
> > >> >This patch adds CPLD support via IFC to the ls1021a-iot board.
> > >> >
> > >> >Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>
> > >>
> > >> CI report build failure.
> > >>
> > >>   CC      drivers/video/hitachi-tx10d07vm0baa.o
> > >> In file included from drivers/misc/fsl_ifc.c:8:
> > >> include/fsl_ifc.h:16:10: fatal error: asm/ppc.h: No such file or
> directory
> > >>    16 | #include <asm/ppc.h>
> > >>       |          ^~~~~~~~~~~
> > >> compilation terminated.
> > >> make[3]: *** [scripts/Makefile.build:271: drivers/misc/fsl_ifc.o]
> Error 1
> > >> make[2]: *** [scripts/Makefile.build:492: drivers/misc] Error 2
> > >> make[2]: *** Waiting for unfinished jobs....
> > >>   CC      drivers/rtc/ht1380.o
> > >>   CC      drivers/video/hitachi_tx18d42vm_lcd.o
> > >>   CC      drivers/rtc/i2c_rtc_emul.o
> > >>
> > >> make[1]: *** [Makefile:2191: drivers] Error 2
> > >> make: *** [Makefile:362: __build_one_by_one] Error 2
> > >> Cleaning up project directory and file based variables
> > >>
> > >> Regards
> > >> Peng
> > >>
> > >Hi Peng,
> > >
> > >Thank you for the test, and apologies for not having validated the
> patch on
> > >other targets.
> > >In fact, this driver was not being used by any target (neither ARM nor
> PPC)
> > >and after this patch it became enabled again. However, PPC targets fai=
l
> > >when trying to include the asm/ppc.h header, which is not available fo=
r
> > >some reason.
> > >
> > >For now, I am thinking of submitting a v3 of the patch adding an
> explicit
> > >dependency on ARM, something like:
> > >
> > >+ depends on ARM
> > >
> > >This way we would avoid building the driver for PPC targets.
> > >What do you think about this approach?
> >
> > It should be ok.
>
> This has lead to:
> WARNING: unmet direct dependencies detected for FSL_IFC
>   Depends on [n]: ARM [=3Dn]
>   Selected by [y]:
>   - ARCH_P1010 [=3Dy] && PPC [=3Dy] && MPC85xx [=3Dy]
>
> WARNING: unmet direct dependencies detected for FSL_IFC
>   Depends on [n]: ARM [=3Dn]
>   Selected by [y]:
>   - ARCH_P1010 [=3Dy] && PPC [=3Dy] && MPC85xx [=3Dy]
>
> For example on P1010RDB-PB_SPIFLASH.
>
> --
> Tom
>
Hi Tom,

Yes, I noticed that this warning is appearing now, and before this patch,
neither this flag nor fsl_ifc were properly used for compiling PPC targets.
Now that I've added more information about this option, it's being
considered again during compilation.

But in this thread, I commented to Peng Fan that it was possible to build
for PPC targets, meaning we wouldn't need to restrict this to ARM targets,
but I don't know what setup was used to crash the mentioned PPC target, but
in the U-Boot Azure DevOps environment, all targets were built successfully=
.

https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D12700&view=3Dr=
esults

We can use patch v2 in this case, or could Peng Fan please show me how he
made his build break? Is it a different environment?

BR,
Mateus
