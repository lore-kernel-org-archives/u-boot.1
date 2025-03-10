Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52868C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 21:31:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC43080107;
	Mon, 10 Mar 2025 22:31:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pX9So3Ik";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44799807D9; Mon, 10 Mar 2025 22:31:25 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8716800C1
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 22:31:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-224171d6826so73500755ad.3
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 14:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741642281; x=1742247081; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ii2dbhH7/sViudRcR5tz1Qgv+kG8TF7mfGFPzyC2QzE=;
 b=pX9So3IkVULrqsO5EmAmE0F0Joz9lItgZnzhd8u1HFPsRTTDeBcNM/DLUR25O+BnTf
 aMODTuj71qFtoi5Pnc1+KiDYAz3Ws3VaAANOAj8xiI20ZH/7nr4XzNIhn7TeDa19wjbe
 5BBQOUwYqZc+pQsVschnpeCXwRp0rxjYakzf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741642281; x=1742247081;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ii2dbhH7/sViudRcR5tz1Qgv+kG8TF7mfGFPzyC2QzE=;
 b=rs2GeygMHOTGp3JSAugPi9ou3Wyg8A3YDQxF71SaCjFHU1m2ofsjVpi20x/mAtsAay
 OIQe8saDZBqiAgrQksj7nfEtrAG24Piil/UKaK0LgCUSMoIh3r/PlCDGgDKQf76DilyG
 Y+ITz3QigydEAyNPwmftq0caE+YOTfQk48STibh+9835P0VfFl4zCdnlvWbUY2PvWKHc
 lxZlarkJUWXuHvoklhYD507i5b3i5OR9SaYxLzVWCGymtpHi7RCWUiAJQCYVgB2gbhTH
 7lZRFm0hRPsHbqSNADKPKMfMSonqlx2jS5nEWd/dMZMSf/HdEgf/9mcNlxNSnRU0ZOOp
 Ob6Q==
X-Gm-Message-State: AOJu0YxroXyt/gfVcvr3RICf183Em8bsqPXnFjlNOXmN6+nLaSRXAlzt
 4SmtaxwcwgG6HC+one6P5O4m479cF5IplWMhJkFb2ptns21x7k8ZHAIE7vWBFxc=
X-Gm-Gg: ASbGncuQm8YBXfqWTvCu3h7FfWEXiH3z1E/4j/SJ5tGV3LBF9Y1n6OOPb+v1aMXQq5i
 93go27wrBPITJ98v0LDJod5mlmj/GCXZQSKfwSIsXdvlqrq8aBQwbeOaMsnsI5z2jr8SZo70vaJ
 fiwmN1iASdGKzQI8vJUz2ECiVhI9ZBOY5u/kC/MES84kPijWXrPINnpij2Ahb/zLqo6eOJ6FEl+
 d0Yjzdyz9q1QLsJF+W899QZTsn0itqAOxhZ5dAsnwubk+/E1GiYeQCuY1taZnVMKerGyMQHDJ6+
 rmqbDzSIQTQ62qewF78eD1KyAR6WsIYgHhdsCMHOUViLWw==
X-Google-Smtp-Source: AGHT+IGmcYz4BbNxb87ZnbI1wBvBHgj89AWKjuFYzDTbwww6HrTGQqRdT+AE0XWfc41lOYs3SwNENA==
X-Received: by 2002:a05:6a00:987:b0:736:46b4:bef2 with SMTP id
 d2e1a72fcca58-736aa9dbf8emr22721098b3a.6.1741642281387; 
 Mon, 10 Mar 2025 14:31:21 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736cc310f34sm3755473b3a.150.2025.03.10.14.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 14:31:20 -0700 (PDT)
Date: Mon, 10 Mar 2025 15:31:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 11/12] pytest: requirements.txt: Include setuptools
Message-ID: <20250310213117.GM2640854@bill-the-cat>
References: <20250308201533.1315951-1-marex@denx.de>
 <20250308201533.1315951-12-marex@denx.de>
 <20250310135557.GW2640854@bill-the-cat>
 <20442227-eb4d-49a3-8401-9031d818c91a@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q7RoRWDyX1fVkT+O"
Content-Disposition: inline
In-Reply-To: <20442227-eb4d-49a3-8401-9031d818c91a@denx.de>
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


--q7RoRWDyX1fVkT+O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 10:07:40PM +0100, Marek Vasut wrote:
> On 3/10/25 2:55 PM, Tom Rini wrote:
> > On Sat, Mar 08, 2025 at 09:12:15PM +0100, Marek Vasut wrote:
> >=20
> > > This seems to be needed for filesystem tests at least on
> > > ubuntu 22.04 machines. Add setuptools into requirements.txt .
> > >=20
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > ---
> > > Cc: Baruch Siach <baruch@tkos.co.il>
> > > Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > > Cc: Hiago De Franco <hiago.franco@toradex.com>
> > > Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > Cc: Nam Cao <namcao@linutronix.de>
> > > Cc: Simon Glass <sjg@chromium.org>
> > > Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > Cc: Tom Rini <trini@konsulko.com>
> > > Cc: u-boot@lists.denx.de
> > > ---
> > >   test/py/requirements.txt | 1 +
> > >   1 file changed, 1 insertion(+)
> >=20
> > This belongs in the requirements.txt for the tool that requires
> > setuptools, not pytest. It's also listed as a required host tool /
> > package in doc/builds/gcc.rst. Having just re-created the
> > requirements.txt file, I don't want to add things that will get dropped
> > again the next time.
>=20
> This seems to come from pylibfdt . I can drop this patch too.

Thanks.

--=20
Tom

--q7RoRWDyX1fVkT+O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfPWh4ACgkQFHw5/5Y0
tyyZoAv9EH4137nsgISBKajyKAHyJGuWdGx+595TO9Rr5Z3dFg3+zEVaY3Mie05B
j34fBOVvM+vX+v2YjEcG7XCZDEROXIMZ+fX0Hku/sVuXBZ0zXCgW/Xx9b/MTcAFV
ePq7fFfLzx6lGfT80QdEdHZcCzoJdOpEOiaM356+Mj4067v+KkTqvrBBqwHDwfPf
2qoa8CcPKcESmBACqvp2EsIye/MWwRVGRmD5BP7BA7ZSNXTRDH0oeiqp+JzB5v0h
Oik9u8sRbNqj5v31UB4xnUbwv8eHjrXHaHp7ISfnxtcNUWZihQyoIQOq4wDDiIa8
mWfPYwa8MvTteDSF0arcPmNs3vOJ1Qq0UyN1MdLDBwXw6MjsISQeP92Xe0UOF2kR
j7M1+HlxQrziAAFirHgZVaKVLrHT+GVQWvcuqqyQZb24qSCSSaP3jij1jOu588mB
u7OzBd0FNqeXRX1vpYgBWWuyUmWUnVXM7DoHwMyBTJfHqCZHQbNuvCgH0KtbSoVt
XYJfu5dA
=8GLd
-----END PGP SIGNATURE-----

--q7RoRWDyX1fVkT+O--
