Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0784D60D17
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 09:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D0BD89500;
	Wed, 20 Nov 2024 10:41:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Tl/7qQFG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F0D189533; Wed, 20 Nov 2024 10:41:17 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31FFB894B2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 10:41:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-382376fcc4fso1102121f8f.2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 01:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732095675; x=1732700475; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mk6D2STUIO5FHpyLWlq6gHw/81Ip8+VYuV1b0b+hLqM=;
 b=Tl/7qQFGxkauA0phsYtErz7/Ni0TOuR2x8CdTqgRpvgsVgqx9qS07hbc8VfQFAXVQX
 HW3xNemVWMsfYpZEK2OtCGMmBj18ii55fPfv1BritsCAgjR1MhdfyJfW8qL29kwtF2tG
 GUcilsUeVWtQDxUC0FNjLuaxfF+++/iFTSy4DnU0xDk4jqEI8l6mDEj1+wPgcQuLxcv9
 oZ72QBJri7IdbgIr7JCOV+bqvdpQa+vaOIkuyqZCCgC7NfwfoDLmv/g4Bxa5VsiVjcps
 hlTAt42QHOv/GIHeydR89m7BSpMsbfKI+LK7GWr3ac5T4P9BZDVUBZy34VZqP+56wKwS
 LrRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732095675; x=1732700475;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mk6D2STUIO5FHpyLWlq6gHw/81Ip8+VYuV1b0b+hLqM=;
 b=Jg/v3Gwuop0yw5pkls/Qa1kAB6zFUfl2dc/xzkMWzNuuXuDztqpg1pNJsOcHZSaBZU
 KJLh/MN/LPqRPp0DLIoS/cWJtQ+5XuAOwWASkBj4qloVPIJ3FOUF7isu7DwxgmmH2+4P
 qgnUKBooqSixaSBCnfTCJiipmD2wBRVG18QndsGNMBXjz8Weib7xYXAG+mn8Fzd7G8TU
 v8bTvy17Kl9c4//VdajU5EpnKbVcEIZQqjSyoRY7istTZ++XRCRkyPAAJnJV3YlqetCg
 jvG3kljR2ygyLnMb5cSxmYxZRQeKB7R5+BN5qvc8rYqUdPhGR8bYGskiamqDXHHl5hxM
 oUEw==
X-Gm-Message-State: AOJu0YxV+OhnSf3dWInLpw6iTHemCgF77cY8yxsZL+ZbfQjoX5RD20bA
 goIaU1qgWLjXZWRRI2VdMyhbIPxCtNvhFRZ89R2/2CmjRLs8hYE3vWfmCAXqWGdBuvJE2FzgxEP
 g9MA=
X-Google-Smtp-Source: AGHT+IE9vwvgM8nvlyx4igMu5EcxeMoMs4hi3CslPcf7Yxb0XpUTHsCm23Lec4r/38K8HsJfTy1hPA==
X-Received: by 2002:a05:6000:2a5:b0:382:4bc5:e5f0 with SMTP id
 ffacd0b85a97d-38254b21993mr1374025f8f.39.1732095674674; 
 Wed, 20 Nov 2024 01:41:14 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:edb:fc01:24e0:2f5f:4be2:4309?
 ([2a0a:ef40:edb:fc01:24e0:2f5f:4be2:4309])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-382549452a1sm1520625f8f.106.2024.11.20.01.41.14
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 01:41:14 -0800 (PST)
Message-ID: <e7bef1db-f9a1-407a-906c-8a74387f35b2@linaro.org>
Date: Wed, 20 Nov 2024 09:41:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "test: Update time tests to use unit-test asserts"
To: u-boot@lists.denx.de
References: <20241119140526.3485208-1-trini@konsulko.com>
Content-Language: en-GB
From: Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <20241119140526.3485208-1-trini@konsulko.com>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 19/11/2024 14:05, Tom Rini wrote:
> While at the base level, this conversion looks equivalent, we now see
> both of these tests failing (due to exceeding their allowed margin for
> being too slow) in Azure with a very high frequency.
> 
> This reverts commit 88db4fc5fec20429881896740df61d402b4b1f66.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>   test/lib/time.c | 31 ++++++++++++++++++++++++-------
>   1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/test/lib/time.c b/test/lib/time.c
> index b99e738c500f..2095bef75892 100644
> --- a/test/lib/time.c
> +++ b/test/lib/time.c
> @@ -22,7 +22,11 @@ static int test_get_timer(struct unit_test_state *uts)
>   			next = get_timer(0);
>   		} while (start == next);
>   
> -		ut_asserteq(start + 1, next);
> +		if (start + 1 != next) {
> +			printf("%s: iter=%d, start=%lu, next=%lu, expected a difference of 1\n",
> +			       __func__, iter, start, next);
> +			return -EINVAL;
> +		}
>   		start++;
>   	}
>   
> @@ -31,7 +35,11 @@ static int test_get_timer(struct unit_test_state *uts)
>   	 * an extra millisecond may have passed.
>   	 */
>   	diff = get_timer(base);
> -	ut_assert(diff == iter || diff == iter + 1);
> +	if (diff != iter && diff != iter + 1) {
> +		printf("%s: expected get_timer(base) to match elapsed time: diff=%lu, expected=%d\n",
> +		       __func__, diff, iter);
> +			return -EINVAL;
> +	}
>   
>   	return 0;
>   }
> @@ -49,8 +57,11 @@ static int test_timer_get_us(struct unit_test_state *uts)
>   		next = timer_get_us();
>   		if (next != prev) {
>   			delta = next - prev;
> -			ut_assert(delta >= 0);
> -			if (delta) {
> +			if (delta < 0) {
> +				printf("%s: timer_get_us() went backwards from %lu to %lu\n",
> +				       __func__, prev, next);
> +				return -EINVAL;
> +			} else if (delta != 0) {
>   				if (delta < min)
>   					min = delta;
>   				prev = next;
> @@ -59,7 +70,11 @@ static int test_timer_get_us(struct unit_test_state *uts)
>   		}
>   	}
>   
> -	ut_asserteq(1, min);
> +	if (min != 1) {
> +		printf("%s: Minimum microsecond delta should be 1 but is %lu\n",
> +		       __func__, min);
> +		return -EINVAL;
> +	}
>   
>   	return 0;
>   }
> @@ -80,7 +95,8 @@ static int test_time_comparison(struct unit_test_state *uts)
>   	error = delta_us - 1000000;
>   	printf("%s: Microsecond time for 1 second: %lu, error = %ld\n",
>   	       __func__, delta_us, error);
> -	ut_assert(abs(error) <= 1000);
> +	if (abs(error) > 1000)
> +		return -EINVAL;
>   
>   	return 0;
>   }
> @@ -99,7 +115,8 @@ static int test_udelay(struct unit_test_state *uts)
>   	error = delta - 1000;
>   	printf("%s: Delay time for 1000 udelay(1000): %lu ms, error = %ld\n",
>   	       __func__, delta, error);
> -	ut_assert(abs(error) <= 100);
> +	if (abs(error) > 100)
> +		return -EINVAL;
>   
>   	return 0;
>   }

Tested-by: Andrew Goodbody <andrew.goodbody@linaro.org>
