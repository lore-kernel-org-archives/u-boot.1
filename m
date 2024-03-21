Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FF5C6FD1F
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 17:02:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D44A587D91;
	Thu, 21 Mar 2024 18:02:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CnOdt18a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CEDF87B77; Thu, 21 Mar 2024 18:02:02 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECCCC88013
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 18:01:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-41478297f78so2074965e9.3
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 10:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711040515; x=1711645315; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=REZ3FrA1okaB30+N+rXB3XgB/uUPFPhpwXlPu3g/74M=;
 b=CnOdt18a5i2ySd/C41wPXNfaSZYDg9W+BO6ABsDaQy13lSfQkhbYhencswbfpS5aQJ
 uMPMyDxOjlV1VUcI8nGAfN8o5XwDbNDd5kc6vSzMwaNypMDiTjaIlR31qtDpCBaDrqOQ
 tSYyIuIWq8IkfnHLRN+qekoSyl/37Gc/Lznsu6q4w58kfx8ZzDdaLOuXwpq+/w03sHbs
 Hhb/BzFXQtS2RPI6wWR1zkTmWs5KSYhsNz0kqzU2QUV0YsSP7QYgWWxNW1nou+63DD8g
 bBlYG9Q7W0QT1ZYqKyVkMBRMXDgScmlD7uQ3FOPUEYA1Qj9od0QiD+x8aTyCgTFbrVKy
 bvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711040515; x=1711645315;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=REZ3FrA1okaB30+N+rXB3XgB/uUPFPhpwXlPu3g/74M=;
 b=JGDrfQwpzaKcovNs9Qsof39yfKiSfevODEa1N3X9IrsrZBok2SHoGa0N1TCmxzUvrZ
 aXm3CZ0im0RF4YSolffAqPbdcUK6kKH/2LkF71c8C31KK43pCC5lh7VZmL0Mw2OxUzJZ
 MwA5r4OzPeLFV2Ucsud36F6F9gSEs4ypNsRCwPqrb65EPBAZGakdJXc1FA7s0C3/E8E5
 YeidG/uT90tLY17jfYARRfgr6legp62DtnEgn7A5IqocJgkG6YvdM3sQZoEyO1Woa48G
 jOOtngjgqLPKVNJpBWEAajCli1xSR1zSLNd/q1+I4BH7NIh5TVt7Dj/UG0fi5pvQP5tL
 MuZA==
X-Gm-Message-State: AOJu0YwXfCtjim3dYgyc9zAUizxtKeuUe9A7dmtnbZ5oNRbdef7hOhyG
 XOP865xqvGjig1ORAPVEgkRCRNOglMPNDEkv3Y9asnzhBqEdxAKoA1FdqhCjLQk=
X-Google-Smtp-Source: AGHT+IHIzb5xhcOmadxLGy8eqADlFoojL08BtEyUFDMQzmGVC4lcRCpvjnawPq2AiXnTJhcJkLDBRw==
X-Received: by 2002:a05:600c:4f88:b0:413:1318:b5d9 with SMTP id
 n8-20020a05600c4f8800b004131318b5d9mr8496786wmq.13.1711040515201; 
 Thu, 21 Mar 2024 10:01:55 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 j1-20020a05600c1c0100b00414055f20a9sm6124525wms.26.2024.03.21.10.01.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Mar 2024 10:01:54 -0700 (PDT)
Message-ID: <28654ab1-a45f-4c21-ace8-68da9e4af26f@linaro.org>
Date: Thu, 21 Mar 2024 17:01:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: UMS: fix 64-bit division on ARM32
Content-Language: en-US
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Lukasz Majewski <lukma@denx.de>, Marek Vasut <marex@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240321153004.709994-2-caleb.connolly@linaro.org>
 <87frwjedjq.fsf@baylibre.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <87frwjedjq.fsf@baylibre.com>
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



On 21/03/2024 16:48, Mattijs Korpershoek wrote:
> Hi Caleb,
> 
> Thank you for the patch.
> 
> On jeu., mars 21, 2024 at 15:28, Caleb Connolly <caleb.connolly@linaro.org> wrote:
> 
>> The patch introducing support for dynamic sector sizes changed the types
>> used in some divisions, resulting in the compiler attempting to use
>> libgcc helpers (__aeabi_ldivmod). Replace these divisions with calls to
>> lldiv() to handle this correctly.
>>
>> Fixes: 74e56e0c5065 ("usb: gadget: UMS: support multiple sector sizes")
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> 
> Would it be okay if I squashed this into
> commit 74e56e0c5065 ("usb: gadget: UMS: support multiple sector sizes")
> ?
> 
> I'd like to not (intentionally) send any patches that don't compile to Tom.

For sure, feel free to do that.
> 
> 
>> ---
>> Hi Mattijs,
>>
>> Sorry for not catching that sooner! I compile tested this locally and a
> 
> No worries, thanks a lot for the quick fix.
> 
>> CI pipeline is running here: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipelines/20029
> 
> I can see from the above pipeline that some other failures are ongoing,
> but they are not related to lldiv().
> 
> arm-linux-gnueabi-ld.bfd: common/dfu.o: in function `run_usb_dnl_gadget':
> common/dfu.c:82:(.text.run_usb_dnl_gadget+0xd8): undefined reference to `dm_usb_gadget_handle_interrupts'
> arm-linux-gnueabi-ld.bfd: common/dfu.c:108:(.text.run_usb_dnl_gadget+0x11c): undefined reference to `dm_usb_gadget_handle_interrupts'
> make[1]: *** [Makefile:1793: u-boot] Error

Ah! I guess this is caused by the "select DM_USB_GADGET" patch...

You can revert it for now and I'll just select DM_USB_GADGET for qcom.

It seems like there's a bunch going on around here with the cleanup by
Marek. I can revisit this once that's settled
> 
> See: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/jobs/802759#L470
> 
> I suspect that this is related to:
> https://lore.kernel.org/r/all/20240225152715.1821613-1-jonas@kwiboo.se/

Is this fixed by the ("usb: udc: dwc3: Fold board
dm_usb_gadget_handle_interrupts() into DWC3") series?
> 
> 
>>
>> Regards,
>> Caleb
>> ---
>>  drivers/usb/gadget/f_mass_storage.c | 13 +++++++------
>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
>> index d880928044f4..ef90c7ec7fb5 100644
>> --- a/drivers/usb/gadget/f_mass_storage.c
>> +++ b/drivers/usb/gadget/f_mass_storage.c
>> @@ -239,8 +239,9 @@
>>  /* #define VERBOSE_DEBUG */
>>  /* #define DUMP_MSGS */
>>  
>>  #include <config.h>
>> +#include <div64.h>
>>  #include <hexdump.h>
>>  #include <log.h>
>>  #include <malloc.h>
>>  #include <common.h>
>> @@ -768,10 +769,10 @@ static int do_read(struct fsg_common *common)
>>  		}
>>  
>>  		/* Perform the read */
>>  		rc = ums[common->lun].read_sector(&ums[common->lun],
>> -				      file_offset / curlun->blksize,
>> -				      amount / curlun->blksize,
>> +				      lldiv(file_offset, curlun->blksize),
>> +				      lldiv(amount, curlun->blksize),
>>  				      (char __user *)bh->buf);
>>  		if (!rc)
>>  			return -EIO;
>>  
>> @@ -942,10 +943,10 @@ static int do_write(struct fsg_common *common)
>>  			amount = bh->outreq->actual;
>>  
>>  			/* Perform the write */
>>  			rc = ums[common->lun].write_sector(&ums[common->lun],
>> -					       file_offset / curlun->blksize,
>> -					       amount / curlun->blksize,
>> +					       lldiv(file_offset, curlun->blksize),
>> +					       lldiv(amount, curlun->blksize),
>>  					       (char __user *)bh->buf);
>>  			if (!rc)
>>  				return -EIO;
>>  			nwritten = rc * curlun->blksize;
>> @@ -1058,10 +1059,10 @@ static int do_verify(struct fsg_common *common)
>>  		}
>>  
>>  		/* Perform the read */
>>  		rc = ums[common->lun].read_sector(&ums[common->lun],
>> -				      file_offset / curlun->blksize,
>> -				      amount / curlun->blksize,
>> +				      lldiv(file_offset, curlun->blksize),
>> +				      lldiv(amount, curlun->blksize),
>>  				      (char __user *)bh->buf);
>>  		if (!rc)
>>  			return -EIO;
>>  		nread = rc * curlun->blksize;
>> -- 
>> 2.44.0

-- 
// Caleb (they/them)
