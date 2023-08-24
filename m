Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E55F3C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 13:27:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF1C786433;
	Thu, 24 Aug 2023 15:27:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JUOdPWd6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21C9086435; Thu, 24 Aug 2023 15:27:25 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EE5986430
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 15:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thierry.reding@gmail.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-99c353a395cso903492066b.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 06:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692883642; x=1693488442;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EBotSSCkQL3DrtMdMgqtjaHwgMG/BF/adN1fVYWa4ws=;
 b=JUOdPWd6IeRg6Vlo9paeygil23e/MUn1TFa2YrPsRpW9TcTiOG4abCquGO6KY99Z+Z
 4jj8oh/U89sEBc01ZgttcjSOciXwy2eCor0GbT8GIWJrIAwMNO6mfUPuveQF0OE8x6pS
 f28EXc8SqPgRFx/juJriMeD/9+6JVUhd/XkLNrsJ3ENVlkn1EgmIWsUkydYPm5jWCaZQ
 dbBU3uUyXRkDKqxLT4+6LZ00pE0yskn2UGbmvfQmqxVZxnNG9C+670eESF5VoQM2lMRH
 XapKbDSwccXGmaeWjphF782o1hHc/vh5XYE6bqSNLyTEB9jgFhGHm+bL7wS6SPEIo5/V
 58ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692883642; x=1693488442;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EBotSSCkQL3DrtMdMgqtjaHwgMG/BF/adN1fVYWa4ws=;
 b=D0mMZAao+GUhCtM8BkhOJ1cvt92tfoUvHTghjRHjh0U7JkDcx6EwsmSHbOQN9Ow27L
 6SyQ/ezt9BJKBYGl0ll6nImFHhpsWLoRUqsTKJc2xboWFNByD/7Flf9n7gow0a6YiXRJ
 I30GUH47WLM5DR5T/Jg97rIiQBshdElFFbAANTdT5RvnTn17Gcm3k0yl5GrRJAL6D1Mh
 xZ3VDqnAjzuMAgTMXPvPe8CSHY9mOupZY/VPKVI3ozUi7E5tZMKh8AokLDqLjuYlArBv
 6akGrxPbWLpFVbI4FjkYoxPdmwh4xXmUQgJW4ub6yFvDCGEcmbmOIqGLvOVV8Mo1wwRg
 wQUg==
X-Gm-Message-State: AOJu0YyZiNGvbfyPBdevjVtrz88uQvajUjHcM0z2vONUymQDy4ITQzOA
 bNTuYauZIG4+XULUpCNzJrc=
X-Google-Smtp-Source: AGHT+IGksADuB9rDZvsIr9EYuyjw8umhA+1+11Oa5oVYY28t0Z7MmOPut5w0tEcz3OzrUWkbr4+MuQ==
X-Received: by 2002:a17:907:78d2:b0:99d:9adc:d69c with SMTP id
 kv18-20020a17090778d200b0099d9adcd69cmr11832108ejc.14.1692883641815; 
 Thu, 24 Aug 2023 06:27:21 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de.
 [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
 by smtp.gmail.com with ESMTPSA id
 ja25-20020a170907989900b009929d998abcsm10987228ejc.209.2023.08.24.06.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 06:27:21 -0700 (PDT)
Date: Thu, 24 Aug 2023 15:27:19 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/1] tegra_mmc: get tap and trim from dts
Message-ID: <ZOdat7QlHuhU5TVZ@orome>
References: <20230819153501.77245-1-clamor95@gmail.com>
 <ZOXlJmZicgBUINlb@orome>
 <10578B16-04A2-4CE3-83B8-2BF7FBDB7711@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="B3QXKp+CpqknrVS4"
Content-Disposition: inline
In-Reply-To: <10578B16-04A2-4CE3-83B8-2BF7FBDB7711@gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
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


--B3QXKp+CpqknrVS4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 02:30:48PM +0300, Svyatoslav Ryhel wrote:
>=20
>=20
> 23 =D1=81=D0=B5=D1=80=D0=BF=D0=BD=D1=8F 2023 =D1=80. 13:53:26 GMT+03:00, =
Thierry Reding <thierry.reding@gmail.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=B2(-=D0=BB=D0=B0):
> >On Sat, Aug 19, 2023 at 06:35:00PM +0300, Svyatoslav Ryhel wrote:
> >> Default-tap and default-trim values are used for eMMC setup
> >> mostly on T114+ devices. As for now, those values are hardcoded
> >> for T210 and ignored for all other Tegra generations. Fix this
> >> by passing tap and trim values from dts.
> >>=20
> >> This commit will cause regression on T210 (emmc may not work),
> >> fix is applied in tegra210.dtsi and will be sent next week.
> >
> >Heh... I don't think so. If you already know that this will cause a
> >regression on Tegra210 you need to rework this. Adding regressions
> >accidentally is already bad enough, but doing so knowingly is a big
> >no-no.
>=20
> DTS change for t210 was sent in "General tegra and board improvements"
> patchset. This is why this pathset contains only 1 (one) patch and a
> warning. It has a dependency.

For U-Boot this may not matter as much because the control DTB is always
linked into the binary, but for Linux for example we need to make sure
that the kernel always remains backwards compatible with older device
trees. I think that's good to follow in general, so making sure there
are sensible defaults to fall back to if the DTB is missing some
properties is good practice.

Anyway, the way you posted these there was a future dependency, so if
someone had applied the driver change without the DTB change having been
applied first this would've caused a regression, which is always bad if
it happens at random points because it makes things like bisections very
painful.

So unless the patch is fixed to fall back to defaults for Tegra210 we
need to carefully coordinate in which order these patches go in. The DT
change needs to go in first, followed by the driver change that relies
on the DTB update.

Thierry

--B3QXKp+CpqknrVS4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmTnWrUACgkQ3SOs138+
s6HPrhAAhh9mr/g/x9HyRt/JtBGlT8dUNf1+XE49SLMielPPwiDttPDE0ZA2U0xB
J+9xI7uJ2KOISM90GTX5kk1W2qhm0BfDceP+zIzmcdLOwc+IRwyY13DZvuvzhxQK
QgCcTETBTnINnzU8vj9Z6rHDaljM4g/o+pZlGKcgNVJE613290cFGExoO0UpFTcm
Mzna2vSMhbxXEBwF2P0ehKcbyMoxXZ8dHjZkxFTaMhgkEVAjEX7csP86NXY55zkT
GWMR2ETN0xqVWW0NSgifRT6UG/iHQePHU+4KHVGtLfAFCoU1XE2vho+gU7GaTxPS
WVl21UJQweAOAqc4Hy5V8NswYFMY5EFI0ZqjGQcgPEsqLvzmrJkDrl9B8R52yOVM
Pzt3hKlPKg9lLUKY73mutDcbOCuAEDYt/nvRfUwW/A6sYeg+shenzZAuFqvXBsh5
6xEMSIl0t+CLtrFBbei4laoGVnyM06ZdFZ4K4lxs5axxnmA7jMpjTZnDbynntv/N
zs+dNjFQk2+snOdUQ2sbRUQh2uMXzIpGHp5iRNbMdrJmE9cQV6NzWPIHS7c/8IP7
WGw/X/JrifeYrMUamNWAjpSMunJdQAIQ9k6YMcJ9SUOGpPieyQDh+Nl5HzDL9jAs
CQKf8brJNeoq4zwkr0O4LTnWnBoueZCJdLH/3p/N8GrpPZtmW24=
=1KpQ
-----END PGP SIGNATURE-----

--B3QXKp+CpqknrVS4--
