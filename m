Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F368C5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 13:15:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D67D98128B;
	Thu, 13 Aug 2026 13:15:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZQ9i2buVxJCf; Thu, 13 Aug 2026 13:15:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7F23C81236
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786626947;
	bh=4Dk3h4XB9LIRvcGJbYwRA3Q/TUQAVjbKjDdivOzweG8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=S3+fwMbbBQDMs0sT47xR96n+bWejU3FUSJqt0Fg6JT795qqviJ6uYOhzd++7gNr7l
	 gX9y8K7GAJOF9CoRNAjTccq/PXudrTT3yWAkpFrxaVBG9DUJLtKMlRWgxYIetA59o0
	 rLk6zNNpexm61XClkXxoS3JsDpKtbL1LOFCBNuAWV2FRGiV/G93GSJuw9JPo2S8ETk
	 rfrumMWXJQptItzplXfbllqCjPaiPLwNlUpc+YcMo/FNzMoaCShSlc32IgswqUozrl
	 MVoqzPWhXS4ecz5QSJP+l7eABw7EPIJ++6sLPNlv1lxYmFW52Kz1UJgu2/exDNW8bf
	 F7dTEEocnvvUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F23C81236;
	Thu, 13 Aug 2026 13:15:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 139523A0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:15:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 07D494096F
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:15:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ag_dM1MD7Lyu for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 13:15:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 85AC740959
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 85AC740959
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 85AC740959
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 13:15:44 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4af81963f35so967571b6e.0
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 06:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786626943; x=1787231743;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4Dk3h4XB9LIRvcGJbYwRA3Q/TUQAVjbKjDdivOzweG8=;
 b=WOndHrVs3IjJgTGdmOHQSuata+Llxtkw2YVuxUjDfyzX0a4PnHVKTqIhvyqvgkfSvg
 fqCNOsz2agzmu1dZeSuyuDTgthoX8c+KebMeihFulMFrW1AAPwl2CbQBPksJyapk8f1f
 +itXwW75dXi5FQYt253517H5cA1siUmNw3MPZ9XMcMqGsH9tokygIwc7tOSklQNaK0AO
 OtMf3R/+Axs7MVPbep8nMoANZNv4MtsUDBG88AOTLW9vf5VwBMEzAverkBvkXugzJsE8
 8QhGh8H8B7FiyE++csS1YZtbTdr/WuXrvAPbHh3Ge+9jea8bdXMPKGW0kTK85FGcSWEL
 +BJA==
X-Gm-Message-State: AOJu0YwmL98O9xvk3RgAXWwCApFRFU4upF1g4HJ0Zq251YbLX/7eabc1
 mNI2EB9iG1yMKfzgbSmgbKWHv+M1OYEzv0NhU9Hkn4N8QAVGiMOe47+P4CP/tk3NgTw=
X-Gm-Gg: AR+sD13ylyNffVK1gWgBAE7VtK9v0YHBqAGhBtmHn+u+7NxfjR8bEZ3JAqnw+J8uH/f
 VW32fCCRRrKbFjltRrQ8vuH7dxeYbmlxOGaj33VMgKbItaZLE8CVKJGwc3DZxQYdZASZKUM4jdF
 Y2tmQI113hyXEIrOBpSUPnFXdh3fkfO5sOZ3oSVXgrAY2YZWOdcm7htoYCoW5ga9xDaBiveFn2E
 MDB8d1BXkCiyIot+U9y1i2g9RIwCHxoCCLpa8wkWto+0Gwmlk2KqR19NktWCwpoDA2yTzjKrvR4
 lYASfn4Sq5EY2jnrdAwrm+rySdIy74KQ8J94jUbC9iBBRbLKGeLdRoVgXKPUkIxGE9zbtc1581/
 wTXXI0rEnB4cQcDzmM4NWYy2M4YlorGnw8vY69lJTRqFSPToL/K2c0xIQUFJnAG4B045k2NdQ9X
 Wz03GzgF0ftcb++xUe9a/Dj0FuB+FWIBe5ArmCOe8ARkJa3C1xYh9s6gcRV8LsgHy5vY/UTfe6A
 okZkRxbw/BF91craRy0fukXhPcQagNFkQFX
X-Received: by 2002:a05:6808:1824:b0:497:df42:1e04 with SMTP id
 5614622812f47-4b227b233b4mr4716718b6e.18.1786626943185; 
 Thu, 13 Aug 2026 06:15:43 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3678:ac91:e955:c25?
 ([2600:8803:e7e4:500:3678:ac91:e955:c25])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b22d004c3csm1525314b6e.18.2026.08.13.06.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 06:15:41 -0700 (PDT)
Message-ID: <a484c17b-83b2-4d10-92f0-554b35b53341@baylibre.com>
Date: Thu, 13 Aug 2026 08:15:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: mediatek: fix reprobe regression
To: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Sam Shih <Sam.Shih@mediatek.com>
References: <20260813-mtk-clk-fix-reprobe-regression-v1-1-ed259968c2b8@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260813-mtk-clk-fix-reprobe-regression-v1-1-ed259968c2b8@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786626943; x=1787231743;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4Dk3h4XB9LIRvcGJbYwRA3Q/TUQAVjbKjDdivOzweG8=;
 b=k7eUSn/xZO/xBc3UXTTAKGtw6PHP8hcIjP3A+C96ZCR80LRGcAUXftQO35FEj2PXXW
 BApr4LmKdvCkLm7cCmvFJv0EtxBx7YRpcy5TW7wxBpX0dZgQ00I9dkdVv7VLcEWyaN16
 qhlusZIRqz2Kh8KbN9DccmdQgrTldk5sI//WDxOdur6gfbxqtnBLY9rTBJb/t/BlpD3C
 p0YTYwHNz0DPw9/jH9OuWL3ETsvbc8WqA4+fTMlg2vvCyElbdp85575m6d55MzTPZw4G
 5DVrudyq7+lmPrO+HEyZ6a5JrecSPWcO9vv58/S0FP9wfAj8oxlotQEKslf283FVMQYR
 MwzA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=k7eUSn/x
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

On 8/13/26 8:10 AM, David Lechner wrote:
> Clear the MediaTek clock provider registry after relocation. This is
> necessary for a couple of reasons. If any clock probed before the
> relocation, the registry will contain a pointer to pre-relocation
> memory. Also, all drivers reprobe after relocation, so even if we
> had a valid pointer, it would be to a clock provider that had not been
> reprobed yet. Clearing the registry ensures that all clock providers
> are re-registered when they are reprobed after relocation.
> 
Disregard. I forgot an important detail and will send v2 shortly.

