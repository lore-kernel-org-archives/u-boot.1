Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E96C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:34:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B14187119;
	Mon,  6 Nov 2023 17:33:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eOhtutwb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2D3C87113; Mon,  6 Nov 2023 17:33:18 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 853A987087
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:33:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-41cb76f3cf0so29917381cf.2
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 08:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699288395; x=1699893195; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tF4D4f3KBkvev9overK/iYozr9rQAmcIW+KClBApeyY=;
 b=eOhtutwboHjcBpKWDfNpaDVW08Duy43GsU/irplFpf4B2wc3PKJgHU3PsBylOmDKdQ
 VNG8vtYPueCOZDMUfv2FD07cHstZ4g0tvWNRGCIXUmYg2GK3cXOdpQG/gpURUKDHZEMr
 NkOKwwOsgfHf3Wnd3ZdA+0QrK1De7QtJ1gqoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699288395; x=1699893195;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tF4D4f3KBkvev9overK/iYozr9rQAmcIW+KClBApeyY=;
 b=n7xXokABDYmNyy+XD07Z9XnmCKMWaazUllX1VMGUZOUzLjbBhSVMqTojs2I6kNhIxn
 Tf/7b+G88cJ45om9SBhK88wlnfdz3gDYD1vzXhB1qNR2XYxlWbydgwLApIt+jUGK3MWS
 NnCIwUaL+P3D3+ZeudrHirkM9UEKstVHvvkSJYE6eDNbEqxUDZZRrL4TFbktKIy7hdiF
 04JiLwcnEkiCtNpOajS8L59HSiEe8l+O+b197TVy2DaR8wUNIqb1yrRJ+Y/XroDM7ZJd
 S3g/ZM+UdjfNgcwXerbqpLgsLmWLGtGEV3I7wfSP8HPJTctvv02IPIW/YPOGk98Ht9CD
 lXPw==
X-Gm-Message-State: AOJu0Yy4XcIgRGe2dtrvsoB7eD2CSyVEYK63jhOjUfbZZo4zMncq6V6C
 m0RnGMjKzM5FlzxLTMKR8urfig==
X-Google-Smtp-Source: AGHT+IHOQ21p8/V42H2UEOZySu3iEH2DK4tm8WA34woXhNRwNTg6J5ctIRkwSJsuCYjUdak7KNN+JQ==
X-Received: by 2002:ac8:59c4:0:b0:417:9431:c61b with SMTP id
 f4-20020ac859c4000000b004179431c61bmr36254013qtf.18.1699288395406; 
 Mon, 06 Nov 2023 08:33:15 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 k7-20020ac80747000000b00405502aaf76sm3504786qth.57.2023.11.06.08.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 08:33:14 -0800 (PST)
Date: Mon, 6 Nov 2023 11:33:13 -0500
From: Tom Rini <trini@konsulko.com>
To: forbidden405@outlook.com
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Yisen Zhuang <yisen.zhuang@huawei.com>,
 Salil Mehta <salil.mehta@huawei.com>,
 David Yang <mmyangfl@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH RESEND v2 1/2] net: add hifemac Ethernet driver for
 HiSilicon platform
Message-ID: <20231106163313.GS496310@bill-the-cat>
References: <20230823-wip-hisi_femac-trunk-v2-0-f64c28dc9b95@outlook.com>
 <20230823-wip-hisi_femac-trunk-v2-1-f64c28dc9b95@outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mP8eZwpFPaw8KJ44"
Content-Disposition: inline
In-Reply-To: <20230823-wip-hisi_femac-trunk-v2-1-f64c28dc9b95@outlook.com>
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


--mP8eZwpFPaw8KJ44
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 01:03:42AM +0800, Yang Xiwen via B4 Relay wrote:

> From: Yang Xiwen <forbidden405@outlook.com>
>=20
> It adds the driver for HIFEMAC Ethernet controller found on HiSilicon
> SoCs like Hi3798MV200.  It's based on the mainstream linux driver, but
> quite a lot of code gets rewritten and cleaned up to adopt u-boot driver
> model.
>=20
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>

Applied to u-boot/master, thanks!

--=20
Tom

--mP8eZwpFPaw8KJ44
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJFUgACgkQFHw5/5Y0
tyw4BgwArzjZ9/jO2w9zBBfhDJMJuSnfZbTaAQ1jtkTKvB8qaBakCpHWDqx2y1rx
UCOkjQWvFHZGwdx/XeNonH5LwNMqG/s3YCyPlDfQisk1dl2/i3Uu2E3Lc8M01Noi
dgX8PwkguPXCBDUVNNdgdE/A5LolD1d7s4QAaVHL/8QmQhV7inAPC9VV/C5avobw
xsBE+tloj8LIo60qBqc/Q8m8N5XCUrXehl3gtEqED7Qh7s8anjQk+4tjQEb7bpAM
hjoQSQA7jh6TaB6Ux3Ha0cCr2mfwJ6ChPK1BYHbdpqUBopMZtS2WaQC1QJpUxs9j
QhgS8R87HXcPdrd8bubsI2EU3GgPUdtYAT29jiQAUFAkqM/ymdlECZZO3qjjJJON
kDlAs/nuQ22LgEMOOw6BwzUVUNFpirmIJ4WdJ6lfedkY5tf1dmfTCJTd/5CosBjg
IIZBGDLPRO1FAYDET574ewlz0hU45PQLxWeZmkT4Hbyl6pAORQqAJWaZEOp+CfLh
fKojuNlB
=ssaG
-----END PGP SIGNATURE-----

--mP8eZwpFPaw8KJ44--
