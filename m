Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F970C04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 16:14:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2208F8829B;
	Tue, 14 May 2024 18:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E7spaG0C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95FFE882DF; Tue, 14 May 2024 18:14:55 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7924187CF8
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 18:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-69cb4a046dfso23405686d6.2
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 09:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715703292; x=1716308092; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hF5c5B5Yfs7H+xEXH3Dd22vlledahiVsFzUB+1zkf0U=;
 b=E7spaG0CwGT6LZ5qE0JnEqkckrLKxIiUqJEkXa7HAjh20042ZJY3Z4scx+HiveW9kL
 b+jOR4J3X9ttnvctrFezw5WvThrPTk5Zi4tnrfcCEoZOM4tdouj2C3ZsDPYfvlbgKetF
 LD7JCmPnqL7I4inJKAgiUqR10CJBCEXptKlZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715703292; x=1716308092;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hF5c5B5Yfs7H+xEXH3Dd22vlledahiVsFzUB+1zkf0U=;
 b=gCdrGVmNvbe7yg9W0lPrAZgo+Oe+C9Phy2SIo3Alh6VnsHLFagoXwQ29p+GkZ7PohS
 UYkUfAkrdKdp2Dyz7/Yybwg8FtjWwGmsa4xw/eEWDFqt3CJRRvZCsdSxTMnieblCN/bs
 s509MdnrBVelD0A9vY/AtvtWpQG89P+OUuHR3ZxccSDXB54EylBtsOhCwkLAc3UlqDhF
 ag/krB/+41A+WTAZqfFAycVJ0dy+TS5bSyAA1Q3JxMj3Rl+cXScz0sKvHBCfPm4FiGzw
 0DmqpE5xHvgr27Yi0fP90PbYh7Y5qlgU3hCM7Tf3b4SyCDpguwKmQMBL4/RjZPsh3FGF
 S/jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcSOGTexwGUNR8+pkIwSf2zR+74jXF0kSZKCkz+rpljF9DVhdCxX6N7bg4PGJBVPDSBi8eaNq12DJHe/6C6L+q4UiMiQ==
X-Gm-Message-State: AOJu0YzxVIkKCPOBpaYbSqqA3a1EgBMef0MSfI9TkPwjMQurLkXWOr4k
 6Ig9wQbHFh0HVzmIkQOtZV6FdgAlmFr/1o83OxLL5gHAbJxp+m+mpfmLPZX2SOU=
X-Google-Smtp-Source: AGHT+IF0RM+9stHNZW0a2Ver9rz4ydEN3cGl8tlVyKMZ++ElToT7y4PJwmKE3JnZ9uqA7UwxT4CGDA==
X-Received: by 2002:ad4:53a8:0:b0:6a0:cad1:9ba0 with SMTP id
 6a1803df08f44-6a168251fe4mr104468766d6.64.1715703292200; 
 Tue, 14 May 2024 09:14:52 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1d73c8sm54698466d6.118.2024.05.14.09.14.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 09:14:51 -0700 (PDT)
Date: Tue, 14 May 2024 10:14:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Sam Day <me@samcday.com>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PULL] Please pull qcom/qcom-main
Message-ID: <20240514161448.GI2568172@bill-the-cat>
References: <20240514070339.3372871-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hJzkjgvQQgKlV8bC"
Content-Disposition: inline
In-Reply-To: <20240514070339.3372871-1-caleb.connolly@linaro.org>
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


--hJzkjgvQQgKlV8bC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 09:01:24AM +0200, Caleb Connolly wrote:

> Hi Tom,
>=20
> This patch for master fixes framebuffer video on almost all Qualcomm plat=
forms
> where the framebuffer is initialised by the first stage bootloader.
>=20
> The following changes since commit 5c5565cfec92eb7377ff7fe197612c6a813bb6=
c7:
>=20
>   Merge patch series "arm: davinci: Migrate da850-evm to OF_UPSTREAM" (20=
24-05-07 11:59:26 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-snapdragon.git qcom-main
>=20
> for you to fetch changes up to 3ceaa825869bd43e9a2ec00a90589cc84885bd40:
>=20
>   mach-snapdragon: do carveouts for qcs404 only (2024-05-14 09:00:41 +020=
0)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--hJzkjgvQQgKlV8bC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZDjfIACgkQFHw5/5Y0
tyzImwwAn/4aOmjN4EYp6rMpVUwmhVxTywidVXK/JubXzCMTNUY0HiVRVrUOxquY
82Ald7jWmdBiYAm0rsuUCFhHWoUDCRNyqGNBjGjWJacQzuRk4sE7O4pLdcZ3qcuc
2ioGG7LRKTl4GGFGUuPRuVHRTtus6LQsIA9mZuZCAqQovWGkWSr0CJVcVk9kdhoj
HBOSkxltUNllXKXsQcxTrYEIzHIhYOU4OgmCdGCyf4ALdBkk/XQs63OHo9J1dhRe
KFUggBUunCZK915KWWptGVKbk0HKeTRdlVEJrdj5hwtVi3UTT++Ez4292ELPLbIw
KCn1aN2xZD3IOd0h5dE8js06Jtadvu9fZXRfWCCipWqwfY4NcwkHvX1yXQ3AL8yV
s36RcF/JuXVJKC2tN8qbB+iZyGDZDxRNVnNE6984Y4mhQ5xn5X4+uv4Qc790wq3y
b6Rul9WkLKEiiY9hlP0eM0hKOyN/CGPwL+2m0x3Pd/EHnZ8Yo5CEX4OwApT8MEuV
rTJnI87A
=NzVe
-----END PGP SIGNATURE-----

--hJzkjgvQQgKlV8bC--
