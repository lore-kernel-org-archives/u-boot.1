Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD5AC4451C
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 02:26:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07E7884105;
	Sat, 18 Jul 2026 04:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="iHMkfjN+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A88584119; Sat, 18 Jul 2026 04:26:30 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D21983FF5
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 04:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4h29dG4t1hz8txr;
 Sat, 18 Jul 2026 04:26:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1784341586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oevTnFwxd+5axqgZ+xYttra0EB+IslXJt+yyeaehfbI=;
 b=iHMkfjN+ANNwCWWgg5gOIr05zKAhh8XzYcybyacY7ysm65b4oes/NLFzMeFydSTF8xs3Ef
 7sSVx5scy9DTUlbZ2Lx36Ahs+fhExIHTLQDQotMrME97JKnz2j93XgpQao71vp37cur+Ee
 E67i5Msa8dmuQSIRpdM37ffxtq9gC64ffub+lhPTV+Zh+arw7FLTE/gmrD7Izpj7RZbwj4
 1P1eHx8Xmhq6xLH1AWlU/hqLVWSeXTIqWT/PZO6uQLcp22QWiBJTDgarp4Fxi+BCWkm3OC
 B3bZwTmV3EuYT8vBk7xXkwl1QnOSxGwjfHmt1/dE9T6Wqyes7Ku5Q65GHx5VkQ==
Message-ID: <626b3219-d0c8-44b0-8947-0e216bd65713@mailbox.org>
Date: Sat, 18 Jul 2026 00:08:58 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: mtu3: support the current devicetree binding
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
References: <20260717-ccaione-upstream-mtu3-spl-gadget-v1-1-57a3e2d0a2b0@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260717-ccaione-upstream-mtu3-spl-gadget-v1-1-57a3e2d0a2b0@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 652be14c1df955cfcaf
X-MBO-RS-META: q1fwbrkf1sxfm9gwgx66s7znmktyniix
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

On 7/17/26 2:20 PM, Carlo Caione wrote:

[...]

> @@ -166,12 +167,20 @@ static int get_ssusb_rscs(struct udevice *dev, struct ssusb_mtk *ssusb)
>   		return ret;
>   	}
>   
> +	legacy_binding =
> +		ofnode_device_is_compatible(dev_ofnode(child), "mediatek,ssusb");
>   	ssusb->mac_base = devfdt_remap_addr_name(child, "mac");
>   	if (!ssusb->mac_base) {
>   		dev_err(dev, "error mapping memory for mac\n");
>   		return -ENODEV;
>   	}
>   
> +	/* Current bindings describe the device block, not the whole MAC. */
> +	if (!legacy_binding) {
> +		ssusb->mac_base = (void __iomem *)((uintptr_t)ssusb->mac_base -
> +						   SSUSB_DEV_BASE);

Can we avoid this typecast horror ?

> +	}
> +
>   	ssusb->dr_mode = usb_get_dr_mode(dev_ofnode(child));
>   
>   	if (ssusb->dr_mode == USB_DR_MODE_UNKNOWN ||
> @@ -317,9 +326,15 @@ static int mtu3_glue_bind(struct udevice *parent)
>   	ofnode node;
>   	int ret;
>   
> -	node = ofnode_by_compatible(dev_ofnode(parent), "mediatek,ssusb");
> +	node = ofnode_null();
> +	ofnode_for_each_subnode(node, dev_ofnode(parent)) {
> +		if (ofnode_device_is_compatible(node, "mediatek,ssusb"))

This is already invoked in get_ssusb_rscs() above, can the value of 
legacy_binding be cached somewhere ?

> +			break;
> +	}
> +
> +	/* Current bindings keep the gadget resources on the parent node. */
>   	if (!ofnode_valid(node))
> -		return -ENODEV;
> +		node = dev_ofnode(parent);
>   
>   	name = ofnode_get_name(node);
>   	dr_mode = usb_get_dr_mode(node);

[...]
