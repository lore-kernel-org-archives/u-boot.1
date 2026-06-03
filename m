Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42679CD6E6A
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 11:12:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F19183EF9;
	Wed,  3 Jun 2026 13:12:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wnOoXDk4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D355283FF5; Wed,  3 Jun 2026 13:12:42 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1DBF8056B
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 13:12:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gVlRC1Z3Sz9v2M;
 Wed,  3 Jun 2026 13:12:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780485159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ry/2qcfMbb7xZINoAg3T9iI6FlC99xbLA0ooPbDgL0Y=;
 b=wnOoXDk4Q8qYMeT/5ltr2H4b7A8lI+9uA4+d0Ys0YtJX4oDL8776tLgzTD4cV9F5Rpz40p
 6gGOIf7ZE17jVnuCa2aX8Ks7BDwra+U+TcVYDf4EWaQS3zQJfuUJHeg76EXyQS1Lod8zQI
 /J+ai9Mi6iGbwPbNb8MP/pz8WTRcNC9y/H2Fk2/QUTpGdsAswCWqVC2Xauup9DomOHHfcy
 cBepjSm4Z0cr6ocVaxyA4kkZFEcHj0mcso9X5oGUrM/Rbg9i+C/ck3k1fA6dqtEeZGWX4n
 c/pmYC/KlOpTlbsAwYHVpIarNWUBCVBwB4g6ZJxwSTC/zPM8AOo42fOupED+ow==
Message-ID: <0ec14745-ca08-41ab-bef7-2e94545590da@mailbox.org>
Date: Wed, 3 Jun 2026 13:10:26 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] [RFC] lmb: Optionally limit available memory to 4 GiB on
 limited systems
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>,
 David Lechner <dlechner@baylibre.com>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
References: <20260530144604.71190-1-marek.vasut+renesas@mailbox.org>
 <8e28ea5f-039e-4620-bb88-8e992290da58@mailbox.org>
 <CAC_iWjJHEXshSgbimHRo9LPOpL36B_cOKiyrsNoqMEuyFeMdxg@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <CAC_iWjJHEXshSgbimHRo9LPOpL36B_cOKiyrsNoqMEuyFeMdxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 0e3229da51e6605d863
X-MBO-RS-META: j46y41njjhhyy9b7nr5w68ae58htr3gb
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

On 6/3/26 12:37 PM, Ilias Apalodimas wrote:

Hello Ilias,

>>> diff --git a/lib/Kconfig b/lib/Kconfig
>>> index 77ebc79e1db..29911068a69 100644
>>> --- a/lib/Kconfig
>>> +++ b/lib/Kconfig
>>> @@ -1295,6 +1295,14 @@ config SPL_LMB_ARCH_MEM_MAP
>>>          memory map. Enable this config in such scenarios which allow
>>>          architectures and boards to define their own memory map.
>>>
>>> +config LMB_LIMIT_DMA_BELOW_4G
> 
> This seems the right idea for now, but is it really 4G or ram_top?
I think the LMB configuration should in fact be board (or SoC) specific, 
because RPi has problems already at 1 GiB, other hardware might have 
problems at 4 GiB, etc. But this config option is the generic "make it 
work somehow" flip switch.
