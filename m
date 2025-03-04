Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C895FC021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 07:10:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5585A80FB9;
	Tue,  4 Mar 2025 08:10:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="LRG3Z6Do";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E497681249; Tue,  4 Mar 2025 08:10:01 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A35ED80FB6
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 08:09:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id AAB921F917;
 Tue,  4 Mar 2025 08:09:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1741072199;
 bh=4dKlhn8TkTi69jWVySAYdIONS45bbFIO0bFiu/vW62I=; h=From:To:Subject;
 b=LRG3Z6DoshoLHpfvxn8CwO/9gHuNIxFbFHWgb8mpyhwiuMkea/mqSJ8rBCuhAMvK9
 ix+EIh8dowzsic8J5AbUCNdbRRltHgvSWwxJ1qV2u7TsbSKy43jVAIHR8PUQKK/m9F
 R3WSCUgOCyZ/mvrOTm7Iza7O6IZJ0Jaz9tjXMUJLLus8yq6eY6fZAgGxj6BgKE4ko4
 N1oz14cFlhsq9lD/i8qqxYzyQ2N6V2LO/PB3vw7st03W2aQRgKyZGRrr72YeRQCcWJ
 HRWm/G1n3k56i5sSEZ45Y0fhzeipm65StmnCjB8TlWVYeMpvAPQTphHMc7o0m2f6/N
 yHECazt9nGqYg==
Date: Tue, 4 Mar 2025 08:09:55 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: francesco.dolcini@toradex.com, trini@konsulko.com, n-francis@ti.com,
 s-k6@ti.com, w.egorov@phytec.de, emanuele.ghidoli@toradex.com,
 u-boot@lists.denx.de, Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1] board: verdin-am62: fix missing memory fixup call
Message-ID: <20250304070955.GA6339@francesco-nb>
References: <20250303181618.41802-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303181618.41802-1-eichest@gmail.com>
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

On Mon, Mar 03, 2025 at 07:16:03PM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> The commit bc07851897bd ("board: ti: Pull redundant DDR functions to a
> common location and Fixup DDR size when ECC is enabled") broke DRAM
> support for the Verdin AM62. This was partially fixed with commit
> 3f866c47b582 ("board: verdin-am62: add dram_init_banksize"). However,
> because fixup_memory_node was not called, the Linux kernel was started
> with the wrong memory size on modules with less memory available. This
> resulted in boot failures. Fix this issue by calling fixup_memory_node
> in the board file.
> 
> spl_perform_fixups will be called in the SPL and now sets the correct
> memory size in the device tree of U-Boot by calling fixup_memory_node.
> U-Boot will then adjust the memory sizes of Linux during bootm/booti in
> fdt_fixup_memory_banks. This chain ensures that U-Boot and Linux only
> use RAM that is actually available.
> 
> Fixes: 3f866c47b582 ("board: verdin-am62: add dram_init_banksize")
> Fixes: bc07851897bd ("board: ti: Pull redundant DDR functions to a common location and Fixup DDR size when ECC is enabled")
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Tom: this is needed in master, this fixes a regression, preventing Linux
to boot, in v2025.04.

Thanks
Francesco

