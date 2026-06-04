Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7339CCD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 14:53:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C16B0848A1;
	Thu,  4 Jun 2026 16:53:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="K4jzFHR5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4352848E2; Thu,  4 Jun 2026 16:53:16 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0E3D84879
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 16:53:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-490be03d47bso6879905e9.0
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 07:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780584793; x=1781189593; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HidTd4zfsVEmGU+IWMMZTIKZtcqJUScKG3FdfDG+R2E=;
 b=K4jzFHR5Lr29hMffhsTCB7J5krXiXkkFbY2kA6XSCzxOVgLl0HA5PmwS9ccrfVT6TO
 UvHnbgpo+fp7B4yCJtnkU/Ph6O2ih9GfEsC2TWyQOkn+lJKJdMx4njFzqdICZq9cDydk
 m6WrxbyhcocFFqQkPgFECNJdtZRHw8A/KCZrLGg8xCCdK7pXT36V6KxGMtlP2ceZAWd6
 M6UPeUJqzfcecEP6MiHD7urM56wV7wAMPMr5GnJpmw4dSYxTUn4Y3n4gllb6p2BhGM8r
 NDEgY6EKMap3sHXxRMz8h7EZllFZG59gbcrPxElfHBPxMqARjWTeikytdWqHInMKaTad
 n6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780584793; x=1781189593;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HidTd4zfsVEmGU+IWMMZTIKZtcqJUScKG3FdfDG+R2E=;
 b=W4ofrBOuz+7N8RnGRii05Bs2cYNmNUom99RI0RbK6xiGSOm+DJr7jxUnLhbMLgOGCc
 5hMkTbJGrPzpRQ4XwqRVIFmlAxLBrJbpJ1p2jgKb00FjGnigJperl31h5MXcmLkuDHvH
 kHrGWfh52NEadGDpDCrN0ksCClMc1E5nV6/xsopMkgxvBfEREAvcCkjjiuT1WjtpsHlN
 6QK25o5AF5dDqlbR/QJp25zOc4ACGBFnAsi096F4Q3uQuUB33wXsVpILJwTgo67PXMp1
 PcpXsYOZZn0VxygIBR5Xlyq+JIypq02D+0giT9CO0Pfa0KklvnqwM5/T8GnXoMT4Zy4C
 RvFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+PJgtdoY8tSzzlL5fE/jBQEyvxVdP9a5l1Kvj1KL3SuQRubjgKlvfEwvjeSU5OkTisbNMKCOk=@lists.denx.de
X-Gm-Message-State: AOJu0YzySHSY2tBKFbGPwx/Y9rAcBuuHRG9GiMajjU5h5vPwTBKdmwAO
 uETacgBk2s8SHPiNerh4IvsLmREVyFZBSwr69tz2WDIX9TpFJvYcMUUMxd0sHl3Dums=
X-Gm-Gg: Acq92OEyJmV2ySPF8tZ7ZhnoKlh8gJRmq+0JCbrLWzhwKGzTs0lGaLt6hF6OJacjGQB
 BLOIziPjOaBGcJ1O+9Qguqr7WPuQSVGIitqdA/2u8XoLQd0Gh3yp3GSu6/llnBLDRUxWTE+4O2X
 M6ZycT4Iz6URjNcUNroVjDljrfrb9E+mGPcKf5irKhgsB5t4pCPInc9CcrigkvsWtiPuZZjP1Vn
 MeDGBz6S5LBl2qhD9IxvDXo8cfaIUq0xJjK1E0FO8XwaU+iclN1Pv28ow4BvT5xdOy+JLekWrJg
 eKLEnosMwIz1liQxaUzJaruqXlmWJHVVGeaHS8Lbdhz2pwxNK26j8l2L5FZFFeUEk14326P/Zxb
 6PVB3NS9S7ZjHuK8Ig9l8PWtiRAQdFCfI9GgM/YqQ68WjP+TbA1xtI0oy0GVAMqeBe9G8RMUNVo
 n9IOgi5xTDioPtdYkE5ZQShizJfkf8X3InbGgONurfEicXhyCLvX1W/eSm7Ygb4rQPeUWfl8f7Y
 uRuapvngA==
X-Received: by 2002:a05:600c:a49:b0:490:b3e7:4614 with SMTP id
 5b1f17b1804b1-490b5e64ac8mr141790525e9.25.1780584793138; 
 Thu, 04 Jun 2026 07:53:13 -0700 (PDT)
Received: from ?IPV6:2a0e:c5c1:0:100:34f5:5b48:6fc0:9fd1?
 ([2a0e:c5c1:0:100:34f5:5b48:6fc0:9fd1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f35133csm17082506f8f.25.2026.06.04.07.53.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 07:53:12 -0700 (PDT)
Message-ID: <9508151e-3603-46ca-a3a2-212e8ba4bca5@linaro.org>
Date: Thu, 4 Jun 2026 16:53:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] power: pmic: qcom: convert ofnode API to dev_read
 API
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
 <20260604-devapi-v1-8-961aded05ff4@nxp.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260604-devapi-v1-8-961aded05ff4@nxp.com>
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
> Replace ofnode_read_u32_index(dev_ofnode(dev), ...) with
> dev_read_u32_index(dev, ...).
> 
> No functional change.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>   drivers/power/pmic/pmic_qcom.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/pmic/pmic_qcom.c b/drivers/power/pmic/pmic_qcom.c
> index 92d0a95859b..4b8dcc6104c 100644
> --- a/drivers/power/pmic/pmic_qcom.c
> +++ b/drivers/power/pmic/pmic_qcom.c
> @@ -72,7 +72,7 @@ static int pmic_qcom_probe(struct udevice *dev)
>   	 * contains two discrete values, not a single 64-bit address.
>   	 * The address is the first value.
>   	 */
> -	ret = ofnode_read_u32_index(dev_ofnode(dev), "reg", 0, &priv->usid);
> +	ret = dev_read_u32_index(dev, "reg", 0, &priv->usid);
>   	if (ret < 0)
>   		return -EINVAL;
>   
> 

