Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69617CCFA1A
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 10:07:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB29D83A6A;
	Wed, 12 Nov 2025 11:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="kJ3NQNDH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D7D383A6A; Wed, 12 Nov 2025 11:07:21 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72672836CE
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 11:07:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2984dfae043so5840775ad.0
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 02:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1762942037; x=1763546837;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G3ffZjScpQgJOYgyuY2SlmANOmGpiw5v2cbO4WRyIjs=;
 b=kJ3NQNDHRBqlQRmogaSf3/+kZA9XX00t6bhdIDNX+XWKjcgk7Q26QdqJSXGI+PtzbR
 2PvaLUNFaeQjWj2hob5joMr3qDUDCIgCRNn1M6sr3L3sou8NKx6cy/Ym9zcPSgJnZb89
 Cp4s8lRXNIOXQMvpTEuvwSrM/b1S4yyrouMY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762942037; x=1763546837;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G3ffZjScpQgJOYgyuY2SlmANOmGpiw5v2cbO4WRyIjs=;
 b=klmNnQmkRXLmsTiNsw0+F0b99z2z4qOh6BPRDKbb8txTkeGVxyBxHxMkOlbc2vCNhN
 dshvvIrvd2OrpUJVD2XqLhQjVk8TgPjHXSCp9ezEj5p1OqXrX4p45OcUieb3OK6AQV+u
 8Oq4f6HYsPKBs2uJjMufIcRQcNXRK3mQiY9SMxATs3xQzOg1yW1PDF3LsgPH4uDNJv+t
 G7XVbPZLO6ZNHKj9/YS2S95jl9Qd07gouz3/suBaAITNAQrlTQv+3LEdNVDq6DEZB00p
 dNP/eog2fZVi3IgZiktdY2aVQahA+S/u59yj9Au8DbnJBHr5PRwnjrBuJhkcd5zIRmib
 sgOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWou+6A6hv+7SaL0IXQdKzTukQhl2el6sg5Eyw4fqQ5BJxYg7CW0EM3lWdMhL+og5gesB6rF8U=@lists.denx.de
X-Gm-Message-State: AOJu0YwmNcaWjlMTGnbtzCowqjWvX6kk8yYsaYkQDJwoV/IOQRuzYPsk
 1Hr+NSxZ28xt7BEGChydAX0Lidjhe/9T55PNQ9Te5CWpfnrgO0MobdzfrIpiMeOPe8QbTHyCtPp
 BXj7IfbFC+0S2+7rtFYJSkDO17msSnjlbQDNcp1gCTw==
X-Gm-Gg: ASbGncuRNd9rqDr1Hih1D8wX9qYWB8t0CnbvFML+t+lMJ1I43tL2Ax7CR0CMBsjK5d9
 nPvMcPmJFup36tY/D3cV9vZUmow0COgB7R34LPHPp9Cnzdlz0hTfSQV24tdVBEW21TBtXZrs7sz
 nNedaGaL3wL0UUO0djhxzCTIFABySJ3b/9960NZqIg2EsV3iIe+IUkHPivyTUMinsHEA+Gr27Mr
 6r30Ndh8my++X9YQcKgJHBVs0ol3ugGe8TCQcqbu5ia7udAAcHp1SjM5qf6/mJF+AZzlkGKIotE
 HuG9PySybo7/Rw==
X-Google-Smtp-Source: AGHT+IETE3XCdKcjPtHAd+EC7GOSYRTct1okcVNLE6ZaY0AI3r5lxSH8CROe4Ex4T+6mJqHgggiaxvlVo3UE3OkOPMU=
X-Received: by 2002:a17:902:cf04:b0:295:70b1:edcf with SMTP id
 d9443c01a7336-2984eda98f7mr28974885ad.36.1762942036868; Wed, 12 Nov 2025
 02:07:16 -0800 (PST)
MIME-Version: 1.0
References: <20251027115638.1186252-1-festevam@gmail.com>
 <CAOMZO5B1sxS8Vh1awupGZd8oqqLhZ55abME07Kf5AZ-w9jUKhQ@mail.gmail.com>
 <3ab1b3a6-b9ab-4571-a7c8-8288d4a8d290@gmail.com>
 <CAOMZO5BcMu_94qn4vhDgxmdWVx0N-mCD9wYTvAPbXaK45EUFBA@mail.gmail.com>
 <b6b82482-ec7d-4703-ad93-ccdd7a651b57@oss.nxp.com>
 <e9c56d66-b2b9-456c-856e-2ef01a009e16@gmail.com>
In-Reply-To: <e9c56d66-b2b9-456c-856e-2ef01a009e16@gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 12 Nov 2025 11:07:03 +0100
X-Gm-Features: AWmQ_bmi1gzzdxSxCMTppM7oqVIXrA2ZK4QWZfK1xfmJu9-qADVMQ-Og5uXXtZg
Message-ID: <CAOf5uwktScqh0LrWTaz-MRA-tDoAVb9Mo8UhxDKz0dauO21QQg@mail.gmail.com>
Subject: Re: [PATCH] imx: Revert "imx: mx6ull: fix REFTOP_VBGADJ setting" and
 fix comments
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Ye Li <ye.li@oss.nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, uboot-imx@nxp.com, trini@konsulko.com, 
 dario.binacchi@amarulasolutions.com, u-boot@lists.denx.de, 
 u-boot@schwermer.no, Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Jacky Bai <ping.bai@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi all

On Wed, Nov 12, 2025 at 10:57=E2=80=AFAM Emanuele Ghidoli
<ghidoliemanuele@gmail.com> wrote:
>
>
>
> On 12/11/2025 09:16, Ye Li wrote:
> >
> >
> > On 11/11/2025 9:47 PM, Fabio Estevam wrote:
> >> Hi Emanuele,
> >>
> >> On Thu, Nov 6, 2025 at 7:22=E2=80=AFAM Emanuele Ghidoli
> >> <ghidoliemanuele@gmail.com> wrote:
> >>
> >>> Hi Fabio, Ye,
> >>>
> >>> At Toradex we have been struggling since quite some time (back to 201=
8) with
> >>
> >> Does this problem only affect early i.MX6ULL silicon samples?
> > Hi Emanuele,
> >
> >     I have same question as Fabio. Are these samples are early? Do you =
know
> > the time of receiving these sample? And could you show the part number =
printed
> > on the chip.
> It could take a little to answer to the first two question. I can say tha=
t the
> SoM I'm using to validate the patch was assembled in September 2021. Let =
me
> know if this information are needed giving that I can report the marking =
on
> the chip:
> MCIMX6Y2CVM08AB CTDQ2107 1N70S CHINA QGDQCTA
>
>
> >
> >>
> >>> the temperature readings and the thermal shutdown behavior on i.MX6UL=
L. The
> >>> issue we observed is that the thermal shutdown seems to trigger too e=
arly.
> >>>
> >>> I have investigated the history around this topic and verified some i=
nternal
> >>> notes in our bug tracker. With this revert applied, and on the device=
s we have
> >>> (all trimmed with value 0), the reported temperature increases by abo=
ut 10 =C2=B0C
> >>> compared to before the revert. The absolute accuracy of the readout i=
s
> >>> questionable: for example, on a device kept at around 20 =C2=B0C, the=
 temperature
> >>> readout was ~19 =C2=B0C before the revert, and ~31 =C2=B0C after the =
revert.
> >>>
> >>> Consider that for devices with fuse value of 6, there is a -10 degree=
s offset
> >>> after this revert (so, the other way around).
> >>>
> >>> I understand that for Sven this revert improves stability during larg=
e XZ
> >>> decompression in userspace for few devices, but for us it means that =
the
> >>> thermal shutdown happens roughly 10 =C2=B0C earlier, which is a serio=
us issue in
> >>> our case.
> >>>
> >>> I would kindly ask NXP to double-check how these devices were trimmed=
. My gut
> >>> feeling is that there might be an inconsistency, either the trimming =
scheme is
> >>> not backward-compatible (e.g. old and new devices behave differently,=
 and the
> >>> code should cope, I don't know how, with this), or this patch must be=
 reverted
> >>> (because introduces a regression).
> >>
> >> Peng/Ye Li,
> >>
> >> How does NXP suggest we handle this? Were the early i.MX6ULL parts
> >> incorrectly fused?
> > I need to discuss it internally, will feedback you later.
> >
> >>
> >> Can the fuse be read and dynamically adjusted?
> >>
> > The fuse is locked by MEM_TRIM_LOCK. Emanuele, can you help to read it =
by
> > "fuse read 0 0 1".
> Colibri iMX6ULL # fuse read 0 0 1
> Reading bank 0:
>
> Word 0x00000000: 00320003
> Colibri iMX6ULL # fuse read 1 0 1
> Reading bank 1:
>
> Word 0x00000000: 00000080
>

As is clear this problem was the same we had some months ago, so we
are on the same page
with Emanuele

Michael

> Kind regards,
> Emanuele
>
> >
> > Best regards,
> > Ye Li
> >> Please advise, thanks.
> >
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
