Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE8CCFD63F
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 14:01:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECBB783A57;
	Wed,  7 Jan 2026 15:01:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tdMjwWAv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F49D8401F; Wed,  7 Jan 2026 15:01:32 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB82783A26
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 15:01:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6F0A743E5E;
 Wed,  7 Jan 2026 14:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20DDC19421;
 Wed,  7 Jan 2026 14:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767794487;
 bh=/DrtR2byfPJVlNA4YPnRGx81pV2W4JNNhKlA82ERwiE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=tdMjwWAvu9Ey+72XrBgoI33Ly0Pb9fRRHEvfaIjvfai0N+8f0rQAQw2kyONDS/Fq7
 5l1K8wh1bDBK/VYVOYDI2BA7kRaxirw5bHfc3R10TtXM/BU3AGX1rmL2SFIllTD26u
 W4X9vfiyM09Mrdv2MGvpROsk7v7dvotq+QLvJ6Gg1/84gHVmoiTpLhl9AHd4xd6/pZ
 +UZyCJv3vGOCUrqrFrku35bmKInVGMOaNNFK3sPOyC1l53NiGvUz3XwYS+bSdw/scg
 BEd4cWF7kHJDhdw5j2+zv5z0FEk21PG2BcCHvfoU1xUlsUK4OZzW61qoYndOaQ1k7+
 pNqEvcxexhCQQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: u-boot@lists.denx.de, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251126-topic-musb-probing-v2026-01-v1-0-ff8d8c487130@baylibre.com>
References: <20251126-topic-musb-probing-v2026-01-v1-0-ff8d8c487130@baylibre.com>
Subject: Re: [PATCH 0/4] dm: core: Support same compatible in host/gadget
 musb drivers
Message-Id: <176779448475.214869.16026456579050958123.b4-ty@kernel.org>
Date: Wed, 07 Jan 2026 15:01:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

Hi,

On Wed, 26 Nov 2025 21:31:06 +0100, Markus Schneider-Pargmann (TI.com) wrote:
> musb currently uses a wrapper driver that binds on the parent device of
> the actual musb devices to manage the differentiation between gadget and
> host modes. However in the upstream devicetree this parent devicetree
> node can not be used to match the wrapper driver.
> 
> To be able to probe the musb devices in host/gadget mode directly, this
> series introduces support for returning -ENODEV in bind functions
> resulting in iterating the remaining drivers potentially binding to
> other drivers that match the compatible.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/4] dm: core: Support multiple drivers with same compatibles
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/292d809159b86ff3c07e4fea93927cd0d00d8b27
[2/4] test: dm: Add compatible multimatch test
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/b1f483a350a7df6130eb4880ecce4cfabfe5b9a9
[3/4] usb: musb-new: Relative ctrl_mod address parsing
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/dce67e20709bd89f4ec17135e242447b5e6570d4
[4/4] usb: musb-new: Add compatibles for ti,musb-am33xx
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/b51b489ae7c47d8372a6b73a4c0c5fa71291c4fd

--
Mattijs
