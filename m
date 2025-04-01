Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB903C36008
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 05:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE85780FDA;
	Tue,  1 Apr 2025 07:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ANka8wsD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C648F817C4; Tue,  1 Apr 2025 07:26:51 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E8A480584
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 07:26:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anarsoul@gmail.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-72c09f8369cso1097549a34.3
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 22:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743485207; x=1744090007; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SAaiZ3cQ6sUDPTi2uv22KQq+AtIs3DwV17VrGotCXJ4=;
 b=ANka8wsDrP0QFQGSX7sbqhstDhSwROVf49on4qdpMw0+BkvRENTQtImNH6Kl+7be5x
 pCZ/6l1sxgSizpavIuSMAinlMRppnc333YJmyCqHvVMVOVrtSOs/ELeDhbi/tPytNKjV
 ajxVB/hIXLy46Lk5ATN40A2vyBnrUnxQZCzjYESlLrJ8ZcKdLJPPuqJs0JxLuICXN96N
 twKp+2URyQ/ZPzQ9A9kwIfBfCiP9Enocl0tYrEr7B9j8TN39PiLsYMF9+WWDLhTRmf7D
 Cfwqzc2ryGQX3K+b94m5Y5HTIiBKBHNQKvkMMuitb+iOL4ILayNHN0CNXhrQfVJfvG5l
 yI5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743485207; x=1744090007;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SAaiZ3cQ6sUDPTi2uv22KQq+AtIs3DwV17VrGotCXJ4=;
 b=O4aPs+HSJhdhgig86uUxtG23f2cwYqWox+pVPDref1AeGpERNDIyOHO6wqF19fp11j
 i917NirrFQ1GBdshHKwIgdVu4oxnCNbIG3Ah2wSbKQajXojQd1xi4IJ9qaFdZQTfC3lj
 1JrguKuHOSRHGWJR1tUV2qN4R8IYUpTVbeusR2KjmdjGvhyGTMbkinejYNUptcnPVzIh
 o1JE9omCrcnEDNmMcFHvx6Mtwbb4xlNnkdLsVGVILrqFXF1HY/u83BMphG3NDrHxH4Ej
 4ErZBhnn7UGfZY63piHIRP+H6GqKkI/5yR+N2UnFJjqsx7BlifbN9w2/o+vQkH0lgCjH
 qE9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXXgdZEFc48gsxqomOhhRAy6b8NiGYjBA2OwR0gPtApdAL4iCJspyXRz+htFD37u16dKQMgfU=@lists.denx.de
X-Gm-Message-State: AOJu0YxLFrZAjDB0AVTKR2UzAURR1xVkKus2ZGX69cKKuLJRP8FWcrPH
 YXVsEpSXdHp+wNh0aS3efueaUX1dECBxfL2D7CyVCnU8QuI8x3HWIB5CKl9zjZeWQXmsPH5aUZa
 2ZIDk6TZjfErpAsV4DCDM8qv6ryI=
X-Gm-Gg: ASbGncu7c/hIefGyvcR1uCtreJaRCHO/XLgiQ6RoCZFSgeTl1Y7ejdl0hIyLHBKQV45
 kP/LB/KNufK8HrAzxqZfdZV0KqgVXWjMxeyhpxELzyFJaFxdh6vT4EBhwWRRpLgOI30Cgy0vTTE
 p1vNnZjqOZV5fNu+4QIAxjnOj4ODG/ApExofPgBSU=
X-Google-Smtp-Source: AGHT+IEgOmERJImsBTOUZNkmZ/Hiu+KhFWeRtLK4xWXzMX5nL5uwMzzDgxairYAuhI5qTcGmerKOuEmXV6Z8O3W5ZHo=
X-Received: by 2002:a05:6830:370e:b0:727:372e:600e with SMTP id
 46e09a7af769-72c637c4a88mr7919061a34.14.1743485207168; Mon, 31 Mar 2025
 22:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250323225134.2369473-1-anarsoul@gmail.com>
 <20250323225134.2369473-2-anarsoul@gmail.com>
 <6f01aadb-9188-48e5-b4d6-2e3e2f69a04e@kwiboo.se>
In-Reply-To: <6f01aadb-9188-48e5-b4d6-2e3e2f69a04e@kwiboo.se>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Mon, 31 Mar 2025 22:26:21 -0700
X-Gm-Features: AQ5f1JoxjFzFIkOB9Hmjomf5pPcOeRMhqjZGM_TBkJjo6EujDSE7P_thZdUHcCg
Message-ID: <CA+E=qVei0CHQtvi+2m_Cr2BParHRHW3_4T97XmfexgAs8eRRsg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] video: rockchip: rk3328: filter unsupported modes
To: Jonas Karlman <jonas@kwiboo.se>
Cc: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Anatolij Gustschin <agust@denx.de>, Jagan Teki <jagan@edgeble.ai>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
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

On Sun, Mar 30, 2025 at 4:57=E2=80=AFAM Jonas Karlman <jonas@kwiboo.se> wro=
te:
>
> Hi Vasily,

> > +     /* Limit pixel clock to 297MHz. While RK3328 support higher rates=
 and it
> > +      * works in Linux, it doesn't seem to work in u-boot. That limits=
 max
> > +      * resolution to 1440p
> > +      */
> > +     return timing->pixelclock.typ <=3D 297000000;
>
> I think it make more sense to limit to the HDMI 1.4 max 340 MHz instead
> of arbitrary 297 MHz. Anything above 340 MHz will require scrambling etc
> and will not work in U-Boot unless at least dw-hdmi driver is updated.

Sure, sounds reasonable. Will do in v3.

> Regards,
> Jonas
>
> > +}
> > +
> >  static const struct dm_display_ops rk3328_hdmi_ops =3D {
> >       .read_edid =3D rk_hdmi_read_edid,
> >       .enable =3D rk3328_hdmi_enable,
> > +     .mode_valid =3D rk3328_hdmi_mode_valid,
> >  };
> >
> >  static const struct udevice_id rk3328_hdmi_ids[] =3D {
>
