Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E718CD6E74
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 17:34:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C539A84948;
	Thu,  4 Jun 2026 19:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Vkjgkg4r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF6A684995; Thu,  4 Jun 2026 19:34:39 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E371D800AE
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 19:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gWWsS1bRdz9tqw;
 Thu,  4 Jun 2026 19:34:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780594476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+XBUUkr1Tov6U2Wj32FvCouuK7VkriG7ug/cVYK0LWA=;
 b=Vkjgkg4r3cgjeK1xSJxlIfxYfihJCH9d/VibSbufbhDuborRhYDC8CMjAQLQPg86Zd7pZk
 C+l93/hu1MjHMfCmgkQ+XUEyIu6yRQgULl+MH2oJi5kFX3XbYL2/N4bmBaFFx+1a69dp1i
 6cBVMV0JlawBATX3VZO748uVBSz+R2cSjRrPBNYP/unvCtBN7iMD5rspXI0BlhtvMO3EhZ
 1pRU3ndVubiSV8K114csVVH5tN0A/ReseiwMLnbVRy7mDBed6yZzy3V3V9gGoQ6Q4MVg+r
 Xny7gjjZarqxwOdSSXu438/YD7ugRleEm8wHy2T3PG44fD/Ude4/mpf9yPosEg==
Message-ID: <d00413d4-a0dd-41f7-b0dc-6b89a6fa0be8@mailbox.org>
Date: Thu, 4 Jun 2026 19:34:32 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v1] lmb: Optionally limit available memory to 4 GiB on
 limited systems
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>,
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
References: <20260603141814.12672-1-marek.vasut+renesas@mailbox.org>
 <CAC_iWjL13SZ6uN2RgQO2EsT+YRfaz=poOCEQuEWBLt8RgahWgQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAC_iWjL13SZ6uN2RgQO2EsT+YRfaz=poOCEQuEWBLt8RgahWgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 6xr3jadtgf3mrod9j1urc6cnsg3ya9mx
X-MBO-RS-ID: 154480cd1c1d5626324
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

On 6/4/26 8:43 AM, Ilias Apalodimas wrote:
> On Wed, 3 Jun 2026 at 17:18, Marek Vasut
> <marek.vasut+renesas@mailbox.org> wrote:
>>
>> Some architectures can not DMA above 4 GiB boundary,
>> limit available memory to memory below 4 GiB boundary.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> ---
>> Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
>> Cc: David Lechner <dlechner@baylibre.com>
>> Cc: Heiko Schocher <hs@nabladev.com>
>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> Cc: Holger Brunck <holger.brunck@hitachienergy.com>
>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Cc: Peter Robinson <pbrobinson@gmail.com>
>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
>> Cc: Simon Glass <sjg@chromium.org>
>> Cc: Sughosh Ganu <sughosh.ganu@arm.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@lists.denx.de
>> ---
>> V1: Invert the IS_ENABLED(CONFIG_LMB_LIMIT_DMA_BELOW_4G) conditional
>> ---
> 
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Tested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org> #rpi4 8GiB
I sent a follow up patch for the Kconfig option name too.
