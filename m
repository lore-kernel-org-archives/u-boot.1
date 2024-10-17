Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81195D37481
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 12:14:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0849488E5C;
	Thu, 17 Oct 2024 14:14:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2cSFmxc9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4C2188FB7; Thu, 17 Oct 2024 14:14:13 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D38688E32
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 14:14:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4305413aec9so9555155e9.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 05:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729167249; x=1729772049;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=pJbt29j8gZhI+6b+qqEknGKTIzM0T6t5S9EjgPGSjyU=;
 b=2cSFmxc9q4Zdvb3wZaC2PM2IJ62hMg13EWkFagUjRn1pjBuqyex/DLReRIeVUMpvBs
 LlPN1aUKnHybOU1RW5sXiA2DtFNsSpZrDOyIVRErbRHM7viXJegX0y0DKsKZDh42p/8z
 iXg5WaBZSchL4VecBVaIp8NmiE6Yef2Ang8/XQ6IuBiZdu6yuQkOVPf1YKGMp9iuisL3
 mu1tUcuXF0qV0dP6kPqwiqt4VGRP6x85L1cyoZdijL1IDifOPbuuUZTMyJCjxt5wCr69
 Vzeb6sZ3ee4GmILbBPAYSKWkP+9hHYwOHduzjAwfqpjL26vmHE4ps9mERHKyJR/zmbSN
 xCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729167249; x=1729772049;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pJbt29j8gZhI+6b+qqEknGKTIzM0T6t5S9EjgPGSjyU=;
 b=XUPdhYn1sAVf8TpUNsnah3YNuw2WMcuPsWqhGU/rKYUbDfNHPHDIAE761NncxCOOFI
 Z63TisHawTd7d5qX9zp/8LOxet7diVb1Csf9nbM/gaUKFJ0PTUwVM6W+JJM29LZ8qxSU
 Ik/DJRa7eO90HvrTft7lqtsPzl6I2ZSIIU2jmY7i7hascc3dyY+38wn3Y5sikKgXbgn2
 9QrUeRoe7eSGEMxwJ35jvPgUCeSo8tjBlKSQHVKB70batVfZbU2F025xDdHdw3CKBfgI
 cDMlvAIAEtojXoEbp0LfXzbFZuZzrrUCeDlHGoqoZLMWfV2ntckowOE128LxXCs0zbmr
 DsLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKxOO7ntZAYJ0DKU1DM579xbjAH9EixJ5VCJ8YUTXYuTi85yf+6mHHyJRZeo4AmZZ7Jg4J90A=@lists.denx.de
X-Gm-Message-State: AOJu0YxlesizvDCbkBeqgijwtaDROWeFXq0ikLSN/JCg5Rqi47Zzr1VD
 2x3bG6oUXZ38cr6x3DobcEGe/sgVcqy0vEaXvQ7swv9klIaSXvH4Fte0rHDMAF0=
X-Google-Smtp-Source: AGHT+IFvFjV5NnoMorrXeF+8Nujgk23MueA1dz+JVs6FzZZ3oBpxAzVE/ZekD1+ZqL40fljapYw1wg==
X-Received: by 2002:a05:600c:4f46:b0:431:5a0e:fa2e with SMTP id
 5b1f17b1804b1-4315a0efb12mr17013175e9.21.1729167248653; 
 Thu, 17 Oct 2024 05:14:08 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa87c4fsm7098311f8f.31.2024.10.17.05.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 05:14:08 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: neil.armstrong@linaro.org, Tom Rini <trini@konsulko.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH 0/3] image: android: misc fixes when using on Qualcomm
 platforms
In-Reply-To: <87y12n0w68.fsf@baylibre.com>
References: <20241016-topic-fastboot-fixes-mkbootimg-v1-0-94fd9340722b@linaro.org>
 <87ed4f2ccc.fsf@baylibre.com> <871q0f2b72.fsf@baylibre.com>
 <66f2ba28-6415-4d0e-87c7-b7d235929569@linaro.org>
 <87y12n0w68.fsf@baylibre.com>
Date: Thu, 17 Oct 2024 14:14:05 +0200
Message-ID: <87v7xr0vw2.fsf@baylibre.com>
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

On jeu., oct. 17, 2024 at 14:07, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:

> Hi Neil,
>
> On jeu., oct. 17, 2024 at 14:01, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
>> On 17/10/2024 13:58, Mattijs Korpershoek wrote:
>>> Hi Neil,
>>> 
>>> On jeu., oct. 17, 2024 at 13:33, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:
>>> 
>>>> Hi Neil,
>>>>
>>>> Thank you for the series.
>>>>
>>>> On mer., oct. 16, 2024 at 17:46, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>>>
>>>>> When trying to use the Android boot image with header version 2
>>>>> on recent Qualcomm platforms, we get into some troubles.
>>>>>
>>>>> First the kernel in-place address can be > 32bit, then since
>>>>> we use the Android mkbootimg, it uses the default load address
>>>>> which isn't big enough to uncompress the kernel.
>>>>>
>>>>> Finally, the ramdisk also uses a default load address, and
>>>>> it should be taken in account like for the kernel address.
>>>>>
>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>> ---
>>>>> Neil Armstrong (3):
>>>>>        image: android: use ulong for kernel address
>>>>>        boot: image-android: do not boot XIP when kernel is compressed
>>>>>        image: android: handle ramdisk default address
>>>>
>>>> I have boot tested aosp/main on Khadas VIM3 using
>>>> khadas_vim3_android_defconfig
>>>>
>>>> This ensures that boot image v2 still works.
>>>>
>>>> I also tried to boot test the Beagle Play board (which runs Android 14
>>>> with boot image v4).
>>>>
>>>> Unfortunetly, that does not boot. The kernel starts but then I see:
>>>>
>>>> [    0.434360][    T1] /dev/root: Can't open blockdev
>>>> [    0.439587][    T1] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
>>>>
>>>> Full boot logs:
>>>> https://paste.debian.net/1332547/
>>>>
>>>> Full boot logs on master:
>>>> https://paste.debian.net/1332548/
>>>>
>>>> It seems that somehow, the bootconfig section is no longer present.
>>>>
>>>> I'll try to identify the offending patch and help debug this.
>>> 
>>> Offending patch is
>>>    [PATCH 3/3] image: android: handle ramdisk default address
>>
>> Thanks for looking
>>
>>> 
>>> The following (invalid) diff "fixes it"
>>> 
>>> modified   boot/image-android.c
>>> @@ -448,9 +448,9 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
>>>   	}
>>>   
>>>   	printf("RAM disk load addr 0x%08lx size %u KiB\n",
>>> -	       ramdisk_ptr, DIV_ROUND_UP(img_data.ramdisk_size, 1024));
>>> +	       img_data.ramdisk_addr, DIV_ROUND_UP(img_data.ramdisk_size, 1024));
>>>   
>>> -	*rd_data = ramdisk_ptr;
>>> +	*rd_data = img_data.ramdisk_addr;
>>>   
>>>   	*rd_len = img_data.ramdisk_size;
>>>   	return 0;
>>> 
>>> I'll debug a bit more.
>>
>> OK so this basically reverts the patch, so it means on Beagle Play
>> the 0x11000000 is valid and can't use the randisk in-place.
>>
>> img_data.ramdisk_ptr is the "real" address the data has been loaded to,
>> and img_data.ramdisk_addr is the address passed to mkbootimg, where it
>> should be loaded.
>
> Beagle Play uses boot image v4, therefore, we go through the following
> code path:
>
> 	if (img_data.header_version > 2) {
> 		/* Ramdisk can't be used in-place, copy it to ramdisk_addr_r */
> 		if (img_data.ramdisk_addr == ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR) {
> 			ramdisk_ptr = env_get_ulong("ramdisk_addr_r", 16, 0);
> 			if (!ramdisk_ptr) {
> 				printf("Invalid ramdisk_addr_r to copy ramdisk into\n");
> 				return -EINVAL;
> 			}
> 		} else {
> 			ramdisk_ptr = img_data.ramdisk_addr;
> 		}
> 		memcpy((void *)(ramdisk_ptr), (void *)img_data.vendor_ramdisk_ptr,
> 		       img_data.vendor_ramdisk_size);
> 		ramdisk_ptr += img_data.vendor_ramdisk_size;
> 		memcpy((void *)(ramdisk_ptr), (void *)img_data.ramdisk_ptr,
> 		       img_data.boot_ramdisk_size);
> 		ramdisk_ptr += img_data.boot_ramdisk_size;
> 		if (img_data.bootconfig_size) {
> 			memcpy((void *)
> 			       (ramdisk_ptr), (void *)img_data.bootconfig_addr,
> 			       img_data.bootconfig_size);
> 		}
>
> We can see here, that we **increment** ramdisk_ptr.
>
> Therefore, the following line is invalid:
>
>     *rd_data = ramdisk_ptr;
>
> Because ramdisk_ptr is not at the beginning of the ramdisk, but at the
> beginning of bootconfig.
>
> I think saving ramdisk_ptr in the above block should fix the issues I see.

The following diff fixes the issue I see on Beagle Play with boot image
v4:

diff --git a/boot/image-android.c b/boot/image-android.c
index a261bb639990..e9d898e003f6 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -424,6 +424,7 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
                } else {
                        ramdisk_ptr = img_data.ramdisk_addr;
                }
+               ulong ramdisk_begin_ptr = ramdisk_ptr;
                memcpy((void *)(ramdisk_ptr), (void *)img_data.vendor_ramdisk_ptr,
                       img_data.vendor_ramdisk_size);
                ramdisk_ptr += img_data.vendor_ramdisk_size;
@@ -435,6 +436,11 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
                               (ramdisk_ptr), (void *)img_data.bootconfig_addr,
                               img_data.bootconfig_size);
                }
+               /*
+                * Since we moved ramdisk_ptr, restore it back to the beginning
+                * of the ramdisk
+                */
+               ramdisk_ptr = ramdisk_begin_ptr;
        } else {
                /* Ramdisk can be used in-place, use current ptr */
                if (img_data.ramdisk_addr == 0 ||

(it's not super clean, but the general idea should work)
Can you add something similar for v2?

>
>>
>> Neil
>>
>>> 
>>>>
>>>>>
>>>>>   boot/image-android.c    | 60 +++++++++++++++++++++++++++++++++++++------------
>>>>>   include/android_image.h |  2 +-
>>>>>   2 files changed, 47 insertions(+), 15 deletions(-)
>>>>> ---
>>>>> base-commit: d5cab0d6adc26ec1bbd45c2fed101184d04454ae
>>>>> change-id: 20241016-topic-fastboot-fixes-mkbootimg-8d73ab93db3d
>>>>>
>>>>> Best regards,
>>>>> -- 
>>>>> Neil Armstrong <neil.armstrong@linaro.org>
