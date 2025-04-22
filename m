Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB051C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 12:19:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AED0281273;
	Tue, 22 Apr 2025 14:19:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RY+45zpf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B09D18144A; Tue, 22 Apr 2025 14:19:55 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAC75807AE
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 14:19:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-39ee5a5bb66so3527821f8f.3
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 05:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745324393; x=1745929193; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=2PWihE29HBgSdqraF0MPNcvlthj4A8+ckcsHyc1Yt4o=;
 b=RY+45zpfDzeFejJ21bCzP4UVNXYarTHeZ7j+mUFGskzj7B1k0qwtfYn8FrTmKpnKBD
 bDy3R7W1jXI4mhfCk9i6wcg8yvBTF1oS7rAcwtVYmRQ4X0mcn5h2n1o9qttJ7Zn+o92M
 O/Dx1dLEI8EK9KliNldRBXmzjlTtxs7CeZJRjSavmzeP0DAMerWxHx62ovKpR+6xjoM8
 EgHifCFxUmNF0vIHdGN5OMoETEGzmZPxVjjqotblWS2Vb1I4jfrTmWedwXp0tRklTk0S
 eEvUhey5iN1tDz4WhOlnN5fj5+rFmPspIaFBYyV81xTRyfwAV+nJbDqdEOYnZJstSUmJ
 2aXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745324393; x=1745929193;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=2PWihE29HBgSdqraF0MPNcvlthj4A8+ckcsHyc1Yt4o=;
 b=bjfNVIXv1d2i1HV/4QQ62hwq0IFhENkjE7j9KZfOGHChnPdTqwZwVSR/tjQOzyNP5Z
 y27bHJADmdz4HeO3UWcucEWIHYMDTNl4grR7EUF5li3weauhqLBw2Pn8YCTxPkTCWVEu
 AmcyCj3yH9ExW7M3LOaw5F5Qpr4PkLom2A/pBFcvofrEYqn+z9WpLa+QhTL+1nsyAqp7
 tR/+y9oKhtYSAR3kmJsx6G0AlhYf38ZwkeekznW/wFYiQmfKRtjtmL8yRYn4Jlx+MVcB
 di6F4UpX/lm28dLIEVbU3gKnni+jor7PkspHJHQ+1G6tg7mO/huve/hhc3bUTaMiGVAm
 ErAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcSF+jv/9zKunubOe7ZRFJ+F081sx/nJKr96kIB46/+0Gkm35ioBEyyrGjyfw101D2Fi9YZiQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwPmWyw5LnsjfwkwJ8b3mqegWh+/4qg9YaiIYqm+WTafT1PCFzb
 NDoaXMUExgbYu5jTqLI5cGHz7Tax8yJ6VbSye6gE9r6dX9U7tcvynU9SXct736E=
X-Gm-Gg: ASbGncvLhclLcR8O2DUpPrHe3iCwjLJiBUQ9fq8Gs8fOim1m9zgTVBt++bf14LFfIba
 Sr4GVt5iyc12ZVvFsoK2nzqkJkSUyv3w9OubHyJkEe7WzlYNBQj/CEidFNJt0rsZ25qVksreyuR
 VRbk+yLzQqJZfKMB1zMymP2i8jwAaiN3JNXJ1fUOz7AHqEFABr8mvy6aOABSERmbl7jYkcSKYxO
 Jn3nmuXQUvAbfNS5XPgWHWCXJWgJlPTBdlb+Jt4lz35SUXuxMn3VcmD4VsH4GJTY7XK1MshKqBC
 hxkHUgkfKjrGfUo1vYxLxZLBtEpq/lYDIZwWrG5qDLgeXPUAcmBTmy1JIFEIbl0syrwfHySiLHM
 dKwhjrC9Syba97Hfpw81FualccqII
X-Google-Smtp-Source: AGHT+IGY17L4djp7m0sCKEbDjRDnc80QI06Y9ziFOAYQXy2fTqD/5LqSwipwSZ2MnvRk60hFZq0lCw==
X-Received: by 2002:a05:6000:1869:b0:391:952:c728 with SMTP id
 ffacd0b85a97d-39efba26158mr10249319f8f.4.1745324393059; 
 Tue, 22 Apr 2025 05:19:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:b137:7670:8eb9:746f?
 ([2a01:e0a:3d9:2080:b137:7670:8eb9:746f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4207basm14877774f8f.5.2025.04.22.05.19.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 05:19:52 -0700 (PDT)
Message-ID: <85c92d67-2a95-463c-a6a8-fc943ea7dbf9@linaro.org>
Date: Tue, 22 Apr 2025 14:19:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/6] clk: qcom: apq8016: Clock fixes for U-Boot v2025.07
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sam Day <me@samcday.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250422-apq8016-clock-fixes2-v1-0-bfc9dd933da6@linaro.org>
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
In-Reply-To: <20250422-apq8016-clock-fixes2-v1-0-bfc9dd933da6@linaro.org>
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

On 22/04/2025 12:54, Stephan Gerhold wrote:
> Fix some issues in the clock-apq8016 driver that I noticed while testing
> U-Boot v2025.07-rc on the DragonBoard 410c. Make it possible to poll the
> clock status with GATE_CLK() to avoid potential race conditions.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
> Stephan Gerhold (6):
>        clk: qcom: apq8016: Fix SDCC clock addresses
>        clk: qcom: Move qcom_gate_clk_en() to C file
>        clk: qcom: Use setbits_le32() for qcom_gate_clk_en()
>        clk: qcom: Allow polling for clock status in qcom_gate_clk_en()
>        clk: qcom: apq8016: Convert GATE_CLK() to BRANCH_CLK()
>        clk: qcom: apq8016: Fix SDCC clock warnings
> 
>   drivers/clk/qcom/clock-apq8016.c | 17 ++++++++---------
>   drivers/clk/qcom/clock-qcom.c    | 27 +++++++++++++++++++++++++++
>   drivers/clk/qcom/clock-qcom.h    | 22 ++++++----------------
>   3 files changed, 41 insertions(+), 25 deletions(-)
> ---
> base-commit: cde0050618968aae335dfbc930641656d51ff5d0
> change-id: 20250419-apq8016-clock-fixes2-66ace5b26ab4
> 
> Best regards,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
