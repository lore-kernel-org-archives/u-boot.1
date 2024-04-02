Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6987FC6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 09:33:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B176B87FB5;
	Tue,  2 Apr 2024 11:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g/VlG7I/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6D2A88105; Tue,  2 Apr 2024 11:33:07 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A97A87F65
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 11:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a46cd9e7fcaso628773166b.1
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 02:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712050384; x=1712655184; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EpvD5hhwRUNWKHo3tWifhpIOqGXxugZLpCj0SwSLIBo=;
 b=g/VlG7I/mP/XnFyZDw6BfIrFqUCoVV0L0jdB3jAaGhL5zwDCgMRMFykOAValt4DOBm
 rDvYcsjLk2W/IOkmQ7iydhMDJVB0b1s/MeEsZEGU/toxJsRmW0w48etEeekgg3GoLvAA
 VA3FUMvt9QZrv5hW2bJmhRMRQ+SXFvv9Ojz9eA8bWh1fk4zYcsR8MbRWerCUPlGtAn83
 boHfmCaKr4BjWVK9h2BXamrPmqYVMb8CdtQ7QG19bkpi/cecYbedMDiJVigjfazU+S0o
 OsowziVk+7uXX/ufphC/oATt6L+MbAgTEce3MsN4NuechfBGJ2tsDv2x+TrkA5IOp5gQ
 ofwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712050384; x=1712655184;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EpvD5hhwRUNWKHo3tWifhpIOqGXxugZLpCj0SwSLIBo=;
 b=Z9uiRjEvoZvoycnbdtQv/ozs33o/6+54+LZiUNYFY9jQIzFgM1c1RjL1B936mxWXrf
 /m1jjtEO/DJ4P9gb05J2YBMUtMadYOCQj8NRjgd6PfeoC07mKkIdDxxsAuaECLLw1nT2
 UDSbrlidYeVjWzDvLiGnGN0Lp3tWPlvrSZBMRdXMbjDCPwpD4fxqLiCRx5sU7LUAgW+7
 51Mm7EqFdEjA1crJ1y2cv27Lv0aDE8VPCQ2Zv6WL3i+ZttNP1AZtSMrH4+S0Ph/IVWOl
 TL2EWHJq2aKZ2YLlf7mK0E1rMe/R+dOYloXY/qenEBw1i32qVYmFW7FJ2pAxpBkgoPwJ
 O7Ew==
X-Gm-Message-State: AOJu0Yx+kVhZm1jTP9JA9RYeqx3UQ2h2r9M+hyccN58MUIKCv5B0ONm8
 ted/bYrtc1k+U4BbcI9ex4JI4CiRVk4y9GmrAvrMuVfiaWyC126rpPtc15KALJQ=
X-Google-Smtp-Source: AGHT+IExkC/2/4vpRAXAta8qOxvkhwrCkQ9a0MESOTbb2Fazh8XufcZuvdp9mSkuXqiHLHTkhFS2Pw==
X-Received: by 2002:a17:906:4796:b0:a4e:61ac:c3e9 with SMTP id
 cw22-20020a170906479600b00a4e61acc3e9mr5448127ejc.31.1712050384478; 
 Tue, 02 Apr 2024 02:33:04 -0700 (PDT)
Received: from [192.168.1.23] (i5E863A89.versanet.de. [94.134.58.137])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a1709064f8100b00a46baba1a0asm6304684eju.100.2024.04.02.02.33.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 02:33:04 -0700 (PDT)
Message-ID: <88cbdf60-3eab-4291-b34c-bca18da700e0@linaro.org>
Date: Tue, 2 Apr 2024 11:33:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/16] usb: gadget: UMS: fix 64-bit division on ARM32
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
 <20240328-b4-qcom-livetree-v5-16-4e98228b3d03@linaro.org>
 <87edbogrbk.fsf@baylibre.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <87edbogrbk.fsf@baylibre.com>
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

Hi Mattijs,

On 02/04/2024 09:24, Mattijs Korpershoek wrote:
> Hi Caleb,
> 
> Thank you for the patch.
> 
> On jeu., mars 28, 2024 at 17:59, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> 
>> The patch introducing support for dynamic sector sizes changed the types
>> used in some divisions, resulting in the compiler attempting to use
>> libgcc helpers (__aeabi_ldivmod). Replace these divisions with calls to
>> lldiv() to handle this correctly.
>>
>> Fixes: 74e56e0c5065 ("usb: gadget: UMS: support multiple sector sizes")
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> 
> I believe I applied this already via [1]

Oh yes of course, I'm not sure quite how this patch ended up in my 
outbox, apologies for any confusion.
> 
> I plan to send your work to Tom this week.
> 
> Sorry for the delay!

No problem at all.

Thanks,
> 
> [1] https://lore.kernel.org/r/87a5mqei67.fsf@baylibre.com
> 
>> ---
>> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> ---
>>   drivers/usb/gadget/f_mass_storage.c | 13 +++++++------
>>   1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
>> index d880928044f4..ef90c7ec7fb5 100644
>> --- a/drivers/usb/gadget/f_mass_storage.c
>> +++ b/drivers/usb/gadget/f_mass_storage.c
>> @@ -239,8 +239,9 @@
>>   /* #define VERBOSE_DEBUG */
>>   /* #define DUMP_MSGS */
>>   
>>   #include <config.h>
>> +#include <div64.h>
>>   #include <hexdump.h>
>>   #include <log.h>
>>   #include <malloc.h>
>>   #include <common.h>
>> @@ -768,10 +769,10 @@ static int do_read(struct fsg_common *common)
>>   		}
>>   
>>   		/* Perform the read */
>>   		rc = ums[common->lun].read_sector(&ums[common->lun],
>> -				      file_offset / curlun->blksize,
>> -				      amount / curlun->blksize,
>> +				      lldiv(file_offset, curlun->blksize),
>> +				      lldiv(amount, curlun->blksize),
>>   				      (char __user *)bh->buf);
>>   		if (!rc)
>>   			return -EIO;
>>   
>> @@ -942,10 +943,10 @@ static int do_write(struct fsg_common *common)
>>   			amount = bh->outreq->actual;
>>   
>>   			/* Perform the write */
>>   			rc = ums[common->lun].write_sector(&ums[common->lun],
>> -					       file_offset / curlun->blksize,
>> -					       amount / curlun->blksize,
>> +					       lldiv(file_offset, curlun->blksize),
>> +					       lldiv(amount, curlun->blksize),
>>   					       (char __user *)bh->buf);
>>   			if (!rc)
>>   				return -EIO;
>>   			nwritten = rc * curlun->blksize;
>> @@ -1058,10 +1059,10 @@ static int do_verify(struct fsg_common *common)
>>   		}
>>   
>>   		/* Perform the read */
>>   		rc = ums[common->lun].read_sector(&ums[common->lun],
>> -				      file_offset / curlun->blksize,
>> -				      amount / curlun->blksize,
>> +				      lldiv(file_offset, curlun->blksize),
>> +				      lldiv(amount, curlun->blksize),
>>   				      (char __user *)bh->buf);
>>   		if (!rc)
>>   			return -EIO;
>>   		nread = rc * curlun->blksize;
>>
>> -- 
>> 2.44.0

-- 
// Caleb (they/them)
