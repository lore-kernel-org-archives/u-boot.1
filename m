Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249E3C282C6
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 19:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 425AD81120;
	Fri, 28 Feb 2025 20:27:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740770850;
	bh=nqKJIwrT45h2NS+jSdxZpTSDTZmDvhryJa5pUhEX5u4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WbZVDgAyhLrCXK97ussHyZbHUNYghFxdXSYgN0pdDt4j99f+3u22SvwNA4nux3+BG
	 LS5UIbp1+FGDBauh0IkcOiOYOFB+kOK5BA5pvKaDV2cunIISIIYB8EsRSSH4O7uV8g
	 144tkIZW1WnSv0DR4NsL8v9aZn9pheeTDkdXY/6I4C1j5k/Uds1WsvKseI0/lkpf6k
	 bFkz4QNrMEQlh3f+CBcN6KBwaKH6gY4AKTaYWO8mgYWcgH/4esnbEJ+kbO0mpd+btl
	 bwfG9Lyjmmyu3VYwGbLVpI1vVdqOMFGLcuVVZTLsGXc853EL+2RC0OlLHRypqYKhqv
	 SJiGsgdAmfcQA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D74981219; Fri, 28 Feb 2025 20:27:28 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DF32811CE
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 20:27:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="OHmafKMI"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4DAA5102FD52C; Fri, 28 Feb 2025 20:27:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1740770845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nqKJIwrT45h2NS+jSdxZpTSDTZmDvhryJa5pUhEX5u4=;
 b=OHmafKMIgA83Ltu3djP8Rk6Sx74pBnGKAcNHHkoKGb7dAr2KK8gvQurvsl9BowxMDhDfMD
 Tr68Trb0bzb8URqLKn6zNYfU+xZB66v69hajc1vRP9E2iBulDMC6G4oaNerZvBQF4uWX4+
 ifws29U0Y1IIzK7P14buhZvR6X8lHI2z3QE8zdx47wLoWL3UBorm3vbpkHmOVBaNmViZKX
 MlXuiLeaOguSWOGFUNv5g73ssZ+V1Lc2u2fTqBbycE+lX40woc91ip/um3ZIDyfdldpXns
 OgVetYcNSu0zZWKE+lwRSMa62KXeqllzIlkycV0jubMQuThaJdfUZiM+jo/8YQ==
Message-ID: <3f6bb0fa-0526-411c-b519-5bf601cadd38@denx.de>
Date: Fri, 28 Feb 2025 20:17:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/20] firmware: scmi: add pin control protocol support
 to SCMI agent
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
 <20250228-imx95-v1-4-09594e93cc9b@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250228-imx95-v1-4-09594e93cc9b@oss.nxp.com>
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
> index 8c907c3b03..5f101f4ede 100644
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
This really shouldn't be in common code, see my previous comment on V4 .
