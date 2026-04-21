Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E3EF8FA90
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 15:45:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19FFC83E76;
	Tue, 21 Apr 2026 17:45:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="OlShOP4+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98E9783FFA; Tue, 21 Apr 2026 17:45:35 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD63183C51
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 17:45:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7dcd689829eso952526a34.3
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 08:45:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776786331; cv=none;
 d=google.com; s=arc-20240605;
 b=EA+4gZIpkWxlZxpmdZhQmP/xsFIgNjmviei00MKP9HlpPO257zG2nxQ7dD/aiQTwE+
 J+av8QRRomKjX76rn83pBMDryK1q2VBaYIklcBUQwNeLgJfPQs2QDFwqD9mx+oUgY3ah
 UgidBskX+gjQ98toDNUGwkBPy1glFVfYwdEjlFzoZkgTyhaXo4XN4c6+BtrRX3GErGar
 MJpSUleGNz52E3i44VvNhHIEjf0bzq4Wtts5lvH5/t7A7hksepVTsz1w7P1Sb5pZy7oZ
 RC5DBhYInx4o3dmHyBd+9l48dGj5jgyuMEbowJ5tjurwPeNrRqrFsF7ujZq0tcb9GmHP
 1TPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zDKc/CJi2HVZYGDP54X1b6LgX1WDCZDpYt/zrhHelqI=;
 fh=sywm0Dt7nGVy+wCIvYl11+E/2xcivyt3wowUZqo3m2c=;
 b=CQVug1+MAJQk3FW1uQBr42tDI/658Nuvwy9BK5cPHUWtIaDqkoR7tJzCSw/fcRZqE2
 hToqKVjWXxJCLUXiRTQ8edlWrqaIOCmvf6M+9MxPmjN3Sq+1LtAsl70T1Ad7FyhI+bAw
 WD+oCebY8cekjdvX4W86FTjReNiDls3bsKz0FKmcTejHFKEl3tcG7jsg8rL0036oMzM4
 vvDy4LqM83JyXAzI8HAE3VmH5Vf5nmJdeUfFb02ue5bbXL5s9OrptWO2XU5o/laxbdP3
 yFGI76VI4zZEz49arR/mIgQsrIMrTGpB0m98Hqk0K0cHaB1iOabrC9dra4/B7vbGXdMJ
 cXFg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1776786331; x=1777391131; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zDKc/CJi2HVZYGDP54X1b6LgX1WDCZDpYt/zrhHelqI=;
 b=OlShOP4+zn+1HMjEWIt2lnfLDf0h0KywH2C+HWmyrNFCmCDPg9oSwLse0exJGld6st
 IiZSYGXxvV8UK+skP4V979eMhLUzu0YKUv/2Wn52bxYMdlP3yvoRzpuasgG8R5/l0WIq
 CbcrBCYjtxDpqQ8OUT40lVIZyxxuVLSXYtiuXAXVadAjsmmbp3bZ3yRBQNpbQ8ISxqIR
 GvCDlpgdcF6jAsZbhH8d/va9QiSGz4TqEd3i4YK5Xp1LbPQeH2Qwb+h+4xZhpAAT7462
 TG1M53oM7ob6gdAN0hiQWFnkYzU3gz+r4M9GNSAzQaP5qJyNn5qujk5E/v0uzU17Wja/
 PxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776786331; x=1777391131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zDKc/CJi2HVZYGDP54X1b6LgX1WDCZDpYt/zrhHelqI=;
 b=rEJCdjfl6NEg4l4aOAsnPqgm27kq/kZO2bHZvz5x8ywDLcoBrPMz+5dBwHtjTWzuGW
 RzIPmqFKH4YYC13O5VZa+zRktIMwT/b0iMln+byddoxqmHzGf97bW4yXT7kcVaje2xlB
 Lch9oTVB4W8600uC4BhSV9cKboeeytszlsOJ/Ml5PNB/5q7w8q7FI2yc/3VbQWg5nI68
 dyE0qfJLgYQq1Zvn2A735b4LKOwyowN/D9ShoBsQbI6/A4tdKW7d/BjICHPtkPxk2uYl
 gcxyeow7yEZmKW8o4oIIU9sLqjmFPvsBAIV+j+QlJe3Ygu0/BoJvaEejCvrzFoks0BNt
 IoNQ==
X-Gm-Message-State: AOJu0YzMHgq5bytvgsr75RVn25fqBUdj4+HsH7Q1TjYf9931gNSI5SGd
 nv3yXJ/V+iClexdgbZTKgt7lmXqG6sezg6MB1mRRRnbsSxIifSsMQT7K4v45i7xayYV2nJktP1J
 Hb4BXNShcpwwsZvrfcBdaFhomNpUgXXinhjpxgo5C+g==
X-Gm-Gg: AeBDiesxCIPi+u/6zok1SUdosFWo+rt0WA3vKXlyO2Lg61XQxVjBIyKy5YO3gOoSxVQ
 MtokVzt0fqZrKeZ7pSMw/DQH27zEcSCfEeOEio5uZUvsZYef1pCI1LgZgX5p4BZW+sCoZ+Bp/Ne
 n4Nj+D/M1jSYHrt4ZAggAgVad+ovSw7YfG5TZgk5Jkf02aV9eGxwB+gg53p+WYD8pSuUhqaEOVk
 U0gxFn2Z8c3gBRQQzpE8ruRQyL3F0tvZvM/wIJTIEd3gRBCxf6+uw7Lh7e1B0kMhz+oI5JQCKKO
 Y14O6NDSlYupAIXgnQ==
X-Received: by 2002:a05:6820:f024:b0:694:9d60:99ab with SMTP id
 006d021491bc7-6949d60a6d0mr947286eaf.6.1776786331417; Tue, 21 Apr 2026
 08:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260415-10g-v1-0-f6809a31c2b2@nxp.com>
 <20260415-10g-v1-1-f6809a31c2b2@nxp.com>
In-Reply-To: <20260415-10g-v1-1-f6809a31c2b2@nxp.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 21 Apr 2026 08:45:20 -0700
X-Gm-Features: AQROBzA0AAYYIOe-dRGL9Q95xbSqbn1XnBHuoPT6XE_5_n8Q0a8NWNaeSRuQmhg
Message-ID: <CAJ+vNU3+rN1hVZQRTHEQmi+uo5o1ak9epLL=VFqNRMGNT-iNSg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] net: phy: aquantia: Increase timeout for out of
 reset
To: alice.guo@oss.nxp.com
Cc: u-boot@lists.denx.de, Marek Vasut <marex@nabladev.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, 
 Beiyan Yun <root@infi.wang>, Bo-Cun Chen <bc-bocun.chen@mediatek.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Ye Li <ye.li@nxp.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Michael Walle <mwalle@kernel.org>, 
 Thomas Schaefer <thomas.schaefer@kontron.com>, Marek Vasut <marex@denx.de>, 
 Alice Guo <alice.guo@nxp.com>
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

On Wed, Apr 15, 2026 at 1:54=E2=80=AFAM <alice.guo@oss.nxp.com> wrote:
>
> From: Ye Li <ye.li@nxp.com>
>
> Current timeout for PHY out of reset is 50ms which is too short.
> Increase it to 2s to align with kernel.
>
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  drivers/net/phy/aquantia.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
> index 10b87dfb8ab..83da3e1cc77 100644
> --- a/drivers/net/phy/aquantia.c
> +++ b/drivers/net/phy/aquantia.c
> @@ -400,7 +400,7 @@ int aquantia_config(struct phy_device *phydev)
>         int interface =3D phydev->interface;
>         u32 val, id, rstatus, fault;
>         u32 reg_val1 =3D 0;
> -       int num_retries =3D 5;
> +       int num_retries =3D 200;
>         int usx_an =3D 0;
>
>         /*
>
> --
> 2.34.1
>

Hi Alice,

I ran into this as well on a new board I'm bringing up. I found I
needed 100 retries in my situation.

Acked-by: Tim Harvey <tharvey@gateworks.com>

Best Regards,

Tim
