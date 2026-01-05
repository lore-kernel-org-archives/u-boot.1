Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A75C79F9D
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 15:20:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E3AF83E62;
	Mon,  5 Jan 2026 16:20:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="t+J7g4GJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C2EE83E76; Mon,  5 Jan 2026 16:20:43 +0100 (CET)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F78C83DEA
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 16:20:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-42fbc305882so6801640f8f.0
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 07:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767626439; x=1768231239; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=EfGR42vRJtBkHu8nsjmr1AN/Y9syEISZCHonEXAy+sM=;
 b=t+J7g4GJoQCxcn2+JTjwlfQZ2sKNysiM1fGRztv+SJ6p51Xw7SbeShHhDPR+ySBHJh
 dfuSpesDcBZ7vAS3pU3J5M/2/TSfnFq1v/vkbbwGEwUPmGddev1sq35fA0HZPM1OdmTz
 mDxfGJzkjdCE409qkXXjX5cXGueUcBkrHuDykxKH6B7cQKhnQzP7bAr2OCbm6j1QEGFM
 2rOkKZoaNomxJwbQS0WYTa1GkziLGrWj2unNDAhbdLWtfSsUwfZiXQIjUiVAXI+6pxO1
 805IOJloEm0IDY3wzuSsAIGqY6yGhM5fZAj5GLpoiSXx5lZD0RME5LERTuxes+soc8vL
 C3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767626439; x=1768231239;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EfGR42vRJtBkHu8nsjmr1AN/Y9syEISZCHonEXAy+sM=;
 b=qbisGn1uEoCVjH35dg7csEoo8s4jQVPMn0jW8GAlQPSxySsPpU82XpGNaHDCiZ2tvR
 oSrsRUmBL74prG5+0GhcjyeUKBd61jzNSB6vI4oNO7lqHmrPiS7R5re9b1V2WpacrAOR
 meOIPhmlbTN0TRmHw9C3XbB9VBaFiK1gpzE0Z0ewj7f0jYAePCw1Cdq+T8vbuwnR/Kdu
 0KFKjMkQ5sbPW4smqSheHywbdHwj4pXqhgvMAApfj+g1InEHAaAwXrWZcbFn98ek5d7G
 meanFwgMoZAdicNgnX30Fp3FrKqsGi7JKNDehSdLS4lWoeDcm0LDi4JEFw1P/045SGN7
 25gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFSQdToDVP4YAvgwsNfEnf0F6Tz0L+gXPjqfMDl02mIzO1cqhjgkYKR24iEzQnB5Fet5BohZs=@lists.denx.de
X-Gm-Message-State: AOJu0YxE38xbrx2eJFaK105zT1igLPdS/H0m7rFSC5OC1tmVhj8rs6J7
 jqY7ajUKQqW7oH8VkmJ5RhvAY+kvmuusZpU2/5nmSmzIp7hBp5K8JsX6LpvpVkBCMC3AHY0bPE6
 tu5/t
X-Gm-Gg: AY/fxX47B1BxZ0jdH/hAM59gX3zgwohzA99I3lVAsuKRIEfgu69hMFgyAA8x7ciD6Mj
 sahcMWfnHwg+ZRDYDHXK5zrKssHB+PKo7K70/I3RCHpAr7eDerZHH8aNw8qkhePhMXoKvRspiZ2
 xiP/9EAHYCIIMHUAYd5JJPKZvGsek5hXEKwkddhJv6ip0avOmwK29SEwtjF3ensoKU+6Q++5VXL
 49WunV2SIBcYJdFSgvlNIOQA4JS5mpqLTKyQ2OmUGPgOU6l5Odf0VaJwdsEfQiSX21oGR3p9La3
 FAtzQ9xsQOvaWuD7+wExlqMJE8djG73tNuklKVrg/DGSq4Soy9UVWqumcNrTfiqugYDg3E7fjnx
 nRYV75Y6uLRtFwZiN5AyLWfLpGaljaQQBPNhp7xEosd9kD8KzIr7YsCiAbfLmoQK7lvdTaePBCY
 Wljb+kC7ugVpVKhpKSZoC/GMeDFeS/HSQyVKmiKLTfkSSGj4l/MsBrA9lUSaupDfbJEM6Rtfog3
 w==
X-Google-Smtp-Source: AGHT+IH0VC2BUfqhsMEh1Cck6V41p0TEvD+hCZgnsUaSV5ToVvqDZq8QZcTXn3e8XhWHBo72BTI4sw==
X-Received: by 2002:a05:6000:18a6:b0:431:701:4a22 with SMTP id
 ffacd0b85a97d-432bca3e417mr124376f8f.27.1767626438699; 
 Mon, 05 Jan 2026 07:20:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:d4c1:5589:eadb:1033?
 ([2a01:e0a:3d9:2080:d4c1:5589:eadb:1033])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bca2f83dsm99150f8f.13.2026.01.05.07.20.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 07:20:38 -0800 (PST)
Message-ID: <a99b6773-5bd4-4030-9308-59db9d4d0fbc@linaro.org>
Date: Mon, 5 Jan 2026 16:20:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 5/5] scsi: ufs: renesas: Add reusable functions
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
References: <20260103002254.183357-1-marek.vasut+renesas@mailbox.org>
 <20260103002254.183357-5-marek.vasut+renesas@mailbox.org>
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
In-Reply-To: <20260103002254.183357-5-marek.vasut+renesas@mailbox.org>
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
> Since some settings can be reused on other UFS controller (R-Car S4-8
> ES1.2), add reusable functions.
> 
> Ported from Linux kernel commit
> 44ca16f4970e ("scsi: ufs: renesas: Add reusable functions")
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link: https://lore.kernel.org/r/446d67b751a96645799de3aeefec539735aa78c8.1741179611.git.geert+renesas@glider.be
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
>   drivers/ufs/ufs-renesas.c | 71 +++++++++++++++++++++++++++------------
>   1 file changed, 50 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/ufs/ufs-renesas.c b/drivers/ufs/ufs-renesas.c
> index b2edc3b5497..5652309911e 100644
> --- a/drivers/ufs/ufs-renesas.c
> +++ b/drivers/ufs/ufs-renesas.c
> @@ -130,21 +130,8 @@ static void ufs_renesas_indirect_poll(struct ufs_hba *hba, u32 gpio, u32 addr,
>   	ufs_renesas_write(hba, 0xf0, 0);
>   }
>   
> -static void ufs_renesas_write_phy_10ad_10af(struct ufs_hba *hba,
> -					    u32 data_10ad, u32 data_10af)
> +static void ufs_renesas_init_step1_to_3(struct ufs_hba *hba)
>   {
> -	ufs_renesas_write_phy(hba, 0x10ae, 0x0001);
> -	ufs_renesas_write_phy(hba, 0x10ad, data_10ad);
> -	ufs_renesas_write_phy(hba, 0x10af, data_10af);
> -	ufs_renesas_write_phy(hba, 0x10b6, 0x0001);
> -	ufs_renesas_write_phy(hba, 0x10ae, 0x0000);
> -}
> -
> -static void ufs_renesas_pre_init(struct ufs_hba *hba)
> -{
> -	u32 timer_val;
> -
> -	/* This setting is for SERIES B */
>   	ufs_renesas_write(hba, 0xc0, 0x49425308);
>   	ufs_renesas_write_d0_d4(hba, 0x00000104, 0x00000002);
>   	udelay(1);
> @@ -158,7 +145,10 @@ static void ufs_renesas_pre_init(struct ufs_hba *hba)
>   
>   	ufs_renesas_write(hba, 0xc0, 0x49425308);
>   	ufs_renesas_write(hba, 0xc0, 0x41584901);
> +}
>   
> +static void ufs_renesas_init_step4_to_6(struct ufs_hba *hba)
> +{
>   	ufs_renesas_write_d0_d4(hba, 0x0000080c, 0x00000100);
>   	ufs_renesas_write_d0_d4(hba, 0x00000804, 0x00000000);
>   	ufs_renesas_write(hba, 0xd0, 0x0000080c);
> @@ -168,6 +158,11 @@ static void ufs_renesas_pre_init(struct ufs_hba *hba)
>   
>   	ufs_renesas_write(hba, 0xd0, 0x00000804);
>   	ufs_renesas_poll(hba, 0xd4, BIT(8) | BIT(6) | BIT(0), BIT(8) | BIT(6) | BIT(0));
> +}
> +
> +static u32 ufs_renesas_init_disable_timer(struct ufs_hba *hba)
> +{
> +	u32 timer_val;
>   
>   	ufs_renesas_write(hba, 0xd0, 0x00000d00);
>   	timer_val = ufs_renesas_read(hba, 0xd4) & 0x0000ffff;
> @@ -179,6 +174,45 @@ static void ufs_renesas_pre_init(struct ufs_hba *hba)
>   	ufs_renesas_write(hba, 0xd0, 0x00000d2c);
>   	ufs_renesas_poll(hba, 0xd4, BIT(0), BIT(0));
>   
> +	return timer_val;
> +}
> +
> +static void ufs_renesas_init_enable_timer(struct ufs_hba *hba, u32 timer_val)
> +{
> +	ufs_renesas_write(hba, 0xf0, 0);
> +	ufs_renesas_write(hba, 0xd0, 0x00000d00);
> +	ufs_renesas_write(hba, 0xd4, timer_val);
> +}
> +
> +static void ufs_renesas_write_phy_10ad_10af(struct ufs_hba *hba,
> +					    u32 data_10ad, u32 data_10af)
> +{
> +	ufs_renesas_write_phy(hba, 0x10ae, 0x0001);
> +	ufs_renesas_write_phy(hba, 0x10ad, data_10ad);
> +	ufs_renesas_write_phy(hba, 0x10af, data_10af);
> +	ufs_renesas_write_phy(hba, 0x10b6, 0x0001);
> +	ufs_renesas_write_phy(hba, 0x10ae, 0x0000);
> +}
> +
> +static void ufs_renesas_init_compensation_and_slicers(struct ufs_hba *hba)
> +{
> +	ufs_renesas_write_phy_10ad_10af(hba, 0x0000, 0x0001);
> +	ufs_renesas_write_phy_10ad_10af(hba, 0x0000, 0x0002);
> +	ufs_renesas_write_phy_10ad_10af(hba, 0x0080, 0x0000);
> +	ufs_renesas_write_phy_10ad_10af(hba, 0x0080, 0x001a);
> +}
> +
> +static void ufs_renesas_pre_init(struct ufs_hba *hba)
> +{
> +	u32 timer_val;
> +
> +	/* This setting is for SERIES B */
> +	ufs_renesas_init_step1_to_3(hba);
> +
> +	ufs_renesas_init_step4_to_6(hba);
> +
> +	timer_val = ufs_renesas_init_disable_timer(hba);
> +
>   	/* phy setup */
>   	ufs_renesas_indirect_write(hba, 1, 0x01, 0x001f);
>   	ufs_renesas_indirect_write(hba, 7, 0x5d, 0x0014);
> @@ -214,10 +248,7 @@ static void ufs_renesas_pre_init(struct ufs_hba *hba)
>   	ufs_renesas_write_phy(hba, 0x4000, 0x0000);
>   	ufs_renesas_write_phy(hba, 0x4001, 0x0000);
>   
> -	ufs_renesas_write_phy_10ad_10af(hba, 0x0000, 0x0001);
> -	ufs_renesas_write_phy_10ad_10af(hba, 0x0000, 0x0002);
> -	ufs_renesas_write_phy_10ad_10af(hba, 0x0080, 0x0000);
> -	ufs_renesas_write_phy_10ad_10af(hba, 0x0080, 0x001a);
> +	ufs_renesas_init_compensation_and_slicers(hba);
>   
>   	ufs_renesas_indirect_write(hba, 7, 0x70, 0x0016);
>   	ufs_renesas_indirect_write(hba, 7, 0x71, 0x0016);
> @@ -244,9 +275,7 @@ static void ufs_renesas_pre_init(struct ufs_hba *hba)
>   	ufs_renesas_indirect_poll(hba, 7, 0x41, 0, BIT(7));
>   	/* end of phy setup */
>   
> -	ufs_renesas_write(hba, 0xf0, 0);
> -	ufs_renesas_write(hba, 0xd0, 0x00000d00);
> -	ufs_renesas_write(hba, 0xd4, timer_val);
> +	ufs_renesas_init_enable_timer(hba, timer_val);
>   }
>   
>   static int ufs_renesas_hce_enable_notify(struct ufs_hba *hba,

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
