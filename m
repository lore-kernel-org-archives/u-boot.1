Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B1BC36001
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 02:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C81D81D1F;
	Sat, 22 Mar 2025 03:49:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742611797;
	bh=aiVEF+vey24abTyNmhCTg4LpxrV/QcAFwY4+f7SSh44=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KyB3gAkxoj4mzkweEDfuRCaJlxb2A+TYm0+DBeYhxVpkPo5umF76kS+skIeW3glS2
	 ztCXJ3vXCfuUwnbFomqNBYVW+xH+031da7+R0DP7s1v9VCqDVT65V/gZuFM2UqLN3F
	 6z0cGhw99yux/xYgb4+b6nTYN6T1WPfrzL+kQjnAK3lI7EI5TkpGLYBm42nC2CEsz3
	 JTjLAm0g86wU5lSynfwClW+085p+cVDjSwwCH5ZEk2kLq0tPSBJAdi7+5DbcrJ4v1p
	 5tXVCI8VfIp8aWgFUyw4fS2uoXxEPXGm4/Z+eNmW6kh7VmD9VCerCKRPm81Xf22Dkm
	 agPZJiuNVqtgA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49F8D806FC; Sat, 22 Mar 2025 03:49:54 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37A67810FE
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 03:49:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Vdl3hYsd"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7B75C101E8F47; Sat, 22 Mar 2025 03:49:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742611791; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=aiVEF+vey24abTyNmhCTg4LpxrV/QcAFwY4+f7SSh44=;
 b=Vdl3hYsdzS+MvJp3jTp4UychWBRpzFkA+BeBdPDyBHH3pjkEddPJcYUvv33Au4U56aPInQ
 S86/p3Yrkx8NUCSD6iKMg5Z9Iankb3MaziwR1zGPic+CviHX/rKQxZ1Q44HEP4akbngnuI
 bePrVkAGkkhpOfCZsXJwNMb5rA/AlfThYEuA04Ot2InSA5cfzp20oeUCRNrrVZYquLE/Di
 04BoY3SQirPOQaD4UFSFNlyCSmPPTcC5B+bedEZXGeGX5slC03SvsF9EYWbZTzy+LuJ965
 XpMigIcX5pvXvY1NekUvja44Hkv0sbNAal+Y1Ja1zxKf8FR5hvBdtM3+8Xv3Ww==
Message-ID: <7d6af7b9-ad5b-46aa-9116-ce9b3ce1cf13@denx.de>
Date: Sat, 22 Mar 2025 02:55:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/19] firmware: scmi_agent: add SCMI pin control
 protocol support
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, =?UTF-8?Q?Lothar_Wa=C3=9Fmann?=
 <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
 <20250321-imx95-v1-3-f2c8ba815f89@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250321-imx95-v1-3-f2c8ba815f89@oss.nxp.com>
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

On 3/21/25 8:15 AM, Alice Guo (OSS) wrote:
[...]

> @@ -352,6 +358,22 @@ static int scmi_fill_base_info(struct udevice *agent, struct udevice *dev)
>   	return 0;
>   }
>   
> +static struct driver *scmi_proto_driver_get(unsigned int proto_id)
> +{
> +	struct scmi_proto_driver *start, *entry;
> +	int n_ents;
> +
> +	start = ll_entry_start(struct scmi_proto_driver, scmi_proto_driver);
> +	n_ents = ll_entry_count(struct scmi_proto_driver, scmi_proto_driver);
> +
> +	for (entry = start; entry != start + n_ents; entry++) {
> +		if (entry->match->proto_id == proto_id)
> +			return entry->driver;
> +	}
> +
> +	return NULL;
> +}

Ideally, the addition of core code like scmi_proto_driver_get() should 
be a separate preparatory patch.

Please also make sure to convert the four SCMI protocol drivers to 
U_BOOT_SCMI_PROTO_DRIVER() , otherwise the code become inconsistent. 
That should be easy, since there are literally four SCMI protocol drivers.

>   /*
>    * SCMI agent devices binds devices of various uclasses depending on
>    * the FDT description. scmi_bind_protocol() is a generic bind sequence
> @@ -436,6 +458,9 @@ static int scmi_bind_protocols(struct udevice *dev)
>   				drv = DM_DRIVER_GET(scmi_voltage_domain);
>   			}
>   			break;
> +		case SCMI_PROTOCOL_ID_PINCTRL:
> +			drv = scmi_proto_driver_get(SCMI_PROTOCOL_ID_PINCTRL);

Please have a look at patch I just sent and give it a try:

[PATCH] power: regulator: scmi: Move regulator subnode hack to 
scmi_regulator

With that and the conversion above in place, you should be able to 
entirely eliminate this switch-case code and make use of the full 
potential of your newly added scmi_proto_driver_get(), this way:

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c 
b/drivers/firmware/scmi/scmi_agent-uclass.c
index 09a25d0067c..98e0c4d7c93 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -431,34 +431,10 @@ static int scmi_bind_protocols(struct udevice *dev)

  		drv = NULL;
  		name = ofnode_get_name(node);
-		switch (protocol_id) {
-		case SCMI_PROTOCOL_ID_POWER_DOMAIN:
-			if (CONFIG_IS_ENABLED(SCMI_POWER_DOMAIN) &&
-			    scmi_protocol_is_supported(dev, protocol_id))
-				drv = DM_DRIVER_GET(scmi_power_domain);
-			break;
-		case SCMI_PROTOCOL_ID_CLOCK:
-			if (CONFIG_IS_ENABLED(CLK_SCMI) &&
-			    scmi_protocol_is_supported(dev, protocol_id))
-				drv = DM_DRIVER_GET(scmi_clock);
-			break;
-		case SCMI_PROTOCOL_ID_RESET_DOMAIN:
-			if (IS_ENABLED(CONFIG_RESET_SCMI) &&
-			    scmi_protocol_is_supported(dev, protocol_id))
-				drv = DM_DRIVER_GET(scmi_reset_domain);
-			break;
-		case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
-			if (IS_ENABLED(CONFIG_DM_REGULATOR_SCMI) &&
-			    scmi_protocol_is_supported(dev, protocol_id))
-				drv = DM_DRIVER_GET(scmi_voltage_domain);
-			break;
-		case SCMI_PROTOCOL_ID_PINCTRL:
-			drv = scmi_proto_driver_get(SCMI_PROTOCOL_ID_PINCTRL);
-			break;
-		default:
-			break;
-		}
+		if (!scmi_protocol_is_supported(dev, protocol_id))
+			continue;

+		drv = scmi_proto_driver_get(protocol_id);
  		if (!drv) {
  			dev_dbg(dev, "Ignore unsupported SCMI protocol %#x\n",
  				protocol_id);

> +			break;
>   		default:
>   			break;
>   		}
> diff --git a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
> index 0ed971369a3..dbd6ff437e5 100644
> --- a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
> +++ b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
> @@ -9,6 +9,7 @@
>   #include <dm/device_compat.h>
>   #include <dm/pinctrl.h>
>   #include <scmi_agent.h>
> +#include <scmi_agent-uclass.h>
>   #include <scmi_protocols.h>
>   
>   #include "pinctrl-imx.h"
> @@ -150,3 +151,9 @@ U_BOOT_DRIVER(scmi_pinctrl_imx) = {
>   	.ops = &imx_scmi_pinctrl_ops,
>   	.flags = DM_FLAG_PRE_RELOC,
>   };
> +
> +static struct scmi_proto_match match = {
> +	.proto_id = SCMI_PROTOCOL_ID_PINCTRL,
> +};


This should be a zero terminated array I think ?

static struct scmi_proto_match match[] = {
   { SCMI_PROTOCOL_ID_PINCTRL },
   { /* Sentinel */ }
};

[...]
