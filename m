Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FCAD0D151
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 18:00:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0202683A91;
	Wed,  7 Jan 2026 19:00:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dlNONGvh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC0FA83B21; Wed,  7 Jan 2026 19:00:54 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8846A83A47
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 19:00:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47bdbc90dcaso17387715e9.1
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 10:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767808846; x=1768413646; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=qVZYGjkh6lea6zgW9nEtnDqX4akuQ96eHGywx3qNJsg=;
 b=dlNONGvhcIEYU502ddsXMiGneoPMLAIzyQIrRWNxz4G6y5IUrILKFBYPry3Oko7dZy
 jEjjEWwfqItr1pyYRxtGsTqtGZHSopvYjY+K3sgZJyQ0byuuJDuhRHNuoK1V9UHEmuq6
 ZZiIhCJQPp6yHXx1xx8He76605Sv5/oLYHKwRre6tEguCfD7owvqoAfCpRAXQ4WfmE/g
 bxow2WBCJwvR03NWCAhYyCQlXc9u4aN2jTDMiMbewBJaeznwQGvDlZ4TaRNZGw2pqWBQ
 10lg7ke8XK/WJLKmTN25diNq7r5xVMPLn58GKGVfBWaO8QZ/nLt0h2O5afRxlg5v8hNN
 3mnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767808846; x=1768413646;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qVZYGjkh6lea6zgW9nEtnDqX4akuQ96eHGywx3qNJsg=;
 b=rRsBquayH+fg/cQMt9MglNjjXxHtrhOBVuiLE3KeA2S0d+FbMfzN4BaaBexlAEX5AN
 khJv3sd/oh61Wuf3dC51CCzdKtmYDr4M/GlzmM2DBss8aiHmL2hz8Kz/9dXAEFYAm9Y0
 0Rdot61lqJGDbnIFYeqImdns76g8vAK/kbtRCK+ls3TyeGreD3ZnE0Of4vQHhabqH0zs
 guBRkUR6rrjKVLimqhAZ64SsH/hazGvry5i6+mw1LAdj0EuLVwKlSEjxtkpiEltJ2sAa
 b/uMKdOhcesDz+bJwiEaGVHUu68uHmuFIGZ0PKaGj8lkJI7mB6Z9wBhGZ2/0hTu00SF3
 YotQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPS04bT2m2hc0lkiO6fH3/G2tftNHGsH3r1Atr6f3MNP/NVhgXU+ul7P7fTiIdHkdif7RFMQA=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/7+AIrv3BfyeJ63kekqyoNj5X2XMsylxPKwTY+RZZkntJ+8BX
 aXx7jIFK3MDNfOUw0k5tyLU+aXo4G1MjHG55TLsE56TGKnmwCBHmcvRrCfnPTafnQ+k=
X-Gm-Gg: AY/fxX4fEXjuI3WjI++Gd3EbLEz39EmILjAYESpz5iufaw9WCimSZ6CL7kE5iAHDrkE
 BxPjrGn/LhMqiKUl3kf0UzVj76qnhORgIAArZi66ypJuPyFEotFUS4SujYKc7i3SUeUIjyftY05
 RK2mp/ldgfCiPH+3b7dUXPm5kvMHVhRIaBERCceysqx1x1eixo4xgoZcPDmWgy5GNlQwXVuOLeM
 o0pLyyi4vQcf9vMmgtmFdaC0NBPXD0AJAcT1ihh5bhL+3vZv9eBy5i8stNi4tEGApx0GaZSqzPc
 0tHJfD41BCSR7IJENr09eWZWY5Hs5eVtsX5/UqF/Eet9IhRJ0iY6Q0ZZWZyEYE9VY1lG1B7TiDg
 QWiPy2D6yJqBznjLGBrbtGr5BFTzLUOancnQ/MMpq+3pAbDN+p6d8a7gZygi4tozTdFB7bGDvx4
 Q0z58+MT90cFHB3m+dHcO8nC4HGQqm2GMhrvKuD7NY8M9FKlUpe6n3hByas+CX/JmyQhxmQJaNx
 g==
X-Google-Smtp-Source: AGHT+IENTCmm+rGvvF1z59wNeqscLs4HPnNdSMMjwm5uiJsIb4eSKWuUyr/6BeJ2KjHkH6PFE6rq7w==
X-Received: by 2002:a05:600c:8b58:b0:46e:32d4:46a1 with SMTP id
 5b1f17b1804b1-47d84b369a2mr39194265e9.22.1767808846359; 
 Wed, 07 Jan 2026 10:00:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:2542:a09c:d0d8:7a1f?
 ([2a01:e0a:3d9:2080:2542:a09c:d0d8:7a1f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d86c6ff40sm39107005e9.2.2026.01.07.10.00.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 10:00:45 -0800 (PST)
Message-ID: <9ca08b31-14d7-4d88-a9de-e27bca935801@linaro.org>
Date: Wed, 7 Jan 2026 19:00:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [FYI] ufs: rename split across commits
To: Marek Vasut <marek.vasut@mailbox.org>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <689907b7-f185-4357-8d84-f9ef23036701@socionext.com>
 <9d6469c3-aeb6-421b-b7a0-ed1bbc829fe0@mailbox.org>
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
In-Reply-To: <9d6469c3-aeb6-421b-b7a0-ed1bbc829fe0@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 1/7/26 12:45, Marek Vasut wrote:
> On 1/7/26 7:06 AM, Kunihiko Hayashi wrote:
>> Hi all,
> 
> Hello Hayashi-san,
> 
>> While reviewing ufs history on main, I noticed something that might confuse
>> future readers:
>>
>>   commit 1de63f1be48b
>>      Message says "Rename ufs.c to ufs-uclass.c", but diff only deletes ufs.c
>>   commit 067c1b033282
>>      Adds ufs-uclass.c together with .post_bind changes
>>
>> So the rename is effectively split across two commits. No functional issue,
>> just a heads-up for anyone using blame or rename detection.
>>
>> Sorry for the noise if this has already been discussed.
> 
> That is a nice find, thank you for keeping an eye on these commits.
> 
> Indeed, this seems like some sort of an application error due to file renaming.
> 
> You are right, the resulting ufs-uclass.c is what it should be.
> 
> Niel, do you know what happened ?
> 

Somehow the rename failed when I applied:

see my b4 ty at: https://lore.kernel.org/all/176167065011.4104072.12154709648586611964.b4-ty@linaro.org/
and the actual ufs-class file was added back on the next commit...

Will check twice next time to avoid this.

Thx for reporting this,
Neil
