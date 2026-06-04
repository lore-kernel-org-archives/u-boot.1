Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FABCD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 14:56:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 511DF848A1;
	Thu,  4 Jun 2026 16:55:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CERnJaVt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C520A8490B; Thu,  4 Jun 2026 16:55:58 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC30C84879
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 16:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-46019b190b6so651490f8f.3
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 07:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780584955; x=1781189755; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KpSoUgCTGlEAVR4p19MOr0Uyd/9zz07UqLGzvS/SaDs=;
 b=CERnJaVtJf1xMAAnY+qipQQAtRNtB7uE7u6tcjtLmzWHzegRVRi7XIJRw1lhcgw5GC
 3N7Np6YTAFX9n8Iu8DrfjdPUDcYuCTWnr5FNgVKcxemLSgPz+fnlMKpDyvWr+RSSy2F4
 uAqK/wrWhla7sNDvcCdKAUzzNEd/swpLbcHMmyhdb1RfNbXe/C4xq8idC8O3Hnogybr8
 ELkVeeo135R+ooowcvNG28qGZnA+tVEDxeH9W13urMEPDHsPDs1tnUBBACANf8IPZ8eB
 rbC4BrNQi3qADWh/i8zLfa4TG1rM0ABxlXiSPcueVFatenNDBFBW1y5+z0RPJvRfT09T
 uYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780584955; x=1781189755;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KpSoUgCTGlEAVR4p19MOr0Uyd/9zz07UqLGzvS/SaDs=;
 b=CGkKsCQSvrTF5b9zLrraOqQOpkl7b/zbWD75X6y/ETRbuiZHRbmx4Aza1YOtOfIvAr
 ditV7g4lk+B3wPXzaT0b46tsit1a85z+xFeKAY0RyK4CGcBr5wC1TJ1IueE1OsaR8ydM
 4kPoklbzf02DlsYYQB20j87Vs9Sjnog/Fqx4OIh3U1zwKp/tL9Gd5K5RhqcE0rTcrM6q
 GIS7zhVWamruXrYUQQgsI99uphnCLajCbEBtbuqqpOWqWPew8vU7NE9SomUsqxAuFEYs
 ynU9MNJ2dfbqh32116bh0vrTK0+Be0gcwl0joRFQ9nhTf4QMMCykyTmzbFHN3VLpf4L2
 J+tA==
X-Forwarded-Encrypted: i=1;
 AFNElJ98wKJH/V1n5eefhLL2GNmkVhPW0JAjg1Y2ARH4/kDYrwndX78uyYXW36okQVQKEiVGv+cAHQ4=@lists.denx.de
X-Gm-Message-State: AOJu0YwRUiusiXc21DfZMo1X+lsFl+WhRheN8rPACFPDIeUbAD+Cebuc
 R0MihcVjNFEyVz5B5OrN3LFz9rnwmnPe/c2T9IhKRaxAezLQfp/itgYsulqR3hpHWQs=
X-Gm-Gg: Acq92OEqjyZC1sT5MAZDYGBkgSMVtymm9b8u0eO1AVWcbS31hpIjcd5c5yKKkWMnSYg
 Flu1tFGkWboSO95sSuGsnQ/S25X+z5GGHE+2vZdgCFYEIxzIEXC9GSXh+shOzrvILrJPiMTjwD9
 mEltzo6pAyA6ZW20lGKoicYWGH7e+DlyVHsZCoybD25mgs5Kbli2+HEyO+CkWFAAvc9J15CiZrz
 MDZYCcSZZLV1WlTHK6i+hq8mQoCvP+96N+MEeOkJb4Isv1Bf9bRyR5rPOsTvBmZswV0jOiuMDsj
 gfmWUiItgGjGrdEYbERbUwh0cHwLgSsKjV3u2aU17l65jfyjBMM4sb/LtwSk1NE4wa0a7YsGCLu
 KbOjWqd/oIC1eh2DsifMkpvtcTCH3yhjm5lydrYTrv91li2ZyaAGwAPN+OCzV+i/W85QbbtZmju
 RbWPMThRbCu1iKa6VKnScYJTyWVTM7DRoV631XGrwYgz1eKnGhAbq/dVxnG41Llia9UUHSZJR0/
 OELB+aBwQ==
X-Received: by 2002:a05:6000:1f09:b0:45e:f266:f4cb with SMTP id
 ffacd0b85a97d-4602193871amr9144318f8f.22.1780584955258; 
 Thu, 04 Jun 2026 07:55:55 -0700 (PDT)
Received: from ?IPV6:2a0e:c5c1:0:100:34f5:5b48:6fc0:9fd1?
 ([2a0e:c5c1:0:100:34f5:5b48:6fc0:9fd1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f345209sm16612714f8f.17.2026.06.04.07.55.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 07:55:54 -0700 (PDT)
Message-ID: <a9531a9b-7a10-4804-9f00-199f8c50d051@linaro.org>
Date: Thu, 4 Jun 2026 16:55:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] power: regulator: qcom-rpmh: convert ofnode API to
 dev_read API
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
 <20260604-devapi-v1-10-961aded05ff4@nxp.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260604-devapi-v1-10-961aded05ff4@nxp.com>
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
> Replace ofnode_read_u32(dev_ofnode(dev), ...) with
> dev_read_u32(dev, ...), ofnode_read_string(dev_ofnode(dev), ...) with
> dev_read_string(dev, ...), and ofnode_for_each_subnode(node,
> dev_ofnode(dev)) with dev_for_each_subnode(node, dev).
> 
> No functional change.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>   drivers/power/regulator/qcom-rpmh-regulator.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/power/regulator/qcom-rpmh-regulator.c b/drivers/power/regulator/qcom-rpmh-regulator.c
> index 4d65aae1690..f1de660c3a0 100644
> --- a/drivers/power/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/power/regulator/qcom-rpmh-regulator.c
> @@ -5,6 +5,7 @@
>   #define pr_fmt(fmt) "%s: " fmt, __func__
>   
>   #include <linux/err.h>
> +#include <dm.h>
>   #include <dm/device_compat.h>
>   #include <dm/device.h>
>   #include <dm/devres.h>
> @@ -882,7 +883,7 @@ static int rpmh_regulator_probe(struct udevice *dev)
>   	priv->hw_data = init_data->hw_data;
>   	priv->enabled = -EINVAL;
>   	priv->uv = -ENOTRECOVERABLE;
> -	if (ofnode_read_u32(dev_ofnode(dev), "regulator-initial-mode", &priv->mode))
> +	if (dev_read_u32(dev, "regulator-initial-mode", &priv->mode))
>   		priv->mode = -EINVAL;
>   
>   	plat_data->mode = priv->hw_data->pmic_mode_map;
> @@ -933,7 +934,7 @@ static int rpmh_regulators_bind(struct udevice *dev)
>   		return -ENODEV;
>   	}
>   
> -	pmic_id = ofnode_read_string(dev_ofnode(dev), "qcom,pmic-id");
> +	pmic_id = dev_read_string(dev, "qcom,pmic-id");
>   	if (!pmic_id) {
>   		dev_err(dev, "No PMIC ID\n");
>   		return -ENODEV;
> @@ -941,7 +942,7 @@ static int rpmh_regulators_bind(struct udevice *dev)
>   
>   	drv = lists_driver_lookup_name("rpmh_regulator_drm");
>   
> -	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
> +	dev_for_each_subnode(node, dev) {
>   		data = vreg_get_init_data(init_data, node);
>   		if (!data)
>   			continue;
> 

