Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA753C79F9F
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 15:19:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8FB1583DEA;
	Mon,  5 Jan 2026 16:18:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lINbPZtE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C523583DEA; Mon,  5 Jan 2026 16:18:34 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01EC5836D3
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 16:18:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-4779aa4f928so209615e9.1
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 07:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767626311; x=1768231111; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=oqNy55eIJDrDrlvyXMiIIf0YBF/KeGLBmvZY3Nk5BZ0=;
 b=lINbPZtElFl3nx9wKWKmUozyj1BIetjVm++ZXG/s3+lL/52T8fbnoftPd7DVXUJZZs
 vp7B8ceJrVIwGaCqVhtpx67Y0TO9h5sDdK2nbkFlMPi96lLywQUOmKPlveS0b49tJLJ3
 CUrQp0FXUE36MMfbydqzlxuaSPTk7es6+J8irEvBEYo2eq8MmlDpPFDjU+230cVZFMlS
 V9uapeXPyLEF+EwtJ9AVq7F8Un1Rz/5HUhj9zGcLzTmiBpACRdF9Ps61T+JR32dbIXai
 n63mzrWTdjMs3vOAnfokzGdvmMvlHd0Tvp83P+ZujJ1jjXZqfDdEH/XtGd2Ix5TyU5Uh
 XqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767626311; x=1768231111;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oqNy55eIJDrDrlvyXMiIIf0YBF/KeGLBmvZY3Nk5BZ0=;
 b=JqBBTNtL4rJIBDCURhMX20YWvHLo0UmfHZvqqw/JoSmhHWKadjA5VEL3a3krzcxaqy
 5+afuarMag5lBLzh+VFTRbwYpaFMEVrLlpyZw+9IGuZshCSQ3j7ydGq/mEK4JDxGSSky
 LToYkAeczieXigflyXQ2HiGya4FS70ayY5leY80QolB+a2nCQ2GzMwJtruI/Tk1fQmZK
 aOhqD/dYorw/ZU6DosGFxVT3IyJhl9MZrYzpYCgwZyXwK3cGTAUPaqQ/eKrdNFA4mOIV
 9uoGK1DZK5YHMeH8pz1J3DkGuUc1lShYN4/24pqanMLyaYGObsM7ekrintmZ4XOjjNu3
 9OJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCLjgoD8wSkBp0q40D1F9w5ijWsc8NHRK82VF3+J6FFjggQvxetzcx00KEd0lBKu+Lpl0JtH0=@lists.denx.de
X-Gm-Message-State: AOJu0Yzap2kG8i3Qnu10sxA9W3wjMO3L+QKS5qOuZSCOkNZd8lACYXwK
 82YlLp21xpwBAIyPGJq/ZfOCDccVqMNujC4uOrtO/4T9TYTBUNO9kfiRiAuSX/TE5KA=
X-Gm-Gg: AY/fxX7qKyL0h9mDZTJfNc26musVsfiG3PhECndwbgS9GUqNG0aIqVN0ZouGIeROitp
 0NzTc5WJN4jME2OGO4Q2FtSjpWLp/F9ehXPR7OQ9soayfwgI2PhUH7BHg2FboW6PK2CII9CxKeV
 bopwg2y9HFjVOVzeceCdbkJp7/5G2a/Y9tsf39Df/ruV1QcS2tvCxYOmi61A8tJT0mrCSuQuc8m
 75/KwWQbPuWH+T2cxxRC2awv6EOJMeowvTYcSJKLrDbJxZqBUy88oYD/YXe9WbR1nYfhJJYGuEN
 C63QRBIBtPM+7C2KQLCBAehM5AhjKVPi6+YqpR9JjjxCXD7r9eHvXbzSXhc0NwcUZKHnHXk2FCL
 ZBeqocqZk/UigQ6QcAo06Fiv4Z0Z3+iigtxwWZHH/CCvFcOc//on7W+IXBDbdThTfDK3rKtSeN3
 SGgFdXfdfqPKK8nDDWm2GS1mSiW2uLZatbHLFEl2wq7KfD4V/NawgXV8yV2hLRWyAQnDkGlUUbq
 A==
X-Google-Smtp-Source: AGHT+IFjqYndfdB0IUwr6L6EQCqnthefvFgyOl+m0vdtuI1x8DO2fgwJIR5gQ1yne9u96rkFGOI9dA==
X-Received: by 2002:a05:600c:c0d2:20b0:47d:264e:b371 with SMTP id
 5b1f17b1804b1-47d264eb6b0mr417240525e9.18.1767626311096; 
 Mon, 05 Jan 2026 07:18:31 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:d4c1:5589:eadb:1033?
 ([2a01:e0a:3d9:2080:d4c1:5589:eadb:1033])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bca569e6sm51599f8f.31.2026.01.05.07.18.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 07:18:30 -0800 (PST)
Message-ID: <2b4dca05-4b07-469d-bc68-a1406b7dec59@linaro.org>
Date: Mon, 5 Jan 2026 16:18:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] ufs: amd-versal2: Fix clock name with binding
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <eadc8d159b6d822077549722c9ec5a96a4d16c2a.1765973221.git.michal.simek@amd.com>
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
In-Reply-To: <eadc8d159b6d822077549722c9ec5a96a4d16c2a.1765973221.git.michal.simek@amd.com>
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

On 12/17/25 13:07, Michal Simek wrote:
> Align clockt name with DT binding.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Binding is available here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/ufs/amd,versal2-ufs.yaml?h=v6.19-rc1
> ---
>   drivers/ufs/ufs-amd-versal2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/ufs-amd-versal2.c b/drivers/ufs/ufs-amd-versal2.c
> index 97de0756f70a..dd62c9819ba1 100644
> --- a/drivers/ufs/ufs-amd-versal2.c
> +++ b/drivers/ufs/ufs-amd-versal2.c
> @@ -305,7 +305,7 @@ static int ufs_versal2_init(struct ufs_hba *hba)
>   
>   	priv->phy_mode = UFSHCD_DWC_PHY_MODE_ROM;
>   
> -	ret = clk_get_by_name(hba->dev, "core_clk", &clk);
> +	ret = clk_get_by_name(hba->dev, "core", &clk);
>   	if (ret) {
>   		dev_err(hba->dev, "failed to get core_clk clock\n");
>   		return ret;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
