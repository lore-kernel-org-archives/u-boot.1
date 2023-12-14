Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37206C4167B
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 14:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99A2887A80;
	Thu, 14 Dec 2023 15:38:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZbCgWHCd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B57E387A80; Thu, 14 Dec 2023 15:38:14 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 396688787A
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 15:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-dbcd1e7adf3so1798768276.2
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 06:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702564691; x=1703169491; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wn96K3xPDU1VRJ79rMcIG2W1PgCkF2KzcR6qvZhSxQA=;
 b=ZbCgWHCdlGab0MRIIx13CcnwZW0HtC7Mbh8B/VQzo7+1Pgc1PE+6tEnF8+4YpFGWHf
 hCOovweKVvPTVxkwfZUopdyFOegkL7kODacYO56k5RyKTHIRSrutcaRc1fVxswMMP63F
 JfTSorDBE9Kpe6iRImc3SGm1JUNUSL6xJI8IY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702564691; x=1703169491;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wn96K3xPDU1VRJ79rMcIG2W1PgCkF2KzcR6qvZhSxQA=;
 b=hZ9Xt8PzsaZfzCZ4rpU8yUvyLVpWQzg63f6dQS47iYxQ6pmpiDMn5Qzv+kERqGuhz3
 n/czs9BNDrOI83neSCUKe0JhwEg/zAsI981svR6XDzpqUjQNbJ3eQnT1eheAMMf7PA5x
 iyYW6tZTpDr992JyOQEzKY2iyj+nsuBPdDDPv1izTozhOw6XPjreTsfvEugQFi8QxS8A
 C/Rc1mNwNJBwWt3WggzAKze/iaCO/U/+7I07xAAuekcnWLN5qLf4s+jCiYOULO398ufi
 YAag9iz3LgfP8uxnMcFSrAaDxw/p1l1Ji8pjN4Kmyhh7c9edutSbkAbG/JqMSVueSOyj
 1plw==
X-Gm-Message-State: AOJu0YyKwvCvpSulrdGops5kYZg8ClpOHwcNU2eng6TTG0f5uroVpda7
 TEcMIKb4xYmHvkNj1atwSLsXMg==
X-Google-Smtp-Source: AGHT+IFDoEX0RN8mIQF53X1nb/T/J1DPXWBeowQ0OuZlIZOS+XlSy3Pjy44+CcHyNCaBU7YM8hR5Jg==
X-Received: by 2002:a25:8a09:0:b0:da0:647d:aaaf with SMTP id
 g9-20020a258a09000000b00da0647daaafmr6063462ybl.65.1702564690923; 
 Thu, 14 Dec 2023 06:38:10 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a5b0a46000000b00d9cc606c78csm4723508ybq.41.2023.12.14.06.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 06:38:10 -0800 (PST)
Date: Thu, 14 Dec 2023 09:38:08 -0500
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, u-boot@lists.denx.de
Subject: Re: Pull request: Please pull u-boot-imx-next-20231214
Message-ID: <20231214143808.GA2513409@bill-the-cat>
References: <20231214110219.14460-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2T0iXXUtsD09QCYb"
Content-Disposition: inline
In-Reply-To: <20231214110219.14460-1-festevam@gmail.com>
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


--2T0iXXUtsD09QCYb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 08:02:19AM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull this u-boot-imx material targetted for 'next', thanks.
>=20
> The following changes since commit be4a5f7c35685d228b3abc398a8d86c434274d=
e5:
>=20
>   test: bdinfo: Handle systems without getopt (2023-12-10 10:08:30 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-next-20231214
>=20
> for you to fetch changes up to 6b73200aedb1d3fb0a52e2600bd6b1e3ff5e5faf:
>=20
>   arm64: imx8mp: Enable TCP, IPv6, wget on Data Modul i.MX8M eDM SBC (202=
3-12-14 06:24:27 -0300)
>=20
> u-boot-imx-next-20231214

Applied to u-boot/next, thanks!

--=20
Tom

--2T0iXXUtsD09QCYb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV7E0UACgkQFHw5/5Y0
tyyG5QwAjmmDVy95kxXnkhR1g5uG9mW2WSOgKh4k3Y71HiiKsgQ4yWUzzylCejR6
9IJ2btNFwj8yfRHI9WAj1LYNbyfkbISHOiMjNsRSQcbsdHjazMWh97QlKaQAptEe
rFnD3D6t4ry3C+0UHtAP/4R/gbK55S6pcb4AtJTDJpwKD/4FCDLtNHvo0H7jozYT
8HldBwKlASDAJGh8ReGlnvpfxThCd4MtHnuzP72omHFJMfluOJRyxQob97t+nZnX
tAKqzhf5/CsEjmYmh9+G53npZsh3TT13IRNFATph7tCi23PBLINIGAur0jBCV5vl
wAGbbeZpN3hhrK1j1X5B6X09wds0ukk7rJPM6URdmeo5T1Pqe2VxTWudaBhw9O70
CsCgOzlP7z/Ri+c9ZKYNUJd0icfy0D/Uyi+BAE3+S51sqd0a9YthbRkL2ost1WFb
TKF3Z7jtveMO381NUTtq+4F2BVIcd7974H3Wzu6GunVk2uqgwvZIYK3ny3IBkXkV
CaxzZK8J
=ClT6
-----END PGP SIGNATURE-----

--2T0iXXUtsD09QCYb--
