Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E02DEB362C
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 18:40:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C03AE83F0A;
	Mon,  2 Mar 2026 19:40:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tiYLhW3j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B7C483F0A; Mon,  2 Mar 2026 19:40:05 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4417483EC6
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 19:40:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d4c543472fso5224234a34.1
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 10:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772476801; x=1773081601; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vZCUsQg7EnerM+hVCZs8yZFYhrR6UqQbCrMRWhxhp78=;
 b=tiYLhW3jvffLMMPzdVVWUGH/Jpda9uKzFdPxIOC5Glx0MzV3bwnLjx0Tk6Yxgj7+ZD
 3cEbG8OTjoMlmMLYaQQmBW06fmMScxBKTlCARGSxFSNAsJ+AhY7iCj3avhSyoK3phISE
 nSZrwV1fix+J9BJ1FHavzFysd+Md0To14Gars=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772476801; x=1773081601;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vZCUsQg7EnerM+hVCZs8yZFYhrR6UqQbCrMRWhxhp78=;
 b=shbvR+FxayfXHGZGFxTA/Ozx9qJRYLiMgbc2VGQOzn4RQb2NZawXuMC/zZ+viNL5TA
 sNWO8oN5fKiRNY6Il1Ja0GTT34aJ7Luy19J44Nzqnh+TYAdy4ftbPsNKngvQq2k4aB1p
 DYYrHj/kZ22rDs4hQ4hQqf5PWB37HrLm7nW6XSWTWjZ+Hy/A/uVGUGWoRQQkxF/f8mr+
 EA0tNRKA+PZRwKVA5hvcNbGw2iV81OFeRsRK0dUzRC6mPqMZup5Znd7Igct+eWBWpdt+
 Y3NGFJ7gQFmweshtSHH+lROP8k6buVfcrQiwsjWHLawHEBV+jpQ4DfE8TsNeKRG0zj/V
 Br2A==
X-Gm-Message-State: AOJu0Yw+v+n2eYOfICP3+JYetwzyp7hxyX291BUAHSNlu4zU1rDm7fON
 6MmeGrWetYyfNWvFNKmtF5gRV0pHyEDGyspkEjPflkU0zccRpoZv0rjY1limjHMkN0z7gA5C/Sb
 VJiPx+qs=
X-Gm-Gg: ATEYQzwRcDwECLwVEgMW/EBo6bXKzIXqVTvjIdMYd5yC68D+B2EFGr/3wcOddqXHiRh
 0wTv0VEDUDoVGgDg0KD4ipIvfNgUWSVNUH0XYSDTSHV1sZFXYERUDjNTmZYQ9/WJ/PyFOaRnn7G
 FG6FaYAu+iQYeNxKpjTQqkxOcsoLoVFLb5zrX3bIUCjxQAV3xflhdszlTd1W6PTlvx3y++Tkj7o
 m9Kzd2PpGsJXwv6WWQQ5K7gH67c8+la46opQulmcoJLEtLOhACFDLo2rqHGyX2qXDgxOH2+qvhD
 yWQfxrKRRoEFx87lOGWSx6NG+nRQ20Yuea1S0wxxo9augFjp92TP9hKKFDs7fNE3sbIGmzmEPAB
 nrxS8rC0rR4obNF3J8Kpbie6TqhZvo75saLAQxUQm+q4BH/TSSTeSHXFm/hkrOwVi2SUeamltKg
 MCOBfO2xOUXn9MLUvStU5tv9Jy/2PVBoeN3qzALv9bsv8MvpCjnxD501HoNskOAikzLtz096nMr
 tBSLew9iln/p8XhIISiCLRm6qKkHdhKec65a3tDVJ1ZYABV08k=
X-Received: by 2002:a05:6870:1849:b0:404:1e38:60ef with SMTP id
 586e51a60fabf-41627928bbamr8811975fac.15.1772476800629; 
 Mon, 02 Mar 2026 10:40:00 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cf9906dsm12782319fac.6.2026.03.02.10.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 10:39:59 -0800 (PST)
Date: Mon, 2 Mar 2026 12:39:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Aristo Chen <jj251510319013@gmail.com>, Benjamin ROBIN <dev@benjarobin.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>
Subject: Re: [PATCH v3 04/17] bootm: Create bootm_final() for pre-boot cleanup
Message-ID: <20260302183957.GI1388590@bill-the-cat>
References: <20260228202011.1834493-1-sjg@chromium.org>
 <20260228202011.1834493-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BBzhdjdjebf1CxF8"
Content-Disposition: inline
In-Reply-To: <20260228202011.1834493-5-sjg@chromium.org>
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


--BBzhdjdjebf1CxF8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2026 at 01:19:52PM -0700, Simon Glass wrote:
> From: Simon Glass <simon.glass@canonical.com>
>=20
> There are various functions which announce that booting is imminent and
> do related preparation. Most of these are arch-specific.
>=20
> In practice, most archs do a similar thing. It would be better to
> have a common function, with perhaps some events for things that are
> really arch- and board-specific.
>=20
> Create a new bootm_final() function with the common pre-boot steps:
> printing the "Starting kernel" message, recording bootstage data,
> optionally writing bootstage to the FDT and printing a report, and
> removing active devices.
>=20
> Be careful to avoid using BIT() macros which are not available with host
> tools.
>=20
> Signed-off-by: Simon Glass <simon.glass@canonical.com>

Getting closer for sure.

[snip]
> +void bootm_final(enum bootm_final_t flags)
> +{
> +	printf("\nStarting kernel ...\n\n");

So most platforms calls in here with "fake" as a flag so that this
printf can be:
printf("\nStarting kernel ...%s\n\n", fake ? "(fake run for tracing)" : "");

But this isn't preserved.

We should just call this "flag" and make use of it already
being BOOTM_STATE_OS_FAKE_GO, and have the riscv and maybe arm patches
(less clear since it's two places since arm and arm64 both define a
function that calls announce_and_cleanup today) be dropping
announce_and_cleanup() now that it's just two function calls. I see that
arc is just doing this openly and I assume everywhere else is inbetween
the two. This lets us also drop the new bootm_final_t flags as well,
since it's only for the fake message.

A separate follow-up cleanup would be to make it consistent for
do_bootm_linux to pass flag around.

--=20
Tom

--BBzhdjdjebf1CxF8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaXZfQAKCRAr4qD1Cr/k
CojRAP9+GmGTH85884LFW/MnXuynfSTNDGvTjTmFl6oO5yYdygEArKmVUUDuZ92W
lma+bCFfHuarRFKh1WGVf/d0Y2kHIQY=
=L3V7
-----END PGP SIGNATURE-----

--BBzhdjdjebf1CxF8--
