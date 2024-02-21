Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7173C48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 12:13:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 533BB87FC1;
	Wed, 21 Feb 2024 13:13:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ehq3Xl9F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5B1A88024; Wed, 21 Feb 2024 13:13:05 +0100 (CET)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE1C487F67
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 13:13:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-7d2e16b552dso3749992241.1
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 04:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708517579; x=1709122379; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=43wk495WmpbJ9tfWp7yReFky47kJgB5zdRXoRrNea7k=;
 b=ehq3Xl9FFb32scXrbn3LbicJ/iWnBcJ882Xosni8UOU+BDQuHa+EZaUG+fdljbiHL4
 UbyFy5dHTyPIHT7kzbJk73PF88zpv5aI9kYdwQi0T3HBNfNDIu1YxvDXWeKeCeGE+SvT
 FeZ7DHN72phWD0zCsiYurQQ/IdwkB1dj863iIcIwdzf4EE0O0J6w0Q2HBafBRCgYTUpY
 LP8DcUe4czmcnXLLXXflCYo3YiuZxbl5jqJxTA92ZNwlx4LU+rv7bVPpbmwisQM/+bqG
 S1ADvvDILzsUkgGFoqxcJczwtUApkAM3QMnbCouz8RgfegJKG56/i9tx9dPOsjgqBSvK
 yOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708517579; x=1709122379;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=43wk495WmpbJ9tfWp7yReFky47kJgB5zdRXoRrNea7k=;
 b=hTW3LlkTjpRq0d0opaykh4k/vOeNDDzuvJAuvYqCssTg+CKbnExXe1Lg2EVN0Y6stO
 qDR3MBsjHA6LniL4Kn4vxyxMQQlI6cLMoC8YAMnmlr70+/uD8eSk5ruz8+B4cOKSibsH
 nrm3/7rDIahFSM+9yd/SNDzw4yyhNEn7iUwqJzlQusmkKxUyn5Sn2ZEH9jY4hZgDgoxV
 uKM+kHYXsgsRgCKcKNPsvachZnm5vMgRQBpIlB66u2lZEb4qoPhE8rpZxYTKmky5iuby
 Ou03qdfp9x6z44BF3ti/0JB4XtzoYNhQImiSHzPuoapROhtAjYUxwbsrIM0EyV1VDoFF
 fKlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpMezVEIDIFvcXPl+fMxcCq18IomsHZZYDTPhEgOF7ZJtRCFqWalvTJBjS9ekqYOQnhT+gq2QjUubHn3mWq5GGx/MOSA==
X-Gm-Message-State: AOJu0YwF42I3pflrgOIkY40cxGRD3hD6xYXeNuCtXRPRRrm8kmyfRw/4
 m8Tcu9bSjDC1AZzZcoWELc1VykIqRBSCIcW9umlyx014jNq2tCezBz0yVSkhSPR0leCQIaiZqG3
 ThRY3J7Z+SEZnz17/1/4XkNCpwBUV+2YHeTkUrA==
X-Google-Smtp-Source: AGHT+IH+FS4NBYuNDzSm0uqe7FwkQ+A0T04/rqqi4PLPtX+JBkA6NiCX7uoxVRzZ5dm0iiGXNB+8m6617VgDk4ymEno=
X-Received: by 2002:a05:6102:4b0:b0:470:575a:5a1f with SMTP id
 r16-20020a05610204b000b00470575a5a1fmr8173158vsa.30.1708517579263; Wed, 21
 Feb 2024 04:12:59 -0800 (PST)
MIME-Version: 1.0
References: <20240220131056.2962331-1-sumit.garg@linaro.org>
 <20240220131056.2962331-8-sumit.garg@linaro.org>
 <20240221075516.GA5131@francesco-nb>
 <fba9ba00b218a9c0c9be4958b2f08f1dee3e7a15.camel@toradex.com>
 <42f24803-8e56-46b2-a3c5-0c09dba69778@denx.de>
In-Reply-To: <42f24803-8e56-46b2-a3c5-0c09dba69778@denx.de>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 21 Feb 2024 17:42:47 +0530
Message-ID: <CAFA6WYOErpAFC4eqjtyFiMgwjsh0Wc2R3j94XEh1NoBn85hbhQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] verdin-imx8mp_defconfig: Enable PCIe/NVMe support
To: Marek Vasut <marex@denx.de>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 "francesco@dolcini.it" <francesco@dolcini.it>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>, 
 "sahaj.sarup@linaro.org" <sahaj.sarup@linaro.org>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>, 
 "remi.duraffort@linaro.org" <remi.duraffort@linaro.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "trini@konsulko.com" <trini@konsulko.com>, 
 "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
 "lukma@denx.de" <lukma@denx.de>, 
 "aford173@gmail.com" <aford173@gmail.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>, 
 "festevam@denx.de" <festevam@denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "sjg@chromium.org" <sjg@chromium.org>, 
 "fathi.boudra@linaro.org" <fathi.boudra@linaro.org>
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
> On 2/21/24 10:18, Marcel Ziswiler wrote:
> > Hi Sumit
> >
> > On Wed, 2024-02-21 at 08:55 +0100, Francesco Dolcini wrote:
> >> Hello Sumit,
> >>
> >> On Tue, Feb 20, 2024 at 06:40:56PM +0530, Sumit Garg wrote:
> >>> Also, enable reset driver which is a prerequisite for PCIe support.
> >>>
> >>> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> >>> ---
> >>>   configs/verdin-imx8mp_defconfig | 9 +++++++++
> >>>   1 file changed, 9 insertions(+)
> >>>
> >>> diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
> >>> index 22b8a334dfa..d8bd644322b 100644
> >>> --- a/configs/verdin-imx8mp_defconfig
> >>> +++ b/configs/verdin-imx8mp_defconfig
> >>> @@ -185,3 +185,12 @@ CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
> >>>   CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
> >>>   CONFIG_IMX_WATCHDOG=y
> >>>   CONFIG_HEXDUMP=y
> >>> +CONFIG_DM_RESET=y
> >>> +CONFIG_RESET_IMX=y
> >>> +CONFIG_PCI=y
> >>> +CONFIG_PCIE_DW_IMX8=y
> >>> +CONFIG_PHY_IMX8M_PCIE=y
> >>> +CONFIG_CMD_PCI=y
> >>> +CONFIG_NVME=y
> >>> +CONFIG_NVME_PCI=y
> >>> +CONFIG_CMD_NVME=y
> >>
> >> This will increase the u-boot proper size
> >
> > Yes, I checked and it is actually slightly more than 32 K.
> >
> >> and marginally increase the
> >> boot time (because of a bigger binary to be read from the eMMC).
> >
> > That was also my concern.
> >
> >> Apart of that do you expect any other impact on those changes? SPL
> >> binary size should not be affected, correct?
> >>
> >> Asking this out loudly to confirm that nothing unexpected is going to
> >> happen because of these changes.
> >
> > Other than that I actually gave it a quick try and PCIe/NVMe does indeed work and the regular boot is not
> > affected (other than the slight size and boot time increase, of course).
> >
> >> For my curiosity, care to share what's the use case? Do you plan to have
> >> the OS stored into an NVME device?
> >
> > For us the question is basically whether that use case does mandate enforcing such changes for each and every
> > customer. Plus the regular expected maintenance effort any such change brings with it, of course.
>
> You can always enable this support on MX8MP EVK, it has M2 slot and this
> would add build coverage of this code too, without impacting Verdin.

I would have chosen that as the base platform to enable but
unfortunately I don't have that at my desk. However, if someone is
willing to test this patch-set on MX8MP EVK then I am happy to extend
corresponding defconfig too.

-Sumit
