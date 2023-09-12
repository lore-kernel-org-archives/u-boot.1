Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BD8CA0EC3
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 12:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B769286C5E;
	Tue, 12 Sep 2023 14:08:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TxH7nzUE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EF4686E2B; Tue, 12 Sep 2023 14:08:40 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AFA286AF6
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 14:08:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3ff1c397405so64605785e9.3
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 05:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1694520517; x=1695125317;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=f1lspVSu/Dn9vH0LFOirqUosKoOZpyPLtR6naQGLS30=;
 b=TxH7nzUEkmSCuiFcx92hEh/H8I1EKJpV2ULFMvFaFH63su5rQwdcCr61/GbObvvH23
 dVlQBDczFQOdbINcyqwmHcldsLXjD1h5cUteed4HLXME3wwyukFHypopqzwtAW+/OxqP
 hjnqjCWv92atvHLE1uzn03zdqKTgmNVBkjQ8aXWKWYwioLkFI8fP+iGLLTpvx9KCo60q
 ti84xMJoO3zNV4vCNiFEK+CVsxapXHHRpe34XUz3v/45UIPWHqD/EgGQuubjMwdBAMQE
 6kLS6JBVWiOrqjnrE93JuYzlb+wtOn+evoUeFz/aqxGdpMt2EpHP+8DW5IudKzi/atET
 +/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694520517; x=1695125317;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f1lspVSu/Dn9vH0LFOirqUosKoOZpyPLtR6naQGLS30=;
 b=UgmrmIIusOXXVFoX6rFdWtDIg60PSnje1nHkQ5GZA7IyaPr60La8wxa2fzdi39GVzv
 7AYi4G9XU01OEgpa0/b9SjPakB9SVxxbxs0CI85zIWootKqn1e2ujS1gTJlsHZzVZ8uG
 k6uvVRgcd2c1WwfWd3HkJmHJfDpZcFPsRZzFLk82CFrCnuxxzX3blFe2egV6ie5QYkxM
 h04dNd9f5gN7rDSN5ij0xDP3/xhE1c/wr3DEMjpyRVbpsAQPbvXlrppmUG3xSdOUvP0M
 V0WpJdfiZ2zqZkxQ6hsg5D3BrfxWvaHgwLzb0SJvVlj3tyJUNFcPcGFbZQObYWU4MAPY
 TKyw==
X-Gm-Message-State: AOJu0Yx2zVQalessGsUF8kBMwcik9rJJ5WiGH5j/SmrbP8Dgr3kxuTSD
 4P7icG71Nw7x3Mi8pmhtMHi3Tw==
X-Google-Smtp-Source: AGHT+IHtt5iXTW51jIb0yjNXt+rCu07qai73yEpuzTXFpwUWmXSlFz6T3Si2BjR9Fy8/5kXHBr51oA==
X-Received: by 2002:a1c:ed08:0:b0:401:d803:6242 with SMTP id
 l8-20020a1ced08000000b00401d8036242mr10813121wmh.27.1694520516495; 
 Tue, 12 Sep 2023 05:08:36 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ay7-20020a05600c1e0700b0040303a9965asm9852538wmb.40.2023.09.12.05.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 05:08:36 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Neha Francis <n-francis@ti.com>, Tom Rini
 <trini@konsulko.com>
Cc: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Jan
 Kiszka <jan.kiszka@siemens.com>, Marcel Ziswiler <marcel@ziswiler.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/2] arm: dts: k3-pinctrl: Sync with kernel v6.6-rc1
In-Reply-To: <20230911140256.945074-2-nm@ti.com>
References: <20230911140256.945074-1-nm@ti.com>
 <20230911140256.945074-2-nm@ti.com>
Date: Tue, 12 Sep 2023 14:08:35 +0200
Message-ID: <87ttrzlhks.fsf@baylibre.com>
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

On lun., sept. 11, 2023 at 09:02, Nishanth Menon <nm@ti.com> wrote:

> Sync pinctrl header with v6.6-rc1
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  arch/arm/dts/k3-pinctrl.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/dts/k3-pinctrl.h b/arch/arm/dts/k3-pinctrl.h
> index c97548a3f42d..2a4e0e084d69 100644
> --- a/arch/arm/dts/k3-pinctrl.h
> +++ b/arch/arm/dts/k3-pinctrl.h
> @@ -11,6 +11,7 @@
>  #define PULLUDEN_SHIFT		(16)
>  #define PULLTYPESEL_SHIFT	(17)
>  #define RXACTIVE_SHIFT		(18)
> +#define DEBOUNCE_SHIFT		(11)
>  
>  #define PULL_DISABLE		(1 << PULLUDEN_SHIFT)
>  #define PULL_ENABLE		(0 << PULLUDEN_SHIFT)
> @@ -29,9 +30,20 @@
>  #define PIN_INPUT_PULLUP	(INPUT_EN | PULL_UP)
>  #define PIN_INPUT_PULLDOWN	(INPUT_EN | PULL_DOWN)
>  
> +#define PIN_DEBOUNCE_DISABLE	(0 << DEBOUNCE_SHIFT)
> +#define PIN_DEBOUNCE_CONF1	(1 << DEBOUNCE_SHIFT)
> +#define PIN_DEBOUNCE_CONF2	(2 << DEBOUNCE_SHIFT)
> +#define PIN_DEBOUNCE_CONF3	(3 << DEBOUNCE_SHIFT)
> +#define PIN_DEBOUNCE_CONF4	(4 << DEBOUNCE_SHIFT)
> +#define PIN_DEBOUNCE_CONF5	(5 << DEBOUNCE_SHIFT)
> +#define PIN_DEBOUNCE_CONF6	(6 << DEBOUNCE_SHIFT)
> +
>  #define AM62AX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
>  #define AM62AX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
>  
> +#define AM62PX_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
> +#define AM62PX_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
> +
>  #define AM62X_IOPAD(pa, val, muxmode)		(((pa) & 0x1fff)) ((val) | (muxmode))
>  #define AM62X_MCU_IOPAD(pa, val, muxmode)	(((pa) & 0x1fff)) ((val) | (muxmode))
>  
> -- 
> 2.40.0
