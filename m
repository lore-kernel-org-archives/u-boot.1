Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A126DCD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 15:02:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD7E084928;
	Thu,  4 Jun 2026 17:02:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wMwJSnvj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65F5384879; Thu,  4 Jun 2026 17:02:21 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CB2B84908
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 17:02:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-45fd461e4a5so636654f8f.0
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 08:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780585339; x=1781190139; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Err73DfSZ+PX9FWDl+8+Mp8IRLdKqf6Q0Lqb2301kXk=;
 b=wMwJSnvj+PTikW1rE1NOOsXwhsK8n4PFZEUUhn3HlZ4WdGhFISgsUibvEEco6p/fHd
 LbPsRxXqW9AovaX4P0tXEFPqEfAMBb5bCYRbTbgFfO08aYP3hBRVV8gzGelAsLt8Y6wq
 KLhSsMHSz+wre7Ba3Fb7EuYXuKg+YS9mgHaGqeKor1UZ2O4DWWiliog2r9ZogxgEtafy
 5Vjih7PzxMeptYgeX9ZFxaQNL9UCrFfkelNmOoeOLA3ggfYWaTwGLuLA92uFXQAsOqfr
 9okk67PZoZMGETYMKbIO6lmyF8etQXyso83BTdoN+xG4j1x/yFCvGxBFGTVqQEdoX5Z3
 vSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780585339; x=1781190139;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Err73DfSZ+PX9FWDl+8+Mp8IRLdKqf6Q0Lqb2301kXk=;
 b=Xj4KC5GT/5Nap+GBE+2ulmsJ07HGOOFW0sp0UWE+OC25lfPR4zVt0K0Q418jJws2/T
 aO7EmkF5AGhHkjFVwi8odk8I/u9VCB9XU88MP7oksxRwxwrZ0HztJEluCk9xCCw77qfq
 S0jYotYbZF9wXBPYN8ApU8JPSQh/uXfQ7aEf5P5znsrMifRcpn+JFlnO1nTccJYhTUVd
 0trE4Nypz+9tN1lByqSrBk0jtBMa21GzjDlw4KnzdMaLUdvhvAJPC06ycWKlsitj270W
 l7Ji7c34gYC9LgBOLkBt7uYeA6E0LtWF9Lw+Cc7wjjljw6Y5sEnMzwTulm0wUyyROe2Q
 mWAQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4yw4u0SyVdvAQdtk7+oAkHmSl6L4dsV4d3u1Dsw7qIEpI7Cof5B0FN4gSo+gIPTHUXzq1TTc=@lists.denx.de
X-Gm-Message-State: AOJu0YynaEEYXx7FRVdpUAVtxJuDXlhWBbxLYB2uG4rWX5MSSXksnXo5
 Qfj4PRpX2upqjpHppVZh6foq6SdaANgpXsEIKmJJ+atgZN2vbMVqWtKObf4Q8MzoJQY=
X-Gm-Gg: Acq92OG/2TcnlbLQDJqf7Yz4pNKGmKEq+Mp9uDOKTfmVyGE8bbsxRma/ebp5MqOv7ma
 Q27KWfRKbRoTi+BHYhfbu1r47U735nDUNYe4wnhI/ZtW6Mg42P9t7IY60be5f4oBwuRNDQ34Tja
 uAbHEC3WLT/sIsn+wh3M26YNvTYRLz0Jwo+2Ifn38vPRNFNzvO0HmaYnByB0dGFjF1VfMkJ4q/w
 X18JMSZkoWUqTmRZ2Btie6Yl3ocLGY20fGwdwo4Gg2/WQd+sqJNaGIVenijI82k6x42sQQwpj6Z
 RT+7LeLf0i1cizHaJYavB2H/3HEZ5dRmz0OQHZwjtXJ1BUqMxl/jWCpH1bORkmMMfH4F5VR9f8j
 OUwWojkWwmgx9RvASLoz9liwfeZH35EKqtqRh+2xBvot9pDkgElb1SWT4DRkWfCnq8lD3jhzj2Z
 b1nPCyis2lbf/7N2v8xiUHxnT9z2wCaIisheJgvZ07tfqwaKhIsQBSpLVgzD0atbMy18xaXVWeS
 ST+9zmzEA==
X-Received: by 2002:adf:fd48:0:b0:45f:f142:d55f with SMTP id
 ffacd0b85a97d-460216db965mr10949386f8f.15.1780585338649; 
 Thu, 04 Jun 2026 08:02:18 -0700 (PDT)
Received: from ?IPV6:2a0e:c5c1:0:100:34f5:5b48:6fc0:9fd1?
 ([2a0e:c5c1:0:100:34f5:5b48:6fc0:9fd1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2e4b18sm12854726f8f.10.2026.06.04.08.02.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 08:02:18 -0700 (PDT)
Message-ID: <16ac86c9-e5e3-463c-ba3f-2ba6cbdff9f3@linaro.org>
Date: Thu, 4 Jun 2026 17:02:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] mmc: msm_sdhci: convert ofnode API to dev_read API
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot-amlogic@groups.io
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Paul Geurts <paul.geurts@prodrive-technologies.com>,
 Primoz Fiser <primoz.fiser@norik.com>, Yao Zi <me@ziyao.cc>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Peter Robinson <pbrobinson@gmail.com>, Peng Fan <peng.fan@nxp.com>
References: <20260604-devapi-v1-0-961aded05ff4@nxp.com>
 <20260604-devapi-v1-2-961aded05ff4@nxp.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260604-devapi-v1-2-961aded05ff4@nxp.com>
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



On 6/4/26 14:20, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Replace ofnode_read_u32(), ofnode_get_property() and
> ofnode_read_string_index() with their dev_read_*() equivalents in
> msm_sdc_clk_init(). Remove the intermediate 'ofnode node' local
> variable.
> 
> No functional change.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>   drivers/mmc/msm_sdhci.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index aaa87923604..7bdb02142a2 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -64,14 +64,13 @@ static int msm_sdc_clk_init(struct udevice *dev)
>   {
>   	struct msm_sdhc *prv = dev_get_priv(dev);
>   	const struct msm_sdhc_variant_info *var_info;
> -	ofnode node = dev_ofnode(dev);
>   	ulong clk_rate;
>   	int ret, i = 0, n_clks;
>   	const char *clk_name;
>   
>   	var_info = (void *)dev_get_driver_data(dev);
>   
> -	if (ofnode_read_u32(node, "max-frequency", (uint *)(&clk_rate)))
> +	if (dev_read_u32(dev, "max-frequency", (uint *)(&clk_rate)))
>   		clk_rate = 201500000;
>   
>   	ret = clk_get_bulk(dev, &prv->clks);
> @@ -87,7 +86,7 @@ static int msm_sdc_clk_init(struct udevice *dev)
>   	}
>   
>   	/* If clock-names is unspecified, then the first clock is the core clock */
> -	if (!ofnode_get_property(node, "clock-names", &n_clks)) {
> +	if (!dev_read_prop(dev, "clock-names", &n_clks)) {
>   		if (!clk_set_rate(&prv->clks.clks[0], clk_rate)) {
>   			log_warning("Couldn't set core clock rate: %d\n", ret);
>   			return -EINVAL;
> @@ -96,7 +95,7 @@ static int msm_sdc_clk_init(struct udevice *dev)
>   
>   	/* Find the index of the "core" clock */
>   	while (i < n_clks) {
> -		ofnode_read_string_index(node, "clock-names", i, &clk_name);
> +		dev_read_string_index(dev, "clock-names", i, &clk_name);
>   		if (!strcmp(clk_name, "core"))
>   			break;
>   		i++;
> 

