Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FEF8C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 07:51:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4BE9886CC;
	Fri, 19 Apr 2024 09:51:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="He1US8DL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8B49886D1; Fri, 19 Apr 2024 09:51:07 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE52688692
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 09:51:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 64FDF3F366
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 07:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1713513065;
 bh=Hri9oAV5oJsUaKx9hzF9oRMgzGotyb8FUgiTJIaFb/M=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=He1US8DLP+MoXtdOWH8oakBlTXmcmC4lTAIjja6Pd+sBdntOqM6O1V+yFGzq8D4F2
 IM+Hpf07EZgvRoRxIT6JrvxmYrpsvXYZiQmiyXOCBwe0h7FDZOcWTCURG1qPYuZrWC
 BU62fyRbERVY5t6/IkXelKlJ6u1rtD9c5u/qiQAi6J3y1xF+QC0FogeZnt+8/5fAAM
 al9LUhM1Xc1VG28d0UySdqNXDVX9CTwQd64AU+CVJYJeBJtUJPOmSXm87h3111LIM3
 wP4MNBfFAMYX05DvhgXObGqxuIhdGkCBxgdBZSr+C74G94TKp5nKddZKFm5s1nfp+n
 DyGoOy6uEvPUA==
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4183909fec8so14515295e9.0
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 00:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713513063; x=1714117863;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hri9oAV5oJsUaKx9hzF9oRMgzGotyb8FUgiTJIaFb/M=;
 b=HtvmWBvaBhQN5zKTiULQjeD41hsqDAt1uM4xnNT4DakbfejzNMpNdurmMXg9bpzOVg
 Mfz5/GvkHBVATIZngct3nruLkMOBI13T39fL9RrKReKaWyfMo0HzGUXti6DBOH4jXqjD
 2r9BT8Jp9DHBVcw7ZAYFGNW65kpohL2tZvCct9Wr1bnpJhweOLjuMbYAdHD4O8CFze3y
 dYaLRutQ5kC+Xo6BZ7GxK/J+lxMCFnY+/pUw/J7rzWBltFnUdRHvMPqrfrwfMtynJtHE
 OtxvaU4MnBRT7ADEYk6C0Szv1/tBlpyvfz4yJ/X6ue4fYgDPUWB1QT81TmiGvC2+u+X6
 9gWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUunft8mnmcQX4joytzhpX5Xz3xFkAZi6T/jOtZJiAo+6NjfHT94fms+mO6HlWeyAhDW34T1wFmFL4rn4pDq0ryz5GX/Q==
X-Gm-Message-State: AOJu0YzMJ7Ctheyp5Hj9oB3YCoux9Ubuvs/BIfmCDvyRJNmLGM+MOBUt
 1jnafzbPMtsZW7IZ6XkvWnlYdKZPtYTNWbCO/ebr8hHK5lkyLX70arqbbj6FvIX6Y78nrj+OG1A
 ogGDfxqmu4rpH7IbMwKy+PjNN/Hqrp1sA6keTyBHZlX6WI4znCYpR+I0l/Lk+EGCcwnU=
X-Received: by 2002:a05:600c:4f44:b0:418:3577:32ad with SMTP id
 m4-20020a05600c4f4400b00418357732admr1137616wmq.38.1713513063058; 
 Fri, 19 Apr 2024 00:51:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAEmwTvlKYg46RcoqC+uplg4SsHvecs6uKLLU2KqV5DpfkGhvjZblixdO/oVf3B3AZTX776A==
X-Received: by 2002:a05:600c:4f44:b0:418:3577:32ad with SMTP id
 m4-20020a05600c4f4400b00418357732admr1137590wmq.38.1713513062671; 
 Fri, 19 Apr 2024 00:51:02 -0700 (PDT)
Received: from [192.168.123.126]
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 n17-20020a05600c501100b00418f1d77098sm3838438wmr.25.2024.04.19.00.51.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 00:51:02 -0700 (PDT)
Message-ID: <1499200d-1e1d-4223-b26e-6d70d45bdbfe@canonical.com>
Date: Fri, 19 Apr 2024 09:51:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: change the error message when storing EFI
 variables
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Weizhao Ouyang <o451686892@gmail.com>,
 u-boot@lists.denx.de
References: <20240419074201.9053-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20240419074201.9053-1-ilias.apalodimas@linaro.org>
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

On 19.04.24 09:42, Ilias Apalodimas wrote:
> When we try to store EFI variables on a file, we need to use an ESP.
> if an ESP is not found, variables will change in memory, but U-Boot
> won't be able to restore them across reboots.
> 
> Adjust the error message so users can understand what's going on
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>   lib/efi_loader/efi_var_file.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
> index 413e1794e88c..5276740ffe7a 100644
> --- a/lib/efi_loader/efi_var_file.c
> +++ b/lib/efi_loader/efi_var_file.c
> @@ -82,7 +82,7 @@ efi_status_t efi_var_to_file(void)
>   
>   error:
>   	if (ret != EFI_SUCCESS)
> -		log_err("Failed to persist EFI variables\n");
> +		log_err("ESP not found. UEFI variables won't persist reboots\n");

%s/reboots/reboot/  We can't look further into the future.

A missing ESP is not the only possible failure cause. How about

* no space on disk
* already 512 entries in FAT12 root directory

Best regards

Heinrich

>   	free(buf);
>   	return ret;
>   #else

