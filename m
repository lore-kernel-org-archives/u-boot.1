Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B167CFD629
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 13:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C04C6839F1;
	Wed,  7 Jan 2026 14:36:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GMaZUuCL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1565F83A57; Wed,  7 Jan 2026 14:36:04 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA894839D7
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 14:36:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C188A4361E;
 Wed,  7 Jan 2026 13:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E22C4CEF7;
 Wed,  7 Jan 2026 13:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767792958;
 bh=sW9ue4JtC8IsgxWOK43SYswthoyuwcrMXPq9YfhA2Ow=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=GMaZUuCLCCDwHeowdL9usAhgk4mkld+KKZplkl6JcxyJE5OjhMe2ZuXrLBZPRV6xj
 /tHpJKLjxEwSYDMyQewuJZaMx0aR6cziZCJLsg+uilmMauuo+l/x5E8n0FyXgJUjiI
 Q/cbjQ/OeFSRMXXVC980zlkrxwuKn63CbPmw6AV+nqoiGGCIzQuefAdv0Stf0D+Mcd
 JfhqNeR1hLC5F0OJttHEoz66zBqopvmW8FA2CTuIVJcTihk4atwmNP6KR4UxgCro4i
 C1hshziABhInQm4qcWaCx5/up4oRjlauBDawTZoUp7Gq3pwKAD8lOhwf6NRxwhMhwl
 D8FqaSGA2gnXg==
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
Subject: Re: [PATCH 2/4] test: dm: Add compatible multimatch test
In-Reply-To: <20251126-topic-musb-probing-v2026-01-v1-2-ff8d8c487130@baylibre.com>
References: <20251126-topic-musb-probing-v2026-01-v1-0-ff8d8c487130@baylibre.com>
 <20251126-topic-musb-probing-v2026-01-v1-2-ff8d8c487130@baylibre.com>
Date: Wed, 07 Jan 2026 14:35:55 +0100
Message-ID: <87y0m9zgsk.fsf@kernel.org>
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

> Add a test for binding of multiple drivers with the same compatible. If
> one of the drivers returns -ENODEV the other one needs to be bound.
>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
