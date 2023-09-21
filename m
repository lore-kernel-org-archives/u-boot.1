Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C152CCD4938
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:04:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48D8486CDD;
	Thu, 21 Sep 2023 03:02:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bTjfE/Dn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 507EC86CCF; Thu, 21 Sep 2023 03:02:53 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CA9486CA5
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5042bfb4fe9so180159e87.1
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695258167; x=1695862967; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WulSmNjKe7Hlg+dGuRv7q3VpTVKq/bJcs+XPlc7ZfhY=;
 b=bTjfE/DnjmBBVbIFo4WyJF5H2gG1YzZg0VE0YQE1Y29unRVexYD+gpbOwujEhvddxk
 H6x/DSCAgAW+DvkrFIpgFQ0uvKvw1LJqGl2YxGwFp/Fz7qfFOueSxtduG+3K9H4nQx2y
 9oKt40orxzso1y3+opEsb7mY0wlEk8UUjKpHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258167; x=1695862967;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WulSmNjKe7Hlg+dGuRv7q3VpTVKq/bJcs+XPlc7ZfhY=;
 b=c/vzDxiY8UwQWGwGiZT8gPwXV/wGvXIbwTHBp3LIjkolOHwoj3PABNgrs3Ck49erHh
 k5rnat6AgzR8rYs1g9KB21axP+3pRbm3jTWLq3deklXLR5G39uN9nN4Vq3Li2740HTID
 L8RwYigwqARDlzf0gxX/fs5E6vktebsDAzOhO0sKDtaUWOP1GWaBkExRNIVQND3yx7P9
 O6RU11gnav4Ij48UCcIZC0w47vye2JZo5W7bEPPogJsVpz4DQ4jqXipMYWajuxKBBPMZ
 ofB65zozy60eLIu2BS+c51KABLBHaCDPs2EruQ1dMehVkIXgbhziXb0NgUYd1Bjnn5u1
 GoHw==
X-Gm-Message-State: AOJu0YxRTCd4v1NdLhqu+EZvEYRbKaQ/QZVHwJywn75L2zgyBbmAwO0C
 40OxvMqcV5V3UvO6ugf4VdLAGYSP1G7sMW7rnhvNKJjNcw9xedAlK3M=
X-Google-Smtp-Source: AGHT+IGcjJvyTXKbb/zj5FsmCfB0QftBtTEvuiobhwhtzlV0aOtspL9t0oG+3keKoNQ2Kx5qCspo0P3ZQfQo4J1iXk8=
X-Received: by 2002:a05:6512:5d6:b0:503:2a53:7480 with SMTP id
 o22-20020a05651205d600b005032a537480mr3458478lfo.49.1695258167408; Wed, 20
 Sep 2023 18:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230919212722.16216-1-mibodhi@gmail.com>
In-Reply-To: <20230919212722.16216-1-mibodhi@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Sep 2023 19:02:25 -0600
Message-ID: <CAPnjgZ1-0J-P0Fk6hhbDGBZ7wbktibNgUPdcS+1+uRe5oHGpGg@mail.gmail.com>
Subject: Re: [PATCH] bootstd: use ARCH_DMA_MINALIGN in memalign() when
 allocating memory
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
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

On Tue, 19 Sept 2023 at 15:27, Tony Dinh <mibodhi@gmail.com> wrote:
>
> Use ARCH_DMA_MINALIGN in memalign() when allocating memory to read the script from the media.
>
> Ref: https://lore.kernel.org/u-boot/CAJaLiFy05F3Cr4X4G2mVkppXnBEFZrHQ+5CngYN8eJPg8ENWkg@mail.gmail.com/T/#m26daadc2463fe653b814a94e6309e5e6bb6be1d1
>
> Note: this patch depends on the previous patch
> https://patchwork.ozlabs.org/project/uboot/patch/20230917230649.30357-1-mibodhi@gmail.com/
>
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> ---
>
>  boot/bootmeth_script.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
> index 96e0ec5efa..de2e510da1 100644
> --- a/boot/bootmeth_script.c
> +++ b/boot/bootmeth_script.c
> @@ -99,7 +99,7 @@ static int script_read_bootflow_file(struct udevice *bootstd,
>         if (!bflow->subdir)
>                 return log_msg_ret("prefix", -ENOMEM);
>
> -       ret = bootmeth_alloc_file(bflow, 0x10000, 1);
> +       ret = bootmeth_alloc_file(bflow, 0x10000, ARCH_DMA_MINALIGN);
>         if (ret)
>                 return log_msg_ret("read", ret);
>
> --
> 2.39.2
>
