Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FB9D19520
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 22:58:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DF9383BFE;
	Mon, 26 Jan 2026 23:58:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V0YSQGyp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0D0B83F15; Mon, 26 Jan 2026 23:58:49 +0100 (CET)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EF1B83B43
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 23:58:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x241.google.com with SMTP id
 5614622812f47-45eabce608dso2872172b6e.2
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 14:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769468326; x=1770073126; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wD9RRMo5eXysuBhqXO7q8ZnbnAwQEc6xh+jBchok4aE=;
 b=V0YSQGypLLEkWRDqK83Y3OVjfnNjR09VtLBQyWLeDsSgBFV+A5jBwIuEsM2VHDtYpo
 +5YtU6WBpcvNpMu2zYUuJoyxsmi7aRvScPpAPZTXiC6tvvhn+lU8issTM1fsZv/Q6UAo
 lBwM3U8dtJ4voXFdk8HoRfMbpRFVtNXULE73k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769468326; x=1770073126;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wD9RRMo5eXysuBhqXO7q8ZnbnAwQEc6xh+jBchok4aE=;
 b=pT/T9HhdcnKp8qCZSLuTrLROX4Ra2USaBhPatnGLeiHM5V5JfFTSgHY+WDY6gNpj4p
 N/7WDsLBxrGJe/9wULQzN+MZGIA0bXvT5ARxZMGfajyFYgQKaO2AyAGpO+in9d07Lc/W
 WiykWFh9/YmBxWSDm3tqS05HMmZ0nJHE6Z9Zw95JZmXNZHyZpcki4RAiA7d5bpedK1go
 92kHePQnaS8l4JJVy5Esh+xEsKJNrW6TBhtKm4d+unP3t2ze5OwiOTEeppP9nKTWP1qn
 vbm17khl7iZ+McRRqCHg1XH8R8FG8KAR3rZdByby2fqfiZ5YK8oBG8uvhdtmYSP9Ajzo
 ErEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG1mAuaYiiZkQAwj9jQTD2jrrJMNaLFUlEl17G19hqXCMVqjsN6eJYirAiL0s4f0EsbLhYNrs=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6jOLJl9U6RLcrcU8nt0mm9rZYGAylFGj1cb4C8Yh51ajk2zsW
 EpiJeHdALtjWvR3XFGZfTE29wXxwyRFaxkMICOrp3rWYoJaHjV0ekblXV3b7SNHXdHg=
X-Gm-Gg: AZuq6aLnuUGQ+MRIB5uX4K/IFvSbTW1LfdeyeYjrqU2fKCKQ/bLXajfY1IY+BL5CnPy
 xYKg+F3mZoV9xCPOPhoC7bKnRJ/ji1T6i/KojqNAg0/SDT0o+PR6XkTRac3xnPb3WmXAuJMPwKr
 wthcjAuLBOOnhdnWtaNXZTTQvSbqtzZuGDJytqsoJ9b6fFgBDOhHIEz0ThTe8QgYGHzcUIaTv3s
 XtHvCiETSckHvSqFyMik7G/P2WSEK5ilFO3JjbUS6QpMvzJYyCk8JJA2I1IXt6NL1fMxApU6ur3
 NWstT7sa9ZScsKwCi3CjVpcEptnzNXxwQzCUFU5mShQ7lt92y9h05HlR4o4GVrqFGRuNEy0Uegf
 1c5weEZf6S26lQmLOwlxFfiRR/D9uvLiqJ/clelNj/Rkdf5gNhbQBBuLopH8o6B6Be4DTVSWpGg
 LWZ93xsWd5hK7Ey1dGu+tdX1k03MFJEUkyPz8kLe2Owde8YuL7QxrVWgqmcH1xNRO2JXpl10MeS
 9BBWYJhhd6IxqGAAPqz5clMtttZOsidDtlisgU=
X-Received: by 2002:a05:6808:1706:b0:45e:9dc3:11ea with SMTP id
 5614622812f47-45ed9a7597emr2980789b6e.40.1769468325949; 
 Mon, 26 Jan 2026 14:58:45 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45eef8b0aadsm1134538b6e.11.2026.01.26.14.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 14:58:45 -0800 (PST)
Date: Mon, 26 Jan 2026 16:58:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <sean.anderson@seco.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, Anshul Dalal <anshuld@ti.com>,
 Beleswar Prasad Padhi <b-padhi@ti.com>, ilias.apalodimas@linaro.org,
 malysagreg@gmail.com, sughosh.ganu@linaro.org,
 philip.molloy@analog.com, marek.vasut+renesas@mailbox.org,
 james.hilliard1@gmail.com, afd@ti.com, nm@ti.com, vigneshr@ti.com,
 n-francis@ti.com, u-kumar1@ti.com, bb@ti.com, praneeth@ti.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v3] mkimage: Default to 8-byte alignment for DTBs added
 via -b argument
Message-ID: <20260126225842.GY3416603@bill-the-cat>
References: <20260122172247.2995437-1-b-padhi@ti.com>
 <20260122174546.GB3416603@bill-the-cat>
 <c05217b3-f753-4fd1-9582-921e2cfd3a0b@mailbox.org>
 <b65ad902-2d07-4948-8a1a-64f4d5825a08@ti.com>
 <1e1f2e09-bfb7-4c7d-abd6-25a79271f256@mailbox.org>
 <DFVWL63A8IDP.23PE1QNTXTMRU@ti.com>
 <6cb4957c-7178-4a31-aea9-ad78d6627c28@mailbox.org>
 <ab3a8a36-eaa2-4030-ba18-6c75647455b6@seco.com>
 <6896afd5-76fa-4b1a-abbd-0798f19185ba@mailbox.org>
 <785327c7-9d8a-4f5f-b792-4a1590796948@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nmLPV4fjWqJksIzP"
Content-Disposition: inline
In-Reply-To: <785327c7-9d8a-4f5f-b792-4a1590796948@seco.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--nmLPV4fjWqJksIzP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 05:03:36PM -0500, Sean Anderson wrote:
> On 1/26/26 16:50, Marek Vasut wrote:
> > On 1/26/26 6:38 PM, Sean Anderson wrote:
> >> On 1/23/26 05:51, Marek Vasut wrote:
> >>> On 1/23/26 11:40 AM, Anshul Dalal wrote:
> >>>> Hi Marek,
> >>>>
> >>>> On Fri Jan 23, 2026 at 3:57 PM IST, Marek Vasut wrote:
> >>>>> On 1/23/26 4:32 AM, Beleswar Prasad Padhi wrote:
> >>>>>>
> >>>>>> On 23/01/26 00:33, Marek Vasut wrote:
> >>>>>>> On 1/22/26 6:45 PM, Tom Rini wrote:
> >>>>>>>> On Thu, Jan 22, 2026 at 10:52:47PM +0530, Beleswar Padhi wrote:
> >>>>>>>>
> >>>>>>>>> When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees=
 are
> >>>>>>>>> packed inside the multidtb.fit FIT image. While the individual =
DTBs
> >>>>>>>>> and the FIT image start address are 8-byte aligned, the DTBs em=
bedded
> >>>>>>>>> within the FIT image are not guaranteed to maintain 8-byte alig=
nment.
> >>>>>>>>>
> >>>>>>>>> This misalignment causes -FDT_ERR_ALIGNMENT failure in
> >>>>>>>>> setup_multi_dtb_fit() when locating the next available DTB with=
in the
> >>>>>>>>> FIT blob and setting gd->fdt_blob, because of the recent libfdt
> >>>>>>>>> hardening since commit 0535e46d55d7 ("scripts/dtc: Update to up=
stream
> >>>>>>>>> version v1.7.2-35-g52f07dcca47c")
> >>>>>>>>>
> >>>>>>>>> The mkimage tool already supports enforcing this alignment via =
the -B
> >>>>>>>>> option, but users would have to specify it explicitly. This cha=
nge
> >>>>>>>>> makes 8-byte alignment the default when using -b.
> >>>>>>>>>
> >>>>>>>>> Reported-by: Anshul Dalal <anshuld@ti.com>
> >>>>>>>>> Closes: https://cas5-0-urlprotect.trendmicro.com:443/wis/clickt=
ime/v1/query?url=3Dhttps%3a%2f%2flore.kernel.org%2fu%2dboot%2fDFJ950O0QM0D.=
380U0N16ZO19E%40ti.com&umid=3D003810bd-b0e0-4a71-9348-75ffbe5cbae5&rct=3D17=
69167692&auth=3Dd807158c60b7d2502abde8a2fc01f40662980862-3859cf23dac8d65722=
a0a9ed4c40c98c98a297de
> >>>>>>>>> Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream version v=
1.7.2-35-g52f07dcca47c")
> >>>>>>>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> >>>>>>>>
> >>>>>>>> Tested-by: Tom Rini <trini@konsulko.com>
> >>>>>>> Doesn't this enable 8-byte alignment for everything in case a DT =
is specified on mkimage command line ? That doesn't seem right ?
> >>>>>>>
> >>>>>>> If I do mkimage -f auto -b ...dtb ... , then I only want the DTB =
to be 8-byte aligned, all the other blobs can be 4 byte aligned just fine .
> >>>>>>
> >>>>>>
> >>>>>> All the mkimage flags are parsed at once and populated in the para=
ms
> >>>>>> data structure in one shot in the code. There is no separation of =
code
> >>>>>> specifically for generating a FIT for a DTB vs for anything else.
> >>>>>
> >>>>> That does not seem to be true ?
> >>>>>
> >>>>> $ git grep -p '\<bl_len\>' tools/
> >>>>> tools/fit_image.c=3Dstatic int fit_extract_data(struct image_tool_p=
arams
> >>>>> *params, const char *fname)
> >>>>> tools/fit_image.c:      align_size =3D params->bl_len ? params->bl_=
len : 4;
> >>>>> ...
> >>>>>
> >>>>> So something like that may work ?
> >>>>>
> >>>>> "
> >>>>> diff --git a/tools/fit_image.c b/tools/fit_image.c
> >>>>> index 0306333141e..0c606ba4cc3 100644
> >>>>> --- a/tools/fit_image.c
> >>>>> +++ b/tools/fit_image.c
> >>>>> @@ -642,9 +642,15 @@ static int fit_extract_data(struct
> >>>>> image_tool_params *params, const char *fname)
> >>>>>            for (node =3D fdt_first_subnode(fdt, images);
> >>>>>                 node >=3D 0;
> >>>>>                 node =3D fdt_next_subnode(fdt, node)) {
> >>>>> -               const char *data;
> >>>>> +               const char *data, *type;
> >>>>>                    int len;
> >>>>>
> >>>>> +               if (align_size < 8) {
> >>>>> +                       type =3D fdt_getprop(fdt, node, FIT_TYPE_PR=
OP, &len);
> >>>>> +                       if (type && !strcmp(type, "flat_dt"))
> >>>>> +                               align_size =3D 8;
> >>>>> +               }
> >>>>> +
> >>>>>                    data =3D fdt_getprop(fdt, node, FIT_DATA_PROP, &=
len);
> >>>>>                    if (!data)
> >>>>>                            continue;
> >>>>> "
> >>>>>
> >>>>
> >>>> I just ran a quick test with this diff and it seems to fix the issue=
 for
> >>>> us. If it's okay can we take the change as is.
> >>> I think the strcmp needs to be some strncmp and check the 'len' too.
> >>>
> >>> Let's see what others think.
> >>
> >> strcmp is fine when one of the strings is a constant
> >>
> >> If type is shorter than "flat_dt" then there is no risk of overflow.
> >
> > What exact data would you be comparing here , the constant and somethin=
g read from possibly past the user supplied "type" buffer ?
> >
> > Some validation of "len" has to be done before it is fed into strcmp() =
here.
>=20
> Well if you are concerned about lacking a nul-terminator then we will
> read at most 8 bytes beyond the string.
>=20
> The other thing that can go wrong is if we get something like
> "flat_dt\0extra data" we will match.
>=20
> Surprisingly the closest we have to this construct is fdt_string_eq_. I
> suppose this is because most strings in U-Boot are guaranteed to be
> nul-terminated.

And gets back to my original point. Either we're fine here, because
libfdt is doing enough input validation (type and len come from
fdt_getprop(...)) and if that passes enough validation to happen but
also allow malicious input this is not the most interesting place to
wreck havoc. Or we're fine, actually. Which is what I was saying on IRC.

--=20
Tom

--nmLPV4fjWqJksIzP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXfxngAKCRAr4qD1Cr/k
CrwHAPkBEbpCaiC6wVvPeawq/GtCexnUxEWDup0lAa4uDol/4gEA3/qN5Rxm3yc9
sLEGj8RrGt/ta0Gz/YGgOsujWYPaAgo=
=vE37
-----END PGP SIGNATURE-----

--nmLPV4fjWqJksIzP--
