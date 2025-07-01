Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74080C83038
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 14:18:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59C7A83018;
	Tue,  1 Jul 2025 16:18:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="iMXJWdSH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6178E8303E; Tue,  1 Jul 2025 16:18:36 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFA4382FA8
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 16:18:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id 12D9C1F9B3;
 Tue,  1 Jul 2025 16:18:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1751379502;
 bh=tfvDopEwv6dLkOCBht35eC9o19QFaUvgaAC4Ii2uQY8=; h=From:To:Subject;
 b=iMXJWdSHEyrzekTpfTaNBVNjKbJaRAFinS4yKc/Zy4HETb02tYYDzcGJ+dXYZX0E1
 qAPiBp/bPqCvmYXEnOM0WWnIgboIxutMrBE4eGV2S4A21VAqHGbOvswHJFrCT2OubK
 kG6uYjKJGxfl+zCrau73vp3ONoDreO6IbJ03dQvVAax/AUH5LtKN5UEVVUkvTznu2p
 HoUtcoFcM1WW+YSWsVbYEYZeFlx19L942u47g4kE3DzCl/9CTlT3gDmHo2ej3l3YEM
 xzu2WE0wC+82YuIkh92uLttr3O9gJGhGRqIITQKB94Kz/hC1YhyEYCyf0I1gPEPQr3
 3Bgq1o9FPoW+w==
Date: Tue, 1 Jul 2025 16:18:20 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 4/5] configs: apalis-imx8: enable RNG support for KASLR
Message-ID: <20250701141820.GD164914@francesco-nb>
References: <20250701134504.1076115-1-ghidoliemanuele@gmail.com>
 <20250701134504.1076115-5-ghidoliemanuele@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701134504.1076115-5-ghidoliemanuele@gmail.com>
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

On Tue, Jul 01, 2025 at 03:44:59PM +0200, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> Enable DM_RNG in U-Boot to automatically populate /chosen/kaslr-seed
> and enable CAAM to provide entropy.
> Enable ARCH_MISC_INIT to initialize the CAAM job ring.
> 
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

