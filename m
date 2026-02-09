Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F008E7E0D5
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 19:46:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99E26802C1;
	Mon,  9 Feb 2026 20:46:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HoSCsbC9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59F54805D7; Mon,  9 Feb 2026 20:46:33 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C8F680050
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 20:46:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-4362507f396so85053f8f.0
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 11:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770666390; x=1771271190; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=swONz7S7UVr4v8rkNEQSX5+keI2BAMIeLVoMPuizFdg=;
 b=HoSCsbC949dCZzTOECXMXgt1v7DCe9V6MUnCIrrVyyLKxvbU1zcCWTsZv2BJa62e48
 LQr9k9mPJ+suIecde6ysc0G/rLHJYss2JZuRMRlmwn3j6Ye8UPZuL5A3gGtgjshCDB9D
 3EMrgtWW8BMsC4hXSBQZ5A+81NL15JWwOXiO4hhtkHuMGG/ODvdonRxM/7I01D0NcGV7
 S1/IMTk8px1JKescZEuTITD6o3WeGCax9QkjOIVS9j2NmWW7yDsg2ZARJDzT7kSw6hpp
 VhajiWXhvcm3PLnR/vi4YVvUx0qhONTqB30yhp/c7wyfGXH9udWE0PgUJcSx/gpWJ0EU
 aqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770666390; x=1771271190;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=swONz7S7UVr4v8rkNEQSX5+keI2BAMIeLVoMPuizFdg=;
 b=e9rff4tnupGzmj/xI2KDiJogVhJVrjeGywV746KlakFI4Blxc0l8A3EfrkQT4UvOZl
 h6Kyqdol2MGR9jvb2Lz2R1wTqwkYfZspLEYTbtQbFoarXbmJYV+/BGKCoy1R/UlQ4KOs
 lzbmB2M/AQuOYZzHGmONWtPH9s/VkZWV5ofQtNk/VWoUhFTljCzWiH+N0Q4Q543f4AtP
 23P5RlE2YzWLwdqugIEtDz1DAIdVvzCiBz98p2iX6GCAbCldjllPU6pAynfAeUOvcGhC
 mc+98OnFH1MBDvG4PwwWfPgjbhgujTUwQ8Pl39YsIfsYztr6V4kSOcLZWlPI6LUFkS8R
 H+lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6b3fqJV4KJywt+0dBWsu1WaYFq19UQsCeZsVZbQNpU22DbjXknMaeKMu4GLgAw87hRkPKwz0=@lists.denx.de
X-Gm-Message-State: AOJu0YyoP+o00cjeBJuQXl5Mm1ZyKde5LsHDgRlShuk5fAQ4eALAj0OS
 P/hqxs0DpdvKGFxo2GX0Mzr4pEmiUfK7N8cXKkMUH0nmvUiU271HgjWyKLkJPTW11oisArkxtnP
 8cPDm
X-Gm-Gg: AZuq6aKqnnjSDh/5k4qa6Qzy4fMTMUXzhWs5zSN6DkdXwIeUHKPaDwlsZ/z6t3uz87d
 aiGq+PwqT4hsGH/BcB3Ebt0uF/2RU7l7EYUWEYO0lY8T9cjtJRlHXt8vTbHMXBF5gE7KeVuWVeN
 GnhlXCAxY4K17v0OVPAluDYOkKhaPHZrbDyap+bfj0bk2k5nAGbV0rE5/7T6TJVkolwqxw1gelO
 C3t5kmh7sUnI2Lv0mFZjBvvlJlh0FDEhX+/xBPdM646mXPX0I66PKZQ5+2c4SD2sD7Xrv3sHQVU
 QtE05tsIzzXbHXPP9mR+3NmDzGP5UHAo78sqy6cQl28bSzFlwM2BSE7rTXBYRVjI22kmn00t7zn
 d6WnqmKqJTa7nnUUXWGF5zyL+eHFRo6uf1kfRmnc0hs2++DaYQv7pliFbuOvcI7P/2N8w3QWsxg
 rGW4RhVJ6F1FTDm7NjXXXoueVViZbjJgneUMtsLtWns+JVp9bUog==
X-Received: by 2002:a05:6000:200d:b0:430:fa58:a03d with SMTP id
 ffacd0b85a97d-436293ae118mr20087177f8f.63.1770666390395; 
 Mon, 09 Feb 2026 11:46:30 -0800 (PST)
Received: from [192.168.1.36] (p5b29ea02.dip0.t-ipconnect.de. [91.41.234.2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bd4desm29142264f8f.18.2026.02.09.11.46.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 11:46:29 -0800 (PST)
Message-ID: <04da0c26-de14-4649-a2b4-cc68414b710a@linaro.org>
Date: Mon, 9 Feb 2026 20:46:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] scsi: Enable FUA bit in WRITE10 commands
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, neil.armstrong@linaro.org, quic_varada@quicinc.com,
 bmeng.cn@gmail.com, andrew.goodbody@linaro.org, u-boot@lists.denx.de
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
References: <20260122083954.2722972-1-balaji.selvanathan@oss.qualcomm.com>
 <20260122083954.2722972-3-balaji.selvanathan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260122083954.2722972-3-balaji.selvanathan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Balaji,

Needs a respin for your SoB but otherwise this series looks good!

Your cc list looks a bit sparse, I would highly highly recommend giving
the b4 tool a try! If not, you can try a script like this which should
pick up more people:
https://gist.github.com/kcxt/2bf9b7410fea3f841615beea5b593aaf

On 22/01/2026 09:39, Balaji Selvanathan wrote:
> From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> 
> Enable the Force Unit Access (FUA) bit in SCSI WRITE10 commands to
> ensure writes bypass the device's volatile cache and go directly to
> non-volatile storage. This provides write-through behavior that prevents
> data loss during board resets.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Reverted "scsi: sync cache on write" commit and then set the FUA bit
> 
>  drivers/scsi/scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
> index 2e99f68cc5a..153b4841add 100644
> --- a/drivers/scsi/scsi.c
> +++ b/drivers/scsi/scsi.c
> @@ -107,7 +107,7 @@ static void scsi_setup_write_ext(struct scsi_cmd *pccb, lbaint_t start,
>  				 lbaint_t blocks)
>  {
>  	pccb->cmd[0] = SCSI_WRITE10;
> -	pccb->cmd[1] = 0;
> +	pccb->cmd[1] = 0x08; /* Set FUA bit to bypass write cache */
>  	pccb->cmd[2] = (unsigned char)(start >> 24) & 0xff;
>  	pccb->cmd[3] = (unsigned char)(start >> 16) & 0xff;
>  	pccb->cmd[4] = (unsigned char)(start >> 8) & 0xff;

-- 
// Casey (she/her)

