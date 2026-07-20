Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B09C44515
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 23:47:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8173780D92;
	Mon, 20 Jul 2026 23:47:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MS5jAGJSLNKJ; Mon, 20 Jul 2026 23:47:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 75CB780D6A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784591278;
	bh=Kia1PeMIdnwGm/rGAloo+avz3gUHW3j6C633xX/QZ7c=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=beCk5ZLkaWy+YyvXnk2Fa10mT80b0lJ/zl8FHwmclcttF0vpCbERVcQoOpsQYZA2n
	 rvFGs3z3vP+D5NyoT2A4zb//+RH0SBOcM+nQ1LsFTnmnY0ktn3bT6c7jtDyDXhTIT2
	 Itz3QTp8TZCngOFpWhjfTJeQl8WnMtO4Nnof3P96iz1GjhSskpMBP07KOCCtFohYL9
	 i8WvARkyhgSSR7B/vlEhVw6nlDeYx2G7XFMEHQkZnUSDG/ctlq7C5kdvLR3trPSFbp
	 Ljr4oRxsk9JhPfFQb0ltMqB16so2aigTtQ83DAdYCnZaGe87YhmCxjRd2Dw7JvlMAv
	 5ZEVebs3/Sqhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 75CB780D6A;
	Mon, 20 Jul 2026 23:47:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 37EE4313
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 23:47:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1593B60704
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 23:47:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dI4PtSg7W_th for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 23:47:56 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 8F1AE60624
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8F1AE60624
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8F1AE60624
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 23:47:54 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F4CD844F6; Tue, 21 Jul 2026 01:47:51 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0DD582991
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 01:47:48 +0200 (CEST)
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6a3d915616fso1476498eaf.2
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 16:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784591267; x=1785196067;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kia1PeMIdnwGm/rGAloo+avz3gUHW3j6C633xX/QZ7c=;
 b=l+qRW4FEpquvAotAdP/FlrxKe0j6bzRvanveGGXxTedSUIhf14TmjDm2IN78CkX1NM
 fVKyF0yEvF3F7QjeaUYuZVIAGe+0N5OYLBBh1yT7bvb9X061Vv6im1YJZFt7GDziFHOw
 vpURU+kYu1CoNhpjkVJx46Nv1DbcZB9o/UjdAo0ic1IfO+uc6lMPij2zWP1zPwBNT2w1
 hMu8y25DlIvCKY1xhvbil9E7ziQoIo2E9FbvGLwbPLjm25Wn6IAtdr/GTPzGp+Fw+zvq
 RF1iY7xLygbH9AIE6lCanzDE1HRSniyyzy/b+mVCPMe2fbBQckgmYhSnDDZKTYVYHx+r
 UE8w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrg1ZOmo1O3c1EMKQl1jd9AiH3vQ3ePhpp+WVeY88iR2OS1z94Xq7GXOhahVkfLgzHtS0rYQwQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyuK502F/0ZnpFW6jHEiQrT6jiTTdmXzXHjWIeBoB8VZBSQCWRC
 v3299h+KlwEDV3FUOyOou5dLhfiNqJCBdgRLXJmX3lItZG/u7sX1Rpdb6toiRaG9mFg=
X-Gm-Gg: AfdE7cnrD2U/5VY/RUxZ9RQvQ7SAmC8yUgSbHqu4KGDGAkxboKWfjgK8brssf6DH5qU
 aa6RewJRnfoH2Ywh705BwtYwk1WWbZ0Qkr2tQNF3AymrfhPznOfmnFYBY2jka/tS4M4Ug/ltYsS
 CKU1d7P9iSDoAFRXW9ObYls5BVgznGUrADFvbxfPgkVidLKElRs0P1rlKoSRMVOIGl2V/xaLB2I
 7uyvgNm9oFNMXxNY6ysqRgWmv28VQ8gMqHY73HP3EZkf67EW7CHz5nAkloTDEmcWsh2RU57WTUV
 j2xdFmFNuddpa1hFj1MCIn4l9QLts+AGBZV5Su9oFRyjVnVLf4qHhx6lnGFJWR4BqMUz+JfTems
 dix8cVAdanXyO69sO0hrTB2N4cSu0Nclum8Dhb2jbOiZlCfrFMY4Oo/l6/gV7/EJEnJi11znFG4
 ox22LyBWdZ6TbgmeT6glJd7mhnzxsj3d63MROt7CJCNxKIQf/kZCkk
X-Received: by 2002:a05:6820:2910:b0:6a3:2368:4cc5 with SMTP id
 006d021491bc7-6a536863bffmr7066125eaf.35.1784591267400; 
 Mon, 20 Jul 2026 16:47:47 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:8ce6:b98e:1126:f7f0?
 ([2600:8803:e7e4:500:8ce6:b98e:1126:f7f0])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a516c03f36sm9379343eaf.7.2026.07.20.16.47.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 16:47:45 -0700 (PDT)
Message-ID: <ec3f60c9-4088-4767-a262-18453eb3c719@baylibre.com>
Date: Mon, 20 Jul 2026 18:47:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: mtu3: support the current devicetree binding
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
References: <20260720-ccaione-upstream-mtu3-spl-gadget-v3-1-91cff44b1622@baylibre.com>
Content-Language: en-US
In-Reply-To: <20260720-ccaione-upstream-mtu3-spl-gadget-v3-1-91cff44b1622@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784591267; x=1785196067; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Kia1PeMIdnwGm/rGAloo+avz3gUHW3j6C633xX/QZ7c=;
 b=cLACvV7Alznji5XGPN2sDw9um+mvVL31Jd6AAIpvvSOTrLBU+CLgFG2iPDk/FX706k
 czOMl2raxmQf5xPCU1UtQyn/0WikaFJXHljBW09XuuzVKCUQtKCTsWLkbjiz67b13/fy
 M2XL5QR0RNahvN6PHNUsXMUfRELQ/G+PthMtnaPwxysuo1dkm7Zt6V7nJv881mnH6AdL
 RHWMrXbosCxP3vpwGXCwm1EJ1jtzlD9ntXF45j9lrz6fe2Ab7mK5e+hBfCrptHM16a6O
 6oIUO5gvq6boe5VCnHupsS4Ku2eRLV/d6cg/4NwOK8alG3e3mMx/sMDCtW8SNgyiBs2Q
 K3wg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=cLACvV7A
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dlechner@baylibre.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=baylibre.com header.i=@baylibre.com header.b="cLACvV7A"; 
 dkim-atps=neutral
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
From: David Lechner via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: David Lechner <dlechner@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/20/26 2:53 AM, Carlo Caione wrote:
> The MTU3 glue driver requires the legacy U-Boot layout, where a synthetic
> mediatek,ssusb child owns the gadget resources and dr_mode:
> 
>     usb@112b0000 {
>         compatible = "mediatek,mt8188-mtu3", "mediatek,mtu3";
> 
>         ssusb@112b0000 {
>             compatible = "mediatek,ssusb";
>             reg = <0 0x112b0000 0 0x3e00>,
>                   <0 0x112b3e00 0 0x0100>;
>             reg-names = "mac", "ippc";
>             dr_mode = "peripheral";
>         };
>     };
> 
> The current binding requires these properties directly on the controller:
> 
>     usb@112b1000 {
>         compatible = "mediatek,mt8188-mtu3", "mediatek,mtu3";
>         reg = <0 0x112b1000 0 0x2dff>,
>               <0 0x112b3e00 0 0x0100>;
>         reg-names = "mac", "ippc";
>         ranges = <0 0 0 0x112b0000 0 0x3f00>;
>         dr_mode = "peripheral";
>     };
> 
> Modify the driver to look for a legacy node only among direct children
> of the controller and bind the gadget device to the controller node when
> none is present. This retains support for existing U-Boot devicetrees
> without requiring the synthetic node in devicetrees using the current
> binding.
> 
> There is also a difference in the meaning of the mac resource: normalize
> the resource address by SSUSB_DEV_BASE for the current binding and leave
> the legacy resource unchanged.
> 
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
> Changes in v3:
> - Remove the temporary platform data and derive the binding during probe
> - Use dev_read_addr_name() for the MAC resource
> - Link to v2: https://patch.msgid.link/20260718-ccaione-upstream-mtu3-spl-gadget-v2-1-7f69ca462559@baylibre.com
> 
> Changes in v2:
> - Removed typecast horror
> - Added platform storage to pass around legacy flags and device
> - Link to v1: https://patch.msgid.link/20260717-ccaione-upstream-mtu3-spl-gadget-v1-1-57a3e2d0a2b0@baylibre.com
> ---
>  drivers/usb/mtu3/mtu3_plat.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/mtu3/mtu3_plat.c b/drivers/usb/mtu3/mtu3_plat.c
> index 26fee141f6e..f5c00cd5a8d 100644
> --- a/drivers/usb/mtu3/mtu3_plat.c
> +++ b/drivers/usb/mtu3/mtu3_plat.c
> @@ -136,6 +136,7 @@ static void ssusb_ip_sw_reset(struct ssusb_mtk *ssusb)
>  static int get_ssusb_rscs(struct udevice *dev, struct ssusb_mtk *ssusb)
>  {
>  	struct udevice *child;
> +	fdt_addr_t mac_addr;
>  	int ret;
>  
>  	ret = device_get_supply_regulator(dev, "vusb33-supply",
> @@ -166,7 +167,17 @@ static int get_ssusb_rscs(struct udevice *dev, struct ssusb_mtk *ssusb)
>  		return ret;
>  	}
>  
> -	ssusb->mac_base = devfdt_remap_addr_name(child, "mac");
> +	mac_addr = dev_read_addr_name(child, "mac");
> +	if (mac_addr == FDT_ADDR_T_NONE) {
> +		dev_err(dev, "error mapping memory for mac\n");

This looks like an error reading the address, not mapping the memory.

> +		return -ENODEV;
> +	}
> +
> +	/* Current bindings describe the device block, not the whole MAC. */
> +	if (ofnode_equal(dev_ofnode(dev), dev_ofnode(child)))
> +		mac_addr -= SSUSB_DEV_BASE;
> +
> +	ssusb->mac_base = map_physmem(mac_addr, 0, MAP_NOCACHE);
>  	if (!ssusb->mac_base) {
>  		dev_err(dev, "error mapping memory for mac\n");
>  		return -ENODEV;
> @@ -317,9 +328,15 @@ static int mtu3_glue_bind(struct udevice *parent)
>  	ofnode node;
>  	int ret;
>  
> -	node = ofnode_by_compatible(dev_ofnode(parent), "mediatek,ssusb");
> +	node = ofnode_null();

ofnode_for_each_subnode() initializes node, so I think setting it here
is dead code.

> +	ofnode_for_each_subnode(node, dev_ofnode(parent)) {
> +		if (ofnode_device_is_compatible(node, "mediatek,ssusb"))
> +			break;
> +	}
> +
> +	/* Current bindings keep the gadget resources on the parent node. */
>  	if (!ofnode_valid(node))
> -		return -ENODEV;
> +		node = dev_ofnode(parent);
>  
>  	name = ofnode_get_name(node);
>  	dr_mode = usb_get_dr_mode(node);
> 
> ---
> base-commit: 96c308b8d2a6a1496c0a7366db9a7becf42d2454
> change-id: 20260717-ccaione-upstream-mtu3-spl-gadget-aa3d39cad06a
> 
> Best regards,
> --  
> Carlo Caione <ccaione@baylibre.com>
> 

This would be a bit more clear to me if we change "current bindings"
to "upstream bindings" everywhere (I think that is what you mean?) and
add some comments in the code that "mediatek,ssusb" is a U-Boot-only
thing.

Also, can we remove the obsolete entries from the U-Boot devicetrees?
arch/arm/dts/mt8183.dtsi already has "mac" in reg-names, so should be
safe to remove ssusb child node. arch/arm/dts/mt8512.dtsi needs a bit
more work.

And we should be able to remove doc/device-tree-bindings/usb/mediatek,mtu3.txt
since there are upstream bindings now.
