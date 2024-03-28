Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FCEC54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 15:08:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A96188127;
	Thu, 28 Mar 2024 16:08:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OKm1G4so";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14BE088150; Thu, 28 Mar 2024 16:08:31 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA68C88010
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 16:08:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-430bf84977dso5780231cf.1
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 08:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711638507; x=1712243307; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ktp4U8VX1Mga9ZYn2vo0PBP7orb9/XPIxw4hFBUDpX4=;
 b=OKm1G4soxY2mBrP6coVnQsfud/gtDpJoJ7XzBv/aIuH+Q6GFtesC2sWonLD/16rdSY
 uJaKGEDCJ48AiGIWrSGln3EggPIKqX9UDiYe5NEB2VgpP+CxJC8Uv5qMDjkbKXq/Lswa
 CMcfOBoe3efu0YfNWCTQbTReT1BPrHmsnuGog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711638507; x=1712243307;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ktp4U8VX1Mga9ZYn2vo0PBP7orb9/XPIxw4hFBUDpX4=;
 b=Ia4roDtiYicrLDM06yxBlJa88RU3aCD+3pcZBu7R/Lom2rmGCMefIo2zS3qOLEo9T1
 Off4fSu2Rchx34bc7BN82QlaVciJ7cITGe0GDGtBr6LGMMzpjkvZi1iBIOpmxcRA/oPc
 627mbdqLtMoUNgLbtCqHlBH5gwdxMPk/SItj1kn3QQTZRSeVxw3qvpfikk5TGR5VFQSt
 F2JIeZS4Iu2ecPM7XtmIyBeVt8eNIvA+fR3YUPS5gxBgHXNQNrfe6JgZc19N2di6i4nv
 7LEPF27iAbJdfitC+DVIHMLXRkLxRS1ZeIeNv4wRRuOkO3WC/AtgOZaEICdLeRwoTy9L
 U7Gg==
X-Gm-Message-State: AOJu0YxG5zyJ238IxF2RqwTc4IUhc/ioAX5wXiqcf/KB2ONlJDznviPX
 Jfq3jjhfj2Lr/ibLEbE6fDU2Lg59ACzFKG7gywYE9dolzmyYbFm8LlVbaPXkbUg=
X-Google-Smtp-Source: AGHT+IECsTLFG0Q4mB++wPm51EVXO+WHhDuQ1lo3IaEqc9x9xYzMbmMKebYkHg0t6mhy7c3SkzJVMA==
X-Received: by 2002:ac8:7c49:0:b0:432:b568:4218 with SMTP id
 o9-20020ac87c49000000b00432b5684218mr1877721qtv.7.1711638507336; 
 Thu, 28 Mar 2024 08:08:27 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 en4-20020a05622a540400b00430a67b3437sm698545qtb.17.2024.03.28.08.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 08:08:26 -0700 (PDT)
Date: Thu, 28 Mar 2024 11:08:25 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [NEXT] Pull request acpi-next-20240328
Message-ID: <20240328150825.GP3442575@bill-the-cat>
References: <e2c1b7e5-ee38-4427-ab03-48a68d41b044@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TQLn+Z1qF9tNVDbB"
Content-Disposition: inline
In-Reply-To: <e2c1b7e5-ee38-4427-ab03-48a68d41b044@canonical.com>
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


--TQLn+Z1qF9tNVDbB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 11:16:56AM +0100, Heinrich Schuchardt wrote:
> Dear Tom,

>=20
> The following changes since commit ab8d9ca3044acf51d8ff3bf3c4718c48f30ad6=
06:
>=20
>   Merge tag 'v2024.04-rc5' into next (2024-03-25 22:15:47 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/acpi-next-20240328
>=20
> for you to fetch changes up to 6eca28b61af1835e70a6feb86f86a0b18b1708c6:
>=20
>   smbios: fill wake-up type (2024-03-27 09:23:30 +0100)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/20081
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--TQLn+Z1qF9tNVDbB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYFh+UACgkQFHw5/5Y0
tyxc9Av+IpO80mWy5CvGdRjyhhvcy6kMNWloEHDJDWjdtUoTzB53nUQpRMa3BT0/
KSlktbbQkven0MEvvtPGGpskrXx7SJw1OHtXBsE0BwGZ5FO/Ue//pdbSbPCd7Z+n
lls3FsGozHCG8Hca+KRP2QQ6D0AO1SloOwDrl2jAqfScH+twrxbkcqYQyJUVb5vX
KnoVq4kM0VR/31QcUc/F1SYq51JJ/rNjEFiydyTWhB790bco5/L6PeSFZf8joD9w
K+jjmOwwhwq7J+eFRa3yDUijcXIfttH6lBa+a8yurDufB0l6SMwQ6f4iWeWCqXmC
ruStzKCp5QC1MTT3CJPCIDC5HZ3mQsusXPg/yaWXo5xCvYFxZb68UQgQ7dSwTQQr
ZM3DtVXeOa+l+vmv0m/EBWz0wkiEpDDUa7s3PtF2OHUY8mNlh8iFXuHV0Fkqi6NO
a9JZOtz9lK4Hko1ddRNKSgZpAf4Ae3bNLIzp/oYC7mBcpAuOs4gIxL8DQ7VWdJ1L
brNNaf77
=jao3
-----END PGP SIGNATURE-----

--TQLn+Z1qF9tNVDbB--
