Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BB7D2F7CE
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 12:01:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE15488DFD;
	Thu, 17 Oct 2024 14:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e2iRzb2v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB47788DFD; Thu, 17 Oct 2024 14:01:19 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D31288B8F
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 14:01:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4311c285bc9so8629025e9.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 05:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729166475; x=1729771275; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=C7dHHaG1p3OZd9MrOmpA3iHpDmOcIzIVf6jPUe+uxUE=;
 b=e2iRzb2v3b9bWBifqn1xcs8QNwxVB9y8Sqec1WW/uEKipoy/04g8cpB1kALAJMqxgZ
 EDvT52rjZa16/jeIYMhCzSLmVK2iyG/xuogluDdIck40JlHW/TXioSjusmptnnBAhcrW
 TZ4Q7i4hmm8KuGoaSbsyXbmGcYat+PSaqSj6G+Xxgi92j9PVkpVbji6W+5YtmJG1QxL/
 bA0pku1px1a7SBs6vTa463D8H9H/cczcD74Xwuj8a1x5CNkuxabcJirXc5dPPn6b2UHT
 z1fOZHFE9BVkvjNq4pIMI/ySGO+PSiDmujjpq5KtZ47ghyu4jjlQqxX2NRc6XS83St/f
 B6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729166475; x=1729771275;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=C7dHHaG1p3OZd9MrOmpA3iHpDmOcIzIVf6jPUe+uxUE=;
 b=B4wn95bfGVZ11+Dl9ISFf+4WVf2Sskh9eJ7BlpIbEGLTCjL0XglKV1RkBpLFjPDvDQ
 7l8p5GUTYZ8xj9+/BPcGPamb0RUMOrI1dwdQ1eElVi0LMFMGT4fWGmt8D8ibhXDU0ZxD
 qydsWCWH1vMZEODt4l3O0lRI3odQEqCQCP5lHl/t+MBGY4m4UP5utXFkN0CDi9PVmN+l
 2Wo8I3fwHS6eDzpquiojp+SLeiju6BTAuSQTsgw1kFqCL9HMfL6cWhxT2y3aaKYWukxp
 xe8TC9zytFFXiDz+nvv4SnHRfLoRmsdQs1GjlP8SfcqbDyvFpTq5hK32w41tREAA1oSV
 7iNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXb01oRORmphcLRyddGSEXOUyUo9h3K+ctjMD+a2FrxQYJDZ9eoJj/1hVVsjk19uTWG/Mh5Isc=@lists.denx.de
X-Gm-Message-State: AOJu0YzWENv3yBVkAk1hzmVEqsFsZZDn63i/Qwsdqib6lc/pR9tzzofB
 7+OWOlN2bL2gh8i3KRU6/KtdT7EdlYISRJD9lqNoiOGvhzSEIdRyPKYmUV60BRo=
X-Google-Smtp-Source: AGHT+IHpSkFQ1oSGfX/ygjeMpaeV5Qpr0YeZ1+esIQRjpKOOEoPt/r+4cDjRPTNfpTdLO164+Jn6Hg==
X-Received: by 2002:a05:600c:1d82:b0:431:5e53:2dc4 with SMTP id
 5b1f17b1804b1-4315e532f84mr7664525e9.6.1729166474614; 
 Thu, 17 Oct 2024 05:01:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b81a:d252:4f5b:7c20?
 ([2a01:e0a:982:cbb0:b81a:d252:4f5b:7c20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43158c3dedfsm23900085e9.26.2024.10.17.05.01.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 05:01:14 -0700 (PDT)
Message-ID: <66f2ba28-6415-4d0e-87c7-b7d235929569@linaro.org>
Date: Thu, 17 Oct 2024 14:01:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/3] image: android: misc fixes when using on Qualcomm
 platforms
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20241016-topic-fastboot-fixes-mkbootimg-v1-0-94fd9340722b@linaro.org>
 <87ed4f2ccc.fsf@baylibre.com> <871q0f2b72.fsf@baylibre.com>
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
In-Reply-To: <871q0f2b72.fsf@baylibre.com>
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

On 17/10/2024 13:58, Mattijs Korpershoek wrote:
> Hi Neil,
> 
> On jeu., oct. 17, 2024 at 13:33, Mattijs Korpershoek <mkorpershoek@baylibre.com> wrote:
> 
>> Hi Neil,
>>
>> Thank you for the series.
>>
>> On mer., oct. 16, 2024 at 17:46, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>>> When trying to use the Android boot image with header version 2
>>> on recent Qualcomm platforms, we get into some troubles.
>>>
>>> First the kernel in-place address can be > 32bit, then since
>>> we use the Android mkbootimg, it uses the default load address
>>> which isn't big enough to uncompress the kernel.
>>>
>>> Finally, the ramdisk also uses a default load address, and
>>> it should be taken in account like for the kernel address.
>>>
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>> Neil Armstrong (3):
>>>        image: android: use ulong for kernel address
>>>        boot: image-android: do not boot XIP when kernel is compressed
>>>        image: android: handle ramdisk default address
>>
>> I have boot tested aosp/main on Khadas VIM3 using
>> khadas_vim3_android_defconfig
>>
>> This ensures that boot image v2 still works.
>>
>> I also tried to boot test the Beagle Play board (which runs Android 14
>> with boot image v4).
>>
>> Unfortunetly, that does not boot. The kernel starts but then I see:
>>
>> [    0.434360][    T1] /dev/root: Can't open blockdev
>> [    0.439587][    T1] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
>>
>> Full boot logs:
>> https://paste.debian.net/1332547/
>>
>> Full boot logs on master:
>> https://paste.debian.net/1332548/
>>
>> It seems that somehow, the bootconfig section is no longer present.
>>
>> I'll try to identify the offending patch and help debug this.
> 
> Offending patch is
>    [PATCH 3/3] image: android: handle ramdisk default address

Thanks for looking

> 
> The following (invalid) diff "fixes it"
> 
> modified   boot/image-android.c
> @@ -448,9 +448,9 @@ int android_image_get_ramdisk(const void *hdr, const void *vendor_boot_img,
>   	}
>   
>   	printf("RAM disk load addr 0x%08lx size %u KiB\n",
> -	       ramdisk_ptr, DIV_ROUND_UP(img_data.ramdisk_size, 1024));
> +	       img_data.ramdisk_addr, DIV_ROUND_UP(img_data.ramdisk_size, 1024));
>   
> -	*rd_data = ramdisk_ptr;
> +	*rd_data = img_data.ramdisk_addr;
>   
>   	*rd_len = img_data.ramdisk_size;
>   	return 0;
> 
> I'll debug a bit more.

OK so this basically reverts the patch, so it means on Beagle Play
the 0x11000000 is valid and can't use the randisk in-place.

img_data.ramdisk_ptr is the "real" address the data has been loaded to,
and img_data.ramdisk_addr is the address passed to mkbootimg, where it
should be loaded.

Neil

> 
>>
>>>
>>>   boot/image-android.c    | 60 +++++++++++++++++++++++++++++++++++++------------
>>>   include/android_image.h |  2 +-
>>>   2 files changed, 47 insertions(+), 15 deletions(-)
>>> ---
>>> base-commit: d5cab0d6adc26ec1bbd45c2fed101184d04454ae
>>> change-id: 20241016-topic-fastboot-fixes-mkbootimg-8d73ab93db3d
>>>
>>> Best regards,
>>> -- 
>>> Neil Armstrong <neil.armstrong@linaro.org>

