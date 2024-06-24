Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13B9C3064D
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 15:49:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EE4B8831F;
	Mon, 24 Jun 2024 17:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="krMwmsff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9689388387; Mon, 24 Jun 2024 17:49:12 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE24D883CE
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 17:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3c9cc681e4fso2420487b6e.0
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 08:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719244148; x=1719848948; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gL61cIwUC35t5UYF32Gp7jVpMc3zWiJNE4wES4BPPWg=;
 b=krMwmsffJgrz06CY6DP1wE3eyY4r5oPWMJZ7Fl2VGIG/LTa22r4NK6w4uFCA0AhSJV
 t67GDEFgJfy1Z8RxdHhkqh/zqXA/Gs2IfGWalMZNuxWBd5zDXiQJssP3jKyA7MtIErT2
 fXHHljZkYpamY3r/rFR4SH8qpNPdBbq002wEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719244148; x=1719848948;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gL61cIwUC35t5UYF32Gp7jVpMc3zWiJNE4wES4BPPWg=;
 b=toyPtC1A91VT5OE/LBTaigxQUc4tYdBlk+dDICDxRaMXLg+HhzDEEPWvtJ5N1/9eeW
 di+Oa58uqQmjEWsT0YV+Yykv8LDSox/qDTCEeaI07gWvlVP47dt3jWCaSvPe/Mgy7Z41
 SvdkKp+WuXC6CdYzLkQioE+FQxkW/0jWtJCUpJc5aSzR2oJl7gJ51N6spTz8zQaxpuQ+
 fGwZ8kh/mzePr86zP32BT5wMMtFFYOmuYyL5NGq2gj3m2xnb2vPBNvWxXwATNsdu+BGf
 QICmQj/a3/XlAZFgxhrAxY2giTbEYaYe8CSYhFyFf+B9ANg2tOKd4XIWlOfNqDzv32s2
 DIOg==
X-Gm-Message-State: AOJu0YwOyu4frxvHqXz5dQy0A4IHZCHRXasyHEnbBerx4GVsB8654hF5
 dqVkhV5wHz479MlKvupQ4Mc94iZcTEc+3Sl1Z2utQ2Brpr0tGpscvMcIBkPb59k=
X-Google-Smtp-Source: AGHT+IHKW8sjJuQP014Ku7ntk5xQHTFvSJ9HhSgHuql6/pDE/JXxy3lnHf8Dtnmof/P3QubZTauKxQ==
X-Received: by 2002:a05:6870:5143:b0:254:e924:be62 with SMTP id
 586e51a60fabf-25d06c1b598mr3528321fac.13.1719244148554; 
 Mon, 24 Jun 2024 08:49:08 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25cd498332esm1938918fac.13.2024.06.24.08.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 08:49:08 -0700 (PDT)
Date: Mon, 24 Jun 2024 09:49:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PULL] u-boot-usb/master
Message-ID: <20240624154906.GB38804@bill-the-cat>
References: <20240623002750.340406-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kX6laDIuoSsjcN4K"
Content-Disposition: inline
In-Reply-To: <20240623002750.340406-1-marex@denx.de>
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


--kX6laDIuoSsjcN4K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 02:27:06AM +0200, Marek Vasut wrote:

> This can also go into next if you prefer.
>=20
> The following changes since commit fe2ce09a0753634543c32cafe85eb87a625f76=
ca:
>=20
>   Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boo=
t-watchdog (2024-06-18 08:34:56 -0600)
>=20
> are available in the Git repository at:
>=20
>   git://source.denx.de/u-boot-usb.git master
>=20
> for you to fetch changes up to 0db3941a24bf0b6fc54438e7b9cc66b18f08115b:
>=20
>   usb: dwc3: add newlines to dev_vdbg calls in ep0 (2024-06-19 06:15:37 +=
0200)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--kX6laDIuoSsjcN4K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ5lXIACgkQFHw5/5Y0
tyyUgAwAnbI8gCdHQQzo5Dwy7Z6+rxdw5Xtq8kHedZvd/gYctXmZl/ndotdRBCgR
/S1c2MeceVeIq5PwDmaxx7PFhqv+ghGXHigEWNp02dOG3VUnkEjenHF6zb4TxJcx
rGaLpJFaHS9pkplQLJDgtYE060pI2OgkQNMg/kehyrQ4E1VR+Xd+CIVh9aj2JI40
OuQ6vD5HPyIaSrEZ4FPJfee2jjHXa5YeFfCY2itOCpb5BGbS9EEoiHLSK7vQB4ht
pU9YR12JyzE2/7vIlaGENqkuYrR35uucCFCEiKF5VDTJq7ZSysVrDxpE7lFquk6V
YyuWOzYzjb0pwPyWES1oZ7kNZjrPkG70DIqoXpa+JuHIz+3U48ex27dKzo2gvBtG
CNybdSealkb8VDPgSbU7q5RY78rii3MILnc3yMa24Y+rAxFtzlpX7XkJRa36mnSa
MC3PX79nlpPj560CVslPw1M4FWU65S0hzAzHTeW548pRpiXDuK8XBL1jCWQ4etDH
OXB7NGdQ
=3lZl
-----END PGP SIGNATURE-----

--kX6laDIuoSsjcN4K--
