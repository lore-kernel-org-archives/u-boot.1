Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DD3C79F9D
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 15:20:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E64783DEA;
	Mon,  5 Jan 2026 16:19:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s9CStQ5j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2082F83E52; Mon,  5 Jan 2026 16:19:48 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEE5283D6C
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 16:19:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-47d59da3d81so9199855e9.0
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 07:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767626380; x=1768231180; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=nX0EWyQ+A6x/yZTVw+P+P4ZrkLKIb/fbzTcdM+adGnM=;
 b=s9CStQ5j+aEZW69c5DYuuh+KlbbohcrM1p6nhUveqdJ+LcV6fWehZW/BCp1duyCfAJ
 rxhy1GEE6UbybqBRxeu6LeO8vkT7DYyVeQZD9mSYn4DTlDEC5guOh/eZmE3XJj7unWtA
 pDAtocmj9CACeUI9MLgpRJiE9X3+R0mjmm2kNCsHdia2Ygf6cTQEKprTFgdc3Tzw/4wl
 huEyIJ/rn8hlFLWjb5SL/BZvk+F/oqn3AfuTS08Qqxk7lTxnA/6nOxdAxbel5yp/ElwU
 BVnZGTnBv1udRbHuO2NNKeTVLJJTA9CCwjLXgK3q/YaXB3ug0ZfwrxikmE4d1JLdi4Dd
 Fpxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767626380; x=1768231180;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nX0EWyQ+A6x/yZTVw+P+P4ZrkLKIb/fbzTcdM+adGnM=;
 b=rufAV1yUO4v0N+scBI8hOjK4F3FLRAkopbrYc78AUuY1HBfb0fhVbBUnyfQYDiu6wm
 bNnyRmInnkqms8cUZOARf+l1XI8Xxzl0VHF2/N5ub6E0nA232+KyAPYRnSZH4/H2LDH2
 Yr7UU6Z2eZa7f+440Pvg7blu9LuMY1NaX5bVFEVFxD1NOmUx1Nm1Nad6e8ib1FiLkLm8
 wPG/Fgika+ZsLT1Ta30q6/lDvQt5RYR1ZWkN59pp+fztAkHKBEApA/vebAJdST4lFL7I
 LvxXXj9d9D2q4yvGf0br+DEtjs/AqZDxirSHEEfCSKXLth8mKLGEGiizBo8DPzVRhNpz
 FAtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVo43GlopOh5JKVv9mH1d/rMIySFxw5eKRI22poFbiDgLo2hAHFoDWrhiGpGq/hNAGVy23jftA=@lists.denx.de
X-Gm-Message-State: AOJu0YyP/kd8KT16x5kCVThwzDq0ceLuNqI4zn+quCwFjG7W6aIqN178
 fsb6QI5UBvylk0gf8oPEXm1b1CRIBSRhBauTxosbUY3gPIRzu4tDOfgYWswjRSgSqWI=
X-Gm-Gg: AY/fxX7scDQqzpyJ8lgAEYFmmqCBJRUPdVIJmX84QUtdadqV6R7aem1L6s/7ANFUb1M
 +QtSKF4OADc58QcvrcexfZZ+btHaSv/nOQcG9Wn4Z8cyX6AJkDdDpoCR5kLuBOAU49IJVnSQNB4
 ++ahk/E3yfrMF73QshHY2p/CoYG/IIJ9JC4iO5QziHZhLcHgYqsdofK3AuJ4rSrgXd2kJt+pNOq
 j9gLD9SeaIzQFuJhoTsWimbYt20expDXaaNiJmgbS6OTySk3UzKwQD3bmRN44MtPKSHtuJbSaxq
 W3dJTwXiYnssE1xx5MpCm1n/aaxpxaVOmLze/rQwaaH15muw157Csx8yLpo/klUFHXJflvN2xhj
 JZDjXB4XVoOUZgXXjLrAOxIMsuGc4YAUGGG/MbJc+ObUczz49QMcmRfbe/izIWzj0R6U+8QJKhC
 y3eRFP+yqdLun6MAxZfCng7VxC992HFzazk5Tykhmw8TO3hSnwOLmQ71LZFqpD9wLwVSKz3AWva
 g==
X-Google-Smtp-Source: AGHT+IEF66SM66R//MqAEsNzW6CawHymIr1cVoqmwHwm3mkEvaCqoM3srkzqu02FwbY4UiD4GbhgIg==
X-Received: by 2002:a05:600c:198a:b0:477:9fa0:7495 with SMTP id
 5b1f17b1804b1-47d6c803ca7mr82700715e9.14.1767626379983; 
 Mon, 05 Jan 2026 07:19:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:d4c1:5589:eadb:1033?
 ([2a01:e0a:3d9:2080:d4c1:5589:eadb:1033])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6d452a3bsm155286895e9.11.2026.01.05.07.19.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 07:19:39 -0800 (PST)
Message-ID: <8657a6f2-3935-45c4-99fb-ff0b1c05c23a@linaro.org>
Date: Mon, 5 Jan 2026 16:19:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/5] scsi: ufs: renesas: Add register read to remove
 save/set/restore
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
References: <20260103002254.183357-1-marek.vasut+renesas@mailbox.org>
 <20260103002254.183357-2-marek.vasut+renesas@mailbox.org>
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
In-Reply-To: <20260103002254.183357-2-marek.vasut+renesas@mailbox.org>
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

On 1/3/26 01:22, Marek Vasut wrote:
> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> Add support for returning read register values from
> ufs_renesas_reg_control(), so ufs_renesas_set_phy() can use the existing
> ufs_renesas_write_phy() helper.  Remove the now unused code to save to,
> set, and restore from a static array inside ufs_renesas_reg_control().
> 
> Ported from Linux kernel commit
> 5129aa627599 ("scsi: ufs: renesas: Add register read to remove save/set/restore")
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link: https://lore.kernel.org/r/9fa240a9dc0308d6675138f8434eccb77f051650.1741179611.git.geert+renesas@glider.be
> Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: u-boot@lists.denx.de
> ---
>   drivers/ufs/ufs-renesas.c | 99 +++++++++------------------------------
>   1 file changed, 23 insertions(+), 76 deletions(-)
> 
> diff --git a/drivers/ufs/ufs-renesas.c b/drivers/ufs/ufs-renesas.c
> index b89205d0f11..8c9a9ec7695 100644
> --- a/drivers/ufs/ufs-renesas.c
> +++ b/drivers/ufs/ufs-renesas.c
> @@ -23,18 +23,9 @@ struct ufs_renesas_priv {
>   	bool initialized;	/* The hardware needs initialization once */
>   };
>   
> -enum {
> -	SET_PHY_INDEX_LO = 0,
> -	SET_PHY_INDEX_HI,
> -	TIMER_INDEX,
> -	MAX_INDEX
> -};
> -
>   enum ufs_renesas_init_param_mode {
> -	MODE_RESTORE,
> -	MODE_SET,
> -	MODE_SAVE,
>   	MODE_POLL,
> +	MODE_READ,
>   	MODE_WAIT,
>   	MODE_WRITE,
>   };
> @@ -45,32 +36,19 @@ struct ufs_renesas_init_param {
>   	union {
>   		u32 expected;
>   		u32 delay_us;
> -		u32 set;
>   		u32 val;
>   	} u;
>   	u32 mask;
>   	u32 index;
>   };
>   
> -static void ufs_renesas_reg_control(struct ufs_hba *hba,
> -				    const struct ufs_renesas_init_param *p)
> +static u32 ufs_renesas_reg_control(struct ufs_hba *hba,
> +				   const struct ufs_renesas_init_param *p)
>   {
> -	static u32 save[MAX_INDEX];
> +	u32 val = 0;
>   	int ret;
> -	u32 val;
> -
> -	WARN_ON(p->index >= MAX_INDEX);
>   
>   	switch (p->mode) {
> -	case MODE_RESTORE:
> -		ufshcd_writel(hba, save[p->index], p->reg);
> -		break;
> -	case MODE_SET:
> -		save[p->index] |= p->u.set;
> -		break;
> -	case MODE_SAVE:
> -		save[p->index] = ufshcd_readl(hba, p->reg) & p->mask;
> -		break;
>   	case MODE_POLL:
>   		ret = readl_poll_timeout(hba->mmio_base + p->reg, val,
>   					 (val & p->mask) == p->u.expected,
> @@ -79,6 +57,9 @@ static void ufs_renesas_reg_control(struct ufs_hba *hba,
>   			dev_err(hba->dev, "%s: poll failed %d (%08x, %08x, %08x)\n",
>   				__func__, ret, val, p->mask, p->u.expected);
>   		break;
> +	case MODE_READ:
> +		val = ufshcd_readl(hba, p->reg);
> +		break;
>   	case MODE_WAIT:
>   		if (p->u.delay_us > 1000)
>   			mdelay(DIV_ROUND_UP(p->u.delay_us, 1000));
> @@ -91,6 +72,8 @@ static void ufs_renesas_reg_control(struct ufs_hba *hba,
>   	default:
>   		break;
>   	}
> +
> +	return val;
>   }
>   
>   static void ufs_renesas_poll(struct ufs_hba *hba, u32 reg, u32 expected, u32 mask)
> @@ -105,38 +88,14 @@ static void ufs_renesas_poll(struct ufs_hba *hba, u32 reg, u32 expected, u32 mas
>   	ufs_renesas_reg_control(hba, &param);
>   }
>   
> -static void ufs_renesas_restore(struct ufs_hba *hba, u32 reg, u32 index)
> -{
> -	struct ufs_renesas_init_param param = {
> -		.mode = MODE_RESTORE,
> -		.reg = reg,
> -		.index = index,
> -	};
> -
> -	ufs_renesas_reg_control(hba, &param);
> -}
> -
> -static void ufs_renesas_save(struct ufs_hba *hba, u32 reg, u32 mask, u32 index)
> +static u32 ufs_renesas_read(struct ufs_hba *hba, u32 reg)
>   {
>   	struct ufs_renesas_init_param param = {
> -		.mode = MODE_SAVE,
> +		.mode = MODE_READ,
>   		.reg = reg,
> -		.mask = mask,
> -		.index = index,
> -	};
> -
> -	ufs_renesas_reg_control(hba, &param);
> -}
> -
> -static void ufs_renesas_set(struct ufs_hba *hba, u32 index, u32 set)
> -{
> -	struct ufs_renesas_init_param param = {
> -		.mode = MODE_SAVE,
> -		.index = index,
> -		.u.set = set,
>   	};
>   
> -	ufs_renesas_reg_control(hba, &param);
> +	return ufs_renesas_reg_control(hba, &param);
>   }
>   
>   static void ufs_renesas_wait(struct ufs_hba *hba, u32 delay_us)
> @@ -175,15 +134,6 @@ static void ufs_renesas_write_800_80c_poll(struct ufs_hba *hba, u32 addr,
>   	ufs_renesas_poll(hba, 0xd4, BIT(8), BIT(8));
>   }
>   
> -static void ufs_renesas_restore_800_80c_poll(struct ufs_hba *hba, u32 index)
> -{
> -	ufs_renesas_write_d0_d4(hba, 0x0000080c, 0x00000100);
> -	ufs_renesas_write(hba, 0xd0, 0x00000800);
> -	ufs_renesas_restore(hba, 0xd4, index);
> -	ufs_renesas_write(hba, 0xd0, 0x0000080c);
> -	ufs_renesas_poll(hba, 0xd4, BIT(8), BIT(8));
> -}
> -
>   static void ufs_renesas_write_804_80c_poll(struct ufs_hba *hba, u32 addr, u32 data_804)
>   {
>   	ufs_renesas_write_d0_d4(hba, 0x0000080c, 0x00000100);
> @@ -214,6 +164,8 @@ static void ufs_renesas_write_phy(struct ufs_hba *hba, u32 addr16, u32 data16)
>   
>   static void ufs_renesas_set_phy(struct ufs_hba *hba, u32 addr16, u32 data16)
>   {
> +	u32 low, high;
> +
>   	ufs_renesas_write(hba, 0xf0, 1);
>   	ufs_renesas_write_800_80c_poll(hba, 0x16, addr16 & 0xff);
>   	ufs_renesas_write_800_80c_poll(hba, 0x17, (addr16 >> 8) & 0xff);
> @@ -221,22 +173,15 @@ static void ufs_renesas_set_phy(struct ufs_hba *hba, u32 addr16, u32 data16)
>   	ufs_renesas_write_828_82c_poll(hba, 0x0f000000);
>   	ufs_renesas_write_804_80c_poll(hba, 0x1a, 0);
>   	ufs_renesas_write(hba, 0xd0, 0x00000808);
> -	ufs_renesas_save(hba, 0xd4, 0xff, SET_PHY_INDEX_LO);
> +	low = ufs_renesas_read(hba, 0xd4) & 0xff;
>   	ufs_renesas_write_804_80c_poll(hba, 0x1b, 0);
>   	ufs_renesas_write(hba, 0xd0, 0x00000808);
> -	ufs_renesas_save(hba, 0xd4, 0xff, SET_PHY_INDEX_HI);
> -	ufs_renesas_write_828_82c_poll(hba, 0x0f000000);
> -	ufs_renesas_write(hba, 0xf0, 0);
> -	ufs_renesas_write(hba, 0xf0, 1);
> -	ufs_renesas_write_800_80c_poll(hba, 0x16, addr16 & 0xff);
> -	ufs_renesas_write_800_80c_poll(hba, 0x17, (addr16 >> 8) & 0xff);
> -	ufs_renesas_set(hba, SET_PHY_INDEX_LO, ((data16 & 0xff) << 16) | BIT(8) | 0x18);
> -	ufs_renesas_restore_800_80c_poll(hba, SET_PHY_INDEX_LO);
> -	ufs_renesas_set(hba, SET_PHY_INDEX_HI, (((data16 >> 8) & 0xff) << 16) | BIT(8) | 0x19);
> -	ufs_renesas_restore_800_80c_poll(hba, SET_PHY_INDEX_HI);
> -	ufs_renesas_write_800_80c_poll(hba, 0x1c, 0x01);
> +	high = ufs_renesas_read(hba, 0xd4) & 0xff;
>   	ufs_renesas_write_828_82c_poll(hba, 0x0f000000);
>   	ufs_renesas_write(hba, 0xf0, 0);
> +
> +	data16 |= (high << 8) | low;
> +	ufs_renesas_write_phy(hba, addr16, data16);
>   }
>   
>   static void ufs_renesas_indirect_write(struct ufs_hba *hba, u32 gpio, u32 addr,
> @@ -260,6 +205,8 @@ static void ufs_renesas_indirect_poll(struct ufs_hba *hba, u32 gpio, u32 addr,
>   
>   static void ufs_renesas_pre_init(struct ufs_hba *hba)
>   {
> +	u32 timer_val;
> +
>   	/* This setting is for SERIES B */
>   	ufs_renesas_write(hba, 0xc0, 0x49425308);
>   	ufs_renesas_write_d0_d4(hba, 0x00000104, 0x00000002);
> @@ -286,7 +233,7 @@ static void ufs_renesas_pre_init(struct ufs_hba *hba)
>   	ufs_renesas_poll(hba, 0xd4, BIT(8) | BIT(6) | BIT(0), BIT(8) | BIT(6) | BIT(0));
>   
>   	ufs_renesas_write(hba, 0xd0, 0x00000d00);
> -	ufs_renesas_save(hba, 0xd4, 0x0000ffff, TIMER_INDEX);
> +	timer_val = ufs_renesas_read(hba, 0xd4) & 0x0000ffff;
>   	ufs_renesas_write(hba, 0xd4, 0x00000000);
>   	ufs_renesas_write_d0_d4(hba, 0x0000082c, 0x0f000000);
>   	ufs_renesas_write_d0_d4(hba, 0x00000828, 0x08000000);
> @@ -381,7 +328,7 @@ static void ufs_renesas_pre_init(struct ufs_hba *hba)
>   
>   	ufs_renesas_write(hba, 0xf0, 0);
>   	ufs_renesas_write(hba, 0xd0, 0x00000d00);
> -	ufs_renesas_restore(hba, 0xd4, TIMER_INDEX);
> +	ufs_renesas_write(hba, 0xd4, timer_val);
>   }
>   
>   static int ufs_renesas_hce_enable_notify(struct ufs_hba *hba,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
