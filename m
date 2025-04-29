Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC085C3ABA5
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:05:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E707B8215E;
	Tue, 29 Apr 2025 15:05:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qxjHSe8B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C2518215F; Tue, 29 Apr 2025 15:05:03 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D52982145
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:04:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a07a7b4ac7so1783567f8f.2
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745931897; x=1746536697; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=vDgtus+CZrBUYMFhZtz7Cq7ttn36vGi8AZPqM79wsM0=;
 b=qxjHSe8BJ+tUFIhxMY6ApwKiwuvAKzm48ym+VtDUsDgMhcCxCWCyfpOPYFJuFp9jNU
 T64h8q4prs6tZuYEmC7d7VzlB8Ep0AXRQzuctl2iy7ZYeFyvjltj9Wxpwvj87zU2Nhs/
 9SKKvvAnBn2/hGC/cd3mBGZK5s/CPXumF9cz3j+2r1IKvvmu1CxCYIVfSgpn0aNJfokY
 S3CyrziHPoxPx/skFGj9IHoOmsV/G+7O0hv6M1eGDQVfGiFzLdqIQyCUOoks0MKNosCG
 BPi+UDgtDEgQSWxCgz3fBL3ZRMrwL4DEOBtPhzqqRQkBrdLA0MVdy0UyIKqtlRYEhSeP
 vkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745931897; x=1746536697;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=vDgtus+CZrBUYMFhZtz7Cq7ttn36vGi8AZPqM79wsM0=;
 b=b/FK7OlY+fx8fLKqz/2gHFA/fnVH4RXcyFZyhTsmbcn0qA089pdP5ZrzDTwokfqE1z
 atorQsJFszMB3xZCR3ZxMyhgQNVVOAdFexU28usaRef7PXHaZ7HoA87LuQxxTB2Fp6xu
 EGMDUGKwjBOdYce6HEBiRP7ArqoKwkcj2kzaLvInMqUan59F6k9tVGUtUFTrXYYvARqS
 nnADryqSIWZU07VvsSfkO3B/1HgLb6bQPZIpDzhYZiotkitU5leVsmRnY5M6aDPUCSto
 3hOkApbFOsdFOacyZHmjFI5pQWjUdQ0G7Ppj5xLpM14JFVd4Yt6bWzn/x+jOEwn4Pkdc
 t2eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4ngLWbgoD3e3Xco+W2G4v6fepaT9nLWpGTCRfoVIvh8qj2F4Ob4pu3xgT+fu41eY/o8kQJqg=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1OEp4MugL6U6OOwZJiCUkXfU28NM429z77LELmfLF5HiLKfIQ
 iYgopLRO53fw0s547Sv1rMDo4lAF/UhtILo4rPZqhdQyvWuseik+6o7GXXPv9+M=
X-Gm-Gg: ASbGncvkKLlHuC0UMYRVAnBUz7fjpkien2E3RJe10H4LfiDXa3il4orfqD0YOFPmhhJ
 q+VifGDFQwc20tG/A4H2PQKUP9DX8y+AtDhD1ObN1tmZV3LUzcOpqBcxwMAWcdOMtgPamVeGfvh
 NMvb4TEHewM+eAQaSnjOGJmMOIoFNYgscPu1o0d8n9BuP6/xeO0ErR0xnT6Mvj5hACoO+NgGTiu
 0gnuf6SpEwKTj676XVQHqnJfYueageQX9M9kIdWcseGYrimm4S9jjCTjvKjZUACgDzfaHxi3EGv
 nQmAR3iJC3d2M1EEQkMSLITUo2V5Ftc1rbTgKSZHK/maI5pcGeDQ93TTr4MNf9KKHPyEEWloQsQ
 li0VGRzjfYjNPMIO5GQ==
X-Google-Smtp-Source: AGHT+IF2AfIH5915OiGhI2sXO1x9Tdqyn+2r6t9dYP9gNf5izoW3fm8AJEIDI3iOGNTsH13lVGQgYA==
X-Received: by 2002:a05:6000:1889:b0:39c:1257:dba9 with SMTP id
 ffacd0b85a97d-3a0894a3cd5mr3238315f8f.57.1745931896663; 
 Tue, 29 Apr 2025 06:04:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:7eea:fda1:4564:f556?
 ([2a01:e0a:3d9:2080:7eea:fda1:4564:f556])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca56d5sm14066084f8f.32.2025.04.29.06.04.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 06:04:56 -0700 (PDT)
Message-ID: <ba9cda74-b946-4e17-9f3d-88461af4555c@linaro.org>
Date: Tue, 29 Apr 2025 15:04:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH RFT v2 1/3] fastboot: blk: introduce fastboot block
 flashing support
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dmitrii Merkurev <dimorinny@google.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20250409-topic-fastboot-blk-v2-0-c676f21d414f@linaro.org>
 <20250409-topic-fastboot-blk-v2-1-c676f21d414f@linaro.org>
 <877c3cgwsf.fsf@kernel.org> <359a5f7c-4c65-4813-be8e-97e12c7786ae@linaro.org>
 <87zffzwfz9.fsf@kernel.org>
 <CAOWkq4kKyFjfeQviK+3rtEppeqNdmMg6uvHNXApN8zFQUuLU5w@mail.gmail.com>
 <87ldrj5esq.fsf@kernel.org>
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
In-Reply-To: <87ldrj5esq.fsf@kernel.org>
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

On 29/04/2025 14:32, Mattijs Korpershoek wrote:
> On mar., avril 29, 2025 at 11:45, Dmitrii Merkurev <dimorinny@google.com> wrote:
> 
>>>
>>> Dmitrii, are you okay to re-licence this code under GPL v2 (which is
>>> common licence for this project)
>>>
>>
>> Yes, I'm ok with that.
> 
> Fantastic, thanks a lot for answering so quickly!

Thanks for all the comments, I'll prepare a v3.

Thanks,
Neil
