Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115DDCD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 14:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 753D683FF5;
	Wed,  3 Jun 2026 16:16:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mc3EQbPG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BE458467E; Wed,  3 Jun 2026 16:16:44 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDCAC83EF9
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 16:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gVqWX0vFcz9tQF;
 Wed,  3 Jun 2026 16:16:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780496200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NMnMljJ+hAXryQMxjIcIGPtaDHnCpWDfSQQqhjI6nWU=;
 b=mc3EQbPGygL6W/p41ec4zWtHgxyREerolZq5B2rLtjCrndYfd1UUzW2GJk3P0tsOogwp8v
 qNOkAmCZUowGAuP7fbZGtMm1RXhILjMCx/ej0zefxkvNXXCOZRryZFygb8nvJpu6iMzCRl
 T5QK3RN2bYaZ8mtIdPBgOOI064FO+o2iBnQ/B0WF75+Aw5JEJcqPE9Q0SVP0cWZev2CX4c
 kE1oOb2Ct+pYJrvn1gFwh6npVpxGrqKtZaeA9IX5uHqtlCI6RG62A1bQNiild0Z+MAKq2M
 Mi+w4gHJG/uoeOupXu3B6SZUBeNsC+KR6vSUELtut4AxTbeZ7nmchG6XCHrLKQ==
Message-ID: <6efaad16-f072-42a2-aeb5-30b50005c088@mailbox.org>
Date: Wed, 3 Jun 2026 16:16:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] [RFC] lmb: Optionally limit available memory to 4 GiB on
 limited systems
To: Peter Robinson <pbrobinson@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>,
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
References: <20260530144604.71190-1-marek.vasut+renesas@mailbox.org>
 <8e28ea5f-039e-4620-bb88-8e992290da58@mailbox.org>
 <CALeDE9O4G21o2Onc=OpdwYO7o2PB7eS9u9JfE4nQjRFfRO4SrA@mail.gmail.com>
 <2604d7ca-1336-42af-b5ab-99fed506d63d@mailbox.org>
 <CALeDE9Nf5WPdf6VdaJGdWOJyo67DwNVp3L7eEiwkMPppLxVw=w@mail.gmail.com>
 <CAC_iWjJv-oQ8Z92kDpnX5mecvknBd1MsuEB2MVvDwpwAjRmozw@mail.gmail.com>
 <CALeDE9MkMx1s=qErP0Zp47MnRaH=fqC2Bfj-faNzn-7am8rsvA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CALeDE9MkMx1s=qErP0Zp47MnRaH=fqC2Bfj-faNzn-7am8rsvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: bygcsokfwnb5ga7qtzyu47x4u5enmyaz
X-MBO-RS-ID: e21c93278f742a11c48
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

On 6/3/26 1:41 PM, Peter Robinson wrote:

[...]

>>>>>>> +             if (size) {
>>>>>>>                         lmb_add(bd->bi_dram[i].start, size);
>>>>>>> +                     if (IS_ENABLED(CONFIG_LMB_LIMIT_DMA_BELOW_4G))
>>>>>>
>>>>>> This conditional should be inverted.
>>>>>>
>>>>>> Peter Robinson , can you test this change on RPi ?
>>>>>
>>>>> That doesn't fix the problem for me on a RPi4 4GB or a RPi5 8Gb.
>>>> Did you invert the if (IS_ENABLED...) conditional ?
>>>>
>>>> Was CONFIG_LMB_LIMIT_DMA_BELOW_4G enabled in your config (maybe the
>>>> Kconfig entry "default y" part needs to be tweaked to cover these devices?)
>>>>
>>>> If both conditions are met, that should behave like the old code.
>>>
>>> I dropped my revert and applied the patch, checked the new config
>>> option was in the generated .config (I mean you could test that with a
>>> "make rpi_arm64_defconfig" and checking the output).
>>
>> You need to invert the logic of IS_ENABLED() for this patch to work.
>> Marek obviously missed a !
> 
> Ah, I missed that bit in grabbing the patch, it seems to work on the
> RPi4 4Gb, not tested a RPi5 yet.

Lemme send an actual fixed up patch then ...
