Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC3BC282D0
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 19:27:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC137810FE;
	Fri, 28 Feb 2025 20:27:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740770847;
	bh=og6qW34HZuWq1hs0siZWFHWj3U7ZMFEAj5W8UYwTZqc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xhRrnQVDlqjCA8yOOOHJYMfKNn/HvNh2TcdHNMfaK6pPsChWZTtrJBL0TfuyOcvLz
	 v44jMRKi9hiG2RSf/v3kFHIy7ZSQhf8VBBgwzMkykt9/dBLyRxEEcp1XOxaqNYceTn
	 26zhl89afjH9K1iZ9S1+vnDMyemGKIwNS4hdOFloteX5KBV8SIGcHKtIBeScMEs7hU
	 IAfIz4RcyDsjEUGsCR3yrOLOVGQCyM9Uke0m0VEp2IWuV4SGWFs1P5MOHx6ou88t49
	 54MceUZewduyH4DjexIxW3QiEqWhnwgMfwh8r3HU4TxkhtNCSErErWhkdtNb5UctnI
	 joaG5xOMp2sdw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 897AC810FE; Fri, 28 Feb 2025 20:27:26 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E3D481113
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 20:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="cyg4Wcb1"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 61A4B1034EACF; Fri, 28 Feb 2025 20:27:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740770843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=og6qW34HZuWq1hs0siZWFHWj3U7ZMFEAj5W8UYwTZqc=;
 b=cyg4Wcb1ijZ65gNCkFEq7uqzvO9j+ZkxlZq6qwk+B9NX+SPfORlgp4nNsI/Tij5rG+XkN6
 8/OYPlxWuEY+ciSs4WmI5NITY/O/N2edim/RqV3NhLK4msmzLcZL1dj1coCKBvHZ6dneKO
 WZ52qcd1b395rGWpXp7TOpveS5WcIvFkMuUPPxRnp1EviPjoRk2b47GpZzDoDE7+zDBQ/d
 N3J/ALpYDyJx9woALpSpiZQ6V8802150RYCrzTDnKNeqXf+w8ulZkPwNwLwNVBTdu39Zse
 cPA/lxkbOmHxWTDWeKDdWrTPP598CAUIPP0uIA76ih2wfJolFBzAJYzLTgr/mg==
Message-ID: <5d0f1b3c-02ec-416d-b566-2cc8f44576df@denx.de>
Date: Fri, 28 Feb 2025 20:16:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/20] pinctrl: nxp: add a pin controller driver based
 on SCMI pin control protocol
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Ranjani Vaidyanathan
 <Ranjani.Vaidyanathan@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
 <20250228-imx95-v1-3-09594e93cc9b@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250228-imx95-v1-3-09594e93cc9b@oss.nxp.com>
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

On 2/28/25 11:53 AM, Alice Guo (OSS) wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> This patch provides a pinctrl driver based on SCMI pin control protocol.
> Currently, only the PINCTRL_CONFIG_SET command is implemented.

This can also be a separate patch and go in separately , right ?

If so, send this as separate patch.

[...]

> diff --git a/drivers/pinctrl/nxp/pinctrl-scmi.c b/drivers/pinctrl/nxp/pinctrl-scmi.c
> new file mode 100644
> index 0000000000..4a791b7e95
> --- /dev/null
> +++ b/drivers/pinctrl/nxp/pinctrl-scmi.c
> @@ -0,0 +1,143 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#include <asm/io.h>
> +#include <asm/mach-imx/sys_proto.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <dm/pinctrl.h>
> +#include <scmi_agent.h>
> +#include <scmi_protocols.h>
> +
> +#include "pinctrl-imx.h"
> +
> +#define DAISY_OFFSET_IMX93	0x360
> +#define DAISY_OFFSET_IMX95	0x408
> +
> +/* SCMI pin control types */
> +#define PINCTRL_TYPE_MUX        192
> +#define PINCTRL_TYPE_CONFIG     193
> +#define PINCTRL_TYPE_DAISY_ID   194
> +#define PINCTRL_TYPE_DAISY_CFG  195
> +#define PINCTRL_NUM_CFGS_SHIFT  2
> +
> +struct imx_scmi_pinctrl_priv {
> +	u16		daisy_offset;
> +};
> +
> +static int imx_pinconf_scmi_set(struct udevice *dev, u32 mux_ofs, u32 mux, u32 config_val,
> +				u32 input_ofs, u32 input_val)
> +{
> +	struct imx_scmi_pinctrl_priv *priv = dev_get_priv(dev);
> +	int ret, num_cfgs = 0;
> +	struct scmi_msg msg;
> +
> +	/* Call SCMI API to set the pin mux and configuration. */
> +	struct scmi_pinctrl_config_set_out out;
> +	struct scmi_pinctrl_config_set_in in = {
> +		.identifier = mux_ofs / 4,
> +		.function_id = 0xFFFFFFFF,
> +		.attributes = 0,
> +	};
> +
> +	if (mux_ofs != 0) {

if (mux) { ... } is enough, the !=0 is unnecessary.

> +		in.configs[num_cfgs].type = PINCTRL_TYPE_MUX;
> +		in.configs[num_cfgs].val = mux;
> +		num_cfgs++;
> +	}
> +
> +	if (config_val != 0) {

DTTO

> +		in.configs[num_cfgs].type = PINCTRL_TYPE_CONFIG;
> +		in.configs[num_cfgs].val = config_val;
> +		num_cfgs++;
> +	}
> +
> +	if (input_ofs != 0) {

DTTO

> +		in.configs[num_cfgs].type = PINCTRL_TYPE_DAISY_ID;
> +		in.configs[num_cfgs].val = (input_ofs -  priv->daisy_offset) / 4;
> +		num_cfgs++;
> +		in.configs[num_cfgs].type = PINCTRL_TYPE_DAISY_CFG;
> +		in.configs[num_cfgs].val = input_val;
> +		num_cfgs++;
> +	}
> +
> +	/* Update the number of configs sent in this call. */
> +	in.attributes = num_cfgs << PINCTRL_NUM_CFGS_SHIFT;
> +
> +	msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_PINCTRL,
> +			  SCMI_MSG_PINCTRL_CONFIG_SET, in, out);
> +
> +	ret = devm_scmi_process_msg(dev, &msg);
> +	if (ret || out.status != 0) {
> +		dev_err(dev, "Failed to set PAD = %d, daisy = %d, scmi_err = %d, ret = %d\n",
> +			mux_ofs / 4, input_ofs / 4, out.status, ret);
> +	}
> +
> +	return ret;

[...]

> diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
> index 7abb2a6f36..279ebbad44 100644
> --- a/include/scmi_protocols.h
> +++ b/include/scmi_protocols.h
> @@ -24,6 +24,7 @@ enum scmi_std_protocol {
>   	SCMI_PROTOCOL_ID_SENSOR = 0x15,
>   	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
>   	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
> +	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
This is the custom iMX specific pinctrl protocol, isn't it ?

Can you rename it to some SCMI_PROTOCOL_ID_NXP_IMX9_PINCTRL to make it 
clear this is custom protocol ?
