Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA665C982CF
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 12:29:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 63AF6407F3;
	Thu, 17 Sep 2026 12:29:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lk9kLMnqQqrd; Thu, 17 Sep 2026 12:29:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CE635407C3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789648154;
	b=f2pTImt72jAO7dLyL74lTPqSxl3w6zp7RhX42PVW/X4Z7K97CirLm13FZRD0IEHEMn+P
	 Eq0CIISgs+7ZCXVNk4olwK0u/GilS4XHslB/jlS3ATYmqUvURmmayn+1n7XBNyb+Wuwe5
	 HMmG6DdJkAYHYOWDL4/FiHnq6Td2mOIDalXbNQEJq2WU0e9ff0UTVr8QCgixpg5ySDG3m
	 iRLgXABebpjFG30973EZyljwKsyc4bLDK+i2wI+Gqb6gGbG1YADyqa6aqzFkCWeHKS2Js
	 g9ZYnvmKQJWccXpfXPdhIzTz4WeNw9m8hHkHsrR2iv58CWjR+K+JHg74g9BLKYgj1zw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789648154;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=fjxa7oyZiLnLcD7Hdqv5sQC84CXV05hxEu1XtwdJflk=;
	b=nsFXmV/gFQDRDspvEl8YZYcZ4kMm1gozANNHzWCqASBIa37/wN7PkRJ99YLlHeskXqz8
	 0fWIe2gAWLlf/8CUnXc0e7fOZ0sygtBaBJFEGMyhP5Avodpa/umwmjF0gQgoiD9aUs/ke
	 /ANXvj9k8PvC7MukykUEAXryj6D0VnbZQ3ItKXS0lx4fTI+gVzfFdPx7G/CfjQ2zyVgaR
	 lEtBzKNlzsN5loce0d9VKsrx67FSsERxotSGWKQZVMTptiADQHlFrSr/creDRVqkmvZE3
	 4ljMOg+9LNNzk78e5qukjD7Omax29kGe5C8BwuZlaTh5CutXdtAD6p5/d3x0xaMbFhA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b="cJwbTOU/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789648153;
	bh=fjxa7oyZiLnLcD7Hdqv5sQC84CXV05hxEu1XtwdJflk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mNDgpriROGzhvM7axeHL/1r+8ljnQ/w245UoQrK9PR+0kn1LGR15E/uqYlm5VGOiP
	 CoIcAArteVG9zrmo6NjrNBm3e/UsG8mixMfhbFgxU7HMSZ/xn5wBZcss4mE2ABX6Io
	 YpopaQOdj0XhZFeZdV5kJWMSZnbXdto/X9BSagBs/a+EFzmhkmECVo7FIJAY8yPwLY
	 86tCO2XfeJqooVIz7buS2BzIyo5M1j3t7POGS/PMiqKrR4piQR/0LmIAQM9LueGTM8
	 qsJpvWFekBNWvTirOlLRGVcHdTe+Z6TEFDvRgMDPo5/pZpz/tD9RFVulP21cFnnRB1
	 QzSR3n3z4HIKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CE635407C3;
	Thu, 17 Sep 2026 12:29:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 22B6523F
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:29:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 05823407E9
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:29:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZIjz8wA307MN for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 12:29:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A4DB9407CC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789648150;
 b=dh4enWWH1VYg9muywyH5lKqoPzQlAMHZvASKL5k56RDlPlu78ZYy4uwINJMTFB/q4BwW
 7vYf54DE0zyrN/j/JE9KImCjgCH1I996/hEwsIXyj3xi01Qdue0aqPyL5HHYC2M6j/5/X
 saMMc4XX+mLu6XSObJ6eKfNWzQ+FqcnQoGybPjcl0GmOllbA8xP4/NNotYrH5+7aPluea
 39qZHYdu7HyVuclafwvBT4AXWxV9wYPIVlcGt9VJvc2g7lSDCOZKDIfuKMXm2geX1hC9D
 fEETGupOrRgDYN9mkNyNX282hnyMZ3uJbD8xyF1tT5Ll6cQ1VpTjAqzk0bMinBChwoQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789648150;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=fjxa7oyZiLnLcD7Hdqv5sQC84CXV05hxEu1XtwdJflk=;
 b=KIMLffk9CEUAfFw8QjwuuocIteS5IsISK5YvMjLC5mNNI7JSLEMyI/mtJHr8Hez5jmn7
 un9f1iCRa77HgWmwRAekCMCl+aUekI1yewJUtVGhqMbGZ6M0koRvA97EpY/zY2rjiG0cm
 WzXVno2lFuNHdBYVjIpDMjaKgnk2jbSBzsmHKv0r7XhZLmP6j8Y0A32A6I/fMeoih/PB0
 CM19ydKfYsBPU8E4/pBxalvrWnjXs/0+9UDdaFLpTBAWn/E2oSqShW3YwhHs5QHG13ma6
 bZHUyJl8dLzCBEbZ1t+xNaGEsv3sWNNY0DcP/w/dYVTo+pgo4Rf4PezbRVkl4POiAuA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b="cJwbTOU/"; 
 arc=none smtp.remote-ip="2a00:1450:4864:30::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:30::10; helo=mail-wr2-x10.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=cJwbTOU/
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A4DB9407CC
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:29:07 +0000 (UTC)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6350faaso477736f8f.0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 05:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1789648145; x=1790252945;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fjxa7oyZiLnLcD7Hdqv5sQC84CXV05hxEu1XtwdJflk=;
 b=cJwbTOU/MqQ/yaNQu4u83Y46QKZaEIrwyJhzFj64o0RIM2VRoHXohUeOiim9oHUsGI
 z8AASuIfVb96GATgOoIhQqNMcDdyWceyPF9nrpt6YJHSffSRunESYRqULk2AKEpu1SJS
 yTGO0H8XRD+L59G8axWY+Qpe6Q6PDjrZt+8fQMc5Gu2FovqU2XyxaVRknyZp6CzN0uaL
 bxmeuO1MsHwZ+zo7F4Jz1mCigN6ojaJtRYn3gHiDcqaXROqnG+DBWbtL8TDbIMyMx03R
 05u1xX29NyYzJVkTn9VpM1XSPJRZB54nhewL1g+HxZlSGBkiOn7KSkyd90FLN73OgQxA
 XGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789648145; x=1790252945;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fjxa7oyZiLnLcD7Hdqv5sQC84CXV05hxEu1XtwdJflk=;
 b=LfJUHxUq5r8xBnSoF53LA4CfbdG1kg9Wv6dxzDUZBru03p44Lzqed8sOr695lIK4BD
 HY+BaADh+GPXLnvOFwQ7Jq8sFagMJVSd23ANeWkoAi4DBJqpZBSPhMSeAEHZywDOCpF6
 mz776dZoMkjjZqWHpo+FMGfl53YEiVUh9ti71okAewG2b+/Iki79FjAfnQtwtnrcvpvg
 A+tWZZLGcaAEd9mLZtkYNY0me6ABaXVenrcIA9yNHk1zYITlhVMg/AOJFyhw284bj2YY
 dHHnonKToiw/iu6kyOmQatWJPOO84zgdqOYMK+eXGYnitDNFn1Y1uPVq8IAN5RZQKSpd
 AAfw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxN4Ux4uFQsTy4OuEsEHBaZnpvWe9K9VNyNWBr+thG0dpIYLc7PUpA+Y5cGeuDw5QVTp6FyzGA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nkHry8JZpgZ/lZocNiZiA8RhFHXJ7Jtv7O4LpD32RPMsTOt9rs
 CPcKFqwGK9HJLbYqnvcKsecA2dUD5hO+JZuJT0ORXgRutMLTxcogHTyMlEms6jHm9lw=
X-Gm-Gg: AYBFou2bFg1DdF8KbVGkDo7vsfOjd9dK/YIzWKik/VrHbfxb0bSLgcAXs0O83y7Iu+A
 9kuQ0VRvEYb6qOxseBeR42owbN0W2JFPZ6ByeElFlilO7BKc/NQ/hoapU/iVzKwg4gSj5kuIQ8U
 bS/ir6VQsYr3wfTBT6/2amz6k21bagBsJgYis1tjc0Ca/AVk+hkg7EqgXZglTZ1DBx/OUd98DHt
 pDLEtpWa9Bl/lr9XZHsRV/qUh1zHBwZN8Q+jPvvTBJIFSDHkgCQfVeKfkajQsZqJnJBs4+rkNOf
 +b2HQImX3yeedFGAxg/DIWFwubL6FSkNrQhtiGMatW3IFfu/Xlm4kiTPKpdtLyn4DGB40Z31TBS
 2FAcUdVgkNF8OlbJ1Hm/LzmqRUEF3KgpFDkn4rKKtcA1OGgp3ZVRp//9eAZ90zxKRDcMpTYN/Q7
 JTRme/vTcHDIbP8k0Xb76LUaMaHoG310Oe92CbQR6fkXHaHhe373v2zp5DjRlMHXElcr/fWdjXZ
 X6z5pSJRD+2nK4TO2So
X-Received: by 2002:a05:6000:2c05:b0:486:fc08:a3ea with SMTP id
 ffacd0b85a97d-4870d276589mr8339276f8f.54.1789648145166; 
 Thu, 17 Sep 2026 05:29:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e50:3860::642d:5bda?
 ([2a01:e0a:e50:3860::642d:5bda]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf1f6cfsm15468486f8f.13.2026.09.17.05.29.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 05:29:04 -0700 (PDT)
Message-ID: <487435d1-9d9d-4e18-a2a6-ed631760fc25@baylibre.com>
Date: Thu, 17 Sep 2026 14:29:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fastboot: block: add 'oem set-block-target' command and
 runtime override
To: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>, 
 u-boot@lists.u-boot-project.org, u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>, Neil Armstrong <neil.armstrong@linaro.org>
References: <20260917-series2-fastboot-block-target-v1-1-fc8328bc2d12@oss.qualcomm.com>
Content-Language: fr
From: Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <20260917-series2-fastboot-block-target-v1-1-fc8328bc2d12@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi,

Probably a stupid question but in your commit message you speak about 
SPI-NOR  but fastboot support flash spi , why not enable it or update it 
if it's not exactly work as you want instead of create a new command ?

Thanks
Guillaume

Le 17/09/2026 à 11:01, Vandhiadevan Karunamoorthy a écrit :
> Add fastboot_block_set_target() so an OEM command can point the
> generic block fastboot backend at a different interface/device at
> runtime, without requiring a rebuild. Falls back to the existing
> build-time CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME/
> CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID defaults when no override is
> set.
>
> Expose this to fastboot clients via a new "oem set-block-target
> <interface> [device]" command, gated behind
> CONFIG_FASTBOOT_CMD_OEM_SET_BLOCK_TARGET (depends on
> CONFIG_FASTBOOT_FLASH_BLOCK).
>
> This is needed to target storage devices, such as SPI-NOR exposed
> through the MTD block uclass, that aren't known until runtime or
> that coexist with another default block interface on the same
> board.
>
> To: u-boot@lists.u-boot-project.org
> To: u-boot@lists.denx.de
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Dmitrii Merkurev <dimorinny@google.com>
> Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> Cc: Adrian Freihofer <adrian.freihofer@siemens.com>
> Cc: Heiko Schocher <hs@nabladev.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>
> Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
> ---
> This series lets a fastboot client redirect the generic block
> fastboot backend (CONFIG_FASTBOOT_FLASH_BLOCK) to a different
> interface/device at runtime, instead of being fixed to the
> build-time CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME /
> CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID defaults.
>
> This is useful for storage devices that aren't known until runtime,
> or that coexist with another default block interface on the same
> board -- for example, SPI-NOR exposed through the MTD block uclass
> (see the companion "mtd: spi: Expose SPI-NOR as a GPT-capable MTD
> block device" series).
>
> The patch adds fastboot_block_set_target() to the generic block
> backend, plus a new "oem set-block-target <interface> [device]"
> fastboot command (gated behind
> CONFIG_FASTBOOT_CMD_OEM_SET_BLOCK_TARGET, which depends on
> CONFIG_FASTBOOT_FLASH_BLOCK) that lets a client invoke it.
> ---
> Depends on: [PATCH v6 0/8] arm: snapdragon: Add snagboot support for Lemans-EVK
> Link: https://lore.kernel.org/u-boot/20260803-snagboot-v6-0-e8bf7a6fc0a4@oss.qualcomm.com/
> Depends on: [PATCH v2 0/4] fastboot: block: Add GPT/MBR and device selection
> Link: https://lore.kernel.org/u-boot/20260427-fb_gpt-v2-0-9e7fe3c1649a@oss.qualcomm.com/
> ---
>   drivers/fastboot/Kconfig      | 11 +++++++
>   drivers/fastboot/fb_block.c   | 75 ++++++++++++++++++++++++++++++++++++-------
>   drivers/fastboot/fb_command.c | 51 +++++++++++++++++++++++++++++
>   include/fastboot.h            |  1 +
>   include/fb_block.h            |  9 ++++++
>   5 files changed, 136 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> index a4539844d89..c7e0509eaad 100644
> --- a/drivers/fastboot/Kconfig
> +++ b/drivers/fastboot/Kconfig
> @@ -225,6 +225,17 @@ config FASTBOOT_FLASH_BLOCK_DEVICE_ID
>   	  Device identifiers are numbered starting from 0 and the most
>   	  common case is to use the first controller on the system.
>   
> +config FASTBOOT_CMD_OEM_SET_BLOCK_TARGET
> +	bool "Enable the 'oem set-block-target' command"
> +	depends on FASTBOOT_FLASH_BLOCK
> +	help
> +	  Add support for the "oem set-block-target" command from a client.
> +	  This allows switching the block interface (e.g. scsi, mtd) and
> +	  device number used by the fastboot "flash"/"erase" commands at
> +	  runtime, instead of relying solely on the
> +	  CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME /
> +	  CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID build-time defaults.
> +
>   config FASTBOOT_GPT_NAME
>   	string "Target name for updating GPT"
>   	depends on (FASTBOOT_FLASH_MMC || FASTBOOT_FLASH_BLOCK) && EFI_PARTITION
> diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
> index a8c74e35d0d..d3e5f6ed1f3 100644
> --- a/drivers/fastboot/fb_block.c
> +++ b/drivers/fastboot/fb_block.c
> @@ -125,6 +125,66 @@ static lbaint_t fb_block_sparse_reserve(struct sparse_storage *info,
>   	return blkcnt;
>   }
>   
> +/**
> + * block_interface_override - runtime-set block interface name, empty if unset
> + */
> +static char block_interface_override[16];
> +/**
> + * block_device_override - runtime-set block device number, -1 if unset
> + */
> +static int block_device_override = -1;
> +
> +/**
> + * fb_block_interface() - Resolve the block interface name to use
> + *
> + * Returns the runtime override set via fastboot_block_set_target() if one
> + * is active, otherwise falls back to the build-time config default.
> + */
> +static const char *fb_block_interface(void)
> +{
> +	if (!IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
> +		return NULL;
> +
> +	if (block_interface_override[0])
> +		return block_interface_override;
> +
> +	return config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
> +				  CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME, NULL);
> +}
> +
> +/**
> + * fb_block_device() - Resolve the block device number to use
> + *
> + * Returns the runtime override set via fastboot_block_set_target() if one
> + * is active, otherwise falls back to the build-time config default.
> + */
> +static int fb_block_device(void)
> +{
> +	if (!IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
> +		return -1;
> +
> +	if (block_device_override >= 0)
> +		return block_device_override;
> +
> +	return config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
> +				  CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
> +}
> +
> +int fastboot_block_set_target(const char *interface, int device)
> +{
> +	if (interface) {
> +		if (strlen(interface) >= sizeof(block_interface_override))
> +			return -EINVAL;
> +		strlcpy(block_interface_override, interface,
> +			sizeof(block_interface_override));
> +	}
> +
> +	if (device >= 0)
> +		block_device_override = device;
> +
> +	return 0;
> +}
> +
>   /**
>    * parse_device_partition() - Parse and validate device:partition format
>    * @part_name: Input string in format "N:partition" or "partition"
> @@ -140,8 +200,7 @@ static int parse_device_partition(const char *part_name, int *device,
>   {
>   	const char *colon_pos;
>   
> -	*device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
> -				     CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
> +	*device = fb_block_device();
>   
>   	/* Check for colon in partition name */
>   	colon_pos = strchr(part_name, ':');
> @@ -190,9 +249,7 @@ int fastboot_block_get_part_info(const char *part_name,
>   				 char *response)
>   {
>   	int ret;
> -	const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
> -						   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
> -						   NULL);
> +	const char *interface = fb_block_interface();
>   	int device;
>   	const char *partition_name;
>   
> @@ -385,9 +442,7 @@ void fastboot_block_flash_write(const char *part_name, void *download_buffer,
>   #if CONFIG_IS_ENABLED(EFI_PARTITION)
>   	if (is_partition_table_name(part_name, CONFIG_FASTBOOT_GPT_NAME)) {
>   		int device;
> -		const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
> -							   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
> -							   NULL);
> +		const char *interface = fb_block_interface();
>   
>   		parse_device_partition(part_name, &device, NULL);
>   		fastboot_flash_gpt_partition_table(interface, device,
> @@ -399,9 +454,7 @@ void fastboot_block_flash_write(const char *part_name, void *download_buffer,
>   #if CONFIG_IS_ENABLED(DOS_PARTITION)
>   	if (is_partition_table_name(part_name, CONFIG_FASTBOOT_MBR_NAME)) {
>   		int device;
> -		const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
> -							   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
> -							   NULL);
> +		const char *interface = fb_block_interface();
>   
>   		parse_device_partition(part_name, &device, NULL);
>   		fastboot_flash_mbr_partition_table(interface, device,
> diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
> index 18d86988f4c..235fae74fee 100644
> --- a/drivers/fastboot/fb_command.c
> +++ b/drivers/fastboot/fb_command.c
> @@ -45,6 +45,7 @@ static void oem_partconf(char *, char *);
>   static void oem_bootbus(char *, char *);
>   static void oem_console(char *, char *);
>   static void oem_board(char *, char *);
> +static void oem_set_block_target(char *, char *);
>   static void run_ucmd(char *, char *);
>   static void run_acmd(char *, char *);
>   
> @@ -120,6 +121,11 @@ static const struct {
>   		.command = "oem board",
>   		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_OEM_BOARD, (oem_board), (NULL))
>   	},
> +	[FASTBOOT_COMMAND_OEM_SET_BLOCK_TARGET] = {
> +		.command = "oem set-block-target",
> +		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_CMD_OEM_SET_BLOCK_TARGET,
> +					      (oem_set_block_target), (NULL))
> +	},
>   	[FASTBOOT_COMMAND_UCMD] = {
>   		.command = "UCmd",
>   		.dispatch = CONFIG_IS_ENABLED(FASTBOOT_UUU_SUPPORT, (run_ucmd), (NULL))
> @@ -589,3 +595,48 @@ static void __maybe_unused oem_board(char *cmd_parameter, char *response)
>   {
>   	fastboot_oem_board(cmd_parameter, (void *)fastboot_buf_addr, image_size, response);
>   }
> +
> +/**
> + * oem_set_block_target() - Execute the OEM set-block-target command
> + *
> + * @cmd_parameter: Pointer to "<interface> [device]" command parameter
> + * @response: Pointer to fastboot response buffer
> + *
> + * Switches the block interface (e.g. "scsi", "mtd") and, optionally,
> + * device number used by the fastboot block backend at runtime.
> + */
> +static void __maybe_unused oem_set_block_target(char *cmd_parameter, char *response)
> +{
> +	char interface[16] = { 0 };
> +	int device = -1;
> +	char *space;
> +
> +	if (!cmd_parameter) {
> +		fastboot_fail("Expected command parameter", response);
> +		return;
> +	}
> +
> +	space = strchr(cmd_parameter, ' ');
> +	if (space) {
> +		size_t len = space - cmd_parameter;
> +
> +		if (len >= sizeof(interface)) {
> +			fastboot_fail("interface name too long", response);
> +			return;
> +		}
> +		memcpy(interface, cmd_parameter, len);
> +		interface[len] = '\0';
> +		device = simple_strtoul(space + 1, NULL, 10);
> +	} else {
> +		if (strlen(cmd_parameter) >= sizeof(interface)) {
> +			fastboot_fail("interface name too long", response);
> +			return;
> +		}
> +		strlcpy(interface, cmd_parameter, sizeof(interface));
> +	}
> +
> +	if (fastboot_block_set_target(interface, device))
> +		fastboot_fail("invalid interface name", response);
> +	else
> +		fastboot_okay(NULL, response);
> +}
> diff --git a/include/fastboot.h b/include/fastboot.h
> index b106d617749..13dcdf919bc 100644
> --- a/include/fastboot.h
> +++ b/include/fastboot.h
> @@ -51,6 +51,7 @@ enum {
>   	FASTBOOT_COMMAND_OEM_RUN,
>   	FASTBOOT_COMMAND_OEM_CONSOLE,
>   	FASTBOOT_COMMAND_OEM_BOARD,
> +	FASTBOOT_COMMAND_OEM_SET_BLOCK_TARGET,
>   	FASTBOOT_COMMAND_ACMD,
>   	FASTBOOT_COMMAND_UCMD,
>   	FASTBOOT_COMMAND_COUNT
> diff --git a/include/fb_block.h b/include/fb_block.h
> index 189c708e2f0..fd981d95316 100644
> --- a/include/fb_block.h
> +++ b/include/fb_block.h
> @@ -102,4 +102,13 @@ void fastboot_block_write_sparse_image(struct blk_desc *dev_desc, struct disk_pa
>   void fastboot_block_flash_write(const char *part_name, void *download_buffer,
>   				u32 download_bytes, char *response);
>   
> +/**
> + * fastboot_block_set_target() - Override block interface/device at runtime
> + *
> + * @interface: New interface name (e.g. "scsi", "mtd"), or NULL to leave unchanged
> + * @device: New device number, or -1 to leave unchanged
> + * Return: 0 on success, -EINVAL if interface name too long
> + */
> +int fastboot_block_set_target(const char *interface, int device);
> +
>   #endif // _FB_BLOCK_H_
>
> ---
> base-commit: 4d3823469724bca19ba4ed3a5a38fc8e951775e2
> change-id: 20260824-series2-fastboot-block-target-c8e9418babdf
>
> Best regards,
> --
> Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
>

