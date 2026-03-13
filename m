Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBFF105F7AF
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 15:00:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A168A8430F;
	Fri, 13 Mar 2026 16:00:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f/nS1fOl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73C7A84366; Fri, 13 Mar 2026 16:00:17 +0100 (CET)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41C2284307
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 16:00:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-404254ffe8aso1411237fac.0
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 08:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773414014; x=1774018814; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nMS1kOfy/LeeF3Xmepuu+rtWdEG7MMSSRb9Ls864d0A=;
 b=f/nS1fOl5NrqhDPlWTmF7iBzwch+Cscl8eSFyA/trUmXitPhCAP+AA8xMA+oY5l+sr
 zzkqHhbSjX6fFPBIGHrQMVCTjXjfKW6jMbQI+oB5FB26h+O4yi2N2LaD9nzTAPRM1LaC
 +i3etoVDaBfcxf90yetq/wLfw6df9cjrpemhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773414014; x=1774018814;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nMS1kOfy/LeeF3Xmepuu+rtWdEG7MMSSRb9Ls864d0A=;
 b=HKiL4jJSamiLKlr6AtR45WbdHInPPxcWgFQwxvYm6PCJQYu+9PUkDe9Wf7rMebvNO7
 5dsGyMCd1oCrVBwxe+ehstGY4pauTtyjJ3RpaAMgAgx3F6QJNfPJifbi9r37SmXI472Q
 ctkQ1a8I5SLNGagnd5tgg0yjiafzzD3hD/Zl6X3HUjiZI7w+FAVT57D0PW5wWJbC1kYG
 XePhaDIFfZhfTiannjJsGYFkyogJmxAqG2rBBMGSLaFugvRLJeBzWin7g/Hf1+6AYhwJ
 It4MvlKCIcUyuvWrz2y/xRFwMS2WYi4xhHL6NH0cV1b+16HODORZ9xpGNEQbdl6JDET5
 lNGQ==
X-Gm-Message-State: AOJu0YwkV5ciQJKkLf3YNauQUAKgqHBT7kYe39Fr2zgL7DQBikDirGIs
 JgXzBe4jBi48fcQQuTVFqnuWEEH+y/4hskZXaxhh+qaYk8r6vZukoOEOk+ctbF51eN0=
X-Gm-Gg: ATEYQzx3HKMx9n70N5TclFzX7FWhGv/MympCW9SrLbwyqgXQiNdYLjm+DYqgu804ZVX
 EOuDbDFFsZQtydEudSiE/bZDuGj/xWXc1sIX8g4DBbZ/4nbSsm5KWDwJDq/AjfgkWR0Cn+ycsEp
 Y1fChtm5EoRGv/NLHco9JomcmgZicP640mHg5plMvrl/0ZvP9dPHg3QDJD9Hs3s5kQEaaSGYWPQ
 JjRuw0l9hEEw8uj5S/tu237+DSPXn8RSJRNXsdvjdJ6pLZEGRx5z7isf0M0Fv2Kf3jS57qZI7/g
 C+CW7Dgmz005cnfbPZ1s6rOf9E3qEwmJewFUv76vG9DefZWV4fspqACWMJ39JNiz0c1WNL73khQ
 h1QRa4lXC1giXqXADhftfJpTphTIy6nm2s/mABiUrREDQ/G0Wn1wHsrMOdcb2okdIJGfS7vQ5a5
 MPo017TzsF6RbEJ8Hyl3CYuHByazjC+pD2i113DdBFBlxIxUtpB/+Owc4UatjhiZE/Ppz4BQsZx
 I+8QObZ1Yd9F3uEyxf+45nS7WBZSY0ArPrwzf6MmliO5ro=
X-Received: by 2002:a05:6870:a495:b0:409:6148:e23e with SMTP id
 586e51a60fabf-41798ec532emr4303747fac.10.1773414012551; 
 Fri, 13 Mar 2026 08:00:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e69c79dsm7699563fac.15.2026.03.13.08.00.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 08:00:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: frieder.schrempf@kontron.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20260302085508.39076-1-ilias.apalodimas@linaro.org>
References: <20260302085508.39076-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] kbuild: fix cross_tools compilation
Message-Id: <177341401139.1035624.13055337202081311292.b4-ty@konsulko.com>
Date: Fri, 13 Mar 2026 09:00:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 02 Mar 2026 10:55:07 +0200, Ilias Apalodimas wrote:

> Frieder reports that after the kbuild sync running
> make tools-only_defconfig
> make cross_tools
> fails with
> 
> UPD     include/generated/timestamp_autogenerated.h
> PYMOD   rebuild
> tools/Makefile:359: *** insufficient number of arguments (1) to function
> 'filter'.  Stop.
> make: *** [Makefile:2191: tools] Error 2
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] kbuild: fix cross_tools compilation
      commit: 4cbb1c4d99780a8b0e476dcd10fb242a5c823bd3
-- 
Tom


