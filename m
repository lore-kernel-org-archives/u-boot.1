Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AD1D41C11
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 07:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FC2D88D56;
	Wed, 13 Nov 2024 08:53:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v+ZKQxBM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B84C98878A; Wed, 13 Nov 2024 08:53:47 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC91388F8E
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 08:53:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-539f6e1f756so6911599e87.0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 23:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731484425; x=1732089225; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3jsfQyQyMX0dhtuK+lwIlS8tIz1xMEvMLDBYvn+We/U=;
 b=v+ZKQxBMvP8FI9OJOwUGWRjVQzEraUSsUfE2xqZXfygOOjJWQe0/e+N2xPY38FDKLU
 VQiXAgDvtj2DE11nybj7yR3OWepwJTWlGdvz8VEko4dMXyWN1xhoWlzlWxZ/4sdNpsd+
 0K/bAOmB61UvQUdie5aaYzrUrZujoY17TG9xXtbK6zIWtS0rXqzb0tzTVLW0vo0KRtdm
 MoTmDrkFBREatmDJ9aUe2KH3Tlz7hmUD7xM+9pie4LrhI5Ed9ngjyg91yInswgP16Us8
 JnQnjbS9M4Kkc3rtm9EqnZxZbPArroCO2P02Q2Ij1fQ16Ll2b0F62BkA3UGfNr5hho5T
 J02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731484425; x=1732089225;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3jsfQyQyMX0dhtuK+lwIlS8tIz1xMEvMLDBYvn+We/U=;
 b=wyCuurzOBwWM+LZQcLD7MtKPfG576wlDcuDPLPPowkDkDUjtm5W1PB/QXoYoDCqNeI
 cWErIEuTYGZC33BMLqHzKPxlQEUCOPl1fQQE09DtryI07VMblb+xjNvagUDFe9t5je0h
 mj8podBdHrIx5fGLoXqz5TGxj2fzq8Pr6AnFLxfr6vAJ34BS/5icNI6g6yL+E0pA20cT
 /3o3JY6Smg4NiF9OigHDnWnlsrNZTGItUS/B4TCMv4c73WIc2my6JvViafmraOxUtTa/
 Ocw9ZNyQXaPniC+IwX9WsbDJAu/HuIfAfpJPLsZhxnlzDPq46z1eyBf1IZMy5ao6ovxZ
 66FA==
X-Gm-Message-State: AOJu0YzoOcjM/m2/15BgpAK6WomzNdcPrH64Sb7qsCfacaNAs31aFhv3
 KaHO7Z4TtOxHlxlx5EgxwGVK1zsAF4hrcDNraIVqxuryw5XXdh4rMt9MoOjmFQyw0qllDsTN1Iq
 UY6jROse4RE0T8JJXhrncZdMX7Ou3DQ5Xu5rPsA==
X-Google-Smtp-Source: AGHT+IHD1sENe9F/568GXI1+/lnRAbNeWOtzSnO7trhMYgREmqJ4654W2x6R1zHHgGmB7gXEeeQI0M4EUINeV/geGj4=
X-Received: by 2002:a05:651c:e08:b0:2ff:4e4b:cbe8 with SMTP id
 38308e7fff4ca-2ff4e4bcf7cmr3480441fa.6.1731484424891; Tue, 12 Nov 2024
 23:53:44 -0800 (PST)
MIME-Version: 1.0
References: <20241113062715.2872-1-dregan@broadcom.com>
 <20241113062715.2872-4-dregan@broadcom.com>
In-Reply-To: <20241113062715.2872-4-dregan@broadcom.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 13 Nov 2024 08:53:34 +0100
Message-ID: <CACRpkdad4b-twPVM5YPDrqK0OWMMOX5SK3bvD043+Yx38iou3A@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] mtd: rawnand: brcmnand: Default bcmbca
 parameter_page_big_endian to zero
To: david regan <dregan@broadcom.com>
Cc: u-boot@lists.denx.de, Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anand Gore <anand.gore@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>,
 Kursad Oney <kursad.oney@broadcom.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Kamal Dasu <kamal.dasu@broadcom.com>, Tom Rini <trini@konsulko.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, dregan@mail.com
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

On Wed, Nov 13, 2024 at 7:27=E2=80=AFAM david regan <dregan@broadcom.com> w=
rote:

> Set parameter_page_big_endian to zero for bcmbca
>
> Signed-off-by: david regan <dregan@broadcom.com>
> Reviewed-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: Anand Gore <anand.gore@broadcom.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
