Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838FDD5C0F2
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 08:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED4A5833C6;
	Tue, 16 Dec 2025 09:51:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="N9ZFoj3c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3EF18334F; Tue, 16 Dec 2025 09:51:17 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EFED8334F
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 09:51:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id 02F3E1FBD9;
 Tue, 16 Dec 2025 09:51:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1765875073;
 bh=SJ7wXbdOYC3XTI3cvOWKEwfaiYbbcAipnVmirD1m3g0=; h=From:To:Subject;
 b=N9ZFoj3cR30de6OJcSGIAJfRdKbM0BEMGZIa4Ahb0pb/hSUDrdFXwFxCgWsLx4Dnx
 EoX2QRaedUNXra/oBHu2v/1RWSUSbz2KKZ5+WTvSRErQSNXmL2+vqRuIxOpn+lWqFF
 TLQSzOkAb4zU2li1BELo5lVBDZ/DPyHc56Q4i8Vq3zAkaMj5O/08WqZdu1KecJ66mi
 MoIGp3g8a96HbGG07MJi7bfC3S4xnLM/NvEa9KvvvE2F9aBxerVYpgHpLi3EDjP56A
 ddKLe0AGlZSQFe2VdXebcGRZSzHwNKoTohXbkVqI/iZG6qEYO51dJWte1cUDI959U9
 9uih0y+hg1Aag==
Date: Tue, 16 Dec 2025 09:51:09 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1] toradex: tdx-cfg-block: add pid4 support for new
 modules
Message-ID: <20251216085109.GA23945@francesco-nb>
References: <20251216084532.613791-1-ghidoliemanuele@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216084532.613791-1-ghidoliemanuele@gmail.com>
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

On Tue, Dec 16, 2025 at 09:45:28AM +0100, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> Add new PID4 to ConfigBlock handling:
>  - 0217 Lino iMX93 Dual 2GB IT
>  - 0218 Lino iMX91 Solo 2GB IT
>  - 0219 OSM iMX93 Dual 2GB IT
>  - 0220 OSM iMX91 Solo 2GB IT
>  - 0221 Verdin AM62 Dual 1GB ET
> 
> Lino and OSM are two new SoM families.
> The Verdin variant differs from the existing 0073 Verdin AM62 Dual 1GB ET
> by the presence of the GPU (AM625 instead of AM623), the absence of
> DSI interface (bridge not mounted) and eMMC size increased to 16GB instead
> of 4GB.
> 
> Link: https://www.toradex.com/computer-on-modules/lino-arm-family
> Link: https://www.toradex.com/computer-on-modules/osm-arm-family
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

