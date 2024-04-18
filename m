Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7490C41513
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 15:31:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F304F88668;
	Thu, 18 Apr 2024 17:31:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="rAlkCvb3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 299B588668; Thu, 18 Apr 2024 17:31:41 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 634EF8867D
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 17:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a5544fd07easo114217566b.0
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 08:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1713454297; x=1714059097; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zDEDxx5pCwVutX6ur+5nseNWbrJeWPDip7Dh3smk16s=;
 b=rAlkCvb39zsXQvFfRG2icGl+tD4sgpe+JNFEkcwFwsT1jrPXSxMQ7t9NJHG5EqA7F2
 19tLWfLmO6jiyYorq8WhiTaKf2tD/8Ph6JXVDe2yDh6ZbH3Rnxa8oz6Q25c8d4JNTBib
 Jym8m3YgQcmIFqrJE8z6umLJkEGKeARhXg+KK5N95erF21Y876/rCDA32rIFqdlZswFf
 /AEtfhxf00GD49gqx76wU5xJuJudwP7lSnj91xi+g9P8Ov1LAVBUlckdgKNCz8p7RqXx
 WJRACO+LQ7QfKt2xmNkuXCoABOVWC0FFUv7CHgjlzQU3fb8I2XeiaoTN4E7ogmxwSEYu
 TZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713454297; x=1714059097;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zDEDxx5pCwVutX6ur+5nseNWbrJeWPDip7Dh3smk16s=;
 b=o83JxXGmbxwyMKB2j2lp4yD+Pazv4lRHW+7X2rdaqUqind/zfAwpNJSe/n1I0etW9I
 nCnwyFyqk1aaiMF7IvQR0vgx1r/HOfppSO27GbaKDCFQvlJO/aAHloXOF5U2BDQRqVaE
 ka3yIeHuZwEEWxa7j9HuOb6Fp+u5nFRCbDaRbrGEziLoyfPLhnkN82vTGzDL7/E8ZbxP
 FNMt1FbXel2mtm49p7XUyfvyseh9unG7bryeilaHZDXw5u+ylMMYbY3HBTtj1605d7GF
 Jge754SsaJOH9OHWnMNhKILx3DcrhSg+bBBhZ48WZ4aXqk3mHFXQbDEIaf4VfmPLrRtn
 /21w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUAF5VC7kpCJ3++TcdMNZ3Ov5JH4mz73Aq6CLyOt0gg7JCZA9cSPgSYgAA6bohHhzD3sP+tHNAv1vzFxKQ26t3ZFzirQ==
X-Gm-Message-State: AOJu0Yw7J850f3NHJP7SErhXoEMxLObQCiti8RrmGbtUljdaoYgRtTqe
 WuYsT+myO0xaDDhj2zlk/f0xv6vGbCDXsSGNq1K4U2AO5kS29s1deOiaglxchf4kWiCvUWSk62i
 7ns5+9bhhPg0AVU4eXWHhRwITFGsIbnxRpZ0eodx8KzCl3OrN
X-Google-Smtp-Source: AGHT+IH8MjWENaocl0qUED1IJ1ll9MYsDUhZNtk9LIfmipK/muZ3AydrPvXQOLDVwSR3HaZhNqn3WOxqi+hydGPLNsQ=
X-Received: by 2002:a17:906:fa06:b0:a52:5df2:ab4c with SMTP id
 lo6-20020a170906fa0600b00a525df2ab4cmr2034865ejb.16.1713454296925; Thu, 18
 Apr 2024 08:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240417200922.3749671-1-tharvey@gateworks.com>
 <20240417200922.3749671-2-tharvey@gateworks.com>
 <121f8e1c-4ca1-4a7b-acff-364fa64f2a6a@denx.de>
In-Reply-To: <121f8e1c-4ca1-4a7b-acff-364fa64f2a6a@denx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 18 Apr 2024 08:31:25 -0700
Message-ID: <CAJ+vNU2+hmSuYFDncX=MT_b=ATTZcULwr+kJ+1yj0pLRNFZc1w@mail.gmail.com>
Subject: Re: [PATCH 2/3] pci: dw_imx: add support for IMX8MM
To: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, Fabio Estevam <festevam@gmail.com>, 
 Martyn Welch <martyn.welch@collabora.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
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

On Wed, Apr 17, 2024 at 8:04=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 4/17/24 10:09 PM, Tim Harvey wrote:
> > Add support for the IMX8MM SoC by adding driver data with the compatibl=
e
> > string of the GPR controller.
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >   drivers/pci/pcie_dw_imx.c | 20 ++++++++++++++++++--
> >   1 file changed, 18 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/pcie_dw_imx.c b/drivers/pci/pcie_dw_imx.c
> > index a2ee228224b5..10d926c30645 100644
> > --- a/drivers/pci/pcie_dw_imx.c
> > +++ b/drivers/pci/pcie_dw_imx.c
> > @@ -45,6 +45,10 @@
> >   #define IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE_EN  BIT(10)
> >   #define IMX8M_GPR_PCIE_CLK_REQ_OVERRIDE             BIT(11)
> >
> > +struct pcie_chip_info {
> > +     const char *gpr;
> > +};
> > +
> >   struct pcie_dw_imx {
> >       /* Must be first member of the struct */
> >       struct pcie_dw                  dw;
> > @@ -54,6 +58,15 @@ struct pcie_dw_imx {
> >       struct reset_ctl                apps_reset;
> >       struct phy                      phy;
> >       struct udevice                  *vpcie;
> > +     struct pcie_chip_info           *info;
> > +};
> > +
> > +static const struct pcie_chip_info imx8mm_chip_info =3D {
> > +     .gpr =3D "fsl,imx8mm-iomuxc-gpr",
> > +};
> > +
> > +static const struct pcie_chip_info imx8mp_chip_info =3D {
> > +     .gpr =3D "fsl,imx8mp-iomuxc-gpr",
> >   };
> >
> >   static void pcie_dw_configure(struct pcie_dw_imx *priv, u32 cap_speed=
)
> > @@ -246,6 +259,8 @@ static int pcie_dw_imx_of_to_plat(struct udevice *d=
ev)
> >       ofnode gpr;
> >       int ret;
> >
> > +     priv->info =3D (void *)dev_get_driver_data(dev);
> > +
>
> Does this really have to be cached in priv ?
>
> The priv->info seems used only in this function.
>

Hi Marek,

Good point. I will remove that. Thanks for the review!

Best Regards,

Tim
