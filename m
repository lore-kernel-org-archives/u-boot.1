Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2225ECD5BB4
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 14:04:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96B01846C0;
	Fri, 22 May 2026 16:04:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XvmkY8ZS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F2DC846F1; Fri, 22 May 2026 16:04:13 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95C38846A7
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 16:04:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43d77f6092eso4357596f8f.2
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 07:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779458650; x=1780063450; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yUx1JEZHDyTqE8FofjaS4t1sWKnsVGzU8Kqn/V2YIOg=;
 b=XvmkY8ZS00k2tpzMdU8+0kdZRnsJFoVKTvOLpPkriAzNjnylUy5b4VuMa56kO6Lk4P
 BpKhEQdf5U1dFba/DRGNECKFQMO7sdOx6KP18d9UftOqDIeT3aISShix+ZvVqbwREr+9
 70CqmrBNPe4w9GM0EsBGRTRwMnotMXf31FnTSZ0ic9j8U2jRnwE/LzDpS56TJXPPiGkC
 fShF2VAxLocnKOoydmJrvXCCDKb7R/9BrVzhD+01dGwNtLeyidKIulSNXz/QqF+LYxQp
 tutifVhh7bsHXlpc7ehGPZowZY6IXzWpk12PllfP473CfQ+Nnre2WIOsXD33p/7pRPky
 1+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779458650; x=1780063450;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yUx1JEZHDyTqE8FofjaS4t1sWKnsVGzU8Kqn/V2YIOg=;
 b=f71war5sRA5+8DEzPLesVSDvdNFA2OdDHmVfrQ6SyfhG9kiQBtPpprKvrlIwvhPCRq
 Xq5wAAU5BP8SsK7h8qCvnoFL0LRWVSH5SNs8XvEtk7SWrQJWXUnYNVS4tJX0yvi/7EV9
 +xPcoc8TYRtf62M+zEdGDUbmZf67+2kYT1y4kkVLC61ZjiMloqdINlLAABBk4klqlAeJ
 0rKivujRWFyIX1omZxyozaoa0EmbFlchhkNw+d/ZRziUX18WIz4tNLB66ELPVmVWB1kY
 uNng07vnooqqqrfbH5bd1lFV9BuplUTOe6fT4+DclqHgl9UsNXQrjh4C82GKhVdaLhRO
 COlA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/E+AzA0ZpBuJhbnSvpNb+lxhFE2QGUgHwaP8gqm8nFGIWdlEOGYUxnJ2dnCShqRrRbjA5/4wM=@lists.denx.de
X-Gm-Message-State: AOJu0YwOjxXE8PKXa2poQh8KpFfhqLrTGyYsy2YCfsgTQK5CCgHAL08r
 itDF4gj6v75qQkE/DsIK2S24IAN8U9iNRxhKs8SJfT3Afk6iDRSk1OQsvISBr02Hu+k=
X-Gm-Gg: Acq92OF1gQ1BUY1EmSthsAQVrgIp/XbLfTDZieyD+Ppn/d+NlV9Ob3Lou4J43FmFdCb
 upHqR91b5uirsO3zATM1iuw3a2LpN75ElyaoUDtaFzVzVkpClsnSMex86ayL19L3ih299Cq/HwW
 GXCoD03cVAh5Rtf8XwGfVQVpkhkykKz0pxnkHmk9l7xZFjYQYQjpvfybI+jFVS0nJfIb3x0s11G
 PCudr918LCvUAYNxWlbjwD87MwaoWIcmFbuTWCPWki61wY88sU2SPOG/IhILKZoRq3/sYcpIEdw
 4x7oHFMJLK7C3cmIYwaftvaW/Oj0777tYyD3wVivm2pUMuxoN+ycVxEGrSdZe8M0GPapgo6UOgG
 1y9JVL1oS/n1xICg2jdT8XU+FnZQ3t0wCL0SKGo4CvNVI8oERLAF4ntRzEwCKNOWF+Abu7DwYdR
 uEfV1Mdk/HRVLl7x55BaIVg04N39rHDro4cxPHi3CvjgNgFCyy1XRfSBtHE1XtUhG6/yD9TH8E4
 VZs
X-Received: by 2002:a5d:59c3:0:b0:43d:7a97:78a2 with SMTP id
 ffacd0b85a97d-45eb38a6422mr5759110f8f.28.1779458649822; 
 Fri, 22 May 2026 07:04:09 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d49132sm4563131f8f.24.2026.05.22.07.04.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 07:04:09 -0700 (PDT)
Message-ID: <114981f6-3a82-480d-ae0c-4a685eff338d@linaro.org>
Date: Fri, 22 May 2026 16:04:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ufs: qcom: Add UFS host regulator support
Content-Language: en-US
To: federico@izzo.pro, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260521-dpu-add-dspp-gc-driver-v1-1-83372488cdcf@izzo.pro>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260521-dpu-add-dspp-gc-driver-v1-1-83372488cdcf@izzo.pro>
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



On 21/05/2026 20:39, Federico Amedeo Izzo via B4 Relay wrote:
> From: Federico Amedeo Izzo <federico@izzo.pro>
> 
> The qcom UFS driver works without touching the regulators on most platforms
> as ABL leaves them already configured and enabled.
> On some SC7280 phones with UFS 3.1 like nothing-spacewar, vcc regulator is
> not enabled by ABL, so we need to configure and enable it to use the UFS
> storage.
> 
> Tested on nothing-spacewar and motorola-dubai using Tauchgang U-Boot.
> 
> Signed-off-by: Federico Amedeo Izzo <federico@izzo.pro>
> ---
> Add support to qcom-ufs driver for vcc-supply and vccq-supply
> regulators to enable UFS support on SC7280 devices with UFS3.1.
> SC7280 devices with UFS2.2 were already working.
> 
> The root cause was ABL leaving vcc-supply regulator disabled on UFS3.1
> devices, and enabled on UFS2.2 devices that worked fine without
> regulator support.
> 
> The tricky part was enabling the regulator in HPM mode (3), which required
> setting LPM mode (1) first, otherwise reg would stay in LPM mode.
> I discovered this by changing the regulator settings from U-Boot
> console. Enabling the regulator in LPM mode resets the phone.

Huhh well that's weird, could this be a bug in the regulator driver? If
you run "regulator status -a" the regulator states are actually read out
from rpmh so they should be accurate but maybe the numerical mapping
isn't correct so logging those as numbers might help.

I'm curious what the default voltage is for that rail (vreg_l7b_2p96
right?) since it seems to have a large range on that device from 2.4v to
3.5v. If it gets enabled without setting the voltage then it could be
set too low and brownout in LPM.

It might be worth double checking if the voltage range is correct for
that device by comparing to the Android devicetree.

I'd suggest raising the minimum voltage for that rail to the 2.96v (or
at least 2.8v or something) that it's labelled as and see if that helps.
The fact that setting LPM first and then changing it to HPM resolves the
issue definitely suggests something weird going on with the rpmh and/or
that the voltage is too low.

Sorry I can't take this as-is, I'm totally fine with having regulator
support here but a hack like this definitely requires more
research/discussion.

Thanks,

fwiw I'd also very much like to get my hands on one of these devices...
We can talk about that off-list :P

> ---
>  drivers/ufs/ufs-qcom.c | 22 +++++++++++++++++++++-
>  drivers/ufs/ufs-qcom.h |  3 +++
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
> index dc40ee62daf..6c4599a6453 100644
> --- a/drivers/ufs/ufs-qcom.c
> +++ b/drivers/ufs/ufs-qcom.c
> @@ -16,6 +16,7 @@
>  #include <generic-phy.h>
>  #include <asm/gpio.h>
>  #include <interconnect.h>
> +#include <power/regulator.h>
>  
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
> @@ -557,10 +558,21 @@ static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_hba *hba, bool enable)
>  static int ufs_qcom_init(struct ufs_hba *hba)
>  {
>  	struct ufs_qcom_priv *priv = dev_get_priv(hba->dev);
> -	int err;
> +	int ret, err;
>  
>  	priv->hba = hba;
>  
> +	/* Set regulator to LPM mode first otherwise HPM does not get applied */
> +	ret = regulator_set_mode(priv->vcc, 1);
> +	ret = regulator_set_mode(priv->vcc, 3);
> +	ret = regulator_set_enable(priv->vcc, true);
> +	if (ret && ret != -ENOSYS)
> +		dev_warn(hba->dev, "failed to enable regulator vcc-supply:%d\n", ret);
> +
> +	ret = regulator_set_enable(priv->vccq, true);
> +	if (ret && ret != -ENOSYS)
> +		dev_warn(hba->dev, "failed to enable regulator vccq-supply:%d\n", ret);
> +
>  	/* setup clocks */
>  	ufs_qcom_setup_clocks(hba, true, PRE_CHANGE);
>  
> @@ -651,6 +663,14 @@ static int ufs_qcom_probe(struct udevice *dev)
>  		dev_err(dev, "Warning: cannot get reset GPIO\n");
>  	}
>  
> +	ret = device_get_supply_regulator(dev, "vcc-supply", &priv->vcc);
> +	if (ret)
> +		dev_warn(dev, "failed to get regulator vcc-supply:%d\n", ret);
> +
> +	ret = device_get_supply_regulator(dev, "vccq-supply", &priv->vccq);
> +	if (ret)
> +		dev_warn(dev, "failed to get regulator vccq-supply:%d\n", ret);
> +
>  	ret = ufshcd_probe(dev, &ufs_qcom_hba_ops);
>  	if (ret) {
>  		dev_err(dev, "ufshcd_probe() failed, ret:%d\n", ret);
> diff --git a/drivers/ufs/ufs-qcom.h b/drivers/ufs/ufs-qcom.h
> index de957ae60f3..4e502e7b3ca 100644
> --- a/drivers/ufs/ufs-qcom.h
> +++ b/drivers/ufs/ufs-qcom.h
> @@ -134,6 +134,9 @@ struct ufs_qcom_priv {
>  	struct clk_bulk clks;
>  	bool is_clks_enabled;
>  
> +	struct udevice *vcc;
> +	struct udevice *vccq;
> +
>  	struct ufs_hw_version hw_ver;
>  
>  	/* Reset control of HCI */
> 
> ---
> base-commit: 744cf5d4e398c5f657e5c3eeb44d00fa5175dc85
> change-id: 20260521-dpu-add-dspp-gc-driver-0c9ec8b0f127
> 
> Best regards,
> --  
> Federico Amedeo Izzo <federico@izzo.pro>
> 
> 

-- 
// Casey (she/her)

