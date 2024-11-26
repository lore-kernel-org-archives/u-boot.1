Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405C6D59D90
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 10:51:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86EEB89C61;
	Tue, 26 Nov 2024 11:51:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="GjaYbKrW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A36289C64; Tue, 26 Nov 2024 11:51:06 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6235A89C53
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 11:51:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 52E321FF68;
 Tue, 26 Nov 2024 11:51:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1732618262;
 bh=GEpafuAsVQ199QTarDXCNVkZ3yN5YTrlx5mpkV4+o1w=; h=From:To:Subject;
 b=GjaYbKrWAOygKiloMjKy2SUvvx7M+0VvMgFoiqnWZe+5cZ40Z5Xr7XYQjP9eHZzAj
 sZr00QOQAPIOJJKWRXl5Fppl2R3U7D6ZnNC3UoBApJoBdF3V0HVtxpMZns4hYiKFw5
 H4eBwDelSuKxsr46uXkqWRIJbY1ntO/nW4pMPw0Ob7C3ccRc+6psX2o5R6kntvcAuS
 FeDjUt6TS6oVXG20VcgOyTWaGSAoEwiQDAluF8P9lAPI5fpSG366YIVHt9TWSHIuCv
 JIZUe/UKqmL7Bzaa2mEXL+wcvn7za1qLl1Hb4h4IcBMdeCuSgMJfj59m21g0vrI/Yo
 vgAEwv8bTWvYw==
Date: Tue, 26 Nov 2024 11:50:58 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Vitor Soares <ivitro@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>,
 Vitor Soares <vitor.soares@toradex.com>, u-boot@lists.denx.de,
 emanuele.ghidoli@toradex.com, festevam@gmail.com
Subject: Re: [PATCH v3] toradex: tdx-cfg-block: rework modules pid4 handling
Message-ID: <20241126105058.GA23364@francesco-nb>
References: <20241125174911.70723-1-ivitro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241125174911.70723-1-ivitro@gmail.com>
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

+Fabio

On Mon, Nov 25, 2024 at 05:49:10PM +0000, Vitor Soares wrote:
> From: Vitor Soares <vitor.soares@toradex.com>
> 
> The module pid4 currently corresponds to the index of the toradex_module
> array. If a new pid4 is introduced that does not follow the sequence of
> the previous entries, it will create a gap in the array.
> 
> To address this, embed pid4 within the toradex_som structure and
> implement a function to retrieve the index corresponding to pid4.
> 
> Signed-off-by: Vitor Soares <vitor.soares@toradex.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco
