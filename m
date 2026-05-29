Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B7CCD6E45
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 07:54:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74EE5846A3;
	Fri, 29 May 2026 09:54:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s/pdIU4Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37B03846A5; Fri, 29 May 2026 09:54:38 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEE87844CF
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 09:54:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-45eeba68948so966108f8f.1
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 00:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780041274; x=1780646074; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=jOS5oAAcO/zD2ytFBQCWYtJXQ4Zn5WNdyeU6uD7Ojn0=;
 b=s/pdIU4Qz+wuRxe1nTYya8xvqfrOvytGv8MiMTmOdaoE1YX/OznHlu6VopAAQbI929
 9+Lt2uBHQVFKHm0CGJbcL5LQIYgOXb18l5jPWg2v2ci0l99tmKnhDhUCVt1AP/8r1OYf
 3xJfi9/ije4h2/3q24nK5nvGI4PFIGvuc+5LJdpVBNSnPjw6de9T2p4m5+5CfdQcrsOv
 UQUO5eFqUgXlsADnTOGwKeSR1u5cubmDsKXeOdY2PcBfbyOsNnKm80dxIWolqYU5Y8yj
 oyr7jMpAqYiqn8oQn3ri7PcxhNBKCT/XEheCBXnZaTIfu6j1EbdWlwy3avnRaLOJlT3L
 xTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780041274; x=1780646074;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jOS5oAAcO/zD2ytFBQCWYtJXQ4Zn5WNdyeU6uD7Ojn0=;
 b=LIGNVjm6d77vMJRUA5nw5b5mhcexQ9WNmyoZDTKJYw2DZfRnYtfrT9Fa4bAahxCy5X
 5W2ALHUGrlHMyPlySmhk801D8d9BlbsQ9scZvsfuU3weaGbOSsSYejtH9r0/YNZGygbA
 BpQUMow40Zq68pqZ3D2Vr+bYiwp+9m006l/1R0V0cW5U4lOpXo1Kfs0U6l/FxW1pWcos
 igJ0HL6chjcN1PWS3mjI8n2wvWLiKkHjMznfhdQxHnHFcKVbNf0tGTb90WIVz5SmF+8X
 8fKnfyrHepiujSD6TarDk5KyBKSLdGuVIC35XZozURgWwkhRbphtVMFLd3hJTnRNd2ey
 WWRg==
X-Gm-Message-State: AOJu0YzmyDSDZXAGwpCV62XtwspSkB2n+InxlIhYIUn/Ui+m0zcPqH/7
 txeemQavGcHEfw0COrqYcXmpKHZ9Idy6h7Al97d4yv/AU8XsNJezOMK3bamhgReEcMVCQBLU9Oo
 Lmlzd/Pg=
X-Gm-Gg: Acq92OHaGD+2ZeXeIt6aSK6826BPOpC1tF1Xn2Aimq+Zxj4GhPCt93K6fxYn0oB08U4
 K+87uQh+E6R3EJFYmV1YrxLF2gGzEDBlR0ltaSKN23acPvMsRw40A7nBJI3Jvjx6ckf0VkG/pcS
 HE+Kc8u6wkn5JpTabHhRF4QaAq9W26Ek7ZlwqoyE7HE5o09F7sZlc+SsUo0/6yO1Q+IH4oeIzH5
 ausi3tYdiMu8xekp/Z+NCQlEBEKELmMUWdXC0TSZN1oo2HCVF72FI2IkpCtSO2GWOH3Qb8dc3z7
 Ypmt68EtyIL2oTriiwz1L/Pcq0nA8VBuVmGjzpsabSALLMJGMW0SmGYGKSFXM+/8bZf0zfNt5OQ
 HfgKcjiXrbrEZ8EbQ6k3rPL5mHbRYQ5u9wvHJMg0LKVQE0tVfzmwByviOVAp1UjogMLpGlOwSzy
 Lv4sOejWc+/8vVV5j9LwBc3s8zquTONoxEUbDRiU26kQ==
X-Received: by 2002:a05:6000:25e9:b0:452:a293:4d91 with SMTP id
 ffacd0b85a97d-45ef13a8dc6mr3262475f8f.0.1780041273729; 
 Fri, 29 May 2026 00:54:33 -0700 (PDT)
Received: from [172.20.10.3] ([37.167.96.43]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3556f51sm1621954f8f.25.2026.05.29.00.54.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 00:54:33 -0700 (PDT)
Message-ID: <162d730d-934a-42ea-adf6-18376971086e@linaro.org>
Date: Fri, 29 May 2026 09:54:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 2/5] drivers: nvme: Implement NVMe flush command (0x0)
To: dmukhin@ford.com
Cc: u-boot@lists.denx.de, sjg@chromium.org, trini@konsulko.com
References: <20260528012056.1744362-1-dmukhin@ford.com>
 <20260528012056.1744362-3-dmukhin@ford.com>
 <baab255f-2cd9-4084-89b6-102a0c22ed19@linaro.org> <ahkJpZXnVVz5n26b@kraken>
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
In-Reply-To: <ahkJpZXnVVz5n26b@kraken>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 5/29/26 05:36, dmukhin@ford.com wrote:
> On Thu, May 28, 2026 at 11:28:33AM +0200, Neil Armstrong wrote:
>> Hi,
>>
>> On 5/28/26 03:20, dmukhin@ford.com wrote:
>>> From: Denis Mukhin <dmukhin@ford.com>
>>>
>>> Add flush command implementation along with a high-level
>>> disk_blk_flush() API to be called at certain checkpoints
>>> during the boot (e.g. updating custom bootflow flags stored
>>> on NVMe).
>>
>> First general comment, please split the patch by adding the
>> flush infrastructure first and then the nvme support.
> 
> Will do, thanks.
> 
>>
>> The for NVMe, can it support write-through like SCSI FUA (Force Unit
>> Access) which bypasses the cache on writes, with slower writes
>> but safer and simpler than calling a flush before OS boot.
> 
> Yes, I've seen there was FUA patch [1], which was then reverted [2].
> 
> For our purposes, flush seems to be enough: the use case is
> updating NVMe-backed boot counter from a custom bootflow.

OK the FUA was reverted because Bin's comment was not adressed:
https://lore.kernel.org/u-boot/CAEUhbmU02GnqEEfuqNrSj8R5XEZkmkTUaLp1+BMbYQNdzTUZ7A@mail.gmail.com/

I would prefer having FUA added so all board could have this enabled
and not have to update their boot flow to call flush, this was basically
why the SCSI FUA was enabled.

As Bin's comment, perhaps a way would be to disable the Write Cache if
the cache is present as init time (WCE), and it's even simpler, or
get the enable state of the WC and use FUA if enabled.

Because the same question remains with the flush command, it's
only valid if the WC is present and is enabled.

Thanks,
Neil

> 
> [1] https://lore.kernel.org/u-boot/20211019104049.v3.1.Ic581ec99f46b6dfa2e0b1922e670a333ac859e82@changeid/
> [2] https://lore.kernel.org/u-boot/CAGi-RUL96GK5nfHx73UQQd_4sFByt3gNwqhFpHps+h58S20JwQ@mail.gmail.com/
> 
> [..]
>>>    /**
>>>     * blk_find_device() - Find a block device
>>>     *
>>> @@ -559,6 +577,16 @@ static inline ulong blk_derase(struct blk_desc *block_dev, lbaint_t start,
>>>    	return block_dev->block_erase(block_dev, start, blkcnt);
>>>    }
>>> +static inline ulong blk_dflush(struct blk_desc *block_dev)
>>> +{
>>> +	blkcache_invalidate(block_dev->uclass_id, block_dev->devnum);
>>
>> Call blkcache_invalidate only if flush cmd is supported
> 
> Ack.
> 
>>
>>> +
>>> +	if (block_dev->block_flush)
>>> +		return block_dev->block_flush(block_dev);
>>> +
>>> +	return 0;
>>
>> Why do you return success here and not from blk_flush() when flush is not supported?
> 
> Will update.
> 
> 
> Thanks,
> Denis

