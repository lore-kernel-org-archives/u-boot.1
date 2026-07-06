Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFD3C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 11:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B089B846FD;
	Mon,  6 Jul 2026 13:59:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b9lRlIw5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 766188488D; Mon,  6 Jul 2026 13:59:06 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67E8B84105
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 13:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3018A60018;
 Mon,  6 Jul 2026 11:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBB71F000E9;
 Mon,  6 Jul 2026 11:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783339142;
 bh=S59WnMl+7PIsQDmrWk2uAigZq399x5sMuL1etImBZVs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=b9lRlIw5yYrBZah6zh59y4xZ/RkIB4JTs9TXKmbG5aZndSb0IOZ09cdPrqEV3KO7j
 J5QfF9MiOV6tXJMJls+NR781W7Se8thWm8Lc9Z5/Q4Brt9M9M+3R9LihvlhMOjdeIP
 A9eb+c6eEfiGUOotO8/3IxppWsOhpryY8PU0oQzFPwwDxWJH0ZZOkwZ1q2X0aBoqZH
 mfMchbkMXI23yT57PiSpaE3/zoO4qIQFb0b34yONihLO0ZiCjw1WqdumTkyssKZew6
 Tuy1xebkejAEzPp+jZGLtq0+tBsm7p+EBcOT0Nr+ENPxyiC3HRIzvR/hPWLrigZUAD
 +Kwh46Z1IdFYw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Javier Tia <floss@jetm.me>, Neil Armstrong
 <neil.armstrong@linaro.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 01/11] doc: Move the b4 guide into sending_patches
In-Reply-To: <20260705193251.2190705-2-sjg@chromium.org>
References: <20260705193251.2190705-1-sjg@chromium.org>
 <20260705193251.2190705-2-sjg@chromium.org>
Date: Mon, 06 Jul 2026 13:59:00 +0200
Message-ID: <878q7o72ij.fsf@kernel.org>
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

Hi Simon,

Thank you for the patch.

On Sun, Jul 05, 2026 at 13:32, Simon Glass <sjg@chromium.org> wrote:

> The b4 contributor guide sits in the coding-style document, which is an
> odd place for it. Move it into sending_patches.rst, next to the patman
> note, so both patch-sending tools are described together.
>
> The b4_contrib label moves with it, so the reference from process.rst
> still resolves.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

