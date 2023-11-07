Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEF7C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 09:03:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28B8E87126;
	Tue,  7 Nov 2023 10:02:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k2QIycF7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 427D887134; Tue,  7 Nov 2023 10:02:58 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AC9C87116
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 10:02:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-507bd19eac8so6974733e87.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 01:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699347775; x=1699952575;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=a3pI/829W3OuDe9zURtPQCHfr9ilIPmywUYZwkN1e5A=;
 b=k2QIycF7LUvIj55IfmxyvzRjLuFyl5DE9EHsu2EK0VHVOtn0WlB4qCrOQEHaEtSOwg
 8IFoeP3hDr/Up6kH9qXfQIOl8V6RIIaDd6IX9tSfpD4pNvoift3gArDrRnhVJV9X7xt9
 ux1YTYgdM6mKX5CnwjP/l/6Dbk8Vblag5vtbnTuPTwxCWUjzOO77beVzeiw0Okw6kVbv
 GQL+He5ljjd4FUFQrcCgTXFwYjYF6iD6yNYby0iqr2RiZXrsBH21srte01MjDpzu0F4u
 U1WJ7ipEKEpcikkl1/e7tlpxQKzC8BY5lJHq5667+aGhKwifkMGUV+0khWK3ZwNeMHDz
 uK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699347775; x=1699952575;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a3pI/829W3OuDe9zURtPQCHfr9ilIPmywUYZwkN1e5A=;
 b=pmhZl9ykyy5exkzHPO0Go/wvbtB0F7hVekzO0BLX4WLoGWQ85r2L2mQtPqcWTsIiXQ
 /KI+AOGwdZMmmp8phn0KYSPm6Mybdz1emPoRdXqC8PaqPEA7FnJ4kXdGAtWLuE5/eSLZ
 T8cMTAQ5fTXKHztk/XJrIIQ9O94Ym0eaYeY8IiziGROBAplXFunP6S/vqzHPX7CynhyP
 qZy2ZJ5UiuOpKIktlPXPxTHexa5GbMNCPSN4N8tOR376ygYKc3xVWRj2uDvmBFjfMMrv
 nFo0Z059R4wptzAjwUkd91XaHAOqrZeV2mnhzScPlM+3qmaCC2B+hOkzF4gUlcbgfZQy
 XaFQ==
X-Gm-Message-State: AOJu0YyQI+G6vNBMztX+DyCnJDGid7Ckm8ore/mz9FBusayX01Sbs+4f
 RPdJ42mcRcQK62cx1LSQfFWdvA==
X-Google-Smtp-Source: AGHT+IG7ZAH/EHhLZhI90+UYVeAK3BaL5tQER/xOYg1HqEjHp2P3sVVTzsG03kF8qmWa52xZopl3fg==
X-Received: by 2002:ac2:5204:0:b0:500:863e:fc57 with SMTP id
 a4-20020ac25204000000b00500863efc57mr23309971lfl.25.1699347775198; 
 Tue, 07 Nov 2023 01:02:55 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 f18-20020a5d58f2000000b0032f983f7306sm1751642wrd.78.2023.11.07.01.02.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 01:02:54 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH] usb: gadget: f_mass_storage: Stop ums on START-STOP
 UNIT SCSI command
In-Reply-To: <20231107001018.55640-1-marex@denx.de>
References: <20231107001018.55640-1-marex@denx.de>
Date: Tue, 07 Nov 2023 10:02:53 +0100
Message-ID: <87jzqu9br6.fsf@baylibre.com>
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

Hi Marek,

Thank you for your patch.

On mar., nov. 07, 2023 at 01:09, Marek Vasut <marex@denx.de> wrote:

> Exit the UMS handler loop in case START-STOP UNIT SCSI command is
> received. This is sent e.g. by the util-linux eject(1) command and
> indicates to the device that it is supposed to spin down the media
> and enter low power state.
>
> This effectively adds support for exitting the 'ums' command from
> host using 'eject /dev/sdN' that is on par with 'dfu-util -e' .
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  drivers/usb/gadget/f_mass_storage.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
> index 1d17331cb03..c725aed3f62 100644
> --- a/drivers/usb/gadget/f_mass_storage.c
> +++ b/drivers/usb/gadget/f_mass_storage.c
> @@ -327,6 +327,7 @@ struct fsg_common {
>  	unsigned int		short_packet_received:1;
>  	unsigned int		bad_lun_okay:1;
>  	unsigned int		running:1;
> +	unsigned int		eject:1;
>  
>  	int			thread_wakeup_needed;
>  	struct completion	thread_notifier;
> @@ -669,6 +670,10 @@ static int sleep_thread(struct fsg_common *common)
>  		}
>  
>  		if (k == 10) {
> +			/* Handle START-STOP UNIT */
> +			if (common->eject)
> +				return -EPIPE;
> +
>  			/* Handle CTRL+C */
>  			if (ctrlc())
>  				return -EPIPE;
> @@ -1325,6 +1330,8 @@ static int do_start_stop(struct fsg_common *common)
>  		return -EINVAL;
>  	}
>  
> +	common->eject = 1;
> +
>  	return 0;
>  }
>  
> -- 
> 2.42.0
