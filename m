Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4CCCFD62D
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 13:48:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE63D839F1;
	Wed,  7 Jan 2026 14:48:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iBzpmdUB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F91F83A57; Wed,  7 Jan 2026 14:48:45 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86695839D7
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 14:48:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2FDFF60007;
 Wed,  7 Jan 2026 13:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A27C19421;
 Wed,  7 Jan 2026 13:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767793721;
 bh=mZQLcRSH30J41EBL+22OmlJ73k6K5/fDXEsy7Lk49i8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=iBzpmdUBdbCuW3tf0OZKPD0m10iKYFHhVFDYDkevYQPI2+hFMEB8uz8+w86UG/L0i
 +1JW2qJtlrNwZQNBc3Ay54Uc4BosFJeRruEPyJsXS1i7Ue4Mh3Zc3V1p54v/5nr3vu
 Qa2ZIqmSw4S1TdrJl/fCjr78d/6/OGwrX0kGPHzCszQux+BMtYB6o39l3OZGlfmN9Z
 A86t9z9JgXi/IPPylk0bkzwXKc0be4A9f+jT1VaIqyufvnqtfzsK+wRI7eH3l3jx3Y
 XqOn2LY6RHlSGs++x0y1e/QXroU2XgIs4U3vPWhMY9RJDoVCx3cP80eZL4Q3l1ai8X
 ngYSk+BaHzlCA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Marek
 Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Kory Maincent
 <kory.maincent@bootlin.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Dinesh Maniyam
 <dinesh.maniyam@altera.com>, Heiko Schocher <hs@nabladev.com>, "Markus
 Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: Re: [PATCH 4/4] usb: musb-new: Add compatibles for ti,musb-am33xx
In-Reply-To: <20251126-topic-musb-probing-v2026-01-v1-4-ff8d8c487130@baylibre.com>
References: <20251126-topic-musb-probing-v2026-01-v1-0-ff8d8c487130@baylibre.com>
 <20251126-topic-musb-probing-v2026-01-v1-4-ff8d8c487130@baylibre.com>
Date: Wed, 07 Jan 2026 14:48:38 +0100
Message-ID: <87sechzg7d.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Markus,

Thank you for the patch.

On Wed, Nov 26, 2025 at 21:31, "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com> wrote:

> The upstream devicetree am33xx.dtsi does not have a "ti,am33xx-usb"
> compatible, it uses "ti,sysc-omap4" for the same node. The
> implementation of ti-musb uses a wrapper driver that binds to
> ti,am33xx-usb and creates new devices ti-musb-host and
> ti-musb-peripheral depending on the dr_mode property.
>
> To avoid this wrapper driver with the upstream devicetree, add
> compatibles for "ti,musb-am33xx" to both ti-musb-host and
> ti-musb-peripheral. Add a bind function that checks for the correct
> dr_mode value and rejects binding if it is not the correct driver.
>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
