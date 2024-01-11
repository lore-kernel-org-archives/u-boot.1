Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8194DC4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 23:39:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E59387937;
	Fri, 12 Jan 2024 00:39:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pvXcAZHY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 199BA878BA; Fri, 12 Jan 2024 00:39:12 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9BC0878BA
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 00:39:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-680adbf077dso39693536d6.1
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 15:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705016340; x=1705621140; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=78nKq6cT0pC/H6G+h9cl53j10sqp0yduMjGEKcFk0YY=;
 b=pvXcAZHYpxISnlmfaGXJUFsd3zkgOvzgXqKjkLFi4IdcCDT+juCxkRg/V1djLKyLPB
 6Z1GCwUfdQGT9N7bSLtph2vIbX+rF8x2GY4UMcDOYHc0U21ciCOD+b/FqMRSHc3GjpLy
 /Dnw9UqexnAv2Ij3+DMG52uGeWIbYGNiSgI+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705016340; x=1705621140;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=78nKq6cT0pC/H6G+h9cl53j10sqp0yduMjGEKcFk0YY=;
 b=h/kl1b9AcAGucjVkXZOqfGU9ERsYLMB+rcUZBYQk0Bc1nvLpmo28QiK9bV2a7uJfoE
 wE+pBFfxaw56mnDndXvRYmjqCWwNjmmxs2DMg9T9VsO0J8FcsZDaJ7Vz3qD5HxiBGk5z
 /+pT1Xhq/CkLTmqNIXtBmi6wq/FKCFdLpWNj+8GP+/vVSvL3Inu4ZMUSAkYWsujSIwoa
 HeuCWEM1jUtWhK0YXGECi5LAD5Jyv677VQOI71PfRfS53AcuV8I+Jx4KcUGmqusLsvu1
 b3N24XmWm1GxYYYdVGWQ9SJMxMiWxESXOWqE+4GYBwfmLYqOFukYKatkkAXnOFuNZtqX
 QoGg==
X-Gm-Message-State: AOJu0YxozCX9xA1hTMCdFGGGBn8dyFGg6PnqU/LM4QARUMrBvn7VThRR
 MX7ShfOFi1UlZEVCzZSSCjEJ1p0Gljm5jhEwhLeRlD65SKc=
X-Google-Smtp-Source: AGHT+IGeWE6RVKe/fGgci6S9u2h2IjV2ea9KA/YjaZ3htVy/+zpEpCja/WXWYl/TKr83PDog/rkErA==
X-Received: by 2002:a05:6214:2688:b0:680:d2eb:ae1c with SMTP id
 gm8-20020a056214268800b00680d2ebae1cmr31541qvb.42.1705016340172; 
 Thu, 11 Jan 2024 15:39:00 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 f7-20020a05621400c700b0067fa1179b57sm643916qvs.131.2024.01.11.15.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 15:38:59 -0800 (PST)
Date: Thu, 11 Jan 2024 18:38:57 -0500
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20240111
Message-ID: <20240111233857.GL1610741@bill-the-cat>
References: <875y006vwo.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zO7d09+8tll2TQD6"
Content-Disposition: inline
In-Reply-To: <875y006vwo.fsf@baylibre.com>
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


--zO7d09+8tll2TQD6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 10:50:47AM +0100, Mattijs Korpershoek wrote:

> Hi Tom,
>=20
> Here are some developments for master including:
>=20
> - Implement fastboot multi-response. This allows multi-line response and
>   most importantly, finally adds support for fastboot getvar all command.
>=20
> - New 'fastboot oem console' command. Useful for debugging to send data
>   the u-boot shell via fastboot
>=20
> - Console recording fixes
>=20
> The CI job is at https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pi=
pelines/19279
>=20
> Thanks,
> Mattijs
>=20
> The following changes since commit c5e461fbf7cc72f0c1c8a79226b6a5170e56cb=
4d:
>=20
>   Merge tag 'u-boot-imx-master-20240108' of https://gitlab.denx.de/u-boot=
/custodians/u-boot-imx (2024-01-08 13:39:43 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu=
-20240111
>=20
> for you to fetch changes up to 6c2f753f4ad3dcee60190949d1286736a6d51d17:
>=20
>   test: hush: dollar: fix bugous behavior (2024-01-09 15:31:59 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--zO7d09+8tll2TQD6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWgfA4ACgkQFHw5/5Y0
tyzcBQwAgnuhyf0gNqxGX9at2RpTkGy+afFsCwHaiClIDK5+y5+NClZYGNVPOmC3
DVkQLvs2Ok6849aL63PApOfNGdwLJNa7UYZn2JDZyrVaHZYsW16zs+8XFhlJ32IH
USqYDKJ/27Qhct/9Kz9x5Us+3Hw3CWzO4THfYoH8MnHeIdWQMvBqP2/l4gyueYie
R0Vlthhg50MMIE5HLQlUaaly/Hb9i6LvORWUSqcEzUYu4AhddM1M927iPP9PMX2C
KYFkpwUUwngMbk5G9ONdKp2Cnv+d+ycQwB9tntyZrBKHud9wTdeltYpqra1liBGR
0D5sFmGn0edDifomLIjbCa9yvox01c+c+CDftImXSUUycYl1E3WXdHwqE3HIJOJI
XDbdhvITCH4r83wqxF51HTpfVuc7Jwf9fKzmgjdFughz5pt5/dur9RMtIB2qhqQO
no40OuEFTty3PZajkKUxMYF6F50jpBcxnkCWRX3mWFq6OoJlNQN833LOJgngQKUj
SLamw2+/
=d5Ki
-----END PGP SIGNATURE-----

--zO7d09+8tll2TQD6--
