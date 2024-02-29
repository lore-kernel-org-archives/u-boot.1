Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783A8C54E4A
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 05:30:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 355EA8802E;
	Thu, 29 Feb 2024 06:30:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZFgbMUnM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD0F587A0B; Thu, 29 Feb 2024 06:30:16 +0100 (CET)
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com
 [IPv6:2607:f8b0:4864:20::92f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 013C488094
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 06:30:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-7dae66def19so193114241.0
 for <u-boot@lists.denx.de>; Wed, 28 Feb 2024 21:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709184610; x=1709789410; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SPL/7dZZv8JC/Z9GrhS6zrfn5OS2RkIop7EU64OPZ00=;
 b=ZFgbMUnM8mgvFnyJKIu5Vf2p+HMiMqxI6RhIqhWdjmLQ9fVotZtm1MESuu4GWG7mPm
 +f9OtB/O4IPhu4bk8g7QG7dao4aheKl1gEH6HzHIlqxhpW59C5QGWzc2oE2rdBep2fYz
 UXphq7ePIKHP/2lB40jsDGoqUqUNKlVA4kohKCj97Rwy26yyX3dsxMwCpgTcOo28Vij1
 We7Umfw0usZ437xozV2+exx6vvcyqAgTrFkFbGjMLDJzqVZanCOeSVI4kceownzdS3ju
 a6laasuFR0L06d4wA/+mN3MrQWDmkDXDsx0snrVYhOZub2eNL3i0kv9xuoYC4UNuLSGq
 Sy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709184610; x=1709789410;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SPL/7dZZv8JC/Z9GrhS6zrfn5OS2RkIop7EU64OPZ00=;
 b=kxYQQ3a7Z0jIDTOLAffA0qKPCJ7uYfZGnZKsvSuI+lcF8/XvFsR6OjGaZsGd1pfQJE
 tpUOZxKN69VtHRz5NQ4jpqIvNwDyTglzOFL4HraF6ux9Lf7fxD8mEqyODOhJqsKZNL0H
 KpXJiZv0PJv5vpz2gk4pn9m9L1GnFtfMOr9RmX6C+oWScTT8QLt2lRnLlxx8K0MAIVNc
 Jk/sfwDKs42gARQjgwae5O8qhhJRH2xXp5zuT3nMnUNNspH0Qal5DhRs0swgbcvB4R+5
 NrZZ0YItiiTLU9l+qj/LstaQrjMWsh+yn3YPrLbPDF1+fZ4UhYooqEgqTjm1NPwBvr9L
 fB5w==
X-Gm-Message-State: AOJu0YwhjCPIH91ZHD5H1KUASwFXoS4pL/ERdBfF6/9ZdByydC16LTMG
 thvJgjc1gQX4nKGzYSwB+napimB0lNP88uTiqqVdVLLG04RJ56VOFvXxCux6CRaGL0BjY28hW4H
 B3QHW2fapQD/39cXrp2KQepHoW8qTmD9TCpdspg==
X-Google-Smtp-Source: AGHT+IGxitJcSW0fyTzuHhVioIHkubIQQGFf8ssNXSePx9RUhKfener0dJlgdnqa+2aUyJJHRDK8i9R+4ouCs43BsvQ=
X-Received: by 2002:a05:6102:1891:b0:471:e02e:c7e6 with SMTP id
 ji17-20020a056102189100b00471e02ec7e6mr1056488vsb.10.1709184610631; Wed, 28
 Feb 2024 21:30:10 -0800 (PST)
MIME-Version: 1.0
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-7-sumit.garg@linaro.org>
 <CAHCN7xLBk4KnNMx3ofaHxb+KJOUA9Y4Sh+drpAymg3=F8gdA1w@mail.gmail.com>
 <CAJ+vNU1KXPUiMP1kqfSvtviosSQLgKGdjhz=ab0j3g4CtmpRvQ@mail.gmail.com>
In-Reply-To: <CAJ+vNU1KXPUiMP1kqfSvtviosSQLgKGdjhz=ab0j3g4CtmpRvQ@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 29 Feb 2024 10:59:59 +0530
Message-ID: <CAFA6WYN_v7_U61-hEqSY0O16RFbRV4bBhXB05qUnsn4xTVz24g@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] pci: Add DW PCIe controller support for iMX8MP SoC
To: Tim Harvey <tharvey@gateworks.com>
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

On Wed, 28 Feb 2024 at 22:07, Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Tue, Feb 27, 2024 at 3:19=E2=80=AFPM Adam Ford <aford173@gmail.com> wr=
ote:
> >
> > On Mon, Feb 26, 2024 at 2:05=E2=80=AFAM Sumit Garg <sumit.garg@linaro.o=
rg> wrote:
> > >
> > > pcie_imx doesn't seem to share any useful code for iMX8 SoC and it is
> > > tied to quite old port of pcie_designware driver from Linux which
> > > suffices only iMX6 specific needs.
> > >
> > > But currently we have the common DWC specific bits which alligns pret=
ty
> > > well with DW PCIe controller on iMX8MP SoC. So lets reuse those commo=
n
> > > bits instead as a new driver for iMX8 SoCs. It should be fairly easy =
to
> > > add support for other iMX8 variants to this driver.
> > >
> > > iMX8MP SoC also comes up with standalone PCIe PHY support, so hence w=
e
> > > can reuse the generic PHY infrastructure to power on PCIe PHY.
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  drivers/pci/Kconfig       |   8 +
> > >  drivers/pci/Makefile      |   1 +
> > >  drivers/pci/pcie_dw_imx.c | 314 ++++++++++++++++++++++++++++++++++++=
++
> > >  3 files changed, 323 insertions(+)
> > >  create mode 100644 drivers/pci/pcie_dw_imx.c
> > >
> > > diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> > > index 463ec47eb92d..7edbf35004a9 100644
> > > --- a/drivers/pci/Kconfig
> > > +++ b/drivers/pci/Kconfig
> > > @@ -413,4 +413,12 @@ config PCIE_STARFIVE_JH7110
> > >           Say Y here if you want to enable PLDA XpressRich PCIe contr=
oller
> > >           support on StarFive JH7110 SoC.
> > >
> > > +config PCIE_DW_IMX
> > > +       bool "i.MX DW PCIe controller support"
> > > +       depends on ARCH_IMX8M
> >
> > I think this also needs to depend on REGMAP to prevent build errors.
> >
>
> Sumit,
>
> both REGMAP and SYSCON are needed to build.
>

Ack.

-Sumit
