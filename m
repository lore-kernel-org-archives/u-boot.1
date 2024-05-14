Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD96C04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 05:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8597288229;
	Tue, 14 May 2024 07:38:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V7a8witw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E48AB88280; Tue, 14 May 2024 07:38:56 +0200 (CEST)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C894588229
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 07:38:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-47eee2af758so3302838137.1
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 22:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715665133; x=1716269933; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sMIcQDQCc1bL6rRW36WmRwGdIyIvUB1tFt8g7V/OOmA=;
 b=V7a8witwjFRx8m8FFghSFfpp+SE+zBgwtMy/96lHL8soKxKIAbmGUAxyVfJuqp4uYb
 iH5K8g/Vqxxz+jcvTbmh/6gnZyqw2mANRZfL7vNOIvWe1Xd1QGNz8l8YcvjrbAbXRl2a
 sAsZuxCfa1XqQLECecBsKFVr5RPnOQbbco5gfRnVe4ueOlyefVVmLgknkr53B1uPvRN1
 jGiH7bCcmtN4DW81NB1MnOxpQKvIcNG2xr6iAbP0bnrbxqMBHj89sVefb/ehzeCm9qm0
 fD2r/OC0Q//SLPmRgugsJRtP1mjXnSn053kv/BpkPUh3arPwWkdsXiYONzhXHH/9gxtJ
 2pTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715665133; x=1716269933;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sMIcQDQCc1bL6rRW36WmRwGdIyIvUB1tFt8g7V/OOmA=;
 b=Y1xC/i69/Q0sRI2tHlRav+u/Z5Oc1x4NXgPxDgzlsnTb5VPmfs/0uLJXg7VrK+qe1m
 uXdtYPlZZMUsen6Aj89qMgw7ek3RyOYyFwlY2Y755y5TdhCKSE0D6dTID7/LZr44rPih
 1XKsL/TKKwYVjcfhPjvslYY/QSYjPtXY3KkmJq6MF1sg+V2zw4TcyXw1V47bsYHZ/wUQ
 61NigSsAaY9SHSvdl0FneY7t6Oc0Rz2rPwuBklZSMJAPHqRR55tygA5uPMlw5wPKGiCS
 Td/+YEowvT9sz8z1p6FdXLvL5CX5M2IJ471lvHW4dyQ0e5iRpsrjh9LmDbHds5Im3obq
 ekiQ==
X-Gm-Message-State: AOJu0YwcL9IgGNENlpOmFsjFHmgTtKB9F+l+ae5dvHWiuul2o2a+VCIm
 dE4GM1I/MtmrzQk4B+4jV9Ld0fF6flQMaV9XaVQUVhWDXiLuIBr4Js7qWOM/hsfhL1/Ad5YcTHn
 jouh4U8YrkbXSViqRn9yDRfia1uitL30ticQEGg==
X-Google-Smtp-Source: AGHT+IHidPBSnUgAUC3g2j93puxQK1bLEmeuWiUaHmnIH4jbz98zO22ohY61+aRM+Ebo0gOKK03KrI7ivCxzDo7OWWM=
X-Received: by 2002:a05:6102:1914:b0:47f:2480:584d with SMTP id
 ada2fe7eead31-47faba20f99mr11464298137.6.1715665132685; Mon, 13 May 2024
 22:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240513-boston-v1-0-fac96938417e@flygoat.com>
 <20240513-boston-v1-11-fac96938417e@flygoat.com>
In-Reply-To: <20240513-boston-v1-11-fac96938417e@flygoat.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 14 May 2024 11:08:41 +0530
Message-ID: <CAFA6WYMYA7t_KHZ7z-80uBispXp1gk3+MD5LEXWEgNRrnA9hLw@mail.gmail.com>
Subject: Re: [PATCH 11/13] dts/upstream: Add Makefile for MIPS
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>, 
 Tom Rini <trini@konsulko.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Paul Burton <paulburton@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
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

Hi Jiaxun,

On Mon, 13 May 2024 at 23:43, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> It is required to make OF_UPSTREAM work.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  dts/upstream/src/mips/Makefile | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/dts/upstream/src/mips/Makefile b/dts/upstream/src/mips/Makefile
> new file mode 100644
> index 000000000000..9a8f6aa35846
> --- /dev/null
> +++ b/dts/upstream/src/mips/Makefile
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +include $(srctree)/scripts/Makefile.dts
> +
> +targets += $(dtb-y)
> +
> +# Add any required device tree compiler flags here
> +DTC_FLAGS += -a 0x8
> +
> +PHONY += dtbs
> +dtbs: $(addprefix $(obj)/, $(dtb-y))
> +       @:
> +
> +clean-files := */*.dtb */*.dtbo
>
> --
> 2.34.1
>
