Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2141FF531F8
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 07:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 335ED83BC4;
	Tue, 14 Apr 2026 09:01:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Gp3P9MOU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2281083EC6; Tue, 14 Apr 2026 09:01:34 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1145D838BB
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 09:01:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4887ca8e529so33637035e9.0
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 00:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776150091; x=1776754891;
 darn=lists.denx.de; 
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fMXtAQwF7JXgXAKQ5k/mj1R1gIuNTOktm98iu5Q9cPc=;
 b=Gp3P9MOU0R9s+5luc5VQNTuosQLqDcdxcaqMW/ksUxZjQuymrn/pv1lKr0zd0dNxIJ
 F+KWET+eNF9jB++mXwg8STZK6GPz085bvxlnt/ybwlQcECSsL0+S0Snx4PNN1uLifST0
 7sVGgM1Ae3Y/D6yJFzFY83zz1MLwzH8HrOfFFyop7yrTGUihaAHr1iqYqJV/jr19SLl1
 RoBnHK/KtdDse94VyHX5O+eAUDT9zIUstmeOs/Tq8+9tlLcHDBi/UoAS3Q8MG1F5wXvW
 UZmRoCpQF2QpThRgFcPuCg7SD5RPMzFNvvPetoS2tk68JaNnPA0EGR0X+vkXnpqsmBuL
 RfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776150091; x=1776754891;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fMXtAQwF7JXgXAKQ5k/mj1R1gIuNTOktm98iu5Q9cPc=;
 b=Q9bii4ZU5cP/2JvOiAwVCj9b1HR1QELNcmlJuRJWmfAYawLECur2C1N5BoVBC54NL9
 tUOt9SrBwwsXrrWXB67v+PaiQBOb+9wgrJnQ2PzfcydGDQoCsxjeajM/iG1FoXt1msGb
 +C5SCOkn5U7Odc1dN2V15UJvkNOudgYUYoGdf7ZlLVmeQ8aGRTh9LKMW3wv305Qh4Et2
 36LdcRVD0sm6d1TEPZRkHyTDxUVUiWyMb+366H1ikd8Km7tpaVjdMrHmrmeyMb2Ymi0e
 R1R5rEueycT3WGocjPHUPcAU2Z4LdB/YsOEqDynJpzr9bITP1U5kfBYIPVhOudZ3I0dE
 4VKw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+jlKOPptMe2brPzRq0Osy4LAY8JisSAm+hiYVI80UOLZuqqxxvMRQbOoYhRB5rkrlrDq2/79A=@lists.denx.de
X-Gm-Message-State: AOJu0YwzKjSmcqv20laBwu1vFQ3cSMjXVA3rq87um+eajG41RQsQebDr
 pw/Ilc7PYXGFH97pwtiusmCwODYed+ewADUQ6xQtL8+5K1jqJ8Ru1HNGjf/b1ph5a5Y=
X-Gm-Gg: AeBDieu643Ab7QW0veZ6XF80S+VawcPjSk2C8/Hzra0JhD5blOgt3WoLT/u/PCJdW/H
 JRRAzIYom1yzLOqaaX5cUP0K3lpXjCD5h2JpMIRP/1F2dhgecVt49mc5gNohu1aCiqqPbsWtEgB
 dlZaDJMZNLSG5Tgc23aCRMMIUDo68kY2OP+TLyam0UE9eHWRzv4dDtYIy9Q7oUCkKLcZE120/ac
 F3s36Fmr4xWSHpbh09etxrCY4Q8gJZBFyzLPFdskktA1TWOJNR/vcCIdScSAk77kXQ7nHAFXJJX
 n9L0ZrX/ZGmInD6BYPmUXq0YFO+b1gO7WVfOefTfqJ1LsSd9JRNu91feMr/tahk5pXfVy0+pUDh
 SPW3ogbWd5tCSWy/GKG2cX02Mug9iH69MDhKvkF64hmvxEI0MSdisaQxzXaT6lhAZeMMRJIJQk2
 KFUWQ++0v/cDp7ZE0=
X-Received: by 2002:a05:600c:609a:b0:485:3e00:944a with SMTP id
 5b1f17b1804b1-488d68ae78amr215556385e9.9.1776150091357; 
 Tue, 14 Apr 2026 00:01:31 -0700 (PDT)
Received: from localhost ([62.246.35.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede24eb0sm28247325e9.8.2026.04.14.00.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 00:01:30 -0700 (PDT)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=f5aca7d37fc53933acffa6c31fe9fbeb47e8c816220021dd55c5b71e4f22;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 14 Apr 2026 09:01:20 +0200
Message-Id: <DHSONMPLU5N5.AY9KGH9Z6WFD@baylibre.com>
To: "Maarten Brock" <Maarten.Brock@sttls.nl>, "Markus Schneider-Pargmann
 (TI)" <msp@baylibre.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "Jerome Forissier" <jerome.forissier@arm.com>, "Tom Rini"
 <trini@konsulko.com>
Subject: Re: [PATCH 2/4] net: cpsw: Remove compat string argument
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
X-Mailer: aerc 0.21.0-126-g9e77103592fe
References: <20260410-topic-cpsw-switch-v2026-07-next-v1-0-c914724b13e4@baylibre.com>
 <20260410-topic-cpsw-switch-v2026-07-next-v1-2-c914724b13e4@baylibre.com>
 <GV2PR05MB11941D5BAD20EA6CC43F2C3F783242@GV2PR05MB11941.eurprd05.prod.outlook.com>
In-Reply-To: <GV2PR05MB11941D5BAD20EA6CC43F2C3F783242@GV2PR05MB11941.eurprd05.prod.outlook.com>
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

--f5aca7d37fc53933acffa6c31fe9fbeb47e8c816220021dd55c5b71e4f22
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Maarten,

On Mon Apr 13, 2026 at 11:00 AM CEST, Maarten Brock wrote:
> Hi Markus,
>
>> diff --git a/drivers/net/ti/cpsw.c b/drivers/net/ti/cpsw.c index 6bfdbb6=
0091ac1cb7ef5a0bb3ad5221c2c11206f..c844416d50ca3db9bb0d9ffe56cd9c352b8c58b0=
 100644
>> --- a/drivers/net/ti/cpsw.c
>> +++ b/drivers/net/ti/cpsw.c
>> @@ -1064,9 +1064,10 @@ static void cpsw_gmii_sel_dra7xx(struct cpsw_priv=
 *priv,
>>  	writel(reg, priv->data->gmii_sel);
>>  }
>> =20
>> -static void cpsw_phy_sel(struct cpsw_priv *priv, const char *compat,
>> -			 phy_interface_t phy_mode)
>> +static void cpsw_phy_sel(struct cpsw_priv *priv, phy_interface_t=20
>> +phy_mode)
>
> Indent please. And consider to keep the type on the same line as the para=
meter.

I think this may have been your mail client? At least in my git patch
and the patch I can see I sent it is all on one line:

+static void cpsw_phy_sel(struct cpsw_priv *priv, phy_interface_t phy_mode)

Best
Markus

--f5aca7d37fc53933acffa6c31fe9fbeb47e8c816220021dd55c5b71e4f22
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCad3mQRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlPN
GgD/UIqjpXygya2FOdN+7gV+at2+RhLN4C8cycajKGuiOYAA/1jDeZyVl9IzkfmW
m/4zqqHXQZyr0Tj9hA9zDAnWuLgI
=XVKc
-----END PGP SIGNATURE-----

--f5aca7d37fc53933acffa6c31fe9fbeb47e8c816220021dd55c5b71e4f22--
