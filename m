Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8653C27C6E
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 18:45:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 377E88892F;
	Thu, 13 Jun 2024 20:45:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KXPxcLQn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7283288936; Thu, 13 Jun 2024 20:45:53 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86D4F8890E
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 20:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-35f1c490c13so1504767f8f.3
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 11:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718304351; x=1718909151;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mh7W6T6SqG8CMQzFA/Ymw3JMWIwiWF76L+w9xYngh9A=;
 b=KXPxcLQnv4Y/HeL7xzIOMkA1oKQwnTYe3tgwCfVGV3HGaJNx9HBSGBUVJlJGd/t/Wh
 Ku3koElivdSZagPIXrIH5Pa8GUogT2HgIK6HK97jEMPRQjL4DTxWOZe1jP0SWtxM3OZL
 8rzbYWRi2QXNebtr4QFmhcWFhRjVNFbLKXek5lpKWWCWnyoQOW+QpFHtXQ1WYKsbUfQa
 nKUk6tMB+vPBiDMAQwE5yrFVCiZVfqM9GcEhlbrRhs7Mm4mZFG7CW08prBjPV/kweEyx
 +qFjFQ7UVXMcIGZJb5YZKQN4KSDla9HT23AmvgAdvm9SKIu3CKWlP0WEjwmoSxIj3f51
 YHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718304351; x=1718909151;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mh7W6T6SqG8CMQzFA/Ymw3JMWIwiWF76L+w9xYngh9A=;
 b=JADosIrd1gX3/feyLffeuRHrhyh4qkxn3K3A5xKZCfwCORWKXajPNZLaYq3BA64GEi
 QSp54/5peN5uWf52CNOVSMjvBOAHiJfB/Xb3ntDOO4nTiyEXksEZCmtkypPaEUVmfs8w
 oBPJ92rQ1+D0RljaVU6dCkgSdU6eNw+6jxledSUkzuYCgSmaPJDr/8in2DU9y/nRhqMz
 zxG3+5aZpBXKxNGCnT/hLqmUUTA7YaAeNFRCVosb5LhiTSK+vH26z9c2HhaLRgTQDL0T
 1g5eZ8m99rY/TsVKKmNmgQGWV7zJ7D4Mobv5eRjEY+UU1XD4/AgwUuSTdbgSqqISxC/2
 1Vrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7V9ApwY2gHplLMoxpEEHvhX4K9kRYxG8EsWdShQoE7b8SujgqkJ9peE1XYsvoy+Jmwz4ij6TiWS1WrizrlG1GLQHJEw==
X-Gm-Message-State: AOJu0YytLW9r4OzvmvkW9j/fgU9vxFa3V+Hd6hbjuq3s/ee4T93VG7KO
 stmeh91D7vf8gwaJFIu02C8xLAQ0bnCLuPUby7bhnjtTxseDLip3T6bynlrn018=
X-Google-Smtp-Source: AGHT+IHBL3tLD4wX12cxYBOvObPnYDDt/ROk9KQ/hlQo1PWUUADXQDC1pxpBG5liT3blxRFBAdQt6Q==
X-Received: by 2002:a5d:468a:0:b0:35f:2843:5382 with SMTP id
 ffacd0b85a97d-3607a7414famr500270f8f.1.1718304350977; 
 Thu, 13 Jun 2024 11:45:50 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:10a5:e010:c6c5:f5c5:a789:215?
 ([2a05:6e02:10a5:e010:c6c5:f5c5:a789:215])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075104b74sm2393585f8f.107.2024.06.13.11.45.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jun 2024 11:45:50 -0700 (PDT)
Message-ID: <cd8f9810-52d2-44f7-8f2f-22cdaa9a00c3@baylibre.com>
Date: Thu, 13 Jun 2024 20:45:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] android: boot: Add set_abootimg_addr() and
 set_avendor_bootimg_addr()
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>
Cc: Julien Masson <jmasson@baylibre.com>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de
References: <20240613-bootmeth-android-v2-0-397f6e66eb29@baylibre.com>
 <20240613-bootmeth-android-v2-3-397f6e66eb29@baylibre.com>
Content-Language: en-US
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <20240613-bootmeth-android-v2-3-397f6e66eb29@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Le 13/06/2024 à 12:13, Mattijs Korpershoek a écrit :
> The only way to configure the load addresses for both bootimg and
> vendor_bootimg is by using the "abootimg" command.
> If we want to use the C API, there is no equivalent.
>
> Add set_abootimg_addr() and set_avendor_bootimg_addr() so that we can
> specify the load address from C.
>
> This can be useful for implementing an Android bootmethod.
>
> Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>   cmd/abootimg.c  | 10 ++++++++++
>   include/image.h | 14 ++++++++++++++
>   2 files changed, 24 insertions(+)
>
> diff --git a/cmd/abootimg.c b/cmd/abootimg.c
> index 327712a536c0..ae7a1a7c83b0 100644
> --- a/cmd/abootimg.c
> +++ b/cmd/abootimg.c
> @@ -22,6 +22,11 @@ ulong get_abootimg_addr(void)
>   	return (_abootimg_addr == -1 ? image_load_addr : _abootimg_addr);
>   }
>   
> +void set_abootimg_addr(ulong addr)
> +{
> +	_abootimg_addr = addr;
> +}
> +
>   ulong get_ainit_bootimg_addr(void)
>   {
>   	return _ainit_bootimg_addr;
> @@ -32,6 +37,11 @@ ulong get_avendor_bootimg_addr(void)
>   	return _avendor_bootimg_addr;
>   }
>   
> +void set_avendor_bootimg_addr(ulong addr)
> +{
> +	_avendor_bootimg_addr = addr;
> +}
> +
>   static int abootimg_get_ver(int argc, char *const argv[])
>   {
>   	const struct andr_boot_img_hdr_v0 *hdr;
> diff --git a/include/image.h b/include/image.h
> index c5b288f62b44..df2decbf5c2a 100644
> --- a/include/image.h
> +++ b/include/image.h
> @@ -1970,6 +1970,13 @@ bool is_android_vendor_boot_image_header(const void *vendor_boot_img);
>    */
>   ulong get_abootimg_addr(void);
>   
> +/**
> + * set_abootimg_addr() - Set Android boot image address
> + *
> + * Return: no returned results
> + */
> +void set_abootimg_addr(ulong addr);
> +
>   /**
>    * get_ainit_bootimg_addr() - Get Android init boot image address
>    *
> @@ -1984,6 +1991,13 @@ ulong get_ainit_bootimg_addr(void);
>    */
>   ulong get_avendor_bootimg_addr(void);
>   
> +/**
> + * set_abootimg_addr() - Set Android vendor boot image address
> + *
> + * Return: no returned results
> + */
> +void set_avendor_bootimg_addr(ulong addr);
> +
>   /**
>    * board_fit_config_name_match() - Check for a matching board name
>    *
>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

