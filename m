Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B68F531F6
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 07:04:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD840840D8;
	Tue, 14 Apr 2026 09:04:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="XyIV39/X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2338784119; Tue, 14 Apr 2026 09:04:22 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDD1C838BB
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 09:04:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso81319505e9.3
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 00:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776150259; x=1776755059;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WmxLD34ESRmceIv6qIvhSL94W4uSOSq+3rFtqD7JlZ4=;
 b=XyIV39/XfKPVSrHOh8TZH/4OFPK18/qrVYCRZinOIhyWwA4QvLqOcBc9cmseTKnq1K
 JNklBXXBLJW1q3aFB5HqiTT91nZlP4Hwz3JMZ63TR/H0Z0HTxuqoTHVxQrb0g2NG7LLI
 7SFxe4XMqBuyMXXCJiXg6UglBBA5jMdowAYbNDG1EEEqq3f+JLuBOrlqbP+/04Q6QnXn
 ONvnbQI25NEP/Og79nMF89UhaY6FWu413Up4XEm4AGGxpi4KYV5/CVytY9UlRTIsIu0B
 oE4+ErG9aDJvN8EXSt3t6aeMOVGOKuxVRLcWwNZETrXyit4Swp/DRmXIgNJjJvQlUnK7
 b7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776150259; x=1776755059;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WmxLD34ESRmceIv6qIvhSL94W4uSOSq+3rFtqD7JlZ4=;
 b=ScP/us/liBoZUqXGOB21zH2n8vmzeb+rVjHumDgM1a0pjU0knTLqvWeieLyi17LLls
 /OrAc04pBeeu5wfIu89Lt40hxm1e2kmzaAmV+hsZMR6fMOKWrIsP7rgAJ5R1UjPnu0Fb
 YmhVZnEgv2lK4pKhQYDhLyJJjEZ0nJEr4eWppu3MMSSHK7YEdPkSkWqtPu1vGo7V1E2q
 VBY0WP4v3rQorZ2Eyv3cTXei4w/fFnmpSC17t8e5n5eva6AtLYuTsJmU3pyyKsbeIHYa
 hM2bcwvTayo6TJGXR1MI/oYG3rjTYb5LYXX6UhcN+XBmjXsAVgbOuXH0BeZzMXYkdKVA
 ujgg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8QF00O4pqLikH+zhWATDqZRASAulDM+WTWbb8iA0GI5mzNnjLBteVs2hxBVPeHiBb3+8erg30=@lists.denx.de
X-Gm-Message-State: AOJu0YyEXgX2VyAwmh4s8CUkIR9hqwSL2hg5SKpvQ5UBMfs5xR0/fq+/
 20Rr+iKXC0yQxjBSsgiFWletP0IUFko8Y0AJzpGsh08C80hLYtYQnLNR6Vb3OeuoJZI=
X-Gm-Gg: AeBDieuF9PCTV+QV538r6+oq+OjYMlZ9bhNPIjlLYrqNepROE2yI4ZYsTNdkKrqMGMC
 oZr9p+to2ZDiU9HDnJGH5mSrJmFhVN2ASZuPna3vaPk7hj6Feb8a4mfzfOXinim/ynCIDeHJ9av
 UX5Tt3RO7aREf9eR8uhSGj7U8ZzycpPnKoe+7mWhKGFJ/nzifiAgxi8Q62qquJItUKnFAmWt2Wu
 QGQzP56dq2vq6T69kXs7fMn1EtMSUnqZ8ZXfl57WXsgWv0GSD5lcNMRI/ssRfz9KmujzYXqBrIK
 VgXezBJf/m1oXcn7P/oMvGARazEVncL7wTXWlyzLaFVEFDPxSXSQVdjQRxdjgwuyBdpVBrl+3kv
 uykOdC4Nccw+eAfXpc/trv6U1L/Bki80pSOWUjfYzncFcJmy732tMDHY4REWoQhP8IYHxe4arQt
 DavvSIxF+q2kacidELpIQqCJZ6EA==
X-Received: by 2002:a05:600c:a109:b0:477:76bf:e1fb with SMTP id
 5b1f17b1804b1-488d6843245mr155138735e9.16.1776150259169; 
 Tue, 14 Apr 2026 00:04:19 -0700 (PDT)
Received: from localhost ([62.246.35.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ee019e44sm48429725e9.15.2026.04.14.00.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 00:04:18 -0700 (PDT)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=0576360213c6dd6bb860cad7b31ade82973e082b92a38409f0d2f00984fb;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 14 Apr 2026 09:04:12 +0200
Message-Id: <DHSOPTRZLJEL.XJXOXRIJAD6S@baylibre.com>
Cc: "Jerome Forissier" <jerome.forissier@arm.com>, "Tom Rini"
 <trini@konsulko.com>
Subject: Re: [PATCH 3/4] net: cpsw: Use driver data for phy_sel
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Maarten Brock" <Maarten.Brock@sttls.nl>, "Markus Schneider-Pargmann
 (TI)" <msp@baylibre.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-126-g9e77103592fe
References: <20260410-topic-cpsw-switch-v2026-07-next-v1-0-c914724b13e4@baylibre.com>
 <20260410-topic-cpsw-switch-v2026-07-next-v1-3-c914724b13e4@baylibre.com>
 <GV2PR05MB11941E84B2F2FBF920F73707F83242@GV2PR05MB11941.eurprd05.prod.outlook.com>
In-Reply-To: <GV2PR05MB11941E84B2F2FBF920F73707F83242@GV2PR05MB11941.eurprd05.prod.outlook.com>
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

--0576360213c6dd6bb860cad7b31ade82973e082b92a38409f0d2f00984fb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Apr 13, 2026 at 10:57 AM CEST, Maarten Brock wrote:
> Hi Markus,
>
>> diff --git a/drivers/net/ti/cpsw.c b/drivers/net/ti/cpsw.c index c844416=
d50ca3db9bb0d9ffe56cd9c352b8c58b0..b1fb009822e9586886e5487e4fbeee115eec9a59=
 100644
>> --- a/drivers/net/ti/cpsw.c
>> +++ b/drivers/net/ti/cpsw.c
>> @@ -216,6 +216,10 @@ struct cpsw_priv {
>>  	u32				phy_mask;
>>  };
>> =20
>> +struct cpsw_driver_data {
>> +	void (*gmii_sel)(struct cpsw_priv *priv, phy_interface_t phy_mode); };
>
> Add a newline before }; please

This also may be your client? It is correct in my git, my mail I have
and lore shows it being correct as well:

https://lore.kernel.org/all/20260410-topic-cpsw-switch-v2026-07-next-v1-3-c=
914724b13e4@baylibre.com/

Best
Markus

--0576360213c6dd6bb860cad7b31ade82973e082b92a38409f0d2f00984fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCad3m7BsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlNV
fAEAxXV9aDIayDihBClIdZLbMLfdQZzYrD72JhytRdmGh/8A/0cEdRvytNJkWvX+
TovxJiPBjO3ZI1WHal4R9W1yQ5gM
=DJdI
-----END PGP SIGNATURE-----

--0576360213c6dd6bb860cad7b31ade82973e082b92a38409f0d2f00984fb--
