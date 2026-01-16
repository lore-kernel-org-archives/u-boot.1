Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392A0D4A60E
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 08:24:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5E3B83015;
	Fri, 16 Jan 2026 09:23:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RpZpaATJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 134B48367F; Fri, 16 Jan 2026 09:23:58 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CE7F80077
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 09:23:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 603C940797;
 Fri, 16 Jan 2026 08:23:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB7EC19423;
 Fri, 16 Jan 2026 08:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768551834;
 bh=YfftrLIGOtTFYTL4IySlcPQR0iXfUbkf9lU/LU1ex/g=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=RpZpaATJYDQBVDe49FJ+VI7aEftGipFSJpUUhhUuak+kGCYKT4pFoxwIvBFLg3A93
 nhAPDlsQSYEkGP4sz2l2jKpntJrWQMqsgPJk9lsZoOwuRyWhWcelk6V1KqVL9jy4ZY
 PnZRQhhySnLfHUTzlAjxnlR10YPmJT2ijQqITZoY61DWejGY09fwd1ulnF8nxIa2lf
 7svu2WONSoZcNhLMXj6CWMA+lqefb/kKqrGRCmsZe9yO8iIzfKFoBfyOXo9ALgFVM7
 Ma4N3K/SdFlcy6kY4LWBksoNsgP0iijzWtlc5AdVLvyJY7NQD2Vg8VGuW8UdzsSpIR
 7nQjJ6/DiDljA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Marek
 Vasut <marex@denx.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, Kory
 Maincent <kory.maincent@bootlin.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, Dinesh
 Maniyam <dinesh.maniyam@altera.com>, Heiko Schocher <hs@nabladev.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, Simon Glass
 <simon.glass@canonical.com>
Subject: Re: [PATCH v3 2/6] dm: core: lists_bind_fdt: Replace found variable
In-Reply-To: <20260114-topic-musb-probing-v2026-01-v3-2-ebb8d990b9df@baylibre.com>
References: <20260114-topic-musb-probing-v2026-01-v3-0-ebb8d990b9df@baylibre.com>
 <20260114-topic-musb-probing-v2026-01-v3-2-ebb8d990b9df@baylibre.com>
Date: Fri, 16 Jan 2026 09:23:52 +0100
Message-ID: <87o6mudkyv.fsf@kernel.org>
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

> 'found' is only used at the end of the function to print a debug
> message. No need to maintain a variable if we can just return 0
> immediately when a driver was bound successfully.
>
> Reviewed-by: Simon Glass <simon.glass@canonical.com>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
