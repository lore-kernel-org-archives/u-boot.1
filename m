Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC67CCF2E6
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 11:14:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A824483015;
	Mon, 19 Jan 2026 12:14:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="cxZrumLG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3E098397A; Mon, 19 Jan 2026 12:14:49 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB651800AE
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 12:14:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 5A402C214C6;
 Mon, 19 Jan 2026 11:14:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6023760731;
 Mon, 19 Jan 2026 11:14:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B620610B6AE4A; Mon, 19 Jan 2026 12:14:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1768821285; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=dAH2LGMNaYl0HOGKc7+jMND5I0x7AvUwpPkrm0V9Be8=;
 b=cxZrumLGx3+6EEILDqV2z/tRwf2btcOJMqYUTw3VJLSl5hKvzS0rVt9GmbanGCgTrwR2Xq
 5DUeASi5tcVAKvwruezweWQ5d9K97N/PCRPNIWwOj63EtLuk3hHgbjCF2VLIkt8bt/xSS0
 xVNXQaD7YTsXBB7ZIH6qP56nnBy9JH7xGADXfydGkhZjm7Oir6EpdI01N5XxXrJ41ZKLcR
 1YA9NkHG8ky1uDD+xVQbF/zpEq/Xj4oZIEx7PzUAagXOtIYBIW55WHi9X/kMCJ3Ab1wrC1
 OTG/1rt/tv8Q3cI6DtJQ54aS0GPyuA1qemt5OZ4yEg/N39mojUthmV1CdgPUeg==
Message-ID: <e83f6caf-0a31-4899-ac28-3a24e0ac7fba@bootlin.com>
Date: Mon, 19 Jan 2026 12:14:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tools: sunxi-spl-image-builder: support H6/H616 NAND
 boot
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Anand Gore <anand.gore@broadcom.com>, david regan <dregan@broadcom.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de,
 James Hilliard <james.hilliard1@gmail.com>
References: <20251028083733.574757-1-richard.genoud@bootlin.com>
 <87bjlruzxg.fsf@bootlin.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <87bjlruzxg.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi Michael,
Le 28/10/2025 à 10:40, Miquel Raynal a écrit :
> Hi Richard,
> 
> On 28/10/2025 at 09:37:33 +01, Richard Genoud <richard.genoud@bootlin.com> wrote:
> 
>> The H6/H616 boot ROM doesn't expect a SPL scrambled the same way as
>> older SoCs.
>> It doesn't use a specific seeds table, it expects a maximized ECC
>> (BCH-80), a specific BBM (FF000301) and doesn't work if empty pages are
>> skipped (it needs its specific BBM, even in the padding).
>>
>> So, add a --soc=h6 option to support H6/616 with:
>> - more ECC strengths
>> - specific BBM
>> - default_scrambler_seeds[] with all values
>> - no empty pages skip
>>
>> In Kconfig, select BCH-80 by default for SUNXI_SPL_ECC_STRENGTH to make
>> BROM happy.
>>
>> And in scripts/Makefile.xpl, use --soc=h6 option when building for a
>> SUN50I_GEN_H6 SoC.
>>
>> Tested on Whatsminer H616 board, booting from NAND.
>>
>> Co-developed-by: James Hilliard <james.hilliard1@gmail.com>
>> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
>> ---
> 
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> Thanks,
> Miquèl

Sorry, I didn't remembered until now, but it seems this patch also got 
forgotten.

Regards,
Richard

