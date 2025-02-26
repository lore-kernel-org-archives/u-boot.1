Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFD1C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 13:07:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B1ED807EE;
	Wed, 26 Feb 2025 14:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mkfmxta4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9D4B80F3F; Wed, 26 Feb 2025 14:07:33 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C22B805C3
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 14:07:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38f286b5281so3470769f8f.1
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 05:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740575251; x=1741180051; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=FKU17S33WohvHjyc5F4kf6gblGCJoPc8Ne8pgae56mE=;
 b=mkfmxta4iGo1DYx72kCqYKzRhIqkEGuNGaNDbHAXNcwlbYPrweqLHNmNUhTsZtlMnf
 mvkID8PgWqs9qzhioO0IrXtfgKDTnB+k81Wa5AZkb4dSSzXHgTFAbOzBpJN45dXyuoP+
 UszmiDQ/26sFow5mrI9GBClpXhorvK82tRiP/nP+mCmymtn7l33U7lekXttJkgr0MAzE
 BCzRJXtahCbxO9jx8rx8h/JWozeyw1Oi0UBA7Mksxq91+gSbZRXz1abFBw9kpi1FC05R
 GN4widuJGocJdxHdr2tI/U5I/UVp+PMDX6Rm6nV5la4MPjEfaPKC3+oMDVwrdRmDyRRE
 LFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740575251; x=1741180051;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FKU17S33WohvHjyc5F4kf6gblGCJoPc8Ne8pgae56mE=;
 b=Gz2yXSF+IXpqVjvRlbKwD81bKEgoVZXOhIuCXNVB5pJbvwngrDJZ7Etl6kPWns975W
 2pNuIJPeTDGAtJV/kHfjz+EVttxH4U/yF6G4leHEthErJ8qsH871QYkJE3RgNFNiY/Bl
 XHBhl1x5CU8EK2RPO2ZRWCxYHlvnFcgI6xyZ29SnN3wHPb3RlS5yfV8znyjwrtaVAQ+x
 IrXenTQvb55SXWPbnKYFmxIhQDte3JlXn5wz8pkKrG8bHAFJqjmx+Df0cY60UitdnDGR
 qdZcJq4bvYgWxNAhOrBakxocERg5KUQx3VYTI+QVB4YF1Fk5+ihT/PtNSifJYLKY/Y4Y
 yG4g==
X-Gm-Message-State: AOJu0YxY6Wkm5f1gInavfKnwp5p5r97ZroSs99O7aKuzDeV/43qXTg+M
 fEorO6L1VpfBAz2QT+itQ+bFXKsqjrAO2fu75mnkqftA2Ae0ALNlFVEIs6haE18=
X-Gm-Gg: ASbGncubvUOjh6nAO+cL/kA2DaZe7E0naF8qWFSjBR2shP/X7enHaZP2Dqg7DF/Ch8r
 hLtmKCwHn6d9fTVsTgHwYiJsFfp1j9fjSx9AQMb5E08anEWFwq5aA/SmvLHtlABSWcc/Th0A/1P
 p6NmE/rcO9FZsN/r0AM86eF4YXzxBhGmCJqxH9MCkKFUiflr8jbqKfCSqADwb9VlIit/BKNsJOL
 OqCdeeslxizvt1sgog0WlAcmKKeFyyHayaLCTfUobYSwYtPe2VK4Q2Hrq4qv7cEpRILR2GvkKm5
 TnyQnqnOpLaC8JxbFd4VdHkyj6iP+hsSNgVyoQZw+JpYWdDIygpaf4rI4+B80pteTsFGRK3OHfb
 fAL0=
X-Google-Smtp-Source: AGHT+IHtmbAyKDPAtnY4oc+n0YWUuLXTQlEbKOMzxXfMSqeAlIsXThCsXyC1m0H4T83Q7l1dbtho+w==
X-Received: by 2002:a05:6000:1a8a:b0:38d:dcf1:d156 with SMTP id
 ffacd0b85a97d-38f7079f6f3mr19385461f8f.25.1740575251098; 
 Wed, 26 Feb 2025 05:07:31 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:ee49:80db:c8ef:c826?
 ([2a01:e0a:982:cbb0:ee49:80db:c8ef:c826])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390dbb16699sm1476041f8f.13.2025.02.26.05.07.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 05:07:30 -0800 (PST)
Message-ID: <9094cfe6-34ae-42cb-84c1-6965121d1a19@linaro.org>
Date: Wed, 26 Feb 2025 14:07:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/2] rng: msm: support newer SoCs
To: Robert Marko <robert.marko@sartura.hr>,
 Luka Perkov <luka.perkov@sartura.hr>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20241125-topic-sm8x50-rng-v1-0-52b72821c3e9@linaro.org>
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
In-Reply-To: <20241125-topic-sm8x50-rng-v1-0-52b72821c3e9@linaro.org>
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

On 25/11/2024 18:12, Neil Armstrong wrote:
> Add support for RNG on newer SoCs which shares the
> RNG hardware between different Execution Environments (EE).
> 
> Also enable it by default to fill KASL seed when running Linux.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Neil Armstrong (2):
>        rng: msm: add support for newer Qualcomm hwrandom IPs
>        configs: qcom_defconfig: enable RNG driver and command
> 
>   configs/qcom_defconfig |  3 +++
>   drivers/rng/msm_rng.c  | 13 ++++++++++++-
>   2 files changed, 15 insertions(+), 1 deletion(-)
> ---
> base-commit: dc1859f8d2ac3faaa5e2e1d465ec4bd8980520a5
> change-id: 20241125-topic-sm8x50-rng-714cd0012391
> 
> Best regards,

Gentle ping, who's supposed to take this ?

Neil
