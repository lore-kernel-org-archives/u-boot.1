Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1ABCD4F25
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 14:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AC76846B5;
	Fri, 15 May 2026 16:03:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k+UzkTS/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 331B3846D5; Fri, 15 May 2026 16:03:30 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42AE7846A5
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 16:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bd3eb594960so398590566b.0
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 07:03:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778853808; cv=none;
 d=google.com; s=arc-20240605;
 b=bG/jDEZDB8ofsXNxfFBbUCMwbQBcp9lUnkFk7ScTlbo/u37uB8EvYmX1mpDTK14aiB
 elF/CO3nfC9jYGx//VOpj6U5EY1xjkInORPvALWCehdVYCxgF2YEaSy1kniwAqjqULQp
 NjExFbgUcbTx2f1f2X3tfWS1iVQSgaJfNT7ySleQvrjkLbrk1UrRK+0qyn1ttY9GsM+V
 6EbImo4zFPhDjmwrv7NZE0WN1wJ+C5PcDGvv1ZoTCAjoQOs0SfBbhUy/KEJEtWTHRnso
 SZDxqqfxw8jX3wEVf1yBwgWPOHwi3MfJuDP+IJD542w+kYxnRREADCJupnuyPywFg5W4
 vH+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YtqQUJkAFML8UjvxRNId7AVrd6aXlndYVxN8ZSnPNyY=;
 fh=+ceJQh3oVwWvE3LiSVLh/MmNmprgA9HTP18ogsdfNYI=;
 b=TUcvi50hVaoyRC0F9wVbw+SdBTLn+1/khb8zVjbtURonelCuuP4rlYXg+zEgtLmnLY
 isTZUfttjk0FB+ndrAvmuvKOprEFgfl7R3mFgPPWi6ofVGZmjufF6uy1VXXPDnlamGM0
 Sjn27xj6/vZusnuAFridGuKu1s1ziNpCyttAdmTkw2M4ZCOVnzeYPdBHzBo5FdGj5Mx8
 F86qHFMBv26luR17N0tauAJlIWNEOtHbZIjeoeqJY/S/qBMRzIwp6dr1f12hUU7HIfH7
 B75NuEDB/JfJAztaVwwnxoj/5lGiRLQmSo1r/Z6PjxkzerhajrBJD76Y+4N7afKO0tND
 XIgQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778853808; x=1779458608; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YtqQUJkAFML8UjvxRNId7AVrd6aXlndYVxN8ZSnPNyY=;
 b=k+UzkTS/emOZ2Dh7kj+fcp8szQ6qnp/pRuToibBeE8z97NXXJb+AUtg65yGGWBBjtW
 T9lnVo11L40HydbRLU5G6ksjO2jhRusR1Pywpsz0iU8IeI323KZRLXYCJjBOmixoUDkm
 CE2ViL/DFCV5sURV9Lf+JmGUcp1BIMy8H4gDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778853808; x=1779458608;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YtqQUJkAFML8UjvxRNId7AVrd6aXlndYVxN8ZSnPNyY=;
 b=ixuD1VhcSuJVzqh6/N92sML/zbQDd2cBhkqIW2oXUPTOocz0YWXw//U5hlLehShBVw
 +uM/wN8vc2e4BcxMdeJxz9LvudwIDdplcnV3us9B/H6XzAL1eurLDND04LLRAonmQ9H0
 ncUqB+0Rk/+vqPYc9Ak26Y7+M2UXXypAOi+6l3PJLnRtByIavAdA3gE4uzsNcdvn1wOT
 O9yuw9brUpe5UDl82xrdE6u0scXdhXbnYGwAVYkP8T7NbqgPCvVZp0mv+mC6j2UeG7Ex
 UeFbfX8hnEm8Z+QjvmLCfEWXYbsfIflGblyNzSm4YWm5TJpw1uNp8cOUq9vO11BIOT29
 NJ3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ULGD4e3vt9HCFPpGbZXEgrsmZ2QONhOYxLMf8Fg/gx/nOTgfcsmSgOEAeFNZ8yFIIim490og=@lists.denx.de
X-Gm-Message-State: AOJu0YwI3jhpggB88wqagnRQ/+3GI3wkGuO32MFkuYFuNutYL+gE6iFq
 pcz9QE0b1gbAKD1YWqt+vhNBolfmVxrq7TFxP8kLpQV/cYXc3Ow5IGcos98zbfZI3IRw79d7Oat
 /5MNLP/2dGmqI28x/QoAfqWSyitY+xafXAH6Dn/Tq
X-Gm-Gg: Acq92OHnSTkF+ZcwQLuXR7UbegMqFy7OPNR6SOHl/d9jnHGkyKmIRC/9tu7gkjBFCVI
 dcr9nEuc+HFOesLlxselTrTaMqCmpRbFJ+bdykoYhrifoaZxEAtLpZcY5vQs8I6AeNp0rqabmGR
 mYuBL87lSAIw5dzgFRU6Mtm7WIfGPQUu4Cj+hK/eTAD6fW/Tc6ileiTNjXSctqauiPwhtGjC3lL
 XonimnLDZIJzuOnH5+wkOJHrYqpcRTQNOkU183oH0QbAWF705MNNYNqMk7Jy7q/9YMTUJnh8wZx
 vbvP9A==
X-Received: by 2002:a17:907:6d04:b0:ba7:fbfb:4caf with SMTP id
 a640c23a62f3a-bd517aba010mr202365766b.43.1778853807429; Fri, 15 May 2026
 07:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260513204943.736142-1-rs@ti.com>
 <20260513204943.736142-3-rs@ti.com>
In-Reply-To: <20260513204943.736142-3-rs@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 08:03:15 -0600
X-Gm-Features: AVHnY4JXBsSn7nb9JGB_V1ga5uTZ7bY7TEp6KcgQKw47qDgPx14EhayHK8gnr8c
Message-ID: <CAFLszTjQXbQVx11QyMRW4FbpdQ5B1KPRWO28O1ssSVznv8KYpg@mail.gmail.com>
Subject: Re: [PATCHv8 2/3] test: boot: add a fdt reserved region check
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org, 
 u-boot@lists.denx.de
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

Hi Randolph,

On 2026-05-13T20:49:42, Randolph Sapp <rs@ti.com> wrote:
> test: boot: add a fdt reserved region check
>
> Add a image_fdt suite and a check for boot_fdt_add_mem_rsv_regions. This
> will ensure the user is properly informed of any reservation failures.
> It will also validate that reservations are cleaned up correctly when
> switching FDTs.
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> test/boot/Makefile          |  1 +
>  test/boot/image_fdt.c       | 70 +++++++++++++++++++++++++++++++++++++++++++++
>  test/cmd_ut.c               |  2 ++
>  test/py/tests/test_suite.py |  2 +-
>  4 files changed, 74 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/test/boot/image_fdt.c b/test/boot/image_fdt.c
> @@ -0,0 +1,70 @@
> +     fdt_sz = fdt_totalsize(gd->fdt_blob);
> +     new_blob = malloc(fdt_sz);
> +     ut_assertok_ptr(new_blob);
> +     memcpy(new_blob, gd->fdt_blob, fdt_sz);

ut_assertok_ptr() only checks IS_ERR(), but malloc() returns NULL on
failure. IS_ERR(NULL) is false, so a failed allocation sails through
and crashes in the memcpy() below. Please use
ut_assertnonnull(new_blob) here.

> diff --git a/test/boot/image_fdt.c b/test/boot/image_fdt.c
> @@ -0,0 +1,70 @@
> +     boot_fdt_add_mem_rsv_regions(new_blob);
> +     gd->fdt_blob = new_blob;
> +
> +     if (ut_assert_console_end())
> +             goto switch_fdt;

This doesn't do what it looks like. ut_assert_console_end() expands to
a block that does 'return CMD_RET_FAILURE' on failure, so the if
condition is always 0 and the goto is dead code. If the assertion
fails, the function returns immediately, leaving gd->fdt_blob pointing
at new_blob and leaking it.

To defer cleanup, either restructure so gd->fdt_blob isn't changed
until after the check, or use ut_check_console_end() and handle the
result yourself. The same applies to the
ut_assertok_ptr()/ut_assertnonnull() above - once gd->fdt_blob is
mutated, any macro that early-returns skips the cleanup labels. We
have a similar problem in the bootstd tests...

Regards,
Simon
