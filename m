Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2EEBD10DBD
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 08:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 203C48948A;
	Mon,  2 Dec 2024 09:29:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ewW27qBV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2474289471; Mon,  2 Dec 2024 09:29:24 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06028894A8
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 09:29:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5d0cfb9fecaso2553559a12.2
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 00:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733128161; x=1733732961; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6uBOYAauAL/3sFIAElYT/52BMcyACXCHT26UMDCKbjM=;
 b=ewW27qBVOlEKuezANX1rBnftC3niQtl1KCV/zf79POGt9hO/kz8zcKQdrn0dK+ybt3
 L/IBqZahgCOVU6vh6tSn+5fXlao6ThvNklIc7pWji3/m9pFiwdhJqu0WnWbHRHHtc1Di
 s58R1HIENR2TIZ2ZwZnObmFVos5NQhbJbZjKFpZETzj6BCKKGIX5RA7tK0cD3AL6hIOu
 VJgZudC32qwhmhs2bsmKI8pIBC5b/O7ioTg4TLyw2XNKtIGXF40Nusw0XMYTENmacycG
 84KFH9xFTixXoiemyFSVL4agBTn4bCKzocUjepZfyU1YxiEje1MWooOLYaLQSSehOKiU
 KT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733128161; x=1733732961;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6uBOYAauAL/3sFIAElYT/52BMcyACXCHT26UMDCKbjM=;
 b=cl+FdCeXZvj+sZf30DwshXEv7zJA4mh9iVN2myooAW6rYTImkLpYWX/su9v+9Wndru
 D9Ha5Ve2KBiXcRgsLgWt3KNbLusyhZSQafwKPHdI0u/STqDmcIp2mI9hCl4ebhzCMXTM
 VNakUAumFgvlbbiFq47iESwl7cCZbHPzi2qV0GAYZTbUd/b1jhGak++Aq3FaqdO8Vb3D
 fFCx82qoN9uZ6pAtew/3CR2nn1YLP5UIgMLoJ8Fjni6bBmH27KQPMSvv/AjpUga/EHMU
 aPF5V1CKvPW+5W/it+D1ZdygYAEkhPKrv+CAH/bKFHBptMYAUrxESuKNrNc9cdAR6ZWW
 dCYQ==
X-Gm-Message-State: AOJu0YzynL1Hx6Co1bley2faQNGRfpdIChBbw6pJpJyj6IQ2LNS6NEIl
 X91IGGH0XtlbvgEKGq4oXm0bZmL2KFo/7gsIS+QcPxF1EM3zWlCKJFNnmXDhNx4=
X-Gm-Gg: ASbGncuO8LD+rwN4uN753Zks8DMxL415AcQj/oqG5wzkBAXI769C7zgbizw74AQF8Ej
 KHcwXdLsC2Sf6dKUW4DRr5nMSYCaba/KJz9eAA2q65MubEdy0iWSX8Od314B2UbyOR6oLIiwH/U
 GJkBlK24wFHK6cMtx4LGzp0vDR2S9M8ATZ7XlO2ue/W8g3w4X/vVxiZP6gIXRX1l1yW96LUaIe2
 yXAtwBxas/QEEYkk3dQ2WGAJcLC5R1pJ1EV1AShB3Li4+yJf7l2uBvlU7yxnrSCLD38MGJK7+2g
 /vNN/+/ooCEBs4WClV94hNQ0g9M=
X-Google-Smtp-Source: AGHT+IFNab/00r24P0UiVPKITOljHej+fU+Pf9zLUzwU2rsaU33dS2Suhadfgt/BgBhRvNvFmK1RpQ==
X-Received: by 2002:a05:6402:2692:b0:5d0:81f3:18bc with SMTP id
 4fb4d7f45d1cf-5d081f3194cmr15957983a12.1.1733128161448; 
 Mon, 02 Dec 2024 00:29:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:cdc0:f84:b603:ad96?
 ([2a01:e0a:3cb:7bb0:cdc0:f84:b603:ad96])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d0d49fc12bsm1987553a12.73.2024.12.02.00.29.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 00:29:21 -0800 (PST)
Message-ID: <8153132c-bf59-462d-b159-942ec6c99587@linaro.org>
Date: Mon, 2 Dec 2024 09:29:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] binman: Avoid skipping binman_init()
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-7-sjg@chromium.org>
 <20241201165007.GU3600562@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241201165007.GU3600562@bill-the-cat>
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



On 12/1/24 17:50, Tom Rini wrote:
> On Sun, Dec 01, 2024 at 07:42:34AM -0700, Simon Glass wrote:
>> A recent lwip change stopped binman's init from working, so it is not
>> possible to read nodes from the image description anymore.
>>
>> Correct this by dropping the offending line.
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>> Fixes: 4d4d7838127 net: lwip: add TFTP support and tftpboot command
>> ---
>>
>>  lib/binman.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/lib/binman.c b/lib/binman.c
>> index 93d85548116..9047f5275f3 100644
>> --- a/lib/binman.c
>> +++ b/lib/binman.c
>> @@ -137,7 +137,6 @@ int binman_init(void)
>>  {
>>  	int ret;
>>  
>> -	return 0;
>>  	binman = malloc(sizeof(struct binman_info));
>>  	if (!binman)
>>  		return log_msg_ret("space for binman", -ENOMEM);
> 
> Erm, Jerome, do you recall why you were doing that at all to start with?
> Or some sort of mis-merge locally that was (sadly) missed on review.

Oops! It is a local hack I had in my branch to run tests on the i.MX8MPlus
EVK with NET_LWIP enabled. On that board I would keep getting errors like:

 initcall failed at call 0000000040222de0 (err=-11)
 ### ERROR ### Please RESET the board ###

...and the "return 0'; was a quick way to work around to proceed with
testing.

Sorry for inadvertently leaving it in :-/ Now I suppose I should try again
the imx8mp_evk_defconfig build and see if the issue is still there and needs
investigating.

Regards,
-- 
Jerome



