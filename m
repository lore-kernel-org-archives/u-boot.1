Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40439C47DD9
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 09:21:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97EE8880F8;
	Fri, 22 Mar 2024 10:21:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RvVwk8dL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ACE98818A; Fri, 22 Mar 2024 10:21:09 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90DEC880F8
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 10:21:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a4702457ccbso257958766b.3
 for <u-boot@lists.denx.de>; Fri, 22 Mar 2024 02:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711099266; x=1711704066;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=mgfGf+K6ftsIur2z+HvATylOwNcowsVXj5frkXDE88E=;
 b=RvVwk8dLJNZmpCJp+iOU4zS1ESanUhwp0dyepwlvwuPzeAiyJ8giyHT0GVYUAAn6+G
 rtMkBHsbs2Q8T+e/M8zejfMBemGJDhc/4ImHStQcMOWtIsrWOepbbcHYjAE/ZIlNA02q
 +VZyWD/Ewf4mCfE0fcNtnTs1gcO/+8uWojqDo/AkwBSQLONhCyAZ6Va9b3edIXOA4gPr
 AKYzqfnXRVir84Kh3OEzJLMzCS7WuFdG/X83iUSbAZVM7+sAR2nmr3E9s3jmWlOS2Smn
 /zrcBDXiTqY8ujF/PXYAXlgTxF+tpNXlDwQp1t7eLc5+uJj54cXjqumGNcWvcs2C1bdu
 yjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711099266; x=1711704066;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mgfGf+K6ftsIur2z+HvATylOwNcowsVXj5frkXDE88E=;
 b=Yb8wYQG1oPZL5C68YRsbwgavZcw/XEl5xqGb4dtN+BoTP6e3MRABV6osE+4huxexfn
 9VuatuvPhHSOO1HllIUEU6//RIz7zb2BPU1ZHoEuMRTYsfETUm1wgricpoZp6q7wQ3M9
 fhsSeJqf6bS7wl+HBJyDzLgTwL3ZL7p2dqaChvdymyOLRysbx3GzDNZg6dDsrKHi+Mye
 C8d4H+956yA+IX28rJ7nJ1RUpPyfKHbh1GofJC+mIpQACKxnYSSsvhfCSp9gGuo5IVbQ
 k7e76yetSiRtyJjU1azX9i8jCmkVkGgoqR0IBFWqFXkYXkvrW3+cnNWzWMJV3mkrNf3O
 n0Dg==
X-Gm-Message-State: AOJu0YwyfhgyyZ89xCgnMpPkaK37BZPh540GRivzfvwoKdnS2ghn4+vU
 WN+9n1PT37TufPlXYcH9QhcvcGc3pLPwev7wsKy14++POgO1PWZEUGZ+zWMbO8KTYu47dUKQBFu
 l
X-Google-Smtp-Source: AGHT+IGb/Z/XVi07hPz4/Eub1GGr32MJyp2w5K1j5oY2xBnYlegw1wMA0NLRoFS39I8AslbQeMG1Ww==
X-Received: by 2002:a17:906:c08:b0:a46:9773:81ef with SMTP id
 s8-20020a1709060c0800b00a46977381efmr1172015ejf.71.1711099265737; 
 Fri, 22 Mar 2024 02:21:05 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 e13-20020a05600c218d00b00412cfdc41f7sm2499097wme.0.2024.03.22.02.21.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 02:21:05 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Caleb Connolly <caleb.connolly@linaro.org>, Lukasz Majewski
 <lukma@denx.de>, Marek Vasut <marex@denx.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] usb: gadget: UMS: fix 64-bit division on ARM32
In-Reply-To: <28654ab1-a45f-4c21-ace8-68da9e4af26f@linaro.org>
References: <20240321153004.709994-2-caleb.connolly@linaro.org>
 <87frwjedjq.fsf@baylibre.com>
 <28654ab1-a45f-4c21-ace8-68da9e4af26f@linaro.org>
Date: Fri, 22 Mar 2024 10:21:04 +0100
Message-ID: <87a5mqei67.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Caleb,

On jeu., mars 21, 2024 at 17:01, Caleb Connolly <caleb.connolly@linaro.org> wrote:

> On 21/03/2024 16:48, Mattijs Korpershoek wrote:
>> Hi Caleb,
>> 
>> Thank you for the patch.
>> 
>> On jeu., mars 21, 2024 at 15:28, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>> 
>>> The patch introducing support for dynamic sector sizes changed the types
>>> used in some divisions, resulting in the compiler attempting to use
>>> libgcc helpers (__aeabi_ldivmod). Replace these divisions with calls to
>>> lldiv() to handle this correctly.
>>>
>>> Fixes: 74e56e0c5065 ("usb: gadget: UMS: support multiple sector sizes")
>>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> 
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> 
>> Would it be okay if I squashed this into
>> commit 74e56e0c5065 ("usb: gadget: UMS: support multiple sector sizes")
>> ?
>> 
>> I'd like to not (intentionally) send any patches that don't compile to Tom.
>
> For sure, feel free to do that.

Done, here:
https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/304fa0aa445384e5e681a54abf413850591cec10

>> 
>> 
>>> ---
>>> Hi Mattijs,
>>>
>>> Sorry for not catching that sooner! I compile tested this locally and a
>> 
>> No worries, thanks a lot for the quick fix.
>> 
>>> CI pipeline is running here: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipelines/20029
>> 
>> I can see from the above pipeline that some other failures are ongoing,
>> but they are not related to lldiv().
>> 
>> arm-linux-gnueabi-ld.bfd: common/dfu.o: in function `run_usb_dnl_gadget':
>> common/dfu.c:82:(.text.run_usb_dnl_gadget+0xd8): undefined reference to `dm_usb_gadget_handle_interrupts'
>> arm-linux-gnueabi-ld.bfd: common/dfu.c:108:(.text.run_usb_dnl_gadget+0x11c): undefined reference to `dm_usb_gadget_handle_interrupts'
>> make[1]: *** [Makefile:1793: u-boot] Error
>
> Ah! I guess this is caused by the "select DM_USB_GADGET" patch...
>
> You can revert it for now and I'll just select DM_USB_GADGET for qcom.

Will do, I'll drop it from the branch.

>
> It seems like there's a bunch going on around here with the cleanup by
> Marek. I can revisit this once that's settled

Yeah, we are working on reworking the interrupt handling a bit since it
has quite some limitations.

>> 
>> See: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/jobs/802759#L470
>> 
>> I suspect that this is related to:
>> https://lore.kernel.org/r/all/20240225152715.1821613-1-jonas@kwiboo.se/
>
> Is this fixed by the ("usb: udc: dwc3: Fold board
> dm_usb_gadget_handle_interrupts() into DWC3") series?

Unfortunately, no:
https://source.denx.de/u-boot/custodians/u-boot-dfu/-/jobs/803228#L578

>> 
>> 
>>>
>>> Regards,
>>> Caleb
>>> ---
>>>  drivers/usb/gadget/f_mass_storage.c | 13 +++++++------
>>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
>>> index d880928044f4..ef90c7ec7fb5 100644
>>> --- a/drivers/usb/gadget/f_mass_storage.c
>>> +++ b/drivers/usb/gadget/f_mass_storage.c
>>> @@ -239,8 +239,9 @@
>>>  /* #define VERBOSE_DEBUG */
>>>  /* #define DUMP_MSGS */
>>>  
>>>  #include <config.h>
>>> +#include <div64.h>
>>>  #include <hexdump.h>
>>>  #include <log.h>
>>>  #include <malloc.h>
>>>  #include <common.h>
>>> @@ -768,10 +769,10 @@ static int do_read(struct fsg_common *common)
>>>  		}
>>>  
>>>  		/* Perform the read */
>>>  		rc = ums[common->lun].read_sector(&ums[common->lun],
>>> -				      file_offset / curlun->blksize,
>>> -				      amount / curlun->blksize,
>>> +				      lldiv(file_offset, curlun->blksize),
>>> +				      lldiv(amount, curlun->blksize),
>>>  				      (char __user *)bh->buf);
>>>  		if (!rc)
>>>  			return -EIO;
>>>  
>>> @@ -942,10 +943,10 @@ static int do_write(struct fsg_common *common)
>>>  			amount = bh->outreq->actual;
>>>  
>>>  			/* Perform the write */
>>>  			rc = ums[common->lun].write_sector(&ums[common->lun],
>>> -					       file_offset / curlun->blksize,
>>> -					       amount / curlun->blksize,
>>> +					       lldiv(file_offset, curlun->blksize),
>>> +					       lldiv(amount, curlun->blksize),
>>>  					       (char __user *)bh->buf);
>>>  			if (!rc)
>>>  				return -EIO;
>>>  			nwritten = rc * curlun->blksize;
>>> @@ -1058,10 +1059,10 @@ static int do_verify(struct fsg_common *common)
>>>  		}
>>>  
>>>  		/* Perform the read */
>>>  		rc = ums[common->lun].read_sector(&ums[common->lun],
>>> -				      file_offset / curlun->blksize,
>>> -				      amount / curlun->blksize,
>>> +				      lldiv(file_offset, curlun->blksize),
>>> +				      lldiv(amount, curlun->blksize),
>>>  				      (char __user *)bh->buf);
>>>  		if (!rc)
>>>  			return -EIO;
>>>  		nread = rc * curlun->blksize;
>>> -- 
>>> 2.44.0
>
> -- 
> // Caleb (they/them)
