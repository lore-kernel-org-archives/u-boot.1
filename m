Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48E5ACD68EE
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 04:48:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B02F864E7;
	Tue, 10 Oct 2023 06:48:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N5glfnJW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D3BF86741; Tue, 10 Oct 2023 06:48:48 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08DED864A6
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 06:48:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-690f8e63777so1399623b3a.0
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 21:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696913324; x=1697518124; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EaDgnJfrTPGteL1pAWRDzzHCeRcedshRmSVZgJqCahI=;
 b=N5glfnJWBhbGNbNkFm6RvROR3zMDtwq6sNJtP/LCh+u+liEN4slGVQhLf6lUiqnqUj
 RvBr2p0OAQ+JeKylOi2EoyI/PECi0MIrPCXT0a7qJcmg2jxrY14kGJaVl2n+KTCOIYPH
 tMVcetoQnOi3kURTzlZZjzlw8E6bjVa8gHykJ1o5sVp1PLyKuZujirVSi0EId8LPx8i4
 8D+TTEjZ68Px4NuBJ+w+oadT9JfXh5yZoET9IvyTIV3Gc15xfF4qHHmHwaXsx03gv4Wq
 DT3qBnxYRzlgjIGj7YrBX6jeKvLbJ3egCUzpXt5yd3qp1Mnxfcst9uo3EGKxHrrxy8RF
 MYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696913324; x=1697518124;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EaDgnJfrTPGteL1pAWRDzzHCeRcedshRmSVZgJqCahI=;
 b=L6/LPGUv/UEc6eA9NBcU5yR4C9Kj78uEl3zhrIIKJf+J5Dw/sSvF5fE+WmzFjArkYt
 DcqFGoXeT6L36/YHEHkhKkCYcAyuxPI2oYdHaxpzChYEkyrZgRJtN+gL/J1/oeEEu8iG
 LdS86sApElQva23+X90tgbSAY8b7u3eQRJTsQBgMbQr7XL7Nj2Jz+nBYgMu65vp4q2So
 t0aFLECebxBv/np5wxhVgfDa+AiyTHs+IA4h0h8YVqO8NqbsoQL5fan2qEZn0ES8zCYC
 AX42XDfMM4xslVufmZHcGogYljeoO6RS5GR5pmb8ssixJ1n/jHmBBDxxCJPat/90YTsn
 NBcA==
X-Gm-Message-State: AOJu0Yxc8YZPU8OQLz8uNNsGsd40LZlH04SE5+LBFyX4DDUzV6noDwSq
 9k7ygtnKUE0KdirYzEntgNBFLA==
X-Google-Smtp-Source: AGHT+IEb+3OQNPpSMcPkKL3WeJ25K5Y/OSYpEv3vm4/9gZlEest/ebrJ/Ce7uIDxAbm8STsLqjXt8Q==
X-Received: by 2002:a17:902:e80a:b0:1c4:1e65:1e5e with SMTP id
 u10-20020a170902e80a00b001c41e651e5emr19562985plg.0.1696913324053; 
 Mon, 09 Oct 2023 21:48:44 -0700 (PDT)
Received: from octopus ([2400:4050:c3e1:100:d26f:f61a:9867:e809])
 by smtp.gmail.com with ESMTPSA id
 g22-20020a1709029f9600b001c61e628e9dsm10540495plq.77.2023.10.09.21.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 21:48:43 -0700 (PDT)
Date: Tue, 10 Oct 2023 13:48:40 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 22/27] efi: Depend on CMDLINE for efi_loader
Message-ID: <ZSTXqCGTzGx6WT7y@octopus>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Tom Rini <trini@konsulko.com>
References: <20231007231255.277623-1-sjg@chromium.org>
 <20231007231255.277623-23-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007231255.277623-23-sjg@chromium.org>
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

Hi Simon,

On Sat, Oct 07, 2023 at 05:12:41PM -0600, Simon Glass wrote:
> This features currently requires the command line, so make this
> explicit. Future work could adjust this, but it needs effort within
> the booting support first, like the bootm command.

I a bit doubt this dependency.
EFI_LOADER as library functions doesn't rely on command line support.
What does is, as you mentioned, "bootefi bootmgr" command.
So a more appropriate dependency would be

CMD_BOOTEFI_BOOTMGR
    depends on CMDLINE

CMD_BOOTEFI
    depends on CMDLINE

CMD_EFICONFIG
    depends on CMD_BOOTEFI_BOOTMGR

# CMD_EFIDEBUG can compile without CMD_BOOTEFI_BOOTMGR.

# In my opinion, CMD_BOOTEFI_BOOTMGR should be split into cmd part
  and library part.

-Takahiro Akashi

> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  lib/efi_loader/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 621ed5e5b0fb..2aef9336034e 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -12,6 +12,7 @@ config EFI_LOADER
>  	depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
>  	depends on BLK
>  	depends on !EFI_APP
> +	depends on CMDLINE
>  	default y if !ARM || SYS_CPU = armv7 || SYS_CPU = armv8
>  	select CHARSET
>  	# We need to send DM events, dynamically, in the EFI block driver
> -- 
> 2.42.0.609.gbb76f46606-goog
> 
