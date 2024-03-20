Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7725CC54E67
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 08:26:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A832087FCC;
	Wed, 20 Mar 2024 09:26:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IwxIImfI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38100880A5; Wed, 20 Mar 2024 09:26:39 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8296F87D91
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 09:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33e162b1b71so5474728f8f.1
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 01:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710923192; x=1711527992; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=sA6hfOv/GrozAQALYrpj5DHPcZyVm6OFqqe9N4y4qiE=;
 b=IwxIImfIMxs895Cpsa0Txd6O5FGVrYp7hSZ7fF2pgEJ4BEaysF0w+GB38E1GY0qfN5
 kVuoxi4BaRv96w4pJ6Y072yVCDquLn5gl/CJKiCwX8E5GSL8Nf9ewJhquFkr4li5xus0
 BWx9TJawTjh7ePuiDI0qn3JtTau5+Xz9ct3yotp+Z9qTNrXfpoV2eAJSHlPemufmJNfC
 JoAtfJwUzXkdsmkz7UdnYQ6kVdAStVouL1iTICZe0NTEeYFVxTfYvfExD1LbQMVnSuEW
 lFPfqldcL2bjVaZhF0Bh7Gip9BqXRR+9Zv/mwmFzkncxgszr565KZNgtSXo9P7Rgbtrv
 F6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710923192; x=1711527992;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sA6hfOv/GrozAQALYrpj5DHPcZyVm6OFqqe9N4y4qiE=;
 b=FeaB/7RRUqSzapoH3EUi51HyVCcr8oxoj9DgwxMDr0f+l5VSNdbpXrPZZhqCF92/NS
 C320vANp/ruEJJWby1Tr7vCHC8MG1B83sy+ZdYAYRUdVv+Tuetjnrm4kWAVdg2HsVu3L
 JaNgwq71XPo7Nj640XU/4IdZDsp11pLa6pExlzBYLenhgQbDwNvydhnnf+ohXjp3GpE+
 36BK+VIOhRofijVJV4mmzzTV9olaz4AFDZmNImbIUdBjP1Q1GAeRaoswLhoaX+/kHETB
 7ZMWkMjTIpIJHWOvbu8WvCvIZhmFIKmtHFL8tsBrFNX7jaGk0OXmiBMghDek+PdAip4p
 0W8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYL5yKXaJ0R9JuNKXSoMYxquPRAalLna8e6QqzBttKP0Yy7JjUuunuXaJsAhDA5aF8WfsC0fnORY6jmpc9anIz5DGXWw==
X-Gm-Message-State: AOJu0Yx92A9z3z1Sz/mRbLAz5y+N4PTkj9hXdvU4aLZYopCvNa3iRG85
 Cj2Y+zc8Mv+DZzNsYv57uO/CUBvuuAX8YeTOSPJ30vDM5eEQjkfmfM+QSURz2HY=
X-Google-Smtp-Source: AGHT+IGWkI1yCAg3/Svub6hBQgd2mU4HJZS5b/5uLP0JIgMNpYinPc8i2Hej/bFlg5+y+yF8JqRy4w==
X-Received: by 2002:a05:6000:2a1:b0:33e:7750:781d with SMTP id
 l1-20020a05600002a100b0033e7750781dmr4477769wry.56.1710923192533; 
 Wed, 20 Mar 2024 01:26:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:13bb:18cc:75cc:ae59?
 ([2a01:e0a:982:cbb0:13bb:18cc:75cc:ae59])
 by smtp.gmail.com with ESMTPSA id
 bn23-20020a056000061700b0033ec812ee0esm11574470wrb.71.2024.03.20.01.26.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Mar 2024 01:26:32 -0700 (PDT)
Message-ID: <34826ce3-3d9e-4f1b-9f77-23df6ef7f17f@linaro.org>
Date: Wed, 20 Mar 2024 09:26:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] board: amlogic: fix buffler overflow in serial & usid read
Content-Language: en-US, fr
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Vyacheslav Bocharov <adeep@lexina.in>, Tom Rini <trini@konsulko.com>,
 Beniamino Galvani <b.galvani@gmail.com>, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de
References: <20240319-u-boot-fix-p200-serial-v1-1-9a4e06815de0@linaro.org>
 <f6810e14-2058-4bc2-9001-ee2cdaa8f585@moroto.mountain>
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
Organization: Linaro Developer Services
In-Reply-To: <f6810e14-2058-4bc2-9001-ee2cdaa8f585@moroto.mountain>
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

On 20/03/2024 06:28, Dan Carpenter wrote:
> On Tue, Mar 19, 2024 at 03:53:24PM +0100, Neil Armstrong wrote:
>> While meson_sm_read_efuse() doesn't overflow, the string is not
>> zero terminated and env_set() will buffer overflow and add random
>> characters to environment.
>>
> 
> In the Linux kernel we would give this a CVE because it's information
> disclosure bug...

Yes probably

> 
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   board/amlogic/jethub-j80/jethub-j80.c | 6 ++++--
>>   board/amlogic/p200/p200.c             | 3 ++-
>>   board/amlogic/p201/p201.c             | 3 ++-
>>   board/amlogic/p212/p212.c             | 3 ++-
>>   board/amlogic/q200/q200.c             | 3 ++-
>>   5 files changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/board/amlogic/jethub-j80/jethub-j80.c b/board/amlogic/jethub-j80/jethub-j80.c
>> index 185880de13..d10492cc46 100644
>> --- a/board/amlogic/jethub-j80/jethub-j80.c
>> +++ b/board/amlogic/jethub-j80/jethub-j80.c
>> @@ -28,8 +28,8 @@
>>   int misc_init_r(void)
>>   {
>>   	u8 mac_addr[EFUSE_MAC_SIZE];
>             ^^^^^^^^^^^^^^^^^^^^^^^^
> 
> This one is also a problem.  You can't pass non-terminated strings to
> eth_env_set_enetaddr().  We call strlen() on it in either hsearch_r() or
> env_get_from_linear().
> 
> All the other functions had a mac_addr[] issue as well.

Ack, I'll also fix those, I should have checked before...

> 
> Btw, this kind of bug is a good candidate for a static checker warning.
> I can create a Smatch check for this.  It would probably be easier in
> Coccinelle even, but I'm the Smatch maintainer.


Would be nice!

> 
> regards,
> dan carpenter
> 
> 
>> -	char serial[EFUSE_SN_SIZE];
>> -	char usid[EFUSE_USID_SIZE];
>> +	char serial[EFUSE_SN_SIZE + 1];
>> +	char usid[EFUSE_USID_SIZE + 1];
>>   	ssize_t len;
>>   	unsigned int adcval;
>>   	int ret;
>> @@ -46,6 +46,7 @@ int misc_init_r(void)
>>   	if (!env_get("serial")) {
>>   		len = meson_sm_read_efuse(EFUSE_SN_OFFSET, serial,
>>   					  EFUSE_SN_SIZE);
>> +		serial[len] = '\0';
>>   		if (len == EFUSE_SN_SIZE)
>>   			env_set("serial", serial);
> 

Thanks,
Neil
