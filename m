Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435E9D6C2AF
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 22:13:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C62BA89586;
	Tue, 19 Nov 2024 23:13:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SihYvlHi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81DF6895CC; Tue, 19 Nov 2024 23:12:59 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BAC188C98
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 23:12:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b147a2ff04so268804285a.3
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732054376; x=1732659176; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IVjlWjOiTSvJ3EEWLazOFGiqiFjFVXY89CzU9ROijr0=;
 b=SihYvlHi/EIkvJYNjtYrbV7tSKn8YLbLeZC+w/BOiM6yzKalcXMRIQMHHI41o2czwA
 UI6B3TxK+roqm5CaMWUguKAWq7dIw5/rfhlNrTKZVo2xELbf1YOisa/lBnCiGxjvtW8m
 bIX2T+1nHNygQJv8F+iDsM239mjlelcg4/nU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732054376; x=1732659176;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IVjlWjOiTSvJ3EEWLazOFGiqiFjFVXY89CzU9ROijr0=;
 b=B91I4r5DaLqkXTT/N21lWRu+C5WvaWABnAi+jtZaJK8Y5sCsuZKU4rToLnvEGgX/CC
 BrB1Xnr3dK780d2L9tQT5WWUKSoJX2YmSdPRHRcyy1PG08mirUz514W23G0p72DHRtcG
 YWGa8I0LKUWu24SAjT5f6w5MGLoOuQdvpFnb54sVXnFTKpJ3BMENlT3NgqSk88nSpqQ4
 LnYZC7GCPUXVC6hRlCWu1SYeKvufN05JWgQPNPEychQ+XQIEo+X1nX2R8lT0PT9qgwpX
 1fTf+uuP4hqSkOQLHHQ1hAh4fkwiS19E+UmG9xXvHlV+ujAyiaNEg528IF/htPYtsWL1
 Un6w==
X-Gm-Message-State: AOJu0Yw5fkAtc2FY/wsP5H+kXkQkNXiMrhb4pC+uuUcXqNvWc5poAGO5
 r56BGuoqcCk9qiaQCUxTjh4bigrHFl5n1kFNZPLHRY03ClM4TrFEp0eUjt4DcK05ooiTKhA0N/i
 fXHk=
X-Google-Smtp-Source: AGHT+IEbilifO0ZHxHoJgZca3pzwGNsuBToIYXR5Q5fxAomNhA5HmAU+8VjrS/ea4mxO9wL6GxVs/A==
X-Received: by 2002:a05:620a:28c6:b0:7b1:5143:8da1 with SMTP id
 af79cd13be357-7b42ee82dadmr75628285a.43.1732054375807; 
 Tue, 19 Nov 2024 14:12:55 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b479d2de77sm10252385a.14.2024.11.19.14.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 14:12:55 -0800 (PST)
Date: Tue, 19 Nov 2024 16:12:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [GIT PULL] xilinx patches for v2025.01-rc3
Message-ID: <20241119221252.GY3600562@bill-the-cat>
References: <cae706ea-b4b5-4b35-886e-58896564f777@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sCtZD5OTK7xVqQEw"
Content-Disposition: inline
In-Reply-To: <cae706ea-b4b5-4b35-886e-58896564f777@amd.com>
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


--sCtZD5OTK7xVqQEw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 07:38:05PM +0100, Michal Simek wrote:

> Hi Tom,
>=20
> please pull these patches to your tree. Crucial part is Sughosh series wh=
ich
> is fixing issue on SOM where current code is ignoring reserved location at
> the end of low DDR and u-boot is using for itself instead of ignoring it
> completely.
> In past this functionality depended on LMB which could be also possible to
> use in this case but it is cleaner to make dependent on new Kconfig
> XILINX_MINI symbol.
> RTC fixes for SOM also preventing RTC drift on Linux where emulated RTC is
> replaced by physical one and started as the part of boot sequence.
>=20
> The rest of the patches should be easy going and I will send another pull
> request for binman support to next.
>=20
> There is one pending issue which I am discussing with Sughosh related to
> commit eb052cbb896f ("lmb: add and reserve memory above ram_top") which m=
ay
> end up in another patch to fix logic around ram_top calculation in board
> file but better to apply current patch and fix it if we find a proper
> solution.
>=20
> Thanks,
> Michal
>=20
> The following changes since commit cca05617a8f585f3a98a8fa82f75cc68a530d7=
71:
>=20
>   Prepare v2025.01-rc2 (2024-11-11 10:07:36 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-microblaze.git
> tags/xilinx-for-v2025.01-rc3-v2
>=20
> for you to fetch changes up to 383fc2f50166fded0571d41baa7826eaaa5dba97:
>=20
>   xilinx: Introduce XILINX_MINI configuration (2024-11-19 15:57:56 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--sCtZD5OTK7xVqQEw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc9DV0ACgkQFHw5/5Y0
tyyMTwv+IDWLtOvxKTSuO/jkTZr3aMNNUVlRYHOVoS1iFJBSEy8o+XpFCRgRhrG/
icy3wHwtA4D7h2DxHZhynBY/R0FOAGpdaevo4HQ0rxXlSiU2D4SAes0YQZLfPosO
K1T6qeDo8Z0mAUeOebfJmza2ambO0oEW5gau9k23nTWxQzHnVL3eUvxWla9xH57R
OYhaRG93CjgMOyEzojAtbPLnmYTl7Z92a9eQV67I/WbvzkOdRy4B8ynuLzJS2MEO
aKtsidOCrWle5/E0FcSe2o4jiHN47airM1RacYsVW9GGTSVCK0pPf6cS2iKp/LOU
aU5gm9eOQE9Dzq56YtXLWqi42SMXY+7rBoy8orptWXUj6STbRSth7RkEK0jV4eLP
670OeFuGF3b01UUcVGqbhCurkFXmkJn4vNc/TyMAIoy7RZ5tXBEkG5AMMommXX9s
BUk5NZam7K8GAlZN/CqD5Jf0VeRQ/MhQQkEHDjTQCuUq3/yBEN6cHepLOg1xRNIm
/nuRaWOW
=0mm0
-----END PGP SIGNATURE-----

--sCtZD5OTK7xVqQEw--
