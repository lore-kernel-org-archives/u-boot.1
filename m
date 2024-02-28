Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C74C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 28 Feb 2024 16:37:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6A3D88071;
	Wed, 28 Feb 2024 17:37:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks-com.20230601.gappssmtp.com header.i=@gateworks-com.20230601.gappssmtp.com header.b="mVfvLx6w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65AE288087; Wed, 28 Feb 2024 17:37:12 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E74C588071
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 17:37:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-565c6cf4819so1806683a12.1
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 08:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks-com.20230601.gappssmtp.com; s=20230601; t=1709138227; x=1709743027;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jqekX5PAeuteGLX92Ual9K+UARXZa/iT81CZOmR+YEo=;
 b=mVfvLx6wBSgQQFk4V9gIdSKysSwRnEKLwe5vP0y8J609SfvzzflMh1ysnSSzrkGE9p
 aecilFftE2Hnt9fjaPZUTHAKnvGSZm1zh4MBNm36orGqHjK6eZEJsiGrA7p/tKBYtt+3
 6JESIjZM/b5IzGoygdodHEGqAlLN+LJNCQJkFdfusoyBLi3IkB/cHGKXjXQqpYaD3Tso
 CkZHljW48X3Ar3s9q91yrngy5kuRFYbYxFor360fApWWwvMtMufjSoNimIQfxeSNYu1c
 Nenm0oCK66EQDBdtBZLBZwwxNEtA/TTYHIdAF/hrRxBX8vnZvdvuASfVmi0kuxiTyJqt
 U6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709138227; x=1709743027;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jqekX5PAeuteGLX92Ual9K+UARXZa/iT81CZOmR+YEo=;
 b=FZQDlDrXQPBZEPeGvB1kGZlBkRmdy5+9uRm3kLDhOzocb5PKGkHBNX8crvNMu0CcGm
 /JBdu9tw0DB1ouuUG6bHdvRICtHZaPQbDGFScmtAKdjtlZyMI2meMDS/qarM5z4owHFt
 SemGt8tpznWewbejRE66BxzudHDbs9g7iv/IA9+PnB7iwixNvdOYVhF81COZ6um+NM2j
 CA4IJ214kO6BS3NHFA3SJ7yns5KDYbMmvwZo7fbsAZ9YfsKh/bv3Wg4hOs+JnrTHzjfG
 97/NLMCo4Csx9+G+pWpvMtej0DX3P18rR1f+HellR/yBT2GrfmQudHdEGLSFUHEHmWsI
 XpxQ==
X-Gm-Message-State: AOJu0YyTrnm1yRT03/BvaFOxv4Mdg3iRBKcc3Paz9N/qYCKxfXtPLKZS
 7s0GX2CJR2Xkp7DZgN8mgjGqNtIb0A+yiTLaHlJbXC8JHsdmISqttVQn9fOy8GMUfThMfnuT4IC
 GNsRbN5OESZnaXthqV//ZQ/i3bwxmPzVfm5U2Yxq0ro5kYozI
X-Google-Smtp-Source: AGHT+IES+kk+BV+lMZkGo1NcMeglByxBLorNbheILJcwph5KHLHEr92zXqUVaIbgBIrGAwNs5f4nN6k3G5oVwsebUjE=
X-Received: by 2002:a17:906:370a:b0:a44:b96:2811 with SMTP id
 d10-20020a170906370a00b00a440b962811mr1348862ejc.29.1709138227065; Wed, 28
 Feb 2024 08:37:07 -0800 (PST)
MIME-Version: 1.0
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-7-sumit.garg@linaro.org>
 <CAHCN7xLBk4KnNMx3ofaHxb+KJOUA9Y4Sh+drpAymg3=F8gdA1w@mail.gmail.com>
In-Reply-To: <CAHCN7xLBk4KnNMx3ofaHxb+KJOUA9Y4Sh+drpAymg3=F8gdA1w@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 28 Feb 2024 08:36:55 -0800
Message-ID: <CAJ+vNU1KXPUiMP1kqfSvtviosSQLgKGdjhz=ab0j3g4CtmpRvQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] pci: Add DW PCIe controller support for iMX8MP SoC
To: Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, marcel.ziswiler@toradex.com, francesco@dolcini.it, 
 trini@konsulko.com, lukma@denx.de, seanga2@gmail.com,
 jh80.chung@samsung.com, 
 festevam@denx.de, andrejs.cainikovs@toradex.com, sjg@chromium.org, 
 peng.fan@nxp.com, marex@denx.de, ilias.apalodimas@linaro.org, 
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org, remi.duraffort@linaro.org, 
 daniel.thompson@linaro.org, Adam Ford <aford173@gmail.com>
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

On Tue, Feb 27, 2024 at 3:19=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
>
> On Mon, Feb 26, 2024 at 2:05=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > pcie_imx doesn't seem to share any useful code for iMX8 SoC and it is
> > tied to quite old port of pcie_designware driver from Linux which
> > suffices only iMX6 specific needs.
> >
> > But currently we have the common DWC specific bits which alligns pretty
> > well with DW PCIe controller on iMX8MP SoC. So lets reuse those common
> > bits instead as a new driver for iMX8 SoCs. It should be fairly easy to
> > add support for other iMX8 variants to this driver.
> >
> > iMX8MP SoC also comes up with standalone PCIe PHY support, so hence we
> > can reuse the generic PHY infrastructure to power on PCIe PHY.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  drivers/pci/Kconfig       |   8 +
> >  drivers/pci/Makefile      |   1 +
> >  drivers/pci/pcie_dw_imx.c | 314 ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 323 insertions(+)
> >  create mode 100644 drivers/pci/pcie_dw_imx.c
> >
> > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > index 463ec47eb92d..7edbf35004a9 100644
> > --- a/drivers/pci/Kconfig
> > +++ b/drivers/pci/Kconfig
> > @@ -413,4 +413,12 @@ config PCIE_STARFIVE_JH7110
> >           Say Y here if you want to enable PLDA XpressRich PCIe control=
ler
> >           support on StarFive JH7110 SoC.
> >
> > +config PCIE_DW_IMX
> > +       bool "i.MX DW PCIe controller support"
> > +       depends on ARCH_IMX8M
>
> I think this also needs to depend on REGMAP to prevent build errors.
>

Sumit,

both REGMAP and SYSCON are needed to build.

Best Regards,

Tim
