Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC97C2BA18
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 04:55:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A19D884FD;
	Thu, 20 Jun 2024 06:55:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SoCTVB4r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4594F88501; Thu, 20 Jun 2024 06:55:03 +0200 (CEST)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2E54884FA
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 06:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-48da5edc11dso844775137.0
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 21:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718859299; x=1719464099; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ojez6/Abg4peSECj6/a5Hf1ZgKTpVxw+L0mCGLbkZYI=;
 b=SoCTVB4rEpydeF9wY8blqRQfi4l3nUUOHmEGgTN+QPO+21A8oIE5grCkVS84ZsLRvg
 O4foYLHHTZWqaiafslcIarh3Pkk1+gUCoQoAuo/OPhAe223XGX3sqHariKVBu2X+kVff
 zPH0xfxCKl41Ul/QlcgzDXi49Z52AUO8jHT1ALEjE5PNACdExG8arH/y672Vv83UEpyu
 VTU+wGGIXGxiM/0QQAdDz9YK63bHl6GeEUNpu+E3CKBTAJLh3OzkFsQiTLMyCDVEEuNp
 dtjHKlAqdpi/CMGY7B1HDffiYTjULuBJu6UtwWNkbZSjBKz9KxrRUw66w0xhKnidqU76
 Mgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718859299; x=1719464099;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ojez6/Abg4peSECj6/a5Hf1ZgKTpVxw+L0mCGLbkZYI=;
 b=t7yfQSdgFRZ8xiWWMPKz5rIRHjS7hdcM0yk6BtDOKeOILtJkuom/Cyi8axWdTASXVh
 IY3m53Iqcr8F7zdUYZ0FKgDkz7X43v6qYY+m1/XkhLuSznofz3FepIusR8oVAA2Xbaaz
 GT5TOgoHqDG3I81Bnu8Sjp0YfY2nlypUU0ZSdfrBLEkgjciIee0znIQObx4opvqDLktO
 /8DBXAsUnEUEe01gx4BfRJzJaI0PL8SjHE5waVqW4HqA9siaFg4nTw6aztCzAENf6Jkn
 6hM4iylGcm2CEi+FU0TZJoI9BPf+5v+OfFNzuyC3gxdjy0yL8i7pgBVH0/iyICqlrhbM
 KYTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWyxFqD9kpEMFDbVN1yDMTk92mSVbowHmc9DKzmJhQdtmEvzBpPTxdV76d9kMp28NuRkMdtG2hijN6s++46LfcGsGTgg==
X-Gm-Message-State: AOJu0YxKkGTumMHxhcTX6DCGaapE0uq1HRqrEPJj2JzNLmsTa9hg6p4j
 LN1CWQiBl45FLL+JK2A87L/P6e+qsymMmMogeozzFBTPBNn0Eda5/CI/9/Dle+kDaZeXsoCtS7Q
 aww9SR0QsVAIRDiI9r16/H97Ad5UhNU0mxSGzdA==
X-Google-Smtp-Source: AGHT+IEGS5yYqRlm76eLqm2XaSeGtk2mxdycUnUM1GHN048LqpuqAEKHTyY/UIpmSxvmgphOthXngyKObHSuPBtAMZg=
X-Received: by 2002:a67:ec94:0:b0:48d:798c:d991 with SMTP id
 ada2fe7eead31-48f02b6bf58mr5358696137.10.1718859299413; Wed, 19 Jun 2024
 21:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240619125310.94867-1-sumit.garg@linaro.org>
 <CAHCN7xK_39QTqRqjvmmnPQyx2atxw7ThoQYu5MB9LbHdeELfBg@mail.gmail.com>
 <CAFA6WYMJi-nVCEE7QoptHVURKpF-QoSh5XqSN14LrFSS5FAKrw@mail.gmail.com>
 <CAOf5uwmy6WsOTCD+mWfjLTrCBO=i8MqGm+mOe6jr+RfyXssjrw@mail.gmail.com>
In-Reply-To: <CAOf5uwmy6WsOTCD+mWfjLTrCBO=i8MqGm+mOe6jr+RfyXssjrw@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 20 Jun 2024 10:24:48 +0530
Message-ID: <CAFA6WYNcCu0FdpEN6_z3TmDqHSRnozQuUEwxZ6mWTOgdfSPd1w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: imx: Drop redundant imports with dts/upstream
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Adam Ford <aford173@gmail.com>, u-boot@lists.denx.de, 
 patrick.barsanti@amarulasolutions.com, trini@konsulko.com, festevam@denx.de, 
 peng.fan@nxp.com, sebastien.szymanski@armadeus.com, sjg@chromium.org, 
 xypron.glpk@gmx.de, marek.vasut+renesas@mailbox.org, afd@ti.com, bb@ti.com
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

On Wed, 19 Jun 2024 at 18:51, Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi
>
> On Wed, Jun 19, 2024 at 3:07=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > On Wed, 19 Jun 2024 at 18:26, Adam Ford <aford173@gmail.com> wrote:
> > >
> > > On Wed, Jun 19, 2024 at 7:53=E2=80=AFAM Sumit Garg <sumit.garg@linaro=
.org> wrote:
> > > >
> > > > Drop redundant header imports with dts/upstream already providing
> > > > updated headers which have been checked to be backwards compatibili=
ty.
> > > >
> > > > The imx headers which aren't present in dts/upstream are as follows=
:
> > > >
> > > > - include/dt-bindings/clock/imxrt1020-clock.h
> > > > - include/dt-bindings/clock/imx8qm-clock.h
> > > > - include/dt-bindings/clock/imxrt1170-clock.h
> > > > - include/dt-bindings/clock/imx8qxp-clock.h
> > > > - include/dt-bindings/memory/imxrt-sdram.h
> > > > - include/dt-bindings/pinctrl/pads-imx8qxp.h
> > > > - include/dt-bindings/pinctrl/pads-imx8qm.h
> > > > - include/dt-bindings/soc/imx8_pd.h
> > > > - include/dt-bindings/soc/imx_rsrc.h
> > > >
> > > > hence these aren't dropped yet but there was an unused header:
> > > >
> > > > - include/dt-bindings/pinctrl/pins-imx8mq.h
> > > >
> > > > which has been dropped as well. There shouldn't be any funtional im=
pact
> > > > with this change but it rather allows iMX platforms to use upstream
> > > > dt-bindings headers in a backwards compatible manner.
> > >
> > > Will this have any impact on board with -u-boot.dtsi files that might
> > > reference these files or will they point to the upstream path?
> > >
> >
> > No it won't have any impact on existing boards, the headers would
> > rather just be included from dts/upstream/include/dt-bindings/
> > instead. The DT files would just be including headers the same way as
> > before: #include <dt-bindings/foo/bar.h>. The world build is ongoing
> > here [1] which should be able to justify it.
> >
> > [1] https://github.com/u-boot/u-boot/pull/587
> >
>
> They will point to the upstream part but the fact it's that you can
> test only that they compile ;).

Majority of the headers removed have been compared to be identical and
the rest headers have been checked to be DT ABI compatible with
upstream counterparts. IMHO, that should be enough to believe the
correctness of this patch. If you would like to manually review them
or give this patch a try on a real iMX device then please feel free to
do that.

-Sumit
