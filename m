Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC264C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 16:39:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DE0888A68;
	Wed, 17 Jul 2024 18:39:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N6gr7Sf1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0690D88A5D; Wed, 17 Jul 2024 18:39:09 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E555988A28
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 18:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4266b1f1b21so49588905e9.1
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 09:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721234346; x=1721839146;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=qJD3f0ldfvybB3Z7bkmxDEvMK7cR3r2vdnEhXfYQziU=;
 b=N6gr7Sf1MJQ44rKo+bNy6dkx9pNJNLfTiknEw8C0wNPDOXutWZscJ26ky644icndCe
 V4T/5CS2s5pQLGs1dcgUfh1fc8DYLh6C68bC4P/7FnpJbSuiTuI3hLtT75BrPGX+wPmZ
 Xa3JUwjb0eiAofmkX4HpS4AO0WUdUyzIRvnvQu7zMtLMeXS3a1c12Tz+oIFVx1ZQDvCu
 5br7r9EPTqi3iit6+M/9ZFYzlwFlFsVJkc9AL4CoizOOvFUwIeq9QAHqe8TAWQsDz51m
 tWW0YPq5XN0y0BXtT8TaumEijeWFJi90vsOr145bSSRJY0AeGmdHMXhgQWdwfYkpjMYH
 b7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721234346; x=1721839146;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qJD3f0ldfvybB3Z7bkmxDEvMK7cR3r2vdnEhXfYQziU=;
 b=FoYLEtYP6l3coDSb88oHumF33mXHB7e+8SjIRHAJCqurCrHWCMrxjDptX9FPuCsk71
 EEUMK7Qf5iBrUPDFfQnhKWQsSTmvVqm1q/Tka7WBckQTDQOywEoHd4f/N3MiR/hjJOp3
 gwlMT/KMd8VKWAapM7R4bpyPFmd6F45wgZHXHoYUGkPwl7/6iCgTaTbu9JSUje6K3WZt
 ArWtrr5r0yfrAdDEgAkze2Eq+mnHlDvyy3M5JResopbVMDg1uUrchrTUUmElh/CASxr+
 k1k7vuZ4+Fv2Dp5oDbRn+er/FelQigR4jO4P7wf7vZ1t7zGUk1NjDraXxYwxei2XtrVR
 CowQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoGQczwWbxXu8FpB2bzUgmVuMS3BH7GN0mSXmgGa32kscybkH2JyR0zW+usWLefsFRqn2oDRRIxrxPuluySrAdgyylzw==
X-Gm-Message-State: AOJu0YxkzH2SaWRIC/ci8kpGVr1hp3o0FBWEEwQpIfxVaWs4TvXq+H3c
 7j30QPtS00WAAVAeUkseC0MUNuyrWECq7SWGCvdYaPjEx/rfA/SbCGOtau5hhD0=
X-Google-Smtp-Source: AGHT+IHd+g4q7KmlvrCL6NvxP56LFl8jh/6du7I1unZL6oIRwNL5BIhJR4w3Ni8X2egUfWpdhSRnXA==
X-Received: by 2002:a05:600c:1c15:b0:426:6618:146a with SMTP id
 5b1f17b1804b1-427c2cb5702mr16485355e9.2.1721234345988; 
 Wed, 17 Jul 2024 09:39:05 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427c778e049sm4565255e9.9.2024.07.17.09.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 09:39:05 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, AKASHI
 Takahiro <akashi.tkhro@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, Anand Moon <linux.amoon@gmail.com>, Peter
 Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH] cmd: move CMD_DHCP6 options beneath CMD_DHCP6
In-Reply-To: <20240717145446.192222-1-heinrich.schuchardt@canonical.com>
References: <20240717145446.192222-1-heinrich.schuchardt@canonical.com>
Date: Wed, 17 Jul 2024 18:39:04 +0200
Message-ID: <87wmlk55xz.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Heinrich,

Thank you for the patch.

On mer., juil. 17, 2024 at 16:54, Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:

> All Kconfig options that depend on CONFIG_CMD_DHCP6 should immediately
> follow it.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  cmd/Kconfig | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 0cf0d8ad8ab..323e473cd64 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1810,6 +1810,23 @@ config CMD_DHCP6
>  	  Will perform 4-message exchange with DHCPv6 server, requesting
>  	  the minimum required options to TFTP boot. Complies with RFC 8415.
>  
> +if CMD_DHCP6
> +
> +config DHCP6_PXE_CLIENTARCH
> +	hex
> +	default 0x16 if ARM64
> +	default 0x15 if ARM
> +	default 0xFF
> +
> +config DHCP6_PXE_DHCP_OPTION
> +	bool "Request & store 'pxe_configfile' from DHCP6 server"
> +
> +config DHCP6_ENTERPRISE_ID
> +	int "Enterprise ID to send in DHCPv6 Vendor Class Option"
> +	default 0
> +
> +endif
> +
>  config BOOTP_MAY_FAIL
>  	bool "Allow for the BOOTP/DHCP server to not be found"
>  	depends on CMD_BOOTP
> @@ -1927,23 +1944,6 @@ config BOOTP_VCI_STRING
>  	default "U-Boot.arm" if ARM
>  	default "U-Boot"
>  
> -if CMD_DHCP6
> -
> -config DHCP6_PXE_CLIENTARCH
> -	hex
> -	default 0x16 if ARM64
> -	default 0x15 if ARM
> -	default 0xFF
> -
> -config DHCP6_PXE_DHCP_OPTION
> -	bool "Request & store 'pxe_configfile' from DHCP6 server"
> -
> -config DHCP6_ENTERPRISE_ID
> -	int "Enterprise ID to send in DHCPv6 Vendor Class Option"
> -	default 0
> -
> -endif
> -
>  config CMD_TFTPBOOT
>  	bool "tftpboot"
>  	default y
> -- 
> 2.45.2
