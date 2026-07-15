Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B27BC44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 18:39:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C38A84C90;
	Wed, 15 Jul 2026 20:39:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hAH1A2Ah";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77E6D84C42; Wed, 15 Jul 2026 20:39:14 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D6BB84C90
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 20:39:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-69a50b818c8so9674715a12.2
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 11:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784140752; cv=none;
 d=google.com; s=arc-20260327;
 b=YjmTrdI7twrMYgUHXpPzxU7e7DcLyP8aDsHNzqQjd1/YUSroObtQkqAeorYvPTsi8a
 EcRNa5CC9MZTOwbE/Z+Pyx2NBKCSfXI+gkTI9XOvlUEAqLe2usU0vpVKEeKQj6R6BZ7C
 CSKCRpkAVSzgPRcEu+hhWp0EqQ+VmKGCoJ9C8ZxKbdTz5coSbJ7SUXsMuccoa1U1pNfm
 Qx/SOJH7n58hwF9+QcVj58rko9DAVam/vhQcWuJf8o8gkwGzxh/oc5bAUn7YbbBG0w6W
 GbBSzsWiujQxdPRSwMURrKWYhKcw4wXHMdRrqTlRQAlhbXR9Z6U8VOGT750vDkxzD/rF
 zmbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=c3C0xU8s9O28Voz9iZwALgjAy7CGkTlyvx2jrFKrAE4=;
 fh=iJRW8VB93FX08DrH3y1pKDG0/UVKiIyyGubq8HI//Y8=;
 b=E70lsEGFlRK9gzJDyB74JN8EFcLhzAzBe+F1YKa4aUIm+vJyU9JJPxj7AwXxwfroLs
 wdxCMGwePR9moF4pbWaqjKwxMRs8RjlwVft106+1ZmJq1MxSwygHXy7yRa99E4Rryw5s
 5A2HNP7XTtzg7VouPKvBuIH62TwNz9u77uklq5ulRTW0ahQdOjVX25Phw1SIiPidjHN7
 vKk47nqTWNRh1fnRDpBdWe+9F4tZoX1Z2uJRl9/XA+iry32dde/00OeAmCI28Qs8HqR1
 5LNs1oRn4UfG6v2LKjBmY81RPKls0NbTLlpdWxlGAC13H3v0bsbq6ncF4NXPqXIh4ElZ
 ss7g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784140752; x=1784745552; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=c3C0xU8s9O28Voz9iZwALgjAy7CGkTlyvx2jrFKrAE4=;
 b=hAH1A2AhdLDsvle0pGqRrewBxWc6PdOnpemlKUxUVQTNX6xP4Khf6IsEsewbvwA5Gw
 D26lc24pDo4kG1JjS29WEgtiHgPM9af/DgnPYaaye3mZdhlWWMd3YJdaZb3TXHRg4ehQ
 733Qe7DLmkDBXXHso/ZmIv5HwGy8MF0nJSirw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784140752; x=1784745552;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=c3C0xU8s9O28Voz9iZwALgjAy7CGkTlyvx2jrFKrAE4=;
 b=cyVLJxXcKtP0gSECcDGATsuKKfZ4AfebfbexzodpTT99BLCnls8OUHgU9wgigxldjl
 6YQSB0BJCunQKw3l8+TkrUxikiZpLrZO9fQkPHEAqdSm1JyT7ydUgaslTt9dm7cxNb2e
 5iRVUIIP1DZPj2cF5rAabquITJD8vKfXWaq73oSu1jd3onWTZMxKfS6RtXpy4vD0oijM
 MNVCF3nD50GCfXMitRJEwMKAbxqhuV+7NBWdgrk9NPOTyLliXkk+K4mJgzNObAj0oNJI
 PCZimtitF0IyWQZ+Fkc07kGohBG5JXRxWPm+G2VIeb+Qxjy1t/dfQyxif8wuEf/CTcjA
 6j3Q==
X-Gm-Message-State: AOJu0YzuRAis+Es1BBUy0cnk1dB7BAdZ+5rusx7CEdQGZOXIs3w4W07d
 cF5xvHy++aD5kLdiCfToVKI0n0tEE6xo0a6RRBgVVrryt1j9POQ8+fwROyOUuUhxL3bZoiM4cg1
 PMjObUonnp8nGPUi+XZVkMhWbb0xMjL1qPFSpPofN
X-Gm-Gg: AfdE7cmZ4+6Ns+U/s2FxYaoLHuqxa0UFs3SNzWGN4r1BFnQpsKgBhuUqJjD1hCX0sN0
 mdtKo86Dj0nf1iTXMRlhfNMOBAEfTZer4d+5Bkt75Ir86CjYKXbw0xxeTVjEOQRu5wvDepRM9s5
 cctN7JTcDB3J7dF4+lRBzO4+UL5UhHQPDKjGLmP6spCFsSlf75TCDBCIlRalp+V50Lt03/7D7z/
 ic9Uti+FANbA2T/8VX6h04VGlVDXfHmAWpObdiUHHmzsm0i8L0llbhV/CO1pQZrU8JV30w=
X-Received: by 2002:a05:6402:2691:b0:698:3b7c:7e2c with SMTP id
 4fb4d7f45d1cf-69e19eee376mr2462665a12.36.1784140752087; Wed, 15 Jul 2026
 11:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260710-rinta-watchdog-gettime-v1-0-9a982fb93f49@nokia.com>
 <20260710-rinta-watchdog-gettime-v1-4-9a982fb93f49@nokia.com>
In-Reply-To: <20260710-rinta-watchdog-gettime-v1-4-9a982fb93f49@nokia.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Jul 2026 12:38:17 -0600
X-Gm-Features: AUfX_myvxj547j5TBQY27tarWPEO73wOrDmifs2GSo26I8KScL0PIJ7be3inTGM
Message-ID: <CAFLszThoX3yUjQAsMaRjYc03dMbT+S1y9wp5DUn-9a139yBbZQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] watchdog: octeontx_wdt: add get_timeout operation
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
> watchdog: octeontx_wdt: add get_timeout operation
>
> Implement the get_timeout operation for the OcteonTX watchdog driver.
>
> Add a timeout_ms field to the private driver data. octeontx_wdt_start()
> stores the timeout after applying overflow clamping.
>
> octeontx_wdt_get_timeout() stores the effective timeout
> in the timeout_ms output parameter.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>
>
> drivers/watchdog/octeontx_wdt.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)

> diff --git a/drivers/watchdog/octeontx_wdt.c b/drivers/watchdog/octeontx_wdt.c
> @@ -61,6 +62,11 @@ static int octeontx_wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
> +     /* Store calculated timeout in milliseconds for get_timeout */
> +     calculated_timeout = (tout_wdog << 8) << priv->data->timer_shift;
> +
> +     priv->timeout_ms = clk_rate ? calculated_timeout * 1000 / clk_rate : 0;

The comment is misleading: at this point 'calculated_timeout' is in
clock cycles, not milliseconds - the conversion happens on the next
line. Please can you adjust it, or fold the two statements into one,
since 'calculated_timeout' has no other use?

Also, when clk_rate is 0 (possible in the gd->bus_clk path) this
stores 0, which get_timeout() reports as a successful 0ms timeout, so
wdt_start() prints '(0s timeout, requested 60s)' - arguably more
misleading than the print this series sets out to fix. Better to treat
0 as no valid value and return an error from get_timeout().

> diff --git a/drivers/watchdog/octeontx_wdt.c b/drivers/watchdog/octeontx_wdt.c
> @@ -88,6 +94,14 @@ static int octeontx_wdt_expire_now(struct udevice *dev, ulong flags)
> +static int octeontx_wdt_get_timeout(struct udevice *dev, u64 *timeout_ms)
> +{
> +     struct octeontx_wdt *priv = dev_get_priv(dev);
> +     *timeout_ms = priv->timeout_ms;
> +
> +     return 0;
> +}

Since patch 2 lets 'wdt gettimeout' run at any time, calling this
before wdt_start() returns 0ms as a success. Returning -EINVAL (or
similar) when nothing has been stored would cover the clk_rate case
above too.

Alternatively, avoid the state field entirely by reading the register
back and reversing the calculation, e.g. FIELD_GET(WDOG_LEN,
readq(...)) - that reflects what the hardware is actually doing and
naturally handles the not-started case (WDOG_LEN is 0). What do you
think?

Regards,
Simon
