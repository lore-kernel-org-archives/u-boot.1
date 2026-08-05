Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E686C55174
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 03:41:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6DA5280D45;
	Wed,  5 Aug 2026 03:41:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AlPpSEYUv_IH; Wed,  5 Aug 2026 03:41:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 185DB80D3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785901265;
	bh=GlfXy2SairRAw5Err9eilB6wgS8Jwn4VY29D6vbFR8I=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=JR7sE6Yri5X1dG5eB2mk3Yirupc8VPyl83mM4VeJberikUutOOE5+2jzL6gybi8lK
	 3M97m6p13BcIMY8euQ7BoGkAJj6Y13Qq4lvw1hQU2ZWcn6rZZOxRfOdZA+n/q3L9n+
	 rK3S9TTjSFJIaxkX9c4bKVqneNfy5MoSMFB4qDHH8kACrnRvGv8+rShevFYIAjJAgf
	 WixX6ccHSa15tryXrO5hTYoNwUizxDenGKnugItaOcwwqUtltZ5TLrA7HfiEjlGBJO
	 tWzJr/QoiXFyQTFq6sGpOUt8LZF2oCRHeqbWV9WT3GNzZmGFTohEu0BIQ3OPXDyFi9
	 fDp/6gCKbcqDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 185DB80D3D;
	Wed,  5 Aug 2026 03:41:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 06540270
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 03:41:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DA691400D7
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 03:41:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sJH-FKfpa5Vs for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 03:41:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 76879400CE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 76879400CE
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 76879400CE
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 03:41:01 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hFGQx4DlhzMlHB;
 Wed, 05 Aug 2026 05:40:57 +0200 (CEST)
Message-ID: <d1843b10-df7c-4f65-ac1f-0c2f5c6cbe3d@mailbox.org>
Date: Wed, 5 Aug 2026 04:37:57 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v5] usb: mtu3: support the upstream devicetree binding
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
References: <20260804-ccaione-upstream-mtu3-spl-gadget-v5-1-5c3b6ec44eb5@baylibre.com>
Content-Language: en-US
In-Reply-To: <20260804-ccaione-upstream-mtu3-spl-gadget-v5-1-5c3b6ec44eb5@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: ae15075b7cf43316e7a
X-MBO-RS-META: f6yx5tdpuec7igxauq5sq1ztxo3izukw
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785901257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GlfXy2SairRAw5Err9eilB6wgS8Jwn4VY29D6vbFR8I=;
 b=jVG5Avx87Q3J74k4cd6HmLXbRWAodBG65Bh2/0PVF8/+IUVXie/pfOCSVAOP8AUPfh2XnK
 pi7QKq1dpdKy3gE3NEveVrJjRDZcsUHV/GOMq8Q0olFk9to5gDPtYdZuAgEs/VIwNe5X3j
 SCEwxUOb4HUx2Wy3aDI2GU/ZtSDKCL2QHYY3G6bHhJmmy1tTIr6M/nSknNJU3eVnMUIiQa
 RYT9jws7moC67yLfl8/LI4wauGii8VGQOM6nIkq5Js5aVSCEYJaben43qyCDv7K78KfoDk
 2jVQAnnkzaQ3l0+Yg3X727A+FZVIuQo0NFmOIp+F7/5J6TbNbsBccHrDyy39Cw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=jVG5Avx8
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/4/26 12:05 PM, Carlo Caione wrote:

[...]

> +++ b/doc/device-tree-bindings/usb/mediatek,mtu3.txt

You could easily swap in Linux 
Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml and 
Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml instead , 
and drop the mtu3.txt . But please do replace the binding documents in a 
separate patch.

[...]

> +++ b/drivers/usb/mtu3/Kconfig
> @@ -22,6 +22,7 @@ choice
>   config USB_MTU3_HOST
>   	bool "Host only mode"
>   	depends on USB_XHCI_HCD
> +	select SPL_OF_TRANSLATE if SPL_USB_HOST

Don't you need SPL variants of the MTU3 controller Kconfig symbols instead ?

>   	help
>   	  Select this when you want to use MTU3 in host mode only,
>   	  thereby the gadget feature will be regressed.

[...]

> +static int mtu3_bind_gadget(struct udevice *parent)
> +{
> +	struct udevice *dev;
> +	int ret;
> +
> +	/* Node-less device: name it after the controller for diagnostics. */
> +	ret = device_bind_driver(parent, "mtu3-peripheral",
> +				 ofnode_get_name(dev_ofnode(parent)), &dev);
> +	if (ret)
> +		dev_err(parent, "failed to bind peripheral mode\n");

Please also include the value of "ret" in printed error strings, it 
helps identify the issue faster. Please fix this for all such cases in 
this patch.

> +	return ret;
> +}
[...]

The rest looks good, thanks !
