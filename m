Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C254DD1812B
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 15:35:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C8298902A;
	Mon, 14 Oct 2024 17:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L9aeU7G+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53D1E89005; Mon, 14 Oct 2024 17:35:18 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2818E89110
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 17:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e292926104bso2249469276.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728920115; x=1729524915; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zKDEpYWB3ks0IwImiB/CBStKmRjc37MSxA7z31aTSG8=;
 b=L9aeU7G+spx0o0uCQGvC2Zoi1pf8IkIwexXvVO+tvgJ4oTGbVYltYchYkOGxYz7+h1
 ytqpI7F8eWXHl5xLtxBvwCB1WtIf+FpwQJ+5Sve2uM+UmAArGXb0aiGIworHMono2iO8
 abL8onUdcZdOIdRtrW0MXtrhuYkDiNgOXZQOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728920115; x=1729524915;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zKDEpYWB3ks0IwImiB/CBStKmRjc37MSxA7z31aTSG8=;
 b=Ul2JSpv4KAgkNz1zhuMvLN6/0h69Tcbrmlh+Ab96Inv1xNRpSjrlDFZ1szvmSOukh8
 QJ2L07K97puTS1nDLZNAqiwXADm+ApgbXXW97S05DP9j2oV9VCoCx3OQawz8osBlWf8/
 I3+xxejzXM6tb5e5oo00hTDXrmL5lqAXXwCwLPyscBUbE77VM5VZs22Vctme5p45DRYu
 yHgKmtJlYynI3m2ohNZErQhO76Qbzd4fdgmvkK1NJt2hAhLD1hNJ6fdwVNDYB5fIFlbA
 s8WhntxvBZSGO2u1vgcBlXYwwrTTLNEse4Kqy1eSdX0aZVFy0IgHi2ch5oALfa4FH6tU
 zWLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlLll1A9XOidO+rmm6teDR8H590ajfchFZjSoaFN7LeLwdp3xGaiohtWFun9DVZcmj8XM9y28=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/FX+LRs8hBPAbuKDrk68IiWoe9AOVnjmibkO33dCaHMYc9ANU
 todXyVGfBPBpVcGuajzdDjyFxA3/ikQMWRnnAh+pOGR3s+fLqNiR5C9IEUajyvo=
X-Google-Smtp-Source: AGHT+IEAN0H4KZO5Xm3Lw7LPV5TajjAB7MJJIZ0ojR37u2Ladu/ZHXWhbhTGFutViQWfNF5btABUQQ==
X-Received: by 2002:a05:6902:10cf:b0:e26:9b7:598f with SMTP id
 3f1490d57ef6-e2919d83c56mr7380820276.13.1728920114863; 
 Mon, 14 Oct 2024 08:35:14 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1148f07f4sm431172885a.65.2024.10.14.08.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 08:35:14 -0700 (PDT)
Date: Mon, 14 Oct 2024 09:35:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Devarsh Thakkar <devarsht@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, jonas@kwiboo.se, richard@nod.at,
 raymond.mao@linaro.org, u-kumar1@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH] boardf: Modify DRAM message
Message-ID: <20241014153510.GN53053@bill-the-cat>
References: <20241010070909.288313-1-n-francis@ti.com>
 <CAFLszTjJ1GJNd5Fn8U2O5WSnKMn99XW_pGLmejkYy_PBfxSEGg@mail.gmail.com>
 <f194f14a-c7c3-4aed-b4b8-f093f64c7b69@ti.com>
 <31aeb96d-55b1-4587-b212-2632ae4cc124@ti.com>
 <20241014142717.GJ53053@bill-the-cat>
 <eef0f5e5-1a54-015b-259c-c8eea4a54d6a@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eIxCydyGUtxyKYYB"
Content-Disposition: inline
In-Reply-To: <eef0f5e5-1a54-015b-259c-c8eea4a54d6a@ti.com>
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


--eIxCydyGUtxyKYYB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 08:59:39PM +0530, Devarsh Thakkar wrote:
> Hi,
>=20
> On 14/10/24 19:57, Tom Rini wrote:
> > On Mon, Oct 14, 2024 at 10:10:43AM +0530, Neha Malcom Francis wrote:
> >> Hi Andrew
> >>
> >> On 11/10/24 01:59, Andrew Davis wrote:
> >>> On 10/10/24 1:50 PM, Simon Glass wrote:
> >>>> Hi Neha,
> >>>>
> >>>> On Thu, 10 Oct 2024 at 01:09, Neha Malcom Francis <n-francis@ti.com>=
 wrote:
> >>>>>
> >>>>> The message "DRAM:=A0 2 GiB (effective 32 GiB)" can be a little con=
fusing,
> >>>>> modify the message to show exactly what is meant:
> >>>>>
> >>>>> "DRAM:=A0 2 GiB (available for U-Boot out of total 32 GiB)"
> >>>>>
> >>>>> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> >>>>> ---
> >>>>> =A0 common/board_f.c | 2 +-
> >>>>> =A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/common/board_f.c b/common/board_f.c
> >>>>> index 154675d0e40..b7add8f7d3d 100644
> >>>>> --- a/common/board_f.c
> >>>>> +++ b/common/board_f.c
> >>>>> @@ -254,7 +254,7 @@ static int show_dram_config(void)
> >>>>>
> >>>>> =A0=A0=A0=A0=A0=A0=A0=A0 print_size(gd->ram_size, "");
> >>>>> =A0=A0=A0=A0=A0=A0=A0=A0 if (!sizes_near(gd->ram_size, size)) {
> >>>>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printf(" (effective ");
> >>>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printf(" (available for=
 U-Boot out of total ");
> >>>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 print_size(size, "=
)");
> >>>>> =A0=A0=A0=A0=A0=A0=A0=A0 }
> >>>>> =A0=A0=A0=A0=A0=A0=A0=A0 board_add_ram_info(0);
> >>>>> --=20
> >>>>> 2.34.1
> >>>>>
> >>>>
> >>>> I've forgotten why the first number can be so much lower than the
> >>>> second. What is causing that?
> >>>>
> >>>> This is quite a long string...could we say "(total 32 GiB)" ? Then
> >>>> perhaps add something to doc/ to talk about the banner that U-Boot
> >>>> prints?
> >>>>
> >>>
> >>> Why not just only print the total number? The amount available to
> >>> U-Boot seems like an internal detail, I'd guess most folks just what
> >>> to see at a glance how much DDR was detected on their system.
> >>>
> >>
> Knowing how much u-boot is using might help someone who is working on some
> memory map related stuff or if they want to stop at u-boot prompt and twe=
ak
> environment variables related to memory map (e.g. load address for kernel,
> dtb, load bitmap to DDR etc). Overall I personally don't see much harm on
> keeping both the information (DDR available to u-boot and total available
> DDR). If the word effective is confusing than the print can be made more
> verbose as being intended in this patch-set or by following the suggestio=
ns
> given by Simon and Udit.

U-Boot isn't "using" 2GiB however. And in fact the command Simon is
working on to dump the memory table and what's where, as far as U-Boot
knows, would be helpful in that case.

--=20
Tom

--eIxCydyGUtxyKYYB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcNOikACgkQFHw5/5Y0
tywh4gwAsoIh88cAa8s5V11Tggb/TJ/ely9Cbo0vWhXQEtor9QqGl+VjEgEUXxAf
9rj+na1AzcZkXBL6ENwc7zo8g4ZkKO+Yjuzz5fnLYLgJR7+wyCfKoMtdAGBMjbdK
nWNH7PNmyHNTuxvOR2/Gl7006UKL6VBRWYkGMZ0L0+SK0u9Ot2I/aEwdJTKyMbtB
9n3H0R3H5kCSh8gXuPhrBP/8PXCjem6kBBPFQI5mPOyahj5o4OeXwDpHe4UYJn3U
QT20ka4bxvH3R0MvdeYj+UjZcOJcQATLhnM+mwdAw6UI1Vh7sMqYDA0mBk7/KoZi
bsMKVRW37e9vfu1nfz+ih19j4mtsq3dhoSYVOz52WhD5qyLrkLKNF1aUIC9exezV
CsjLKZvgfjXMsipKfxB/Q3/rOD6dwH7iexVi/EhHw4VetTsNU0DbCeowh5eltuwb
jUflTiMEaQoPFUhmIcdUbegsGECxfzC0ksd2whBqYfO05Wqz/CDqJ9gq3m1+SQaa
3StpzJB4
=pRMg
-----END PGP SIGNATURE-----

--eIxCydyGUtxyKYYB--
