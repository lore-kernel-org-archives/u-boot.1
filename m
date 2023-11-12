Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B755C4167B
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 16:46:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A70786D93;
	Sun, 12 Nov 2023 17:46:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="rzGIdsQr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E54386DD2; Sun, 12 Nov 2023 17:46:02 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 029F586D4C
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 17:46:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4EFFB3FADB
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 16:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1699807559;
 bh=zgZyE4i/zZLrWNXlYpid6cHtBF4EL0HwYhAeqLc8X6A=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=rzGIdsQreJCmlaDDUHeU0ogHXm0chnQtGu6x5DPrGiIxsaaixAghyGEVfKDOqQxvB
 W/01l1qO6IEBaMtYtlcYvtRgDJ7Rxvw8WaeU+gT4BCG7MKGwuxnI7CcYMUEF3z/qtK
 SldnMkZO3ITtNUlUKAKClcyFzyzGYKboKloIxz9yRblEKVd5PnS4igPszBt7OxW+Cp
 P0xPsCcYZUWH2FwpZpr3ItZqqihjW52YEJsh78WhWlfNqQeSx2paViRAlnjmFW4/p4
 YZSNi44M0SY4QaHqo1yLnW44x/15fE6u4VWvMaBcPFTUbKHoxLNFmAPwKF1PM+RVnU
 dudHvoTBdW8Sw==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4083fec2c30so23929195e9.1
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 08:45:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699807559; x=1700412359;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zgZyE4i/zZLrWNXlYpid6cHtBF4EL0HwYhAeqLc8X6A=;
 b=K8p0EHeaVVvJM90j5H4rbsRwE1KH7V1UAKktvgMIOfzFl/z/jsp/l+AzoWbPKVNyj8
 AWim267BghqO2K0U2TLifwmOZX8bbzog8Xs1reXgK5MBzodk7AZzh2kyMdxl53DeCRB5
 hFCgKC+Eh2Ng0fM4fVvemWAumR+RnwfDxiG9820hESw/zdA3Mwep7nEXoleiIY27VUnf
 XFOyoBgdqeOtrBMvjzKM/R700f63CZd3pCXZDn4qE2l3KTwwFUrHaBemZmERnyESdB7j
 wUEnH6dOI2d9s9XPSjwYJWLvwJ+4cCPudag2pG1E6tJHJb8rHhMTx+h1gelx9iBCbg3T
 kP5A==
X-Gm-Message-State: AOJu0YyGOgQyE9SQbAG2ZaSXTmvqXmMiUbiwoT2d1Qo+egaTQVSFlab5
 sr2fzXet6AHvqXSdgIF+y1c8JqOpseCJHI0IicwJ2bsQwwLil88c6Ii2YBL+o8IV8Y69Qw4Iu5k
 5uJdAz+UQkzvN/BMRMjaRtjlpwkDi+aY=
X-Received: by 2002:a05:600c:4694:b0:401:dc7c:2494 with SMTP id
 p20-20020a05600c469400b00401dc7c2494mr3815881wmo.27.1699807558980; 
 Sun, 12 Nov 2023 08:45:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLgBamAtncZs3+AOmlUilBxRZZ8NhOz1pVlw+8TQzmoV5sXzF2Yz6iq46QGeYDhVUuH2NA3Q==
X-Received: by 2002:a05:600c:4694:b0:401:dc7c:2494 with SMTP id
 p20-20020a05600c469400b00401dc7c2494mr3815873wmo.27.1699807558639; 
 Sun, 12 Nov 2023 08:45:58 -0800 (PST)
Received: from [192.168.123.94] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 16-20020a05600c021000b004060f0a0fdbsm11053231wmi.41.2023.11.12.08.45.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Nov 2023 08:45:57 -0800 (PST)
Message-ID: <781b39ed-9440-47c7-a457-22aff53ae494@canonical.com>
Date: Sun, 12 Nov 2023 17:45:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] acpi: Use __packed with struct acpi_xsdt
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20231112155808.135585-1-sjg@chromium.org>
 <20231112155808.135585-2-sjg@chromium.org>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20231112155808.135585-2-sjg@chromium.org>
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

On 11/12/23 16:58, Simon Glass wrote:
> Since struct acpi_table_header is not a multiple of 64 bits, use the
> __packed option for struct acpi_xsdt
> 
> This ensures that the entry[] array starts on the correct boundary.
> 

Typically we keep the original signed-off-by when reposting patches.

Thanks for picking this change up.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

As in your review you suggested to add a unit test I have done so in my v2:

[PATCH v2 1/2] acpi: fix struct acpi_xsdt
https://patchwork.ozlabs.org/project/uboot/patch/20231112070316.17982-2-heinrich.schuchardt@canonical.com/

> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   include/acpi/acpi_table.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/acpi/acpi_table.h b/include/acpi/acpi_table.h
> index 1f85de091d39..59ab79ed17c2 100644
> --- a/include/acpi/acpi_table.h
> +++ b/include/acpi/acpi_table.h
> @@ -80,7 +80,7 @@ struct acpi_rsdt {
>   };
>   
>   /* XSDT (Extended System Description Table) */
> -struct acpi_xsdt {
> +struct __packed acpi_xsdt {
>   	struct acpi_table_header header;
>   	u64 entry[MAX_ACPI_TABLES];
>   };

