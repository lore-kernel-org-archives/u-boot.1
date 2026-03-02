Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D64EB363D
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 22:18:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52A8983A1B;
	Mon,  2 Mar 2026 23:18:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HokieHA9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AEF583F0A; Mon,  2 Mar 2026 23:18:33 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AA3B8063E
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 23:18:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-45f18e8f2f5so3420480b6e.3
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 14:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772489909; x=1773094709; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tLOgHlxw+vky3el/nFievB1E7T9D2ANNXrnN5TXQ1ac=;
 b=HokieHA9iR3Kuij1ftWwZKe2Z65Yf8AGWUR3tYNixk8O776qacR2J4Lb93UeuajyFl
 tmbUxV2nD4eKKi2bxbB8BsGVrNZb5vD8kZDO5EHmOmx2xmSzQaxDGWc0z6H9b7DzDVcV
 Girxrngg/DnP31Uw0yvKpVT3sylt8DVwltmSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772489909; x=1773094709;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tLOgHlxw+vky3el/nFievB1E7T9D2ANNXrnN5TXQ1ac=;
 b=Q1wxvQErkDrDcxFwF4QbXSNSJuI0wMkmUb88bwBBZkr+S+SNRpYxiZQfSbo5F5IDra
 dLb2GySffHlj405KCaqWjEHqJVuBVFbMLM86dZS/h5udG4+rueENx5DzgVTqOORu9Hki
 gQ8lRgboNfOQf2AHXAw9c1LMLH84FJjp/uCXcDST9bulXeD2nJ7XuJmyMvc1y7L+McSo
 4BggJc1JQtcK2u47HUAuoxuISHStS9dpKJyV70xKXeSYA5q4IKzg9pa08+FeTqNoZKXK
 EqUMOUgSV2bvhmaFpXF6L/m87Nx9YeqxqyeuKzJR+LE7UWrnX2ID78nHcnksbQUgzOMg
 hUOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCViVJOVZBRePnzOa+ddQC/TKUWRkla3/Lu3YUHqVVQ7dr6C75iw8NrhO1Nt6+U8RUchP7a8BMw=@lists.denx.de
X-Gm-Message-State: AOJu0YwAoWOXRu9R3pbQegtbNEOTQ0zNexDNUwUerTbRPEZiC6hMtvUQ
 IR+/rzrj5IccOhIlsEBjKhz5h/LU8MVxU7dOKwsWrcPkc03Lblof5jEU4GWwyOHUB50=
X-Gm-Gg: ATEYQzxjwb8QHYfUSje8h9ptQ7ikszXgq0Jny3kd0I99rOm+7Cvy344gEGK75Z/UAiv
 SIk1U2ZqcuHx6gg1dfR4sIe9LhELLIGV2RHYNJEdTvROsUU+YBfCdGtsk0Uxt15g4KwJpitks8U
 OcyLhVv2MOzYf+GTPltbVfuyh0sXNOMC8Rtty/3p/AKnREljx90QW6s0yERxK+02XkI+Dd5Of49
 q90Q0dqRHBkph2siGxxhLAmNWrRmcoSBul+ovc7zoZUpOdVsRTDNnvOQxBMArisljObFA1ZENNA
 Zr6gI5GKozRMtHRTtc7X8E4lGO6Z5CBVfT7H8OdKKXOseTykDX29XPQPWQ/rURwye+Xt+3HMX64
 6Se609l1lsHw9Jxuv65bP8bgVoQehqL2ACoq1TFPcHS88yOvbGtmToN3XWG4ChfsqXhLYxzzHX7
 4Lfm4+6+SOEBNmkPxTdWhVV4xGJqukI8HL0hjRjnlwoMeF6EvPF8e3fLAGB57Z39ATuiBl2nwUl
 FuZtFq6uwsQkRe/5EFWEFl3A4WIOR2jn8kR+ayygAizCHonKok=
X-Received: by 2002:a05:6808:ed0:b0:45f:2788:b00a with SMTP id
 5614622812f47-464becaa16bmr7308481b6e.33.1772489909265; 
 Mon, 02 Mar 2026 14:18:29 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41640b99b39sm8360284fac.10.2026.03.02.14.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 14:18:28 -0800 (PST)
Date: Mon, 2 Mar 2026 16:18:26 -0600
From: Tom Rini <trini@konsulko.com>
To: "Chawdhry, Manorit" <m-chawdhry@ti.com>
Cc: "Francis, Neha" <n-francis@ti.com>,
 Nagabhushan D <nagabhushand34@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: FIT Verification
Message-ID: <20260302221826.GK1388590@bill-the-cat>
References: <CAA-ybFQ=DbZzcGq_=HLFx_Gp_D1YKj=oKYXtD0HKPuVYcQyyoQ@mail.gmail.com>
 <CAFLszTisAAQJb53Z9bifbMd9fQL-1iXnmbsyZMRDovAYYF87oQ@mail.gmail.com>
 <dfd8356a-2e93-47e3-883b-9605173a1db0@ti.com>
 <6c7588a2-254b-4e26-9174-925b1c66619c@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uUH9+/V5qFTATvXc"
Content-Disposition: inline
In-Reply-To: <6c7588a2-254b-4e26-9174-925b1c66619c@ti.com>
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


--uUH9+/V5qFTATvXc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 04:24:37PM +0530, Chawdhry, Manorit wrote:
> Hi Neha, Nagabhushan,
>=20
> On 2/27/2026 4:00 PM, Francis, Neha wrote:
> > Hi Nagabhushan
> >=20
> > + Manorit do correct me if I'm wrong
> >=20
> > On 2/27/2026 5:14 AM, Simon Glass wrote:
> > > +Neha Malcom Francis
> > >=20
> > > Hi,
> > >=20
> > > On Wed, 25 Feb 2026 at 01:54, Nagabhushan D <nagabhushand34@gmail.com=
> wrote:
> > > >=20
> > > > Hi Team,
> > > > I am a recent graduate working in Embedded stream. Currently explor=
ing secure booting on TI boards. I went through some of the writings on git=
hub - https://github.com/ARM-software/u-boot/blob/master/doc/uImage.FIT/sig=
nature.txt and other sources by TI. I would like to get few confusions clea=
red by this mail and thanks for take some time for this.
> >=20
> > I'm linking a couple of links [0] and [1] that should clear up everythi=
ng if you
> > haven't stumbled upon them already.
> >=20
> > > >=20
> > > > 1. Can I try out only fitImage verification with hs fs boards only?
> > >=20
> > > Neha may know about that one.
> >=20
> > No, both GP/HS can enforce fitImage auth (check FIT_SIGNATURE_ENFORCE)
> >=20
>=20
> FIT_SIGNATURE_ENFORCE is something that wasn't upstreamed.. it's something
> internally that we had tried to flow flush it and just left it at an RFC
> stage [2]
>=20
> But to answer yes, all the keys and everything is contains within U-boot =
so
> regardless of HS/GP or whatever device, it should work fine if you follow
> the guide.
>=20
> > >=20
> > > > 2. Can I try it with ti dummy keys or any other way to know if the =
flow/fit signing is correct?
> > >=20
> > > There are tests which check signature verification using sandbox,
> > > which might be the easiest way to try it out. See test_fit.py
> >=20
> > Yes sandbox testing would work, as well as building with the TI dummy k=
ey.
> >=20
> > >=20
> > > Regards,
> > > Simon
> >=20
> > [0]
> > https://software-dl.ti.com/processor-sdk-linux/esd/AM62AX/latest/export=
s/docs/linux/Foundational_Components_Kernel_Users_Guide.html#creating-the-k=
ernel-fitimage-for-high-security-device-gp-devices
> > (this is our SDK doc, just in case you need more help to follow along, =
more or
> > less the same as what the upstream docs talk about)
> >=20
> > [1] https://docs.u-boot.org/en/latest/board/ti/k3.html#fit-signature-si=
gning
> >=20
>=20
> [2]: https://lore.kernel.org/u-boot/20240111-b4-upstream-fit-signature-en=
force-v1-1-2b91be31866e@ti.com/

And someone picking this up again would be appreciated.

--=20
Tom

--uUH9+/V5qFTATvXc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaYMrgAKCRAr4qD1Cr/k
CrA3AP46yWcwE+GUmnijJVMpVQ5KCe+QWvzfkKxxCe1+qU3M/wEAvbl5vHuGgdta
n2tTQJXzIg3IyLL4tVc711E4ksw/1Qc=
=Q0qg
-----END PGP SIGNATURE-----

--uUH9+/V5qFTATvXc--
