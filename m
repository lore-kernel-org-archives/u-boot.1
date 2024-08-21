Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6DDCC52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 12:34:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE1C488B4C;
	Wed, 21 Aug 2024 14:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sgKfF021";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C021388B3F; Wed, 21 Aug 2024 14:34:19 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9449A88B52
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 14:34:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-371aa511609so2753685f8f.1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 05:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1724243656; x=1724848456;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=96F55ty9vb5l1HmMWn+gXdPhUG3yDmmorDxsCiVRWJo=;
 b=sgKfF021y7xLsaQZoMOkJdTfuwvKb6xNQYdt+kPIQ6iy9KRuxJuBhD7chG03Hnx3Jh
 saNTb76onMsH3izf1DifGFZfwhm7anc7cCTbfcaqaq/+vpw59TG+rslsEhQ5jqB4Nad+
 +M1AbH1td/DSSYln8qX9fElDJSM7SxXGo6bLZxSY3838StMzDRZfNK+o6P/cu/TOzp7B
 WBvnCp6ndQAphHDbEtaLs89Wpw+Rz8tibF0YwMZ54vcY0OLQY++dn6L6MwhgRW0Ew0I2
 fz904cFM+aUZ+fGG0q6EP4zRCOGc/DRWAgUt3HYG+LMMZ3kSaEy1hrKL2bLuvFkpIjOh
 3zTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724243656; x=1724848456;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=96F55ty9vb5l1HmMWn+gXdPhUG3yDmmorDxsCiVRWJo=;
 b=s6uS8/+ey/mChUBsNkTdmgLptuqicXBkNioTdw9VO4xiN9p/tCPPlWMcBwbFXjBx2n
 pB8EzdZEjRNSK+rA+5jFF2tHVXX99xsRBFlT1K33OUAystLGJfLj8qH6cH3O80nabWEM
 GzsHw+G7F2NNWf0OyH4EzblsbAl1Xc9QXQZJAiS0UGAsMtg423CFKy4B0F0kBwMLCsmV
 zN3HyYH5MjpSj+h2pM/0t9KCLuKFCQr7hK0UO90h4UqSm4uQKjVH9WFm8j8bEHcRMin6
 0i2UdzW4tkW7YcqGHpn3WvJgNblC7NOAC4Jp6bgAHT8cFsjtt3USxlBi5a8646DgNyLr
 qLMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAoglVAJi2cLI90jX4ME4yodc/y5z7PBr6EVtR3cDQYxL91z4adi2JH2REB3nRfTPVQlh99II=@lists.denx.de
X-Gm-Message-State: AOJu0YwfKfxISK/A0W7lkedKlIqHdAQm6rC9ORYIBCFeoAbzZuATdQKm
 itBwmf3q5G89xF8+0kpzXN7sqwMW+/CpT1Pm88uX36UOzgU7wbLn9ryD/fdISSU=
X-Google-Smtp-Source: AGHT+IEN/EA+LncrnMgx0OaNQci7lZ1tXSIpBI+umjx4zUQpW34Gg2JiA9cQsi8s7TMq9JPxI+MbXg==
X-Received: by 2002:adf:e0d0:0:b0:368:319c:9a77 with SMTP id
 ffacd0b85a97d-372fd6f13f6mr1417114f8f.29.1724243655468; 
 Wed, 21 Aug 2024 05:34:15 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898ab855sm15582271f8f.105.2024.08.21.05.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 05:34:14 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, Caleb Connolly <caleb.connolly@linaro.org>,
 Zixun LI <admin@hifiphile.com>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] usb: gadget: ether: Handle gadget driver registration
 in start and stop
In-Reply-To: <c6d9d714-c44c-4d97-bbea-66dc2f410b60@denx.de>
References: <20240726083102.380719-1-admin@hifiphile.com>
 <172301272563.244852.18199647448023901472.b4-ty@baylibre.com>
 <87le0ruqcj.fsf@baylibre.com>
 <d280f437-c873-47b7-8ff9-ebd42da7e572@linaro.org>
 <c6d9d714-c44c-4d97-bbea-66dc2f410b60@denx.de>
Date: Wed, 21 Aug 2024 14:34:13 +0200
Message-ID: <87r0aicawq.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On mar., ao=C3=BBt 20, 2024 at 19:12, Marek Vasut <marex@denx.de> wrote:

> On 8/20/24 7:11 PM, Caleb Connolly wrote:
>>=20
>>> Instead, to enable usb ethernet, we should manually bind the UDC driver
>>> to the usb_ether gadget.
>>>
>>> For example, on Khadas VIM3 board, this can be done with:
>>>
>>> =3D> bind /soc/usb@ffe09000/usb@ff400000 usb_ether
>>=20
>> It would be great if this could be done like ums where the UDC index is=
=20
>> given rather than having to figure out the magic DT path incantation :D
>>=20
>> =3D> ums 0 scsi 0,1,2,3,4,5

Agreed, but we don't want to have one U-Boot command per gadget function.

>
> Yeah ... I wonder if we want an 'udc' command ?

This seems like a nice idea. I will give it some more thoughts and look
into prototyping something.
