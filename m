Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5FACA1013
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 15:05:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64025837F2;
	Thu,  4 Sep 2025 17:05:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Mg/nPAXy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 734F78384C; Thu,  4 Sep 2025 17:05:04 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05527837F2
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 17:05:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cHjSq6CVSz9sSs;
 Thu,  4 Sep 2025 17:04:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756998299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EI5Fo/K4y8koy8v3Bkv9ZWecnBeE8jKl0YNBeHJ6K9A=;
 b=Mg/nPAXysw0HXgSp/UWwfLN+EbwOVgjRsZyS81EA5dTwk3CrTk+ND05sQPrhJ76/wvsrbn
 h4QJYT5ckikgAVJRvQyR/y908RYnt/nMuvoeke89D7ie578neE78U5uxywwiSC2zXrD4Oq
 DVi3EOR90Qa29BJ0yyW8zg7F7vvOYbKLBCw9A37WaNWdfANeBiiEFB4TZPih8uueZPPvJw
 q/ClD9NJVkQoi126BL0m+o0gPWlbCfowr8LKWI4hPLlBPFgbP2je1KPgdnJBRr0jMYdc3M
 o6S4s05QN15oPM1asNl+Z2s1X146TmSku2O4gcEDgxjf8riXcLympKSZvOXpIg==
Message-ID: <1c505e20-74e4-4525-bba9-1f1d74ce6b6f@mailbox.org>
Date: Thu, 4 Sep 2025 17:02:30 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 5/5] Image size checks: Simplify SPL_SIZE_LIMIT logic
To: Philip Oberfichtner <pro@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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
 <20250903105653.335417-6-pro@denx.de>
 <21adca4e-834f-479d-a944-e4369c1b8c5e@mailbox.org>
 <aLlMjQb0Qs-VkiaX@aristophanes>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aLlMjQb0Qs-VkiaX@aristophanes>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: yxh4pd8owdqcsbmxai86351psqf1h4ud
X-MBO-RS-ID: 3ca6f23dae046fa2ca8
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

On 9/4/25 10:23 AM, Philip Oberfichtner wrote:
> On Wed, Sep 03, 2025 at 02:59:01PM +0200, Marek Vasut wrote:
>> On 9/3/25 12:56 PM, Philip Oberfichtner wrote:
>>> Simplify the depends-on logic for SPL_SIZE_LIMIT. No functional change.
>>>
>>> Signed-off-by: Philip Oberfichtner <pro@denx.de>
>>> ---
>>>    Kconfig | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Kconfig b/Kconfig
>>> index aa00669ba20..343299eed50 100644
>>> --- a/Kconfig
>>> +++ b/Kconfig
>>> @@ -588,8 +588,8 @@ config HAS_SPL_SIZE_LIMIT
>>>    config SPL_SIZE_LIMIT
>>>    	hex "Maximum size of SPL image in bytes"
>>>    	depends on HAS_SPL_SIZE_LIMIT
>>> -	default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
>>>    	default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
>>> +	default 0x11000 if ARCH_MX6
>> This makes it less obvious what the other case (!256 kiB SRAM SoCs) covers,
>> why is that an improvement ?
> 
> This was originally Heinrich's idea. I personally find it better this
> way, but I won't argue about it.

Why do you send a patch which you cannot even argue is correct ?

> Can you please find a consensus the two of you?

No, you should be able to clarify why this patch should be applied, do 
not shift this onus to other participants.
