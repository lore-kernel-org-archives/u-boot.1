Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375D1C25B76
	for <u-boot@archiver.kernel.org>; Sat,  1 Jun 2024 19:51:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5448C88176;
	Sat,  1 Jun 2024 21:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SfE4XnTi";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MLXCa26g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF927880F1; Sat,  1 Jun 2024 21:51:27 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 180268811C
 for <u-boot@lists.denx.de>; Sat,  1 Jun 2024 21:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Vs9bd5CT7z9sGf;
 Sat,  1 Jun 2024 21:51:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1717271485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I40m0vwuITiw/Frfc6PiQqFsfkiT7NmnXGXf66mKad0=;
 b=SfE4XnTikRvRhSPB9xNCXUS4rKRXTBVj73m23g8mkaJSU95Hois80IwJePR9dMNY+nqsc2
 XfxOx+LaY0mrxpB2AHiRodspkcuEGZB8423qEOWtFcPRPVbTYE4Js6SlGbDbONoRmAe4QH
 0Lv4V7+ur+ucXp7qLjgs57mdc6KjWQ5j7N+cNXy3Nozu8WFm2UZPiN9Eabe904RZbREyXv
 W/EqtfaIrF13lxqOp7K6LMEfp+tpKz/FlKg/LGyNogF0yi/SRYA23++Nv57mhl6dKHAD7L
 cfEw31jU4YM0H69XV7wpY9t656fI/7sMMQ75wVP//m/WUeJ8LrYoVJUIIl+XPA==
Message-ID: <b9fbb3a4-f6d6-42e8-9128-483bbe2a12c7@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1717271483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I40m0vwuITiw/Frfc6PiQqFsfkiT7NmnXGXf66mKad0=;
 b=MLXCa26gBopzUtgWd1Y5JSsby0DSXeU/ZXsZ1DZzOSKmeTjq5ZPU2oSOf/5+ClOeT/sIQ0
 ELCif2SW7fwN45WFklhiQbqvezcX3oMyYHr4zgZgBGS2JyuBAgkJFGpEiQoev/RGV4cVvR
 lInzT1tzuQO6Q7AKBubdwUPP5fahM//JbTg5gHJpA6taC7Ze/YLHxPr4IFVQL6LM/SCwZF
 rvP9KQgJxgeRHLLjODX7XK5nAd02e2TW//lgNZa2wQy+ZYTzpeC3M7Vgt85eNCY08VMUDp
 8HI16lcQN2uU3yHbzJTHLoBGDHLmcpR5WlODM0x+cClQ5VeuP17WON6WAVMB1A==
Date: Sat, 1 Jun 2024 21:39:36 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] configs: rzg2_beacon: Realign ENV location and offset
To: Adam Ford <aford173@gmail.com>, u-boot@lists.denx.de
Cc: aford@beaconembedded.com, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Paul Barker <paul.barker.ct@bp.renesas.com>,
 Sumit Garg <sumit.garg@linaro.org>
References: <20240601145521.200132-1-aford173@gmail.com>
 <20240601145521.200132-2-aford173@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240601145521.200132-2-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 300a913d88ec36c8e12
X-MBO-RS-META: hi7yksmwqcu31mydid4oeskrpxg31edu
X-Rspamd-Queue-Id: 4Vs9bd5CT7z9sGf
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

On 6/1/24 4:55 PM, Adam Ford wrote:
> The ENV size and offset were changed to different
> values in Beacon's downstream release.  Change them to the
> same values as the downstream for consistent behavior.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
