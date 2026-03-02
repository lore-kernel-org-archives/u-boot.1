Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CD6D58E73
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 07:41:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74C0683BC7;
	Mon,  2 Mar 2026 08:41:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="RxhU5P1w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DEEA83CDF; Mon,  2 Mar 2026 08:41:21 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DE028063E
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 08:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
 by mail11.truemail.it (Postfix) with ESMTPA id 224E7229E8;
 Mon,  2 Mar 2026 08:41:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1772437278;
 bh=1uewu8ljkJ1dT54gaHs6dHqPADm6W6sYjuIF9a0rhyc=; h=From:To:Subject;
 b=RxhU5P1wJvOYnkx69005HryG/uSUVpmddw5vkgX4b7478s4NN3ugJ8jFT2PJ9XPFG
 Si1DPztTkG4G5h9hoEfeo9pCxfZwaDjqNVV9QE7zJvGpJakKYLY5ZggJiSLqz9b0F2
 sUsx8NGQoA3VDL3e/JYvSkdZZ447PGPqHgpeKdIlCezPQeN3ke3/6nG/ZeGtZH/YDB
 ACFck+V/tBJtK4Iuvzn0zXliEj2hE7XwAP/jrmCRMoHoFM92V5diknSyjLIZt57rIw
 1fetDKZmP1ZqrV74Hm/QkLdbR8acokTfV7nPdM4iKE0K7z7x+wv7dHI6uMpmRGOKzs
 brOTLAHuhS2OQ==
Date: Mon, 2 Mar 2026 08:41:14 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: trini@konsulko.com, stefan.eichenberger@toradex.com, s-k6@ti.com,
 w.egorov@phytec.de, n-francis@ti.com, emanuele.ghidoli@toradex.com,
 francesco.dolcini@toradex.com, u-boot@lists.denx.de
Subject: Re: [PATCH v1] common/memsize.c: Fix get_ram_size() original data
 restore
Message-ID: <20260302074114.GA11690@francesco-nb>
References: <20250314100734.23777-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314100734.23777-1-eichest@gmail.com>
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

On Fri, Mar 14, 2025 at 11:06:49AM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> The get_ram_size() function fails to restore the original RAM data when
> the data cache is enabled. This issue was observed on an AM625 R5 SPL
> with 512MB of RAM and is a regression that became visible with
> commit bc07851897bd ("board: ti: Pull redundant DDR functions to a common
> location and Fixup DDR size when ECC is enabled").
> 
> Observed boot failure messages:
>   Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
>   Authentication passed
>   Starting ATF on ARM64 core...
> 
> The system then hangs. This indicates that without a data cache flush,
> data in the cache is not coherent with RAM, preventing the system from
> booting. This was verified by printing the content of this address when
> the issue occurs.
> 
> Add a data cache flush after each restore operation to resolve this
> issue.
> 
> Fixes: bc07851897bd ("board: ti: Pull redundant DDR functions to a common location and Fixup DDR size when ECC is enabled")
> Fixes: 1c64b98c1ec4 ("common/memsize.c: Fix get_ram_size() when cache is enabled")
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com> # Toradex Verdin AM62

