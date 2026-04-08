Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDCE10F9945
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 14:51:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9202C84120;
	Wed,  8 Apr 2026 16:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uD5ALK34";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5204D840AB; Wed,  8 Apr 2026 16:51:23 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C78684148
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 16:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dbb6c072f1so5247438a34.2
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 07:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775659880; x=1776264680; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0mO9y2CvpRrNXNTtw+8WgaVAEEfA6BV8PFHOsXLZi38=;
 b=uD5ALK34CDc5oa3E++58IftaPV9QfRV9LsO5f+/AD3vv6hbxQ8gT+Fc/LnR1ph37s9
 YapJFnUFxYFc82rOLnAgJ48PJJuHztBCIkuD1SBGioevuxECq2/oJVAnw/PUYLNVhnKn
 umsVAY6467w3aMkHKwc3IitOQNsBXKW03ePG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775659880; x=1776264680;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0mO9y2CvpRrNXNTtw+8WgaVAEEfA6BV8PFHOsXLZi38=;
 b=U+WAgxGr0uCT5k2QtSrwFgcuU1hPZE2CTEXPn77gKVd71qEvL5nETawzp8vA+D41GS
 HlZDj4rbSJqW0xmHA8pDYiJKl1UBk4NafCcyaQxT4ULmROy4EdE1Os9mj/IgDFG1A1A9
 FktosgH+beq1XpR0p3M4Ef/8IhluUzXT1ZwvaTM70xvL+jLR/Loa52H7Jz6+3n+8Qwre
 AEl9J3djHHo/xGuOk3oo1YjRJCsNczko3G50aRXKzxKu10EEZIfYGbTnfJbBAVNwgkJ6
 ZGvhOYMRdMwOjt1e1yK3jhJc6MAj26jBHqsIyuzzT1pJ2igrMHzeb/uuYiIxf+XLIksA
 /OQg==
X-Gm-Message-State: AOJu0YzCLYrP04PdLvqlkw5CqFS1qG8sVyAD1gwEX8UTO4TGPICIClJa
 8dnZN8dZ6LScWsnGVMc9U0aWI8eBHcxOyp1R1GCnj96OowmlbXIQ6H9dDrkAv1/qSPE=
X-Gm-Gg: AeBDieu33/8Yra1p38IrQCjIDQoUoWz/ZbHix0KG68jPEboEeZHk0dbFnFyPWkjCFYN
 oYPkVtl1EY6YQnvbVQg1xAlHIQbVjfJbksKz6X7mMMRYSlKheeOmETeFra9nn7UCDn11x/i47uU
 ly3bqq9wXATapdsM8kuyyGBhPoqiP127YuyREtWZ/FfxgUSI7ImXdgCjZ6znka5LyN8jP2tafUn
 SQ71nxfbhw1mXqh18usUup/ePglBqWfqYnjB5D/ZGn+yvPgbyEI6XtNaIVh84BmC78WptqAfkZK
 42UkdXw6fT6/5cd3mb8MKARifSC4aLdzkAcy1m/52oGBvKP7l0cqdfC7CPvtbH2il9nNuBFnQ1h
 jhW+mELyeebg14rAwnFSB0T5t9bNRJNArDmXz/RswHtxKaGgTlSxAVadcbLoIVS3RLL41CfHh6R
 frmhT4tYAFnWTTXWBKhyNdWVVi/3tlwzf2neWyYwxfPeZKk+JRxqAI0rCRkhd9hgGThpn82Jh7W
 sFCPqy28zmY3muuJxfRtrFWlJmW9pth0KtSkxOdrmmFV+e6ItYQsQvR0A==
X-Received: by 2002:a05:6830:d19:b0:7d7:cea3:6d89 with SMTP id
 46e09a7af769-7dbb6f248ecmr16052580a34.4.1775659879978; 
 Wed, 08 Apr 2026 07:51:19 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc081753f6sm1514644a34.6.2026.04.08.07.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 07:51:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20260315235756.304972-1-marek.vasut+renesas@mailbox.org>
References: <20260315235756.304972-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] dm: Respect dma-ranges size
Message-Id: <177565987909.779397.14670435677808110987.b4-ty@konsulko.com>
Date: Wed, 08 Apr 2026 08:51:19 -0600
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

On Mon, 16 Mar 2026 00:57:23 +0100, Marek Vasut wrote:

> Rework dev_phys_to_bus() and dev_bus_to_phys() to respect the size
> of the area specified in dma-ranges DT property. The area outside
> of ranges is remapped 1:1, while the area in the ranges is remapped
> according to the description in the dma-ranges property.
> 
> Adjust the test to test the area within the remapped range, not area
> outside the remapped range, which was incorrect.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] dm: Respect dma-ranges size
      commit: a383c9689282269bb9687ec6c115de094c27fa67
-- 
Tom


