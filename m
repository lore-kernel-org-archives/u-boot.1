Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70839C47258
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 02:52:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF23E87C1D;
	Mon, 29 Jan 2024 03:52:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V3oAR5jr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 414E0879CC; Mon, 29 Jan 2024 03:52:20 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D269C87C1D
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 03:52:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d722740622so4436625ad.0
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 18:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706496735; x=1707101535; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LD8ZT5Y7Q67G3URSplFaW1bF5nZqudAy8Wr5hx+yD3E=;
 b=V3oAR5jrGHwNGDtV+nHYZRocqYxcWjjRdQjPawlpQl1h6lMikGVyU35BpnbHTZS7Jc
 fRtVI6vlwR0iaoapg6aUXyRDX4kkMtkXkEU5H6/JNSkFkZ7IBBlx9yoj4tN++n3ubkJe
 WmoVKJQRLMBxWbZWHkjsjI5JhxznXlGrfb4dzbG9AY0BuXxTP+W+9pMsys8AERFfOSFS
 cJiG05rA7iRkwDnWTuhAy/Sj57nfSRKmP+Ah/A7mxnQnm3q05SWUW6M3jL2NMLKH7LI/
 HsBwmZkNRgQnTpamnCIu7GH9q/j9cohAqeLlbxCzYyOOW/X2W9gz7vtFHt8zFgodSC63
 HcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706496735; x=1707101535;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LD8ZT5Y7Q67G3URSplFaW1bF5nZqudAy8Wr5hx+yD3E=;
 b=cTi+xPtgCf7j7El31BV2OtrkIAUmiTwvemD08k0AkQECAK/igknv3HVm5D3oWeCe8f
 LjlwNRCwGDe0MMB5UNIegZzuVyh2OKomy9Hh7Hyqi7O8+EvDaqBKYadgZqm2gbdPJJ1m
 5HKK9gtSkvMOHO3hiOKbshUEsjuestX7h3XmA2w4f7iyT8FyhFhFU5TwbkFEDEaPbUit
 /NEjcHCfD+u1FNrsbi+27o6hGNv4jAjRYUL7f1ZQirGrxl5ln1c84czmc0cDWAXGK0Fu
 TaG3LmAvjJC8uztU3tOrPytyOLF/shg4yuLls9PvsOuqv6HgXwPyi9mwVTEk/AeK9tbX
 1woQ==
X-Gm-Message-State: AOJu0YyKqLShjaRO64sF2U5Na4GJmPsP8iC91XLfkmiOUr5mwbPE3pdM
 wdhXsjLkz2w3Cur4jkd09yuDgvYbOT6bkOMiAyUCyAPjbWdN/xMMM3yLqPRck/Fn7ZqCo40lfjB
 FBx3uRmBriwicPFCAJGav7lEzd7V7/FF4k6k=
X-Google-Smtp-Source: AGHT+IG0jLk+tdjaZsuC62F4vcptBZHphRqPSSl4xdia+bh8wh3Ge+jgKa2No8TO3+L/yv3w21Q985N4BT4ojF3yW40=
X-Received: by 2002:a05:6a21:183:b0:19c:9c10:fa27 with SMTP id
 le3-20020a056a21018300b0019c9c10fa27mr7658306pzb.4.1706496735116; Sun, 28 Jan
 2024 18:52:15 -0800 (PST)
MIME-Version: 1.0
References: <20240128214335.120280-1-Mr.Bossman075@gmail.com>
In-Reply-To: <20240128214335.120280-1-Mr.Bossman075@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 28 Jan 2024 23:52:04 -0300
Message-ID: <CAOMZO5Am__FUZw3O0_JTV+1ATf12pgboutxNOxykc2Higsjw+Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] imx: imxrt1050-evk: Add support for SPI flash
 booting
To: Jesse Taube <mr.bossman075@gmail.com>
Cc: u-boot@lists.denx.de, 
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
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

Hi Jesse,

On Sun, Jan 28, 2024 at 6:43=E2=80=AFPM Jesse Taube <mr.bossman075@gmail.co=
m> wrote:
>
> This add some macros to change addresses to use flexspi.

This sentence is not very clear.

> This commit adds support for booting the imxrt1050-evk from spi.

Please don't use 'This commit adds support' format.

Use imperative mood instead: "Add support...."

> It adds imximage config and the ability for SPL to boot from NOR.
>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
>  arch/arm/dts/imxrt1050-evk-u-boot.dtsi        |  31 ++++++
>  arch/arm/mach-imx/imxrt/Kconfig               |   1 +
>  .../freescale/imxrt1050-evk/imximage-nor.cfg  |  41 +++++++
>  board/freescale/imxrt1050-evk/imximage.cfg    |  10 +-
>  board/freescale/imxrt1050-evk/imxrt1050-evk.c |   7 +-
>  configs/imxrt1050-evk_defconfig               |   8 +-
>  configs/imxrt1050-evk_fspi_defconfig          | 100 ++++++++++++++++++

Please add configs/imxrt1050-evk_fspi_defconfig into
board/freescale/imxrt1050-evk/MAINTAINERS.
