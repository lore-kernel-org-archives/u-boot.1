Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D820C79F9F
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 15:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D281083E62;
	Mon,  5 Jan 2026 16:20:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ucvfVCu+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B73F83E72; Mon,  5 Jan 2026 16:20:07 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25BF383E60
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 16:20:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so151745e9.2
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 07:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767626404; x=1768231204; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=ZeHJ1VlYNC83nRCjJmB0jpag5Nv6TltVipAsNXQ+hHY=;
 b=ucvfVCu+MBu4z5ZU5ge8ihKSGx148l5sldLfmc9lOE7IA1UqKBZ/Bmh4IWiVRZDKZI
 xm9PSH0u/YoIl/1TROUhGv7LHdNrXkOYoUXQ+6+l97q1Dp9fI2w8A/8R0EtddekG8jCS
 TXacKprDu5KrIIw6S15HUOKCaHa5BrCBg+Nz6it8wzf47YoMCdD8C9b825z4zTdJt5y7
 Dt6fCR4ruOQyT3MWA4kPaSVxpI4+wVMkiCixM0HGAxkvXn+8XuJy9yn+bl254HxFNA9o
 xe/hu17NqcqPlqbuxkTlpWpyx7Ppmm9anBSALBG0CVeRqzENza+ZOfLBaPCLgVG7LqWe
 2c4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767626404; x=1768231204;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZeHJ1VlYNC83nRCjJmB0jpag5Nv6TltVipAsNXQ+hHY=;
 b=rp5R01m/kLtdWvlGSD+PNq6YQxTXx5Vic488lFeP3RFVlqTQWDWF8TJzSdQQ5cQ3jq
 IlwUBH8vJZk6aCHzsNKffx4LyQa2FZz8D1DaoBfFTvpA4J6lKGq6/EqRxlN1KwyC7K8z
 oxVHjHvoB7qHYxwRujpaa8+NYkah7Nt8MU+tYoa36By6NaZayuIoKUi7sLRS9giyuKiP
 UmEB26npgTnRBW1g/zx2/8imLthjnbxJiBXEZuY7XfXkFviQtYqv1mru+yzo+0fk6HHY
 tQXizaqhC0jaFZlTEMJ8eV/ng6RtDY0NVExFd+rmbi3cS4h9Zh3fyfoVr3nlhAzse7Ug
 nuxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIb5TUw5QhcdIJAvbaTRd7Ksecp9EeAI2yFZ9Poj0wE7V+oi1+VhHgKXr+vuqsdLXDM3vXnj8=@lists.denx.de
X-Gm-Message-State: AOJu0YyT2hdXzBrvuu19T9F6357DTFvdlNhsvaQ0IJlmpoPr78NrzWnW
 yykE6stXDMvnQcpSRma+6mHnfqirixMk18TKGAslNDfK3c0Um9yfrZ9lS24/VJSfgZA=
X-Gm-Gg: AY/fxX6WvUJmKj6NqsmbiRDqrm9noRRfLhUAwGxd5dinO0TDUQSWbt6K/xGCvPwGQ6Q
 gF91Q/N4hI8mjn96PqAGjNX0HNU8/BGVwqkDNPByV/GIqYnkHLRr9EOiSn5IiUI1d54J8j8ULF6
 exCZj0ChkpiqtF1z3g7f2S9Slwbyu0Ln/SwhiuAKkQKAoM14lYCM4motw/RcDSDZDyu0S4yL9Hv
 xXNCB1JjhyK7Aljiq94Gzr9s4QLYGtJzl6o4DOyGnbibjcE/dZOicUftWURLs0HINVIvo0HVyi3
 UH9k3+I3b7ZgxMVD/98keNqjS/tYNpufty/3xCqNnubQ+cZ9WotQLSPGg7JZ5lkB0xVuaBkjOIg
 GP/SIKlhPkQSn91j3AB9MTU5Y1l3JC+3cH/aPrftxmcGrVyZcUvV8EPbuzifXnqbzzDXwGrtQTe
 ZlD9ToxOOIUgHtYpE32gVTrhaoRpg6rvI8Gz/YH5Atv3zGYliDoe0J5IBXD5TX/I1xy4yQeOGSD
 A==
X-Google-Smtp-Source: AGHT+IEih/CSysIzdDkwKtOj7R/CeuVzfuHJfiwtCDC+Dnute8CI1gK/v3usNUFFVTSw8VdMRsnEkg==
X-Received: by 2002:a05:600c:3b2a:b0:477:b734:8c22 with SMTP id
 5b1f17b1804b1-47d1953bd29mr595079185e9.8.1767626404400; 
 Mon, 05 Jan 2026 07:20:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:d4c1:5589:eadb:1033?
 ([2a01:e0a:3d9:2080:d4c1:5589:eadb:1033])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6d148ee4sm160595045e9.7.2026.01.05.07.20.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 07:20:03 -0800 (PST)
Message-ID: <ee46cef4-0f66-46bf-a837-db5c1894ad37@linaro.org>
Date: Mon, 5 Jan 2026 16:20:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/5] scsi: ufs: renesas: Remove register control helper
 function
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
References: <20260103002254.183357-1-marek.vasut+renesas@mailbox.org>
 <20260103002254.183357-3-marek.vasut+renesas@mailbox.org>
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
In-Reply-To: <20260103002254.183357-3-marek.vasut+renesas@mailbox.org>
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
> After refactoring the code, ufs_renesas_reg_control() is no longer needed,
> because all operations are simple and can be called directly.  Remove the
> ufs_renesas_reg_control() helper function, and call udelay() directly.
> 
> Ported from Linux kernel commit
> 855bde8ce5bc ("scsi: ufs: renesas: Remove register control helper function")
> with replaced readl_poll_timeout_atomic() with readl_poll_sleep_timeout().
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link: https://lore.kernel.org/r/69500e4c18be1ca1de360f9e797e282ffef04004.1741179611.git.geert+renesas@glider.be
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
>   drivers/ufs/ufs-renesas.c | 101 ++++++--------------------------------
>   1 file changed, 14 insertions(+), 87 deletions(-)
> 
> diff --git a/drivers/ufs/ufs-renesas.c b/drivers/ufs/ufs-renesas.c
> index 8c9a9ec7695..c8fbe61901b 100644
> --- a/drivers/ufs/ufs-renesas.c
> +++ b/drivers/ufs/ufs-renesas.c
> @@ -23,100 +23,27 @@ struct ufs_renesas_priv {
>   	bool initialized;	/* The hardware needs initialization once */
>   };
>   
> -enum ufs_renesas_init_param_mode {
> -	MODE_POLL,
> -	MODE_READ,
> -	MODE_WAIT,
> -	MODE_WRITE,
> -};
> -
> -struct ufs_renesas_init_param {
> -	enum ufs_renesas_init_param_mode mode;
> -	u32 reg;
> -	union {
> -		u32 expected;
> -		u32 delay_us;
> -		u32 val;
> -	} u;
> -	u32 mask;
> -	u32 index;
> -};
> -
> -static u32 ufs_renesas_reg_control(struct ufs_hba *hba,
> -				   const struct ufs_renesas_init_param *p)
> -{
> -	u32 val = 0;
> -	int ret;
> -
> -	switch (p->mode) {
> -	case MODE_POLL:
> -		ret = readl_poll_timeout(hba->mmio_base + p->reg, val,
> -					 (val & p->mask) == p->u.expected,
> -					 10000);
> -		if (ret)
> -			dev_err(hba->dev, "%s: poll failed %d (%08x, %08x, %08x)\n",
> -				__func__, ret, val, p->mask, p->u.expected);
> -		break;
> -	case MODE_READ:
> -		val = ufshcd_readl(hba, p->reg);
> -		break;
> -	case MODE_WAIT:
> -		if (p->u.delay_us > 1000)
> -			mdelay(DIV_ROUND_UP(p->u.delay_us, 1000));
> -		else
> -			udelay(p->u.delay_us);
> -		break;
> -	case MODE_WRITE:
> -		ufshcd_writel(hba, p->u.val, p->reg);
> -		break;
> -	default:
> -		break;
> -	}
> -
> -	return val;
> -}
> -
>   static void ufs_renesas_poll(struct ufs_hba *hba, u32 reg, u32 expected, u32 mask)
>   {
> -	struct ufs_renesas_init_param param = {
> -		.mode = MODE_POLL,
> -		.reg = reg,
> -		.u.expected = expected,
> -		.mask = mask,
> -	};
> -
> -	ufs_renesas_reg_control(hba, &param);
> +	int ret;
> +	u32 val;
> +
> +	ret = readl_poll_sleep_timeout(hba->mmio_base + reg,
> +				       val, (val & mask) == expected,
> +				       10, 1000);
> +	if (ret)
> +		dev_err(hba->dev, "%s: poll failed %d (%08x, %08x, %08x)\n",
> +			__func__, ret, val, mask, expected);
>   }
>   
>   static u32 ufs_renesas_read(struct ufs_hba *hba, u32 reg)
>   {
> -	struct ufs_renesas_init_param param = {
> -		.mode = MODE_READ,
> -		.reg = reg,
> -	};
> -
> -	return ufs_renesas_reg_control(hba, &param);
> -}
> -
> -static void ufs_renesas_wait(struct ufs_hba *hba, u32 delay_us)
> -{
> -	struct ufs_renesas_init_param param = {
> -		.mode = MODE_WAIT,
> -		.u.delay_us = delay_us,
> -	};
> -
> -	ufs_renesas_reg_control(hba, &param);
> +	return ufshcd_readl(hba, reg);
>   }
>   
>   static void ufs_renesas_write(struct ufs_hba *hba, u32 reg, u32 value)
>   {
> -	struct ufs_renesas_init_param param = {
> -		.mode = MODE_WRITE,
> -		.reg = reg,
> -		.u.val = value,
> -	};
> -
> -	ufs_renesas_reg_control(hba, &param);
> +	ufshcd_writel(hba, value, reg);
>   }
>   
>   static void ufs_renesas_write_d0_d4(struct ufs_hba *hba, u32 data_d0, u32 data_d4)
> @@ -210,13 +137,13 @@ static void ufs_renesas_pre_init(struct ufs_hba *hba)
>   	/* This setting is for SERIES B */
>   	ufs_renesas_write(hba, 0xc0, 0x49425308);
>   	ufs_renesas_write_d0_d4(hba, 0x00000104, 0x00000002);
> -	ufs_renesas_wait(hba, 1);
> +	udelay(1);
>   	ufs_renesas_write_d0_d4(hba, 0x00000828, 0x00000200);
> -	ufs_renesas_wait(hba, 1);
> +	udelay(1);
>   	ufs_renesas_write_d0_d4(hba, 0x00000828, 0x00000000);
>   	ufs_renesas_write_d0_d4(hba, 0x00000104, 0x00000001);
>   	ufs_renesas_write_d0_d4(hba, 0x00000940, 0x00000001);
> -	ufs_renesas_wait(hba, 1);
> +	udelay(1);
>   	ufs_renesas_write_d0_d4(hba, 0x00000940, 0x00000000);
>   
>   	ufs_renesas_write(hba, 0xc0, 0x49425308);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
