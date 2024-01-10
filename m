Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F377C4707B
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 15:12:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 407BA8771B;
	Wed, 10 Jan 2024 16:12:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="aqv9O5bJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE96A87508; Wed, 10 Jan 2024 16:12:17 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B64AC8771B
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 16:12:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50e7c6f0487so4364574e87.3
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 07:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1704899534; x=1705504334; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CYoqAT2EhyqTMATuqdrEnb5kM/M76x0Jhxh/dZgYvYk=;
 b=aqv9O5bJXKQ8ah8fQwB2bu++8zt4R4sJhrhUcLLfEbqVMBFf96seANIeaNhMkPRMvn
 zH/K4jj/FRjXb4+2DP1/ryQk3j+MDs/bypIh6VI8LF3QByYgESEy/iPKEADhqVctyLtn
 n4JcWZaBlnacD7auqw6oDekWkmQXLwyCmgbXIyabiAEFZq7LB6bfIVI6yA7h/ouKgVfp
 o+4teXVhx1qyvL1o9DvHJcERCwBcmNZxb7BgvJ03p6DWoIT43YMv2CzShKACsmwIQwtB
 vzItJJQrKKEVisgxh+JwqeSTbk1kYVEobu5IzXAUo3JrTwkyksIoKniCuLNkw1sttT9t
 leFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704899534; x=1705504334;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CYoqAT2EhyqTMATuqdrEnb5kM/M76x0Jhxh/dZgYvYk=;
 b=tsnR7RZYV/UUypnkwn/+8wlyTDa+TjAZ7A1o2r3vF3M3ZOtjfvjnpcjjO+nxtgidfi
 ToM2srBKbmsE8NSCWapT+rCH40pgQ3jMdfpO3JS2ENjwIK8fJL3qU05gK52eG3u2FPTI
 1B//s7OLy4yOsaM2rPDy4yvp+0bsJjEReHwj6VXmapzuAxR3ctuwgh3YEwbmTPLMzkd6
 oS6qG3PMiTLCy/farDYiEsv+o6v98GSP+yKWeBqhIB4KaJRa02RjcX99ytZv/dLrDukL
 WHVXDSMDXyuwn+pYP+UoREzuJml3W04hzZ6bIQRimnVCtjUUi9eu7cNRGIVKPP0Ahpmo
 bulw==
X-Gm-Message-State: AOJu0YzAKvfLM7sXcKUuCfNN2d62y99XmOCC1N9wXY4uEsG7zA84IdJV
 KXsDM3JiQ1rm5flb48TtXNq0FWNMGolbQQ==
X-Google-Smtp-Source: AGHT+IFYUokh5pyNIU6D7NTxQGKQbbbZ5FYntDIiemG+8C03EOVd5bjY7PyaYGjy8iAIPIgOrGHB/Q==
X-Received: by 2002:ac2:41d0:0:b0:50e:84f8:77d4 with SMTP id
 d16-20020ac241d0000000b0050e84f877d4mr312179lfi.153.1704899534472; 
 Wed, 10 Jan 2024 07:12:14 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.188])
 by smtp.gmail.com with ESMTPSA id
 w130-20020a0dd488000000b005d317074440sm1626379ywd.79.2024.01.10.07.12.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 07:12:13 -0800 (PST)
Message-ID: <2fc1ea46-78d0-4ce2-aabc-d78f826152a4@suse.com>
Date: Wed, 10 Jan 2024 16:12:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] bcm2835: Dynamically calculate bytes per pixel
 parameter
Content-Language: en-US, ca-ES, es-ES
To: "Ivan T. Ivanov" <iivanov@suse.de>, Peter Robinson <pbrobinson@gmail.com>
Cc: Dmitry Malkin <dmitry@bedrocksystems.com>,
 Thomas Fitzsimmons <fitzsim@fitzsim.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 wahrenst@gmx.net, florian.fainelli@broadcom.com, u-boot@lists.denx.de
References: <20240110122908.31612-1-iivanov@suse.de>
 <20240110122908.31612-5-iivanov@suse.de>
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20240110122908.31612-5-iivanov@suse.de>
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



On 10/01/2024 13:29, Ivan T. Ivanov wrote:
> brcm,bcm2708-fb device provided by firmware on RPi5 uses
> 16 bits per pixel, so lets calculate framebuffer bytes
> per pixel dynamically based on queried information.
> 
> Tested to work for RPi2b v1.2, RPi3b v1.3, RPi4b v1.1,
> RPi2 Zero W, RPi5b v1.0.
> 
> Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   drivers/video/bcm2835.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/bcm2835.c b/drivers/video/bcm2835.c
> index 14942526f1..63efa762db 100644
> --- a/drivers/video/bcm2835.c
> +++ b/drivers/video/bcm2835.c
> @@ -16,7 +16,7 @@ static int bcm2835_video_probe(struct udevice *dev)
>   	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
>   	struct video_priv *uc_priv = dev_get_uclass_priv(dev);
>   	int ret;
> -	int w, h, pitch;
> +	int w, h, pitch, bpp;
>   	ulong fb_base, fb_size, fb_start, fb_end;
>   
>   	debug("bcm2835: Query resolution...\n");
> @@ -41,9 +41,23 @@ static int bcm2835_video_probe(struct udevice *dev)
>   					DCACHE_WRITEBACK);
>   	video_set_flush_dcache(dev, true);
>   
> +	bpp = pitch / w;
> +	switch (bpp) {
> +	case 2:
> +		uc_priv->bpix = VIDEO_BPP16;
> +		break;
> +	case 4:
> +		uc_priv->bpix = VIDEO_BPP32;
> +		break;
> +	default:
> +		printf("bcm2835: unexpected bpp %d, pitch %d, width %d\n",
> +		       bpp, pitch, w);
> +		uc_priv->bpix = VIDEO_BPP32;
> +		break;
> +	}
> +
>   	uc_priv->xsize = w;
>   	uc_priv->ysize = h;
> -	uc_priv->bpix = VIDEO_BPP32;
>   	plat->base = fb_base;
>   	plat->size = fb_size;
>   
