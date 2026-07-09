Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E664C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 12:58:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBC2084AA4;
	Fri, 10 Jul 2026 14:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="k/5epf/D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAE1984BF6; Thu,  9 Jul 2026 20:36:35 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0051484A78
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 20:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-698bf053053so188660a12.3
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 11:36:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783622193; cv=none;
 d=google.com; s=arc-20260327;
 b=O/uiOls5ca8Dg4ejabq0lHdJ2nmlhfqeLQf3Y4zwxWrd+oJsYYYylLD42p2GT1+mM/
 AGKVUkjaZUJMRg8Uk0qV7cjm+LGrK9UvERu3xTwjgkot6u1yjFGTNzgN7aZRay4suc2M
 NTmhFEM9W8rkjiAuHyhVT1wPBwze+Ddm2noL+6SML9cDAU80AgotoYUnqVI2MVTyxBPQ
 Jwo76R6vnZvqEgsntg020SFToKQZULy3t5OiChgQ8rm3FOLp2gAFX1Jgy0mVHhEbFIg6
 S2AboWngSFHS8DZZiYl0oYiNMJlQyvqn6p9LDt/mgiedxDjxBZBwKdx71zId87p5qHNG
 tjoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VOHDsTIi/eic8iL5jOdWRdyy8XBwZDQyMSIKKrCtAZ0=;
 fh=syXcLE83OFDraqGbuQhMyZ13Rvk/iT7U0hwLRfOyT4s=;
 b=Iwwa+5VgOzTlMo6kE73qLwWhp9Fvr4CwWiwq8tvoPbixe9c33XzInSR7NuhnLQqvVX
 DUq3cqa6EE7OiYvW9UyBuv5nlGoG9EvmY34QUUdtjb2W9IhVNICyqUFecGAOz4TxdKAd
 P491div2ObA4zVvIm0ucTFK9t9QgCzVbNaxIRhKuGLjffZi5mebdHkQMm46syVmzWdPt
 BR/P9P4njfSiMn0RLJJYlHBu83wxXpkrC81l7gWI0RVI/ycbJJV6JdO/ihYxP6WMkaPP
 TmAM0KGz8EwAuDgnZkjvkfwV9YkJ04gO+PhcMMIa/k55ZE4zXqtlALyVu56DhMTG9yi2
 Vrew==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783622193; x=1784226993; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VOHDsTIi/eic8iL5jOdWRdyy8XBwZDQyMSIKKrCtAZ0=;
 b=k/5epf/D7cRIcSnry0Dpz9Aie0ZI+nEVHzwm8pTi6MB2caWV1eFC096Yk1Osr+iPjC
 hL94+zcJ6jj9xsiZ1YKikUIHcb0fhDlG4zSnNyL0PSiVKIH038F3eiZsu3VZaY9oIs89
 5DIaDa1n6m5bDkXVfsL0A3C6dXTrtTOOuy8AE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783622193; x=1784226993;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VOHDsTIi/eic8iL5jOdWRdyy8XBwZDQyMSIKKrCtAZ0=;
 b=DND+V9JoReBDYv0br0qOOtbu0UUvaHYWZ/TEiNOF8lMf9snsMbFOcPLYmz1F74oEms
 Uks/9lfg6KQHfaWWEMInPcAbjjDm7zcDVE1TDrM3uyfYn1qwcNdTnAI2ZG7gLaajZG4Y
 ejkW26696CYZ2FyKAO6JPTmYHuEIRr71ITQVN90J3cp858JcCh06w7G4pEEk3VO5lNU/
 0t70ljmE1KAVbzdidGVTp5LHRVKJz2hUR9vgBRaB8lP6+dslbFF4Huvm+SIDEwauNr/0
 VGbatfvOzUdXrH85aKd2bYe5LkYbDFk6I6dyzQNzJohyg6f8oJ1qQD+iL7WnJQUTcRT7
 5Jcw==
X-Gm-Message-State: AOJu0Ywa3P1cytzCMb+F+gfUYcuH/eI5ORZ/0TO/6CGsBtgigxc4C5cG
 s76yRKUr3SDTTp5nFUBOcZE0PBSn+mpFuNqhLuGSYTXpLYaRn1cymBkV8AL+iE6u1ZGz9/KAD2x
 Dxs8wbm85JKi3JjDnt3fKSvYNzlzf48FxL3kn8rPZ
X-Gm-Gg: AfdE7cko9REZrwwgKH5ay4ZpHeIcfv7GXCR94ICALpjTiKBWC/pYnAPK4c5jEbD5R1T
 oI6wUoQd41qr20TXXmlzWI0DN5VMowkejCct7FLBun+NVOW2zb7IVim16YstBniDIxn53GW+pBy
 313GhXYQRKAh8B2aMaZwHliZiNOWz4R4VX6vY0GdZzcUPU+/+toPObbmoqVm5gO+r5WdA/hUl8h
 rAHAQRzhPDSy3Spw3dG21mruejgPzHUmuYc4pNZtr5WTU0oHxqOCLsm8jwjoT8cN+wnSiNyea8m
 60Oe7A==
X-Received: by 2002:a05:6402:3226:b0:698:ac05:5b40 with SMTP id
 4fb4d7f45d1cf-69ab4453cc1mr3703506a12.2.1783622193511; Thu, 09 Jul 2026
 11:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260702-submit-ce-series-v2-v2-0-ffda5bed58af@gmail.com>
 <20260702-submit-ce-series-v2-v2-2-ffda5bed58af@gmail.com>
In-Reply-To: <20260702-submit-ce-series-v2-v2-2-ffda5bed58af@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 9 Jul 2026 12:36:21 -0600
X-Gm-Features: AUfX_mz9GbVLtG1KWEq79CCwyDwvmTZpjqnrLFWY5QVSE9C-64ECJO55mIUG4wk
Message-ID: <CAFLszTh828s7+gYVz4rj=Jy+4Cizyr8nJ+e9xEwO+AjPBC=rdQ@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] crypto: aes: allow DM AES in SPL
To: james.hilliard1@gmail.com
Cc: u-boot@lists.denx.de, Svyatoslav Ryhel <clamor95@gmail.com>,
 Ion Agorria <ion@agorria.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Randolph Sapp <rs@ti.com>, Heiko Schocher <hs@nabladev.com>,
 Alexey Charkov <alchark@gmail.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>, Johan Jonker <jbx6244@gmail.com>, 
 Francesco Valla <francesco@valla.it>, Michael Walle <mwalle@kernel.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 E Shattow <e@freeshell.de>, Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Thierry Reding <treding@nvidia.com>, Francois Berder <fberder@outlook.fr>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jerome Forissier <jerome.forissier@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 10 Jul 2026 14:56:43 +0200
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

On 2026-07-03T01:49:45, James Hilliard <james.hilliard1@gmail.com> wrote:
> crypto: aes: allow DM AES in SPL
>
> The AES uclass Makefile is already keyed by CONFIG_$(PHASE_)DM_AES,
> but there is no SPL_DM_AES symbol to build it for SPL.
>
> Add the SPL variant so SPL code can use UCLASS_AES providers, for
> example when decrypting FIT images before loading U-Boot proper. Select
> SPL_CRYPTO from SPL_DM_AES as well, since drivers/Makefile only descends
> into drivers/crypto/ for SPL when SPL_CRYPTO is enabled.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> drivers/crypto/aes/Kconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
