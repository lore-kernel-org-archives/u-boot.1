Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9C4C021A0
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 17:48:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB6E780756;
	Sat, 15 Feb 2025 18:48:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eIwPxqB1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 469AE80C6F; Sat, 15 Feb 2025 18:48:09 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11F8080077
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 18:48:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-471c74e16ebso5963561cf.2
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 09:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739641686; x=1740246486; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wk1J3f2J+5OuV5GXV8/HpEVj6ZWFImfWlZ0sgXLLTEQ=;
 b=eIwPxqB1ZPE0ggu/9EEnqRMH8TECPT46nxcmvZfnQnyK7nYbwKHUDVPCqaP86SbrEB
 oVifT7W7IO9r1QMD+Ee0fbdWaGdwNef4JQItz04i3Pb8Q6O2rGxlHQqkMmw/Rxj9ahwJ
 vyPQ+EB91bh8f1I2kEesV2Ljcxoxk2oMhM47PpWOrrxzqyvO5woryq7uFpyRClSZfJpc
 cEumzR1uOFg+7MmraWNqFxrRMuzj9+aA3by+SJjyYgbgQ4LST7qpQbs7PYQSzNCfg5I9
 89nUsSS+0g9qSQPevn1bSkqaQI2sR7auuahj5v1J5cPFgQFmrylG3gqV9rf6C16nFES9
 G/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739641686; x=1740246486;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wk1J3f2J+5OuV5GXV8/HpEVj6ZWFImfWlZ0sgXLLTEQ=;
 b=lzDLWtKOJSPmUp4xPukDy35HJWu27IR4DtbFJ/xqxO/FFfJrdOq6zVBUk6E5m/pF9h
 V4nzuNueZbQ+4x5RvNrKLNUSXcCRy1MrjsLvMBWD8VAvJDNsnN0+tnXvdLnKLkUvIvFR
 H6zxq7gOuLEIvutSeNB8ulih/HAlGobhgv6RrbyTl+GQvmiipgP8cWaxIEOZk0YjoQbE
 4dmu8bdaQIhVXOnnsPEZ/tCGqDjVuhGar77qlSt7OQE3ZRmaQ4t7mcbmIrYz1r3cBb8n
 xDbGpa1MUYlN88HCVavWdQI4Fb8k7YnkOFeBK1l9HMJ1pQ6zpoqFN1+6v5dGTwqYENwy
 rqfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUThbzH4jfHo+HNsjEn6T1PX/BVZVbi/PQdq6Beu9y35eGLRhD7xcLh8CG/+Mx2FUM0rR3FYc8=@lists.denx.de
X-Gm-Message-State: AOJu0YyTW80UKGliSqak1gBmrgWdFYdCm7YIRyGN4aghHDGfJVdrlJ77
 gqy60HN1aQCTLdQ+JXTSbvns6L/EbliGjcMBPx94DxjYaWf07j5T
X-Gm-Gg: ASbGncvvwhWZAKOnfn8v0TygoiThcpwfgUIehA7+R3GVflbATacWNYMivDm/b5K1LRA
 VtEKmzhpzOyYXziDmg3kk8dRnTz2BUAkXRtRHfFiU74nH63Ch3Mp3eyhwqktHTmETk1mGcLnSJz
 SqJkpJdklsjmqW7OOwD5KV0/KyN1nb1QJhWYEmIvK9rwJHjypqVtkoNNieIPuQABXFpkPP8z6ZC
 v+5xGhnrM7LlSvXvj2z6OeF0vRzlG9kVZwNdhSl5smjz00/FovI1q9sN/Ivceps6gJyErT3HZTb
 K5z5Bow2fzg6rxNg3WZROKMoPpoURahZP4+/t73HuHCdR46gmKtOyApaL3Lb2almTt4=
X-Google-Smtp-Source: AGHT+IHhjtaJ5CJ1zXFWXvbRiuroFPVDgH3lFmErCQLeRhqrM5pCKU6xeGKPE0nJyT4iojtvZqfWkg==
X-Received: by 2002:a05:620a:178e:b0:7c0:7bab:d08f with SMTP id
 af79cd13be357-7c08a9f041fmr183897785a.9.1739641685809; 
 Sat, 15 Feb 2025 09:48:05 -0800 (PST)
Received: from [192.168.1.201] (pool-108-28-192-105.washdc.fios.verizon.net.
 [108.28.192.105]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c07c6088ccsm340273485a.33.2025.02.15.09.48.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2025 09:48:05 -0800 (PST)
Message-ID: <8a2961af-fbaa-74f6-8f2a-be9dd5e84a8a@gmail.com>
Date: Sat, 15 Feb 2025 12:48:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [BUG report] spl: image size check fails in spl_load()
Content-Language: en-US
To: Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de
Cc: vigneshr@ti.com
References: <20250214111251.2349093-1-anshuld@ti.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20250214111251.2349093-1-anshuld@ti.com>
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

On 2/14/25 06:12, Anshul Dalal wrote:
> Hi all!
> 
> I was trying to implement falcon boot on TI AM62x EVM with the kernel image on
> SD card's filesystem but the following check in `_spl_load` at
> `include/spl_load.h:95` fails to -EIO as per the latest commit [89d3333]:
> 
> 	return read < spl_image->size ? -EIO : 0;
> 
> The check seems to be comparing the image size gathered from the header
> (spl_image->size) with the number of bytes read form the loader.
> 
>  From spl_load.h:
> 
> 	ret = spl_parse_image_header(spl_image, bootdev, header);
> 	if (ret)
> 		return ret;
> 
> 	base_offset = spl_image->offset;
> 	/* Only NOR sets this flag. */
> 	if (IS_ENABLED(CONFIG_SPL_NOR_SUPPORT) &&
> 	    spl_image->flags & SPL_COPY_PAYLOAD_ONLY)
> 		base_offset += sizeof(*header);
> 	image_offset = ALIGN_DOWN(base_offset, spl_get_bl_len(info));
> 	overhead = base_offset - image_offset;
> 	size = ALIGN(spl_image->size + overhead, spl_get_bl_len(info));
> 
> 	read = info->read(info, offset + image_offset, size,
> 			  map_sysmem(spl_image->load_addr - overhead, size));
> 
> 	if (read < 0)
> 		return read;
> 
> 	return read < spl_image->size ? -EIO : 0;
> 
> During kernel build process the header size is computed including the BSS
> whereas it's removed when creating the uncompressed image. Therefore the size
> of the uncompressed image on filesystem will be smaller than the size specified
> in the header. Which leads to failure of the above check.
> 
>  From linux kernel's `arch/arm64/kernel/image.h:63`:
> 
> 	#define HEAD_SYMBOLS						\
> 		DEFINE_IMAGE_LE64(_kernel_size_le, _end - _text);	\
> 		DEFINE_IMAGE_LE64(_kernel_flags_le, __HEAD_FLAGS);
> 
> Disabling the check leads to a successful boot directly to the kernel.
> Therefore it seems like the check is non functional as the size in the kernel
> header does not correspond with the file size of the kernel image.

Did this work before v2024.04?

How exactly are you loading your image? E.g. what are the values of

CONFIG_SPL_OS_BOOT
CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION
CONFIG_SPL_FALCON_BOOT_MMCSD
CONFIG_SPL_FS_FAT
CONFIG_SPL_FS_EXT4
CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
CONFIG_SUPPORT_EMMC_BOOT

 From what I can tell, the OS_BOOT path should not call spl_load in the first place.

In any case, the root problem is that the size reported by the kernel is actually the
space the kernel will need when it is loaded, and not the size of the data to load
(which we need). So if we have a short read, we have no way of knowing if the filesystem
is corrupt, the image was truncated while writing, or if it's just missing the bss. And
we still have to rely of the image size so that we can load from e.g. NAND or SPI where
there is no filesystem.

One way to fix this could be to move the length check to spl_load_info->read. This would
involve updating all the callers and callees.

--Sean
