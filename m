Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEAE6C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 14:14:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D65987C13;
	Wed, 31 Jan 2024 15:14:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cGg076R3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EE6B876C1; Wed, 31 Jan 2024 15:14:06 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1407D876C1
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 15:14:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-68c3b845643so32811726d6.1
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 06:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706710443; x=1707315243; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=T3W90rjn/izBF2Ey64S+X9R/Q2UfxbQp+wUS5psRRsU=;
 b=cGg076R3mxbEaAS+hftiFEpewzKyELslWOv0GUPnMJ4/c1Y5v/ae5ZOinVIl7mgfaD
 5ipBb6XwQzCMkaJr1laXAUJ61LKqzmGcNH3yGnZxEqw4fQErLQPIQclLvR6VDPAsJ9hN
 xvY4HfPMpuS8HFTSBzqy3dRP9rcJ45KjaOcOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706710443; x=1707315243;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T3W90rjn/izBF2Ey64S+X9R/Q2UfxbQp+wUS5psRRsU=;
 b=MjgAHgN5S8WpTsbofABqsFw3pWzkaKp8zhXDOry7djkHRxDUc6V2tCdOPc/51iSNU0
 e8pySP9lM/SGsGdMjqydKPxm8G37ryaCcz60kGKMjA6yBodfX9ELH/ELS/awYCJUW3i7
 7CeSJMcISjbBeiD9TL2AjedwE+W2H96vFZ8XYRhr/o2eGTfKO4yU0Wtt3Q9I9gIcnEJd
 dY9fevCk+CxTbfKTH9LRVpu/zxhcjcJmUtsUDBp/jrXRRJQtYhCObLbIaXyOcGktiZFt
 9ZSv9mYIU+05Oxpu2U0h/h3hiWPV+iuV6mDJG5IpER4r7IKxaV+gHIHziQBocb4c59Ur
 qL+Q==
X-Gm-Message-State: AOJu0YwQ83BkBHkpoMJi9ud3My2xgPiyPCvSn1Dh+wG+giRFwbUjVol5
 1+yDyvx0f9rTNOx11o0BEHAMCtNPcPfjAbK84WwNYX7CBMTocEXElkT69y8Yh0Q=
X-Google-Smtp-Source: AGHT+IE8TD5ymR6r6NClD5wfQlHDL3/wlPbeB5a4BSsZw1gUkhwKQgHsWkoM8lqm9GaEfblufxufAQ==
X-Received: by 2002:ad4:5cc1:0:b0:684:6077:f923 with SMTP id
 iu1-20020ad45cc1000000b006846077f923mr2187489qvb.5.1706710442827; 
 Wed, 31 Jan 2024 06:14:02 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 w15-20020a0cc24f000000b0068c55087a1asm2483583qvh.74.2024.01.31.06.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 06:14:02 -0800 (PST)
Date: Wed, 31 Jan 2024 09:13:59 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de,
 sjg@chromium.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org,
 neil.armstrong@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
 seanga2@gmail.com, rasmus.villemoes@prevas.dk, peng.fan@nxp.com,
 jh80.chung@samsung.com, rfried.dev@gmail.com, mibodhi@gmail.com,
 bb@ti.com, mark.kettenis@xs4all.nl
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance
 within U-Boot
Message-ID: <20240131141359.GT1152441@bill-the-cat>
References: <4d8aede8-5ea8-45a4-87fe-d555a025ef8e@denx.de>
 <CAFA6WYN1tFs1id7UxTwLEyp69zx2BPUP7bffVZn80FKPLx2yJw@mail.gmail.com>
 <48125705-e78e-438f-90ac-2816432cd747@denx.de>
 <CAFA6WYMuerS5YTsquGvc+OHr+0a3JXrM4AQ_ReV4tPhvxv9H0w@mail.gmail.com>
 <20240125150400.GM3652023@bill-the-cat>
 <79439bfb-5ae0-4492-a298-788fb46eafa3@denx.de>
 <20240125231933.GY3652023@bill-the-cat>
 <0d4ed462-a5ec-4114-84ab-d2e2a6d79b69@denx.de>
 <115d5376-8cf9-474a-9344-223df4ee1d6a@amd.com>
 <CAFA6WYMP0=LOJhHYvXSB9CA-EaSD0+dfxZcb6U0BTgfRiGk4hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="X2GTna+0FOO3XRbJ"
Content-Disposition: inline
In-Reply-To: <CAFA6WYMP0=LOJhHYvXSB9CA-EaSD0+dfxZcb6U0BTgfRiGk4hQ@mail.gmail.com>
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


--X2GTna+0FOO3XRbJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 06:26:54PM +0530, Sumit Garg wrote:

[snip]
> So I did a demo experiment for this here [1] where cherry picking DT
> fixes into subtree just worked fine with the next uprev. Steps
> followed:
>=20
> $ cd <U-Boot tree>/
> $ git remote add dt-rebasing
> https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-reb=
asing.git
> $ git fetch dt-rebasing master
> $ git cherry-pick -x --strategy=3Dsubtree -Xsubtree=3Ddts/upstream/
> 9de355a75fdeffc26486508107bf644ca2749fdb
> $ ./dts/update-dts-subtree.sh v6.8-rc2-dts
>=20
> If you would like it to be documented then I can do that for the next rev.

Yes please.

--=20
Tom

--X2GTna+0FOO3XRbJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW6VaQACgkQFHw5/5Y0
tyzrWAv+JwCM9eINJZTuM2JcdpyAKCxDICAg+KZNG6bYtKczZAkx0lZJFIWLepUW
MqIyqr/lX+kBYYXlOGkGlljBntTOk/XkQKiYAbvbErnJS1CdcxxKMSFYzkRjfHYO
RXn8PR/307hhcd4sQcoR2r8v12MJz4/3bcMTzdMa00Z+Y3IMYalc1ZiD7ARFJUCR
8dlPjGSH7sj9ua7GfvcaOmHj9UTNmwtshaL532xvHfIjYMFEjaN2VW4fISO8P8WJ
nllR9EhctDPwiRsOKAySjZXZ0EUPtOz8Nvh0H83aaeAmjsKAe/KtEwleIT793Vu/
OfFJ0o3K7R64MFtPTWaN+yXJIYrVmHmpCaGHPhm3KKgoSA6zS/TNwApooy9+JjZs
f2mT/ZPsxoOeanIc9LKwcdGqzPDqg8ZlLK2ILpYygrZhwMANZB1cjPgOCvbYKF03
qSgy5BZKI4C8o1L1oymLn8fDDoOe59k9NL/xnh4lOnj7/EWy8OWTosZJbgy58N4A
c9fLhRlS
=8e4O
-----END PGP SIGNATURE-----

--X2GTna+0FOO3XRbJ--
