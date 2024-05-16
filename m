Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2628EC25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 12:10:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64FCD87FF0;
	Thu, 16 May 2024 14:10:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XDKhSVVR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF70387FF0; Thu, 16 May 2024 14:10:33 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5350F87FA7
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 14:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6f0ef6bee72so54171a34.0
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 05:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715861429; x=1716466229; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ekDMBWUi6SQQXQganpdwgbyJ1jrgAB49LYDyQjqULg=;
 b=XDKhSVVRMPtqQ44oza2iqbvEvp8wc7+1ZCeLCfxi+EMKOdtztcQTXWiuWECsYJUs+o
 m6CLK6stbXGZV/h7wXXkQZdjoqRZa5dmuetJ+GnE+cHRBvwRoNNld9nBlHfXQKJ8eBJQ
 GAfybQqYyLhlbA24YpEXanCQ65et5mL5s0WkHVXs8n109+UYjkwtf+CzbMtP//trOgJV
 koLKUrKcHCJcJZjtGe6FslkqKR9sNSbWzz7Alo9CAILFOA2K4tR+XT+v2vqjAMjsOYid
 AXWV8CqY01sQ7dVxE+peWOETRPPlJMtfTm0fM2c7zY1u1bn8eW0rvOnuhPM8L00V0G9H
 mkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715861429; x=1716466229;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ekDMBWUi6SQQXQganpdwgbyJ1jrgAB49LYDyQjqULg=;
 b=EBdIDKZAdKGBGkjHTpawnoaGQTJ7E2qhpAysmPkSJOLZ8Kk0WSpayZJLDB7ydM8iEK
 xwlnPVssuVIJfPt1VVb09QIgEHGVZ4qVGJbC9nxgvWEjDWycfBmGPjei1QLrbdiemr/7
 GjW63E10nCal/seKSe/X8ZEmUydVGUEobnSrdiRT3wMGTxTWDsI6sMBF+p7V4cxwFttl
 bQw+ijRB5Q+XKWk/Uy8y00mU61u8a8Zju7WTKZUUA903fjmH7d41Dea75qgmkNIi33GW
 T1W/qPEXC0p+jvIJcWKeUcAV4rqYncCt8lkjqVrl1Y2y1xkmvhs2ZcuWeXsHDCuuHrzT
 gBBQ==
X-Gm-Message-State: AOJu0Yy3gXUOcICR/PMy7VqQPr493sTNa9pEl8nKKQr3194JBroCkv6m
 xot8Q41VxNGwImhy3OOwoCKlQrKBrJ8ci+qyGuY2mehL88CzMpxb5ldj1U5tsFuW+RP6E0uVmOY
 ZQT0iTMWT3b5FzkMGlcaW2HkMioG6anjpUdDbiw==
X-Google-Smtp-Source: AGHT+IEWt+pyVcy1XYvOzoqrUN/C+sKYjge/seaWrHJsuWnWSub1hELWrTW3lgjopF4tOOPboy7EoyhqQjhyuM/e+wo=
X-Received: by 2002:a05:6808:253:b0:3c8:6dad:cad8 with SMTP id
 5614622812f47-3c997057154mr19772432b6e.21.1715861429027; Thu, 16 May 2024
 05:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240513-boston-v1-0-fac96938417e@flygoat.com>
 <20240513-boston-v1-12-fac96938417e@flygoat.com>
 <CAFA6WYPapa8PUqOQ-wJRkD4bOfX+2eBCk_5voamQB-XbAhhBcg@mail.gmail.com>
 <0d2fd774-7f63-4b3b-abea-6dda6a9159cd@app.fastmail.com>
In-Reply-To: <0d2fd774-7f63-4b3b-abea-6dda6a9159cd@app.fastmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 16 May 2024 17:40:17 +0530
Message-ID: <CAFA6WYP_hrZ2g4i4kiOdnk_BkXkn_Cg7bD1_2a18T3GsC3rBaA@mail.gmail.com>
Subject: Re: [PATCH 12/13] MIPS: boston: Migrate to OF_UPSTREAM
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>, 
 Tom Rini <trini@konsulko.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 "paulburton@kernel.org" <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
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

On Thu, 16 May 2024 at 17:29, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
>
>
> =E5=9C=A82024=E5=B9=B45=E6=9C=8814=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8A=
=E5=8D=886:45=EF=BC=8CSumit Garg=E5=86=99=E9=81=93=EF=BC=9A
> > Hi Jiaxun,
> >
> [...]
> >> @@ -0,0 +1,10 @@
> >> +// SPDX-License-Identifier: GPL-2.0+
> >> +
> >> +&plat_regs {
> >> +       compatible =3D "img,boston-platform-regs", "syscon", "simple-m=
fd";
> >> +       bootph-all;
> >> +};
> >> +
> >> +&clk_boston {
> >> +       bootph-all;
> >> +};
> >
> > You can try to push these overrides to upstream DTS as well, so you
> > won't have to maintain them in U-Boot.
>
> Hi Sumit,
>
> Thanks for your comments! For the compatible override, I already sent
> patch to upstream. However, I have a question, Can we really do bootph-al=
l
> in linux upstream?

Yes.

>
> I don't think it's documented in upstream dt bindings.
>

It has been documented as part of core schema DT bindings here [1].

[1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/=
bootph.yaml

-Sumit
