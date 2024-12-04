Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2CDE7716E
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 12:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23BEC8917D;
	Wed,  4 Dec 2024 13:29:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e+P52DKN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B04F38917D; Wed,  4 Dec 2024 13:29:37 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FFB888E31
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 13:29:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-432d86a3085so57019995e9.2
 for <u-boot@lists.denx.de>; Wed, 04 Dec 2024 04:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733315375; x=1733920175; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=bgSEycTJe8ZZe2YXh+I7WdbPSWJd25/r4ZhvaxFT3CA=;
 b=e+P52DKN+zQk8EX6+nPTBDVpKkbLTssEEytQ415U4zTvk4azkmmXuhMQzAseNRxAKo
 hZsXwvQcAwbzjBrGs652p7sZ404mDUIxLn+iWF6gybQ42BzkxwLLDFcQUn3JyLLlHhWR
 oxzsGq479Ls36HbbbL0ZaCQaakLxrzfZMWI4KnuhAXsFqYlwKmPzuRw+Lg0JNCCpYmLa
 UQH8ezIOptvB5dHZ6hNsi658BxYDkn+gBOkasJYikaoQumMRp9MhDYVPXfvj0X0jnuRc
 qZuf1I/c2m37Hph7aeTf2jtXl0zt0ekih17oDyEafqlSkFGfHgYoo/hNE0G2PxEmqlLZ
 XY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733315375; x=1733920175;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bgSEycTJe8ZZe2YXh+I7WdbPSWJd25/r4ZhvaxFT3CA=;
 b=HBlf1VSi7a4dmZOqvtO67z3xhp4CWmtYcW8hWiDmct4B+tSF/nPyzmeNkBkQZ/E0C9
 9nu1viYLAcdq8cULPrbrr81pc0ZHLxnsPLKmOK5ys0pCWV4oYaPYWSvbLK82PJRWz3TA
 FHPo3zp+iZWkKcfRACBuCEsphrZ6OYUPK3uDVKb67TnLRnHbgoOs1/9SuFOpEK+bdkdH
 FSTNxU9+hWltW/Zagn2f7/o9KYGpIw2JX5F/Dse8WL4GdhCInnrFvyPo+s395dzqiwHM
 aIbW45viZHtEzG/nO5+qIQGDbnyeSlw1uZvUl3dicxkgyFA01fTyZCIHhuNz4zhhsn9Q
 4LFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOe56OUWSXwgNuZkY6NO1AiUWkxAnAY6VPnphgQJtYJYkRNsRBF1IjZeuUoLo5Alj6z+scWtM=@lists.denx.de
X-Gm-Message-State: AOJu0YyR7gavi77nZ70WT2+Df7BcvE18MtfKx9RWqwf9/hyXz/ow1FSb
 TqvXuxjyctIlVxevWoH0lgtQNSOziTelXSYSPRpgcE44ZzlhoaSLS6WQUmitQxA=
X-Gm-Gg: ASbGnctdCrMVFSie5WUp//vyJldvRL81qIeukqlLuiOsXxosY1NCWk4yOVMsUfa0vMp
 tRX+EJuUAFC8sYUEZiGc6QqGjL6Ga/YBuj9QpMMp6c/iON3HQiZIY3wQ9RIa9Yep1rL1ljJwjTw
 1FqBOsqP3oOURAoHQ/JClqSGTPHe6YfrduTKhvhcdbi1wytcoPVo3INDjzd1ExdrCqwIWxnmOur
 IVRnvf1E81RAg+5+JkbhvY6cZgqGLHjlH/uGLab6rVWneNQsDaw3aPJKLDe/BWXmBoQCKgTZvmv
 LA2jibEaLtQWdo6sfS3Va018
X-Google-Smtp-Source: AGHT+IHTbke5Wr4COwzTCx8K/1Y4N4DnasjhkrkQwUL0ZO+nMWn1er8889S5rkE2Tb7UwUhCQIxK6A==
X-Received: by 2002:a5d:64c5:0:b0:385:dffb:4d70 with SMTP id
 ffacd0b85a97d-385fd435fb7mr5388417f8f.54.1733315374912; 
 Wed, 04 Dec 2024 04:29:34 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:740:b323:3531:5c75?
 ([2a01:e0a:982:cbb0:740:b323:3531:5c75])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385e1824ec4sm13761157f8f.108.2024.12.04.04.29.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 04:29:34 -0800 (PST)
Message-ID: <2015391d-5196-4860-817f-a7ef317b980c@linaro.org>
Date: Wed, 4 Dec 2024 13:29:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/6] ufs: core: initial cleanup and defines sync with
 Linux v6.12
To: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
Cc: michal.simek@amd.com, marek.vasut+renesas@mailbox.org,
 bmeng.cn@gmail.com, venkatesh.abbarapu@amd.com, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
References: <20241120-topic-ufs-cleanup-v1-0-a5cef54b1cdc@linaro.org>
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
In-Reply-To: <20241120-topic-ufs-cleanup-v1-0-a5cef54b1cdc@linaro.org>
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

Hi,

On 20/11/2024 10:22, Neil Armstrong wrote:
> This serie fixes the build and checkpatch warnings, and
> does a split of the ufs.h into a separate ufshci.h which
> helps syndhronizing the defines from Linux v6.12.
> 
> No functional changes intended, tests on hardware
> are welcome.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Neil Armstrong (6):
>        ufs: core: include missing include/ufs.h
>        ufs: core: mark unexported functions as static
>        ufs: core: cosmetic fixups
>        ufs: core: move ufshci defines in a separate header
>        ufs: core: sync unipro.h with Linux v6.12
>        ufs: core: sync ufshci.h with Linux v6.12

Gentle ping, could you have a quick look ?

Thanks,
Neil

> 
>   drivers/ufs/ufs.c    |  43 +++--
>   drivers/ufs/ufs.h    | 335 +-----------------------------------
>   drivers/ufs/ufshci.h | 469 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/ufs/unipro.h | 128 ++++++++------
>   4 files changed, 571 insertions(+), 404 deletions(-)
> ---
> base-commit: dc1859f8d2ac3faaa5e2e1d465ec4bd8980520a5
> change-id: 20241120-topic-ufs-cleanup-23671e3fc9e9
> 
> Best regards,

