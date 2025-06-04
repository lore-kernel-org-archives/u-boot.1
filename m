Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61485C5B549
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 12:32:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 864FD800D7;
	Wed,  4 Jun 2025 14:32:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oJwkCChs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42C9D803DF; Wed,  4 Jun 2025 14:32:00 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A585E80050
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 14:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikko.rapeli@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-32abd926858so24247161fa.2
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 05:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749040316; x=1749645116; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3Nc1cRZLMag0Ju5NwtUeWMhT6Grtor2A+m7KdOaENuc=;
 b=oJwkCChswbZmVYs/HgfQcdTFNAXWotFoixnEHOL1tuSAz97X8abobMg3wZdSJPIzhB
 YTCkPdENYiNBK5E746LLEJ5UOW4eCbMiMTNDF5NNaTn2njvp+LYW/LsXu+dkrWwMs5fA
 NbSeXEt9PbWFyrnlrNBu+1urk87Hxt/cEwV0Ito5ScP63IS2y5DCPu+f2pgJXCgCl1Ot
 DsJ97LWoPJfLge+/yWSWFLsu0jLJJ+9Dlx+kpb4wyQPsOafu+WzFkgMitz+ZvWzFEv9P
 Urm7QGdc1nJ0Z9aUoeZ4iq0BqrX72rbgq166TI8JrOqaAUp92fzqQkPBvtnY1kpC7FDS
 UEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749040316; x=1749645116;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Nc1cRZLMag0Ju5NwtUeWMhT6Grtor2A+m7KdOaENuc=;
 b=Xu8zW0QAuIzL9+Sii28BYJ7Hu3wPTl6RTwjONxzARMvB3Os2Y2osTfsYZl0oSclRJj
 8lZhKiOoigl5ZVKNvem+xURiIXyU9BIpwLZNnlBrbo/XYupKVneb4SNnQemDWRbRxpxu
 LvFeq0/EVtKnry5/Diu1/mxAnEYSlI3XxunB/Z9d91H/rzZmNeuj5ClYYSzocSRYlxCK
 fka9N3BCoG9yO7dHiPx86rrN3jkPhCYetRZSyisnf6qJkyCStAcE2Uf873lGBHr4X/qT
 /A6DewsZLRPwxuL9ii1KzhI7P9COObFtnSTC9sMeVnAHLHNM0gkEo7k56+f+lcJcZRl+
 1+Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6d+5U1Pju8UENjM189qO4XNXquOxQOGiZon/1KsjaU3tVYaG7GDNvYMgw1Xi1WmP0nld/uWA=@lists.denx.de
X-Gm-Message-State: AOJu0YzpbI/DxDRHEvHCyElMTpL6ESt/Wlw+fO87vxjqZ8Vi04LzOZef
 aCaws5kLp9kBR5CYy+ke6yp9OUHUg6CmLD91WihYm0d0CyW7j8DnQRT92Zet7xbhGH0=
X-Gm-Gg: ASbGnctcHY2YDnWYtjGDNIQQb8lf28bDxD2+Y+e3UXhF2IMLcLK0NU6kes8ihsyr562
 JbAmL8HquUiPK/Ox1FelIKi7qlG9GWV3+rOlBtnCUspaUSyKFJU0k/z99dQvicZ6mieYpTNVBoV
 mSBbhuyxaAfPcbjx9UdN5xGdIUHMUDYqlCI8VNQ3CwDgTf42XK7SDhOcxEhGxJJPXjn115/EC/b
 FV/fJOpLRSIyctx5/yrLyrp34EvP0pFfA4PbuJcu1mZOYxpmjLmLK5pQNW9W8xISqg4tvQgDT5r
 xeyDFYTfE8akZnxWJkIce2JoYlmjAsdGY51BHUjtwAJ2GcrXdDBaQ5h+Ypuwsb6x7/iY0Q9slI5
 n3/b5
X-Google-Smtp-Source: AGHT+IFPFkyIxlOE0NRztLatOIPYLVnMk9vh+e01bngjkVOyokpUC55hXC7DmoODs36VWMiMC3tcpA==
X-Received: by 2002:a05:651c:30cc:b0:327:eb55:a7fe with SMTP id
 38308e7fff4ca-32ac795a86emr7051791fa.20.1749040315864; 
 Wed, 04 Jun 2025 05:31:55 -0700 (PDT)
Received: from nuoska (2001-14ba-48e-3a00--193.rev.dnainternet.fi.
 [2001:14ba:48e:3a00::193]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-32a85b1a86csm22001851fa.12.2025.06.04.05.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 05:31:55 -0700 (PDT)
Date: Wed, 4 Jun 2025 15:31:53 +0300
From: Mikko Rapeli <mikko.rapeli@linaro.org>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: forbidden405@outlook.com, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] arm: armv7: fix a bug that prevents CONFIG_BLOBLIST
 and CONFIG_POSITION_INDEPENDENT to be enabled together
Message-ID: <aEA8uXoptzUQ03Xc@nuoska>
References: <20250531-pie_blob_fix-v1-0-7b4a37987dbc@outlook.com>
 <b80d6fe8-d477-430b-bf21-eb7662541c28@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b80d6fe8-d477-430b-bf21-eb7662541c28@cherry.de>
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

Hi,

On Mon, Jun 02, 2025 at 12:37:10PM +0200, Quentin Schulz wrote:
> +Cc Mikko Rapeli who's attempting to patch this in OpenEmbedded-Core
> 
> On 5/31/25 3:10 PM, Yang Xiwen via B4 Relay wrote:
> > [You don't often get email from devnull+forbidden405.outlook.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > This patchset also enables CONFIG_POSITION_INDEPENDENT for qemu boards
> > to avoid similar issues to happen again in the future.
> > 
> > Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> > ---
> > Yang Xiwen (2):
> >        arm: armv7: restore section to .text after saved_args
> >        arm: qemu: Add imply CONFIG_POSITION_INDEPENDENT
> > 
> >   arch/arm/Kconfig           | 1 +
> >   arch/arm/cpu/armv7/start.S | 2 ++
> >   2 files changed, 3 insertions(+)
> > ---
> > base-commit: 93905ab6e7564089f5d7b703b660464d675e5ab0
> > change-id: 20250529-pie_blob_fix-a61229c8fcc6

I tried adding this series and similar armv8 change to u-boot master
branch at commit fdc0dcbb2c84c4c but this does not fix the boot hang
with qemu kvm. Patch applied was:

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 79f60eb3f349..6ff3f2750ea8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1091,6 +1091,7 @@ config ARCH_QEMU
        imply USB_XHCI_PCI
        imply USB_KEYBOARD
        imply CMD_USB
+       imply POSITION_INDEPENDENT
 
 config ARCH_RENESAS
        bool "Renesas ARM SoCs"
diff --git a/arch/arm/cpu/armv7/start.S b/arch/arm/cpu/armv7/start.S
index 959251957de4..833486817f84 100644
--- a/arch/arm/cpu/armv7/start.S
+++ b/arch/arm/cpu/armv7/start.S
@@ -182,6 +182,8 @@ saved_args:
        .word 0
        .endr
 END(saved_args)
+
+       .section .text
 #endif
 
 #ifdef CONFIG_ARMV7_LPAE
diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
index 829a620faeb6..1d0b59889e78 100644
--- a/arch/arm/cpu/armv8/start.S
+++ b/arch/arm/cpu/armv8/start.S
@@ -409,4 +409,6 @@ saved_args:
        .dword 0
        .endr
 END(saved_args)
+
+       .section .text
 #endif


Cheers,

-Mikko
