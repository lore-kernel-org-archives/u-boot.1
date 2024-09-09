Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6C4EDE996
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 03:20:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D4A788F16;
	Tue, 10 Sep 2024 05:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bVU0GLlY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A59B6889C9; Mon,  9 Sep 2024 18:38:46 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D52588CC9
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 18:38:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-374b5f27cf2so2646407f8f.1
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 09:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725899915; x=1726504715; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=73ZxkAFtjsAgLJROOk8HViLVzQXrEUYItZxYr5nqaew=;
 b=bVU0GLlYX0Y5KeMrvqZt5U2dNIbpelEtLObcxAfUciGFFkbZjt2UIFH/kpnsXT/vC3
 cuArkaxAk/QR5IE3S/cpzOyUfqskORdwIAPiMKZt8+MNbKxT+U/E0wE6xDkFkLLHz6o+
 g6WwkoPBgsLn8nCQeiDHQhcyBmcPrO75W5lTI8gXZRZI4zfLkQ/c2iTToeS+wapYJOjT
 dRi1dPlnpNNbjkiGCvRzVJ760jPrtRvFzfnXVUmyEtehbxSRNtOUXK/skGy55XHlFX7l
 Xt6vlJ/nBDpo3BCk4+i9kTyHWmFNCfJ1jHa6tRFacjPfVGLHliovamJUyCJXy7E+5Ogd
 MpTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725899915; x=1726504715;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=73ZxkAFtjsAgLJROOk8HViLVzQXrEUYItZxYr5nqaew=;
 b=PpvdPLb7E7fk6RXSIfkmM4HZ/1dlHHX2rGnFeEMPpRq1TR/szNIjrnEKS+EX8oQiET
 al/nZIYFwxX//3sQvbLaXvvN/HeEmua8Y6Qkqxc3PRW+/OBJuNKD9ZctW+GuSCoFf6Pm
 Whx+SlyIUq3NkvWVupENIkMCWYIyQdmAKKKx+cACP25eHCN7So+SH1UQS1gF0f/4LL8G
 mTbgBiUmWfE7gCqUg0fSb8Fw/v54pVffILSVKKaBe6Y1Vng8j3MCOUGFLkgurg5mBeQz
 pg8G1x20zdgmo5rj/Z7YoqwPz5M/dT6tDpg1x4WuSSryrWp5GlhBDbcKLpKYEFb3gzaF
 PkQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLgIpqweT2TwRe5yu6ZXYgjAWm7CJuWDhbSxD33DoNju7HiEfEIs/GyjORapafiHOywbMul8E=@lists.denx.de
X-Gm-Message-State: AOJu0YzNkRXyTTdRjISZ3YTEdWxcHfJvtm/f0B8lPQMTJT0y6yZLVuLB
 7z4nitjGCVSEiraSK62jFRFGlagkiLkrqMKH3Rvj6VlAVh8wFaEv
X-Google-Smtp-Source: AGHT+IEDnDTXUgEpcOpGNwp5U1BP6n4eMvCKSg6cIK7nejcsuItzTdzJm5cVgKqGz4CyhXzGiPLi7w==
X-Received: by 2002:adf:fc91:0:b0:374:c432:4971 with SMTP id
 ffacd0b85a97d-3789268e9a0mr5155407f8f.16.1725899914738; 
 Mon, 09 Sep 2024 09:38:34 -0700 (PDT)
Received: from [192.168.0.61] ([79.115.63.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956d35e5sm6472162f8f.76.2024.09.09.09.38.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 09:38:34 -0700 (PDT)
Message-ID: <32c83c27-ff9e-4316-8ba1-9cbf8fe89ed3@gmail.com>
Date: Mon, 9 Sep 2024 19:38:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor-ids: Deduplicate mx25u25635f entry
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Dhruva Gole <d-gole@ti.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Jim Liu <jim.t90615@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Michal Simek <michal.simek@amd.com>,
 Neal Frager <neal.frager@amd.com>, Prasad Kummari <prasad.kummari@amd.com>,
 Teik Heng Chong <teik.heng.chong@intel.com>, Tom Rini <trini@konsulko.com>,
 Vignesh R <vigneshr@ti.com>
References: <20240906211022.193224-1-marex@denx.de>
From: Tudor Ambarus <tudor.ambarus@gmail.com>
Content-Language: en-US
In-Reply-To: <20240906211022.193224-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 10 Sep 2024 05:19:45 +0200
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

Hiya,

On 07.09.2024 00:10, Marek Vasut wrote:
> The mx25u25635f entry exists twice in spi_nor_ids, remove the less
> complete variant of the entry and keep only one copy of it.
> 
> Fixes: f0084f1dfdbc ("drivers/mtd/spi/spi-nor-ids.c: add mx25u25635f support")

Or one can directly revert the offending commit as it dropped support
for the 4b opcodes. Looks good anyway:

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>


> Signed-off-by: Marek Vasut <marex@denx.de>
> Reviewed-by: Michal Simek <michal.simek@amd.com>
> ---
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
> Cc: Dhruva Gole <d-gole@ti.com>
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Jim Liu <jim.t90615@gmail.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Neal Frager <neal.frager@amd.com>
> Cc: Prasad Kummari <prasad.kummari@amd.com>
> Cc: Teik Heng Chong <teik.heng.chong@intel.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Vignesh R <vigneshr@ti.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
> index d1389e681d6..5582a978ab5 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -258,7 +258,6 @@ const struct flash_info spi_nor_ids[] = {
>  	{ INFO("mx25u6435f",  0xc22537, 0, 64 * 1024, 128, SECT_4K) },
>  	{ INFO("mx25l12805d", 0xc22018, 0, 64 * 1024, 256, SECT_4K) },
>  	{ INFO("mx25u12835f", 0xc22538, 0, 64 * 1024, 256, SECT_4K) },
> -	{ INFO("mx25u25635f", 0xc22539, 0, 64 * 1024, 512, SECT_4K) },
>  	{ INFO("mx25u51245g", 0xc2253a, 0, 64 * 1024, 1024, SECT_4K |
>  	       SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>  	{ INFO("mx25l12855e", 0xc22618, 0, 64 * 1024, 256, 0) },
