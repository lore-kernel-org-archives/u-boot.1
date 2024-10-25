Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F43D149D9
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 17:54:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 654F588F71;
	Fri, 25 Oct 2024 19:54:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WPUYJXhQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7F5B88D13; Fri, 25 Oct 2024 19:54:24 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3108088F71
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 19:54:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cbce9e4598so13847316d6.2
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 10:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729878853; x=1730483653; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Tq/250fmYDP9FB3T9AX0PVQ4LoePqPQXoZgYjWEEZAE=;
 b=WPUYJXhQ4/5eH0rgxdQ9mOyKe5B3DRlmAsKuYDT4z+WUMRrmrcOUU4GkxcfaExuZCK
 9y3Vql3UeBaar7wEkrhRs7/igbehPs4N6ArWjvVtKqmurbCrzvFOK9rBGVQhnbQiHh1X
 5p0fWELenRzVLkUmL0fqGhCQTwNZyu4Yb0/QI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729878853; x=1730483653;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tq/250fmYDP9FB3T9AX0PVQ4LoePqPQXoZgYjWEEZAE=;
 b=k36/Km4PDXp4f6LmN98mP1E7zEWV5tmgf72zTIcmoDPSykCx/YtqQbe5YZCIjyglsv
 Ttir17ggSHgzh5qX9gFSRhsOqrBpbfjYVUOpcxiIq9oO0l07x+/Wl4ksc1xQ2SI3YNY7
 yOAHwXnuZHRtUeMNEp/Aa8SuMbqoJ6H6Yti/yq8X4U8h2WO6khX/le5FfhNb3DgS7ebm
 uJ37VphXtdpiZmkETwm9FiAqHf+F2+bDlJskW8YbWCshbnh141xAlRvykTKS7KIWrokN
 mRQLDdlzaE9/uBN8lZzFFyup78u2vWyDXJ/XPdlkttWd1WR0bzBQWEZ+qNjTeRSlw+Ef
 7Bow==
X-Gm-Message-State: AOJu0YzHFyRbjgK0thwCnz2Ntem3qmR/Qs46ZONRnJQuJidhNk9KXOtg
 exTFFrnhaNZjLesnNwy6yYreOmm0nenbZnzE6IH40faGXtiPruTR+JpCmr7bx54=
X-Google-Smtp-Source: AGHT+IFs9ub8hmHtbeKjmda9xo2SDhhZEUoUf30UuF3maNOT01Bm5WKJPDHTJvVPCEVkbyA7o31zOg==
X-Received: by 2002:a05:6214:468d:b0:6cb:e3ea:f07e with SMTP id
 6a1803df08f44-6d1856fb7dbmr4080796d6.26.1729878853028; 
 Fri, 25 Oct 2024 10:54:13 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d179a5bc20sm7730706d6.143.2024.10.25.10.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 10:54:12 -0700 (PDT)
Date: Fri, 25 Oct 2024 11:54:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20241025
Message-ID: <20241025175409.GB4959@bill-the-cat>
References: <87frokva81.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PWOt4cMUXjeF7RPa"
Content-Disposition: inline
In-Reply-To: <87frokva81.fsf@baylibre.com>
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


--PWOt4cMUXjeF7RPa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 10:49:02AM +0200, Mattijs Korpershoek wrote:

> Hi Tom,
>=20
> Please find some new developments and fixes for master:
>=20
> Dfu:
> - Rely on device tree for spi speed/mode on spi flash
>=20
> Android image:
> - Fix booting on platforms having > 4GiB of memory
> - Decompress boot image to kernel_addr_r when compression is enabled
> - Honor CONFIG_SYS_LOAD_ADDR when mkbootimg uses default address
>=20
> Bcb:
> - Rework bcb command to use U_BOOT_LONGHELP
> - Move ab_select cmd to bcb cmd
> - Implement ab_dump command in bcb
> - bcb: Write '_<slot>' instead of '<slot>' to misc partition
>=20
> CI job:
> - https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/22962
>=20
> Thanks,
> Mattijs
>=20
> The following changes since commit 7af813341d5df064aeee764c31ffb50ffcdf4e=
b6:
>=20
>   Merge https://source.denx.de/u-boot/custodians/u-boot-watchdog (2024-10=
-23 08:33:56 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu=
-20241025
>=20
> for you to fetch changes up to 21e7fa0e3ac599737cd235bb5233765e8a1b8b0f:
>=20
>   image: android: handle ramdisk default address (2024-10-24 09:48:14 +02=
00)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--PWOt4cMUXjeF7RPa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcb2zUACgkQFHw5/5Y0
tyzQgQwAuVV6XndONrs/dxOTxAU1Rujcdf3WY2F7BX9iS/QrKpgg4IZVq1HWp9lh
MUZzJzqt/miys2jQuqYtUlEk38ySyFTT9wiPOhZ0Tvawuqs1hlgK6QDJGGM/M0TF
V/LNP43e9ScP3AZDLIE8yXZWeXqxvbErnydleZetEHPiY1tKI+vn69NEuqFvqHuJ
0/m/EkkTXh6zsJI4e+eQrhNQpf1irg2ZbrMilb6nFh6XYHVaawpHXA/zrk2hTn6S
r5T05LTVKWMDXHxB4fsOGdASvW1lxyiMMtFuMqahGvTUhNc+r5x4K9IWowh3vb+7
dP3OdVfnXrASfz5Ioc7CzzDzZ25LkjMv190yXc85sxR81pzypZK+br+uzINL1wyw
kSd+WUelBEFfO78Urugq1cYJTQUJAaxOip+6zzKhJWTMlOkE5S3nlYfNQQCSIqIL
uuzEPHKBm1xEyqCSptGDw0e59ehdu/nieamJysUcxSXTr5YTXmTfCezSrEQiNIwX
6o1K7nUD
=hUdU
-----END PGP SIGNATURE-----

--PWOt4cMUXjeF7RPa--
