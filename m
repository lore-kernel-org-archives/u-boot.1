Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C1FC43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 12:00:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73A9F846FD;
	Mon,  6 Jul 2026 14:00:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AkTP8EzS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57D56848D2; Mon,  6 Jul 2026 14:00:42 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D2DC84105
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 14:00:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 21DF8600C3;
 Mon,  6 Jul 2026 12:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479781F000E9;
 Mon,  6 Jul 2026 12:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783339238;
 bh=5IL/OtOxsaBcnT4S6FbZ1t8V17rDBLQ5ia55BiqRNBE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=AkTP8EzStsgLeoscqjP5NJ+CEiaqK1zfCfiQVNy8hB+QLIN19vRD9S+lVxXHchkww
 +5ohl9ENFtU1NIieRfcy0RpktijhDNKjPZSE9Y4BFBhk95C+UR8lptSFXadrigWEzq
 frRKYk7DrNy+tBXa4716T1Lk+w/LbBgfQPCud/bQVoUzLfktheuJUSKSJwpr7gCbts
 o18t6tfbY427MDbKixpYNl9slpt2XpK5ga8Nuh+/XGdjz6oFB1PiVj37/pql92JXZc
 lGTkKGM3U2qOAHtGCXO/49XPERd1780LMxwJfE+i+8qcfLe2APrqgfq7PwKANPcKZA
 zij5H1xVZowtA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 02/11] doc: Remove the patman documentation
In-Reply-To: <20260705193251.2190705-3-sjg@chromium.org>
References: <20260705193251.2190705-1-sjg@chromium.org>
 <20260705193251.2190705-3-sjg@chromium.org>
Date: Mon, 06 Jul 2026 14:00:36 +0200
Message-ID: <875x2s72fv.fsf@kernel.org>
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

> The full patman manual now lives with the standalone patch-manager
> package, making the 1000-line copy in the tree redundant.
>
> Remove the in-tree manual, its README and the doc/develop/patman.rst
> toctree page.
>
> The sending-patches guide already introduces patman, so point it at the
> patch-manager package instead of the now-dead ':doc:' cross-reference
> and, with the manual gone, add a couple of lines on how the tool works.
> Point the SPI howto at that guide too, rather than repeating the install
> details.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

