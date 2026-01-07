Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFC8D0D170
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 21:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED33D8405C;
	Wed,  7 Jan 2026 22:09:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="qrulm0c4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89615840A9; Wed,  7 Jan 2026 22:09:25 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73F9683A2D
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 22:09:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 17CA841968
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 21:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767820162;
 bh=YPUHget73xCVxejyip0HkiyxXh/2Y8oqGvSQ4Vo/5u4=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=qrulm0c403/2UR2GmrzrTO3kjRTw0TDIfcoLAi/90eKrFz9qDRh7Vn/8Ra5uqU6rF
 UB7hOvW/JO0oxBUNiYdM/GsWirRNslXIC3YlBqTl33rtfhDbP5fIAOnAVNV4jZoUM+
 Fs3KyUJ7UMebmozeb6k8k2RCy58q/+6utscgRgWkFgexfaMYVnSuyI1VfptfWylzgt
 v3zDcs4V0O8B9jUhpl3slI/WZhg862S/31RhTzFzi0mPI7SazxGlRFFxAabHOfSao+
 wt9U8NVGwytus2fAwAs3z/x2P5Kx5WGNL6U8bb+03VTzUBvhYx58WVt4W4XzYNSB2q
 zBBzH0Qd/wQx3Eondvadh1igyL1Gx7tdmWvGbQq4VDHCMOaMfvEf6Jh5jxuQhCSfmq
 vdlam0ZMgL0LhBDwdGpBhwJdlUWW2luY//ManeQ7GA5vdCrmFnXQnFa4D7d2TCGCuS
 G22R4A4Nf9vFV23ukt9Y2LrQ6qMvho3kJY6ahq/94pEl9ZEWxRaOBomfNroZkeqsc4
 FV7qQ+Z2qmDj7NTJH0V8LaDFFDsD+/wfr6qh+WXL914/g7662AN3v59Tc/Fb0zaYFs
 Bc1CjTmuRFD/TY70v74IlLZelxnflD7PogwSu1TSr9CSksgf+eFR/xz6tEzPduKYGE
 2LjdOB4uKgFe5ILta5DAi1KI=
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-430fdc1fff8so1588468f8f.3
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 13:09:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767820161; x=1768424961;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YPUHget73xCVxejyip0HkiyxXh/2Y8oqGvSQ4Vo/5u4=;
 b=Yl3uAy3cQHvLWqQPCU+j9fAWuF9SjnBzvg9tcF+xUckDSy3vsUcZJ9trO5V0c3HcQk
 PS+bRTXgEXLsUPgHNtIgNr8sOfOqO+iCG+c79cyXYrrhwTCDQQllUJgnEPkFF+oJGW54
 4xvwnBNVEqNPX5XJYypB2s0aAcALyDNSq0z3eDCOJD36MWT8VESLk5TNJ5GifI7QQFhu
 0+hN8zTWE9Wa1fbwQdOft/ZXXeZbDhtyypKo5EPAtZ2DmYhrKPJ63V2yufpG+02xPGRI
 2XGEPVjqy3O1dmCfBx8MPbgWXI/+nRtaSuL7u3KtcXSgBmaX9McfKYhza+VwGNwVbFfT
 lkUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA0k2KRShgXdswMf+U/su9dMzhbiL/bT7JCqyxHsOE+VEu3YzeRoggBQsakZr5ZYTW9O6LIrM=@lists.denx.de
X-Gm-Message-State: AOJu0YyHuJau2GkGiVfVbWQa5qJa+TqMRBOzlui9wWfGosl4fsiOPRQD
 JseLacVo4l0pa37OFliwjqDxAGBc3X2OnOtwMXRFkfPCimrirlXMiwy9eZAP0bn5uyt2pOYoHLq
 cnFybJClKJ8znIm4YZqk+yw+ABqyJ3yJ0o0obsNPzXtZUAUravAk3MQr4nLScfTQRBVCoWhU=
X-Gm-Gg: AY/fxX5fSiUeSisDb0xdeSlAosAXxvBknDR235n7TlMRgomIedQqzj2xjpdHNn7bCcL
 rcwCdTk6SlMzcpmhQELbQn36QkdCBlwtPLknZoGqGGO+wyi/YeWi5WD8qd0FefAJU8XQkfQ3z5o
 OaR6GQlX3dfRCDWUWYZmG0pLKyXi6nAOONNQGDghG+vYvteNhr8PT2IFJF1r3JFGiXJOj9/bdbh
 TzSX603co3O+BWibV0eSgvJ1kEGSNSp6/eg6lgwiSzvIIAR86rYIaa69LrwXqloN032tTuKwiyd
 ivBvBrk8kvKLdRdzwddqPJXQ7AxhFROLMqiqn+I3X4atGjarYvLZrU5a8CakjN64Y+t/G2n0yar
 yUA2i3X81i071zyxPjo2INr+X0vIXZIFLJcrscK2q7wviwi18jrc3siCBdN5nJKQsgQ==
X-Received: by 2002:a05:6000:25c1:b0:430:f742:fbc3 with SMTP id
 ffacd0b85a97d-432c376155bmr5042567f8f.48.1767820161650; 
 Wed, 07 Jan 2026 13:09:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6/QQ84s4NCohE05G2lAu2LhRRsGdWUAW31GpqsV1awN3uQsuXe8WJ6/heoQxue7s2hyPeng==
X-Received: by 2002:a05:6000:25c1:b0:430:f742:fbc3 with SMTP id
 ffacd0b85a97d-432c376155bmr5042535f8f.48.1767820161274; 
 Wed, 07 Jan 2026 13:09:21 -0800 (PST)
Received: from [192.168.103.126]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df9c5sm12768366f8f.22.2026.01.07.13.09.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 13:09:20 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <d878f88e-9349-42e5-a7e6-d363c01743a3@gmx.de>
Date: Wed, 7 Jan 2026 22:09:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] doc: board: qualcomm: document Pixel 3 / 3 XL
 support
To: david@ixit.cz
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Luca Weiss <luca.weiss@fairphone.com>, Simon Glass <sjg@chromium.org>,
 Petr Hodina <petr.hodina@protonmail.com>, Matthew Croughan
 <matt@croughan.sh>, phone-devel@vger.kernel.org, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, Petr Vorel <petr.vorel@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>
References: <20260107-pixel-config-v3-0-02a25e3fdcfa@ixit.cz>
 <20260107-pixel-config-v3-1-02a25e3fdcfa@ixit.cz>
Content-Language: en-US
In-Reply-To: <20260107-pixel-config-v3-1-02a25e3fdcfa@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 1/7/26 21:28, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> U-Boot does work on Qualcomm 845-based Pixel 3 and 3 XL.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>   doc/board/qualcomm/board.rst | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/doc/board/qualcomm/board.rst b/doc/board/qualcomm/board.rst
> index 642c5095261..e5dbc9816b9 100644
> --- a/doc/board/qualcomm/board.rst
> +++ b/doc/board/qualcomm/board.rst
> @@ -38,6 +38,25 @@ with appended dtb, so let's mimic linux to satisfy stock bootloader.
>   Boards
>   ------
>   
> +Pixel 3 (blueline) and Pixel 3 XL (crosshatch)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

How about the Pixel 5 (redfin) mentioned in patch 2/2?

Best regards

Heinrich

> +blueline refers to the Google Pixel 3, and crosshatch to the Pixel 3 XL, both
> +powered by the Qualcomm SDM845 SoC.
> +
> +These devices use the common qcom_defconfig with the google-pixel.config
> +fragment for configuration.
> +
> +Use the following commands::
> +
> +	make CROSS_COMPILE=aarch64-linux-gnu- O=.output qcom_defconfig google-pixel.config qcom-phone.config
> +
> +The DTB is called:
> +
> + - "sdm845-google-blueline.dtb" (Pixel 3)
> + - "sdm845-google-crosshatch.dtb" (Pixel 3 XL)
> +
> +More information can be found on the `Google Pixel 3 page`_.
> +
>   starqlte
>   ^^^^^^^^
>   
> @@ -131,5 +150,6 @@ Other devices with boot image version 2 can be built like this example::
>   	fastboot flash boot boot.img
>   	fastboot erase dtbo
>   
> +.. _Google Pixel 3 page: https://en.wikipedia.org/wiki/Pixel_3
>   .. _Samsung S9 page: https://en.wikipedia.org/wiki/Samsung_Galaxy_S9
>   .. _DragonBoard 845c page: https://www.96boards.org/product/rb3-platform/
> 

