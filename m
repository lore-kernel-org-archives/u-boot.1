Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03FED116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 14:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F07C8458A;
	Fri, 28 Nov 2025 15:13:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="v9pfZnSP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03409844D2; Thu, 27 Nov 2025 21:22:20 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 996B48449C
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 21:22:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b735ce67d1dso198098366b.3
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 12:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764274935; x=1764879735;
 darn=lists.denx.de; 
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iMEiJy7Text2GRZMdpTU5pwTlNap339YaF3fE8csRz8=;
 b=v9pfZnSPWegTPLgu/YLjOeqh0Uz78e/vmnxiJ9ngQxCcF5Z/MThu0BYqaERHTzL7Yi
 szw95VyKCVQZTegl5Ym+ghvsCnduIMU00c2fkB4e3Fv4zdVme2JvgZxgqy1Id3UrhQeM
 Js98SFqYTNVS3km2T+jhD9YY3PuOmwet3vtgDRQJe5GzL0WkT5FFxUxCb6r1uiSEK3ka
 TQi/H8euwzwzfiUbD2NxksbsOrdkWy9BOnzeKoiJNB26QCWJNQWWliVsf83GvkJ94GES
 51SQMPSIZLGl30wZ9Qn4FQNNhrSg4BsnQBYPbnBVRMywPrPILTAYssLKqvbbIUTjnO53
 lJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764274935; x=1764879735;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iMEiJy7Text2GRZMdpTU5pwTlNap339YaF3fE8csRz8=;
 b=ZliNkKBiAQSSHKiJZh6Ur7oL7z1mMlYBSxT9OS+E5kHxD43z0uHmHLYHQ+WG3LtFL/
 cfObJpK4e0NqvXqEAS8ut5jIVNNHR7VwyHnSDV5bhcXREVkUl3K2TwvNXxI4+Oyzfslp
 6wL8DpgXqqqAadXDsRBPeOqRCduPVe91t6Oy+j9LIk/FJe+AiTqyFujFoNc/q6kG1wgU
 rTuv9HNrHfqdmhldKZZc7UGvru6oKiMJV9oNGTjKcAn2qhcMNBaUCT9+vg89qQ6x9hgc
 IBwaqXayCbopOeqCjdw5pTrXd5qWm1NqLaf3S3kEhhKARc68KJNX60h6Dl+yuV7c0ffs
 vh/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXikyOb0ZxR1xk91mW/yVs7PJbcm/y+StH893jGzheikl6ggqfqW4tvwvSM/i/8N4N4UwuM0sU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9763tJVkS42egKBycPrChEnNB+drv3R/N33cUt1BlynPHChIU
 hFeTiSRfd/aispnLXStLUsxj0rPgGqQW4hM+s95loFS2s5mS+JLGdygH0NFsSXO3DuU=
X-Gm-Gg: ASbGnctx3qjxMMjhg8q/64v0vq7BXfoEAnohBJ4b7KnIRaKKHETCBZzZMZBDYslus0d
 rA2gsTyHNXU45wjqiQYTEuoJYFW4Oro8x0IFriZcSO6Zaz53To1akYw2z2Wm30sSZcIW8Y0KGv0
 9O7uqt1kLgu3qlJeMkRz7Qp3LFRgSBMsqqf+btmrp9PdrM+P/siKbWF97CbbqP9oA8+GiODYoB4
 w1YKJdfbXJX+HYe8//eNN7uQbb9ai2/C+P2j3MJqPvCc8tvK5DKVeKmRrgBN1t4Js0Y5ygw9cBm
 VKYJaP25/ir5L+iXM7W1dJStS9BbcrJhkhfx7e2/JephBWQKeadzw2coOBDZRHMgpoD+6kIUtN6
 dh6fZ+/iYZZ6enctrR9Rs7B6Aoc43O9IIgIsMcKizsV6duDCSLsP0KuD5n0qcbJVeixK5/poTW/
 Uxcg1a
X-Google-Smtp-Source: AGHT+IH/mpK9jYwHAh/z3Jkrnoxzm903lCXX4vhsvo1uOY+9jn0CGoUEC/6b98FuNHGdugpSo8V2nw==
X-Received: by 2002:a17:906:730b:b0:b76:3399:457b with SMTP id
 a640c23a62f3a-b76c5513e47mr1206771666b.37.1764274935062; 
 Thu, 27 Nov 2025 12:22:15 -0800 (PST)
Received: from localhost ([62.246.248.122]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f519e2f0sm259717566b.21.2025.11.27.12.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 12:22:14 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=be6e0269f53696c4e097b5df9a96267c5f88245b6ba53d276479ac266c26;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 27 Nov 2025 21:22:09 +0100
Message-Id: <DEJR9LISZARV.2I8LOGUGUQC4N@baylibre.com>
To: "Maarten Brock" <Maarten.Brock@sttls.nl>, "U-Boot Mailing List"
 <u-boot@lists.denx.de>
Cc: "Kory Maincent" <kory.maincent@bootlin.com>, "Markus Schneider-Pargmann
 (TI.com)" <msp@baylibre.com>, "Tom Rini" <trini@konsulko.com>
Subject: Re: [PATCH] board: ti: am335x: Fix DM_TPS65910 condition
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
X-Mailer: aerc 0.21.0
References: <GV2PR05MB11941393665E8D8E4EC9BA1E883D1A@GV2PR05MB11941.eurprd05.prod.outlook.com>
In-Reply-To: <GV2PR05MB11941393665E8D8E4EC9BA1E883D1A@GV2PR05MB11941.eurprd05.prod.outlook.com>
X-Mailman-Approved-At: Fri, 28 Nov 2025 15:13:26 +0100
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

--be6e0269f53696c4e097b5df9a96267c5f88245b6ba53d276479ac266c26
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Maarten,

On Tue Nov 25, 2025 at 2:55 PM CET, Maarten Brock wrote:
> scale_vcores_generic() calls functions implemented in
> tps65910.c, not tps65910_dm.c. Change guard from CONFIG_DM_PMIC_TPS65910 =
to
> CONFIG_SPL_POWER_TPS65910.
>
> Fixes: 0b9ff0851592 ("board: ti: am335x: Do not call disabled PMIC functi=
ons")
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> Signed-off-by: Maarten Brock <maarten.brock@sttls.nl>
> ---
> Resend of [PATCH 01/15] board: ti: am335x: Fix DM_TPS65910 condition
> as a separate patch as requested by Tom Rini.

Thanks for sending this, I was a bit slow this week.

Best
Markus

--be6e0269f53696c4e097b5df9a96267c5f88245b6ba53d276479ac266c26
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaSiy8RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlPh
GAEAk9gE3jKb0DcsBVYHqm9H60ZzY3IYCUhGM2akQUw/BWEA/1FGIEBGTEIdfDPN
JoVIpfxEyujTOxKSxCadZj805k4L
=WRSX
-----END PGP SIGNATURE-----

--be6e0269f53696c4e097b5df9a96267c5f88245b6ba53d276479ac266c26--
