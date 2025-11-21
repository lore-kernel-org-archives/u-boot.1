Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE71CFA76D
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 10:56:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22D96835FD;
	Fri, 21 Nov 2025 11:56:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZZSjtqvz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E63B8367F; Fri, 21 Nov 2025 11:56:55 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2B6D802C1
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 11:56:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A972060097;
 Fri, 21 Nov 2025 10:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDB6C4CEF1;
 Fri, 21 Nov 2025 10:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763722611;
 bh=4Pdf8Ph5dl9xiHPE2vNhVo5YO3qCPUkROepHfqFFeC8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=ZZSjtqvzO8SsLCEf/VUBDiRPolOQRlbLougtzkf+idKdiNAmY4SYCoZvL1RFG19u8
 r++tkdtWxR4+i5Izk1WMyoVixbt1kTKxu8gOvDMqxGb3QIQ4q2s/RcU8FKclzDf5/3
 Na0xPws7hCs02/JxSW4LVK3XwT9JcHeh/NO0mVcIwdmrm+wCusVbu3ftO/cS34lq/e
 vO+ZoXiXTHpH77P9PyaNNvIz+jgl5bOs0R1ITBdGYm6BKwrzn4ZID2wArUGI/3hGt6
 PEmiNJ3f3WMX5wc9JOpWrp1MUfnAGyvAeJHXdiIlVCBoso/H8dCNRQZHqedE52hP2k
 ByAb20TFerqoQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Christian Marangi
 <ansuelsmth@gmail.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Guillaume La Roque <glaroque@baylibre.com>, Heiko Schocher
 <hs@nabladev.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, Simon
 Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini
 <trini@konsulko.com>
Subject: Re: [PATCH 1/2] sandbox: Fix DT compiler address warnings in
 sandbox DTs
In-Reply-To: <20251113115658.947953-1-marek.vasut+renesas@mailbox.org>
References: <20251113115658.947953-1-marek.vasut+renesas@mailbox.org>
Date: Fri, 21 Nov 2025 11:56:48 +0100
Message-ID: <871plr4psf.fsf@kernel.org>
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
> DTC 1.7.2. Fill in the missing address and adjust emulated I2C address
> to fit the 7bit address limit:
>
> "
> arch/sandbox/dts/sandbox.dtsi:138.30-140.5: Warning (i2c_bus_reg): /i2c@0/sandbox_pmic: I2C bus unit address format error, expected "40"
> arch/sandbox/dts/sandbox.dtsi:146.18-161.5: Warning (i2c_bus_reg): /i2c@0/emul: I2C bus unit address format error, expected "ff"
> arch/sandbox/dts/sandbox.dtsi:148.4-17: Warning (i2c_bus_reg): /i2c@0/emul:reg: I2C address must be less than 7-bits, got "0xff". Set I2C_TEN_BIT_ADDRESS for 10 bit addresses or fix the property
> "
>
> "
> arch/sandbox/dts/.test.dtb.pre.tmp:912.18-926.5: Warning (i2c_bus_reg): /i2c@0/emul: I2C bus unit address format error, expected "ff"
> arch/sandbox/dts/.test.dtb.pre.tmp:913.4-17: Warning (i2c_bus_reg): /i2c@0/emul:reg: I2C address must be less than 7-bits, got "0xff". Set I2C_TEN_BIT_ADDRESS for 10 bit addresses or fix the property
> arch/sandbox/dts/.test.dtb.pre.tmp:928.30-931.5: Warning (i2c_bus_reg): /i2c@0/sandbox_pmic: I2C bus unit address format error, expected "40"
> "
>
> Fix up pmic test to match.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
> Cc: Christian Marangi <ansuelsmth@gmail.com>
> Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>
> Cc: Guillaume La Roque <glaroque@baylibre.com>
> Cc: Heiko Schocher <hs@nabladev.com>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
