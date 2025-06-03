Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0485C5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 16:42:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6C8082AA7;
	Tue,  3 Jun 2025 18:42:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oPi/aZNd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27B6C82AAA; Tue,  3 Jun 2025 18:42:36 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D688682A76
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 18:42:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-441d437cfaaso40543525e9.1
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 09:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748968953; x=1749573753; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=RRErAR5/zSrj4R4AkHstbTsf2/iJCIAeBQ7xXGpYcxk=;
 b=oPi/aZNdxc3Jvm8mumtCgeb2LO4jZKZIw3KompENLEW+3j5cWDenVIEj1YtL0miPwi
 B0NmBSh65hk0d2qzsT2/pQ99VqPma742DWU8rLPEqABrTD+xrjAvGI4zSxhUMpSJwwNh
 Y/k6fNl6qlc54EnAo6LEPi++ibQM0RL/LuXnr8XwEEOZyD+il0uvrQCNKVPHwjk+XHRy
 Cxv3/BKlbLPdz3hjxFtGgllse9ACHHIOjZ9TWEy+jZ919XfhKcJxs8Gkusa0KFIMsXT6
 DLrfAsqfdvhMXvK5m137gQbcA6STmhRh5tvs7X/zwrXCLv2bH6pRZ8FErWQnID9efCoB
 sGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748968953; x=1749573753;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RRErAR5/zSrj4R4AkHstbTsf2/iJCIAeBQ7xXGpYcxk=;
 b=R+c9YPp0sd25M+wtChYAZGLsnFvJsGa33H4JvPrWPu36o2vmK2zspqPrPLs2JtgpLu
 +vDpDhSDBpJPov58Ef/xAB9pM7Sc6wnzoj5y6pE4cuK2mLUffAS9Wg3WZB7RQ2VN6HPw
 lD6tAUA5xxftQOMgGVKq1yl6ymD1ovXBt3KI1brIu8rA2/6PGa8QifWO8DphUAMEoZEh
 Anp0qcY3QAkUrE/FEXSX+dtZse/lebN6IdvR9/O5MHlzEZqiovbsPD61XuWtGtS9sEq6
 8uZmmTMqW4AHoXCTWxz3ip3gZ3Y50fzEPtANs2NARC3o2gtKKdUMTwnZr7Ed5/hA0g1s
 VRMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz/LPe9NN4O3voXErOzgzVbOoMX3JwVanhvCVlYewYwsbzVNZa3UhV1J0+JL7+HLBzL/myQO4=@lists.denx.de
X-Gm-Message-State: AOJu0Ywidy0JepHPzJ0IYlo8B2obIL3HJSmJXqZxV+vQ2GjRuP/NYLf1
 ckCqkKfK188ZrT+QZcWt5cx09QGishFFIuP8bCN3tGUDUgW8WWq8+xAAOgdKumzpHaLQYmo0483
 +6pQP
X-Gm-Gg: ASbGncsFwO3ZC3BA6yL3BpTnWhBlm3Pndamp2WSfPSEZKcx5Ye0EDQ/1HtyE3A8IPz8
 rvXkgriJrv7PtJxUBNDFHFLzj0Vev3kSvExLnExfnCpA6fACpcJhRyCk9XYE0D3CyHLM3pQ0nr4
 t6VlyUxHDuzj39gQd382NM2WMdOMG/SisfC855YFuZh2tu6D1X7LAWPkZqqhEULbWJ2xC8LzWbp
 Lss+TRd1SjuJFpDSydNnNaB4w4fr3qTTnr8dWfzcd21buqYlArAmbn3WVSjAgQ1KmLtLxhLXYnX
 q2vFY7/wx31+gL+5zjDSSJErH1hccFpiAyab9tw6VQ/3qp+NuE00l72OZLsTYkG3cWSFn8QWSwP
 lYHViDKZYsvXCQfBN/vPLoAcbHA==
X-Google-Smtp-Source: AGHT+IG899CwTbJU5TaPRH42acCwhIGkTWy5QeLc1ph+V4zrJeBBCNwPVDK+QccZHroq6k9XKdIatA==
X-Received: by 2002:a05:600c:3b8b:b0:442:e9eb:1b48 with SMTP id
 5b1f17b1804b1-450d8876132mr146327415e9.24.1748968953279; 
 Tue, 03 Jun 2025 09:42:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:563:3654:17de:c930?
 ([2a01:e0a:3d9:2080:563:3654:17de:c930])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451ee4efc29sm2417235e9.12.2025.06.03.09.42.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 09:42:32 -0700 (PDT)
Message-ID: <46e481a8-7347-43d9-9aac-0f5ecc8b5e24@linaro.org>
Date: Tue, 3 Jun 2025 18:42:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] pinctrl: qcom: handle reserved ranges
To: Tom Rini <trini@konsulko.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250410-topic-sm8x50-pinctrl-reserved-ranges-v2-1-654488392b9a@linaro.org>
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
In-Reply-To: <20250410-topic-sm8x50-pinctrl-reserved-ranges-v2-1-654488392b9a@linaro.org>
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

On 10/04/2025 10:52, neil.armstrong@linaro.org wrote:
> From: Caleb Connolly <caleb.connolly@linaro.org>
> 
> Some Qualcomm boards feature reserved ranges of pins which are protected
> by firmware. Attempting to read or write any registers associated with
> these pins results the board resetting.
> 
> Add support for parsing these ranges from devicetree and ensure that the
> pinctrl and GPIO drivers don't try to interact with these pins.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Gentle ping !

Neil
