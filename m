Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E223C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 15:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC16A876B1;
	Mon, 18 Dec 2023 16:11:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FVEJm7yj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A04FF876B1; Mon, 18 Dec 2023 16:11:58 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C9F687505
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 16:11:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-77f642b9a22so328750585a.0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 07:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702912315; x=1703517115; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=O+DDtGt509kfLGfM964dPrQASricrDrJiP4kyzlswls=;
 b=FVEJm7yjWecR+ef1IVB1gEozDxq49Ffj8VRq9wRITC24tBnAfiyu7kTbLHSMauJzj9
 5JfI0IBcWD4Uf5Pj+bwnJg0hdzBykk2FTg0lrY63+qIQx8E231B5V6az0XgX+fUQnCB+
 xau1XAUxuch8qfrXfyV2ib0qt5gLX9sngZXbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702912315; x=1703517115;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O+DDtGt509kfLGfM964dPrQASricrDrJiP4kyzlswls=;
 b=DIdkuCVk5Ezf3GJrLSl80cOk1bWuE6Tum/+QFf1gHn4AMAlE+zc0A9SoFzqMvl9nnX
 Af2UBzf0Ajmm5dLzIdHBzPcJRkUfkKdxhwoyUaNxanq+i8az4W1L89+nATbSs3zEHSjH
 vbB6tTXOcYEbK9KaLVDK55z+/7HgUU17HoFOXB7KByzzg10w4xeifO30fwaHfbyipkpj
 vP9G42MF1J2Xk9omNB9MJ0zOaI4eb90rkArKsCCkQ0rOXdplYuavabMU9orB+3L1bFXM
 YJbD5hPfjikwrQIB9BsgCPH/v57oSEyuayEPheD59g8Z1jXVlzeHwNLjn2H14gZlFR1m
 7DtA==
X-Gm-Message-State: AOJu0YxuF4L9gE/xutunbaAp+Soh6fLXtLKWQExL3YoPtA0lnuBOAhOK
 HxE2CzvNsGUtOmJfS7tnhotSwA==
X-Google-Smtp-Source: AGHT+IHOSsxzYdJnXuwviwK9DNYI7eTIDLTD5LMRYw6Vh4+zVTRPOnHSsSEhCSa2JSWd/uwe/jbfCQ==
X-Received: by 2002:a05:620a:45ab:b0:77f:97bd:fb31 with SMTP id
 bp43-20020a05620a45ab00b0077f97bdfb31mr14837699qkb.63.1702912315268; 
 Mon, 18 Dec 2023 07:11:55 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a72b-a3fc-ffa6-9927.res6.spectrum.com.
 [2603:6081:7b00:6400:a72b:a3fc:ffa6:9927])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a05620a112700b00765aa3ffa07sm8379609qkk.98.2023.12.18.07.11.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 07:11:54 -0800 (PST)
Date: Mon, 18 Dec 2023 10:11:52 -0500
From: Tom Rini <trini@konsulko.com>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, simon.k.r.goldschmidt@gmail.com,
 tien.fong.chee@intel.com, sjg@chromium.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, bharat.gooty@broadcom.com,
 rayagonda.kokatanur@broadcom.com
Subject: Re: [PATHv1 0/9] net fixes prior lwip
Message-ID: <20231218151152.GG2513409@bill-the-cat>
References: <20231204120446.3277-1-maxim.uvarov@linaro.org>
 <CAD8XO3a0PF4hGhdLwTrAo5WYRZp+Z1Ve0BJmCYEUg0iTONcdsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="blzvuu+2HpVId3Cf"
Content-Disposition: inline
In-Reply-To: <CAD8XO3a0PF4hGhdLwTrAo5WYRZp+Z1Ve0BJmCYEUg0iTONcdsQ@mail.gmail.com>
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


--blzvuu+2HpVId3Cf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 09:03:47PM +0600, Maxim Uvarov wrote:
> Hi,
>=20
> Do I need to resend this patchset with small comment message correction or
> it can be done on the apply?

Yes, please v2 that patch and perhaps re-read all of the commits and see
if all of the commit messages could be improved / expanded upon a
little more, thanks.

--=20
Tom

--blzvuu+2HpVId3Cf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWAYTUACgkQFHw5/5Y0
tyzr1AwAt39VF2bOxaWUIE8tYZ19S/Jwz3zW44htumtjUwvcWjLYkQQoxQmSoKfw
afd/gS4eZDI5kOUlo739C3+0o/saDh90ol/a3nvFreXyWFHbym/aLvhI7b3twyB1
tL1ZO6dnrXhiz0W/QpIKyQ3lVZ4qev7bBQ4P8HoM78XIAhhwDGH2rPbiVx8B+BI6
i2Cex/BXbmHLrJbUaKNT339MUjs1soIMGNTXb+BQqETBF6UJk+857m6NfJhP8tnL
ub9B9A1E/x1L5p5EK/LlTd7sdNxH6t2GTd3v6DBsvC4wILBwXP6K74Vn0a+p6R2t
Pf7vAXO5o4wwVE3fLel9zoYMGMHyINBeaXry8hK4sBB0XaEjI9jjUSolzORidK6z
GnT191zoExNwc44cUmMnPnoNmrFOJ4hVwFgADumFJPT6rHD0s09VUBAhBS2NRJxf
h3dLd2EWTBLHyK3AX50VaZZkeCTAT+B3Cdvtkev2wUa021YJ8uzVr6razln03Axo
5xEtcGNC
=rWRv
-----END PGP SIGNATURE-----

--blzvuu+2HpVId3Cf--
