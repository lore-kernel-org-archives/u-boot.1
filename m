Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04A8DEDB7C4
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 07:15:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 402C883F98;
	Tue,  7 Apr 2026 09:15:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ro18g4cV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA0FF84034; Tue,  7 Apr 2026 09:15:23 +0200 (CEST)
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com
 [IPv6:2607:f8b0:4864:20::1335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DD058352B
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 09:15:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-dy1-x1335.google.com with SMTP id
 5a478bee46e88-2ce102afb0aso2990844eec.1
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 00:15:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775546119; cv=none;
 d=google.com; s=arc-20240605;
 b=JtMDQHC3sITAilBZ0mCa3AGPCJsNzyDrh+BnDOLZY8EuDtzLeXWtFUtEos3S9XmP5F
 IYk3m5mQRskNqUNrWCTdhChafiNPSs2it1o5RoKDT2kwcsJHqhltek57GRBsopqhzTKC
 /Xfr79AvZpzeL69VUDgc1hJQQkMbt725tNXZoe7x7OcowP2iIJtJyftihhtaBAl6tyhC
 go+yZoqsnpFxALFqROmoe9cVnk5xmC3cFlje63asL2QPvBAc1N3RO/rUiYHCnCV2RqXP
 u6GjpSKmJ3j/8WbSeOPCGrHw+oXoNAceS2nPT4j6es0IKY4yMukZ4wksDF52Wtqmdt2k
 GR5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=m+xXcKLNPMzgrOVTzHq6j8JX4T6FggX4MrPQvGk0pT4=;
 fh=85Z8+huWynni1WhQzjgWUjNLuIZs7aoXOc9QhJIzwF0=;
 b=cClfoeEZ0aKO9Xi6PmyowOk2MngxqKzzipHeooEGxkrcUr5E0xCCmn4xvZaQpmETI+
 mrtMU18HCIUS8NTbpooe6CyZaJn1OsHiKfHuWbEmOdKh1d/CE8vsNn3yPINHF88Mz7eb
 xMYHn8OUkv6OqYRyglNX6guYwMc+kTFalhQYFFxfYosKAeTA+t7ztYiTdf2ZI1aTNy6N
 CJtXybfxWyTRyy39SHEt2Zq4VmmQ+xWZwLvnbe8eyo5sLnyUakGcVXctKRATsEKYKZ7L
 z9e9jooVgJWWoJiE4sW6rFo1wo8LVi73VoPrKEqYKd+ypgCyjwBkt+q+O+55uGwi8EQ/
 1p8A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1775546119; x=1776150919;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+xXcKLNPMzgrOVTzHq6j8JX4T6FggX4MrPQvGk0pT4=;
 b=ro18g4cVZTC7VCng8goBMfujLjHXP4cRv4iU3LiuZnVSoUfLpst15CX5+e5kgpXoHE
 TZr0iMGH1fcLuwbc3wXkkJebw/FTFY6sFitgV+EvGp5DMzATt0FKfnBEBe+AHoFB3s57
 CfgxMmNjNFSlQV227mh2jvVwKxmto6dYp/IgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775546119; x=1776150919;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m+xXcKLNPMzgrOVTzHq6j8JX4T6FggX4MrPQvGk0pT4=;
 b=daR/hGMQmbOlsyzvKLJfhB1UBO+MWGs6PCH1BwzoXCvfMgKTLtRwctGj3q0LzaacPK
 /7I0jFCt4rWQzo0QyfKNnA/oOz9mpuj9MXd61IY035lL6Ahn2T2RxalW0ZAHG3XRVNd7
 hoo13DGXiBq75jmTNeeOVOcWw9vcRz3EXLht7neSmCfc7yb37Ay9LphvzQK5T5qC1HEQ
 rTbicEbdRjSITjMkpdZB0ABetiW/UGJw91VEZq0yCMcYW2Fqe7JD5xvp5aL+WObh3ZRW
 0AGWbnV6j4bWuvR13+NLVFmU4+4Ps3AX98iimIretRTvWfeOHRkq+fvGxagxRZ6sjOJ9
 vzVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT71SmOhA4RZzNnjdKKVCXfjCpUsF+QBSf7vB/FgkHgZfUQHyzOoVn9oZK0Xzzy0AgOuoRF88=@lists.denx.de
X-Gm-Message-State: AOJu0Yxqtt42YpTCZz+08VRNhfpRyudw71rIvXQGlaMWaXFF4sAZNCQo
 klWB0sjCEKyOmM+7KKlW1v+77FCWnHI1/JRIn1qKpiMurzJ9PZGjsLniD4uOT9nWng1k3gUpcYk
 gjReGfRQqKPbTZfHv+JN6yJ+zCl4OfeNFIHD7wqteiw==
X-Gm-Gg: AeBDieuEGeiftBqgzSXupyGYlWiJQnO3Kiz/rjIZuHszVUWxCjMOlEdpu51Zv+jaR2N
 BDkwt71uh7P+JPbnbmuqGHzcsLK8g+7niycci64pJHYARI9OPOFjrSoXD7pqsT10iX+Kpdqldic
 Lxc3dasfLiSQmSMo5ljV1WVEp4EIDnTRigBfSyl1NNhR48NMEvdB70lvrP+H1NWEgdBjMDFohQf
 k2LxKvVOm6HOpEjJMrqDShjwdXyJTuPp37y5jRcHhGEHvTMQCPvOCodptNYF3G4v1uEdo/+CuX5
 XK6ZLmRNoKtOSgodGsBbHPvIwIovs+l1PfE=
X-Received: by 2002:a05:7300:3254:b0:2d1:1da1:a57c with SMTP id
 5a478bee46e88-2d11da1a75cmr2235709eec.13.1775546119184; Tue, 07 Apr 2026
 00:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260304032441.31558-1-dinesh.maniyam@altera.com>
 <20260304032441.31558-2-dinesh.maniyam@altera.com>
 <20260304143920.GT1388590@bill-the-cat>
 <PH7PR03MB6942D3E727EC89DE074BC0EFF756A@PH7PR03MB6942.namprd03.prod.outlook.com>
 <CAOf5uwm9eEMKe=CVGbZavGgmv3SArnnLZNcJs1RZJW7H6vgw_Q@mail.gmail.com>
 <PH7PR03MB6942E3711A99A34A114E614AF75AA@PH7PR03MB6942.namprd03.prod.outlook.com>
In-Reply-To: <PH7PR03MB6942E3711A99A34A114E614AF75AA@PH7PR03MB6942.namprd03.prod.outlook.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 7 Apr 2026 09:15:06 +0200
X-Gm-Features: AQROBzBLt6gkr3F6_2G7P6r-LBekssD1pPnApLFMYO0J4Ym3qgXaXA9PAD5t1uw
Message-ID: <CAOf5uwkrp37jF-8FNZ=dJw=xfwq-gAPockLwKkK71sutfiE62w@mail.gmail.com>
Subject: Re: [PATCH 1/2] mtd: nand: raw: Kconfig: clean up SPL Cadence NAND
 dependencies
To: "MANIYAM, DINESH" <dinesh.maniyam@altera.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot-Denx <u-boot@lists.denx.de>, 
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, "Chee,
 Tien Fong" <tien.fong.chee@altera.com>, 
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>, "NG,
 BOON KHAI" <boon.khai.ng@altera.com>, 
 "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>
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

Hi DINESH

Your series is here, I will have time this week.

https://source.denx.de/u-boot/custodians/u-boot-nand-flash/-/commits/nand-0=
7042026

I need to take care of other patches too. I have some Easter stops to
address, and I also have other patches from Bootlin to finish
reviewing and others to queue this week

Michael

On Tue, Apr 7, 2026 at 8:41=E2=80=AFAM MANIYAM, DINESH
<dinesh.maniyam@altera.com> wrote:
>
> Hi Michael,
>
> > Hi
> >
> > Yes I have two series on my queue, I I will work on them this week.
> >
> > Michael
> >
> > Michael Nazzareno Trimarchi
> > Co-Founder & Chief Executive Officer
> > M. +39 347 913 2170
> > michael@amarulasolutions.com
> > __________________________________
> >
> > Amarula Solutions BV
> > Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> > T. +31 (0)85 111 9172
> > info@amarulasolutions.com
> > www.amarulasolutions.com
>
> Any update on these 2 series?
>
> Regards,
> Dinesh
> ________________________________
> From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
> Sent: Thursday, 26 March 2026 1:57 pm
> To: MANIYAM, DINESH <dinesh.maniyam@altera.com>
> Cc: Tom Rini <trini@konsulko.com>; U-Boot-Denx <u-boot@lists.denx.de>; Ma=
rek Vasut <marex@denx.de>; Simon Goldschmidt <simon.k.r.goldschmidt@gmail.c=
om>; Dario Binacchi <dario.binacchi@amarulasolutions.com>; Richard Genoud <=
richard.genoud@bootlin.com>; James Hilliard <james.hilliard1@gmail.com>; Mi=
quel Raynal <miquel.raynal@bootlin.com>; Chee, Tien Fong <tien.fong.chee@al=
tera.com>; Hea, Kok Kiang <kok.kiang.hea@altera.com>; NG, BOON KHAI <boon.k=
hai.ng@altera.com>; YUSLAIMI, ALIF ZAKUAN <alif.zakuan.yuslaimi@altera.com>
> Subject: Re: [PATCH 1/2] mtd: nand: raw: Kconfig: clean up SPL Cadence NA=
ND dependencies
>
>
> [CAUTION: This email is from outside your organization. Unless you trust =
the sender, do not click on links or open attachments as it may be a fraudu=
lent email attempting to steal your information and/or compromise your comp=
uter.]
>
> Hi
>
> Yes I have two series on my queue, I I will work on them this week.
>
> Michael
>
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> www.amarulasolutions.com
>
> Il gio 26 mar 2026, 03:57 MANIYAM, DINESH <dinesh.maniyam@altera.com> ha =
scritto:
>
> Hi Michael,
>
>
> ________________________________
> From: Tom Rini
> Sent: Wednesday, March 4, 2026 10:39 PM
> To: MANIYAM, DINESH
> Cc: u-boot@lists.denx.de; Marek Vasut; Simon Goldschmidt; Dario Binacchi;=
 Michael Trimarchi; Richard Genoud; James Hilliard; Miquel Raynal; Chee, Ti=
en Fong; Hea, Kok Kiang; NG, BOON KHAI; YUSLAIMI, ALIF ZAKUAN
> Subject: Re: [PATCH 1/2] mtd: nand: raw: Kconfig: clean up SPL Cadence NA=
ND dependencies
>
> On Wed, Mar 04, 2026 at 11:24:40AM +0800, dinesh.maniyam@altera.com wrote=
:
>
> > From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> >
> > Fix and align Kconfig dependencies for Cadence NAND in SPL.
> > Move SPL-specific selects to SPL_NAND_CADENCE and remove them from the
> > non-SPL NAND_CADENCE option. This avoids incorrect symbol selection and
> > keeps SPL Cadence NAND support self-contained.
> >
> > Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> --
> Tom
>
> This patch has been reviewed by Tom Rini.
> When you have a chance, could you please take a look?
> If there are no further concerns, I=E2=80=99d appreciate your considerati=
on for merging.
> Thanks for your time.
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
