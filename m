Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB25C7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 14:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A88918304C;
	Tue,  1 Jul 2025 16:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="J1OD09r6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A47E83092; Tue,  1 Jul 2025 16:18:44 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22CA68304D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 16:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id 5D55A1FB1A;
 Tue,  1 Jul 2025 16:18:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1751379513;
 bh=tdIu6V8mYPxmJEWGr+DTdL0VLxQ5QmVCjTboVtvvumE=; h=From:To:Subject;
 b=J1OD09r6L7EetH4v8SCJal5wchvW/iaCsdDwCCeaqOkOk9Ph2cXhz+QKRunGxxOLd
 S5BNNGvt0WJjlCTo6tB/lspq9Jnv7f+aSZnzaUbQZmqxJ+YXzMkPoF9753v+3Ki9Cl
 iCXd0htTKFOWOAfLdnXqMo21HioTMltvUXWFPFEURNmjCoD1weB+fw+CgzAaHcN1kP
 0vir7nZeqMSxRCE71yHj7MVIXRfXp/IjM8U5SACrm8uti5WopgNfPR77Yn0eL92q05
 CDoUZ8tFO//xHeVdhFpDWkBSGnbfizD/sEhX3QzvECCxC19H2jwdFp+yEFy3o0EQdr
 p1NMA1czGzc1w==
Date: Tue, 1 Jul 2025 16:18:32 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 5/5] configs: colibri-imx8x: enable RNG support for
 KASLR
Message-ID: <20250701141832.GE164914@francesco-nb>
References: <20250701134504.1076115-1-ghidoliemanuele@gmail.com>
 <20250701134504.1076115-6-ghidoliemanuele@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701134504.1076115-6-ghidoliemanuele@gmail.com>
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

On Tue, Jul 01, 2025 at 03:45:00PM +0200, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> Enable DM_RNG in U-Boot to automatically populate /chosen/kaslr-seed
> and enable CAAM to provide entropy.
> Enable ARCH_MISC_INIT to initialize the CAAM job ring.
> 
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

