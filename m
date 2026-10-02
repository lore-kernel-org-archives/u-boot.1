Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4F8CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 00:45:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B89660B5D;
	Fri,  2 Oct 2026 00:45:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jxS59u47hSxJ; Fri,  2 Oct 2026 00:44:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 0D8F86080A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790901899;
	b=GL+H3h6WnsYy+WNi0YwhRQr/507XrOAHX9Ghh4d9s8MmSf6ajPnwJlcBO+tL++dLgCI/
	 5IY71PF+gcdulM9byhsvhQc4BwI7G1ikzkoMTB+dLk++gL7v60UnVn5HQs36sV+EH6kb6
	 2yz0pVffAqGnMmSREsbvrTkj1RmXDXEG90Mx4aONmzFwzkdqvdZyNQ8aulK3Tg+fA4TDw
	 pWj/9KHol6ERTNaNJPjOBIbhtg2uDHDklQcyaExzttxkRHakjQZ7LqWh92lMB7xQGdqdc
	 YGap1ziwQvVpeKCZ7T9vCyaGTfW01tSHnmR50IYOGvr9uq+9uWNNUOuyhxLN3gqn65A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790901899;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rQU9wEEYQA5HVwGezq+m6vu3QnK35D5/BV9ABjdwLK0=;
	b=eWq6VkPpNr+3NGf3Y2MhGtgO1sPPsn5L3DK10o3soicb+jw1Gjh4yeM+gLkRICYZwZYt
	 eTqkhJOQbzx/4p0VAWVaa9BzgQMjdzvzc4SsVdgSvuiGK2lI/EuP1JTgPby+nTfjSQ+S5
	 HzEpn7OmU0oXDtdElps+9YRQenYivSxK+VRjat+P5BIf5irn7A8GsUzLCb56947MEHefN
	 eGrroqmMEl/2kfZtoW+Mbh/qKeA9cb7UKM/WUe3aRMR9+CVS9Wh8HjGIetnXoJNcKrjZP
	 KHa01k61Yuz0Kr+FLo0kSRZT4wWzfPw4Xk3nQcd+LI/V5gyQ5rS2FrZb5wg9ZjxyLcA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790901899;
	bh=rQU9wEEYQA5HVwGezq+m6vu3QnK35D5/BV9ABjdwLK0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ofTHALH3Ib6CJIz1qrmNNrz/tkEX6XilIhIziecwm8R3ovCtVCxL2jc8DqNt8K2YO
	 z4/g6uGP8IhfauPY/vVtrDPKwmWSsRZ/7xdqGRWhdWnAO5phVJzdg4RoN0U1LxzPJI
	 nI7fZpRA71EK3f4h5dVqwKLPu3DI2NFiq4SF+H8zkPP9KzbrKpwoTLw7AHqZRdBjgr
	 3kFI5akbfZnm1J++wHzl+/2EsQvwcF62auNE0SvxkGh5c+uEG9r6MLdy9YcCSyePec
	 w3RJVBsIq/Ou6RtcKNEZR6uoj02DjFNhVPtyKeNIKEZBB2WLQv3IxeXH+Y8KRD4BL+
	 q9w7belT2Hk0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D8F86080A;
	Fri,  2 Oct 2026 00:44:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3DD2432F
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 00:44:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 240D58115D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 00:44:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OkrSlD_LkZQP for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 00:44:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 87DD981155
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::e"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790901896;
 b=tYRGjDkmGdG0o8JdEsxefs00HlSbohR3iayg0nUiT6ASLl4d7pmwQBmKf1t1AZhLklJh
 e/xsJZCqRdOZTYJrDL7Rqrk4NlxPvQrzSr27bcejFOy+Z9bPlhyXAXPOk8POKoPzZLzQn
 APRUZ3AAETD1e0fx1rKA6gphAWVODPsd3pnimH4X0VqvUqiUxWxXyUbjp/UDPZz37Dltl
 xiizUavB+mXd6omH/5SFlsjmAkQA5CBknp98dd6XY0A08cs34yG+ks6kwjh8nJqX5OxYc
 0Mv6u6vJRUQRMMHN4uzDEM68ATlc5O+ejzQjPi1ExlaWXBbkwdENPHix6cpQ6hZNc7Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790901896;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=rQU9wEEYQA5HVwGezq+m6vu3QnK35D5/BV9ABjdwLK0=;
 b=TUaUDw0C5qW2w9zRdwcutJRCQMNRsM1luxD9T0lK+BK1pZbLtERFKoKG0hX7CfswRH3s
 RUUnZDHymvve+NIqX1RcgcH//2GBzU9T6CtVIB5wvGE0wZnuydnLRNchKiBkx1Uuddryg
 8+VpeE08gfqZ8EOT5xbT/4YWD7ruTUvFEx81bTdmQjykJkM6TAYhzlgCeX+4EsWIsWxy+
 CSAhrfgYbV2oxUqqq3jbf/CoqGVZMPh9Rzh8AnkMrSXz0ADg7tlLoHm9YUCQD+kCr2OWa
 M9wjm/b6NWCzbJgVfcakRB2KZxF/uzfwvTYWOTTrd75QqTcODwGYSkyMv5+DbbrCr+w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=NC3UDJK1; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::e"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::e;
 helo=mail-oa2-x0e.google.com; envelope-from=dlechner@baylibre.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=NC3UDJK1
Received: from mail-oa2-x0e.google.com (mail-oa2-x0e.google.com
 [IPv6:2607:f8b0:4864:30::e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 87DD981155
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 00:44:53 +0000 (UTC)
Received: by mail-oa2-x0e.google.com with SMTP id
 586e51a60fabf-49aa2fa57adso850264fac.0
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 17:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790901892; x=1791506692;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rQU9wEEYQA5HVwGezq+m6vu3QnK35D5/BV9ABjdwLK0=;
 b=NC3UDJK1NAJc+o5KYDWRLWOo/ERFQPKkgZ4jZ3W0Lq0p7glr3Y2A6lAmB0ewZrjp1Y
 xquxggS42K3i8tZqeZbN3lRMab/I8DPpyxDPAbaF1ur8GrFhWQlWuLQ2nyMzhdNheMNa
 dhD0TIMf9W5OJWHYvsB8OCivmD82qvJ/0QpSHV8u4/U3Ahtgg9oZFUz7MNrIkM9pzamK
 KwA2Ts5v5Sow4liovqBEmidwwGnoclomSPN9Jgn1K+6XKj+a/DNjUfOA7X8BofxZWUaI
 biNKwCR0fGSdQb+SDQUUGVDhJMZBL4GNsooGlZzlvHHVj1lH7SLgvxzADX2lNSfIpvDn
 Nqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790901892; x=1791506692;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rQU9wEEYQA5HVwGezq+m6vu3QnK35D5/BV9ABjdwLK0=;
 b=ZMx/YrW95rlDPT/hd5urX0O5aMAf6pLVI2X2qR3+eyconO42CuoJT+6eOs334O1Ipw
 HKI1dw9fUEVKfdOiVyPv3s4h5GmS2Odm27rz4Ro1+iuhVl+dslPbX26L3LQfQ6U5TIzk
 DsUQYEt7k6jBinSb2LwE2ADFTT/rhuTd6IV69613z5jGJxz5yGUt17cUNKC0W6XYO94T
 j/jIiGFjy8jhofiOlJXplsXPoQ9cKeKqz/fpsaNXRUti+F+zJ5ZZEQYQ0Ea4Ys8qGZ7b
 rmNtF2krPNIHm3EznAS0zQnCA8vH5QLip5UpS/QV8Rr1LXo94tK6PLDWkqHu71sqQYW4
 gofg==
X-Forwarded-Encrypted: i=1;
 AKwUvByd6zYos/Kk/5jvEiy/2qQQZ3y4UZSTtQEtzbFRaRFKOLlxYYdX4E6jT4Z4qRY8d3RWO3jej84=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI9mEjn/RC/ttWL89eArXXabiuRQZW3zRC81XAL4GKbfnjL57+u
 iAhpzyDolxcnZEWpjR4ohxRZcLrsmJDk/LRlUvDrjrZGIT9EbxiXni+fQRYQYqo/6YE=
X-Gm-Gg: AYBFou1UQ203TN9Iinn7KD2RU77V6jLbZe1nRLj6FYe5NNakUcAEUfL82u7pUPWUDiL
 X7owEVCbavrtNZfISQ9skhO0KNSHIWntKVFj4+/TqahcXVR/gdzILix8IDQPf5X5jfstvsXMbjV
 9Zb97srFohkuu5uJq/A2vKUZPL7xcJozHQ25q1mjr/lYTi1470DcamFyu/cPeNMHRhNDVCt+kgF
 YgC5v8AjwTz1D8rbQlAdV8Gk1TTu/XH2hYxYIoTbvFF91EWb6WRVRIeqHxWwJxIs6DU65Hp3bfZ
 xK3UKvNzy9TTlqU5b7goPmUgzldf6qCob70mWuNcoTVe6mXEaNJ+bHPszAqnlFnSVQQR5VSrwb9
 C9oEZKtxI4nTraw8aD/BuUCaYivGN9Ln5DN0Pmv8LBJLy0WeAsNImgRhteWTflfsElolyprJR8c
 e48oSoey3nCnQpPHsrf1OqtePRKrurBPNmSjCoK2v9B3BDHy2zkg9zb3EgHW3o37yLcwqUgEYp4
 KW5ns3HhGjzTe94Rkwz9ycrLf/MOawFtGWvf685TumqRE3l
X-Received: by 2002:a05:6870:8dcc:b0:46a:c673:a16c with SMTP id
 586e51a60fabf-49e15c87e4amr959025fac.5.1790901892483; 
 Thu, 01 Oct 2026 17:44:52 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b543:49c5:7c72:a244?
 ([2600:8803:e7e4:500:b543:49c5:7c72:a244])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-49e16e577c0sm1172833fac.10.2026.10.01.17.44.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 17:44:50 -0700 (PDT)
Message-ID: <4b2f1610-3b2c-442a-aeb2-fd3f18892c89@baylibre.com>
Date: Thu, 1 Oct 2026 19:44:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] video: mediatek: add dsi driver
To: Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Heiko Schocher <hs@nabladev.com>, Johan Jonker <jbx6244@gmail.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>
References: <20260928-mt8365-mt8366-add-dsi-support-v1-0-212f51b1742b@baylibre.com>
 <20260928-mt8365-mt8366-add-dsi-support-v1-11-212f51b1742b@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260928-mt8365-mt8366-add-dsi-support-v1-11-212f51b1742b@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/28/26 10:08 AM, Julien Stephan wrote:
> The DSI controller is the last stage of the MT8365 and MT8366 display
> pipelines: it serialises the pixel stream coming out of the pipeline
> onto the MIPI D-PHY lanes, and carries the DCS commands the panel needs
> to come up.
> 
> Add a video uclass driver bringing up that whole pipeline: power the
> D-PHY and the controller up with its D-PHY timings, ungate the
> components, route the overlay to the DSI through the mmsys, start the
> components in order, then program the video timings and the pixel stream
> format from the panel's own description, and start the video stream once
> the panel and its backlight are on. The MT8365 runs the stream through
> the colour pipeline, the MT8366 straight from the rdma, which the
> per-compatible data selects.
> 
> The driver is also the MIPI DSI host the panel talks to: the panel init
> sequence goes out through the controller's command queue, in command
> mode, before the video stream is started.
> 
> The driver matches "mediatek,mt8183-dsi", the generic fallback the
> MT8365 dsi0 node carries behind "mediatek,mt8365-dsi", and
> "mediatek,mt8366-dsi", which the MT8366 node carries on its own as that
> SoC is not upstream yet. Beyond the colour pipeline, the two generations
> differ in the offset of the command queues, in the mt8183-style shadow
> register control, which the MT8366 does not have, and in the command
> queue size of the long packets, which the MT8366 has to set itself
> (CMDQ_SIZE_SEL): all of it is per-compatible data.
> 
> The objects both paths need move out of the HDMI object list into
> Kconfig symbols of their own: VIDEO_MEDIATEK_DISP_COMP for the component
> helpers and the mutex, selected by both paths, and VIDEO_MEDIATEK_DPI
> for the DPI, selected by the HDMI path. VIDEO_MEDIATEK_DISP_PIPELINE
> covers the mmsys routing and the display rdma of the DSI path.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>  drivers/video/mediatek/Kconfig   |   32 +
>  drivers/video/mediatek/Makefile  |   19 +-
>  drivers/video/mediatek/mtk_dsi.c | 1220 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1268 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/mediatek/Kconfig b/drivers/video/mediatek/Kconfig
> index a10f2360391..9d779a26da5 100644
> --- a/drivers/video/mediatek/Kconfig
> +++ b/drivers/video/mediatek/Kconfig
> @@ -4,6 +4,36 @@
>  #
>  # Author: Julien Stephan <jstephan@baylibre.com>
>  
> +# Display pipeline component helpers, selected by the output paths below
> +config VIDEO_MEDIATEK_DISP_COMP
> +	bool
> +
> +# mmsys routing and display RDMA, used by the DSI path
> +config VIDEO_MEDIATEK_DISP_PIPELINE
> +	bool
> +
> +# DPI timing generator programming, shared by the DPI and HDMI paths
> +config VIDEO_MEDIATEK_DPI
> +	bool
> +
> +config VIDEO_MEDIATEK_DSI
> +	bool "DSI video path for MediaTek SoCs"
> +	depends on VIDEO && ARCH_MEDIATEK
> +	depends on ARM64 && CLK && PHY

&& POWER_DOMAIN

> +	select MISC
> +	select MTK_SMI
> +	select PANEL
> +	select PHY_MTK_MIPI_DSI
> +	select SYSCON
> +	select VIDEO_MEDIATEK_DISP_COMP
> +	select VIDEO_MEDIATEK_DISP_PIPELINE
> +	select VIDEO_MIPI_DSI
> +	help
> +	  Enable support for the DSI controller found on MediaTek SoCs such
> +	  as the MT8365 and the MT8366. The driver drives the mmsys display
> +	  pipeline (overlay, RDMA and, on the SoCs having one, the colour
> +	  pipeline) to scan out the U-Boot framebuffer to a DSI panel.
> +
>  config VIDEO_MEDIATEK_HDMI
>  	bool "Video HDMI Support for MediaTek SoCs"
>  	depends on VIDEO && ARCH_MEDIATEK
> @@ -14,6 +44,8 @@ config VIDEO_MEDIATEK_HDMI
>  	select MTK_SMI
>  	select PHY_MTK_HDMI
>  	select SYS_I2C_DDC_MTK
> +	select VIDEO_MEDIATEK_DISP_COMP
> +	select VIDEO_MEDIATEK_DPI
>  	help
>  	  Enable support for the HDMI TX output found on recent MediaTek
>  	  SoCs such as the MT8188. The driver reads the EDID of the
> diff --git a/drivers/video/mediatek/Makefile b/drivers/video/mediatek/Makefile
> index 38ab13e94fd..9de9a9c78f1 100644
> --- a/drivers/video/mediatek/Makefile
> +++ b/drivers/video/mediatek/Makefile

...

> +/**
> + * struct mtk_dsi_data - per-SoC DSI data
> + * @has_color_pipeline: the DSI is fed through the color, ccorr, aal, gamma
> + *			and dither blocks rather than straight by the rdma
> + * @cmdq_long_packet_ctl: the command queue size is not set automatically for
> + *			  long packets, CMDQ_SIZE_SEL must be set
> + * @shadow_dbg_off: offset of the shadow control, zero on the SoCs without it
> + * @vm_cmdq_off: offset of the video mode command register
> + * @host_cmdq_off: offset of the host command queue
> + */
> +struct mtk_dsi_data {
> +	bool has_color_pipeline;

I've been looking ahead to other targets, and I think has_color_pipeline
doesn't actually belong here. To be more like Linux, it rather belongs on
the mmsys component. And it is not just a boolean. It should describe the
individual components in the pipline.

I.e. for DSI each conpatible would have an array (or read this from of_graph
but I think that was avoided for simplicity since we know what it is anyway?)

For example:

MT8365: ovl0, rdma0, color0, ccorr0, aal0, gamma0, dither0
MT8366/MT8189: ovl0, rdma0
MT8188: ovl0, rdma0, color0, ccorr0, aal0, gamma0, postmask0, dither0
MT8195: ovl0, rdma0, color0, ccorr0, aal0, gamma0, dither0, dsc0, merge0
MT8183: ovl0, ovl_2l0, rdma0, color0, ccorr0, aal0, gamma0, dither0

Plus HDMI and DP could have different piplines.



> +	bool cmdq_long_packet_ctl;
> +	u32 shadow_dbg_off;
> +	u32 vm_cmdq_off;
> +	u32 host_cmdq_off;
> +};
> +

...

> +static int mtk_dsi_power_on(struct mtk_dsi_priv *dsi,
> +			    const struct display_timing *timing)
> +{
> +	struct mipi_dsi_panel_plat *plat = dev_get_plat(dsi->panel);
> +	struct phy_configure_opts_mipi_dphy opts = { };
> +	int ret, bit_per_pixel;
> +
> +	bit_per_pixel = mipi_dsi_pixel_format_to_bpp(plat->format);
> +	if (bit_per_pixel < 0) {
> +		dev_err(dsi->dev, "unknown MIPI DSI format %d\n", plat->format);
> +		return bit_per_pixel;
> +	}
> +
> +	dsi->data_rate = DIV_ROUND_UP_ULL((u64)timing->pixelclock.typ *
> +					  bit_per_pixel, plat->lanes);
> +
> +	opts.hs_clk_rate = dsi->data_rate;
> +	opts.lanes = plat->lanes;
> +
> +	ret = generic_phy_configure(&dsi->phy, &opts);
> +	if (ret) {
> +		dev_err(dsi->dev, "failed to set the PHY to %llu Hz: %d\n",
> +			dsi->data_rate, ret);
> +		return ret;
> +	}
> +
> +	ret = generic_phy_power_on(&dsi->phy);
> +	if (ret) {
> +		dev_err(dsi->dev, "failed to power on the PHY: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_enable(dsi->engine_clk);
> +	if (ret) {
> +		dev_err(dsi->dev, "failed to enable engine clk: %d\n", ret);
> +		goto err_phy_power_off;
> +	}
> +
> +	ret = clk_enable(dsi->digital_clk);
> +	if (ret) {
> +		dev_err(dsi->dev, "failed to enable digital clk: %d\n", ret);
> +		goto err_disable_engine_clk;
> +	}
> +
> +	ret = mtk_disp_comp_enable(dsi->mutex);
> +	if (ret) {
> +		dev_err(dsi->dev, "failed to enable mutex: %d\n", ret);
> +		goto err_disable_digital_clk;
> +	}
> +
> +	ret = mtk_disp_comp_enable(dsi->ovl);
> +	if (ret) {
> +		dev_err(dsi->dev, "failed to enable ovl: %d\n", ret);
> +		goto err_disable_mutex;
> +	}
> +
> +	ret = mtk_disp_comp_enable(dsi->rdma);
> +	if (ret) {
> +		dev_err(dsi->dev, "failed to enable rdma: %d\n", ret);
> +		goto err_disable_ovl;
> +	}
> +

On the subject of replacing has_color_pipeline again. This would become
something like a for loop to enable the components used by the chosen dsi0
pipline.

Such code could also be shared with HDMI and DP implementations. They would
just have a different array (or in some cases the same) of pipline members.

> +	if (dsi->data->has_color_pipeline) {
> +		ret = mtk_disp_comp_enable(dsi->color);
> +		if (ret) {
> +			dev_err(dsi->dev, "failed to enable color: %d\n", ret);
> +			goto err_disable_rdma;
> +		}
> +
> +		ret = mtk_disp_comp_enable(dsi->ccorr);
> +		if (ret) {
> +			dev_err(dsi->dev, "failed to enable ccorr: %d\n", ret);
> +			goto err_disable_color;
> +		}
> +
> +		ret = mtk_disp_comp_enable(dsi->aal);
> +		if (ret) {
> +			dev_err(dsi->dev, "failed to enable aal: %d\n", ret);
> +			goto err_disable_ccorr;
> +		}
> +
> +		ret = mtk_disp_comp_enable(dsi->gamma);
> +		if (ret) {
> +			dev_err(dsi->dev, "failed to enable gamma: %d\n", ret);
> +			goto err_disable_aal;
> +		}
> +
> +		ret = mtk_disp_comp_enable(dsi->dither);
> +		if (ret) {
> +			dev_err(dsi->dev, "failed to enable dither: %d\n", ret);
> +			goto err_disable_gamma;
> +		}
> +	}
> +
> +	mtk_dsi_enable(dsi);
> +
> +	if (dsi->data->shadow_dbg_off)
> +		mtk_dsi_shadow_debug(dsi);
> +
> +	mtk_dsi_reset_engine(dsi);
> +
> +	mtk_dsi_phy_timconfig(dsi);
> +
> +	mtk_dsi_set_vm_cmd(dsi);
> +
> +	mtk_dsi_set_interrupt_enable(dsi);
> +
> +	return 0;
> +

...

> +static int mtk_dsi_probe(struct udevice *dev)
> +{
> +	struct mtk_dsi_priv *dsi = dev_get_priv(dev);
> +	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
> +	struct display_timing timing;
> +	struct udevice *mmsys_dev;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	/* Before relocation we don't need to do anything */
> +	if (!(gd->flags & GD_FLG_RELOC))
> +		return 0;
> +
> +	dsi->dev = dev;
> +	dsi->data = (const struct mtk_dsi_data *)dev_get_driver_data(dev);
> +	if (!dsi->data) {
> +		dev_err(dev, "missing dsi match data\n");
> +		return -EINVAL;
> +	}
> +
> +	dsi->base = dev_remap_addr(dev);
> +	if (!dsi->base)
> +		return -EINVAL;
> +
> +	dsi->engine_clk = devm_clk_get(dev, "engine");
> +	if (IS_ERR(dsi->engine_clk))
> +		return PTR_ERR(dsi->engine_clk);
> +
> +	/*
> +	 * The DSI host's "hs" clock is the MIPI TX PLL. U-Boot's MIPI TX driver
> +	 * does not register it as a clock, so it is not fetched here; its rate
> +	 * is set through generic_phy_configure() instead.
> +	 */
> +	dsi->digital_clk = devm_clk_get(dev, "digital");
> +	if (IS_ERR(dsi->digital_clk))
> +		return PTR_ERR(dsi->digital_clk);
> +
> +	ret = uclass_get_device_by_of_path(UCLASS_MISC, "ovl0", &dsi->ovl);
> +	if (ret) {
> +		dev_err(dev, "cannot get ovl device: %s\n", errno_str(ret));
> +		return ret;
> +	}
> +
> +	ret = uclass_get_device_by_of_path(UCLASS_MISC, "rdma0", &dsi->rdma);
> +	if (ret) {
> +		dev_err(dev, "cannot get rdma device: %s\n", errno_str(ret));
> +		return ret;
> +	}
> +
> +	if (dsi->data->has_color_pipeline) {

Obviosuly, more pipline stuff here...

> +		ret = uclass_get_device_by_of_path(UCLASS_MISC, "color0", &dsi->color);
> +		if (ret) {
> +			dev_err(dev, "cannot get color device: %s\n", errno_str(ret));
> +			return ret;
> +		}
> +
> +		ret = uclass_get_device_by_of_path(UCLASS_MISC, "ccorr0", &dsi->ccorr);
> +		if (ret) {
> +			dev_err(dev, "cannot get ccorr device: %s\n", errno_str(ret));
> +			return ret;
> +		}
> +
> +		ret = uclass_get_device_by_of_path(UCLASS_MISC, "aal0", &dsi->aal);
> +		if (ret) {
> +			dev_err(dev, "cannot get aal device: %s\n", errno_str(ret));
> +			return ret;
> +		}
> +
> +		ret = uclass_get_device_by_of_path(UCLASS_MISC, "gamma0", &dsi->gamma);
> +		if (ret) {
> +			dev_err(dev, "cannot get gamma device: %s\n", errno_str(ret));
> +			return ret;
> +		}
> +
> +		ret = uclass_get_device_by_of_path(UCLASS_MISC, "dither0", &dsi->dither);
> +		if (ret) {
> +			dev_err(dev, "cannot get dither device: %s\n", errno_str(ret));
> +			return ret;
> +		}
> +	}
> +

...

> +	mtk_dsi_set_display_mode(dsi, &timing);
> +
> +	mtk_dsi_lane_ready(dsi);
> +
> +	ret = mtk_ovl_layer(dsi->ovl, plat, &timing);
> +	if (ret)
> +		goto err_power_off;
> +
> +	mmu_set_region_dcache_behaviour(plat->base, ALIGN(plat->size, MMU_SECTION_SIZE),
> +					DCACHE_WRITEBACK);

Do we actually need mmu_set_region_dcache_behaviour()? AFAIKT, this
DCACHE_WRITEBACK attribte is already set by default since we are using
PTE_BLOCK_MEMTYPE(MT_NORMAL) for the whole DRAM.

I think the ALIGN() would cause it to touch memory we didn't allocate too.

> +	video_set_flush_dcache(dev, true);
> +
> +	ret = panel_set_backlight(dsi->panel, BACKLIGHT_DEFAULT);
> +	if (ret && ret != -ENOSYS) {
> +		dev_err(dev, "failed to set backlight\n");
> +		goto err_power_off;
> +	}
> +
> +	ret = panel_enable_backlight(dsi->panel);
> +	if (ret) {
> +		dev_err(dev, "failed to enable backlight\n");
> +		goto err_power_off;
> +	}
> +
> +	mtk_dsi_output_enable(dsi);
> +
> +	return 0;
> +

...

> +U_BOOT_DRIVER(mtk_dsi) = {
> +	.name	   = "mtk_dsi",
> +	.id	   = UCLASS_VIDEO,
> +	.of_match  = mtk_dsi_ids,
> +	.probe	   = mtk_dsi_probe,
> +	.bind	   = mtk_dsi_bind,
> +	.priv_auto = sizeof(struct mtk_dsi_priv),
> +	.flags	   = DM_FLAG_PRE_RELOC | DM_FLAG_LEAVE_PD_ON,

I think we should swap DM_FLAG_LEAVE_PD_ON for DM_FLAG_OS_PREPARE and add a
.remove() callback that shuts everything down. AFAICT, there is nothing in
Linux that knows how to properly take over from U-Boot here. And when I run
this on Genio 360, when Linux starts, the screen gets corrupted and slowly
fades to black. With a proper .remove() callback, then Linux works as it
should.

We would need to fix Linux first in order to make this actually work as-is.

> +};
> 

