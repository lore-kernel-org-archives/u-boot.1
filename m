Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E787C83038
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 14:18:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7E5C82FD4;
	Tue,  1 Jul 2025 16:17:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="B35dI5qq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7650D82FD4; Tue,  1 Jul 2025 16:17:48 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C96482FA8
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 16:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id 72BBB22929;
 Tue,  1 Jul 2025 16:17:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1751379458;
 bh=K3pfKApTyKo85um27C9SnhdwAnwSgRUGiJtfGTu6qTU=; h=From:To:Subject;
 b=B35dI5qq6YuHQqZuV5DIMnIebClkXmsbH1KPTOAQSaUX317Zy6JbA87mTa0LjRnkn
 HJEepXRrYuMoPqQrir/yT9xx55HlLHdPmMZToEz5Seg/R97u3ocSImH4pPljFFZTSt
 EJOC3FeVoprjHzK0HN6PtUAsmW6m9eQYGGD36KoEU1wCHWxhVKcmr13E/FtvdYvCCx
 ju8hYFk8qiF4TzWGfaScHwkZEzU/sRKD98o1BnY+o31zEuP+46ugspj2WT0JQ5D6g3
 lI2OCsgoGzO/Ib+vI7fXQv1euQfqcRSyRhJZ7z+1c2DBngbqKeMjYxmrO31+11xDxJ
 FQeIi9VAAfGwA==
Date: Tue, 1 Jul 2025 16:17:34 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/5] configs: verdin-imx8mm: enable RNG support for
 KASLR
Message-ID: <20250701141734.GA164914@francesco-nb>
References: <20250701134504.1076115-1-ghidoliemanuele@gmail.com>
 <20250701134504.1076115-2-ghidoliemanuele@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701134504.1076115-2-ghidoliemanuele@gmail.com>
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

On Tue, Jul 01, 2025 at 03:44:56PM +0200, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> Enable DM_RNG in U-Boot to automatically populate /chosen/kaslr-seed
> and enable CAAM to provide entropy.
> 
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

