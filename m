Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56212C5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 13:45:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E2D882B07;
	Tue, 10 Jun 2025 15:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aQooOWvo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8D1982B0E; Tue, 10 Jun 2025 15:45:42 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 694FF80E9A
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 15:45:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a3798794d3so4697315f8f.1
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 06:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749563140; x=1750167940; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=bbEA19u7SgvTpqrtzWD/lPTZL9Qebz8zSvBeCiXefUU=;
 b=aQooOWvoVQZvsmANbY7Mqu65GRk7cFGYfyRjIt8dpd2NiuwuYAf0FhMQj1V36/SvUq
 h0opfRmNL6qBfGvFvfwkdi392HBUrZJGyl+WVcm2mo/xIRyTWW7ICZuOwohQQtNojgQL
 LRSpMVI1ms2Y8QM3F5i8+qlsvx9EGoG0FRNwVkqaD0mTloTbvXv0zOsu8+taBtFqcfDP
 Nbn74dYC06QgE/8hLsGgX5AKggVnSeTsB4hg3esP+yB7E/v+OfbcAWUt1IhJODzLxL2T
 C82Z3DlfZGpcpmvN8HkCAsXhj4/DR/VogtZ207A6a5SBLKtXbGOTQPEI3A6n/RXA5dsW
 VGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749563140; x=1750167940;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bbEA19u7SgvTpqrtzWD/lPTZL9Qebz8zSvBeCiXefUU=;
 b=HO+0fDH4qfnVwS+UF56Pj+ha0fIRFViVEQEIeLrhDkEKbi++SlIf8/9FzDLC1Cu+Wi
 neoohUWmsIlqWsgN3XLy7kyPUJHn2Y/SCnZJvOSbBybN5P7dXcBLzsTwe+d9B9Xffduw
 jU2RqsllYCLJsYhp5MvpNqjpvF7AN+zlWuXfiVw+530sU/jd7GJqEtB90Oe8bGxEi/87
 gUvCt4C9+budNLYgs0jACbo10O5l0ax/YNwBL8GUDzyCLnyMQxUpOcscsOOVd58Mk3b0
 4PcrL1bjc7H/MPCv5WQNyaEzmZrAMQi/74LLEFJ8HEEgjqdK6n42JcTkPX3ihdI3C4vE
 C42w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWflcIy+trJRzoDquWIe2O6FDicsgJLOovO6m8hibQHrTove6yr+xmoBcpYau2U03eaO1FE5fI=@lists.denx.de
X-Gm-Message-State: AOJu0Yx2dCwtsl3j9s4LSSsId2t56XapAKoZwhwH++IEd2MW5CCEqYu5
 65bsPHwcRH8OA1Zx+va0tqfF2XwRLFG79OaE9kT7TiB9gkFdJKpCqS7tF7cbSOivb2c=
X-Gm-Gg: ASbGncspnIj1fBNtd58GDNxkdrsv/frVRh4X5jR7MVFDxuz2dOeop3AmC6bKj36RUq1
 TQ9KQoVNMiyEdccEQoBBpXu72Mby8GWuVyaRBKJpq5YxDxnNV++P9RMyK5iL8YbE630T20EoD8k
 PPbJPjIJvxKqa1kggU37UGWqC3dFgHjk0rPJXopRI7kuETBSlPMaXFiQMUQ8e8ntewq9b/4eGpP
 xQZF9/BhiacSJ0PQ2IyvuQJ0+Ywhiaeuj+3kvYa5TanypU400nQtSqBagw7UMZrlSk1tgkGsBRu
 9lNFyuJO2OIcRugpCRMdl+GMdzTI99L9tNu4See6QpRf4AL8C6rjmhZS2UtXVcRMVG378xt+1tm
 QAJnzaxKfKaghHmhfohInhgOvxiXu+b0Jl1VM
X-Google-Smtp-Source: AGHT+IERVRHlRqLdphYoLL63hGzqCOxKz2QsWhj84Lk8MosaasNbZ+/mEIwadlcGZYUQph9NbF50GA==
X-Received: by 2002:a05:6000:2482:b0:3a4:ec32:e4f3 with SMTP id
 ffacd0b85a97d-3a531ab517emr12256255f8f.17.1749563139768; 
 Tue, 10 Jun 2025 06:45:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f0b:a9b6:d508:9d14?
 ([2a01:e0a:3d9:2080:f0b:a9b6:d508:9d14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5323be604sm12183732f8f.42.2025.06.10.06.45.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 06:45:39 -0700 (PDT)
Message-ID: <4476151c-aad5-45b1-8573-a5e5b12cdcc3@linaro.org>
Date: Tue, 10 Jun 2025 15:45:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFT v5 3/3] fastboot: integrate block flashing back-end
To: Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Dmitrii Merkurev <dimorinny@google.com>
References: <20250606-topic-fastboot-blk-v5-0-203538ec5b32@linaro.org>
 <20250606-topic-fastboot-blk-v5-3-203538ec5b32@linaro.org>
 <20250606143638.GS1382132@bill-the-cat>
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
In-Reply-To: <20250606143638.GS1382132@bill-the-cat>
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

On 06/06/2025 16:36, Tom Rini wrote:
> On Fri, Jun 06, 2025 at 11:33:09AM +0200, Neil Armstrong wrote:
> 
>> From: Dmitrii Merkurev <dimorinny@google.com>
>>
>> 1. Get partition info/size
>> 2. Erase partition
>> 3. Flash partition
>> 4. BCB
>>
>> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/fastboot/Kconfig      | 29 ++++++++++++++++++++++++++++-
>>   drivers/fastboot/Makefile     |  1 +
>>   drivers/fastboot/fb_command.c |  8 ++++++++
>>   drivers/fastboot/fb_common.c  | 22 ++++++++++++++++++----
>>   drivers/fastboot/fb_getvar.c  |  8 +++++++-
>>   5 files changed, 62 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
>> index 70207573de2bd0d56b4b7fa6f7e17fdc5803ba15..75911468ba4980d9b96e2af9e708f08b9ef16ac8 100644
>> --- a/drivers/fastboot/Kconfig
>> +++ b/drivers/fastboot/Kconfig
>> @@ -91,7 +91,7 @@ config FASTBOOT_USB_DEV
>>   config FASTBOOT_FLASH
>>   	bool "Enable FASTBOOT FLASH command"
>>   	default y if ARCH_SUNXI || ARCH_ROCKCHIP
>> -	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS)
>> +	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS) || BLK
> 
> This is what's tricky. The symbol FASTBOOT_FLASH is default y for all
> ARCH_SUNXI and ARCH_ROCKCHIP platforms where FASTBOOT is enabled. Since
> looking in to effects here isn't super well documented, I'm going to be
> a bit more verbose here than I might otherwise just to have a post to
> refer back to later (possibly for adding to something under
> doc/develop/).
> 
> So, tools/qconfig.py can be helpful here. If we use -b to first build
> the database of boards and CONFIG sybmols enabled, we can then do:
> $ tools/qconfig.py -f FASTBOOT ARCH_SUNXI BLK
> to get everything that is FASTBOOT and ARCH_SUNXI and BLK.
> We can also do:
> $ tools/qconfig.py -f FASTBOOT ARCH_SUNXI BLK ~FASTBOOT_FLASH
> To get the same as the above, but do not enable FASTBOOT_FLASH. This
> gives us the CHIP platform. This is going to be the one that now enables
> the new functionality. If we do the same but for ARCH_ROCKCHIP we get
> zero matches. So this is our culprit.
> 
> This means the series, and this patch here needs to also disable the new
> functionality on the CHIP defconfig.
> 

Wow thanks for finding that, I didn't imagine this could cause such issues.

Thanks,
Neil

