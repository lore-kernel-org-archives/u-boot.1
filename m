Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2D5CD6E55
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 13:33:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EE91848A6;
	Mon,  1 Jun 2026 15:32:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vK1OwXuS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 666B3848A9; Mon,  1 Jun 2026 15:32:58 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 551768489D
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 15:32:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-45f3cf907ceso850258f8f.2
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 06:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780320776; x=1780925576; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=ulKNkeuF3vt0gWCmfxyl7W5OX9yXhyKsaodR4B9cGt0=;
 b=vK1OwXuSbKLHX9bXXXTUcpw8/k7jwVpKVhfm9zvANL0J6vvWaF2J23p26gG32ykaB5
 z6qznFN+s0gjuyjBckM7s85hqqRdVh25ahwmT0GOKdUmTMoIhjAtUzJ6puQkjJ6epeL7
 DVYG+gzlQckEUeHtIx42W8Cr+WnndWT8KKxlMB1d+O/avHE8dNKoGTDuhUerrQJKXjxT
 w8oktdN3q0HfiHCNxgJRSeRLhfE+7bFZTYy2plxjOfcLdbrdVpXxeafA+2w1ZDlW/FLq
 jSBlcvtRsn2zo/LXvua/jAX/DCvfXz+uHWHmScCdF96uWnta4job7H6EDSHEey0NdQl5
 1BLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780320776; x=1780925576;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ulKNkeuF3vt0gWCmfxyl7W5OX9yXhyKsaodR4B9cGt0=;
 b=qEQmUPjSNWzM7Zzh8MA5BXfI39NH5W5KmbFYX5VxVCKQoqryR6kdIuN2X3VNCLPOmq
 F9XBS09aho96li31Oagth7jQYyaLo8W/jtza1mC0Kcf1LnDki/HOtJ1gYSF5lmliSMUg
 LVERSUfZSqehamKLbHc8DZl71DXgTKl1CtEdbZNn63MZe0peu4pF71u/rLosmi6CmbOy
 /ryCCDtlCKf1jf9ZnrOdsUNzH50zr5PhTOkn6qMqu2DYVSZyEo2oOSJUCAkYtbmiNIgR
 LkIMMESRYzPbNhHeJkGAM6H3FPVELRNq1HmHUaI8iSRNVzhbfr0Y7kKVTrNzBkCV0HUh
 bu6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8APAToNt28rOr2KHj0VrcuwoYyxTjBHwplvaUihcGTIA/9UfFEsyQ/S60e/RTFg1dKOidtF9c=@lists.denx.de
X-Gm-Message-State: AOJu0Yya5vqPVKIfZc+lV/cKOfEEMH+1033SXxletDLzJ7lb+4RGyGDz
 Ol1OOylCTZb8Z93+MWXzwvuqQZN5JejiHfk5vT5j85eP4qRxRCmF+NSkmoqNjz9oYfM3aNi0spD
 sGxyEC3E=
X-Gm-Gg: Acq92OH3vPHxkCyVas24PsCtDDxzuPWqt9MS3sezSv4yDtRB9q9zGyrNbHE8v3zhO14
 YDZuvwtuNcDVTdFRvFiUp3LDj6bkBGw9O6KQk8bZJnxDId330o2excRE1dZ8re9fkEc2IaXZek/
 nbr3M4O8tJ4b4/0vPw2BSAKnh4XM8jLtgkZ5VLeTkiI5zRGx7eHtQ6YFCi4drR9qZN/HRFDwbv1
 rnHnxGKWNR7CtwmxnxtEnKeadGfKj2515JcxdihdUI+qOA1HQ0Ok4HTTWHhQ2HzyMl6VWFrbUXf
 AU/H8io2xJXS0XKQ+9CuptEkMb3mVpg+pQ/WKZipFJHLZ6igx23isGJGGwio6B70nmbPwWPHfOs
 p51kc5DtCs0HSiHvvkMPgqQn+sJgc0hojCLJkKMfpo84w+gv7X7ZQV7yKmsKrEKhF+kz8/iR5rg
 82gRVD2Y9IcfjFTzLyYeLtSNmAQtHsuYTjBeRTpMyauVC4LePex9MPnoHhsIL4kmDRSaxHMlBZq
 jd3PKX/Gf48KOcGxw==
X-Received: by 2002:a05:600c:4755:b0:490:4e3e:b483 with SMTP id
 5b1f17b1804b1-490a29335camr182863975e9.22.1780320775595; 
 Mon, 01 Jun 2026 06:32:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:2fd4:bcb3:83d3:ecb5?
 ([2a01:e0a:106d:1080:2fd4:bcb3:83d3:ecb5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c967c77sm267034955e9.1.2026.06.01.06.32.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 06:32:55 -0700 (PDT)
Message-ID: <46d2f58e-f732-4e6a-ab09-b7e83a42a669@linaro.org>
Date: Mon, 1 Jun 2026 15:32:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] **Cover Letter for ufs-tool**
To: Raz Ben Yehuda <raz.benyehuda@mobileye.com>, u-boot@lists.denx.de
References: <20260601112754.2337900-1-raz.benyehuda@mobileye.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20260601112754.2337900-1-raz.benyehuda@mobileye.com>
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

On 6/1/26 13:27, Raz Ben Yehuda wrote:
> This patch series adds support in U-Boot for interacting
> with UFS devices. It provides the ability to
> query and configure UFS device parameters.
> It is customary to configure UFS logical units (LUNs)
> outside the general-purpose operating system,
> as storage devices may be removed or replaced,
> potentially affecting system behavior.
> 
> This tool has been tested with UFS devices from Micron and Western Digital.
> 
> Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
> 
> --- b4-submit-tracking ---
> # This section is used internally by b4 prep for tracking purposes.
> {
>    "series": {
>      "revision": 1,
>      "change-id": "20260601-ufs-tool-030d47d5df42",
>      "prefixes": [],
>      "presubject": ""
>    }
> }

You should send the patches with "b4 send" so this doesn't get sent and
all the patch numbering is handled automagically.

The cover letter subject should be like another patch subject, like:
"ufs: add ufs tools commands for provisioning and debugging"

Thanks,
Neil
