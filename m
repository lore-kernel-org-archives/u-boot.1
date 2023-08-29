Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5564FC71153
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 14:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A426586524;
	Tue, 29 Aug 2023 16:09:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Iiz3hX6p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53A1686521; Tue, 29 Aug 2023 16:09:53 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F0A886524
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 16:09:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6bd045336c6so3298464a34.2
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 07:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693318188; x=1693922988;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Gzz/31Z8ZdzTCKVfpG4lD20c7wdC/5y10m6tjPt56OI=;
 b=Iiz3hX6pe5KDprk0dsEfKK3CUpygkUoRQToLj+ASGvhLLir2Xq2IJLn3jEvI32bD/r
 7XxOGmAUbo94RUAAzyrSx9pSs00s9LPSTmuwVhhS8d/bcYkrYZclvPH+D7S5hFUgwoDZ
 1e1GTtQ/Fllq6EvS4vu3TEDdzW1yoWMh7xCNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693318188; x=1693922988;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gzz/31Z8ZdzTCKVfpG4lD20c7wdC/5y10m6tjPt56OI=;
 b=XTgGUUjYZD5mgMMePgMTbZK1wfbYcdWn/RA6dkVyA4GfOrMwpUqTSy10+r8B0bNAVG
 rZticK7li1DRd0AXuMaQDg9MD5a02hkjmMz1JZZRz6kBPcPD6sjhSc0adWg/r8cNrPl/
 YzTxvH8TSf8fpafWASCEy86+yOOBNf4tEi0SjSktLe1dcCy5SR7ypwQTG+43sqMGDJQ0
 kTliOlYXEnWZtfuRIL2wxBj6tOO8chTNAiD8dtdeRIzlsQZhviyHXffuI08Q9voKWa+Z
 lrm17oAIcInk3A/Z/0GGRdywIBA9pk/nI+9dZ61oYRAOSrvA2gR+CkEVBPArrkvp0jA9
 Fl1A==
X-Gm-Message-State: AOJu0Yw4DbEqgjCQ/WfB4IjbTLHC54t2VIliHR5NwnNq/P7v7SM6gGSo
 +ZuZd09K9veOTX2wYVpCBOslJsJOh0g76UcBge+r4g==
X-Google-Smtp-Source: AGHT+IFVdabZEB/LDUNAIsDO8ME7eUyBO31L7EeWk1yqwAMCkiJrqLsxibdK0holYf40eoOvgHhXig==
X-Received: by 2002:a05:6358:7208:b0:12b:df63:9d64 with SMTP id
 h8-20020a056358720800b0012bdf639d64mr35134691rwa.19.1693318187454; 
 Tue, 29 Aug 2023 07:09:47 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4165-1a0d-2d73-76fa.res6.spectrum.com.
 [2603:6081:7b00:6400:4165:1a0d:2d73:76fa])
 by smtp.gmail.com with ESMTPSA id
 v124-20020a252f82000000b00d7465a90f0csm2205117ybv.22.2023.08.29.07.09.46
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 07:09:47 -0700 (PDT)
Date: Tue, 29 Aug 2023 10:09:45 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH 1/4] Azure: Set the timeout for jobs to the maximum
Message-ID: <20230829140945.GA3953269@bill-the-cat>
References: <20230820173129.781985-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="52b5HiE2eFCxRuTs"
Content-Disposition: inline
In-Reply-To: <20230820173129.781985-1-trini@konsulko.com>
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


--52b5HiE2eFCxRuTs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 20, 2023 at 01:31:26PM -0400, Tom Rini wrote:

> As per current Azure Pipelines documentation we qualify for 3600 minutes
> per job, if specified, as the timeout. The default unspecified timeout
> is 60 minutes. Rework things to specify 0 as the timeout (and so maximum
> allowed) so that we don't have failures due to running slightly past 60
> minutes total.
>=20
> Link: https://learn.microsoft.com/en-us/azure/devops/pipelines/process/ph=
ases?view=3Dazure-devops&tabs=3Dyaml#timeouts
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--52b5HiE2eFCxRuTs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTt/CkACgkQFHw5/5Y0
tyxQPgv9ENnLhyn+otZSnQry2UHTfXv9yYvxIM09z1OY/bVzBEgrwG4o+FrLffxh
Pb6NPqrwFp81smYLxXph/4IglSjJGfN7VJ8H0fqkWbJncQkXlohMCHXl6wy4MA+l
TSPe+a6gUW5rTcXPLdS9YpaWErtfGrpi8iFo0VnkDPYD+MJzzLreVpre6TWHOVNo
lW7kdQ1LJbOcITBu38oCt1r3S3GOBLKNf7USQ7k8BklaOTzet0xxwKoo1UiCo+5O
sk0OUDrtCLZtfSbPhKx3L/1nHbLAFdDKOijDENQR5OpKgxy7fmoa7X/sLsFiiluE
f9SQ74CR0mE1rumlugBPBJxZSYlFNWaKmDBumY3DPGwIYG4O5kVcMDWthTRPB+KP
rMyJJNbw/8BiIoxAX8gYqr/A/FDkR+Ng0IHQ7YJU6G/bGGdbHwdxDIIsAjyRWoCw
ESmA0SdE/5PZkoK420hN1N3eXAL7atcdS6plfdDdCrJ7y/Q8Zjf/J5b+Bl/W0o2W
z+f1gzEg
=HhhT
-----END PGP SIGNATURE-----

--52b5HiE2eFCxRuTs--
