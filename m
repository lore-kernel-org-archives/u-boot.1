Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDC8C0218B
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 15:26:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63EF180AE3;
	Fri, 24 Jan 2025 16:26:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737732378;
	bh=139I7uErC3dMoGjgKZkrnT0Os/p84pkXWHp29//ZlzE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aTvpAQ2kjoV9bmjwriOM7pmhbinyJbW08CuKYOHBVtAEsJhLkO3+7W1efqMygz+iG
	 t42AL8Ouj+2zBaQ8nzg69fS1EHjvdMpM2ceXxfXqcnpgnWKfuAK0ASRJ7vuTkGajLD
	 iihMlVwGNw9y1CCYo1k7JemNrNtcBaExya7GecrCpNPiv4XAskbQZZD3KFJON33tQ3
	 rKM124kFvWnJO/rKHis4iGX48P0XqBL3gb+8pGZ81MFS0/UhYT8t61u8s1yEB/FU5O
	 awOKemiCa/g0EqThrIvEMSevMKSv82r80kkB4xPrBKWWf2bN3gRW8Y6mR8bQLVAWLe
	 eGrs8tEywJ+HA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39A86809D2; Fri, 24 Jan 2025 16:26:17 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38D46809D2
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 16:26:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="f93U9Yin"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 262B4108873CC; Fri, 24 Jan 2025 16:26:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737732374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=139I7uErC3dMoGjgKZkrnT0Os/p84pkXWHp29//ZlzE=;
 b=f93U9YinvoN+a55L82n1Llq22OlKGvJrw/vxLc2kpLCgsS/WzsiGTHHBdT8vAgYuAI3caD
 dMjiJkmSTTpIJiTiWVhSbdd8p2wSreO/bX5iJMT3QLSOqgd3jM6Ojl3THDi8tIzyo4y6yK
 sO36ywBYkjsu9c848v9SNCKcIcTxDKl+EedlyQX9d8ezLWnRIUZnltXRtWAl9EOwS9oZ9u
 Xmrt0ZS2vpd/dz1pj/zfbHpKaU6I7qE/DDbaJivYHTv974EJB1PPD0lysDfZmCLB48N2T/
 pFg2rXFluyCtE7PrddDpLlfxCa+ENg2uL070gfLp1kq66g//BvcGaeUKJPs8WQ==
Message-ID: <9859d7f3-95ed-40b4-9140-f86638b0e522@denx.de>
Date: Fri, 24 Jan 2025 14:55:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/20] firmware: scmi: add pin control protocol support
 to SCMI agent
To: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Alice Guo <alice.guo@nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-4-93b28a514dea@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250115-imx95-v1-4-93b28a514dea@oss.nxp.com>
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
> From: Alice Guo <alice.guo@nxp.com>
> 
> This patch adds SCMI pin control protocol support so that the pin
> controller driver based on SCMI, such as
> drivers/pinctrl/nxp/pinctrl-scmi.c, can be bound to the SCMI agent
> device whose protocol id is 0x19.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>   drivers/firmware/scmi/scmi_agent-uclass.c | 11 +++++++++++
>   include/scmi_agent-uclass.h               |  2 ++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
> index 8c907c3b0328095c4b35ba089ed608fcda48b567..5f101f4ede8b585f8c562a42886ea7be4ef09953 100644
> --- a/drivers/firmware/scmi/scmi_agent-uclass.c
> +++ b/drivers/firmware/scmi/scmi_agent-uclass.c
> @@ -97,6 +97,9 @@ struct udevice *scmi_get_protocol(struct udevice *dev,
>   	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
>   		proto = priv->voltagedom_dev;
>   		break;
> +	case SCMI_PROTOCOL_ID_PINCTRL:
> +		proto = priv->pinctrl_dev;
> +		break;
>   	default:
>   		dev_err(dev, "Protocol not supported\n");
>   		proto = NULL;
> @@ -147,6 +150,9 @@ static int scmi_add_protocol(struct udevice *dev,
>   	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
>   		priv->voltagedom_dev = proto;
>   		break;
> +	case SCMI_PROTOCOL_ID_PINCTRL:
> +		priv->pinctrl_dev = proto;
> +		break;
>   	default:
>   		dev_err(dev, "Protocol not supported\n");
>   		return -EPROTO;
> @@ -436,6 +442,11 @@ static int scmi_bind_protocols(struct udevice *dev)
>   				drv = DM_DRIVER_GET(scmi_voltage_domain);
>   			}
>   			break;
> +		case SCMI_PROTOCOL_ID_PINCTRL:
> +			if (IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI) &&

Is this pinctrl protocol really imx specific ?

If not, this needs to use some other config option to gate access to it.
