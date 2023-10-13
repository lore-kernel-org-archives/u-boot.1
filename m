Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C96CDB483
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 08:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7517F86AE6;
	Fri, 13 Oct 2023 10:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O9vghNh+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E251686B0A; Fri, 13 Oct 2023 10:49:29 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1726A866AA
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 10:49:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rickchen36@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2c503da4fd6so9330451fa.1
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 01:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697186961; x=1697791761; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4lROs3AgDTnNKvODgZPQLx41XSYvs2Q8qVrSoUQNfwk=;
 b=O9vghNh+umsZq3m+f7hXd3k9W7DnWPmFz5cZdAhT+fJ8pUWFSzPFoazgrK6eSwUf6d
 +5C99ng1vmuFYS7sSUQdWGkPTggtlYgk8dXeCaJCxCEooYRp891WYbN2ZMWz3gaySyAE
 an+IEsae/uMJLN+4Ikc4GoZF/EoPYBeIpds7+FY4CBXHyrmEH+fnNFkh9GWC9R9UzSIa
 fE+9mKrpilDkv5b+hBPQKwVbsJorN4sWIVJTHfLOfonAVwpip/j7kn0871g2zPHv6Jq4
 XBH2J2cgpAiHW4zOuJboRPeVwvlpPlK2P7Nw3Y182N1Dj3KG4yly6ElETXzyaph/WXvF
 JbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186961; x=1697791761;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4lROs3AgDTnNKvODgZPQLx41XSYvs2Q8qVrSoUQNfwk=;
 b=FLwHh08njCrt9ss1Qum/VFvswDMBmRSqxdimnskodG+82E2MDVziy5UFaVVv7EpByL
 IXATnb8xJiIBeksdpuxkJ9rOaX1Juv6j5YZDRdzQ2wUAEnSsNP/fQIC3gJZZSC5rgIsB
 AYtE3lTDDfiUPcuXKJAdyiLNeAaFdJkJMdV5gYYd50T41loduZoNzk31TjMQTbVqjjzw
 k9nxkI+lH2sXLSJ23OJuDk4cbgiPwlHIpvyYnw9V9X0T3N4UUqEp8qmDr7+kFdkMSjF4
 W2bRHAi8GtR9FxhyyXti7nvOT+6FiP6+2rEeigV0ARdKXSsH3ID7/hIZHfh4NJ7Be3iN
 /pzg==
X-Gm-Message-State: AOJu0YwwZ70nnW8Mc3iRYAPkEdXb8utpddXGgfIo7GEefdm9aXHkwiqD
 JE7PI0QjEvUeUeQZZ8U/jm+677iyxi8mdzr0UEI=
X-Google-Smtp-Source: AGHT+IH9g9eoyH7Mzdu3YIDHbsBLQkg+ZvW5VcrIXnjMv2IAL0OR51UWMtbb+UXefHzsQwq7m9VwC08OWu61kTQbQSQ=
X-Received: by 2002:a2e:7c15:0:b0:2b6:e2e4:7d9a with SMTP id
 x21-20020a2e7c15000000b002b6e2e47d9amr24052359ljc.38.1697186961057; Fri, 13
 Oct 2023 01:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231001054047.9054-1-heinrich.schuchardt@canonical.com>
 <SEZPR03MB80649515AA09011889497B5EC1D2A@SEZPR03MB8064.apcprd03.prod.outlook.com>
In-Reply-To: <SEZPR03MB80649515AA09011889497B5EC1D2A@SEZPR03MB8064.apcprd03.prod.outlook.com>
From: Rick Chen <rickchen36@gmail.com>
Date: Fri, 13 Oct 2023 16:49:09 +0800
Message-ID: <CAN5B=eLPDJ=ae7CS1h-ioYNHwmcic_S82e0AOAXpyeE-Ez9uhA@mail.gmail.com>
Subject: Re: [PATCH 1/1] configs: sifive: enable poweroff command on Unmatched
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Green Wan <green.wan@sifive.com>, rick <rick@andestech.com>, 
 Leo Liang <ycliang@andestech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

> From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Sent: Sunday, October 01, 2023 1:41 PM
> To: Paul Walmsley <paul.walmsley@sifive.com>; Green Wan <green.wan@sifive=
.com>
> Cc: Rick Jian-Zhi Chen(=E9=99=B3=E5=BB=BA=E5=BF=97) <rick@andestech.com>;=
 Leo Yu-Chi Liang(=E6=A2=81=E8=82=B2=E9=BD=8A) <ycliang@andestech.com>; u-b=
oot@lists.denx.de; Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Subject: [PATCH 1/1] configs: sifive: enable poweroff command on Unmatche=
d
>
> Powering off the SiFive HiFive Unmatched board is supported both via the =
SBI and GPIO sysreset drivers. See device-tree entry
>
>     compatible =3D "gpio-poweroff".
>
> Enable the poweroff command.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  configs/sifive_unmatched_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Rick Chen <rick@andestech.com>
