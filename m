Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B611C71135
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 07:10:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1CFF81E18;
	Mon, 16 Jun 2025 09:10:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZkOFJxYI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F18682063; Mon, 16 Jun 2025 09:10:53 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56B8681E06
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 09:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 70E6E5C585D;
 Mon, 16 Jun 2025 07:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D7EC4CEEA;
 Mon, 16 Jun 2025 07:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750057849;
 bh=ftN0jTiMesD9IQcVIwmFztRXF6gK/eFD+FmZXR5jBgI=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=ZkOFJxYImTIS2/6H1t0Yh2OtGbZmFfjbVuWYQsgkatf1LXaIyzYRU7WPKNfni75Lv
 H80Eaxg5tXN5j8n21roV43OSqx0A6KpZhq41dSwYbFY81L4DzR3r4j60geBMyZepUI
 SchYc8nAcGddL+t04d+5LpPUD12GsVed2WUs5eEKPwEYhwPFrT4JK8/LK3ysXNbR07
 3zWmnQEaCloFRfYJoafW+//0IXyYQBNHEqEVxnMYW0WKvSO5py6ZqE4+g3QepISpGz
 DmTxgB0gjxWEvUPyFucI1N0505gZsENU84+eIQdApQwG/4Z8PY2DyxfxqezuStuhPm
 M1Nsub22m18yg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Jean-Jacques Hiblot <jjhiblot@ti.com>, u-boot@lists.denx.de, 
 Kory Maincent <kory.maincent@bootlin.com>
Cc: thomas.petazzoni@bootlin.com, Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>
In-Reply-To: <20250611171031.840277-1-kory.maincent@bootlin.com>
References: <20250611171031.840277-1-kory.maincent@bootlin.com>
Subject: Re: [PATCH] usb: gadget: musb: Fix duplicate ops assignment in
 ti_musb_peripheral
Message-Id: <175005784728.9661.2044694653130520746.b4-ty@kernel.org>
Date: Mon, 16 Jun 2025 09:10:47 +0200
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

On Wed, 11 Jun 2025 19:10:30 +0200, Kory Maincent wrote:
> Remove duplicate .ops assignment that was overriding the correct
> ti_musb_gadget_ops with musb_usb_ops (host ops) in the ti_musb_peripheral
> driver. This was causing U-Boot crashes when trying to call the
> handle_interrupts operation since the wrong ops structure was being used.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] usb: gadget: musb: Fix duplicate ops assignment in ti_musb_peripheral
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/e6eca9ea6457e79acb4e2a426f1e078842c17b25

--
Mattijs
