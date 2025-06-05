Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20F8C5AE59
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 08:17:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16CD281E25;
	Thu,  5 Jun 2025 10:17:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="D8CDr3XG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CE4F82145; Thu,  5 Jun 2025 10:16:59 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7941B8091A
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 10:16:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so1153269f8f.0
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 01:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749111417; x=1749716217; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=bGiLyFdRRs1BavfOyzfULUHOEFbyoyTajcolpI2fOLI=;
 b=D8CDr3XGQqIJEKTEoSwUkLecdrVPeH0FSeayLpsQOwDCZr4QYGBhgsD+LjVgup/2gh
 knq23BhYEMBg8a4iPkxasZk1VYdafdtlXhEMFgGGaFTakSrJfYB0nn+HSz7oxy4wvlli
 YbeYGTs3izgJXKfVW2myXzcnssvqSI1MZ8xBcHx6RsGq5zb4l6qyuyDhpfWixO+fOQRm
 EgRSvF1ul0RhpHxQXMcXmtBDruBynofTgIctkc9WNuEbidEQeyD3O0dYraUfNOsjPorA
 hj0BUPrwIcGeCEyTBrfV3L2UOnTXqaAchjFlB+iH8Fs8k7jjjdp9dhN0YFVWqmienkrM
 i4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749111417; x=1749716217;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bGiLyFdRRs1BavfOyzfULUHOEFbyoyTajcolpI2fOLI=;
 b=Eg4MzlJ/gpZC6ewGwpP8odyhOU9wtoZQfsJ1E/kVTupAdEOMvN7S6CmFxqGkwdyf8j
 2OIs5N7hTCbM5iiEl9QDqUBCOdpEKOmUM9cboNwqVWxQHNqmsbvz92ENoovijINBsNQL
 7JE9sM8+LuswmoIv0yvOyQ4vrZ+7ZGonhkYVs6IteFz3yuBKdqNWWqk8oJT9mEJdfjKo
 dtk+htb8sUICmAeQofRQSk18fVBiivEyZm6BcPELP0ELsWgN5/nsaP4DsRZ102DT1kDK
 b0G9817Rinn5Ly8gdH2pRbuoGLlR4wQ/Kw731ET4g3dYq9x54osStTVNx9nduDMBqpg+
 a0EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9+GAbcmNl+wySCFvdgi9jqT98n6nfWY9ldFcLvifqRZVVyIDQKs5Es6df6/C6ku22DKZgul4=@lists.denx.de
X-Gm-Message-State: AOJu0YyT3N85NO0vT6l11w9Od1bcO2NkoEJ87pSyL5TtEu8ZSbuYkXVx
 Cb2YmWmfaMG46MU+OL9i+eDlP08iTXN/iQ+fJXeXB3QNnRYFWzlYclEtaJporqLgOno=
X-Gm-Gg: ASbGnctwrIXlfaEnf5JN2kCDOt9/RZ32CfO1mp6DkEULaxzyPNMAgcxGHRgSiIIr2vW
 nhdT73Luibd+GgzAN8PHVBalsJXT5ocJDcqhx5Awp6t40dNPghiKPLk6F5QGNVPpxevfmOF9j4E
 E5VCXsxkCuhy7FC2SH4rMFPOTgGHbF/Ri1AQz9GZscLne0o2A0S/3oTCXlj9pMROx3iUpcbpgCP
 PmCzxBnqb/qsshB1n0OuTIMhzE0FzYmd28rD08kvx+n+KrP65kSsjatvKzXNXTfFaTpr5jGp1Nt
 Va8k8UKaqN7WRLCfyFTmIaOpmHPF/hkjq/Z43NFQQgIi09ovnorG0nHCCqbV7A01QlNygWNZaQh
 9NJb0MwN9Z4/ChMDgmGiFASEEHKIFyPgx12n9Kg0=
X-Google-Smtp-Source: AGHT+IH1GUW2eozBFfZgbnod7f4s2dhK0pl4H8TDPSrOwHrgy40VNpTW6/r5624aKp0VgxHvjz8KLA==
X-Received: by 2002:a05:6000:18a5:b0:3a4:c71a:8119 with SMTP id
 ffacd0b85a97d-3a526e177e2mr2224273f8f.25.1749111414951; 
 Thu, 05 Jun 2025 01:16:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:53e5:f2b3:9ac1:62cd?
 ([2a01:e0a:3d9:2080:53e5:f2b3:9ac1:62cd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5215e4c4asm3724344f8f.17.2025.06.05.01.16.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 01:16:54 -0700 (PDT)
Message-ID: <b83cfc3a-39e6-4710-a6ac-c24c878052cc@linaro.org>
Date: Thu, 5 Jun 2025 10:16:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFT v4 3/3] fastboot: integrate block flashing back-end
To: Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Dmitrii Merkurev <dimorinny@google.com>
References: <20250522-topic-fastboot-blk-v4-0-af7f7f30564d@linaro.org>
 <20250522-topic-fastboot-blk-v4-3-af7f7f30564d@linaro.org>
 <20250522143958.GJ100073@bill-the-cat>
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
In-Reply-To: <20250522143958.GJ100073@bill-the-cat>
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

On 22/05/2025 16:39, Tom Rini wrote:
> On Thu, May 22, 2025 at 02:37:07PM +0200, Neil Armstrong wrote:
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
>>   drivers/fastboot/Kconfig      | 29 +++++++++++++++++++++++++++++
>>   drivers/fastboot/Makefile     |  1 +
>>   drivers/fastboot/fb_command.c |  8 ++++++++
>>   drivers/fastboot/fb_common.c  | 22 ++++++++++++++++++----
>>   drivers/fastboot/fb_getvar.c  |  8 +++++++-
>>   5 files changed, 63 insertions(+), 5 deletions(-)
> 
> I know this was posted before I replied with more feedback moments ago.
> 
> [snip]
>> @@ -193,6 +197,31 @@ config FASTBOOT_MMC_USER_NAME
>>   	  defined here.
>>   	  The default target name for erasing EMMC_USER is "mmc0".
>>   
>> +config FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
>> +	string "Define FASTBOOT block interface name"
>> +	depends on FASTBOOT_FLASH_BLOCK
>> +	default ""
>> +	help
>> +	  The fastboot "flash" and "erase" commands support operations
>> +	  on any Block device, this should specify the block device name
>> +	  like ide, scsi, usb, sata, nvme, virtio, blkmap, mtd...
>> +	  The mmc block device type can be used but most of the features
>> +	  available in the FASTBOOT_MMC will be missing.
>> +	  Consider using FASTBOOT_MMC on a MMC block device until all
>> +	  features are migrated.
> 
> A default like "" in order to un-stick configs that are now here and
> enabling the option is wrong. If we're enabling new functionality for
> platforms, it needs to be configured correctly. This leads to building
> code on platforms that won't be used on the platform so we've likely
> added run-time bloat for no benefit.

I agree but what's the solution ? I'll prefer having no default as it was initially.

> 
>> +config FASTBOOT_FLASH_BLOCK_DEVICE_ID
>> +	int "Define FASTBOOT block device identifier"
>> +	depends on FASTBOOT_FLASH_BLOCK
>> +	default 0
>> +	help
>> +	  The fastboot "flash" and "erase" commands support operations
>> +	  on any Block device, this should specify the block device
>> +	  identifier on the system, as a number.
>> +          The device identifier should be 0 for first device on the
>> +	  interface type specified in FLASH_BLOCK_INTERFACE_NAME config,
>> +	  1 the second, etc...
> 
> This help should be one paragraph and note something along the lines of:
> - Device identifiers are numbered starting from 0.
> - The most common case is to use the first controller.
> 
> And then yes, "default 0" is fine here because it is a reasonable
> default when configuring the system to use the functionality.

Right, I'll update with that.

Thanks,
Neil

> 

