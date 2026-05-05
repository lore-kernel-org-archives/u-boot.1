Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0553CD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 13:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 448FF848FC;
	Tue,  5 May 2026 15:45:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uxpYIRx6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E00D84936; Tue,  5 May 2026 15:45:54 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6857848B9
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 15:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so11914085e9.3
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 06:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777988751; x=1778593551; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v2Ujph7/mGTdhtkoEBz4nbCz89J6KB3wKpij943HSSo=;
 b=uxpYIRx6xQRdjTl8sZFJOnOeA5l56Qw6fpMzsOTpEuPbwdZtbuxX2Hjrs+W/BGhJDV
 Xw0Tr/We4F7gXYfUzWfwRjVWDE+uoSUJu4upGWdF2GxFrkms0UGoB6qz+xitPvQ1dH1C
 lzvgktCn30CO8WM9s1sTk+Oo0+HfJ/Pw0I9H+Lc1wUsQabIIFFML5Dt8xuCLST9hFvjQ
 tsG/dO3KmmsEsEWQ9NGoQ/xEH50IWQLUCougqN+6pL4yaC5l684LYZzI20jVzx97QZeL
 9Ye1xcOwbVKHf9VyCEC1URmpFdZlQ8orAOoTqwMjS0yl/Ls7g/zYLzHCoQdlf2IA1JWv
 VvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777988751; x=1778593551;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v2Ujph7/mGTdhtkoEBz4nbCz89J6KB3wKpij943HSSo=;
 b=KeJEFR30Q2sTze4YmD5QwPQ0EZfRaTVo1qu5Hcb95apDLqggxTSnVNJS80niTUljcD
 cmJyvNT7Vx80IbmqrDvI0OheTGKxT8dKJcY7CyvAaDM2Ud45+5oDBAqRe8uXY+Cx6G5Y
 hEbAthoq3tEpwWJ0mqqoo1/EUOLQn9+JqZQrOjZTGUH/0mcdnaF9ZZy3impP242YExba
 tCJK3wSudjTUyieAaPBuILeedruWuTL3z+2Yes8MnBG7gVHne6ASJYevGBNcc7VBI78n
 7j/JKT0cLwo9FcSc5DdVWdRLZr7DT/ArVG9pLTPr6Jjr4XxfgOY5XY21kc5YvFnGcRnV
 z00w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8d0OtU1/ZvCr3lSls13oX+5Q1LU/GJ695amL9E4SSoPgvgKBRpf4Heh8xrOw5Hp4+HX687vMY=@lists.denx.de
X-Gm-Message-State: AOJu0YyTfpK3DWwBpwd13CG6TKYnNjyEQV0LbeZ5cm9POrlO3BpnWg+Q
 AntNdbk6yxPgxagpkH7p05YAeI7OjT/kXJ8NJPPcmYapOvSrrlFvu4EsKRdNL55sCms=
X-Gm-Gg: AeBDietye+I9/5O8zc9T5wu530arSZ6oWyUbaNAxDTsKu8JzNlMSeca+8CSWxb9s7w5
 pLHl11zX3IO34JlR8Lj1rSwwz6lS3g1M5BxdrwW3Q54IWWIZqVDM4OLgUV3l7RMTJvsB5yc115h
 Tm6j9nQvECLo/U+yMnFo3C76ot4axfU9vT0UeqNDlqwh2xBTzvLhTOX3ey7NnjpRUocwYIYitsa
 FvMEQNnTS+tG5R9sEpKUjM9+1GtAU0gr0cEUaWFThIlXHZMHBjkDX/Ck8Mfv5FRo588zzhs1tEk
 SpGL4T/kIgj31jkvRGd+TOQd0YLnsDWfQWBNodFEaWcXGNRX8CeqT9x0J6rwuTwV96Jrp/nAPKl
 bWEjaRfFi4ibDsGeC5+TdAcT5uIzCJkakWhn2DGy960+DjOK2QKlJEgErZhwFDzoOGNpis5nRft
 VcMAINzL/EcNKFCr9JmmLW5fpC3PdFbBXbEyj3e02uB+fsKG9XW1eGFNYfvSDNM74TFX5mnKKCC
 IJ7
X-Received: by 2002:a05:600c:c16a:b0:489:1cda:bbb7 with SMTP id
 5b1f17b1804b1-48d18ceb33dmr52637545e9.25.1777988751026; 
 Tue, 05 May 2026 06:45:51 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eba8487sm349281325e9.11.2026.05.05.06.45.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 06:45:50 -0700 (PDT)
Message-ID: <151c9899-d082-4f5c-afcd-d56c860f2965@linaro.org>
Date: Tue, 5 May 2026 15:45:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drivers: mmc: uclass: Set removable flag based on
 device tree property
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>, Peng Fan
 <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Sajna <sajattack@postmarketos.org>,
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
References: <20260421-emmc-v2-0-0ebd3322b676@oss.qualcomm.com>
 <20260421-emmc-v2-2-0ebd3322b676@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260421-emmc-v2-2-0ebd3322b676@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
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



On 21/04/2026 15:00, Balaji Selvanathan wrote:
> The block device removable flag should reflect whether the MMC
> device is physically removable (SD card) or soldered (eMMC). This
> information is specified in the device tree via the "non-removable"
> property and stored in the MMC_CAP_NONREMOVABLE capability flag.
> 
> Update the removable flag in the block device descriptor during
> controller probe to properly reflect the device's removable status.
> This allows the block layer and upper layers (particularly EFI boot
> manager) to distinguish between eMMC and SD cards for appropriate
> handling.
> 
> The default removable=1 is set in mmc_bind(), and this change
> overrides it only for non-removable devices after mmc_of_parse()
> has set the MMC_CAP_NONREMOVABLE capability from the device tree.
> 
> Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Moved removable flag update from generic mmc-uclass.c to platform-
>   specific msm_sdhci.c driver
> ---
>  drivers/mmc/msm_sdhci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index 66f3cf2de4f..13fd4ae8a7d 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -189,6 +189,7 @@ static int msm_sdc_probe(struct udevice *dev)
>  	struct sdhci_host *host = &prv->host;
>  	u32 core_version, core_minor, core_major;
>  	struct reset_ctl bcr_rst;
> +	struct blk_desc *bdesc;
>  	u32 caps;
>  	int ret;
>  
> @@ -252,6 +253,12 @@ static int msm_sdc_probe(struct udevice *dev)
>  	if (ret)
>  		return ret;
>  
> +	if (plat->cfg.host_caps & MMC_CAP_NONREMOVABLE) {
> +		bdesc = mmc_get_blk_desc(&plat->mmc);
> +		if (bdesc)
> +			bdesc->removable = 0;

Would bdesc ever be null here? Or an ERR_PTR()? Please handle the error
case properly and bail out.

> +	}
> +
>  	host->mmc = &plat->mmc;
>  	host->mmc->dev = dev;
>  	host->ops = &msm_sdhci_ops;
> 

-- 
// Casey (she/her)

