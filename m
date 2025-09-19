Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45ECCAC597
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 00:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98C56829E7;
	Fri, 19 Sep 2025 02:11:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WcdkXIW8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCEA882C84; Fri, 19 Sep 2025 02:11:23 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A970B81E13
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 02:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-74526ca7d64so1631594a34.2
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 17:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758240680; x=1758845480; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=93YAwFBDatZLB1fmm8jLUcWqQgDcTDNCU+4tt2QCa2g=;
 b=WcdkXIW85vxxSRy9Bepzou9MShKHWTV6QS0C7J0zOvvzqeKmO1JJkrC9D6zYydunFO
 4w9+A1Kw4sv5Wl6LRSdjoZ/r1u3km64PP5SMQECXFG7WJSegpV7tUHpcgJWi/1Lwum15
 cFItWIMVnQAW/tvS1IzxWdIw6j/u71/vc+osk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758240680; x=1758845480;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=93YAwFBDatZLB1fmm8jLUcWqQgDcTDNCU+4tt2QCa2g=;
 b=VituzM65SdiVACGXKTI8K3NOIO960drtmPzE9m6wSiveVs5OsBqReN4cPkLJc6fefN
 /ITvB3nIRhh6p4qDmz2m2PFeaW7dF8YgV8FociqQJL2IQKnqKBaTJqykMmKc+yl0W+PP
 TMsHyTdvFmDNbzBoRisIjrOGsS8tL1SH+zmbmY8UyM3fiCetzLryAK4Qk6mgbUMjRjcZ
 3kU+KVfN+SOooEM3T3XovxoLnj/Bf+ER7pm5M3oC/Dt5LL/lx3JkQBVR5J35RD+8jXhr
 3Q5IWJHSwgWFfOzDC2SVwmMmWOfMqiEmTH20IylFlbPk3LrTcXo5WHS2zaiwiCITuupC
 iBgg==
X-Gm-Message-State: AOJu0YzRbY7IsQUT3amllPDx+Wgu4rtRTKPvFeV7sEz+tvmEVgVI/bAk
 30EkK4OwpLh7iIxQ+Bf1n+zPPlxClnCV6Rlk4mCq774hM806efdpoSyED1Qk1qfm2j8=
X-Gm-Gg: ASbGncs7ZdjN5NPELFJcfwmYEVUtvliNu9q+xfR5WfAq7JhwZgVWBZGfEbnZdW7N7YS
 YuF3n+cUU/9m7z+K5TFg/guFAiRoej8DQnH0gL/PhNebZqCnxb+HuGF/XR8n31bvFRfuvdI3hni
 t4/8xi60cPKsfX2S90I2VYPS7oJpim3tBEZo327HUy1tfv9VoTOUYktrWvoHVKeO1+gfly+i5dz
 osM0qGfVux5Zi9MQ0sngQiIFECOE4MFE3IiUOGojYMW9lzhbXCvqSZyiXQ3fb/XfLbXxAfDuM/o
 1IlKXdkJUGZonddZuVzMLPM+xKAbk88J3/z9WOjqeYH8yC5s6virzJMsUZ6J99FKxs/o3GWsfrB
 secyMxwnsLbU7EZjA4VkLROpVsBjhVvxoVhps41DqMm7B4xpVCsw6+5672obFCSYKFn/KjGCXwd
 0=
X-Google-Smtp-Source: AGHT+IFl1/+47ZYvFif9P4PuSGq2HuzqLOS3PIPi39VUbII7ES/9Eh0FKdJBp9GsUhhUV4Fr5IDtnw==
X-Received: by 2002:a05:6830:4492:b0:756:c5ea:3bcd with SMTP id
 46e09a7af769-76f755fed63mr935550a34.14.1758240680407; 
 Thu, 18 Sep 2025 17:11:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-76929180e50sm1618209a34.21.2025.09.18.17.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 17:11:19 -0700 (PDT)
Date: Thu, 18 Sep 2025 18:11:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "jerome.forissier@linaro.org" <jerome.forissier@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 "sjg@chromium.org" <sjg@chromium.org>
Subject: Re: [PATCH 1/1] board: ti: am335x: Do not call disabled PMIC functions
Message-ID: <20250919001117.GA974973@bill-the-cat>
References: <DB6PR05MB4551D31271569EC04E8EC60F830CA@DB6PR05MB4551.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2KdOUOQsEgXzltmj"
Content-Disposition: inline
In-Reply-To: <DB6PR05MB4551D31271569EC04E8EC60F830CA@DB6PR05MB4551.eurprd05.prod.outlook.com>
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


--2KdOUOQsEgXzltmj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 08, 2025 at 04:05:04PM +0000, Maarten Brock wrote:

> When PMIC drivers are disabled their functions should not be called.
>=20
> Signed-off-by: Maarten Brock <maarten.brock@sttls.nl>
> ---
>=20
>  board/ti/am335x/board.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c
> index 2b7ab68e83c..284c31cc329 100644
> --- a/board/ti/am335x/board.c
> +++ b/board/ti/am335x/board.c
> @@ -283,7 +283,7 @@ const struct dpll_params *get_dpll_ddr_params(void)
> =20
>  static u8 bone_not_connected_to_ac_power(void)
>  {
> -	if (board_is_bone()) {
> +	if (CONFIG_IS_ENABLED(PMIC_TPS65217) && board_is_bone()) {
>  		uchar pmic_status_reg;
>  		if (tps65217_reg_read(TPS65217_STATUS,
>  				      &pmic_status_reg))

The problem is that here and elsewhere we don't have SPL_xxx symbols and
so we're turning off these calls in SPL now on the platforms which would
be calling them.

--=20
Tom

--2KdOUOQsEgXzltmj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMyfoQAKCRAr4qD1Cr/k
CoSyAQD5qNVAytjrqSbSnaZ8O8SDOjVBMxGmBOFqBXT7nIEk7gEAowv+u+8o96Ba
nQkHYeeQS9Nws4wSPD0yoMBHvETPSAQ=
=EWYU
-----END PGP SIGNATURE-----

--2KdOUOQsEgXzltmj--
