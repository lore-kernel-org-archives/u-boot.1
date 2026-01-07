Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EEECFD636
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 13:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B281F839F1;
	Wed,  7 Jan 2026 14:44:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aizqCraj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C301883C4B; Wed,  7 Jan 2026 14:44:42 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C307D839D7
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 14:44:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 20BEB43F1F;
 Wed,  7 Jan 2026 13:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E1FC4CEF7;
 Wed,  7 Jan 2026 13:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767793479;
 bh=D10pdr4FMnxntZxSBxS1DoXtD10Hv9EHF5FgmMF4jvI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=aizqCrajpR7fzXYK7s3l9otqAF14enUHu2kdD9/qnPsz8wnj3ZjVOJZmqi3rFIvId
 XW7g5XuzMDBOnP+bokwwgPfMbFn1L77iVx+sITo+sOYknZd+dL56vn6drDn5uZnLxb
 xHUvERSHSh0xwmkadbApPeWTOevgm4GvikMXyLzB/kiHJ4eAPjwHdRY90HKRTOw3N+
 48j0VSHMfzyAI+2yva5pYN0PGrmdgoIGFQhOYyYf+xycK0Sgy4g4I6ZLsuQqtfvzMR
 ULkS8Aj687ERhzcxINvjhWyA39hTeh5O+Xz48hHFGBVTWLVdj0RoC1FYLlJ/zXu0wz
 r2d9hGQe3ORlg==
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
Subject: Re: [PATCH 3/4] usb: musb-new: Relative ctrl_mod address parsing
In-Reply-To: <20251126-topic-musb-probing-v2026-01-v1-3-ff8d8c487130@baylibre.com>
References: <20251126-topic-musb-probing-v2026-01-v1-0-ff8d8c487130@baylibre.com>
 <20251126-topic-musb-probing-v2026-01-v1-3-ff8d8c487130@baylibre.com>
Date: Wed, 07 Jan 2026 14:44:36 +0100
Message-ID: <87v7hdzge3.fsf@kernel.org>
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

> For the upstream DT the ctrl_mod node is using a relative register
> address which is not translated by the current code.
>
> Make address parsing understand relative addresses.
>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
