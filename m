Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CB1CFD316
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 10:26:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C04E892CD;
	Fri, 11 Oct 2024 12:26:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Bx+qBrT5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B03CA892CE; Fri, 11 Oct 2024 12:26:48 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7440B886DF
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:26:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2e18856feb4so1767272a91.3
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 03:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728642405; x=1729247205; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yWUCdI5kIAajkfGYwCueSqNwJp0vHA+e4Fr+/bH4Bho=;
 b=Bx+qBrT5GrF7DmkaI0oudULtgVrf+SFYns5Vu4BY1SU9gFBrYsJPQhu3PaXw/ggeDm
 dLfQcowrURI3FuzGN5z8d6KE8tjrU51Eb1Ds/ZbsHpS62rgiEZNd7J4y8t5a0zwxVp1b
 EWcaYDin/HCHC+VpVFjFKR2pQnZbpfmvlD1pJgJz8AHPXTtok+8qE9nE/8XcVWcRUBy2
 YrtWdQ01YXOO9jXTxH8jiX6W2xABp+GMqpjsD9sizwW3xhPgg6kzvQre/C/G1eiDyUu4
 fCyqfEixObtcH4ZHfQ8mEpaVv+ylVOYqzcopfAHNVLcOaBNLQyvt49GXU1AuNBvaekYJ
 +GWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728642405; x=1729247205;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yWUCdI5kIAajkfGYwCueSqNwJp0vHA+e4Fr+/bH4Bho=;
 b=vtEFbpdzcFetYYhx5nhIfHaOJS6lgAyaH7wajosQ3L49BRL2LSThKQ7jMyje/AaQbq
 oSevN0F0GiDMr+hnUFxHNnLZ0B9edrRCC+jP0fjgwrSkZuvheEP6W/130Rs4JmnMo+8E
 Di7eu04KAddgGSTCeSXYI152grkkv1/RDH/pXJw0IS1GeKHZIGe0Zc1sqxUj8JZbkyVg
 Joxk2T8TjzGyeEn+M0d0MfhZeIRYty9YK4NCQE/vqTt5YqQhm84oZj3sNc8Zwr6iL2ib
 YYCAPWFwCKJ40iYYepGSJvmeO2V8Cjx/tmAQ9rJyyP6O7lAkQv3cMfTfAaOXtMhr767X
 KWMw==
X-Gm-Message-State: AOJu0Yzibnv9Y2z4f3K2wVCgVdXCzUqmp1VFF9rGc3uvst9iOz5NxrO5
 o4cQfTkvLm3Kxb2iRqjzYzSAe2HDf99RpxDrDnUT1utC4Z4o2resOST/5IToPUp6mcyZAkgeB7U
 jon7xwvR3UWRy9rQNUJDuzONDQlBK/xQfh/yXKA==
X-Google-Smtp-Source: AGHT+IHUtDotsr6iCsI4PicvWdhtjt3m+mtDb1vVdq6maHqD8MW9UmiCya1UUM14hk+qsFclask339uZeTI6VLHHQuA=
X-Received: by 2002:a17:90b:38c:b0:2e2:bb32:73eb with SMTP id
 98e67ed59e1d1-2e2f0c550f7mr3123419a91.31.1728642404975; Fri, 11 Oct 2024
 03:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20241008181435.1753814-1-sughosh.ganu@linaro.org>
 <20241008181435.1753814-5-sughosh.ganu@linaro.org>
In-Reply-To: <20241008181435.1753814-5-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 11 Oct 2024 13:26:09 +0300
Message-ID: <CAC_iWjKMoLz2=cwMP6gebeHYdf0XBXfai+ou5F0_6OVMchEGhQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] lib: Kconfig: add a config symbol for getting
 lmb memory map updates
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

Hi Sughosh

On Tue, 8 Oct 2024 at 21:15, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Add a Kconfig symbol to enable getting updates on any memory map
> changes that might be done by the LMB module. This notification
> mechanism can then be used to have a synchronous view of allocated and
> free memory.
>

Are there size concerns to enable or disable this? I think we should
always sync and get rid of this

Thanks
/Ilias
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1:
> * Add a config for SPL stage
>
>  lib/Kconfig | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 1dd4f271595..61452f7ac94 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -75,6 +75,23 @@ config LIB_UUID
>         bool
>         select SHA1
>
> +config MEM_MAP_UPDATE_NOTIFY
> +       bool "Get notified of any changes to the LMB memory map"
> +       default y if EFI_LOADER
> +       help
> +         Enable this option to get notification on any changes to the
> +         memory that is allocated or freed by the LMB module. This will
> +         allow different modules that allocate memory or maintain a memory
> +         map to have a synchronous view of available and allocated memory.
> +
> +config SPL_MEM_MAP_UPDATE_NOTIFY
> +       bool "Get notified of any changes to the LMB memory map in SPL"
> +       help
> +         Enable this option to get notification on any changes to the
> +         memory that is allocated or freed by the LMB module. This will
> +         allow different modules that allocate memory or maintain a memory
> +         map to have a synchronous view of available and allocated memory.
> +
>  config RANDOM_UUID
>         bool "GPT Random UUID generation"
>         select LIB_UUID
> --
> 2.34.1
>
