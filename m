Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3E9C56201
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 10:37:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF1F040792;
	Wed,  5 Aug 2026 10:37:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wSALwsQBrs_E; Wed,  5 Aug 2026 10:37:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E82F94068E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785926229;
	bh=ffQHsYoREZKG1Bwq1Gg+e0z75x+f0KwqUe2Tfd9Nhe4=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j0CWkFWbgKxHikdUYJ+TuSW2sJjBoQOXksb3OQGYk9qEGftk5SYKo6bqKoLMQ/OLD
	 SoY8Hwpi8W1adEpg0CxA/YypaM4CyH6q5xIc+Jt0v+yOgeZmySPj8+b47LXzSwGHTp
	 gEWJYTYNA9nNIeJtlZv0PtVsguhK0WVmkcyGCgk82kgtlgOig8wpKhkntiSnqqOMWZ
	 7on6bFALzABtugzhRuldUmNzrvFbtptxf5lbTfMtWAqPQREHITonA69Hj1NFfSyixk
	 Lgn3abrb7lzGvpcQJJmNx18oWOpTrsDKrBj+mmeWwIfoSGgJpjNKceBJV1uIbCM1XC
	 +BMvdijUL4yBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E82F94068E;
	Wed,  5 Aug 2026 10:37:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A1CBE2B6
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 10:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F87A606C6
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 10:37:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uaLOzhuujXFF for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 10:37:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32f; helo=mail-wm1-x32f.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A7488606FF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A7488606FF
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A7488606FF
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 10:37:05 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so8362135e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 05 Aug 2026 03:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785926223; x=1786531023;
 h=in-reply-to:references:cc:subject:from:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ffQHsYoREZKG1Bwq1Gg+e0z75x+f0KwqUe2Tfd9Nhe4=;
 b=BuQMo8kXR8J9nk/+DDEJGwbB77YLRWtr7uQ7JWcUOKUQRiNf3ViTXb7skS/yiQWe3p
 1iia5mfvpbYJf7lOmD87ioM2UphCZaZOa/YRC2Bm5VJFJ09afLr103hulHxFkwmsKcSC
 TXE0bMD6uH7SdupWXrLnEFhbCbBQYJCLg1sEbUTDqcGY9SCop6TuWErsEk8/ZNeydwxk
 I/nqGwynWre7NipHJHtQOgHKIO+MGirGh+jQQbtr6ypbHZkICHieRHD2+lhhtZ7IlAdI
 pkP8NvOpC4YPeLSeVR8zfeaGRBA1NXvbsWji8aSRXlCX7UViRP//A0L2NqJJD0/W4xo5
 q/sg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpvnp1yU1SG9KN7yvr/SL2+J8fEom+K5pots6QPeIITZ20082EzFaVzUuZtdcarlBdCquhNezo=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzVEycOUgW8rCJ8sZNXPHW2hybo2E7lxmolq1jnDrxIJaeNHWzT
 LmCuYAOwmTXsoojzua9bfvQV2CFoIUAzozcVxqyOZgLviX1DUwxj8lPt1Ui29bu3MsA=
X-Gm-Gg: AR+sD10dJ4GUJJjjZpg5es0ivkey7G/opMSdn4Wl8QZ1odxUxYp5JraQBbO8CXv8BVx
 p3EN46M3gkKiCY5JLNOG3Hap0Fbn4TKm1jIPcTakBvrVUi1JVNA9cxADFR7jM1xCKcOtgaDv68e
 sz/v50zrnw2zJ5bnOI2a+1ag1YEPucgYNIc5hJBeuL3EiAT879ZeuBNwdTECkFPCmqwW4LEMt1P
 7XBgpXK7ynerVJxQyZsdxfPLyECTbH7dS84Fz8JRJxlczmdPg4xUhzMBB7X9zryQjFW194CVTyi
 TwZXmmGXcZqgtTvdPmGVimTJm2QTNiuY65nug/QsPaUIOsfX9NcoDEnHF/ZcpkMgMx3asIdFpKq
 N6bfr9Wwe2ftXeRwhN0hdgZlrGgnlDFDC5lRh0JU2j3rStpowIy/Nj1HHlnfKxCfAf4iADWwtEn
 WdwAhYXAQR/w/sL9UbKrp+9/WnK6Z9oEspRWFYj1fMITooOb0tyCMTaBsWFrjsS7Yd+ZByXdZaT
 Ec4bXa9pikBvqM+PKbxPOT7EY+DNR4tP3LTTFcwvT86xFQ8FaZ1MG7UKza2gTm1h/Y=
X-Received: by 2002:a05:600c:4454:b0:497:fecd:5b00 with SMTP id
 5b1f17b1804b1-4994e7c0377mr65902065e9.9.1785926223028; 
 Wed, 05 Aug 2026 03:37:03 -0700 (PDT)
Received: from localhost (host-212-171-227-71.pool212171.interbusiness.it.
 [212.171.227.71]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47febfdd383sm7187978f8f.8.2026.08.05.03.37.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 03:37:02 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Aug 2026 12:37:01 +0200
Message-Id: <DKGY0BWU7SO0.3L78LYC856KGI@baylibre.com>
To: "Marek Vasut" <marek.vasut@mailbox.org>, "Carlo Caione"
 <ccaione@baylibre.com>, "GSS_MTK_Uboot_upstream"
 <GSS_MTK_Uboot_upstream@mediatek.com>, <u-boot@lists.u-boot-project.org>
From: "Carlo Caione" <ccaione@baylibre.com>
Subject: Re: [PATCH v5] usb: mtu3: support the upstream devicetree binding
Cc: "Ryder Lee" <ryder.lee@mediatek.com>, "Weijie Gao"
 <weijie.gao@mediatek.com>, "Chunfeng Yun" <chunfeng.yun@mediatek.com>,
 "Igor Belwon" <igor.belwon@mentallysanemainliners.org>, "David Lechner"
 <dlechner@baylibre.com>, "Julien Stephan" <jstephan@baylibre.com>, "Marek
 Vasut" <marex@denx.de>, "Tom Rini" <trini@konsulko.com>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Peng Fan" <peng.fan@nxp.com>, "Jaehoon
 Chung" <jh80.chung@samsung.com>
X-Mailer: aerc 0.22.0
References: <20260804-ccaione-upstream-mtu3-spl-gadget-v5-1-5c3b6ec44eb5@baylibre.com>
 <d1843b10-df7c-4f65-ac1f-0c2f5c6cbe3d@mailbox.org>
In-Reply-To: <d1843b10-df7c-4f65-ac1f-0c2f5c6cbe3d@mailbox.org>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785926223; x=1786531023;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:cc:subject:from:to:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ffQHsYoREZKG1Bwq1Gg+e0z75x+f0KwqUe2Tfd9Nhe4=;
 b=G3M9NchNTupHtfvByWGmcI4V3MjvsgW3JHrXKy1aunMUTrbXlpje1eHD3Ac+8Z0UW8
 QvWmCMOtRSyUztpZ4dmFhuyjo7subYZZDZ0O7x3xd0VMettQhsq/SRdWlus28EGcgHUn
 J6AtHf/vFb/ZQzTpfVNF2dcci0E6zseJiXL++yAuFaqXT4IouLMpA6HqhFE8uOBEvucQ
 KasfaETn9nCOUBQV2NN5VobFFyoUgifNWHaK0V2sIPgWG7p6JXdpUzYXBciiBS41cw2I
 XB/pygTp/mAaFDZuQGefJDDiYZYITXkc0R45Rmmte77KB+Ox/w3BfXssLwd1ae8G98F+
 eEFA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=G3M9NchN
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed Aug 5, 2026 at 4:37 AM CEST, Marek Vasut wrote:
> On 8/4/26 12:05 PM, Carlo Caione wrote:
>
> [...]
>
>> +++ b/doc/device-tree-bindings/usb/mediatek,mtu3.txt
>
> You could easily swap in Linux=20
> Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml and=20
> Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml instead ,=20
> and drop the mtu3.txt . But please do replace the binding documents in a=
=20
> separate patch.

Shouldn't we just drop both
doc/device-tree-bindings/usb/mediatek,mtk-xhci.txt and
doc/device-tree-bindings/usb/mediatek,mtu3.txt and automatically fall
back onto the corresponding ones in dts/upstream/Bindings/usb?

>> +++ b/drivers/usb/mtu3/Kconfig
>> @@ -22,6 +22,7 @@ choice
>>   config USB_MTU3_HOST
>>   	bool "Host only mode"
>>   	depends on USB_XHCI_HCD
>> +	select SPL_OF_TRANSLATE if SPL_USB_HOST
>
> Don't you need SPL variants of the MTU3 controller Kconfig symbols instea=
d ?

Fair point, I'll add those to V6.

>>   	help
>>   	  Select this when you want to use MTU3 in host mode only,
>>   	  thereby the gadget feature will be regressed.
>
> [...]
>
>> +static int mtu3_bind_gadget(struct udevice *parent)
>> +{
>> +	struct udevice *dev;
>> +	int ret;
>> +
>> +	/* Node-less device: name it after the controller for diagnostics. */
>> +	ret =3D device_bind_driver(parent, "mtu3-peripheral",
>> +				 ofnode_get_name(dev_ofnode(parent)), &dev);
>> +	if (ret)
>> +		dev_err(parent, "failed to bind peripheral mode\n");
>
> Please also include the value of "ret" in printed error strings, it=20
> helps identify the issue faster. Please fix this for all such cases in=20
> this patch.

It makes sense.

Thanks!

--
Carlo Caione


