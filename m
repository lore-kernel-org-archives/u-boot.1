Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD7DC0218B
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 15:26:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EE7080BA4;
	Fri, 24 Jan 2025 16:26:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737732370;
	bh=RWUakF+u+pqDMzIC3eJsguCD16j8x18UZSRRz1fJc1w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fcaUeRRI9Sc89MNMnfA4hnLZ1HMr1lTH2zi2bRotZJYI+RS9nrOrI8l1Rt0DQZjB2
	 CTH3SSXbSMz+dJIcarOyR+UTP7mbf9y9T4dpZtNmy2J6lk4/zNvLjnuB0jtpDUhxqb
	 H2HgerpnJJQmWAXOnER7r3W6UzhCBD/Z/N71ZTdSrr5x+JyLn5lLLtGufsY4jecEFs
	 gg9EyeawJ5EKFVhcXdfbDAnK4HcSH1AwlaQ4j0DfCButRb7qSL25WXkj+0zzm5I/cK
	 zwVjTPt1oS1fioe2c+t4T7GbRPNHV3EjnhgrU4cmqJyhLRhO6ybywWq9RolZu/YpKK
	 AXH/jGgqRIlkg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9788980BA4; Fri, 24 Jan 2025 16:26:09 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C5EA809D2
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 16:26:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="E5ly7/H6"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id ED7041048EF47; Fri, 24 Jan 2025 16:26:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737732367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RWUakF+u+pqDMzIC3eJsguCD16j8x18UZSRRz1fJc1w=;
 b=E5ly7/H6TpRvq7cmYKlGgMf5xewop1qhCJPqrRTIarg/Pj/lZcbbZkOjsrZSvPYndDs9Ny
 XiDC2PeHRbaoPhOh2TRq1wnWTSrvTbg1t/WHZPSIxEUmSjxT023UTVoZm6QpXU5QnEkZdm
 o2hMinxQMbNX0gZFoVsbh/GBbkaG0IQyPY7l0jYh+bC6lndEkhtXVUoIHPoCXxai8IeJBC
 fonczddstNmq7EMIwHUcZGrQSdJWYBlBrayXRdeIRI75sjj/OTLF2IEYAXgUtClHdzpzEq
 F8U5qMdmMjEbvHioQTEG/fwphDEn4sgATUDHQsIyWUqYKOTbj5gEqVZAtHHVsw==
Message-ID: <7ebf0d87-fb63-4524-9a1b-abdb6030d7ea@denx.de>
Date: Fri, 24 Jan 2025 11:58:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/20] mailbox: add i.MX95 Messaging Unit (MU) driver
To: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Alice Guo
 <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Viorel Suman <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-1-93b28a514dea@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250115-imx95-v1-1-93b28a514dea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/15/25 2:28 PM, Alice Guo wrote:

 > This id ported from Linux (v6.12.8) driver
 > drivers/mailbox/imx-mailbox.c.

'id' -> 'is' typo .

It is better to include the commit SHA from which this was ported over 
too, so the follow up patches in Linux can be easily ported over as they 
appear. If the last commit SHA from which this was ported over is known, 
then it is possible to do e.g. the following to find out any new commits:

linux$ git log 39d7d6177f0c..origin/master -- drivers/mailbox/imx-mailbox.c

"$ git log v6.12.8 -- drivers/mailbox/imx-mailbox.c" indicates this is 
the latest imx-mailbox.c commit in Linux 6.12.8:

39d7d6177f0c ("mailbox: imx: use device name in interrupt name")

[...]

> +#define IMX_MU_xSR_GIPn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(28 + (3 - (x))))
> +#define IMX_MU_xSR_RFn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
> +#define IMX_MU_xSR_TEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(20 + (3 - (x))))
> +
> +/* General Purpose Interrupt Enable */
> +#define IMX_MU_xCR_GIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(28 + (3 - (x))))
> +/* Receive Interrupt Enable */
> +#define IMX_MU_xCR_RIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
> +/* Transmit Interrupt Enable */
> +#define IMX_MU_xCR_TIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(20 + (3 - (x))))
> +/* General Purpose Interrupt Request */
> +#define IMX_MU_xCR_GIRn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(16 + (3 - (x))))
> +/* MU reset */
> +#define IMX_MU_xCR_RST(type)	(type & IMX_MU_V2 ? BIT(0) : BIT(5))
> +#define IMX_MU_xSR_RST(type)	(type & IMX_MU_V2 ? BIT(0) : BIT(7))

[...]

> +static const struct imx_mu_dcfg imx_mu_cfg_imx95 = {
> +	.tx	= imx_mu_generic_tx,
> +	.rxdb	= imx_mu_generic_rxdb,
> +	.init	= imx_mu_init_generic,
> +	.of_xlate = imx_mu_generic_of_xlate,
> +	.type	= IMX_MU_V2,
> +	.xTR	= 0x200,
> +	.xRR	= 0x280,
> +	.xSR	= {0xC, 0x118, 0x124, 0x12C},
> +	.xCR	= {0x8, 0x110, 0x114, 0x120, 0x128},
> +};
[...]

I would suggest these changes:

- Add the remaining SoC support, the plumbing is already there, all the
   conditional bits are already there for MU v1/v2 , so fill in the data
   for at least the V1 MU SoCs.

- Split this patch into separate submission or series, so it can get
   reviewed separately and land faster, possibly before the MX95 support
   gets fully sorted out.
