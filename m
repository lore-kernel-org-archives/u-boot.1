Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0541BC5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:59:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EBE4606AE;
	Mon, 24 Aug 2026 13:59:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hjwPiAbQnWJB; Mon, 24 Aug 2026 13:59:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787579989;
	bh=gkSGIG1jJf7eOM+PfZtB+he6oF7q64hL9alA9sy50Ts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F73lJdAFv+6X5W4Xvf+zNIrFCFlBYEbHEXU+NAVWS7pe17fMEfVUhekSga1KKwD2m
	 uqdbNWH80uRADaIJgrglQyoG2ig+RQvXueInjApONnwGkzte54IKByZzdG7//Qgk7J
	 1YQ+YFe8iHuS8qDvXBO7K/PvKNi9ec36amE6rjfCY54qWxwNIpnL2XxVeQPH3HK1SA
	 hcEU3YML6IEfd2oK4+wW1OKI0aBFUaIlEMVfpFYV2oUxQuP0JeRXoASFpMYkF+epQf
	 Qi6roMRAIdsz7V1L1vpSQSvsx/JnTJmL9R238m2l/793ZmBL+pwSR4kYpOncBKB+nf
	 hx0HEZUTAAlVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 383226063A;
	Mon, 24 Aug 2026 13:59:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 061012FD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:59:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E08E340050
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:59:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Qr3oB7EmwC4c for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:59:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=stephan.gerhold@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=JioyD+b9
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4409040029
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:59:45 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c15d111ca99so419875766b.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 06:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787579983; x=1788184783;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gkSGIG1jJf7eOM+PfZtB+he6oF7q64hL9alA9sy50Ts=;
 b=JioyD+b9v/E4RRSzUa/y5acAg1S/po0jxO84+lh5gnzNAO2eVmvNKkAYVvtrTSPCmY
 sjqZ0xHRzuZzf+PfO6op0pRNF6VmsXJmwvsXkt1R/uHBYmnP9l+s4M9Qc3098gSxdZ07
 hU7AYSnJ6srckkT2Wk5dQpI16+LYKFmhsqsYIoMU937oXHiF5VrtuGs+NZboyG1lupMe
 Vbg4IgYGqniMji2jQBhMBKpcMvKXGhRlHBlosvzeMAXiNEEVO0oI7ktFhUnmW2Vd1I57
 hW8W/rKlN63q3UMdDvy/dCK3RX75SmcukBsyP+QQbIke5XC8LTXRiol76aegJA54XMYF
 PryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787579983; x=1788184783;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gkSGIG1jJf7eOM+PfZtB+he6oF7q64hL9alA9sy50Ts=;
 b=d/K5rdNk1ASEbc7Nz2L/wt39j4Yx7EtCsbFCl7bJ3wuwXYh6jYZqyM3zVPVUV3msDV
 eR7bU56nC5VdUxR0l0zcOAUYrYoJtpSav4JfVN1bi37l0ts/hZv9f41JnGOXV5kquryB
 Wm94HoV7NggLnkjRKymlwR/iyQEVxZETjNOW+Rla6DB1jRGjuUWSIoFzm1wHItwlmxbl
 4MiKp0Z/Qqlr8BSZ8XvlDf0KeSkzslHu2wC/nFVE49EDG9KOoU2HTGI+7Cj4bJwK4Qlr
 fWDix8X778jAXZQusevKrPbKjUKpoKJhkN5ie59JzfLueyLE82nErKRowK8FUFToIaQO
 6MZw==
X-Gm-Message-State: AFuF++nRSWIUG9KDzWBMeDSaxiFoCZSWhJ49IYVtDq0E96NgePI6x6/b
 WHXQ+qRmuqT4PFrLUNqP96ESMy/GeveQxdPbSvLolqaz0fky8fwB94U7Y/V/R3u95es=
X-Gm-Gg: AR+sD13RPIpooWJoZWAhc3ufTsqsW2bakJE02pulb+B7UMy4xCMOQmsLef3MEmhLVny
 hI9sdRe3PSWT9TdD2oyp3FgJ7cB1lRCCAXAzAnQKaQDHKCIagu1hxM1H/L2y0X+JW105Wsf/Xz7
 gFeAzwXHyv6YAiIHCx+75aZcf1mq+VSMir4E1RgMMoz+llbQ+HXfd7mI3jWugROZpkxOWbSgVhU
 /RxM/u92RbVJq7ZP1tljSj6HvbCb2pPdMS64cJwV1bdZ7L/bUWMm6q+WWbvvE5MKu1rDdTpK+dQ
 8YzmBfbfgv/AcGASKQctHqevtkhx8Cy3hqd+Kdo7s+jawf7QQ3mTImo8p1QF2ZV8M0AzyiSYflr
 WnvGuotUCMiwDN6JleGYvqrex8Oyky7Yk91BD8LofqvadquxY7bdOsKo+cczykilEHHSEd/cmhF
 m1Cg8lG23w6uAUo4n5ZWRo/exxPsb9ut/+xjQRgwkvMPRgi83o4LGBs0uZD5W6b6wXmN3konM=
X-Received: by 2002:a17:906:6312:b0:c24:6445:d19 with SMTP id
 a640c23a62f3a-c24926f3cf9mr2251607566b.17.1787579983432; 
 Mon, 24 Aug 2026 06:59:43 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff24:7210:8b5e:6b33:b439:3e9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249672becesm1320261166b.42.2026.08.24.06.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:59:42 -0700 (PDT)
Date: Mon, 24 Aug 2026 15:59:41 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefan Hansson <newbyte@postmarketos.org>
Subject: Re: [PATCH v5 13/13] arm: u8500: Package Stemmy device trees in FIT
Message-ID: <aoxOTWT8r7QX00lL@linaro.org>
References: <20260823-ux500-external-sdcard-v5-0-07ca794e2b94@kernel.org>
 <20260823-ux500-external-sdcard-v5-13-07ca794e2b94@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823-ux500-external-sdcard-v5-13-07ca794e2b94@kernel.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Sun, Aug 23, 2026 at 10:39:32PM +0200, Linus Walleij wrote:
> Build all seven supported Samsung Ux500 device trees into the FIT
> appended to U-Boot. Select the appropriate configuration at runtime
> from the machine ID passed by the Samsung firmware. Codina and Codina
> TMO share a machine ID, so distinguish Codina TMO by its board ID.
> 
> Keep a Kconfig default for the generic multi-DTB build dependency, but
> remove it from the defconfig since the board selection is now dynamic.
> Print the firmware machine and board IDs to aid diagnostics and future
> machine ID mappings.
> 
> Signed-off-by: Linus Walleij <linusw@kernel.org>

Yes! This is great, thanks :)

> ---
>  arch/arm/Kconfig          |  1 +
>  board/ste/stemmy/Kconfig  |  6 ++++
>  board/ste/stemmy/stemmy.c | 77 ++++++++++++++++++++++++++++++++++++++++++++---
>  configs/stemmy_defconfig  |  1 -
>  4 files changed, 79 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 2a01ac9b7675..8e697b87d50f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1278,6 +1278,7 @@ config ARCH_U8500
>  	imply DM_REGULATOR
>  	imply DM_REGULATOR_FIXED
>  	imply DM_RTC
> +	imply MULTI_DTB_FIT
>  	imply NOMADIK_GPIO
>  	imply NOMADIK_MTU_TIMER
>  	imply PINCTRL

It's a bit weird to have this in ARCH_U8500 since there may be other
(non-Samsung) U8500 boards who couldn't use MULTI_DTB_FIT.

Can you put this into stemmy_defconfig?

> diff --git a/board/ste/stemmy/Kconfig b/board/ste/stemmy/Kconfig
> index b890ba51cb03..e891ddf9f8b2 100644
> --- a/board/ste/stemmy/Kconfig
> +++ b/board/ste/stemmy/Kconfig
> @@ -9,4 +9,10 @@ config SYS_VENDOR
>  config SYS_CONFIG_NAME
>  	default "stemmy"
>  
> +config DEFAULT_DEVICE_TREE
> +	default "st/ste-ux500-samsung-janice"
> +
> +config OF_LIST
> +	default "st/ste-ux500-samsung-codina st/ste-ux500-samsung-codina-tmo st/ste-ux500-samsung-gavini st/ste-ux500-samsung-golden st/ste-ux500-samsung-janice st/ste-ux500-samsung-kyle st/ste-ux500-samsung-skomer"
> +
>  endif

I don't mind adding this here, but I'm also not sure if there is any
advantage compared to adding this directly in stemmy_defconfig?

Thanks,
Stephan
