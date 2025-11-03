Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBD9CCFA03
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 18:52:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03208836D1;
	Mon,  3 Nov 2025 19:52:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c8ClJvn/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C8A583700; Mon,  3 Nov 2025 19:52:20 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D076C8331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 19:52:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-421851bcb25so2658041f8f.2
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 10:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762195937; x=1762800737;
 darn=lists.denx.de; 
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DiDV9VzV89nTjw70RhDz9NSxBj/EfqR14KHklHOYRKs=;
 b=c8ClJvn/o0CV3f4U9qdERI0V5lm7VqJID01v5qsvfPIog8HtHkstLVL5gjHUukzqOr
 ifkBz1GVwszz/FsevY8nvu4Bwk26IlgBXxKRvoKZzcDMVEwX+A+BALrU8HrynIOs+227
 dH7SipSukWhi5jOSvvRP9RGtMhhOXXfLZV9BLu6YXlvp836TGq5/jshUkNCwv4YzZrHC
 A21uEwgPDoON6DJizhNvggHGde6Nna0H0w6exxu1+A9pwoTCGLXzr4qTRY6tePIPMrAc
 MrvVN1+lra2iJ4z6MEzgxnPUlRZFQRTA2I0G1tFoFSsTXSYudrk94qM7Huhs9m9uif9P
 nE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762195937; x=1762800737;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DiDV9VzV89nTjw70RhDz9NSxBj/EfqR14KHklHOYRKs=;
 b=JqdDmxdY/dcpsJ3CAWGKoYOz7jx81qtYy27uoTYOB0xSyvbVDvmEIJidatOz9+vNs/
 FT97e2VhcxDxwOA3VNxrYhd7uXzhd6Gk2xvGPDoeH9mJ/feSBwFH044t9GTNCSlKAVqS
 XYy8dhxNDh6sTMvg4I27vMY8VCSwMt51b0EFYD1MhTPmuZ55diLqUeM+9nEzHdvmvgnK
 +Q1+p3P4MaXrnOatn2++Mna4IVvgSeyJc2VBrO9WxCQGAHkWDX0Ky0b4aV00EfLwyjWc
 hwNDuyPtRVahtUVeJMX7LKb3pvzWVS4TQ9Zi0jjEvxilqHCTVoune9q+AyL4RjR256Tp
 /v3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGGSts2CJik++/3Pqj4xcYMLwmMXJlbkie5z6ijw/2Rr83rjGSiMdHFIs5jChfUyiivh+v7Ms=@lists.denx.de
X-Gm-Message-State: AOJu0YybfEeryDknDUAtwOHJmjad8BninoOIA2EcrJobt/8eta0U3E5+
 rqACRu24Kxq9jDSZ1V7VZB4M6grubml+f6elqprL0HKbsC0cQplV0HmqM1CC8GNnmJI=
X-Gm-Gg: ASbGncsErnhDw7LVQ8527DHw2x8SIrBvHzHhVHjE/jNbJo+5hLGHhJ5peEltEw6vO/6
 lmt2J26fn6cmw1DvL4d8OTDtKtbVpj0TZLblDRgqIQCwijWWIMSE0OFcxKuQevCbfOhpkQrH+iZ
 mcDxY/G4E1UZUO41PWxIZADtVHg0G0CR4W4TBXYB3UEAdqO3gQiGwkmGH0X18l7MHtuLfghLm2m
 7PECqdaPiT1bU3OUGoCyQPq5OSktUT5C9uXuEPs89VC3qHwhjOw27xYXilnb+altYZCPEIJpuIz
 NEddiLRBzjirSZ/gyqZx1lkEKf48BiDfO+BnCD2Enlh3WU7PzRfV8sMY8wc2rU3dH8GBo+w7rIX
 edLhaKXcJQEnUHSYeSw5Od2AzCpxjH54G6W/5xFit/vXA5F7qpKISvMDqvpUzjEC4ceyW8B9qac
 jmzumzsZnYW0nwNbZ53N8jaau5OybM/tyTNMOShR2a4183
X-Google-Smtp-Source: AGHT+IHHbh6YsEtJ1JMH577WJrTCVBMmi4iT3FW9OVmXxRB412sBv5cq3b//EnCIzkZBHRcpG61oPg==
X-Received: by 2002:a05:6000:186c:b0:429:dbed:2900 with SMTP id
 ffacd0b85a97d-429dbed3b87mr213278f8f.39.1762195937127; 
 Mon, 03 Nov 2025 10:52:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e50:3860:23eb:8c68:e19:f7bc?
 ([2a01:e0a:e50:3860:23eb:8c68:e19:f7bc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c2e674csm168098175e9.4.2025.11.03.10.52.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 10:52:16 -0800 (PST)
Message-ID: <5c42a166-1ff4-478a-b76c-9573874a0ca3@baylibre.com>
Date: Mon, 3 Nov 2025 19:52:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] boot: android: Add bootconfig support
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Nicolas Belin <nbelin@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Aaron Kling <webgeek1234@gmail.com>, George Chan <gchan9527@gmail.com>,
 Sam Day <me@samcday.com>, Jerome Forissier <jerome.forissier@linaro.org>,
 Maxime Fournier <mfournier@baylibre.com>
References: <20251017-bootconfig-v2-0-8c7c2f2e5474@baylibre.com>
 <20251017-bootconfig-v2-3-8c7c2f2e5474@baylibre.com>
 <87cy635ahz.fsf@kernel.org>
Content-Language: fr
From: Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <87cy635ahz.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,


Le 31/10/2025 à 16:58, Mattijs Korpershoek a écrit :
> Hi Guillaume,
>
> Thank you for the patch.
>
> On Fri, Oct 17, 2025 at 15:19, "Guillaume La Roque (TI.com)"<glaroque@baylibre.com> wrote:
>
>> For android vendor boot image version 4 bootconfig is mandatory.[1]
> There seems to be a link "[1]" here but it's not part of the commit
> message.
> Can you add it please?
yes of course ,
>> In the android_image_get_ramdisk function, after copying both vendor and
>> boot ramdisks, we extract all androidboot.* entries from the kernel
>> command line. These entries are added to the bootconfig section.
>> We then update the sizes of the ramdisk and bootconfig.
>> Finally, all androidboot.* entries are removed from the kernel command
>> line.
>>
>> Signed-off-by: Guillaume La Roque (TI.com)<glaroque@baylibre.com>
>> ---
>>   boot/image-android.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 93 insertions(+), 8 deletions(-)
>>
>> diff --git a/boot/image-android.c b/boot/image-android.c
>> index 613f2aa4b9e..cf038a4a62f 100644
>> --- a/boot/image-android.c
>> +++ b/boot/image-android.c
>> @@ -534,17 +534,102 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
>>   			ramdisk_ptr = img_data.ramdisk_addr;
>>   		}
>>   		*rd_data = ramdisk_ptr;
>> -		memcpy((void *)(ramdisk_ptr), (void *)img_data.vendor_ramdisk_ptr,
>> +
>> +		/* Extract androidboot.* parameters from bootargs */
>> +		const char *bootargs = env_get("bootargs");
>> +		char *androidboot_params = NULL;
>> +		char *new_bootargs = NULL;
>> +		size_t androidboot_params_len = 0;
>> +
>> +		if (bootargs && img_data.bootconfig_size) {
>> +			size_t len = strlen(bootargs);
>> +
>> +			androidboot_params = malloc(len + 1);
>> +			new_bootargs = malloc(len + 1);
>> +			if (!androidboot_params || !new_bootargs) {
>> +				free(androidboot_params);
>> +				free(new_bootargs);
>> +				printf("Error: malloc failed\n");
>> +				return -ENOMEM;
>> +			}
>> +
>> +			/* Extract androidboot.* and build new bootargs in one pass */
>> +			const char *src = bootargs;
>> +			char *bc_dst = androidboot_params;
>> +			char *args_dst = new_bootargs;
>> +
>> +			while (*src) {
>> +				/* Skip leading spaces */
>> +				while (*src == ' ')
>> +					src++;
>> +				if (!*src)
>> +					break;
>> +
>> +				/* Check if this param starts with androidboot. */
>> +				if (strncmp(src, "androidboot.", 12) == 0) {
>> +					/* Copy to bootconfig (add newline if not first) */
>> +					if (bc_dst != androidboot_params)
>> +						*bc_dst++ = '\n';
>> +					while (*src && *src != ' ')
>> +						*bc_dst++ = *src++;
>> +				} else {
>> +					/* Copy to new bootargs (add space if not first) */
>> +					if (args_dst != new_bootargs)
>> +						*args_dst++ = ' ';
>> +					while (*src && *src != ' ')
>> +						*args_dst++ = *src++;
>> +				}
>> +			}
>> +
>> +			*bc_dst++ = '\n';  /* Final newline for bootconfig */
>> +			*bc_dst = '\0';
>> +			*args_dst = '\0';
>> +			androidboot_params_len = bc_dst - androidboot_params;
>> +
>> +			/* Update bootargs if we extracted any androidboot params */
>> +			if (androidboot_params_len > 1)
>> +				env_set("bootargs", new_bootargs);
>> +		}
>> +
>> +		/* Map addresses for memcpy operations */
>> +		void *ramdisk_dest = map_sysmem(ramdisk_ptr, img_data.ramdisk_size);
>> +		void *vendor_ramdisk_src = map_sysmem(img_data.vendor_ramdisk_ptr,
>> +						      img_data.vendor_ramdisk_size);
>> +		void *boot_ramdisk_src = map_sysmem(img_data.ramdisk_ptr,
>> +						    img_data.boot_ramdisk_size);
>> +
>> +		memcpy(ramdisk_dest, vendor_ramdisk_src,
>>   		       img_data.vendor_ramdisk_size);
>> -		ramdisk_ptr += img_data.vendor_ramdisk_size;
>> -		memcpy((void *)(ramdisk_ptr), (void *)img_data.ramdisk_ptr,
>> -		       img_data.boot_ramdisk_size);
>> -		ramdisk_ptr += img_data.boot_ramdisk_size;
>> +		memcpy((char *)ramdisk_dest + img_data.vendor_ramdisk_size,
>> +		       boot_ramdisk_src, img_data.boot_ramdisk_size);
>> +
>>   		if (img_data.bootconfig_size) {
>> -			memcpy((void *)
>> -			       (ramdisk_ptr), (void *)img_data.bootconfig_addr,
>> -			       img_data.bootconfig_size);
>> +			void *bootconfig_src = map_sysmem(img_data.bootconfig_addr,
>> +							  img_data.bootconfig_size);
>> +			memcpy((char *)ramdisk_dest + img_data.vendor_ramdisk_size +
>> +			       img_data.boot_ramdisk_size,
>> +			       bootconfig_src, img_data.bootconfig_size);
>> +			unmap_sysmem(bootconfig_src);
>> +
>> +			/* Add androidboot.* parameters to bootconfig */
>> +			if (androidboot_params && androidboot_params_len > 1) {
>> +				ulong bootconfig_ptr = (ulong)ramdisk_dest +
>> +						       img_data.vendor_ramdisk_size +
>> +						       img_data.boot_ramdisk_size;
>> +				img_data.ramdisk_size +=
>> +					add_bootconfig_parameters(androidboot_params,
>> +								  androidboot_params_len,
>> +								  bootconfig_ptr,
>> +								  img_data.bootconfig_size);
>> +			}
>>   		}
>> +
>> +		free(androidboot_params);
>> +		free(new_bootargs);
>> +
>> +		unmap_sysmem(boot_ramdisk_src);
>> +		unmap_sysmem(vendor_ramdisk_src);
>> +		unmap_sysmem(ramdisk_dest);
> We are here in the "if (img_data.header_version > 2) {" block.
> What about boot image v3? Why are we forcing bootconfig upon them?

our right it's not good bootconfig come with version 4 i will fix it in v3.

>
> Also, please move this to a seperate function. It makes
> android_image_get_ramdisk() quite long and difficult to read otherwise.
i will.
>
> Finally, what happens if a kernel does not have bootconfig enabled ?
> I imagine that everything will crash due to this change. Even if
> bootconfig is mandatory for boot image v4, I believe we should make this
> behaviour optional to avoid breaking existing kernels.

it's enable in android kernel since android-12-5.4.xx so if you enable 
boot image version 4 and move androidboot.x in booconfig instead of 
kernelcmdline it's because you decide to enable it with 
BOARD_KERNEL_CMDLINE += bootconfig and you support android boot image 
version 4. it's explained in aosp doc 
:https://source.android.com/docs/core/architecture/bootloader/implementing-bootconfig 


>
>>   	} else {
>>   		/* Ramdisk can be used in-place, use current ptr */
>>   		if (img_data.ramdisk_addr == 0 ||
>>
>> -- 
>> 2.34.1

