Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6606C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 11:05:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBD7D86DAF;
	Tue, 28 Nov 2023 12:05:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eUYAf/1z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD94486CBD; Tue, 28 Nov 2023 12:05:30 +0100 (CET)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E7B286DAF
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 12:05:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c9b5e50c1fso5015651fa.0
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 03:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701169528; x=1701774328; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=8aUu6JPaC+OWmb/+kFcf4yzuZSDVOz2aY0ryYLFs+Pg=;
 b=eUYAf/1zksfR4hY0rZI4HXSr2KVaDooRO03AL0zhtCi0msa8cLE7Ml3CK4F6GU0YlD
 F9Y4All6/fcGdl9czqsrmXkSjYbFzTuDxjtsjRAJxQcUpe8K2rb6ALxztGvfP4AIgZQQ
 mY5DJiYXQgucpzX/ciGsJz5qccepeKg0UNnz5qxKw1OZpqYZ5iYFZCGM5oGo5YTMbc5d
 njrQCp3Ex58j/mASFwM8827C5xOV7R1SkT4gvJIWzhExLsE67iKom7tpKCcrrWx9emkZ
 eqaDnGlBRHUJLyMi5MqR0N+bGJxejVvZyBMquZ6uFvblftT1IMwI/ueOzHejqaEy7VPe
 WqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701169528; x=1701774328;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8aUu6JPaC+OWmb/+kFcf4yzuZSDVOz2aY0ryYLFs+Pg=;
 b=EovRua4EzFxRykafuKq/7sZiAmYelaQW9NcPlD6FTvotOhQHuxZ4bh80GvvnV/w/z9
 dFNLW51OrHzQXAXflwxEBEfjW0ajZdlDe4df9IBJassuIjR7FEAfYoKmiu/2CviW1bhF
 T81NtRfNSUMqmrINW6Q9rdw2lCXswKgJIQ9kBVKdSXUJZF83myZc4YHUrgb76MPVoY7O
 8BwYD3TfaKBoCOiKwVLMytyf/0wbjrjAqnbcamOXnQ60GF8q5VjEiIoMvWQrd4tNuHUZ
 nkNwRsiKfDwyd7gWnMDTBIp2wKZvscnM40TS/Bq9bBntdvWNpYRkUWeSKaCGe0L4EED8
 sbaQ==
X-Gm-Message-State: AOJu0Ywovnp0TIgKtA7Uax6pj0Z1AYTNT04mmiXEyxDGqOg0lFEIrh6S
 0WARf1r+SWei/0qbH8S4DQYwjA==
X-Google-Smtp-Source: AGHT+IHpTYD0aQTWehLu9IqKfqm8LTKrXeEO5bEHtEjQ+UCa2nEcstIfXTtBhfSlwc1Rqs8HR4Q50g==
X-Received: by 2002:a2e:9557:0:b0:2c9:b623:ddf1 with SMTP id
 t23-20020a2e9557000000b002c9b623ddf1mr771777ljh.51.1701169527780; 
 Tue, 28 Nov 2023 03:05:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe?
 ([2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe])
 by smtp.gmail.com with ESMTPSA id
 e15-20020a05600c4e4f00b0040b40e3f877sm10533979wmq.6.2023.11.28.03.05.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 03:05:27 -0800 (PST)
Message-ID: <c8964e5d-b639-4585-9870-0832560b8999@linaro.org>
Date: Tue, 28 Nov 2023 12:05:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATHv11 15/43] test_efi_loader.py: use $filesize var
Content-Language: en-US, fr
To: Tom Rini <trini@konsulko.com>, Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 goldsimon@gmx.de
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-16-maxim.uvarov@linaro.org>
 <20231127181842.GN2513409@bill-the-cat>
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
In-Reply-To: <20231127181842.GN2513409@bill-the-cat>
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

On 27/11/2023 19:18, Tom Rini wrote:
> On Mon, Nov 27, 2023 at 06:56:58PM +0600, Maxim Uvarov wrote:
> 
>> bootefi code relays in internal variable then to filesize environment.
>> lwip tftp do not update this variable. For not I update test to provide
>> correct size.
>>
>> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> 
> This is a lwip problem then, loading a "file" should update filesize and
> there's use cases, not just tests, which rely on this behavior.
> 

filesize is updated in tftp_close, but what's missing is a call to efi_set_bootdev
when tftp transfer is finished:

https://elixir.bootlin.com/u-boot/latest/source/net/tftp.c#L305 :
	if (IS_ENABLED(CONFIG_CMD_BOOTEFI)) {
		if (!tftp_put_active)
			efi_set_bootdev("Net", "", tftp_filename,
					map_sysmem(tftp_load_addr, 0),
					net_boot_file_size);

Neil
