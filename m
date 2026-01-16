Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECE0D4A613
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 08:44:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2538E83015;
	Fri, 16 Jan 2026 09:44:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="txrqY157";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14ACD83623; Fri, 16 Jan 2026 09:44:35 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B449C82BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 09:44:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EB9BE40C08;
 Fri, 16 Jan 2026 08:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420C9C116C6;
 Fri, 16 Jan 2026 08:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768553070;
 bh=F730hI7smLZNbV8ZHKfGIGj2YwzlXUYnh1l9WIOG+XI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=txrqY157Zhc9qCBAzcBpLv8hQo5gU2vqVbl/WRipUlGlzFhYrWFZKHxaxUekgV/tt
 zPw+QzgmNNybBTCXMJIMhrchaGTLV5tFAd4cRY2NTR/DHP5LMLz1DH/6Xq9xdlHC+A
 IAJP1d0lKHf7yp3PoMy73x/LvqvWYPfUeja4MGcADVoriVVoipg/s622zHIWfwyenG
 iDADmSC79CeSX8OiTiujpwi+hpkjiELKB3qGSCw6xKWiCBUjRQpE2xu5fQ+sYpfY8y
 zeRm9Rvi4+VAxzFD1eNMhrherUwwx+QDgTcyoFWo/ibzn6NasT9iUF1/QVnhSZOk/6
 OLc89ADgdz4pA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Marek
 Vasut <marex@denx.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, Kory
 Maincent <kory.maincent@bootlin.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, Dinesh
 Maniyam <dinesh.maniyam@altera.com>, Heiko Schocher <hs@nabladev.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: Re: [PATCH v3 6/6] usb: musb-new: Add compatibles for ti,musb-am33xx
In-Reply-To: <20260114-topic-musb-probing-v2026-01-v3-6-ebb8d990b9df@baylibre.com>
References: <20260114-topic-musb-probing-v2026-01-v3-0-ebb8d990b9df@baylibre.com>
 <20260114-topic-musb-probing-v2026-01-v3-6-ebb8d990b9df@baylibre.com>
Date: Fri, 16 Jan 2026 09:44:28 +0100
Message-ID: <87ecnqdk0j.fsf@kernel.org>
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

On Wed, Jan 14, 2026 at 09:33, "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com> wrote:

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

I already reviewed v1 and v3 did not change for this patch:
https://lore.kernel.org/all/87sechzg7d.fsf@kernel.org/

Any reason for dropping my Reviewed-by: tag?

Adding it back to make sure it gets picked up by b4:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  drivers/usb/musb-new/ti-musb.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
