Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41547C44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 17:24:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B04D84C33;
	Wed, 15 Jul 2026 19:23:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Kg50CIna";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 034CC84C42; Wed, 15 Jul 2026 19:23:57 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FC9E84B86
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 19:23:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7e9ecd7216cso1195556a34.3
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 10:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784136233; x=1784741033; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xQFJsMw9/oKNVN11fCfN2LDv8PrzUbCegafOrH3nwr4=;
 b=Kg50CInamHv+5+cEho9/oYQGNkpWzLuhO5gkaOPXmlSsgsZO+pd1EQsIW3BZZ7Exyx
 i1kYKJ21Gvaqv4b4cNCKtf8P2IeYukszK8Sg0dZVul+CLNkzgwFwtkYIAVrKA9hEf7Jt
 1OD7dRQAraR6TW/BuQJ96vPcXLu+s41lIlm5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784136233; x=1784741033;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xQFJsMw9/oKNVN11fCfN2LDv8PrzUbCegafOrH3nwr4=;
 b=GcnD5ABJ+mz7sEORw5yS5MVgoQ6aD2/WnK6T8EfsJmoRIwCwFJBbxs6Y+gT75FrCKx
 Rtk/OD6nHmTz013HPeQovMnZCcvcRLve403ioygc0N97X6paSWXnLQYvLoaPSthXbEUF
 +1ugXfDstU8ZDt7v/OhL76SfI9wW4px1PNf/chDcGmZ5g6ko8rs1p8YEllkvFXZhZcN2
 lNuu4lOYAcz0LFKDwBhhyVcpnnH2fvLCtcFwB9/E+UcLAMX+YoFgClVZ8CAPKfCixaMR
 oEzRiKwSZ3Qc17cNC8w0WPL0P0VnJNnQtNDjlOZj/9E18OO9/3qNR1NWQoUOmT9hagHd
 hSDw==
X-Gm-Message-State: AOJu0YxXtseV1CWRdDPvGaQdOVf3eA3ojRHrblcc+oQADFO17eDc8YWN
 odemcRWZRiCbx3mURt+FCZ0z8e9TA38VojR9PqQ6xOAd5HdkHf+Bv3oZoOW7AptOcNI=
X-Gm-Gg: AfdE7cn5KgFr++6KFgLc/bB6XTt3ed8kdFnb9kLizHRFjGiD5vvbj7m0HJpe0t//6j6
 m0PJZeo9NIsLNG6drzmsoIXFOowm34FfCsMdqi8zViO2aarmEZ5MPAmFf/90cPsBNvoGfTE6oFq
 jjTO+tK32VylqstOyGF0Hveg2dHFupKPotWa/wylg0XsOJ5F7Lj2Ff7WOBYu3vroy1yvI+SEygY
 1rFS9zcr+/oAXKij6cbe6r2SUA2CWVVYCasCHw+kH/AqG0+QvxFSMNAu7a8lnRIiZqRtpZBQqcL
 yLpOSHspS8vNoKyRbTfwvMZ2bTztzHkkyosRYmjgG4XmA95+qqfiorQgfhcTUlBHPyxcmTS5mxw
 3ezOPaCewx47dHaNTh0tWfqs032FgRrirlk1aPX2V8qNZZ44UAoWypKM4kC9fUhFZMzolPU8xca
 nBI+tLRB/kdplV/HTu68wCmqySue00r1MbXjbStgm2indE0kRfu4CeNy5zM097/0N6/PwVt3/Lu
 j3bI1JhUWUFvC2h4MRqbMv56GSn5xKgcRm8tw==
X-Received: by 2002:a05:6830:4412:b0:7ea:b8c:4198 with SMTP id
 46e09a7af769-7ec096c3a2fmr10512723a34.8.1784136233262; 
 Wed, 15 Jul 2026 10:23:53 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcb2630casm18907723a34.18.2026.07.15.10.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 10:23:51 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:23:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Sean Anderson <sean.anderson@linux.dev>
Subject: Re: [PATCH v4 3/3] test: py: load: check null_dev_desc_ok dispatch
Message-ID: <20260715172349.GK749385@bill-the-cat>
References: <20260601131311.1163914-1-vjardin@free.fr>
 <20260702144359.1583239-1-vjardin@free.fr>
 <20260702144359.1583239-4-vjardin@free.fr>
 <20260715005625.GA4103122@bill-the-cat>
 <ale-vlEwBRNgIWcD@L30177.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DY9ZdYFoeEEBb+qI"
Content-Disposition: inline
In-Reply-To: <ale-vlEwBRNgIWcD@L30177.local>
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


--DY9ZdYFoeEEBb+qI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 07:09:18PM +0200, Vincent Jardin wrote:
> Hi Tom,
>=20
> > OK, but this fails CI with:
> > https://git.u-boot-project.org/u-boot/u-boot/-/jobs/40773
>=20
> It should be fixed now with the v5. By the way, how can I run/check
> my series on u-boot's gitlab runners before sending them ?
>=20
> I did miss it with my local runs !

Thanks. Part of the answer is
https://docs.u-boot-project.org/en/latest/develop/ci_testing.html and
part of the answer is that moving forward, we're going to be opening
git.u-boot-project.org up for more people. But we haven't figured out
all of the process for the latter just yet.

--=20
Tom

--DY9ZdYFoeEEBb+qI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCalfCIQAKCRAr4qD1Cr/k
CiuTAP9H7BugVvq/YhyB16CGdx7EFXpj8MYkEPUjng71E/LWSwEAvVfyQf3567zJ
6SdE7aJfpxpMo44usFyM1OunhqY5xAA=
=BvYi
-----END PGP SIGNATURE-----

--DY9ZdYFoeEEBb+qI--
