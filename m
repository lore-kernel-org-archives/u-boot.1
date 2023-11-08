Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E344BC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 04:29:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8BA98776A;
	Wed,  8 Nov 2023 05:27:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d2roWTXI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 676C98774F; Wed,  8 Nov 2023 05:27:29 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6596C8770B
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 05:27:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-da077db5145so6404626276.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 20:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699417646; x=1700022446; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f8KihiseLkyTZ7pcPMylsECHDnIkHSKpbvkpTAp+3cg=;
 b=d2roWTXIqWrFLljbb1YmewrvOBhmgdWsyPHwQSu296kD8XDcfyD2iPcEqHK+EJLUY6
 hZNxui8cI4l+vpDjx/buFejftbDiWEUfsbY+3NeScGwtAndbm6LufYncM1rybWTpJDLc
 vRplaUHM+bwtdTtxCknHlGcJ5unUQeQGvhAkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699417646; x=1700022446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f8KihiseLkyTZ7pcPMylsECHDnIkHSKpbvkpTAp+3cg=;
 b=CgESRgMWgoz1LaedAB9sikdJjbYq59rzIhR8HfvxLbgETbX0AI9yViFTLk1k7xZf6U
 oreR0Qf1A/OwEfnfS710YQQNdX8CJjd/PjYf58pzOqVYMtvXAnAxswt1IU/F1y/7WfE/
 R3MLPkrijXSg03Jb2CC4Gmk2C1cOv5hatJxQYncQpKsk46p6C8lxqnUPDpvlit8kTRg5
 U/xkow+OyVDXQ2CrJZ1C7eNYTaVbzEnSqEn2P5BXeRfSP2AjIj52LF6KWcbiw7niVHul
 OibW9+NRrBH4/zJWpullmfpN6NjMemkuiDUbyTI3e9uTTXzljFvQEeUjyzyvSVGzWBOz
 3gsA==
X-Gm-Message-State: AOJu0Yy2Vginli+RVYleTWv79YNKF48eHON4GYYvbCTxm1UG2Rg9tRRZ
 bv+AfNmYdYIV9c6uZu3UtCALa4G3fgcIybcmwgZI5w==
X-Google-Smtp-Source: AGHT+IHNaKyjBM6dX6lV0yh3uHL9+XKRaHxx75Y2Yt0xpboC4sdLna57FnpTuCO4oo5v1qa7nZpuZm8Zajdsv7UWHD8=
X-Received: by 2002:a25:c78e:0:b0:da0:cf4b:c504 with SMTP id
 w136-20020a25c78e000000b00da0cf4bc504mr790761ybe.8.1699417645992; Tue, 07 Nov
 2023 20:27:25 -0800 (PST)
MIME-Version: 1.0
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-6-seanga2@gmail.com>
In-Reply-To: <20231106022603.3405551-6-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 21:23:39 -0700
Message-ID: <CAPnjgZ1efoJtQCZPO1Nb0u_B5fS6nhH=8k8AcS0Ank3pQe+JpA@mail.gmail.com>
Subject: Re: [PATCH v6 05/25] spl: Remove NULL assignments in spl_load_info
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>, 
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
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

Hi Sean,

On Sun, 5 Nov 2023 at 19:26, Sean Anderson <seanga2@gmail.com> wrote:
>
> Remove NULL assignments to fields in spl_load_info when .load doesn't
> reference these fields. This can result in more efficient code. filename
> must stay even if it is unused, since load_simple_fit uses it.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> Changes in v6:
> - New
>
>  arch/arm/mach-sunxi/spl_spi_sunxi.c | 2 --
>  common/spl/spl_fat.c                | 1 -
>  common/spl/spl_mmc.c                | 2 --
>  common/spl/spl_nand.c               | 4 ----
>  common/spl/spl_spi.c                | 2 --
>  common/spl/spl_ymodem.c             | 1 -
>  6 files changed, 12 deletions(-)

This makes me wonder if we should have a function to clear it out
(using memset() and perhaps a bl_len parameter)? Having said that, the
info-field use is pretty self-contained with these files.

Reviewed-by: Simon Glass <sjg@chromium.org>
