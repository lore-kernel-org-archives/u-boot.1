Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E5FC02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 21:31:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CBCB808A2;
	Wed,  5 Feb 2025 22:31:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CwtbRQBn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B0B8807A7; Wed,  5 Feb 2025 20:03:58 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28CE280104
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 20:03:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2f42992f608so65268a91.0
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 11:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738782232; x=1739387032; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RCFGURwLVjZcpKR7ja6E8Y+syhonTUtPBx2dKax5348=;
 b=CwtbRQBnOJadV02cyhoJZfjqsnQN0v4Li+VIIYOp1jKOJAln/0MhH8IuvkOVd20Wz3
 p841FkrHwiPeLAtsQqWIt0L9m6K5/rPah3RrMNKRUaG5746K9li2Fh5qRuZut8Y3sYZq
 lPGJfqDoE5BAtldd8sAqQlyUTXy5UWS5q/FU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738782232; x=1739387032;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RCFGURwLVjZcpKR7ja6E8Y+syhonTUtPBx2dKax5348=;
 b=XXW8tAjSDIYpujqQZ3RTduVqU459S9AI3YEoosf5x7rdumk890p7O+6coNewjyIygA
 uwFVzIbSXrX5H69SRGHKLn0q8jkBsyiWBmyi1fKczA20mQstsETb19zi4BPP16LG5Fji
 8gGKE0QDMuheKo4Rq19tWxErcbLdTgRYOfY5d/htTof725xZJ3fFGsrA15X4lEvy6W6c
 GsJ7pGirY1TYh+r6ZJqN+H2sGwPlAzarUZ2OiDrZcshxsmfh4oM/sB5Wkf42OJyIRTGZ
 3p1LR3H5mIo8REIGajLG9BDoBMjJpgV+YC4pJkXgNYLnsicLx4zM9/kdcTAiTwgOHmTN
 jbZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWAtX5D9GNiiT+TdPj0WUsmhOOdKIlk/DwIIgE12Xqt4+vbONXQC4MUCyFnSeOzkJ7byv+Bqk=@lists.denx.de
X-Gm-Message-State: AOJu0YxnIPLhtQskqbkGSREQDFz6mQJ+OyFdpNzS/FH3pSmEo6CnSQy+
 PtV0X5YtFIdBmiHdtml6Z4LC4mkvHW3i13av7WNWKKzmMvoyCPJYVeO9dwLXv4k=
X-Gm-Gg: ASbGncta9y1kI4MT8dTwKkMDCdyN7ZGt4mHj4Qmxh+dW49Qh2z62i7vhFOyUv+9QYXp
 CuagdQyHgKxH/PsdhHtmomlFemP1NdmI6woxI0RooJJX1on0KqLJrJuea5MnmxxdIdToXik/u9d
 LxJPgjDFc0eATtc6DiYCf3zqM/Vn1KW8ynHzyl259H6+SiZ8HN1CS5El7h1FLVpP4agK9VIbulR
 acBjxLcj5ZklsWlJ3DjbwnQBuS2iP3n0S7Co6KeDXPxYGf63+8wekjtBrac8zyiBtqMfFiIEKtY
 GzWIhaxTir5+/f8=
X-Google-Smtp-Source: AGHT+IHXRmSdylyzoDB04cDjzbU7eFOgctU/ezE6z0gK2SvN8jLHpmNfP3MEW7jtXS0XDEBCa97SLg==
X-Received: by 2002:a17:90b:4f4c:b0:2ef:316b:53fe with SMTP id
 98e67ed59e1d1-2f9e080922fmr5329862a91.22.1738782232590; 
 Wed, 05 Feb 2025 11:03:52 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21de3300050sm118249825ad.161.2025.02.05.11.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 11:03:51 -0800 (PST)
Date: Wed, 5 Feb 2025 13:03:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, xypron.glpk@gmx.de,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Marc Zyngier <maz@kernel.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?iso-8859-1?Q?Pierre-Cl=E9ment?= Tosi <ptosi@google.com>,
 Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Stefan Roese <sr@denx.de>, Joshua Watt <jpewhacker@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Alex Shumsky <alexthreed@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>,
 uboot-snps-arc@synopsys.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v1 3/6] arm: Prepare linker scripts for memory permissions
Message-ID: <20250205190345.GZ1233568@bill-the-cat>
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
 <20250205071714.635518-4-ilias.apalodimas@linaro.org>
 <CAC_iWjJnGGLhSyZFyF3jju9Evq9hY792jsDD4bL33H+6E2x9+w@mail.gmail.com>
 <6e34f324-f9ea-476c-854d-92574f35ae9d@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FJQcRwPKnaS4R9hJ"
Content-Disposition: inline
In-Reply-To: <6e34f324-f9ea-476c-854d-92574f35ae9d@amd.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 05 Feb 2025 22:31:05 +0100
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


--FJQcRwPKnaS4R9hJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 05, 2025 at 01:41:46PM +0100, Michal Simek wrote:
> Hi,
>=20
> On 2/5/25 09:22, Ilias Apalodimas wrote:
> > I'm just replying to myself here but I'll send a v2 when the patches
> > are reviewed.
> >=20
> > I can add the linker under an ifdef, so u-boot size won't change
> > unless a Kconfig options is selected
>=20
> I think you can just do it for alignment not really big ifdef in the file.
> Definitely this will be needed for our mini configurations which are runn=
ing
> out of OCM.
> Feel free to look at xilinx_*_mini* configurations.

Does the existing SPL_SIZE_LIMIT on the mini configs catch problems?
This series doesn't trip it there, but maybe we're only close? Thanks.

--=20
Tom

--FJQcRwPKnaS4R9hJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmejtgoACgkQFHw5/5Y0
tyxsTwv/eicjCZRJOtLmnqEEqDglLH6BbEOljzh7N/XE0pV13g+qW8rc6L/Ox8jL
w8Ohh9Dl06hnwuwJ+XLjcWLMzt+SpX5E4Bcf40cAfLwGfvaS8HRjuqH+QDjApLVI
uBNe1aRgdhWpMksQszIPu/Q9zuIBDO9LyOf9oWAHQ4g+XxIh46aMtux+K0wtu51P
U3TtbwBYnq4TYHLo9wMveYjmRLeeVbYduga2CiohzpOse7rEvjKZ6Q/Jen0MRcf8
3ABuwn/GLhJebWQSc8r88ef6s0odyzWH48FJbgYDcWQYQiMk1seqAZFN2dC/vMrW
swHQI7d4fBAEA0Ida9KaBKSIPZ2/arT6pT9h+RIc2U+9XAtZdrf1wg359ksFkmAq
UQCtgc2KwK9A/9ltc2h8t7AlU0t+ROkVheACEttwhPBfA3Q2zqCckM/GyPvGIhjl
jyLwgfJiJ86TzEAW2GMHK69Dqx/HJsMr0v3qzt+tcEKLXCmrqe/GKlfjJbxJLWEd
134jfUQY
=09Oa
-----END PGP SIGNATURE-----

--FJQcRwPKnaS4R9hJ--
