Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EF6C8303F
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 12:15:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEADA832C8;
	Thu, 28 Aug 2025 14:15:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d0O/+d88";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D8B8832DD; Thu, 28 Aug 2025 14:15:50 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B78783192
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 14:15:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-55f4969c95aso932545e87.0
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 05:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756383347; x=1756988147; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gtduvF+nF/9JuCuYb8gCUCarmAixOGNo1huLyqyIUfE=;
 b=d0O/+d88kcr/5j1DPzGtiIonjptrHBrTcJZIwopZOdh/SkRTjg+INCplSlfaD961Cc
 ZpFX/8AqFuWXR6OjwO1SUaK5vsFk0RdvX71WP7ROEcHJxZTJjiDr8ZxZb6atZPkdjKU0
 7i3Oq0g8RBblYJ1L7l6yU9jKfKtwrDY7ojx9qb6yzoozZ1stX+dJ4wI9Oza9zDfhkQ/L
 fjOQvP3f6JyZDYfk7IbhEuJxVmCnonyg+wi4R+fOakcjSk2HKJti0v3Wpmo8YGw05y5z
 4+aqmACulFUPh5oTPEohteEXxxCLkjJ05OIKKnvOL+sFGZDI3rJVo6la0O5CubpZ6V2a
 ZkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756383347; x=1756988147;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gtduvF+nF/9JuCuYb8gCUCarmAixOGNo1huLyqyIUfE=;
 b=fed2Roq5J1ih75LfMmjezC33yq7gn/sbBGgrqBdZyPuBzdvlt5TuZm92iSb1y6Z5UO
 CxmlfhBj+IsTN+epoPq2w3S/30+bPmCOvIXSa9YMQkBw5hgzgdG/L6LP7sgsabNEDBc7
 iW1mJ68kg3QjFu8al6eQu8//SXINwtcHoR8HugfOjWxqPHMvGIjjT3J4nor8ERG52G2c
 9pZVUMcQPHLP7rBg/MmUX33c2BahbyuAd5RZFFFsFcHaQ/6UXDtqce6trk6vuGEa04pX
 yMy4kXmXJHwLyLWIoQclqbtmQYSsHkLvVwMMheVnV6sjVOF61FiqYI3Hb1VPumg7SXwH
 09Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuxElPy1kWTjRmW7vk29D/vpIhIKyRRIx7m41Qg0hmPbbmcUB/WQtIIR0a/bvNnc6FuktP5bE=@lists.denx.de
X-Gm-Message-State: AOJu0YyqoXU/IBV6dpXq2s9DidXtIqnY/hae8snMt+kXeVU1IeTEX+i4
 p2KtLCooxcCkXpDPRsAYoeILfvHX+9aFVXEUKS1MKaF/XHtGrWmP6GG8zDyBme0tgWXo5DkdwDY
 6ao5NPQ0Pt8U54NooVTwILkahTo7eyTRN15lo
X-Gm-Gg: ASbGncuUvJLGBDlXFvPTliIulYI43nS516ViRmctRU7JuwovZXYuQVglm4Kj9GTwds+
 wMYT4XFChE0eHigy6SJ9In8RVU4v1p0Lx/yQ15TXSQIALP5ZMgHwoN8UgUJBB7o2tLDoqu1S6IK
 vgx27V2ienbKhFJEMVQZlr//60CzzquaZMtl/IrAT5oxtuoRtycQjMy2tY6CENbac1w9s+hMzoA
 hYUYvMMbvtOShpxsQVs2UHloIfCa9uz5JQlBqM0WUGd49NhFw==
X-Google-Smtp-Source: AGHT+IHcTTbbrZ5PuIuVktJVgVUpluVyWT+7JBmRwEh7Zs5IfQmQ+/iZ5i7OQb8J7ad8XKumUhgIwMGUO2hnDqoD5rU=
X-Received: by 2002:a05:6512:4004:b0:55f:5b65:a3e3 with SMTP id
 2adb3069b0e04-55f5b65a4efmr879881e87.35.1756383347018; Thu, 28 Aug 2025
 05:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250822-imx8mp-libra-fpsc-v3-1-50ba9cd2d474@phytec.de>
 <2437d9efbf0121ef177f20b084ad19b54a0312f3.camel@phytec.de>
In-Reply-To: <2437d9efbf0121ef177f20b084ad19b54a0312f3.camel@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 28 Aug 2025 09:15:34 -0300
X-Gm-Features: Ac12FXwk__ywFyI2WDNMkdN01vKnBephmIRuqckWDTz3daExZeJx_T3v17BPmvM
Message-ID: <CAOMZO5Br+s7HA9e+AXY6qgEhn5RvDkDVEv5xgO4w=cgH+4gZ=A@mail.gmail.com>
Subject: Re: [PATCH v3] Add imx8mp-libra-fpsc board
To: Teresa Remmet <t.remmet@phytec.de>
Cc: "sbabic@nabladev.com" <sbabic@nabladev.com>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>, 
 Yannic Moog <y.moog@phytec.de>, "trini@konsulko.com" <trini@konsulko.com>, 
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 Wadim Egorov <w.egorov@phytec.de>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Benjamin Hahn <b.hahn@phytec.de>
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

Hi Teresa,

On Tue, Aug 26, 2025 at 9:19=E2=80=AFAM Teresa Remmet <t.remmet@phytec.de> =
wrote:

> > +
> > +/* ddr timing config params */
> > +struct dram_timing_info dram_timing =3D {
> > +       .ddrc_cfg =3D ddr_ddrc_cfg,
> > +       .ddrc_cfg_num =3D ARRAY_SIZE(ddr_ddrc_cfg),
> > +       .ddrphy_cfg =3D ddr_ddrphy_cfg,
> > +       .ddrphy_cfg_num =3D ARRAY_SIZE(ddr_ddrphy_cfg),
> > +       .fsp_msg =3D ddr_dram_fsp_msg,
> > +       .fsp_msg_num =3D ARRAY_SIZE(ddr_dram_fsp_msg),
> > +       .ddrphy_trained_csr =3D ddr_ddrphy_trained_csr,
> > +       .ddrphy_trained_csr_num =3D ARRAY_SIZE(ddr_ddrphy_trained_csr),
> > +       .ddrphy_pie =3D ddr_phy_pie,
> > +       .ddrphy_pie_num =3D ARRAY_SIZE(ddr_phy_pie),
> > +       .fsp_table =3D { 4000, },
> > +};
> > +
>
> please remove the empty line at EOF.

Yes, this causes a warning while applying this patch.

> > +Build U-Boot
> > +^^^^^^^^^^^^
> > +
> > +.. code-block:: bash
> > +
> > +   $ make flash.bin
>
> looks like this should be removed.

Correct.

> Teresa
>
>
> > +   $ make -j $(nproc) \
> > +          CROSS_COMPILE=3Daarch64-linux-gnu- \
> > +          imx8mp-libra-fpsc_defconfig \
> > +          flash.bin

There is no need to pass "flash.bin"

After running:

make  imx8mp-libra-fpsc_defconfig
make

The flash.bin will be generated automatically.

I'll wait for v4. Thanks
