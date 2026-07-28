Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0EFC54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 13:00:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14B828144E;
	Tue, 28 Jul 2026 13:00:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9fb-6Ek5lhuK; Tue, 28 Jul 2026 13:00:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 59BD281301
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785243636;
	bh=nwVVcOyO6/7ljRLEYJezFPxuKrDtpl6VLmLODibxGdI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HezwODB23cGOgSME9+PFU2AHM3TjAfbMEsgiFuIqhP6xDsDQZ8laiZVN1rdgF3F37
	 i9q8ghBv+tA2pkUzNul22a0ujrJ+H/ti2VW9gtvUxgKhBZvIrRFal5DNprW8ZIhCO5
	 1z41r+t1/NeUze2hLHsXKAz3jrmR8Hkt8keiY9usCYxq1fL89v48O9pRaLMITGGpT+
	 u0AAnAoL5c41mSYLVkDAN5FW+X9kbAWAKWQ0kkAUYmScsTAF53QVyMKpbz3xQ/Eokr
	 Uzjp7VgAVZCC7QbSFnkbXiTRs7fTC6sxhdyVUmzd5ES4CAfbcsQ7FmDP8EfmThvRKd
	 OgXOcqfFXbN0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 59BD281301;
	Tue, 28 Jul 2026 13:00:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F1714788
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:25:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E3348607B6
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:25:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AQeUznKqL7jZ for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:25:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A5C0C6077A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A5C0C6077A
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A5C0C6077A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:25:38 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DC918494B; Tue, 28 Jul 2026 13:25:37 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF3DD848BA
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 13:25:34 +0200 (CEST)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-698bf053053so5500129a12.3
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 04:25:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785237934; cv=none;
 d=google.com; s=arc-20260327;
 b=iLHJgtIp5NcYSc0cWMXulFRVKwHBqhHKgFU6I/5MI6LtRESVyD+ZvcU3Y77kEG/gkW
 0+W7d9i9EBjALESTL/Xrr0iqCNvCOMcgpCiMaWw6z84QByjm3EEdySVLsZFgVXvhAbOE
 oQAzzfb3byVuN2nTWOaL0zvg7DAw8i0y5lNh8HZ84j5IIueWO5/FQA0OXqZc3GvzJdLS
 /6PMcHWRP78ayl7H0R7neXm2ZFQhYwuV9MyUDRQvcSQEFoRtpzGoIScaSdHj4eDw6r23
 hQdjHNOo2sRVYw091mzfCB13tSkfh4vUkOMABrLqQBTiiIitVvYtfyYp1ZBHKL+Yzhoc
 0qNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nwVVcOyO6/7ljRLEYJezFPxuKrDtpl6VLmLODibxGdI=;
 fh=2p/Zgw9yOkwhUenPrxXFLXl/+pb/Vg7dA1Gd6Cm/EPI=;
 b=YOjsPjCJJzzOlOFqud4+kDFi9le170d9tVslZCWxyf1pHoZiFp0LGfzbgymfdcj3Fv
 tKC01NxaYhYoWYb8DEkZIn6l+Y6BJ/nteFT3G7UInr21CBS3yAmQAnNIansPwi9N+T9e
 7elgbBJjm02/CKzRyjgiRpf9PibykcUrUvyl3oSoBiAvXWDrT1/cepfDcDz7zpkl28co
 W6pgIMJbE5vYVjCSGOjuHpiGpDKa70K/fPhMRgY7ICJTDHqyPFqCR/XYtrgL7u2gcagC
 nidqBY5TkF3KhVolDVpNxpjvvuO+9cAlPoJfxA5POP8xF/GDFlD0CL+20ufHIvAXWsEp
 QUwQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785237934; x=1785842734;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nwVVcOyO6/7ljRLEYJezFPxuKrDtpl6VLmLODibxGdI=;
 b=LtX5q89oTLgDJSQw9lmh228yfrp8gZ5akgCfaW5xpQiQQMX7Ontc7ecNqlW/y1MtFf
 kG5SYCQuGiMQqcLGo4Hccnjooo+LaaIqlG+bSXmjyhvZHFit4w/9Y9w85Oj8iQ6aBqq9
 cy66+LJkJUk2ZgMLlCiDb7T4owDV4X1Z3tx2AqOe+qjFy2p0TYVNCPd/9bO4oILjMmKv
 m4GQjAacHECz7TVXIsszu0iXZuBVfWUMdi8seUrQgVKwCvHXX0CDXCYbL7TEAqKSLzXU
 57FyWb9qU65IJ5QwYmRuAd8FEq8pfy91wSOMraOJVPKGWpqLvKtdNyJdCw60DtU/Thkd
 IL9g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp9tq1LpvrZu6rwEmI/fXdEZUZ4V3H2idp3aRqdsd1mcSvVVkcPebpsfpuV+HJhqL0SWdfgfVY=@lists.denx.de
X-Gm-Message-State: AOJu0YyZC3BWgv8weqjRocN/ygcPY9Jax5pWaScLLB0h4AOSYSlQ69UD
 XiVVdAh7HAKC/udPnQ64fGgqRiZPOIhmHS0IfOFQuaXnPuj2zlSO8XRLKJfEIUDMHyREONhNvXd
 Qh0RYfxWGU1ZUoDfhxvK16C1oYz43xvuzur0rNwVy
X-Gm-Gg: AR+sD12Wqo3Sb8C8xUWIEqusOfUctb4CHlF7XXwiiHmsS1k0Jaqtn74LCRuEus5kBxy
 7nHI9oEEeuytrfartaoZ3S39fYXPIIdv3fI4Jl0SLldmRY7m+HFpH1ghwxxYGBNf9nPK2nz8HY4
 PmZqgWoHBr2Nz+vMRAmPCA1UBK2e7rSYM7DBqDtwVbIiw/XUGVsslspFqNsDAdHCa0wV3b/RFlp
 pTBXEYwContvuKmkc5bmOl2jWFJEAjRtZ0V5djMPef5tLnH2Nx+UQU6fpRTvh0TS7MnvIU=
X-Received: by 2002:a05:6402:159b:b0:69f:4b45:924 with SMTP id
 4fb4d7f45d1cf-6a0349dcf31mr1067470a12.9.1785237934280; Tue, 28 Jul 2026
 04:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260719-submit-ce-series-v2-v5-0-3c41f66d4522@gmail.com>
 <20260719-submit-ce-series-v2-v5-13-3c41f66d4522@gmail.com>
In-Reply-To: <20260719-submit-ce-series-v2-v5-13-3c41f66d4522@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:25:19 -0600
X-Gm-Features: AUfX_my30DJbBCjQYJfh5QAzNnzYLWb1EXJtadrvxX2ylfGHOxS1vvGXuVGU1yA
Message-ID: <CAFLszTiG+KRm3HQ0WJjXmYB_V5NbzM_dRz=H6sgr7o1PGwq8SA@mail.gmail.com>
Subject: Re: [PATCH v5 13/14] crypto: allwinner: add sun8i-ce ECDSA verifier
To: james.hilliard1@gmail.com
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>,
 u-boot@lists.denx.de, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, 
 Thierry Reding <treding@nvidia.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <u-boot@0leil.net>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Rasmus Villemoes <rv@rasmusvillemoes.dk>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Francois Berder <fberder@outlook.fr>, Peng Fan <peng.fan@nxp.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Randolph Sapp <rs@ti.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Alexey Charkov <alchark@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, 
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Michael Walle <mwalle@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, E Shattow <e@freeshell.de>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lucas Dietrich <ld.adecy@gmail.com>, David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Raymond Mao <raymond.mao@riscstar.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Heiko Stuebner <heiko@sntech.de>, 
 Vincent Jardin <vjardin@free.fr>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 28 Jul 2026 12:59:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785237934; x=1785842734; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nwVVcOyO6/7ljRLEYJezFPxuKrDtpl6VLmLODibxGdI=;
 b=TNMBhYptid2RSbvnIznfblp0eOKv1IkwigGN9IFBd+4GefUXS0JrmvtedQgmX82PQL
 QHeTa/xx3C2eFt8F1hTuG5dPvl/yzC+JYKhEWSwQZyyxsP8wRQ+ZdIHfaDXgMR0riZ0+
 olggQAbaSBsTypiu1MQ7TGOY5nUNvsu/9UDlI=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=TNMBhYpt
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="TNMBhYpt";
 dkim-atps=neutral
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-07-20T04:13:44, James Hilliard <james.hilliard1@gmail.com> wrote:
> crypto: allwinner: add sun8i-ce ECDSA verifier
>
> The H6 and H616 Crypto Engines include an ECC engine which can verify
> ECDSA signatures. Add a UCLASS_ECDSA child for the sun8i-ce parent so FIT
> signature verification can use the hardware block from U-Boot proper and
> SPL.
>
> The CE takes explicit curve parameters for each operation. Provide tables
> for the curves accepted by U-Boot's FIT ECDSA parser: secp224r1,
> prime256v1, secp384r1 and secp521r1. Derive each curve's a = p - 3
> parameter from p instead of storing duplicate constants. Make each curve
> independently selectable for U-Boot proper and SPL. SRAM-constrained
> builds can keep only the curves they need. The task input layout follows
> the ECC verify buffer order used by Allwinner's CE implementation.
>
> The CE input buffer uses fixed-width curve fields. Reuse the parameter
> packing logic for the message digest as well, so wider digests are
> truncated to the leftmost curve-width bytes according to ECDSA rules.
> Map the private input and result through the parent's cacheline-safe DMA
> objects. Round result storage to complete cachelines while keeping the
> descriptor output curve-sized. Submit ECC work on the dedicated asymmetric
> completion channel. After retirement, unmap the result and input exactly
> once before inspecting the result.
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> drivers/crypto/allwinner/sun8i-ce/Kconfig          |  94 +++++
>  drivers/crypto/allwinner/sun8i-ce/Makefile         |   1 +
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c  |   6 +
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-ecdsa.c | 382 +++++++++++++++++++++
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h       |   3 +
>  5 files changed, 486 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
