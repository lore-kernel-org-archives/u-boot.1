Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C5CD37482
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 12:16:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A483E88E5C;
	Thu, 17 Oct 2024 14:16:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pdWB2wyR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7F5888EDA; Thu, 17 Oct 2024 14:16:55 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 703F288E32
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 14:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37d70df0b1aso635457f8f.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 05:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729167411; x=1729772211; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=E2HU9/vIF9p/Spx+0HWJDJWYKy1OkFlRXd5cgMFcy1I=;
 b=pdWB2wyRfTdojJB3WevrnCo7pwGa+H5GFOu5Hgpem19bny32q/ICK0iNmyE7gTHWrO
 9ZQlYkpi9lHR3RqsjSLctT88btcjm3UlBISD9PlOR3nPCxdsnXbP1ZK7U6TOU96zkLBK
 g/3FA5DtRcpCd6aM2w9GPwJVUrWEyyiuuvs3hDKKdRHbAeLAM3h+9zmdpOZHOxS2+Xvo
 VZ/Ujh4qodydhEL4oajF/XyTsXtSbYt9sj58y5YijuLX3Q4VdM1UmhoC3NlxrbrH5i7L
 fTwSwMwWuesDOMrsQZZqxuaXLSuSES784TtLLDKIOhcNnLBMzt/+lkhlsKhnDzbIuzQc
 HEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729167411; x=1729772211;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=E2HU9/vIF9p/Spx+0HWJDJWYKy1OkFlRXd5cgMFcy1I=;
 b=i5XgAFe2BCz3HwkyxDIZD6BBDFjZEgHIoHcpRQlEB0hEosdsFU+jEc8U9Ec3Eaqkfa
 eRFk1rdIgNoN2mVkO43vecNWgHuteP5G4VF3ben9SgF/1Z/mnozAZW9mwHAKPvGCuUc7
 FnbXLejvljjGi+lhQjIh+kYucc2IzeAE4NVBfqHxuvLQrvYNrfrPCH8FSuzzJrlKehkk
 d/zddUDMFNQD8fDjsX/NU7s+PMbrvWZZxCQDpVZ1WRmPgzyoU2Jp3HfXQQuToKFdq3Zp
 zcOuPnLPxSHku6mS0S0dcir6HjKKlQYjSORz9aQZHvSTepeV0uJ/l019byAuta1HvESV
 vNww==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3R6H59vXVu001gSPzeYxhXpGU2LAC9rMob0T+NV+yYzq1r9z8do8LIJxXzHD1zFsSVmBEHC0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2J4maxTnHf8cwwKiAjZoWJVSpofwo36ROAJZoazTQ7tlELYue
 CPAGyl9MKr2lD4B9bpDf5M/XNGrsTH0kvsu753Sfzv/PUdkmWIziatmabxN59Uk=
X-Google-Smtp-Source: AGHT+IGgPxLDVA9y8Tk733BNOFEgPZln+QoRPKeOCGWwOYPx6W9z6x/QIS3lmeC308VzyUTjRH3V9Q==
X-Received: by 2002:a5d:5e0d:0:b0:37d:890c:63e4 with SMTP id
 ffacd0b85a97d-37d890c6529mr3467308f8f.55.1729167410632; 
 Thu, 17 Oct 2024 05:16:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b81a:d252:4f5b:7c20?
 ([2a01:e0a:982:cbb0:b81a:d252:4f5b:7c20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fc419ffsm7037816f8f.111.2024.10.17.05.16.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 05:16:50 -0700 (PDT)
Message-ID: <8358b171-57ab-4811-b271-5f03c131ca5b@linaro.org>
Date: Thu, 17 Oct 2024 14:16:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/3] image: android: misc fixes when using on Qualcomm
 platforms
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20241016-topic-fastboot-fixes-mkbootimg-v1-0-94fd9340722b@linaro.org>
 <87ed4f2ccc.fsf@baylibre.com> <871q0f2b72.fsf@baylibre.com>
 <66f2ba28-6415-4d0e-87c7-b7d235929569@linaro.org>
 <87y12n0w68.fsf@baylibre.com> <87v7xr0vw2.fsf@baylibre.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <87v7xr0vw2.fsf@baylibre.com>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 17/10/2024 14:14, Mattijs Korpershoek wrote:
> On jeu., oct. 17, 2024 at 14:07, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:
> 
>> Hi Neil,
>>
>> On jeu., oct. 17, 2024 at 14:01, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>>> On 17/10/2024 13:58, Mattijs Korpershoek wrote:
>>>> Hi Neil,
>>>>
>>>> On jeu., oct. 17, 2024 at 13:33, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:
>>>>
>>>>> Hi Neil,
>>>>>
>>>>> Thank you for the series.
>>>>>
>>>>> On mer., oct. 16, 2024 at 17:46, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>>>>
>>>>>> When trying to use the Android boot image with header version 2
>>>>>> on recent Qualcomm platforms, we get into some troubles.
>>>>>>
>>>>>> First the kernel in-place address can be > 32bit, then since
>>>>>> we use the Android mkbootimg, it uses the default load address
>>>>>> which isn't big enough to uncompress the kernel.
>>>>>>
>>>>>> Finally, the ramdisk also uses a default load address, and
>>>>>> it should be taken in account like for the kernel address.
>>>>>>
>>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>>> ---
>>>>>> Neil Armstrong (3):
>>>>>>         image: android: use ulong for kernel address
>>>>>>         boot: image-android: do not boot XIP when kernel is compressed
>>>>>>         image: android: handle ramdisk default address
>>>>>
>>>>> I have boot tested aosp/main on Khadas VIM3 using
>>>>> khadas_vim3_android_defconfig
>>>>>
>>>>> This ensures that boot image v2 still works.
>>>>>
>>>>> I also tried to boot test the Beagle Play board (which runs Android 14
>>>>> with boot image v4).
>>>>>
>>>>> Unfortunetly, that does not boot. The kernel starts but then I see:
>>>>>
>>>>> [    0.434360][    T1] /dev/root: Can't open blockdev
>>>>> [    0.439587][    T1] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
>>>>>
>>>>> Full boot logs:
>>>>> https://paste.debian.net/1332547/
>>>>>
>>>>> Full boot logs on master:
>>>>> https://paste.debian.net/1332548/
>>>>>
>>>>> It seems that somehow, the bootconfig section is no longer present.
>>>>>
>>>>> I'll try to identify the offending patch and help debug this.
>>>>
>>>> Offending patch is
>>>>     [PATCH 3/3] image: android: handle ramdisk default address
>>>
>>> Thanks for looking
>>>
>>>>
>>>> The following (invalid) diff "fixes it"
>>>>
>>>> modified   boot/image-android.c
>>>> @@ -448,9 +448,9 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
>>>>    	}
>>>>    
>>>>    	printf("RAM disk load addr 0x%08lx size %u KiB\n",
>>>> -	       ramdisk_ptr, DIV_ROUND_UP(img_data.ramdisk_size, 1024));
>>>> +	       img_data.ramdisk_addr, DIV_ROUND_UP(img_data.ramdisk_size, 1024));
>>>>    
>>>> -	*rd_data = ramdisk_ptr;
>>>> +	*rd_data = img_data.ramdisk_addr;
>>>>    
>>>>    	*rd_len = img_data.ramdisk_size;
>>>>    	return 0;
>>>>
>>>> I'll debug a bit more.
>>>
>>> OK so this basically reverts the patch, so it means on Beagle Play
>>> the 0x11000000 is valid and can't use the randisk in-place.
>>>
>>> img_data.ramdisk_ptr is the "real" address the data has been loaded to,
>>> and img_data.ramdisk_addr is the address passed to mkbootimg, where it
>>> should be loaded.
>>
>> Beagle Play uses boot image v4, therefore, we go through the following
>> code path:
>>
>> 	if (img_data.header_version > 2) {
>> 		/* Ramdisk can't be used in-place, copy it to ramdisk_addr_r */
>> 		if (img_data.ramdisk_addr == ANDROID_IMAGE_DEFAULT_RAMDISK_ADDR) {
>> 			ramdisk_ptr = env_get_ulong("ramdisk_addr_r", 16, 0);
>> 			if (!ramdisk_ptr) {
>> 				printf("Invalid ramdisk_addr_r to copy ramdisk into\n");
>> 				return -EINVAL;
>> 			}
>> 		} else {
>> 			ramdisk_ptr = img_data.ramdisk_addr;
>> 		}
>> 		memcpy((void *)(ramdisk_ptr), (void *)img_data.vendor_ramdisk_ptr,
>> 		       img_data.vendor_ramdisk_size);
>> 		ramdisk_ptr += img_data.vendor_ramdisk_size;
>> 		memcpy((void *)(ramdisk_ptr), (void *)img_data.ramdisk_ptr,
>> 		       img_data.boot_ramdisk_size);
>> 		ramdisk_ptr += img_data.boot_ramdisk_size;
>> 		if (img_data.bootconfig_size) {
>> 			memcpy((void *)
>> 			       (ramdisk_ptr), (void *)img_data.bootconfig_addr,
>> 			       img_data.bootconfig_size);
>> 		}
>>
>> We can see here, that we **increment** ramdisk_ptr.
>>
>> Therefore, the following line is invalid:
>>
>>      *rd_data = ramdisk_ptr;
>>
>> Because ramdisk_ptr is not at the beginning of the ramdisk, but at the
>> beginning of bootconfig.
>>
>> I think saving ramdisk_ptr in the above block should fix the issues I see.
> 
> The following diff fixes the issue I see on Beagle Play with boot image
> v4:
> 
> diff --git a/boot/image-android.c b/boot/image-android.c
> index a261bb639990..e9d898e003f6 100644
> --- a/boot/image-android.c
> +++ b/boot/image-android.c
> @@ -424,6 +424,7 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
>                  } else {
>                          ramdisk_ptr = img_data.ramdisk_addr;
>                  }
> +               ulong ramdisk_begin_ptr = ramdisk_ptr;
>                  memcpy((void *)(ramdisk_ptr), (void *)img_data.vendor_ramdisk_ptr,
>                         img_data.vendor_ramdisk_size);
>                  ramdisk_ptr += img_data.vendor_ramdisk_size;
> @@ -435,6 +436,11 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
>                                 (ramdisk_ptr), (void *)img_data.bootconfig_addr,
>                                 img_data.bootconfig_size);
>                  }
> +               /*
> +                * Since we moved ramdisk_ptr, restore it back to the beginning
> +                * of the ramdisk
> +                */
> +               ramdisk_ptr = ramdisk_begin_ptr;
>          } else {
>                  /* Ramdisk can be used in-place, use current ptr */
>                  if (img_data.ramdisk_addr == 0 ||
> 
> (it's not super clean, but the general idea should work)
> Can you add something similar for v2?

Neat, I'll try to make it cleaner but I get the idea :-)

Thanks!

Neil

> 
>>
>>>
>>> Neil
>>>
>>>>
>>>>>
>>>>>>
>>>>>>    boot/image-android.c    | 60 +++++++++++++++++++++++++++++++++++++------------
>>>>>>    include/android_image.h |  2 +-
>>>>>>    2 files changed, 47 insertions(+), 15 deletions(-)
>>>>>> ---
>>>>>> base-commit: d5cab0d6adc26ec1bbd45c2fed101184d04454ae
>>>>>> change-id: 20241016-topic-fastboot-fixes-mkbootimg-8d73ab93db3d
>>>>>>
>>>>>> Best regards,
>>>>>> -- 
>>>>>> Neil Armstrong <neil.armstrong@linaro.org>

