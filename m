Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A870C47422
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 00:01:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60AD387867;
	Mon, 22 Jan 2024 01:01:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L8jzvAzA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99529876E5; Mon, 22 Jan 2024 01:01:10 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59E31876B1
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 01:01:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-dc25099b084so1474054276.0
 for <u-boot@lists.denx.de>; Sun, 21 Jan 2024 16:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705881667; x=1706486467; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nLaE2WB6kVRcS8m3/wfMON0NJ3a+gdsPmNnqFQMx2E8=;
 b=L8jzvAzAmF/pzsBA+SM4sWVHSYFeheyIcU2KrIaML9WGHDfxlHdF0lRv4jZrW+og89
 cz65Dcnsm4qve+ESQZql3AsszHzl5FAwy7ajdugsmADDKcX/4ANw37KUqtYlte40KOL5
 2ety0S3FViksT6znsd9oBikYq7aq5cflQXfcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705881667; x=1706486467;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nLaE2WB6kVRcS8m3/wfMON0NJ3a+gdsPmNnqFQMx2E8=;
 b=ii8xe4TG7AWACpdThfI4qmIjkYXYPi/DlgPCT8UMpwFQzYNzHc9gpLQUAZzd2gHEtc
 E9e5qHBKg58ubP3ftrPosGI1cg5LajiP6AlVHy2UTtzuWT1d0avqI3kvFGvGV+LBIJvv
 e5ClTlVa0fjgzbwLd2v9Zd0KVA2Z1h3EYzQJl0xCs1z0l9vYeeiAqbhSuE/c1dsex1Ii
 YHxY8vFCeSsnUdXcNyVjg3UH9BjpJoTOU8awkzMGSlNRCtc4xwRyvsPmk8RBHP863y2p
 iU2yumbvO6zLxmT2Ws2+slZrXBaNdVYqTeJtdth+wLzhhuoB4a1bSqRoWH6aS+AOu1HG
 aEmg==
X-Gm-Message-State: AOJu0YxQuAf/fB534uQrTssgmKArgoeGDHO/A7PrX4eEcaNOMlC0Vu+s
 MMeqAPKb9WZO9NyLdgtu+FwhBhlhmKrg8XyF7KUG1GeOecMYlUVtWJtW/jL5Bzk=
X-Google-Smtp-Source: AGHT+IHANI/FNMjHOk2PI3xVYeR1BQj7TvPvnwxew6YbO7xjkklffUfR4ACsfMbLYLbC/e14xu3UBQ==
X-Received: by 2002:a25:b908:0:b0:dbc:daf3:61c2 with SMTP id
 x8-20020a25b908000000b00dbcdaf361c2mr1488469ybj.91.1705881667062; 
 Sun, 21 Jan 2024 16:01:07 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 v40-20020a25abab000000b00dc25a265260sm1291477ybi.34.2024.01.21.16.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jan 2024 16:01:06 -0800 (PST)
Date: Sun, 21 Jan 2024 19:01:03 -0500
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Marek Vasut <marex@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 u-boot@lists.denx.de, u-boot-amlogic@groups.io,
 u-boot-custodians@lists.denx.de, sjg@chromium.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor@kernel.org, neil.armstrong@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
 mibodhi@gmail.com, bb@ti.com, mark.kettenis@xs4all.nl
Subject: Re: [PATCH v4 00/11] An effort to bring DT bindings compliance
 within U-Boot
Message-ID: <20240122000103.GE3652023@bill-the-cat>
References: <20240110103547.719757-1-sumit.garg@linaro.org>
 <82d509de-3d47-4cc2-8217-c38dc78fad28@denx.de>
 <7b4ff8e8-2f21-4d07-9848-fb0d5652819e@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+BEsnWEudJb7rHiP"
Content-Disposition: inline
In-Reply-To: <7b4ff8e8-2f21-4d07-9848-fb0d5652819e@linaro.org>
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


--+BEsnWEudJb7rHiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 21, 2024 at 10:41:51PM +0000, Caleb Connolly wrote:
>=20
>=20
> On 21/01/2024 15:33, Marek Vasut wrote:
[snip]
> > Assume that there is some large breaking change in Linux 6.(n+1),
> > something which would be problematic for specific U-Boot platform (e.g.
> > i.MX) or would require a lot of work to sort out, will there be a way to
> > temporarily pin DTs for specific platform to older DT version until that
> > is resolved (e.g. pin to 6.n) ?
>=20
> (Upstream) devicetree has to be forwards and backwards compatible, were s=
uch
> a breaking change to get merged without prior discussion with DT users (i=
=2Ee.
> U-Boot) then I think the correct course of action would be to revert it.

The caveat is "unless it was wrong before", which happens more often
than is generally thought of I think. I'm not sure off-hand the best way
to deal with that.

--=20
Tom

--+BEsnWEudJb7rHiP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWtsDwACgkQFHw5/5Y0
tywSkgv/d6a4U7YcvCgUcfwm3vPPsG+tRj+F6QJy9AsAe4vPpEfeuHA//nylwj5N
q2XKgIJCK287vw57fgm0BGQX34oaLTbhFnak0yoe9TNRHd4QWLnXku9DclCtAWWU
T/rO0JnuvU41hpTJW2IN4+SU4nKslNSuKiwU4kn8k8TqZwfsAm4GQy9fqNZpglf2
aq7C3Lo07UbXEUXLShOopfbS6/NpXG+x10UsD0FLPM9YQslDXxnHABhODyKvOjba
lqeENQjRNOWHl1pgy/gB4yp65dWdsUaRmhRdI79IqWUFsA8162/v1eUNFf5zJzXf
7vtWoZ89QFD9QNYN/67SFTiCODF07MJgH9MdF8aW/XFrKbeJOg0d9KDULLG3x/1p
NnELJKu0ZhKQnRgHJOJVFUeHV1uqsGg7lSdtlfbQD+JraAvLRoRhvaV8BZfSoawB
NGbeOzp/zeF/6o2KqsomXvDKQVEYStEQjZwBgoQAKNzCxTld/cp8UVW29ieESEGo
Eff/Upj+
=PIBb
-----END PGP SIGNATURE-----

--+BEsnWEudJb7rHiP--
