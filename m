Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E2AC48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 12:14:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E31E988013;
	Wed, 21 Feb 2024 13:14:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="krc/aRIV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D3EB87E01; Wed, 21 Feb 2024 13:14:38 +0100 (CET)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 860EA87F67
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 13:14:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-7d6275d7d4dso3453825241.2
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 04:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708517672; x=1709122472; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0tEmk4cUevclgLpyTwTGslna9UZ0B+DxCzvVADCAJlE=;
 b=krc/aRIVh03/tczZoAayw3Oskmdu6OsFF9UHLVpuAAoEpWSkQgOC7/LZR+N3Jycww1
 dbqFtkcd21jWtQiagc+qM1a/2tGRSHihmdmcvpYezypgLnx27dbhxSdHvRw0/ZQm5c9D
 wdz4bYYgflge+d9F8/mf2c1BDHGYkymWjbV3wCcUEiu0zv28JvxJ1aTgeI0TN1z/LkkQ
 9Qm5AjbIN89ngJA6qq0WHpOHO27oQopGyq9sSuj6i+Owl5JbCD3zqHAq3NDd5lDBp5fX
 egDgjmokTFZo++sJEcLRapY+4dIxHR/fWLd+yQPf8QQStBZANnDGp4zyQfGjLQ36UNgY
 0QZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708517672; x=1709122472;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0tEmk4cUevclgLpyTwTGslna9UZ0B+DxCzvVADCAJlE=;
 b=HZbaXluaciJM2kjrH4X1FQYfC5XEls9lwzg/QKAg2k+Oafz7Fg6kx0yG3cEaluYG2f
 cPLdJwbzvASHNhDwt/Z061z+6d2wxtCPzOVQ2mzBdflPs7vvFTqNYVVW4NPEZs676l4e
 6IV8/00dA3OV8Ei3eoiDZJyNx6nmQMZGCLufe+PVgbIP3z9rJbm1qD99vwGcmJyt2N7Y
 bbgzBnYWv3OJNesBijR5be8tpWpLFc/YU+ES6L0SZszWY2e1SBCeJBKCaE4f+PQdWMN7
 ZiDdwlNdBma+yUxthAB3uZNYcVutncSEZqxiUtG9QklaXebq5pOvaiaHi7Xi5jL/K0YL
 P19Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc5kR6q6HFKt0YnnxTjVUgASeEMKQE2Ct0iZ2q2dH0GKZghVMcX0R4IDyTSxMl25t+BPpPjEkOrjfF3RjIYE4Xg0+f0Q==
X-Gm-Message-State: AOJu0YxkK3k1B3zUX0QcnSEWFxLR5laEmGG/mHm7x/L4oKyeSNJc/i+q
 HhMg7ETTRxY2t0mLGg2Q2/wW0pioTwxmq8cdUyYNnf2X4vf0fAR6t2pEzGBrjZ8SEZr1mPXtbmn
 /RfZii5joLl154BEEsuWXawvxpd4JbjFt3YBtog==
X-Google-Smtp-Source: AGHT+IG3eZ575dfIfGEhzjcnUmZ88J1j6zNzLbEGqER4iL1yhhKTDxOqfbFmhs6WdH+nqUo00LZf64CBUUT9J8IeijQ=
X-Received: by 2002:a67:f60f:0:b0:46d:30b0:af9f with SMTP id
 k15-20020a67f60f000000b0046d30b0af9fmr15352317vso.9.1708517671761; Wed, 21
 Feb 2024 04:14:31 -0800 (PST)
MIME-Version: 1.0
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-8-sumit.garg@linaro.org>
 <20240221075516.GA5131@francesco-nb>
 <79590f1e-d90c-4d42-9633-7fb9cee17228@denx.de>
In-Reply-To: <79590f1e-d90c-4d42-9633-7fb9cee17228@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 21 Feb 2024 17:44:20 +0530
Message-ID: <CAFA6WYMqbrDTgmt1Fv5t7xOMwtO3OpN-w4b_PZwJX3CgqYf3RQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] verdin-imx8mp_defconfig: Enable PCIe/NVMe support
To: Marek Vasut <marex@denx.de>
Cc: Francesco Dolcini <francesco@dolcini.it>, u-boot@lists.denx.de,
 marcel.ziswiler@toradex.com, 
 trini@konsulko.com, lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, 
 festevam@denx.de, andrejs.cainikovs@toradex.com, sjg@chromium.org, 
 peng.fan@nxp.com, aford173@gmail.com, ilias.apalodimas@linaro.org, 
 sahaj.sarup@linaro.org, fathi.boudra@linaro.org, remi.duraffort@linaro.org, 
 daniel.thompson@linaro.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 21 Feb 2024 at 16:11, Marek Vasut <marex@denx.de> wrote:
>
> On 2/21/24 08:55, Francesco Dolcini wrote:
> > Hello Sumit,
> >
> > On Tue, Feb 20, 2024 at 06:40:56PM +0530, Sumit Garg wrote:
> >> Also, enable reset driver which is a prerequisite for PCIe support.
> >>
> >> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >> ---
> >>   configs/verdin-imx8mp_defconfig | 9 +++++++++
> >>   1 file changed, 9 insertions(+)
> >>
> >> diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
> >> index 22b8a334dfa..d8bd644322b 100644
> >> --- a/configs/verdin-imx8mp_defconfig
> >> +++ b/configs/verdin-imx8mp_defconfig
> >> @@ -185,3 +185,12 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
> >>   CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
> >>   CONFIG_IMX_WATCHDOG=y
> >>   CONFIG_HEXDUMP=y
> >> +CONFIG_DM_RESET=y
> >> +CONFIG_RESET_IMX=y
> >> +CONFIG_PCI=y
> >> +CONFIG_PCIE_DW_IMX8=y
> >> +CONFIG_PHY_IMX8M_PCIE=y
> >> +CONFIG_CMD_PCI=y
> >> +CONFIG_NVME=y
> >> +CONFIG_NVME_PCI=y
> >> +CONFIG_CMD_NVME=y
> >
> > This will increase the u-boot proper size and marginally increase the
> > boot time (because of a bigger binary to be read from the eMMC).
> >
> > Apart of that do you expect any other impact on those changes? SPL
> > binary size should not be affected, correct?
> >
> > Asking this out loudly to confirm that nothing unexpected is going to
> > happen because of these changes.
> >
> > For my curiosity, care to share what's the use case? Do you plan to have
> > the OS stored into an NVME device?
>
> Boot OS images from NVMe is useful if eMMC size no longer cuts it
> (because debug symbols or to collect logs over long periods of time).

Yeah especially if one wants to run a fully fledged Linux distro image.

-Sumit
