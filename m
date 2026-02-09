Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF6AE7E0C3
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 11:05:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8137A8341A;
	Mon,  9 Feb 2026 12:05:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sEoIUk29";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9292A839A5; Mon,  9 Feb 2026 12:05:44 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9847805D7
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 12:05:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4359108fd24so2746387f8f.2
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 03:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770635141; x=1771239941;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8vTM69Qa7ER/4yRcoT1vvmj96hv6tJ2cKVQrBP8mWtE=;
 b=sEoIUk2994Js4s1wchjDfIJT5dMDFSlt7q4hvSzJG4LrbQgkbFfm+PtkQ76nlpkFf9
 S7ao3xTkbOdYPQ1G7iJVR7gj2vB3y98J8MyySkc4yeA67wPtU/VlIkXK7s757mTy57m4
 k2hOz5bE9uWcyFTPxCmcEmeGzNTf8QR79WLyRdcb+6hEKrcDVw8N0/F/4IFYetc9HGSC
 1BYRWfqHxux4y1sZqqSHu035R3JG7ClkcNPZ0EqDbnhUjq5XD5As4Z5sEQHRbQlbHO0d
 C2QWoW1iIXESHCh3I/K7/7ajR3k9s8XPevi3b1lwScVwTCWBzekofafee0lZRUhZuGBd
 nBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770635141; x=1771239941;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8vTM69Qa7ER/4yRcoT1vvmj96hv6tJ2cKVQrBP8mWtE=;
 b=c4fZb14NIzO9+9e8ARJAKMyf/t7xSKZ0a+2beb61Itjsn7OEzyEe+I9AnUUcC0sH9I
 lIvEwoz7mYzaHtVpkwDiLG3h8jwT7ELkwkWJR3nxLUcKqIL99YsPNSLrEuRJVJgsmAy1
 Elxj7tYhA5XrrvRGd+7wndD1Slwi8NpTY8OtAnyw2TGU5Ikh6ZXL0m/NszWuH0ZxNYCU
 1AVR2FyAAAeJpFrGhg4XjD1FZpia2X5Ig5oy7ySJ8tioVAnCEcc2w5etD6OROVg3416W
 aQMtzksRCmpc6/3keQoCZugWAhmTn62pw74enC/F5yHZzc6+cZl68DBjaqGtMOipaiRU
 bMrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh3qGVJNU8z6VKyhnAmDqTrZdmuMuEqWBW3rcvAa6sHagajns/rIFmX7Bd4nM3FrGkV8n/E/o=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+mtt2zWMHWqBLfHZ0zQNmCA3r3LQB1yTscSkv1BAU5iavdri8
 NTT97ISX9EXo0Pc409dSFaKVcjy2x2AKeulRWoldZm+3hnljfsOihQ6HqHRIzc88qSk=
X-Gm-Gg: AZuq6aLj/22B3rBKrlmTCaTe5QAmFieHHuSG1yhllWjd3GJWXmu2PF9nXFG4wbUoP6g
 NVL+5CnAZi2HlQ/do+ic2PyU2XAMrqr++peKMitkazjlheWYCKvb/Cd5WFUQhJO+e4Biu2ffVfo
 +QBGFLOiVfEmaubs8LYVBYFMs4pxSOW1B73s90qtzAMS2TbLr58dLNj8zCwz0mPevNT1E2GPVJ/
 58MWDz21aNhMNI0fw3rObb/zOAIzHTgEUHGeIWBTJr84dFfNa78joWQxyfDUQW1RmMisW+z2Nul
 kBf3SuZTImBDCmTMGrQuDZSJ47ItcYV5iZ3IHwtgFP1SIUlSG0IBceaykbq88QUdiigWx7MYKlI
 fuoOoaEb4IF8NQAObQdgqqiFSmbsV6+vSKPGJ7J/KKNH4/JzniSkYv2QdZQSdlHaNxzZMtnPjq+
 NGTjsGKm0JkUmYq8SSVd0F3wcRiIZfSHn07JuUkHvOpstJMyldTzYUzC5m7A==
X-Received: by 2002:a05:6000:4024:b0:437:6f6b:4f7d with SMTP id
 ffacd0b85a97d-4376f6b5079mr3874282f8f.19.1770635140992; 
 Mon, 09 Feb 2026 03:05:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e50:3860:9cd9:2f9d:7c05:425d?
 ([2a01:e0a:e50:3860:9cd9:2f9d:7c05:425d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4376b62b835sm11984968f8f.12.2026.02.09.03.05.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 03:05:40 -0800 (PST)
Message-ID: <80dd375b-e905-46c5-b43d-dd4c87e71c98@baylibre.com>
Date: Mon, 9 Feb 2026 12:05:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20260116194323.GP3416603@bill-the-cat>
Content-Language: fr
From: Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <20260116194323.GP3416603@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Tom,


sorry for delay, i check defects please see my comments inline

Le 16/01/2026 à 20:43, Tom Rini a écrit :
> Hey all,
>
> Here's the latest report from Coverity scan. For the LZMA ones, the
> _pad_ stuff seems to be a false positive (the _pad_ byte is just for
> padding and not refernced) and the flow control one is how that's
> written for whatever reason the upstream author wanted it like that.
>
> ---------- Forwarded message ---------
> From: <scan-admin@coverity.com>
> Date: Fri, Jan 16, 2026 at 1:06 PM
> Subject: New Defects reported by Coverity Scan for Das U-Boot
> To: <tom.rini@gmail.com>
>
>
> Hi,
>
> Please find the latest report on new defect(s) introduced to *Das U-Boot*
> found with Coverity Scan.
>
>     - *New Defects Found:* 7
>     - 2 defect(s), reported by Coverity Scan earlier, were marked fixed in
>     the recent build analyzed by Coverity Scan.
>     - *Defects Shown:* Showing 7 of 7 defect(s)
>
> Defect Details
>
> ** CID 641431:         (TAINTED_SCALAR)
>
>
> _____________________________________________________________________________________________
> *** CID 641431:           (TAINTED_SCALAR)
> /boot/image-android.c: 434             in android_image_get_kernel()
> 428     		if (*newbootargs) /* If there is something in newbootargs, a
> space is needed */
> 429     			strcat(newbootargs, " ");
> 430     		strcat(newbootargs, img_data.kcmdline_extra);
> 431     	}
> 432
> 433     	env_set("bootargs", newbootargs);
>>>>      CID 641431:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "*newbootargs" to "dlfree", which uses it as an offset.
> 434     	free(newbootargs);
> 435
> 436     	if (os_data) {
> 437     		if (image_get_magic(ihdr) == IH_MAGIC) {
> 438     			*os_data = image_get_data(ihdr);
> 439     		} else {
> /boot/image-android.c: 433             in android_image_get_kernel()
> 427     	if (img_data.kcmdline_extra && *img_data.kcmdline_extra) {
> 428     		if (*newbootargs) /* If there is something in newbootargs, a
> space is needed */
> 429     			strcat(newbootargs, " ");
> 430     		strcat(newbootargs, img_data.kcmdline_extra);
> 431     	}
> 432
>>>>      CID 641431:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "newbootargs" to "env_set", which uses it as an offset.
> 433     	env_set("bootargs", newbootargs);
> 434     	free(newbootargs);
> 435
> 436     	if (os_data) {
> 437     		if (image_get_magic(ihdr) == IH_MAGIC) {
> 438     			*os_data = image_get_data(ihdr);
> /boot/image-android.c: 434             in android_image_get_kernel()
> 428     		if (*newbootargs) /* If there is something in newbootargs, a
> space is needed */
> 429     			strcat(newbootargs, " ");
> 430     		strcat(newbootargs, img_data.kcmdline_extra);
> 431     	}
> 432
> 433     	env_set("bootargs", newbootargs);
>>>>      CID 641431:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "*newbootargs" to "dlfree", which uses it as an offset.
> 434     	free(newbootargs);
> 435
> 436     	if (os_data) {
> 437     		if (image_get_magic(ihdr) == IH_MAGIC) {
> 438     			*os_data = image_get_data(ihdr);
> 439     		} else {
> /boot/image-android.c: 433             in android_image_get_kernel()
> 427     	if (img_data.kcmdline_extra && *img_data.kcmdline_extra) {
> 428     		if (*newbootargs) /* If there is something in newbootargs, a
> space is needed */
> 429     			strcat(newbootargs, " ");
> 430     		strcat(newbootargs, img_data.kcmdline_extra);
> 431     	}
> 432
>>>>      CID 641431:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "newbootargs" to "env_set", which uses it as an offset.
> 433     	env_set("bootargs", newbootargs);
> 434     	free(newbootargs);
> 435
> 436     	if (os_data) {
> 437     		if (image_get_magic(ihdr) == IH_MAGIC) {
> 438     			*os_data = image_get_data(ihdr);
> /boot/image-android.c: 433             in android_image_get_kernel()
> 427     	if (img_data.kcmdline_extra && *img_data.kcmdline_extra) {
> 428     		if (*newbootargs) /* If there is something in newbootargs, a
> space is needed */
> 429     			strcat(newbootargs, " ");
> 430     		strcat(newbootargs, img_data.kcmdline_extra);
> 431     	}
> 432
>>>>      CID 641431:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "newbootargs" to "env_set", which uses it as an offset.
> 433     	env_set("bootargs", newbootargs);
> 434     	free(newbootargs);
> 435
> 436     	if (os_data) {
> 437     		if (image_get_magic(ihdr) == IH_MAGIC) {
> 438     			*os_data = image_get_data(ihdr);
> /boot/image-android.c: 434             in android_image_get_kernel()
> 428     		if (*newbootargs) /* If there is something in newbootargs, a
> space is needed */
> 429     			strcat(newbootargs, " ");
> 430     		strcat(newbootargs, img_data.kcmdline_extra);
> 431     	}
> 432
> 433     	env_set("bootargs", newbootargs);
>>>>      CID 641431:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "*newbootargs" to "dlfree", which uses it as an offset.

For CID 641431 : for me it's a false positives defect, malloc was done 
with strlen return and free done on malloc pointer.

> 434     	free(newbootargs);
> 435
> 436     	if (os_data) {
> 437     		if (image_get_magic(ihdr) == IH_MAGIC) {
> 438     			*os_data = image_get_data(ihdr);
> 439     		} else {
>
> ** CID 641430:         (TAINTED_SCALAR)
>
>
> _____________________________________________________________________________________________
> *** CID 641430:           (TAINTED_SCALAR)
> /cmd/abootimg.c: 244             in abootimg_get_ramdisk()
> 238     				      &rd_data, &rd_len))
> 239     		return CMD_RET_FAILURE;
> 240
> 241     	if (argc == 0) {
> 242     		printf("%lx\n", rd_data);
> 243     	} else {
>>>>      CID 641430:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "rd_data" to "env_set_hex", which uses it as an offset.
> 244     		env_set_hex(argv[0], rd_data);
> 245     		if (argc == 2)
> 246     			env_set_hex(argv[1], rd_len);
> 247     	}
> 248
> 249     	return CMD_RET_SUCCESS;
> /cmd/abootimg.c: 246             in abootimg_get_ramdisk()
> 240
> 241     	if (argc == 0) {
> 242     		printf("%lx\n", rd_data);
> 243     	} else {
> 244     		env_set_hex(argv[0], rd_data);
> 245     		if (argc == 2)
>>>>      CID 641430:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "rd_len" to "env_set_hex", which uses it as an offset.

CID 641430: false positive too. env_set_hex convert value on an env variable , so convert rd_len and rd_data
  in variable.

> 246     			env_set_hex(argv[1], rd_len);
> 247     	}
> 248
> 249     	return CMD_RET_SUCCESS;
> 250     }
> 251
>
> ** CID 641429:       Insecure data handling  (TAINTED_SCALAR)
>
>
> _____________________________________________________________________________________________
> *** CID 641429:         Insecure data handling  (TAINTED_SCALAR)
> /boot/image-android.c: 307             in android_image_get_data()
> 301     			printf("Incorrect vendor boot image header\n");
> 302     			unmap_sysmem(vhdr);
> 303     			unmap_sysmem(bhdr);
> 304     			return false;
> 305     		}
> 306     		android_boot_image_v3_v4_parse_hdr((const struct
> andr_boot_img_hdr_v3 *)bhdr, data);
>>>>      CID 641429:         Insecure data handling  (TAINTED_SCALAR)
>>>>      Passing tainted expression "vhdr->bootconfig_size" to "android_vendor_boot_image_v3_v4_parse_hdr", which uses it as a loop boundary.

CID 641429:  False positive too. "vhdr->bootconfig_size" come from android image so external source , not possible to validate if value is good or not except when AVB feature was enabled

> 307     		android_vendor_boot_image_v3_v4_parse_hdr(vhdr, data);
> 308     		unmap_sysmem(vhdr);
> 309     	} else {
> 310     		android_boot_image_v0_v1_v2_parse_hdr(bhdr, data);
> 311     	}
> 312
>
> ** CID 641428:         (TAINTED_SCALAR)
>
>
> _____________________________________________________________________________________________
> *** CID 641428:           (TAINTED_SCALAR)
> /boot/image-android.c: 658             in android_image_set_bootconfig()
> 652     		total_size += params_len + BOOTCONFIG_TRAILER_SIZE;
> 653
> 654     	/* Map Dest */
> 655     	ramdisk_dest = map_sysmem(ramdisk_addr, total_size);
> 656
> 657     	/* Copy data */
>>>>      CID 641428:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "img_data.vendor_ramdisk_size" to "android_boot_append_bootconfig", which uses it as an offset.
> 658     	ret = android_boot_append_bootconfig(&img_data, params, params_len,
> 659     					     ramdisk_dest);
> 660
> 661     	unmap_sysmem(ramdisk_dest);
> 662     	free(params);
> 663     	free(new_bootargs);
> /boot/image-android.c: 658             in android_image_set_bootconfig()
> 652     		total_size += params_len + BOOTCONFIG_TRAILER_SIZE;
> 653
> 654     	/* Map Dest */
> 655     	ramdisk_dest = map_sysmem(ramdisk_addr, total_size);
> 656
> 657     	/* Copy data */
>>>>      CID 641428:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "img_data.bootconfig_size" to "android_boot_append_bootconfig", which uses it as an offset.
> 658     	ret = android_boot_append_bootconfig(&img_data, params, params_len,
> 659     					     ramdisk_dest);
> 660
> 661     	unmap_sysmem(ramdisk_dest);
> 662     	free(params);
> 663     	free(new_bootargs);
> /boot/image-android.c: 658             in android_image_set_bootconfig()
> 652     		total_size += params_len + BOOTCONFIG_TRAILER_SIZE;
> 653
> 654     	/* Map Dest */
> 655     	ramdisk_dest = map_sysmem(ramdisk_addr, total_size);
> 656
> 657     	/* Copy data */
>>>>      CID 641428:           (TAINTED_SCALAR)
>>>>      Passing tainted expression "img_data.boot_ramdisk_size" to "android_boot_append_bootconfig", which uses it as an offset.

  CID 641428: for me it's false positive too. img_data.boot_ramdisk_size and vendor_ramdisk_size come from android image, it could be corrupted if we corrupt android image but it's an external source so difficult to say if value is corrupted or not , it's why on real device we have AB features to check it.

> 658     	ret = android_boot_append_bootconfig(&img_data, params, params_len,
> 659     					     ramdisk_dest);
> 660
> 661     	unmap_sysmem(ramdisk_dest);
> 662     	free(params);
> 663     	free(new_bootargs);
>
> ** CID 332278:       Control flow issues  (UNREACHABLE)
> /lib/lzma/LzmaDec.c: 720           in LzmaDec_TryDummy()
>
>
> _____________________________________________________________________________________________
> *** CID 332278:         Control flow issues  (UNREACHABLE)
> /lib/lzma/LzmaDec.c: 720             in LzmaDec_TryDummy()
> 714       UInt32 code = p->code;
> 715       const Byte *bufLimit = *bufOut;
> 716       const CLzmaProb *probs = GET_PROBS;
> 717       unsigned state = (unsigned)p->state;
> 718       ELzmaDummy res;
> 719
>>>>      CID 332278:         Control flow issues  (UNREACHABLE)
>>>>      Since the loop increment is unreachable, the loop body will never execute more than once.
> 720       for (;;)
> 721       {
> 722         const CLzmaProb *prob;
> 723         UInt32 bound;
> 724         unsigned ttt;
> 725         unsigned posState = CALC_POS_STATE(p->processedPos,
> ((unsigned)1 << p->prop.pb) - 1);
>
> ** CID 252901:       Uninitialized variables  (UNINIT)
> /lib/lzma/LzmaDec.c: 1295           in LzmaDec_AllocateProbs()
>
>
> _____________________________________________________________________________________________
> *** CID 252901:         Uninitialized variables  (UNINIT)
> /lib/lzma/LzmaDec.c: 1295             in LzmaDec_AllocateProbs()
> 1289
> 1290     SRes LzmaDec_AllocateProbs(CLzmaDec *p, const Byte *props,
> unsigned propsSize, ISzAllocPtr alloc)
> 1291     {
> 1292       CLzmaProps propNew;
> 1293       RINOK(LzmaProps_Decode(&propNew, props, propsSize))
> 1294       RINOK(LzmaDec_AllocateProbs2(p, &propNew, alloc))
>>>>      CID 252901:         Uninitialized variables  (UNINIT)
>>>>      Using uninitialized value "propNew". Field "propNew._pad_" is uninitialized.
> 1295       p->prop = propNew;
> 1296       return SZ_OK;
> 1297     }
> 1298
> 1299     SRes LzmaDec_Allocate(CLzmaDec *p, const Byte *props,
> unsigned propsSize, ISzAllocPtr alloc)
> 1300     {
>
> ** CID 252579:       Uninitialized variables  (UNINIT)
> /lib/lzma/LzmaDec.c: 1327           in LzmaDec_Allocate()
>
>
> _____________________________________________________________________________________________
> *** CID 252579:         Uninitialized variables  (UNINIT)
> /lib/lzma/LzmaDec.c: 1327             in LzmaDec_Allocate()
> 1321         {
> 1322           LzmaDec_FreeProbs(p, alloc);
> 1323           return SZ_ERROR_MEM;
> 1324         }
> 1325       }
> 1326       p->dicBufSize = dicBufSize;
>>>>      CID 252579:         Uninitialized variables  (UNINIT)
>>>>      Using uninitialized value "propNew". Field "propNew._pad_" is uninitialized.
> 1327       p->prop = propNew;
> 1328       return SZ_OK;
> 1329     }
> 1330
> 1331     SRes LzmaDecode(Byte *dest, SizeT *destLen, const Byte *src,
> SizeT *srcLen,
> 1332         const Byte *propData, unsigned propSize, ELzmaFinishMode
> finishMode,
>
>
>
> View Defects in Coverity Scan
> <https://scan.coverity.com/projects/das-u-boot?tab=overview>
>
> Best regards,
>
> The Coverity Scan Admin Team
>
> ----- End forwarded message -----
>
Regards,
Guillaume


