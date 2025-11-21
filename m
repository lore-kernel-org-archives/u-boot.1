Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40BDCFC279
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 14:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74DF58394E;
	Fri, 21 Nov 2025 15:30:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GUbBMft6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 512D683981; Fri, 21 Nov 2025 15:30:48 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22DCC8397A
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 15:30:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6574de1cda1so838653eaf.3
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 06:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763735445; x=1764340245; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UBkyrop+NQpg0eDuqA4AqVVePv7v1/qEFvLFbLcbp5Q=;
 b=GUbBMft6qQkoxVc3MsJK6hAKFe56llFEEY6qFAPMLHMEZxiJZFWN57g+k7Sw5a9NHd
 K8l3DOpc4rea88MIYGLPPL7MfMpcwFZxvSsIMUtfssFPhPz+FM0+qJXZD2Rc9BrYQAhE
 aVWCwd4J+0g9ZBG56+8BRk+iWasPLFXHjSEyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763735445; x=1764340245;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UBkyrop+NQpg0eDuqA4AqVVePv7v1/qEFvLFbLcbp5Q=;
 b=Q44GE5Esk8qnPSylPmjMKkY8VoVqrWCQXl+P5F1ZZY9D+CPG6EQwicaj7DanUDgnx7
 byfHEZ2Y03ECR6wH0hs5GwuiJIS4mfqCwF3G2bQE92Y4nGuIrvAsyidP7Fmbkj5nnYoq
 QCT7/2GerAVHSlkJtahx7CNdSCH9zouPoN35d/G7yfkgaTRuxb659yGVSTkVFqLYOjLY
 TvQOmxPZ5rlRP3N96k7MD3NlYoI7zHFy6nhNOw2iAcwWTnxUCfOZoqds4PUgwQkONcwX
 /eD8XBSoWwNSY5o8TfHVlXydHV4XQKXc7SaCfE22wr8Rr4dYCdNbvR97oalxquagVvWU
 V1cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/As17MC54TFb4LnKKjLXpl17JALqy3D4Xv7C/zkcGL0ZupSiWwg/Q5iIFsXunqIHN4T29IxM=@lists.denx.de
X-Gm-Message-State: AOJu0YzZTwqR2VQmEXxX2G/1Kx8EQBFQY6HO9sg+Og0EOMdWtlcnVVAQ
 LMxHk0bKOxgJ8HtoPuXwQMEIltAmmtyZSLibJnnzK/wczL3uLe1FDPQGEkPWl03D5UQ=
X-Gm-Gg: ASbGncs5XrZLmqf4d0tf49V7Fg1qGbD3IFNOvvp4Bm4y3Fsns/ew127YccR+Eco7oAt
 hvN6/D0eh+nn/X984h8Cg4OuypuZUWeX2634NLarPvWBzIzyiWK9takeWYtprqxVRKDIRI32r++
 IQVnTEzPzj4vXNvRyIiohKZQOyXNTXY9nQFxmNzHFA6Ib6hyEXrLwcz/yAkwl1sEbmC5vp0ZVt0
 nJweZnMOyB701cyvNWcmqVjH4hsUTlsHU22TJLorJztNG/Wnf5zs54tmGHIMzN1upq3Nf6p/k7s
 dFAb9tvuRwLR4ztG2jQnnDru01gxsoZKf0iF1IIluBtHD0SYDBb8s5QdNf79W8gHaZcAF8xWiJh
 3fMx5VpY4PQETmlpdrNGyOW80EkTn5qfLUYFMG7tJPWQ1EtLCvthVGtcDlPnoPVngB5pNiqDk27
 9L/6EP4LSfM++m6WkCNiU5tOgJEpEJ/VmdXXuTYS7O6PpZ4ItMpA==
X-Google-Smtp-Source: AGHT+IG9qgGNTKk/Sgxzhr5WQNi4CB4vIo2o42LfmAywq4htRgW4XlTqJf5fAbUT6MgsoFB0GgdNSw==
X-Received: by 2002:a05:6820:4c18:b0:657:63b1:658 with SMTP id
 006d021491bc7-65790b502a9mr936848eaf.7.1763735444698; 
 Fri, 21 Nov 2025 06:30:44 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65782b4cad5sm1647763eaf.9.2025.11.21.06.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 06:30:44 -0800 (PST)
Date: Fri, 21 Nov 2025 08:30:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com,
 marex@denx.de, ilias.apalodimas@linaro.org, rui.silva@linaro.org,
 luca.weiss@fairphone.com, quic_varada@quicinc.com,
 mkorpershoek@kernel.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v1 3/6] drivers: phy: qcom: Add QMP USB3-DP Combo PHY
 driver
Message-ID: <20251121143041.GW2125796@bill-the-cat>
References: <20251119152530.4175628-1-balaji.selvanathan@oss.qualcomm.com>
 <20251119152530.4175628-4-balaji.selvanathan@oss.qualcomm.com>
 <20251119155203.GA2125796@bill-the-cat>
 <924893a7-5cd7-4328-832c-aaa01b9e04be@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yp+i6VPi75sipNcs"
Content-Disposition: inline
In-Reply-To: <924893a7-5cd7-4328-832c-aaa01b9e04be@oss.qualcomm.com>
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


--yp+i6VPi75sipNcs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 02:22:42PM +0530, Balaji Selvanathan wrote:
> Hi Tom,
>=20
> Thanks for the feedback.
>=20
> Sure, will change to bool.
>=20
> Should we add "drivers/phy/qualcomm/" to the ARM SNAPDRAGON section
> in MAINTAINERS file?

Sounds good to me, thanks!

--=20
Tom

--yp+i6VPi75sipNcs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSB3kQAKCRAr4qD1Cr/k
CnOHAQDAwS+T2kGBrpXn5SH6elvnDAVHoDvzsvlvMK00c4L+iQD7B2jQcP9Ilo7O
SbRArKJYRpzE3VF9+niFMTLfnLX53gM=
=fo0L
-----END PGP SIGNATURE-----

--yp+i6VPi75sipNcs--
