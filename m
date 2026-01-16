Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6ADD4A60E
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 08:41:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BF9383015;
	Fri, 16 Jan 2026 09:41:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fqDzqqll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07F62830E4; Fri, 16 Jan 2026 09:41:35 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B728182BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 09:41:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7787F6016B;
 Fri, 16 Jan 2026 08:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3413C116C6;
 Fri, 16 Jan 2026 08:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768552891;
 bh=8nuggKW2oWH77TIxwXooHNfTjX4M1kEqmFgPKwu2Ka8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=fqDzqqllnMHxPSKVIDbA316V/Lysa7x3PNZPbpDs9n1cX2HW4Vkhj/eabi5cWRVzm
 bwkrMcM6YSDpvCVe2znZfs33eQ81endZhLtP/dc9b1iOmazoqpi4Y0GXxfZa0gxjpL
 +y+ngqXpICgO81GKqDVUXFd53Z2N7riAmX0hGWIesCG86i6yvQQWdV9VIIeQIi+xMi
 rYHb6+dp7MjNNWZqaMCOpC240v98SLh7QWNebp8G2eHR6Be2RX9PXU88I048pIl5fQ
 4EUsOEdslfrVwlaxKpa40hdSz2r9/aYRopQTZKLrlu82u6Vade6y5K5SEEBeeDxh3U
 riq277DLZCYvA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Marek
 Vasut <marex@denx.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, Kory
 Maincent <kory.maincent@bootlin.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, Christian Marangi <ansuelsmth@gmail.com>, Dinesh
 Maniyam <dinesh.maniyam@altera.com>, Heiko Schocher <hs@nabladev.com>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Subject: Re: [PATCH v3 5/6] usb: musb-new: Relative ctrl_mod address parsing
In-Reply-To: <20260114-topic-musb-probing-v2026-01-v3-5-ebb8d990b9df@baylibre.com>
References: <20260114-topic-musb-probing-v2026-01-v3-0-ebb8d990b9df@baylibre.com>
 <20260114-topic-musb-probing-v2026-01-v3-5-ebb8d990b9df@baylibre.com>
Date: Fri, 16 Jan 2026 09:41:28 +0100
Message-ID: <87ikd2dk5j.fsf@kernel.org>
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

> For the upstream DT the ctrl_mod node is using a relative register
> address which is not translated by the current code.
>
> Make address parsing understand relative addresses.
>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

I already reviewed this in v1 and the patch did not change in v3:
https://lore.kernel.org/all/87v7hdzge3.fsf@kernel.org/#t

Can you please explain why you have dropped my Reviewed-by?

Anyways, putting it back so that b4 picks it up.

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>


> ---
>  drivers/usb/musb-new/ti-musb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
