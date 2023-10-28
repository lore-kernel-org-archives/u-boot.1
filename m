Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C931DC27C47
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 00:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4640E86C68;
	Sat, 28 Oct 2023 02:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rNDUn9bO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07EDE86C68; Sat, 28 Oct 2023 02:51:10 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AED9886E5A
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 02:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-41cc75c55f0so30445591cf.1
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 17:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698454265; x=1699059065; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uyOkpE11BshJcB58i/TM1hu55u4zFnEP/GangTWGoKI=;
 b=rNDUn9bOGrGyg/ITUGEcM9oleir7RFEcR/1xo/AbT+NEbnzeF+rc14/Ajt2DmiWtY3
 Fxxwf2VFGIwBNUV8hhwgBMZuo+TxPwZvHuuaW5EXsZuG3JmAQNjWcYRqS4WV33OavU1i
 lyamNj9lmm/fxizuLtlNzEoLreuC+blU03SN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698454265; x=1699059065;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uyOkpE11BshJcB58i/TM1hu55u4zFnEP/GangTWGoKI=;
 b=kkLTC7EqvFsNS8Z/+FqUsankBKD7XvcslPE9iJY7leLAayMxZv7elZmF6S3TnBY5cj
 XDT/vz29NhC5JNYvbf9LHA3crbbbVJLFI1txJZocIPAeewRSmDz+Ic0p3Iwo3qThkpK/
 rQaeXNU7Z/SNYMoIVHht9LEsPJ34S4B1coSc3O4dyIORN7wkkaiDCnAAFWSVQ+FxV+zI
 HKJwxe7QzwiVCsqxIQmvF4unQlFb+ki/9PMctUK/LyDGMRxIcAHFcoPIj0aFRjcQuaBX
 v/NS1vxQ/Qu1hg132RVtifdQ7BV8TAYhGYuvtZIH3NIYK+MqCtsM3YTYE7b80mih1HN4
 ra1Q==
X-Gm-Message-State: AOJu0YwxApTEzPiOzhlOPPUxKwSmOddcyuwxiH/U00vH/YNWUwmNspg2
 3ADbI7j8suoPDk/F7VreVDBS4Q==
X-Google-Smtp-Source: AGHT+IGZ4DZA9Jt9vQeBWD7Os8bLc3HH0S8d59SkM7QpeMBszFxLkcNLlX6lC2/vAphrrsP0yTNQjQ==
X-Received: by 2002:a05:622a:118c:b0:410:92ca:3dcd with SMTP id
 m12-20020a05622a118c00b0041092ca3dcdmr10055903qtk.9.1698454265357; 
 Fri, 27 Oct 2023 17:51:05 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6f2b-3a78-9e8e-d344.res6.spectrum.com.
 [2603:6081:7b00:6400:6f2b:3a78:9e8e:d344])
 by smtp.gmail.com with ESMTPSA id
 f10-20020ac8498a000000b0041b3deef647sm1102836qtq.8.2023.10.27.17.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 17:51:04 -0700 (PDT)
Date: Fri, 27 Oct 2023 20:51:02 -0400
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, xypron.glpk@gmx.de
Cc: u-boot@lists.denx.de, sjg@chromium.org
Subject: Re: Pull request for tpm-next-27102023
Message-ID: <20231028005102.GF496310@bill-the-cat>
References: <20231027112616.112555-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mRVasj6tMq7raKkn"
Content-Disposition: inline
In-Reply-To: <20231027112616.112555-1-ilias.apalodimas@linaro.org>
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


--mRVasj6tMq7raKkn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 02:26:16PM +0300, Ilias Apalodimas wrote:
> Hi Tom,

> The following changes since commit e29b932aa07fa0226d325b35d96cd4eea03701=
29:
>=20
>   Merge branch '2023-09-30-Kconfig-updates' into next (2023-10-01 11:54:3=
1 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-tpm/ tags/tpm-next-2710=
2023
>=20
> for you to fetch changes up to 4fd7d27ccb763ce8b836a0e4c5dd005392d38e18:
>=20
>   test/py: always use autostart on tpm2 selftests (2023-10-27 13:17:21 +0=
300)
>=20
> The pipeline https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipeli=
nes/18327
> showed had no red lights.

Heinrich, I see that the docs job passed.  But I see:
+++ b/doc/usage/measured_boot.rst
@@ -0,0 +1,31 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Measured Boot
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

And was expecting htmldocs to complain and fail. It does neither (and
did neither locally which I believe is a regression in the doc building
side of things.

> Heinrich I did not ignore your reports and I agree with both of your
> observations.  The doc needs to mention EFI and the DT Kconfig options
> can be squashed in the future.  However this is a big patchset with
> a time consuming test procedure.  The changes you requested are
> trivial and we can send them later.  I hope that's fine.
>=20
> Simon there's one patch you haven't acked/reviewed yet, but I've
> responded to your concerns in the ML.
> The response is here
> https://lore.kernel.org/u-boot/CAC_iWjJL_taKWWEi4kancnQ6Dsg1V5+4hMSvTifcd=
r_aCH-Ykg@mail.gmail.com/
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--mRVasj6tMq7raKkn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU8WvYACgkQFHw5/5Y0
tyxPzwv8DZYmCrDphmMW/MVkirsU3aibQsam/aCsz8yzQBZ/FNyatbStZsr7p/eu
W+4qx6Oxfx65ryF+X6JYaXm9TJL9HUahZ96PWKeDJQRZsjQKJAl/neu9xF05Prac
IT3YfqqI/NKARKqldXoW2ffkQlK7xAHA45bQlDeKPOmjoqpqUUacN+Cu/xE3TXvE
I3LPd4V0SE9iqZSSYpIUXCclN8VPqC175CtzD+GF1577o8Ko9lZxJCREXtKp+qvm
fwnja1/r+4PpYIeISOYo2T4ybaDY4eGKCPCFkRBqXbfC2HdZRbhhyPWGGNoYDgir
Y0pEkw4WX0a4Lz1r2AMMYbDXa23SM4p5Opj7CddaRk7Cm9q8OAFWNJyHFAJ0rw7e
Lk1bdvQjTR89cqTvYE+UXL/hTgBXQqw7zBNj6ydWkZoIWS3S4OxOdEW1zBNh5t8S
RlsIjVkF+n9lawtM6mV8WMsycxl0m8DVmET7vyNA8q2URuJmjAEpeVvFG5ZaS4PA
BorSHQvJ
=35Ix
-----END PGP SIGNATURE-----

--mRVasj6tMq7raKkn--
