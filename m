Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B85ACCF9F8
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 09:18:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E09183B22;
	Thu,  6 Nov 2025 10:18:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Nzb6bUhq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB49983B4E; Thu,  6 Nov 2025 10:18:10 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A225B83A15
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 10:18:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 93B5760218;
 Thu,  6 Nov 2025 09:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8133C4CEFB;
 Thu,  6 Nov 2025 09:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1762420687;
 bh=SqfLcbV/agh4kcCt9QkgrFsscURHz+lKjEzS/SzERSE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Nzb6bUhqfBey8ZuXt9vBibOInpS3cZ9KbtuHfMTxPwDI9ANpuRIqEJpfjik6jwIh0
 hi4CHXz3dJHA75Ge81v0FmqS5lIUpsU4GRFGoBxNyFct/2GKpFXJvpzboWkywtiGww
 oDovsY68+pUBKnOZivhzcXvONBHiAnEgV/AkL4Ss9kj2GpxKQJfWjSLdQm1m5Nb1Sc
 cOaa4K+bY0xEDAck6MbMY1hZmVHDgSYL00K9yO2exTeuFfTSfswsX1SKCf8Zjkk3kQ
 rvSET+1z/gPJuFnMkmRksq3Fk87SGvUppM2sKhDwQH2VNyzmSLrnNCYAx1IUR0QsIH
 bTtK1RKyJWukA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: trini@konsulko.com, lukma@denx.de, peng.fan@nxp.com, 
 marek.vasut+renesas@mailbox.org, anshuld@ti.com, andre.przywara@arm.com, 
 xypron.glpk@gmx.de, ye.li@nxp.com, sjg@chromium.org, 
 dario.binacchi@amarulasolutions.com, a-dutta@ti.com, 
 dinesh.maniyam@altera.com, Hrushikesh Salunke <h-salunke@ti.com>
Cc: u-boot@lists.denx.de, s-vadapalli@ti.com, danishanwar@ti.com
In-Reply-To: <20251023080922.3527052-1-h-salunke@ti.com>
References: <20251023080922.3527052-1-h-salunke@ti.com>
Subject: Re: [PATCH v4] spl: Add support for Device Firmware Upgrade (DFU)
 over PCIe
Message-Id: <176242068529.10289.3970876777489060067.b4-ty@kernel.org>
Date: Thu, 06 Nov 2025 10:18:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Thu, 23 Oct 2025 13:39:22 +0530, Hrushikesh Salunke wrote:
> Introduces support for Device Firmware Upgrade (DFU) over PCIe in
> U-Boot. Traditionally, the DFU protocol is used over USB, where a
> device enters DFU mode and allows a host to upload firmware or binary
> images directly via the USB interface. This is a widely adopted and
> convenient method for updating firmware.
> 
> In the context of Texas Instruments (TI) SoCs, PCIe can be used as a
> boot interface in a manner that differs from the conventional
> "PCIe Boot" process, which typically refers to booting an OS or
> firmware image from an NVMe SSD or other PCIe-attached storage devices.
> Instead, TI SoCs can be configured as a PCIe Endpoint, allowing a
> connected PCIe Root Complex (host) to transfer images directly into the
> device’s memory over the PCIe bus for boot purposes. This mechanism is
> analogous to DFU over USB, but leverages the high-speed PCIe link and
> does not depend on traditional storage devices.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] spl: Add support for Device Firmware Upgrade (DFU) over PCIe
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/cde77583cf0b54dd572a38acd159ded7dd5e3e86

--
Mattijs
