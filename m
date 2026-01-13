Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE1D4D29DF3
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 09:35:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D95E8352B;
	Tue, 13 Jan 2026 10:35:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PfN0uV+m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CC64835FD; Tue, 13 Jan 2026 10:35:49 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D8F3803F5
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 10:35:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so80221585e9.2
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 01:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768296947; x=1768901747; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=e8WWLX/SULFtiUvfe6J1exf+VT/jxEieTR3bSgISev4=;
 b=PfN0uV+m1C9TKdWuW/Kdo4MBUTbB4ldiGGtbJge9wvd7f6qtk3+c716wOoheSTXoCf
 qrXOXKEbIcnFgwrgDBj/W56bPNmgQFjE23yUFb2STiom3vZTlOZAE9yIUXOToPrXdH86
 SI+Ca953+xSrpsvnKjuRhn71NBNh6zR355U3+WhA15HnjDvufsVflj9jFF/Z4Gl1gHzl
 GmMqIhHc5l49suGb+YqUFW1R9QoN5EIC5l4GfNsIPcp2P4cEKDcI2A+SALoGNGwLvqYx
 uaZ6cCbMYEaHqzk+IEPl8kgTqlp815BFkzQjRGAhZJS0Z0R61WgZJTg0dli/hn1vCMlG
 PwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768296947; x=1768901747;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e8WWLX/SULFtiUvfe6J1exf+VT/jxEieTR3bSgISev4=;
 b=mIxYdNfzWzYWgPQ0BUiUq/lGLdI5ETk7NCaQqtaprQgRDyfG4/8K/hy/hNIoGCJJC1
 3VmQCGyV7TLRh3CBiI03IT3y7ADa/hQoitasHEwBtv5iidtV1UrsD6aSxMWvdUDbSEpt
 Gfx+EJmFDkInIO8hcrcOGI2vu7WvWqBiAwR9hSQ04Y4O4+r9j3LkfNdvdsWt1CPGQLOT
 ZSxlfKMiB0RdpkxNVObijBOcxc8f6mqqT2ohtEO9eTmxhNaBbxogaRN9EdkH4LYcUXgG
 lQCl7IVp1NAkaxKajmJWFiHTq9BPXYYTDKB+zS2sRVCWBwPWuOVW2GqoQpm2KO0ZLapX
 B88g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH9T5GLQSzxx3nLEc+F8JM5cJmBX6KcHF1SndO9cxQzq9psgv3XVPAY5pgSs4kA68Ce9u4iEE=@lists.denx.de
X-Gm-Message-State: AOJu0YwZLait6pVDfc6bdSnYCS2D5bzW4/ttcHAhSouU3jg9SpUMa/bx
 M6i8SQmFADHH6potb0z3Wgcs9UPAzJyf/D6pp7PbZyyiof8wOqDFqkkOBUB+qqNcx7o=
X-Gm-Gg: AY/fxX4M59vv0ngGetQWTQDW9T9TLC3nUUwdbAhYb22/cIl5/L9JD+66X5j5uP5idui
 TrjQAbGHL2yWLsK/LvOJcOMbWmTNEkF7ftH6lwOHkD2h7Fiw3kkG8C148YvHM1yiAL8JnSSQRXx
 fY73iqVzW9R2ay+pF9xEKsFOz/Vcw10deptUXr7uy8MsAdDNDWYjQQf4YlFUf5Egdur2Lc4nWfh
 PRnnwysFM2r+S7RMXfiUzUVF2sUEft/hZt4sIoL6FzdDU8+3wx27n6irwBsYkVayxMJTTpvdTOj
 K2BAyq7nHunUfZMsa+0pdYPuLj83K0Ll5xjk5uOMG+EI2nYcPI0tBHqof/erxmaaRmXKM6OW/gL
 eMeman+gLC1x+3t1YJnYG1SI6n5OGXM3tcdlwznqRCTx5xDzi2LeTx0uXMyDZMaN+eIfpQD/569
 ixvBX4+m18nFXEENygHcMM5pdurBp7+UkFdRbSQmU=
X-Google-Smtp-Source: AGHT+IHT2qu/QuQFklET8hgS7j9SN4DWXSJA4FByCVxVre+GC19uBeVnr1t+pfsgGeTZXWZ8Bd7zTw==
X-Received: by 2002:a05:600c:1392:b0:46e:4a30:2b0f with SMTP id
 5b1f17b1804b1-47d84b3863fmr237056135e9.29.1768296946610; 
 Tue, 13 Jan 2026 01:35:46 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080::fa42:7768?
 ([2a01:e0a:3d9:2080::fa42:7768]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f68f69dsm393683665e9.1.2026.01.13.01.35.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 01:35:46 -0800 (PST)
Message-ID: <65071031-daea-4913-aa0f-5c072aaf362d@linaro.org>
Date: Tue, 13 Jan 2026 10:35:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] power: regulator: common: remove unnecessary debug
 trace
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Tanmay Kathpalia
 <tanmay.kathpalia@altera.com>, Ye Li <ye.li@nxp.com>,
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 David Lechner <dlechner@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
References: <20260108-power-regulator-fix-compilation-v2-0-b00cb3268059@baylibre.com>
 <20260108-power-regulator-fix-compilation-v2-1-b00cb3268059@baylibre.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20260108-power-regulator-fix-compilation-v2-1-b00cb3268059@baylibre.com>
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

On 1/8/26 15:42, Julien Stephan wrote:
> Drop the ftrace like debug() that checkpatch --strict complains about:
> 
>    WARNING: Unnecessary ftrace-like logging - prefer using ftrace
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>   drivers/power/regulator/regulator_common.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/power/regulator/regulator_common.c b/drivers/power/regulator/regulator_common.c
> index 685d8735fa5c9a6f98cb6154cd13afcabaeab1ac..ce3d80670de045dde7e263c5301bccd744abd2f5 100644
> --- a/drivers/power/regulator/regulator_common.c
> +++ b/drivers/power/regulator/regulator_common.c
> @@ -98,7 +98,6 @@ int regulator_common_set_enable(const struct udevice *dev,
>   
>   	if (enable && plat->startup_delay_us)
>   		udelay(plat->startup_delay_us);
> -	debug("%s: done\n", __func__);
>   
>   	if (!enable && plat->off_on_delay_us)
>   		udelay(plat->off_on_delay_us);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
