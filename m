Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76145CD98F2
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 21:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C53D584067;
	Thu, 13 Nov 2025 22:57:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xJ3aLTdD";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Vwe3sgFn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5061984001; Thu, 13 Nov 2025 22:57:55 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59C6784001
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 22:57:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4d6vJx02qtz9tdy;
 Thu, 13 Nov 2025 22:57:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763071073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=imA9lDiseDRn50qfIlhkcx+XOa0eVO1TCsRT3JJt5AQ=;
 b=xJ3aLTdDFDm8B2t9DJc/VxQx7N0XrB411+LaAHNfDRe9Xhd2mchAj/dApSozheW8TbRoLH
 72Lsc/L7jrusomMILNZaO+c+uvq5qTY5UylPFPVniw7bXcP01cUJUjdrp5r0GV7rtzJfmv
 N+HCiad4Su/LM1whjDMCeMrP2DAUe4JSxMlXEbqSQYoVcSdkbPPx/hOxuoXvWxStC1u6Jw
 i2RjZFj0LXYYooQN+1R84pHVvu7BHBZBWbJ7cD7xY5CvjjfvzaYFgIYrW9CIQ5UidDZVUa
 viUO+j/fbTOS0Z6HK616/Mbmfgsos4Tw8Cfl6xtiGpOugv5ycoQd03kgh8F6bA==
Message-ID: <81115588-50c7-4ecc-975e-13994101955f@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763071071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=imA9lDiseDRn50qfIlhkcx+XOa0eVO1TCsRT3JJt5AQ=;
 b=Vwe3sgFnNGGzBD6DU3eh7VTTmMV/TFpCdSfVCzoUEzBFiLxJyucR6mY3kUwQsR6LefCwKA
 C3/d2l3VKaHKq5M19/RsWhxwKyfPRnA+Pmm1U6wTqPaNANKQFqSKxXpQ732ApX84cy0HvN
 3rQ1DvxTS28oNyvscaVu9yO9UYRrHvyUGyP+OVZOUHUjbLLFEFpOOAVb0G2+/1j+had2ZG
 vINCgNchYYbCFUme3P8HO84eCAiUtIvJEj0ew4ceQef9XjLoCIfOGoX0LAYCemAG31qDo2
 SwY/rXMXrZJx1FevTkE9vBVbIQG5Wjddrfnk5w76FlJdXdEDphqCMxl9Xac/hg==
Date: Thu, 13 Nov 2025 22:56:22 +0100
MIME-Version: 1.0
From: Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH] boot: Assure FDT is always at 8-byte aligned address
To: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
References: <20251113115516.947835-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTg0ByjUGgX4MSbU=i0oG7fuidM4J0J128ER6Aq+r6HW9A@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAFLszTg0ByjUGgX4MSbU=i0oG7fuidM4J0J128ER6Aq+r6HW9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 23ce0fe6792ca3456f3
X-MBO-RS-META: xjxmsbu5q8ctmeb48kgchbj9fjamt3xo
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

On 11/13/25 8:33 PM, Simon Glass wrote:

Hello Simon,

>> The fitImage may contain FDT at 4-byte aligned address, because alignment
>> of DT tags is 4 bytes. However, libfdt and also Linux expects DT to be at
>> 8-byte aligned address. Make sure that the DTs embedded in fitImages are
>> always used from 8-byte aligned addresses. In case the DT is decompressed,
>> make sure the target buffer is 8-byte aligned. In case the DT is only
>> loaded, make sure the target buffer is 8-byte aligned too.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
>> Cc: u-boot@lists.denx.de
>> ---
>>   boot/image-fit.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/boot/image-fit.c b/boot/image-fit.c
>> index 2f2d3e9304d..cccaa48f683 100644
>> --- a/boot/image-fit.c
>> +++ b/boot/image-fit.c
>> @@ -23,7 +23,6 @@
>>   #include <log.h>
>>   #include <mapmem.h>
>>   #include <asm/io.h>
>> -#include <malloc.h>
>>   #include <memalign.h>
>>   #include <asm/global_data.h>
>>   #ifdef CONFIG_DM_HASH
>> @@ -36,6 +35,7 @@ DECLARE_GLOBAL_DATA_PTR;
>>   #include <bootm.h>
>>   #include <image.h>
>>   #include <bootstage.h>
>> +#include <malloc.h>
>>   #include <upl.h>
>>   #include <u-boot/crc.h>
>>
>> @@ -2279,7 +2279,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
>>
>>                  log_debug("decompressing image\n");
>>                  if (load == data) {
>> -                       loadbuf = malloc(max_decomp_len);
>> +                       loadbuf = memalign(8, max_decomp_len);
>>                          load = map_to_sysmem(loadbuf);
>>                  } else {
>>                          loadbuf = map_sysmem(load, max_decomp_len);
>> @@ -2291,6 +2291,11 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
>>                          return -ENOEXEC;
>>                  }
>>                  len = load_end - load;
>> +       } else if (load_op != FIT_LOAD_IGNORED && image_type == IH_TYPE_FLATDT &&
>> +                  ((uintptr_t)buf & 7)) {
>> +               loadbuf = memalign(8, len);
>> +               load = map_to_sysmem(loadbuf);
>> +               memcpy(loadbuf, buf, len);
>>          } else if (load != data) {
>>                  log_debug("copying\n");
>>                  loadbuf = map_sysmem(load, len);
>> --
>> 2.51.0
>>
> 
> We really can't do a memory allocation in fit_image_load() !

We already do, notice the malloc() when "decompressing image" part.

> The problem should be fixed higher up, in its callers, etc. For one
> thing, the caller knows whether it is a DT or not, so putting this
> logic here is messy. See boot_get_fdt_fit()

This is triggered by a fitImage with DT embedded in that fitImage as 
non-external-data. That DT is at 4-byte aligned address, so how can the 
caller deal with it ? The caller gets a fitImage, which itself is at 
8-byte aligned address, but the DT in it is not at 8-byte aligned 
address, so that DT has to be relocated somehow and that happens here.
