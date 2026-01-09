Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908A4D232EE
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 08:25:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDCA7841FA;
	Fri,  9 Jan 2026 09:25:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jDo4t8Ol";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1676B8419D; Fri,  9 Jan 2026 09:25:45 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A74484121
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 09:25:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C55ED60136;
 Fri,  9 Jan 2026 08:25:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23013C4CEF1;
 Fri,  9 Jan 2026 08:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1767947140;
 bh=nhaLgT3wYWPQj6HN0QiZ/ieEYg4M6gyCtvaY71IdMZw=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=jDo4t8OlohtTIX7jUnnwOsthfGkAdMZ5X2c9hekIYIVMIgCxC9RTNJhzeoP2X3IId
 Jnf+xd0BdJFaYD92n39XllK44dEoENv27GsJlQjwEZygnnYwuCdf9gUdRsOZvgfx4e
 8aREurWbwhwV1UaHEpFw/3x/2BulzYN/H+CTWY1TRFd2Hlyf+mExflFAAAnPthI/Zw
 seOvlAVJCoQkM+Kg6NocNBhNCLyAcThnhnxKNzn/A4J9XbT23sppOFRst3ppSE5H8H
 4RNCtOYLONb4A8YEv3Vaa78eVL9gWpRTxGn/K3K9kLkNt0Yb4uwsLQnNhPVz9ywHnt
 A0raGgPJU0nWw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Julien Masson <jmasson@baylibre.com>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, Quentin Schulz <foss+uboot@0leil.net>
Cc: Tom Rini <trini@konsulko.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251218-bootmeth_android-deps-v1-1-0113c804f951@cherry.de>
References: <20251218-bootmeth_android-deps-v1-1-0113c804f951@cherry.de>
Subject: Re: [PATCH] boot: fix missing dependency for BOOTMETH_ANDROID
Message-Id: <176794713799.404000.17569976937052113144.b4-ty@kernel.org>
Date: Fri, 09 Jan 2026 09:25:37 +0100
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

On Thu, 18 Dec 2025 13:19:07 +0100, Quentin Schulz wrote:
> The code depends on set_avendor_bootimg_addr and set_abootimg_addr
> functions which are only defined in cmd/abootimg.c, only built when
> CMD_ABOOTIMG=y so let's add a dependency.
> 
> It should be "depends on" to be properly implemented, but we get a
> circular dependency otherwise:
> boot/Kconfig:566:error: recursive dependency detected!
> boot/Kconfig:566:	symbol BOOTMETH_ANDROID depends on CMD_ABOOTIMG
> cmd/Kconfig:504:	symbol CMD_ABOOTIMG depends on ANDROID_BOOT_IMAGE
> boot/Kconfig:7:	symbol ANDROID_BOOT_IMAGE is selected by BOOTMETH_ANDROID
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] boot: fix missing dependency for BOOTMETH_ANDROID
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/1cd0a441066d3003c63fc90d936f6c4e1b47c896

--
Mattijs
