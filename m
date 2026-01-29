Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7AABD6B08A
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 16:33:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 756A08401A;
	Thu, 29 Jan 2026 17:33:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fnAYFoMU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0113184034; Thu, 29 Jan 2026 17:33:52 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D6A183FFF
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 17:33:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4f24TS1jMJz9srX;
 Thu, 29 Jan 2026 17:33:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769704428;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/av3G9v5nNgGbHuL0nGG+H4N3/uQrR8V8PkCq4ecze4=;
 b=fnAYFoMUD+39ZPQXTLhnLpYXKZD5Yi0tRwqIB3a+mVEkQOPVJaOPvvX/4X51ulfELEqynb
 eixDHj0ZXmV1s2ifJUzYcHe2hG1jiK7aaTwIV8QBK0xDc18EWjKFtGi4C83ppNfCJpdZVB
 nvClW66it27uxbfos8pEdNHZYQmTUaR8Vk6fUGUyejM2ccL1/XygXQxQhxrwoiF/Ng8Ad7
 5OevZJYBUtuyllef7yVrtOgFG/owo9MwO7LZU7VR4PkNjByRcIF54lCQUnPXVybyfF6uP+
 ut2upooYGxIqu2Uo8zviCVdlQ75WypdIz5bLM6I4rfAyssGG9Bmde69Je3a0/Q==
Message-ID: <0af7fd1f-7f8b-4ef4-b8ba-9df260fb8f81@mailbox.org>
Date: Thu, 29 Jan 2026 17:33:45 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] gunzip: Add ability to disable progress indicator
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Cc: Alexander Graf <agraf@csgraf.de>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
References: <20260127235914.1503663-1-marek.vasut+renesas@mailbox.org>
 <87wm10mm0g.fsf@kernel.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <87wm10mm0g.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c4423a0a7395e3cd3f4
X-MBO-RS-META: xxqqoyt8i96q4smq477sgg8zc43ywjjp
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

On 1/29/26 5:17 PM, Mattijs Korpershoek wrote:

Hi,

> +++ b/lib/gunzip.c
> @@ -8,6 +8,7 @@
>   #include <command.h>
>   #include <console.h>
>   #include <div64.h>
> +#include <env.h>
>   #include <gzip.h>
>   #include <image.h>
>   #include <malloc.h>

This is part of

gunzip: Implement chunked decompression

so clearly I should move that part here already.

> Maybe this should be included conditionally depending on the command
> being enabled or not?
Why conditionally ?
