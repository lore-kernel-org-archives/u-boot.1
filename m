Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D13EC71121
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 20:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68096886E5;
	Wed, 28 Aug 2024 22:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sYdS/jMF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8B32885C5; Wed, 28 Aug 2024 22:19:18 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9819C879C1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 22:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7a337501630so456124485a.3
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 13:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724876355; x=1725481155; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u5SqORkgsJp1g+V/G6fWpyentIHvyB3kWiMVU3t+Owo=;
 b=sYdS/jMFDMsUo1ME9BVE3y5yOdLYLDFpzGRtSowe2M+E84xOmi/6awIMs+yzJyW8mx
 Njb190h7H9T3TuoaZhdMCaO+Dz7PzN2MBlZfBCF3eyRFY1zDIz0u3hzUfR8eDvlMqlFU
 NqnNe7ElMZcoYbeOLbYAVRnPGqn8S5Vfk83is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724876355; x=1725481155;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u5SqORkgsJp1g+V/G6fWpyentIHvyB3kWiMVU3t+Owo=;
 b=ofcPSzH3wtEr8cAf1rjXr/qqNWyJ3iAXu23dzLZoCbRZCf7Xi8poTBR+FtcZiuU/kJ
 +hNtXyr+V3sxk5C6eHXWe45DX8faCkD3/Dr5xmmo5biBujt6ADV+lAUNOnPyAu7YMSpx
 CqAXLKZzD7gGKnqQOj/yNQsSNC3rvH8x0cV5njOCtLWCKqdsq1ifUhxj5AzrM66ommVM
 QhOKzIyDK/TdRf994afqBCeefwLnG7TaX6vbPA2Px0APS4hgW/NdXFt/Zs8UU2kQFUWn
 HzQpXsFK/21XoCu1k9lvwkVHAEZ1IJKFceLnSiDYqbPk0Lm1+CyN+k61xKEjmIjbbOrN
 ffbQ==
X-Gm-Message-State: AOJu0YyGpXUTDULuXu6C9xW2vZfVbcqPtOokvuakR8avb+0pS86Jm5z8
 OZnbBy/Za7sbWV4jbhG5QZRuIuly4hArF8tpKtZQjk74tF7mThpuqhipv0aLi4w=
X-Google-Smtp-Source: AGHT+IHyUJqfdtIK5uG+7NlQq3BVWphTm/lnIxg/j0dHiR5NHMjE40zzHgPLIg7n+d3gbhk+DDti8A==
X-Received: by 2002:a05:620a:46ab:b0:7a3:51ed:38b0 with SMTP id
 af79cd13be357-7a8041838afmr68674985a.13.1724876355274; 
 Wed, 28 Aug 2024 13:19:15 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a67f3fc894sm664674685a.113.2024.08.28.13.19.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 13:19:14 -0700 (PDT)
Date: Wed, 28 Aug 2024 14:19:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [u-boot-test-hooks PATCH v4 3/3] Provide some basic scripts for
 Labgrid integration
Message-ID: <20240828201912.GV2479150@bill-the-cat>
References: <20240828164523.125770-1-sjg@chromium.org>
 <20240828164523.125770-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DnL31iSdubakvSVz"
Content-Disposition: inline
In-Reply-To: <20240828164523.125770-4-sjg@chromium.org>
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


--DnL31iSdubakvSVz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 10:45:23AM -0600, Simon Glass wrote:

> With Labgrid we don't need to specify the various methods, except for
> the console, which simply calls labgrid-client.
>=20
> This allows supporting any boards in your lab, without adding per-board
> configuration to these hooks.
>=20
> Provide ellesmere files as an example.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

I think maybe we call this version "labgrid-buildman" and make sure the
documentation emphasizes using buildman to provide U-Boot. This will
make it easier for me to provide a follow-up of say "labgrid-external"
that requires the binary to be provided, similar to our other hooks.

My thinking is that while it would be good to be able to expose labs to
CI, and I would like to get mine showing up as well it's also important
that I be able to keep doing the type I do where I extend the normal
defconfig with additional features to test.

--=20
Tom

--DnL31iSdubakvSVz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbPhjwACgkQFHw5/5Y0
tyyIWgv+N0XXUlO5WIFJtas12Pj8HNVimaibvReEqS6NVLD+qjy2cj2U8L7mcgPY
Fz7EMJkqMp7pXNcamQBrDZry01XupaL/bSEconAb0dHJiwVu8gkLbLyO+R41FDeK
lElGuC2k3l/v7CAKDHFS9J3nsrwUo8tZmMsySeAIDmne1L8dRK3groALcPOGlkWD
JR12s2bAiVwhMzRDSUVDHsfI0Z+lTNIjAXbFNiPRpqRSlVOJuByker1WqsXyJcP5
Sars1HhY88pdlx/fbx+qS0lWBaGuQAMY3oPC5J2l3nC8XrZefmuqgMvJIGB1/RVS
jw8TS7NnAXdXKOMLgER43Eq2qcf7l0vb4lYEcATmoDuU8DzWS6FxqWWarFnHlBRJ
4YWY1zpBSwJC7CgCnj9yyXO+Prq/LVnbZKi7YKO5Og17NumUHxsJS9Fm2SSqaO8X
DyhCW4zffu9VnEBRFpDR33v8LHrrn7Cu/qZ0vUmzGlNEwOjo4PApqceU7WrqSH6Q
nTz2udg4
=AEi4
-----END PGP SIGNATURE-----

--DnL31iSdubakvSVz--
