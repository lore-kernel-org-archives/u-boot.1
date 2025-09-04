Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E7ECA1013
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 15:05:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E43328383E;
	Thu,  4 Sep 2025 17:05:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OsV3cH7/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBFAA8383E; Thu,  4 Sep 2025 17:05:00 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DA5B837F2
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 17:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cHjSm4FMXz9tGx;
 Thu,  4 Sep 2025 17:04:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756998296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kPcuZ4xTCjLTZk+HTX96y3qpb+SYU7q45//0uPaQPaw=;
 b=OsV3cH7/EvKLF+AmfDs6ehb0YS7FzvYYSl0wajuxH6rAiryyP8ZQXFhSxjAHjtFSz6H3u/
 kX9zkv5gRoC2XWUSrdlNPwBIlcG9gDlonv5GFm6dFnyw88ZTG5HgCDb8jHDG13vRWKnwAq
 NJnwMxkJegSfpFzsySk2hnK7+nWb5uPnnLkHlcK/SYH1kUhcIGEBbcX6HlK82CUoKY1YgN
 Iqo5BOlR6b9NmxLdssHXbAGMhg7U8WCa8E50w45rCof+LYRQFNW0blkMi+SkB1fkazjTWo
 yogJw/aHFaVeIAz/vng5mhw0RFL91n2WX0OAIy5y9MqCplrQz1B7IECkqJ86sA==
Message-ID: <7826abc2-ef93-4b76-9478-f4be1dd05246@mailbox.org>
Date: Thu, 4 Sep 2025 15:56:26 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/5] Image size checks: Use HAS_SIZE_LIMIT consistently
To: Philip Oberfichtner <pro@denx.de>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>, Ye Li <ye.li@nxp.com>
References: <20250903105653.335417-1-pro@denx.de>
 <20250903105653.335417-3-pro@denx.de>
 <d1b371f3-df96-421d-8f26-635ac0382666@mailbox.org>
 <aLlLdkRkqrfLm2FY@aristophanes>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aLlLdkRkqrfLm2FY@aristophanes>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 459316f3215c2d64cc6
X-MBO-RS-META: 7w574zw3b5rx7fapm7c3bqtcxbyudfus
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

On 9/4/25 10:19 AM, Philip Oberfichtner wrote:
> On Wed, Sep 03, 2025 at 02:51:44PM +0200, Marek Vasut wrote:
>> On 9/3/25 12:56 PM, Philip Oberfichtner wrote:
>>
>>> diff --git a/configs/am62x_beagleplay_a53_defconfig b/configs/am62x_beagleplay_a53_defconfig
>>> index 05853317fea..dfac96379ce 100644
>>> --- a/configs/am62x_beagleplay_a53_defconfig
>>> +++ b/configs/am62x_beagleplay_a53_defconfig
>>> @@ -20,6 +20,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>>>    CONFIG_SPL_BSS_START_ADDR=0x80c80000
>>>    CONFIG_SPL_BSS_MAX_SIZE=0x80000
>>>    CONFIG_SPL_STACK_R=y
>>> +CONFIG_HAS_SPL_SIZE_LIMIT=y
>> How much of this massive config file patching can be done using some
>> "select" in Kconfig file ?
> 
> I'm not following you here. I'm only adding CONFIG_HAS_XXX_SIZE_LIMIT
> wherever there already was an explicit CONFIG_XXX_SIZE_LIMIT in the
> defconfig before. I'm not changing anything here. Can you please
> elaborate on what it is that your asking for?

Can this massive configs/ update be avoided by using a default value / 
select / imply in some Kconfig file ?
