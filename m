Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292B7C9830E
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 18:54:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 82C8981213;
	Thu, 24 Sep 2026 18:54:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9QcN8uvD-iDi; Thu, 24 Sep 2026 18:54:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9D9888120D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790276097;
	b=kdb2OVUQAGugK09P08v7Q3Jmsbi7iguDgkSsBYTyV7hvIjvReeAxV4RztLKh9KMAv6g8
	 2ccaOcAnD+kOS2RmYJ7y4xKL2x1oWH2eXeT94bx2gfeJprNs+5OduodJQ3PeXKXQdTa9h
	 WiSBY8RCADHPWV0GSbG4H/3myJDBTjONl4j4yj4HKPtCM5Y+S29IdfSTeJC/44TfVldkL
	 kd0d4UOytXNHO85g907wPQuNfkuawI1f7/WO7mwxMA1wh6/d4XZ4jjzjgOkMzVGbZpoqk
	 YWneAqXkB9BSOCyNvhkNsDbSRF4jowLV6FbDIcNpNb6OHqF7w35ZOa0E3ALs5jflfew==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790276097;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FoIUFkxn0K7RH4fu5Ywqv0NBIJ/bT7QQYQnLUQ5Ylzo=;
	b=V4++RPHvzSXP8gJmQpdC7gnnK5BhwicMBcMtlmyIgW44/QCNPUStndaNSAHplyiXbDft
	 +hTyNrPbwDOMSRmHLffMfP57jitweUKNmCmT+yvTKxhc48pvUyM+ovH7PuMkHGGFccMPp
	 3SaCReSU1p1wClLdCrjiBXWJzQGeW2qq/ix/1zh6aFsiZ58B4wDyPDxpxo6ga61K2kNdx
	 /rFqu916ZHKU3GS8Z7N6vGBeSuHWA1HzF++KVjcr3ivpwZ4Nk8Q2LRGBUZjHGSgbK/Elf
	 AEd5459cilwELEv/oQaW0uw5P9DDybuXfNbfMzO6nKC71Nyhlhp78TnTU9b55U7lIFg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790276097;
	bh=FoIUFkxn0K7RH4fu5Ywqv0NBIJ/bT7QQYQnLUQ5Ylzo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0E7ZIu2phJKM1HanEdBIubyQf1kvwXAsiDQzkeev1HByaJ3NOhX3UJ26299VKEOH2
	 4sHAlIxR1o7qCCLSghccA7heleX66LXb+n62SPX46ehrObRSm5ODW5ljVzwW864k2v
	 BKCjGdQJVUS0OCtwcgCOE5RrCqKA049QwOko9iaSJQhvWWnu656E30jZE1xB559Ej2
	 tx0z3I71xYKOPVk1lIRShNIzvwFvnOOGGYoEmalXcjtqTQ1sszrcnqWNipkEtxiwSL
	 YlQczOfyb4k39zE+PNAF5yjr/I+RHjMEHOwmcVR+eBwUpfxv7WzMQzi2mR1ACoSfHU
	 sRQ4NKQmMnfwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D9888120D;
	Thu, 24 Sep 2026 18:54:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F783355
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 18:54:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 459CC40AA6
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 18:54:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dX6IVj8eQjOz for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 18:54:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 35F384085E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:36::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790276095;
 b=Mwn+Edvy5t0Zy3MGu96XtxdMEMc28ohqaMlwFuszDMYxm/M3cAP3gGHQo84ms4U9N+o/
 hdKIuyPaiIw7TnRC1fI9FaI5/WhkR3EiR6Wt+eDKUBU8by1yzJMNxfyx7xMeI+zarrzd3
 i4YOJRiC8ggopO2KEm0V+axJPY6iLiAYqeC/6gcQdpk93DDMjkYtMgL98NB1W/qUFAunS
 FOqYkn1+UirpnFqVj5lmnZQocuRNIq8YpjKVZgN/wRAPUWNvyWSSvVhkTs5HbE1jNMHAE
 h4jGNP9xVoV4hQ59p2RNC9ZRpVoeiRuogFoDgZj7cXNrENTIeFAZ7tJbH4UGCFGmFRw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790276095;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=FoIUFkxn0K7RH4fu5Ywqv0NBIJ/bT7QQYQnLUQ5Ylzo=;
 b=nOw2PGtH8r7LYrn0Fh4pLFEoBcR5OKxg4c/98WS3Z8YO3PjEA1Myv9RThnugMNszM+ls
 HVunYB8zc12dLKhBPjRTjz6JXJtpWjRHJ5SIaK8jdoc71cVVN1WZZUAeGeXrcyrbiRIAW
 73z0e5INitpdUkvDXnxNUpBfBEJ2IHhc3N98t0sCWKIvtp64Bmx1F8bHGG8T8M81RQm8W
 gTlCl4MK9Nm/1WlWhuU7BmO8lwN4KOYdiB0R7MX1WSDcXqqdf66jFYLz+RlFE4p9zimXG
 hM8jvYO+B6VQi3uSD0ixbxw1WEAFvOk6HSREjtVRpnvSKCXjSYnxFJDNQOWjzs9QVAw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=XQEzQemh; 
 arc=none smtp.remote-ip="2607:f8b0:4864:36::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:36::10; helo=mail-dy2-x10.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=XQEzQemh
Received: from mail-dy2-x10.google.com (mail-dy2-x10.google.com
 [IPv6:2607:f8b0:4864:36::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 35F384085E
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 18:54:53 +0000 (UTC)
Received: by mail-dy2-x10.google.com with SMTP id
 5a478bee46e88-328664dbe2dso43347eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 11:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790276092; x=1790880892;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FoIUFkxn0K7RH4fu5Ywqv0NBIJ/bT7QQYQnLUQ5Ylzo=;
 b=XQEzQemhU0DqYNB04i2oNH3MKtP3Rp6uIzmXAp9HJcz//qQBj9JsVxQPOV6x+wueV5
 aBIZQL1+RYs9iP3HHnziWmMjTOuF7nv3kaCa4nhHouwMBVGOtjKR85Jj5cAco9MyGvYx
 tJ8D100Chr7bZD7jnzEhg7bB+9kZ8ArsWRCfTlX9n9qtyYlWltqsnqbRYMZgXzEvFglI
 /pyXM/Ur28RSwnpl9FMkfPjysJaRUB9qCbm+tZmYQDVp8lYK9aGzpJ89QQA164Km6vkM
 nx3bKyXxZZ/UV1xUYDxAQ19qKqm1u5iQCWKeqbU+Q8mzJ29F3Gh1P7idDCtCOPu/sK3t
 7QYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790276092; x=1790880892;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FoIUFkxn0K7RH4fu5Ywqv0NBIJ/bT7QQYQnLUQ5Ylzo=;
 b=VgJIdx1zCVnnIujiYXJ9zE6Pw5uY73BfLkMXIXui+mI52XH/X4Emh5g8WZHFHfL+bM
 8wqMFN7optshj3tLeVyqWg2/yu5exMtJIhzXUAkMGxGVu2EZUlACHpWphjkHdgbjLSdh
 KlGYkq2MNC7GzwCTaQCecNaD3MeN419x7p/C3DE6RcN2aryXBDJ57/7dpD9FmgeqYAx9
 yRTMABFAyvcV4xAatxDKPl+i4NX/Ul/0D/NLotYgcUoq2R13RkqzdZb5yRbSEz5JFV3R
 Tw4dqSyhXdZkqzgs+L44/v0DNNeavWH8EoqIFL1OafKNgzjmLufk+bTP3yfc1d7hQWuf
 n1EA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrWj+WC5tDz5/nCTGI2lxPgdDGqE/vl+YT882VrLgzg0UZnNTtVvrnaEEnPiwLRkHDt/w22qQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lMVsdSCTEqG+Lx8Ht68VmLwUGq/7+i62eg/2jO+5jt6QKJZN01
 +gV51uie7aAcXj6EKxgbiJ0bDvSBDpK9G4ZDWDUvqr3IVKK7dq0MgGLhpSR3OJY5p6o=
X-Gm-Gg: AYBFou1hZtutsA3OyvmF5RPPBZrfZlV4pgJ6gcmsIRZFZ5XoA5uwzyhjxaETqND8D10
 NBKmAanwOd/Cs7veMmV3cZnnQmGOb4o0sAJFxLzYUSq0ve+vxsU75fdDk+MY5eykgSE4W8aZJRW
 ybRv8/OGU/RzRjKERiq7xpjc+WeA4Nn1/tHKD0Ny0LKM5fJmaL6XH4G952Gj26/6O7HUvRNyXtX
 jhtlBhgPV8jSe/TjQXTFjkL/kBNQqXmQSjPO0S/8QsT1as3IaILX/+U543+UccAsuc/MZtSgNz4
 zhyCqhO/DqafHJdYLiYEMvNyOLBnmmDIN0O4+TcYVN/McO8kNUDt2CXYXhSv0l3/HEZKyIlujFg
 Ev24Awg8pP2blduq67F7H/vHLTHrlDefXvCzPwoZERM0/5CHaeFwYSKY14GVm876uExvXPghDFw
 KCVZv7VJb6VZtkrY/3lGW0txjRI8+C+6jERaVOFzrt82Ps/V3NJ5It9Pecc9qcASiO8RVlWBv9V
 U86UuQ8bQzto+jf/vSZLP7WaF5YzyhKoV6bVGa415rC0CqP
X-Received: by 2002:a05:693c:6392:20b0:33e:643c:91fb with SMTP id
 5a478bee46e88-34002ee1e78mr2724659eec.5.1790276092249; 
 Thu, 24 Sep 2026 11:54:52 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:7ded:edd5:63dd:4102?
 ([2600:8803:e7e4:500:7ded:edd5:63dd:4102])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34141a4a5ecsm506958eec.3.2026.09.24.11.54.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 11:54:51 -0700 (PDT)
Message-ID: <f008d8d3-2318-4c30-9b85-d38304466ead@baylibre.com>
Date: Thu, 24 Sep 2026 13:54:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pinctrl: mediatek: add pinctrl driver for MT8196
To: Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>, Deep Pani <deep.pani@mediatek.com>
References: <20260924-mt8196-pinctrl-v1-0-4df08627ad64@collabora.com>
 <20260924-mt8196-pinctrl-v1-1-4df08627ad64@collabora.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20260924-mt8196-pinctrl-v1-1-4df08627ad64@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 9/24/26 11:03 AM, Arnaud Ferraris wrote:
> Add pinctrl driver for mt8196. The driver is based on the kernel driver.
> 
> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> ---
>  drivers/pinctrl/mediatek/Makefile         |    1 +
>  drivers/pinctrl/mediatek/pinctrl-mt8196.c | 1905 +++++++++++++++++++++++++++++
>  2 files changed, 1906 insertions(+)
> 
> diff --git a/drivers/pinctrl/mediatek/Makefile b/drivers/pinctrl/mediatek/Makefile
> index 0e6eedba9c4..6ea55030bba 100644
> --- a/drivers/pinctrl/mediatek/Makefile
> +++ b/drivers/pinctrl/mediatek/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_TARGET_MT7988) += pinctrl-mt7988.o
>  obj-$(CONFIG_TARGET_MT8188) += pinctrl-mt8188.o
>  obj-$(CONFIG_TARGET_MT8189) += pinctrl-mt8189.o
>  obj-$(CONFIG_TARGET_MT8195) += pinctrl-mt8195.o
> +obj-$(CONFIG_TARGET_MT8196) += pinctrl-mt8196.o
>  obj-$(CONFIG_TARGET_MT8365) += pinctrl-mt8365.o
>  obj-$(CONFIG_TARGET_MT8366) += pinctrl-mt8366.o
>  obj-$(CONFIG_TARGET_MT8512) += pinctrl-mt8512.o
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8196.c b/drivers/pinctrl/mediatek/pinctrl-mt8196.c
> new file mode 100644
> index 00000000000..750f4eda029
> --- /dev/null
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt8196.c
> @@ -0,0 +1,1905 @@
> +// SPDX-License-Identifier: GPL-2.0

GPL-2.0 is ambiguous and deprecated. Prefer GPL-2.0-only or GPL-2.0-or-later.

> +static const struct mtk_pin_desc mt8196_pins[] = {
> +	MT8196_TYPE0_PIN(0, "DMIC1_CLK"),
> +	MT8196_TYPE0_PIN(1, "DMIC1_DAT"),
> +	MT8196_TYPE0_PIN(2, "PWM_VLP"),
> +	MT8196_TYPE0_PIN(3, "MD_INT0"),
> +	MT8196_TYPE0_PIN(4, "DISP_PWM1"),
> +	MT8196_TYPE0_PIN(5, "LCM1_RST"),
> +	MT8196_TYPE0_PIN(6, "DSI1_TE"),
> +	MT8196_TYPE0_PIN(7, "GPIO_7"),
> +	MT8196_TYPE0_PIN(8, "GPIO_8"),
> +	MT8196_TYPE0_PIN(9, "GPIO_9"),
> +	MT8196_TYPE0_PIN(10, "GPIO_10"),
> +	MT8196_TYPE0_PIN(11, "GPIO_11"),
> +	MT8196_TYPE0_PIN(12, "GPIO_12"),
> +	MT8196_TYPE0_PIN(13, "EDP_TX_HPD"),
> +	MT8196_TYPE0_PIN(14, "SRCLKENA2"),
> +	MT8196_TYPE0_PIN(15, "SRCLKENAI0"),
> +	MT8196_TYPE0_PIN(16, "SRCLKENAI1"),
> +	MT8196_TYPE0_PIN(17, "MD_INT0"),

> +	MT8196_TYPE0_PIN(18, "DMIC1_CLK"),
> +	MT8196_TYPE0_PIN(19, "DMIC1_DAT"),

These names are duplicate of 0 and 1. I think it would be confusing to have
duplicate names since the name could not identify the actual pin and
probably makes some pins unuseable by name. There are some other duplicates
as well.

