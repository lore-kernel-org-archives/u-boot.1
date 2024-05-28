Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA22C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 12:39:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F9118824B;
	Tue, 28 May 2024 14:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="obKrLK9p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3E2C8824B; Tue, 28 May 2024 14:39:34 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C090B88349
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 14:39:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id D4E1D1FA3C;
 Tue, 28 May 2024 14:39:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1716899972;
 bh=8gn+24puka5bbmqpANYQp1sH0JxWI2ySgrB1MNA9jqM=; h=From:To:Subject;
 b=obKrLK9pf7sgxasQoEjDpwxOPme2zzAWvOlSQNl529qDv1qVjmXP78hi69A4tImvu
 dfN1OdaDKt2Tf6IvnwhoPEfBNb1o4fRaf7hDShlSOQomNi620XRT8EI4k2WMqfycWO
 PN2I07nTSi3Jo1b9H+cN/M+j5PFnGX1NsvbjiL21F6Vc8yRiZcuckSZuItkihSANqA
 f2fhd6rk9v8CTOEyg0/7yCUzJo8qdiDiBIQ0p4mq6hPHcmh7zU4t+vY9O2utFKHtLN
 qzpFlyFZkBNgNor2InOgz8R0dsRbh1DQGZIsfWGdDrk/VpYG7aBURhRiQH1zLbAW9g
 eAlEMziAXOVVA==
Date: Tue, 28 May 2024 14:39:27 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Fabio Estevam <festevam@gmail.com>
Cc: Emanuele Ghidoli <ghidoliemanuele@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/5] board: toradex: Add new Verdin and Aquila SKUs
Message-ID: <20240528123927.GA12666@francesco-nb>
References: <20240528095941.872693-1-ghidoliemanuele@gmail.com>
 <CAOMZO5DhnEz_7Ldg58PnsQaFoDMnPY1_gmxZEeLUf2JyyQ8GEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5DhnEz_7Ldg58PnsQaFoDMnPY1_gmxZEeLUf2JyyQ8GEA@mail.gmail.com>
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

Hello Fabio,

On Tue, May 28, 2024 at 09:31:47AM -0300, Fabio Estevam wrote:
> Hi Emanuele,
> 
> On Tue, May 28, 2024 at 7:00 AM Emanuele Ghidoli
> <ghidoliemanuele@gmail.com> wrote:
> > From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > This series adds support for 0090 PID4 Verdin iMX8M Mini Quad 4GB WB
> > ET SKU.  It also adds two new SKUs config block support: 0088 Aquila
> > AM69 Octa 32GB WB IT and 0089 Verdin iMX95 Hexa 16GB WB IT.
> >
> > Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> >
> > Emanuele Ghidoli (5):
> >   board: toradex: verdin-imx8mm: add 4 GB lpddr4 memory support
> >   board: toradex: verdin-imx8mm: increase maximum addressable ram to 4GB
> >   toradex: tdx-cfg-block: add aquila am69 sku 0088 pid4
> >   toradex: tdx-cfg-block: add verdin imx95 sku 0089 pid4
> >   toradex: tdx-cfg-block: add verdin i.mx8m mini 0090 pid4
> 
> It would be better to split the series in two: one for the TI-SoC
> boards and another one for the NXP-SoC boards.

I disagree on doing this on this specific series. The reason is that the
changes on the tdx-cfg-block are depending one on each other and they
have nothing nxp nor ti specific, they are toradex specific.

If I misunderstood your request, how would you do it?
Patches 1,2,4 and 5 are for Toradex NXP board variant, patch 3 is for a
Toradex TI board, patches 4 and 5 depend on patch 3.

Francesco

