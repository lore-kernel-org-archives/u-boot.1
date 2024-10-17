Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A241D2A53A
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 12:08:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 241E088E5C;
	Thu, 17 Oct 2024 14:08:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OVkFxWCr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9837B88E8C; Thu, 17 Oct 2024 14:08:08 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CE4B88E00
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 14:08:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-539fe76e802so1119222e87.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 05:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729166883; x=1729771683;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=V2+s0Fr1+x9B1Tr3WO2sYeMGo0HL/OF2Ny/wQAshJXI=;
 b=OVkFxWCrsfA52XfzGl6jVFJ1LusWbcihwZ2S/j3JO95MfhAC4V3bks3I7MIZQdOev0
 EbAndQFPk/cCenMc8/sdU1oxIv1ibM51Dggwnpq82HwbUeruVBpmp6v1wUEkwtB7ci2B
 HOWOWciguDnABFHIJ3BtHYrhH/kdIEFcKTeYbZ3dcikgb3X9QYt1p34gl4ROD75gbSs6
 eIDSndsm8IT3SOev2ulit+Csg41wsRoJHQJYD/TRntEinEjL+/U0mF2B0pfEphJULG/z
 5oWgnWhyq2Ogs7jcAgrP+Ue6NR30LESkAbW7HkZ7wsY4/0p25wiTkEZCGki5HYZekhyk
 EnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729166883; x=1729771683;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V2+s0Fr1+x9B1Tr3WO2sYeMGo0HL/OF2Ny/wQAshJXI=;
 b=PrYgGOg9nJeZj8lYIe7yyOYP/6gi7vryg+StxA5RilpUkf5oLrafEOcW50d0hB4KLq
 1aFKvRsUbCi7aCexh5W82v5PciwRKr/vuZlzVcOAk1UQ5+lPZ22bk5GM0r06+GZJCvn2
 fUKNMTyFerwiPD8ozSfE7hLRFBuCYD6btoHIn/UsGeKx1xTJc5AfrFQtj46MoUat8+7+
 sSvvcghIudFnwnNzZsUaIHqndtgBuowtJsML8UN/Njr70yaNPpE1LDiTJ21ZRO/IcrjW
 U9ChoWcDx/n9ybIyUwfFvJ3fhXM9QG7xzXB+tbtF2nc7w+fPVXuYRcHwxlGMoB7n0wY5
 B7kQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJmFmx1yM85ohZBWXZYelDRSj/28myobiEheEbju22nIaY4HOHkhxJRJ/4OxfhbkCg8LdZ8IE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3uQSBgGH7SYFyiSWXm9RmFSuCxtmLLRkH7YHnuC1oY4CjCE9a
 YjRk4kqC5Oca6i/bccfCJw9dOhpyz7EQX/Mny/65ZsHdQEp2hWrkyHYfVdX/X+Q=
X-Google-Smtp-Source: AGHT+IHw6Um+zmmdVbmP0Lwmu7ovse+sJFFn2SH008tkr/YIUc05XHaM+Z1mWzRsmVpQJgvrMsedVA==
X-Received: by 2002:a05:6512:3b26:b0:52e:9cc7:4461 with SMTP id
 2adb3069b0e04-539e54d77admr10955323e87.5.1729166882611; 
 Thu, 17 Oct 2024 05:08:02 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43158c39b81sm24210825e9.19.2024.10.17.05.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 05:08:02 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: neil.armstrong@linaro.org, Tom Rini <trini@konsulko.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH 0/3] image: android: misc fixes when using on Qualcomm
 platforms
In-Reply-To: <66f2ba28-6415-4d0e-87c7-b7d235929569@linaro.org>
References: <20241016-topic-fastboot-fixes-mkbootimg-v1-0-94fd9340722b@linaro.org>
 <87ed4f2ccc.fsf@baylibre.com> <871q0f2b72.fsf@baylibre.com>
 <66f2ba28-6415-4d0e-87c7-b7d235929569@linaro.org>
Date: Thu, 17 Oct 2024 14:07:59 +0200
Message-ID: <87y12n0w68.fsf@baylibre.com>
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

Hi Neil,

On jeu., oct. 17, 2024 at 14:01, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> On 17/10/2024 13:58, Mattijs Korpershoek wrote:
>> Hi Neil,
>> 
>> On jeu., oct. 17, 2024 at 13:33, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:
>> 
>>> Hi Neil,
>>>
>>> Thank you for the series.
>>>
>>> On mer., oct. 16, 2024 at 17:46, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>>
>>>> When trying to use the Android boot image with header version 2
>>>> on recent Qualcomm platforms, we get into some troubles.
>>>>
>>>> First the kernel in-place address can be > 32bit, then since
>>>> we use the Android mkbootimg, it uses the default load address
>>>> which isn't big enough to uncompress the kernel.
>>>>
>>>> Finally, the ramdisk also uses a default load address, and
>>>> it should be taken in account like for the kernel address.
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>> Neil Armstrong (3):
>>>>        image: android: use ulong for kernel address
>>>>        boot: image-android: do not boot XIP when kernel is compressed
>>>>        image: android: handle ramdisk default address
>>>
>>> I have boot tested aosp/main on Khadas VIM3 using
>>> khadas_vim3_android_defconfig
>>>
>>> This ensures that boot image v2 still works.
>>>
>>> I also tried to boot test the Beagle Play board (which runs Android 14
>>> with boot image v4).
>>>
>>> Unfortunetly, that does not boot. The kernel starts but then I see:
>>>
>>> [    0.434360][    T1] /dev/root: Can't open blockdev
>>> [    0.439587][    T1] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
>>>
>>> Full boot logs:
>>> https://paste.debian.net/1332547/
>>>
>>> Full boot logs on master:
>>> https://paste.debian.net/1332548/
>>>
>>> It seems that somehow, the bootconfig section is no longer present.
>>>
>>> I'll try to identify the offending patch and help debug this.
>> 
>> Offending patch is
>>    [PATCH 3/3] image: android: handle ramdisk default address
>
> Thanks for looking
>
>> 
>> The following (invalid) diff "fixes it"
>> 
>> modified   boot/image-android.c
>> @@ -448,9 +448,9 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
>>   	}
>>   
>>   	printf("RAM disk load addr 0x%08lx size %u KiB\n",
>> -	       ramdisk_ptr, DIV_ROUND_UP(img_data.ramdisk_size, 1024));
>> +	       img_data.ramdisk_addr, DIV_ROUND_UP(img_data.ramdisk_size, 1024));
>>   
>> -	*rd_data = ramdisk_ptr;
>> +	*rd_data = img_data.ramdisk_addr;
>>   
>>   	*rd_len = img_data.ramdisk_size;
>>   	return 0;
>> 
>> I'll debug a bit more.
>
> OK so this basically reverts the patch, so it means on Beagle Play
> the 0x11000000 is valid and can't use the randisk in-place.
>
> img_data.ramdisk_ptr is the "real" address the data has been loaded to,
> and img_data.ramdisk_addr is the address passed to mkbootimg, where it
> should be loaded.

Beagle Play uses boot image v4, therefore, we go through the following
code path:

	if (img_data.header_version > 2) {
		/* Ramdisk can't be used in-place, copy it to ramdisk_addr_r */
		if (img_data.ramdisk_addr == ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR) {
			ramdisk_ptr = env_get_ulong("ramdisk_addr_r", 16, 0);
			if (!ramdisk_ptr) {
				printf("Invalid ramdisk_addr_r to copy ramdisk into\n");
				return -EINVAL;
			}
		} else {
			ramdisk_ptr = img_data.ramdisk_addr;
		}
		memcpy((void *)(ramdisk_ptr), (void *)img_data.vendor_ramdisk_ptr,
		       img_data.vendor_ramdisk_size);
		ramdisk_ptr += img_data.vendor_ramdisk_size;
		memcpy((void *)(ramdisk_ptr), (void *)img_data.ramdisk_ptr,
		       img_data.boot_ramdisk_size);
		ramdisk_ptr += img_data.boot_ramdisk_size;
		if (img_data.bootconfig_size) {
			memcpy((void *)
			       (ramdisk_ptr), (void *)img_data.bootconfig_addr,
			       img_data.bootconfig_size);
		}

We can see here, that we **increment** ramdisk_ptr.

Therefore, the following line is invalid:

    *rd_data = ramdisk_ptr;

Because ramdisk_ptr is not at the beginning of the ramdisk, but at the
beginning of bootconfig.

I think saving ramdisk_ptr in the above block should fix the issues I see.

>
> Neil
>
>> 
>>>
>>>>
>>>>   boot/image-android.c    | 60 +++++++++++++++++++++++++++++++++++++------------
>>>>   include/android_image.h |  2 +-
>>>>   2 files changed, 47 insertions(+), 15 deletions(-)
>>>> ---
>>>> base-commit: d5cab0d6adc26ec1bbd45c2fed101184d04454ae
>>>> change-id: 20241016-topic-fastboot-fixes-mkbootimg-8d73ab93db3d
>>>>
>>>> Best regards,
>>>> -- 
>>>> Neil Armstrong <neil.armstrong@linaro.org>
