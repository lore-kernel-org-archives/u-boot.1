Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC4A7C44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 18:39:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70D2F84CA8;
	Wed, 15 Jul 2026 20:39:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L6M4Ku2C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0C1784CAF; Wed, 15 Jul 2026 20:39:22 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA92484C42
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 20:39:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-69c5fda04a8so8947903a12.1
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 11:39:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784140760; cv=none;
 d=google.com; s=arc-20260327;
 b=EjufCKbrS2BGva3fkQAw6WgVOJd9+p47nHfb6tr3CRDnTSXzjusEdnUpt4yqYUaHUn
 3luIytNatxOidcDcM9h8lmvXGXHxTuw+WeOm1ttt+bVqlfD6XcMsSEEuDzwE3XZFtG3z
 V3cP1j9qnRxmkUtuWM13CkNVs/cutRDFlK+cZwApzR2BYAk3IOp+KLgIS02bKEgtll1+
 T58P/fWDMyZ+wx9z77W+o64C8Ew34NewyIkIy5Wb6xGTwP1UnERUvcJJDlzP/WPcJukB
 btCRvpHML3nPGXCLUv+BSNBZwhLdCLbX9kcoZm1N9MxjOL+CibbwST2MM+n8++Va2aso
 tYDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sgPHOK/DJ7n3hbMwI4PC86Q0vze9uk8z8x8rRfrw/CY=;
 fh=iJRW8VB93FX08DrH3y1pKDG0/UVKiIyyGubq8HI//Y8=;
 b=aEt40edhJsEDCMlXkUzBPBq+jQ6ECS9mFHDqAHr+E1SNVwXc6Qi2/D/uB4hxFLuMph
 DsEQz8YW7qhP/pNDzLnBr+KlPYFoeLpefaJGyJtTb4bQxsawlbXJcm4x+tbbxnZT2Ax7
 sO6GEvD11YEA2MD19IRer/yQLFomv67uPBM77zkg+voeqgjtesybOz8UU50jgQsWRToc
 wyOIb3PaRQVONbmAuXtnM7ZXgZJq1srHJw5cHmvhBJusrh+WtG53BlHtky+DSJGb8nJs
 B7LIex4+Vart9RcqhmY65YlNiKyFbcAbRQKaL5+EC1hsZyGmLbNnPa7mpWxarMNT1Oxh
 SUTw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784140760; x=1784745560; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sgPHOK/DJ7n3hbMwI4PC86Q0vze9uk8z8x8rRfrw/CY=;
 b=L6M4Ku2CXKSxQZ/Hu6cHkv1J6OUpmPqAb4AvNvWTxeHNdGBtk0/msvdL5vnPq5tkGu
 0gWXzlrrgb9amFq26vCQVylGXuSTuHray6jWTZKPswP+JQ+5J/xu6Vk74bHUZY3ZzDoA
 mZsWZh4fSlPIWjrAjfc2I7SDcoWPAHYEs1wbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784140760; x=1784745560;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sgPHOK/DJ7n3hbMwI4PC86Q0vze9uk8z8x8rRfrw/CY=;
 b=C6Ung68J1u45ibUJBsjFO/IBt8w9oRr22/qDXDN6cVDVxBpj6L9iBHqB/+Y64iIPYI
 cbf9J3mA7Z6Ny8m9RT3/BvK+Y9FHnO5eP8gzVG3LLc29qvWwXYy5OIsZ3V3/rjnfx4SV
 JYZN7Mw+SNR3i7PV04/aZNAtGkWXk1fWPKIoK5G+g3T8BlE5c9+L0ipwo3pVGv6ITe6p
 bDq/P1mzGGUMt6fcCG5ae5Fi1cvt/T21y/FIgd2iuQQ/U31+EYX7Q3EvG0DuXPTlQh3B
 9fSXVELRRYaonkFqOpYj+JGw5WEVDvBUlXtg3SiBRxfjuOeI0RoiAeoIFxeG0zZiWU7O
 cu2g==
X-Gm-Message-State: AOJu0YywJKbeZsc/2aZc7Ez+YNLnG71oFOg2GiFMJgnOX7lpsDUNeEIb
 D4HCVGIIjFkm0Hk2kCln4rFPFG5UN6PM7Ujflis6lbK19STVGCs4yqd1DkbagVgAPP0PgpN8yVX
 iQ/2gEmXpGJzIjXY5Lizceky0rI/m6norxfNxMQzI+loJk60NhdCSOw==
X-Gm-Gg: AfdE7clC6CPM2SuPn4zmMxOLg6doxBrnU+7a32CxFlKnJRJoldy0yRKJAifLiG1nWTO
 e5cGlP3b5UPITV+t94+j+3VFz+8N8eNYjfi9yq8u42S4bg0B76IYqqn9HF43FsyEWL11z9jJcE+
 KgqreIyCARXLqruGPcfENUFBCpxV0L/X1lZVK9z5fzt9QuY83kdEt6X/ZAVsCuWfgsZ0Ji0Cc5z
 h04ve23DgIawC2W8I+MykL6QndQYuNMHvXjNbie5n28Do71somzNiYZqks4C1cq9T5FJNQ=
X-Received: by 2002:a05:6402:2685:b0:698:aa8c:c15e with SMTP id
 4fb4d7f45d1cf-69cd2b3eadbmr5464554a12.25.1784140760306; Wed, 15 Jul 2026
 11:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260710-rinta-watchdog-gettime-v1-0-9a982fb93f49@nokia.com>
 <20260710-rinta-watchdog-gettime-v1-5-9a982fb93f49@nokia.com>
In-Reply-To: <20260710-rinta-watchdog-gettime-v1-5-9a982fb93f49@nokia.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Jul 2026 12:38:18 -0600
X-Gm-Features: AUfX_myQWu-zSWgpkKK9c5qgTbw9dy43uaUyLfcgC9FVAgAgdAzmJRa1V26wpIE
Message-ID: <CAFLszTjE1K4xpaBXOtYFUn2G_ZdSjCYJ5sLZAeKME4RHPti+Cg@mail.gmail.com>
Subject: Re: [PATCH 5/6] watchdog: sandbox_wdt: add get_timeout operation
To: juuso.rinta@nokia.com
Cc: u-boot@lists.denx.de, Stefan Roese <stefan.roese@mailbox.org>, 
 Tom Rini <trini@konsulko.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Yao Zi <me@ziyao.cc>, 
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Juuso,

On 2026-07-10T04:51:17, Juuso Rinta <juuso.rinta@nokia.com> wrote:
> watchdog: sandbox_wdt: add get_timeout operation
>
> Implement the get_timeout operation for the sandbox watchdog driver.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
>
> drivers/watchdog/sandbox_wdt.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

> diff --git a/drivers/watchdog/sandbox_wdt.c b/drivers/watchdog/sandbox_wdt.c
> @@ -43,11 +43,20 @@ static int sandbox_wdt_expire_now(struct udevice *dev, ulong flags)
> +static int sandbox_wdt_get_timeout(struct udevice *dev, u64 *timeout)
> +{
> +     struct sandbox_state *state = state_get_current();
> +
> +     *timeout = state->wdt.counter;
> +     return 0;
> +}

Since sandbox_wdt_start() stores the requested timeout unchanged in
'counter', the effective value always equals the requested one, so the
clamped-timeout case and the new 'requested' print in wdt_start() have
no test coverage in patch 6. Please can you make sandbox_wdt_start()
clamp the timeout to a maximum defined in asm/state.h, so the mismatch
path can be tested, including the console output via
ut_assert_nextline() ?

Also, please rename the parameter to 'timeout_ms' to match the ops
declaration in wdt.h and the other drivers, and add a blank line
before the return to match the rest of this file.

Regards,
Simon
