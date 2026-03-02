Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D2AE9B344
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 09:49:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 531A283E63;
	Mon,  2 Mar 2026 10:49:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FnXRymCA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0E6183EC6; Mon,  2 Mar 2026 10:49:22 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5590183CDF
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 10:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-483a2338616so26460235e9.0
 for <u-boot@lists.denx.de>; Mon, 02 Mar 2026 01:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772444959; x=1773049759; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=NfUpctEpUNQEOAISJBQIbdqwi/+97Hw5Kxf/Ai7gfok=;
 b=FnXRymCARmVBcxEjv8bzohZA1Zv+H3v3XnVy4adKw3IJ7IgpD3swPh/l7F14vsEWPZ
 36IjJfeCDXeCTjEmkanbZUW4T7UMLgWL2GQ3Wi6vs/RhOWyqmwn7svYwqoIlsryyEmJJ
 nOprn0TEbwNtAoYVZBONc2j4BPEoaY/bXarIxn5mlVHRBiCLvquLBoTduwJrwhxjgbJg
 66SkK1mpGSOm5vwuilhsb45YIRG4OFDNEJlQ4NXC8J/DibVzTaG6wWqPCTrwuspVGyfC
 vtBv3Sslu7OUUK+SpZRU4ZtbEaAjATEG/C/kRVQUThsryfcOlMmWciL444a4OvD6d5vo
 LrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772444959; x=1773049759;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NfUpctEpUNQEOAISJBQIbdqwi/+97Hw5Kxf/Ai7gfok=;
 b=ZclbMa5FCL5NMQaT1yQ72tQZEm1sQKTxJNHITdpClr3dJYVLGAFXCQ5PW3Xcu/Lrzn
 j1m8MWZsPkokNYzjOxn7iXkAZvI4Ai3A42XIlD1iYATcx72wqwI1YPyfIYzVCRo1DpNB
 td6921+84WGovTSjh6HGskE6hpVu5BC536L5whuZAmyEosYLzfbGcEAsoNDPa7CA0Uts
 kp/+Zq0RYAFNIyyudzIj+2T/kCvKC9IDWa5UkTu2Sju5cE/TUK2vMImnWix/6d4zNIpz
 DFQnRT65WTAFIQObVfbkHIajuq9qMGI5XAaHu5ntwvs6dpIuKaQeyp7sKf+Ru68JsIrE
 DbcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKP6yS4k4lL2DiuXqAMbw5r6EUp5KwrwjLTL9GAJdNmt+4Wu3fP2KuP0PhzSD44HAklOTiG+U=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7Nggv9cki4UyOvbDk33RzKVMcTsLODcJ8lsFesGMj2SD6iqIY
 vyb1RGIHxMjBWnnjJIv5k/lXXpEV/5ftHW5cw1XZOUrB2rJK4uBqy74hGjrGANYtr9I=
X-Gm-Gg: ATEYQzwz4j/bXM8UsMdI2kj6Cyd8FKIUF/hxE5kUv7VAxkjDFwPFrjxvZF1Z9JU2ol5
 7C/kXcCZZAV9bBUUUDSncJ9zxdmwZlVp1HHYVfns4qg+7H9s++FnZWcTzgVWBmSHsM5BRtKpXSb
 LCO+4ntta32ec+qedsUMMyEBEtWsQA4JwvyDAUEfTUMaYC2nE/UCqMyu5hwcaTOol0tyZESbyHv
 NdZTU4fQLkqkvHRhJKku1X6hwxhDWka7cLdgg31ZqS8yibkZlXB8Pcydmz/hxphaiPwz2RINPnQ
 sReAvl2HWbUoT4I8YvzIygrr9x1X9gYe3s9HzmIjs9CRfsvhJcSYY8tY4usp7LAtBt/3b1kDB+t
 IiA6mVFNEI56LJ1//4t7R/UFn8JQrgdKURelt75CTEE6Xn3NxjA1xadR605NDASMiZEUKTFAXi8
 FiwqZk7XKjJGFUn0+xu0gWgfTjx9lNaHid79sMz2PYL5fW0kwbgBLjRJf6X8fKLyB76Lnq66ryQ
 UpYb+Q2x9nHTIg=
X-Received: by 2002:a05:600c:c04b:10b0:483:79a6:e7e1 with SMTP id
 5b1f17b1804b1-483c9ba7e28mr145860455e9.7.1772444958601; 
 Mon, 02 Mar 2026 01:49:18 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:c342:61e:309c:3478?
 ([2a01:e0a:106d:1080:c342:61e:309c:3478])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c765c67sm28111046f8f.32.2026.03.02.01.49.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2026 01:49:18 -0800 (PST)
Message-ID: <42718ff6-d698-4c6c-8b00-e5106c40f8f4@linaro.org>
Date: Mon, 2 Mar 2026 10:49:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/1] ufs: don't select non-existent CONFIG_PHY_MTK_UFS
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Shawn Lin
 <shawn.lin@rock-chips.com>, u-boot@lists.denx.de
References: <20260225063100.46962-1-heinrich.schuchardt@canonical.com>
 <578013ec-1f37-4d66-8d6b-c268a5b660be@cherry.de>
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
In-Reply-To: <578013ec-1f37-4d66-8d6b-c268a5b660be@cherry.de>
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

On 2/26/26 13:38, Quentin Schulz wrote:
> Hi Heinrich, Igor,
> 
> On 2/25/26 7:31 AM, Heinrich Schuchardt wrote:
>> Symbol CONFIG_PHY_MTK_UFS does not exist.
>> Don't select it.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>> CONFIG_PHY_MTK_TPHY seems to be the only Mediatek PHY driver symbol
>> in U-Boot.
> 
> This binds against mediatek,mt6878-ufshci compatible property. We have no DT in U-Boot with that compatible. I couldn't find any mention of this compatible or this SoC's support in the kernel mailing list(s) either...
> 
> The PHY symbol was actually defined in patch 1 of the series, see https://lore.kernel.org/u-boot/20251011-mtk-ufs-uboot-v1-0-a05f991ee150@mentallysanemainliners.org/
> 
> Considering the kernel binding for the Mediatek UFS controller requires PHYs, I'm assuming the series shouldn't have been partially merged, especially the controller part without the PHY. (Note that the kernel binding still doesn't list MT6878 as supported).
> 
> @Igor, maybe you can work on a v2 for the first patch in your series so we don't need to revert the UFS controller part since it's unusable today as is (first because no DT with this compatible is found, and that even if it was, there's no PHY driver while it is required for the controller to work). If the PHY is not required by the code, then it doesn't follow the Mediatek UFS upstream binding (providing mediatek,ufs.yaml is where MT6878 support would be) and shouldn't have been accepted as is. We do not want to drift apart from the kernel bindings any more than we already are.

I should've probably merged the PHY driver at the same time.

Neil

> 
> Cheers,
> Quentin

