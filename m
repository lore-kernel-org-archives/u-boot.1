Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A48D4A60E
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 08:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6FB483015;
	Fri, 16 Jan 2026 09:35:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tnBN5Z5U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FBC18309A; Fri, 16 Jan 2026 09:35:19 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66B4982BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 09:35:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3AA006016B;
 Fri, 16 Jan 2026 08:35:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73182C116C6;
 Fri, 16 Jan 2026 08:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768552515;
 bh=5D3wbBf0BHzRIUy7DnfGeTJT6DKCeReqBJUaiIQ203Y=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=tnBN5Z5UTJXQO1gyoDKb55AkHCoJ2SjndYupbGQAahTss5XuVu+1Ny+twDW78IBow
 ArxyKzfv5kNe6XIXv4VqX5Dj7hS7MabnRLVDXcBusHlkUEnxBl/O9QCI4NYvul5Fob
 1QqewCpkLGmbWs18aoXCr3URL1UMGN5h3nQmMHHXYhlFInF1qDQa7ONz+mO3ENj8Qw
 qO0hixz2tu/c4TABvb66XvZOrWZbYiZyTzpoqvXYTnDfbwtMVjPIbaHyS4LB7NvIFb
 2Q/Urpx1zxRmRpdvs2MoD9DJ7sdvemGxe66f15r5RrlyoR4nlGHCPN8cxcPN9JnGRQ
 fYU1HgDVj18JA==
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
Subject: Re: [PATCH v3 4/6] test: dm: Add compatible multimatch test
In-Reply-To: <20260114-topic-musb-probing-v2026-01-v3-4-ebb8d990b9df@baylibre.com>
References: <20260114-topic-musb-probing-v2026-01-v3-0-ebb8d990b9df@baylibre.com>
 <20260114-topic-musb-probing-v2026-01-v3-4-ebb8d990b9df@baylibre.com>
Date: Fri, 16 Jan 2026 09:35:13 +0100
Message-ID: <87ldhydkfy.fsf@kernel.org>
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

> Add a test for binding of multiple drivers with the same compatible. If
> one of the drivers returns -ENODEV the other one needs to be bound.
>
> Reviewed-by: Simon Glass <simon.glass@canonical.com>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>  arch/sandbox/dts/test.dts |  4 ++++
>  test/dm/core.c            | 15 +++++++++++++++
>  test/dm/test-driver.c     | 26 ++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+)
>
