Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F570C36001
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 02:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1804581C64;
	Sat, 22 Mar 2025 03:49:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742611796;
	bh=kofPsDztY38na3QVsWtWF5B3XwJ6n5a6etGsio60nKc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RY6/hvmfI317Sd7SWV2/HGs08Jiatr9SI8CuGVWuW29d7XlpBJt+RoTN2jiFOhZte
	 AUjVZIcE16aYo3sjgAfjHTMRDiLEe9fRVZmNxvxWtBwK1qAMITVCtJMJQhZntsEcm5
	 z+afz9G170LZ0QCrxFb4wrVKf/llKkJVGajh/NH8N8RDUdMERTT/HmQWIrIPQIHD1E
	 QL4l9l87PQSxbMEHm5Vk0qVEiSqD5Z+EFLjYEmITkbT2zXQMllGCH5NVbNZ4KGv/7P
	 3dvx+q5kSVznM200LktZ/IbbQrWTXgF5PIMkTEcqOm2Q3PAHz/+DJU57C1QwD5ersC
	 +IA5+4vKfWOFg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B64F81A0E; Sat, 22 Mar 2025 03:49:53 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B18B4806FC
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 03:49:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Oa2d6qv7"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AC8DE101E8FF1; Sat, 22 Mar 2025 03:49:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742611790; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=kofPsDztY38na3QVsWtWF5B3XwJ6n5a6etGsio60nKc=;
 b=Oa2d6qv7dExE/2g14y7/jcY7FYEEWRoi9AsB2Tasn6AdXlhHpU4xy9eRkHD52TSbV3zvpa
 dyEGk4JaTqmnN6WEGvFeQv4rGXnRhaKZDnN+nPCPzYz5iiqlzKY6C12Sx+VHlesV7tRtmo
 gv3eyHvzGZCVu8yvDipf3bk7mOJRr79lN2SjhnL/Ej1k2wet39U2H5GMrRw2TKq1K9nemp
 IJrjq9VgQXAb1pD4VBCZ26e2ZzjQvMuLhG00BKre7m/PEA2GVNWQwe8r3uzqzeMCsndb4g
 qJKKaKukkgFNHyp0l3euQzIo1gIBRkVAJEJqVKz2vFK0wfIMYmqSOj7V+3oaMg==
Message-ID: <a180b7e6-6978-4814-97ff-05e34223938f@denx.de>
Date: Sat, 22 Mar 2025 01:46:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/19] pinctrl: nxp: add a pin controller driver based
 on SCMI pin control protocol
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, =?UTF-8?Q?Lothar_Wa=C3=9Fmann?=
 <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de, Ranjani Vaidyanathan
 <Ranjani.Vaidyanathan@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
 <20250321-imx95-v1-2-f2c8ba815f89@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250321-imx95-v1-2-f2c8ba815f89@oss.nxp.com>
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

> +static int imx_scmi_pinctrl_probe(struct udevice *dev)
> +{
> +	struct imx_scmi_pinctrl_priv *priv = dev_get_priv(dev);
> +
> +	priv->daisy_offset = is_imx93() ? DAISY_OFFSET_IMX93 : DAISY_OFFSET_IMX95;
> +
> +	return devm_scmi_of_get_channel(dev);
> +}
> +
> +static int imx_scmi_pinctrl_bind(struct udevice *dev)
> +{
> +	if (IS_ENABLED(CONFIG_IMX95))
> +		return 0;

Why does this driver support iMX93 , but it is explicitly not going to 
bind on iMX93 ?

In case the MX93 support is going to be added, you probably need 
something like:

if (IS_ENABLED(CONFIG_IMX95) && is_imx95())
   return 0;

Because IS_ENABLED(CONFIG_IMX95) does not automatically imply that this 
code is started on MX95 , that is when is_imx95() comes into play and 
does runtime check for MX95 .

> +	return -ENODEV;
> +}
> +
> +U_BOOT_DRIVER(scmi_pinctrl_imx) = {
> +	.name = "scmi_pinctrl_imx",
> +	.id = UCLASS_PINCTRL,
> +	.bind = imx_scmi_pinctrl_bind,
> +	.probe = imx_scmi_pinctrl_probe,
> +	.priv_auto = sizeof(struct imx_scmi_pinctrl_priv),
> +	.ops = &imx_scmi_pinctrl_ops,
> +	.flags = DM_FLAG_PRE_RELOC,
> +};
> diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
> index 7abb2a6f36b..279ebbad440 100644
> --- a/include/scmi_protocols.h
> +++ b/include/scmi_protocols.h
> @@ -24,6 +24,7 @@ enum scmi_std_protocol {
>   	SCMI_PROTOCOL_ID_SENSOR = 0x15,
>   	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
>   	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
> +	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
If this is the IMX specific pinctrl protocol, please make sure to name 
it accordingly , SCMI_PROTOCOL_ID_PINCTRL_IMX or something .
