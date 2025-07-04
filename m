Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F65C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 21:01:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 923B382A76;
	Fri,  4 Jul 2025 23:01:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S/fbX7mE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 292B182AF6; Fri,  4 Jul 2025 23:01:23 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48EC682063
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 23:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-40ab5bd9088so826985b6e.0
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 14:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751662879; x=1752267679; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+j5O9qfF6VKj9NZioYaE7thwK3klOvQW4IfxYZkTLAE=;
 b=S/fbX7mE2M1sh2xRMP3K9J2lsSSpv1UjAKqUWNtjgnphmQNd+1gWdmvlQDeH3lznaB
 oqNm/SbtFNRqlyXgJ8Vk4S+7Z4mkmXmIjSK2ZDyHMAM81vF7gSPAsaT/80ItBUZ9AkAr
 PadkP+oKlkiv5g5sp+EKkzmsMGq399BAoGxzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751662879; x=1752267679;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+j5O9qfF6VKj9NZioYaE7thwK3klOvQW4IfxYZkTLAE=;
 b=SynXOlsLTxtvD8hJuYdSHA6c+vILuvHb6dOGxEU9u0PXUkOD7OWJoAnxskxMoDyVSQ
 Gx3ECP98guywD/7cpjWo6lRHCMbIw7tTajtOZukYznGDiiMeXwQ9pzhGGCx/v17rZVRK
 9gfltQ8m8yarTA6syHqJFFyaEH7QDqe/j9BshRt679PNnoBO2cjQQTOQDLXaRpaKKG4c
 JWN1xxEFCmyuYqEf1ygbMFXYyZ7FRCLUp/4TyX6XP3EfohO3zVBvGHWI4HFvExLsjU5+
 i8p94WaKgU2f8yYiAlDO34LwUUGc0T8Edy83o5CLr0eqHda0Ei4ayrs4w469pnt+TSCV
 P1sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIWWguF97KX2qCqjlPg0dfN3RLVf/T4Q8y//5OPZ/tCOdVl9q0h6LZSQH6QYtl96NgS3nF5AA=@lists.denx.de
X-Gm-Message-State: AOJu0YyGDXY2cl4ZDCRLRPbLSJYi4JAp60KI+peJ6yw7QxNICQUrL6gA
 k6sGZiBBRHqBROKu3vzm4BNCCYj0dmuUc2+7TjOZpmfL6cGPmqwP6KxDLaGqtSr7f65kwsPzsLb
 ZpGV8Iq4=
X-Gm-Gg: ASbGncua8Y5GbWjSqrzzbyYEFVTgBke7X7PEj9c2gspVpRi0QKd32wVb+didqh9Q2TB
 oJgIo1aQ02bX3SrCUytyw+Dj9EQWBHacn0v1OY/R6AJJQBqcUCdRPdXgafmtn6fdR/cXjpm+KEl
 eE5U73RYUdBqvue6EZI1ajsoJFzY6TFp50j4FD0qeKy4AT71d7BLPa2y4dGm0MBzFWtLWHH2e74
 +vcdue38FG7DcvScx9KGFoaJ70zFvZLcZkQfkqg97Bcjo3SmT0249g+hl/6sRlgxsSTYu2c6pxC
 7XfEqMgMeLV8lXTW/R+Rjx0hfe3CCKn5W2QuAvj+QdnMpRQpzbpXr0iLXhnPwjaCPIClPm8IV/j
 jBMXxdzu5xuDZpPmJkKew
X-Google-Smtp-Source: AGHT+IGhloXqVwHVONuWN1WUUMbqp3kF8OBljD/K4MPgFCI6MGphS5z+Zhfnr/XwotvCi5GM5JVS6A==
X-Received: by 2002:a05:6808:6ec6:b0:403:31f8:44c6 with SMTP id
 5614622812f47-40d2db01599mr90780b6e.26.1751662878993; 
 Fri, 04 Jul 2025 14:01:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40d02aec0b4sm409303b6e.46.2025.07.04.14.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 14:01:18 -0700 (PDT)
Date: Fri, 4 Jul 2025 15:01:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] ofnode: NULL check bootscr_flash_size before dereference
Message-ID: <20250704210116.GM6424@bill-the-cat>
References: <20250703-ofnode_fix-v1-1-c739233efb58@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7AXVErIazl53TPS0"
Content-Disposition: inline
In-Reply-To: <20250703-ofnode_fix-v1-1-c739233efb58@linaro.org>
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


--7AXVErIazl53TPS0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 03, 2025 at 05:05:31PM +0100, Andrew Goodbody wrote:

> Move the NULL check of bootscr_flash_size to before the first time it is
> dereferenced to avoid any possible segment violations.
>=20
> This issue found by Smatch.
>=20
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/core/ofnode.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> index 26e014d5c53..1c285a867b3 100644
> --- a/drivers/core/ofnode.c
> +++ b/drivers/core/ofnode.c
> @@ -1960,6 +1960,12 @@ int ofnode_read_bootscript_flash(u64 *bootscr_flas=
h_offset,
>  	int ret;
>  	ofnode uboot;
> =20
> +	if (!bootscr_flash_size) {
> +		dm_warn("bootscr-flash-size is zero. Ignoring properties!\n");
> +		*bootscr_flash_offset =3D 0;
> +		return -EINVAL;
> +	}
> +
>  	*bootscr_flash_offset =3D 0;
>  	*bootscr_flash_size =3D 0;

Is the compiler likely to optimize this to:
*bootscr_flash_offset =3D 0;
if (!bootscr_flash_size) {
  ...dm_warn(...)
  return -EINVAL;
}
*bootscr_flash_size =3D 0;

Otherwise we should re-organize it like that. And yes, the two patches
today for "fix platform ... because it grew too much" reminded me to be
picky like this.

--=20
Tom

--7AXVErIazl53TPS0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhoQRwACgkQFHw5/5Y0
tyyPzgwAqxPm6VCKyTU7a3mL59PaPXwaFTmWyheULp2wWN+bSBUP8K8un1Cb4IP8
VxP6lOfj9310/e85aqPKSZBLkUnChZtsw4t3fZh6hhG/y6awe0gGzTeozBTlBMAk
vO4WPXL0YX9QKtRjTT7i+ksWQJbv/KjvtQT5PuoxverJ8mRN4eZVUhfvmRnXD3su
L4RJ1LRun7yUSqiLojq1yg8H/igCDNszjVMQYUrwYRUvEkFGjgqp2HQvIXzrhACt
175cpd/QtTsbyRlcdHBsaybyfSFJRPLMII1UvZLaYIzaJUAjfn0KFruvbFAzq5Lx
O/KwhiOUSXwErT+Pzj8o970utpHowzwKKfhLlAZXeKfzdJ0InqikXoPvGuhqLBtF
zchz5+qmD7p5OidVdEdoatwznt7O8TsiREW8migGJVf780REfGZ+0s5rbF7Lv4L6
SWeg+XE9g8IbZ4aNG8NrQlc/RmZTyQtOIYgL4ZQCvFIDu0rF2Xqg3H+c/W4Wsg3i
O3UpSjRB
=24Tp
-----END PGP SIGNATURE-----

--7AXVErIazl53TPS0--
