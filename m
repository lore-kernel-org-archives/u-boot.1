Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED97DD16242
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 11:20:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F64388E3F;
	Mon, 14 Oct 2024 13:20:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="fwGkT2io";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C989B88D9E; Mon, 14 Oct 2024 13:20:16 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5F1888703
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 13:20:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37d6ff1cbe1so877641f8f.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 04:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1728904813; x=1729509613; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LoBvuIkZLgCAFGo3JKPmnD2k3smkr3MdpNfpVqIkUIM=;
 b=fwGkT2ioWVMbEoPCf90U1AB8zeDwDQGfsKm4Dh5IatMrYFlOtWGQ2vNosKNWwHQepT
 UDTq8KcMWYPRbnn4LYJqbgRpAz3EfHjgETh/W2fgAQvq1Z09+iO9djj8whUtEQ5Ofd2p
 HPb1QpFaDAs/FQdPYmLKihD8BfLJ/rvfeg/9d/iY7M+FsC7estKVfbznXp8Ni1PSK+7r
 QxSokX+rJj0YYsDe59tALQA/3BiRAED1dCum6i8CNlpw7LC7gtr1o+ujgkiRAMsAXl0p
 ZiS/A/teLSHHyfczuB1JRwO0QUJtuOL6T/nBPibGJsMcRbXTAaOov3GOrhD90ZYCaR/g
 GqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728904813; x=1729509613;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LoBvuIkZLgCAFGo3JKPmnD2k3smkr3MdpNfpVqIkUIM=;
 b=Y2AHl4fUJ+T/IUsiJazZ8/VgXyJP/xHUFsy6o8qrJ21X5A9XCTWtUs9f2dbh8ffnKv
 Yli2OwgoI8LpeJ810hoVJC0ZKmZeUMZ09bgXQWyEG5n2tQUHYCqm+I5P3ldzXfniR+EY
 x8LzBKCQ6WHrY5m5vPnl81yo/x52+kEd3DhsCEnMO0pftoTBVbhvs5UoUDZm2PMfDZwz
 rpE7muWv1UCjL6/Nss1AgtOE/eSiBseT7kdfLxCjiuNHMG3wu9ObSrYtsq67KvemCFXE
 lioo5xKRe2F+xAT2RSJQUnAehDgSohKSxj0pkbQiMKg68Xfr1MhnTZFfZOO0egZN3yZw
 wrIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbIjUMilvNhzYF2dGMZ1zXL0tNIvtxCD2W4v8wm4ycEH9Z6OG8Gxu/oSt/vXAHe/zVcDtrkd8=@lists.denx.de
X-Gm-Message-State: AOJu0YxssaxufovyEELX6HC6TxsLHl+iWYsL57WbaFpXX0OI4kscbN45
 mm9R0GjwYp16YEN4XPq81FWHeskEgONst6ObrGMtbG/ZvnIX2yxNB9a2PYewnIU=
X-Google-Smtp-Source: AGHT+IHAaky2NfB1Y16vTNwjFUKvEEdI6saASMUkstYCTinzZnbq89G6lBX2/AQ1qCsEDiTSLoEQVg==
X-Received: by 2002:a05:6000:bc4:b0:368:3731:1613 with SMTP id
 ffacd0b85a97d-37d551ca21amr6454235f8f.13.1728904813180; 
 Mon, 14 Oct 2024 04:20:13 -0700 (PDT)
Received: from [192.168.42.132] ([81.95.8.245])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d4b7ef4f6sm11249069f8f.107.2024.10.14.04.20.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2024 04:20:12 -0700 (PDT)
Message-ID: <d7508980-6977-4f9b-a4c4-4cfe41d816d7@suse.com>
Date: Mon, 14 Oct 2024 13:20:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: rpi: Pass CMA through from firmware DT
To: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
References: <20241011170914.1980541-1-pbrobinson@gmail.com>
Content-Language: en-US
From: Matthias Brugger <mbrugger@suse.com>
In-Reply-To: <20241011170914.1980541-1-pbrobinson@gmail.com>
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



On 10/11/24 19:09, Peter Robinson wrote:
> For a lot of usecases, such as display, camera, media
> the Raspberry Pi needs a lot more CMA than distros
> configure as default so we should pass this parameter
> through so things work as expected. Fix a spelling
> mistake while we're at it.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Acked-by: Matthias Brugger <mbrugger@suse.com>

> ---
> 
> v2: Update the cma string
> 
>   board/raspberrypi/rpi/rpi.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index ab5ea85cf9f..dd5a318d239 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -540,12 +540,15 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
>   	if (fdt == fw_fdt)
>   		return;
>   
> -	/* The firmware provides a more precie model; so copy that */
> +	/* The firmware provides a more precise model; so copy that */
>   	copy_property(fdt, fw_fdt, "/", "model");
>   
>   	/* memory reserve as suggested by the firmware */
>   	copy_property(fdt, fw_fdt, "/", "memreserve");
>   
> +	/* copy the CMA memory setting from the firmware DT to linux */
> +	copy_property(fdt, fw_fdt, "/reserved-memory/linux,cma", "size");
> +
>   	/* Adjust dma-ranges for the SD card and PCI bus as they can depend on
>   	 * the SoC revision
>   	 */

