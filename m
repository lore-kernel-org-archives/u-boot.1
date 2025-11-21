Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD10CFA76D
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 10:57:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6ECB2835FD;
	Fri, 21 Nov 2025 11:57:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bsNQITyw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32ED7836D1; Fri, 21 Nov 2025 11:57:38 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F0F8802C1
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 11:57:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B19AE40A95;
 Fri, 21 Nov 2025 10:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7877C4CEF1;
 Fri, 21 Nov 2025 10:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763722654;
 bh=wlk2PuhxjLuu0vghVKwCHbuWL1qTURkYvOsmM3af3MA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=bsNQITywK/RmM+6eYZsZ1gDCXSElelRz+qjfvmw95h0EjCB16eirzWv+LA1174x+U
 g5ww/8zfGS7C9E4BKTYHNl/v9HmPBlNlC0igy7scLodDM06+IbRXViJzVazmZDLYWh
 xyiNTQNDzxQH4EATeJM5ZkD4oh8mr83wXoMU4vxW+JhaeSNtUhOko1bhgs1LLCWfT2
 CGwj/+J+kqOfsl/uD+oR5XSddiiaxKbo36487Agl1sXj/QpPvAYwIQu4YaM8qnbmeQ
 WfOPVw7bYdzuoxoLSNouqDorzffjYtNGqcPGppDfuTh32G5KqmPnKCpkJjF7ZhydJK
 Lb8gbWevFXWug==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Christian Marangi
 <ansuelsmth@gmail.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Guillaume La Roque <glaroque@baylibre.com>, Heiko Schocher
 <hs@nabladev.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, Simon
 Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH 2/2] sandbox: Fix DT compiler pin warnings in sandbox DTs
In-Reply-To: <20251113115658.947953-2-marek.vasut+renesas@mailbox.org>
References: <20251113115658.947953-1-marek.vasut+renesas@mailbox.org>
 <20251113115658.947953-2-marek.vasut+renesas@mailbox.org>
Date: Fri, 21 Nov 2025 11:57:31 +0100
Message-ID: <87y0nz3b6s.fsf@kernel.org>
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

Hi Marek,

Thank you for the patch.

On Thu, Nov 13, 2025 at 12:56, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> Trivially fix the following warnings in sandbox DTs, which show up with
> DTC 1.7.2. Assign pin groups less confusing node names with pins- prefix
> to avoid confusing DT compiler into thinking the node is really a bus node:
>
> "
> arch/sandbox/dts/.test.dtb.pre.tmp:1831.20-1841.5: Warning (i2c_bus_bridge): /pinctrl/i2c: incorrect #address-cells for I2C bus
> arch/sandbox/dts/.test.dtb.pre.tmp:1831.20-1841.5: Warning (i2c_bus_bridge): /pinctrl/i2c: incorrect #size-cells for I2C bus
> arch/sandbox/dts/test.dtb: Warning (i2c_bus_reg): Failed prerequisite 'i2c_bus_bridge'
> arch/sandbox/dts/.test.dtb.pre.tmp:1848.20-1856.5: Warning (spi_bus_bridge): /pinctrl/spi: incorrect #address-cells for SPI bus
> arch/sandbox/dts/.test.dtb.pre.tmp:1848.20-1856.5: Warning (spi_bus_bridge): /pinctrl/spi: incorrect #size-cells for SPI bus
> arch/sandbox/dts/test.dtb: Warning (spi_bus_reg): Failed prerequisite 'spi_bus_bridge'
> "
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
