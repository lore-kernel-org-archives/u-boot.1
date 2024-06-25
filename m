Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4B1C30653
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 08:29:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A850884BA;
	Tue, 25 Jun 2024 10:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="T6KE61Zz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AB0E884C3; Tue, 25 Jun 2024 10:29:40 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53855884B2
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 10:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 66C5A1F928;
 Tue, 25 Jun 2024 10:29:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1719304177;
 bh=IsuZWw4WdH1dFZy6AgvrNoIv+QaB4wa1/mTGraG4PXU=; h=From:To:Subject;
 b=T6KE61ZzP/bNMFSs1dypQ1RKTYvOAlwL+N4ydi5ZXiH5j98JtzRGmz3NPAntei3FX
 Y4FDIjjomc8gYLXRKmjbnjK2+EQ5f8JuB0Kt6nHSTwK3KmzIeDpuzevwlS/1rgPPMj
 R1rauoNoD5SyUZE25d86p3Qfa+3tB3PppEJf9PLrZrKlRK3hDPBNkorBPxeo2SBsPD
 fCiSdUhZOaGFD5apaLhPv1iWXA6WiGvpYSIqxQWg/R0MQ9J3/mZfNkCMTFDGlCzFvb
 Y1sOjKzbmbJJCHFnry63fbfc3R+yHT3rGRgoKb3Eo2DxIoqva5leqn3g3Wat4Jdn0o
 FRqCON4ZdpJLQ==
Date: Tue, 25 Jun 2024 10:29:33 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>, Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH v3] ARM: imx: verdin-imx8mm: Set CAN oscillator frequency
 based on model
Message-ID: <20240625082933.GA9378@francesco-nb>
References: <20240625082638.8867-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625082638.8867-1-marex@denx.de>
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

Hello Marek,
thank for taking care of this.

On Tue, Jun 25, 2024 at 10:26:15AM +0200, Marek Vasut wrote:
> The older i.MX8M Mini Verdin SoMs may came with 20 MHz SPI CAN controller
> oscillator, the newer SoMs always use 40 MHz oscillator. Handle both by
> overriding the oscillator frequency just before booting the kernel.
> 
> These are the known variants with 20 MHz oscillator:
> - 0055, V1.1A, V1.1B, V1.1C and V1.1D, use a 20MHz oscillator
> - 0059, V1.1A and V1.1B, use a 20MHz oscillator
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco

