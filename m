Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3700EC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 09:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6626D87A35;
	Thu, 14 Dec 2023 10:20:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VVQtxxpw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E37DF87A3E; Thu, 14 Dec 2023 10:20:51 +0100 (CET)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com
 [IPv6:2607:f8b0:4864:20::934])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E371878ED
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 10:20:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-7cb0fdced70so1103916241.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 01:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702545648; x=1703150448; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H3HpAX6CQXGZvGX5HmnS+9SB4uxM0bBy0lkGfjCKfd0=;
 b=VVQtxxpwcXdlli3s9edFI0JGj1vd5VK7wA8Qt1d4u9NameAS0anBEM6krYrtLCc+8y
 wcO55hM/Em/ZMkOhJ5g5SMam4dFOkSe4WQvE6CECkPScqv4v2MrcKmm7VwXkGBJ488By
 /SI05gbj6g2vWGPdIyiXzeQMsdqjLDP6nMYXMBJ6qLaularjBdvflVsLexbU11Y8pQzo
 e5edGHPKFhZe/zhpjdGyy//9DaVQcxqJdAPmfnI5vtzPNsSXO/LfnrWSqdfmBtI8skpe
 jAU0KBszRwpkO8O+Of9ubEMMtM6x0iY2XHM6FuTDa+zcXv308M8LeQBWpYYSXojNMS8e
 t6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702545648; x=1703150448;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H3HpAX6CQXGZvGX5HmnS+9SB4uxM0bBy0lkGfjCKfd0=;
 b=MYlGowqWaTVHxNiGXE8A28e4UBp/eeY/x3VmSAZBiJ6wRegeUuHDD40Oexh756YKR/
 sXCIXHaHi51QKRYVzcTnoxSREQJsb41RrvxmzvBXZz0mDPsnMW6k8TGikZD+D2UglRaF
 dZm648ueDKzK7ugfE4VmbqVUnl156BtnU1Nfd3qxKmN5Jwyz2HklWwfWOWzWPJJMIfbu
 BEXPkU/QOLfc9Yox+GSMxBkuoZ5Uh0zj+Jyy8jc+oGxidiiXAs411z7y7lYOth36Je/E
 lRHzbpewI0ut78fM3CmlLyAPX+47S7nt6Kx7paV+aJENRogOTkA1wIpnT2J9SYKXfNXD
 19mA==
X-Gm-Message-State: AOJu0Yxl3WYXnzXAt4qiKm4He+YogC6WgQHmOPRwPfZ+3ycWRKMxJdbL
 hCU9zjCsbAGrsaWEUCw1XB4bza4NZVOyuabqNXCaWA==
X-Google-Smtp-Source: AGHT+IG2tlALZJcawt+mIvaIss16r3wrUe0S75NuIQ1s0aQezClu/9OErQs0jvAVI/Bk6IBlRG8XsfBOZYrFru9AIuU=
X-Received: by 2002:a05:6102:1608:b0:465:da5a:8a58 with SMTP id
 cu8-20020a056102160800b00465da5a8a58mr7970415vsb.28.1702545648237; Thu, 14
 Dec 2023 01:20:48 -0800 (PST)
MIME-Version: 1.0
References: <20231211-b4-dwc3-qcom-v1-0-46275113b4f2@linaro.org>
In-Reply-To: <20231211-b4-dwc3-qcom-v1-0-46275113b4f2@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 14 Dec 2023 14:50:37 +0530
Message-ID: <CAFA6WYMU=nefETmdVWSoyxvnYwO_0EWNHESnP=HUSg0w0ufzCA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Qualcomm quirky SMMU support
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
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

Hi Caleb,

On Tue, 12 Dec 2023 at 00:11, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Qualcomm platforms are heavily locked down, in many cases offering no
> way for users to gain EL2 or EL3 code execution and including many
> additional security features. Among these are modifications made to
> the SMMU behaviour (done by having the hypervisor intercept register
> accesses). On many platforms it is not possible to disable the SMMU,
> and not possible to configure streams in BYPASS.

I suppose SDM845 is one of those.

>
> To enable support for peripherals like USB which depend on DMA, we must
> allocate a context bank on the SMMU and configure an IDENTITY mapping.
>
> This patch series fixes support for building IOMMU without CONFIG_PCI.
>
> Then, it introduces first introduces support for a .connect() op in
> IOMMU drivers, this is called before the peripheral drivers .probe()
> function and allows for IOMMU devices to perform one-time setup.
>
> Lastly, introduce a new driver which supports the SMMU as found on
> Qualcomm platforms, when a DMA capable peripherals is probed, this
> driver will first see if the previous stage bootloader configured a
> context bank for the given stream ID already, and if not then it
> allocates and configures one so that DMA accesses will work.
>
> There are no in-tree users for this driver yet, however it is required
> for upcoming USB support on SDM845 and future Qualcomm platforms.
>

Is there any other pending stuff for USB to be supported on SDM845? If
not then you should enable USB alongside this patch-set as without a
user its hard to justify this driver merge as it is.

-Sumit

> ---
> Caleb Connolly (3):
>       iommu: fix compilation when CONFIG_PCI disabled
>       iommu: add a connect op
>       iommu: add qcom-hyp-smmu
>
>  drivers/iommu/Kconfig         |  16 ++
>  drivers/iommu/Makefile        |   1 +
>  drivers/iommu/iommu-uclass.c  |  16 +-
>  drivers/iommu/qcom-hyp-smmu.c | 396 ++++++++++++++++++++++++++++++++++++++++++
>  include/iommu.h               |   9 +
>  5 files changed, 436 insertions(+), 2 deletions(-)
> ---
> base-commit: 8806443ed784dad5b5daf351b0175acb3343e729
>
> // Caleb (they/them)
>
