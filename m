Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED438C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 13:28:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14D6381A10;
	Fri, 14 Mar 2025 14:28:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="HSj0wNJC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4144181B42; Fri, 14 Mar 2025 14:28:40 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E965E81A0E
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 14:28:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id E29631F93A;
 Fri, 14 Mar 2025 14:28:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1741958917;
 bh=0KfcEakarwDzrxJrmprn9td4jgkELT5OVxGWU/7ZBhI=; h=From:To:Subject;
 b=HSj0wNJCGcOWBsJyQfKDFfvhUEOSA3iVpSnuIh6/xH0PXvWOwTiSocB0aRO7ORnw5
 9qy7uRLE2BHcAYD4etwXZT9x58hRCOkrLi0QeiOtI2X82ifLyPKze0KorGamOekkJ8
 NPJeMFfHSo06JHRJLJ39ZRhSQ58OASkfqmrI8AMPZ8Ru9uQqLOybEhhGqEKIIYIm6V
 ssIK4V9HwIEvHDFqNMfa1khe6shcLwhLwmHUXJSQEVK6NuBkHm4CcuqoDL61Q8SHwS
 ERHp4FURlPYu0pc1z6iYDqtCezMQ8DEqxIJpNgKurlab1VsUr5VqrahFK3Rzku0zR5
 fxoSyYujs9hwA==
Date: Fri, 14 Mar 2025 14:28:32 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefan Eichenberger <eichest@gmail.com>, trini@konsulko.com
Cc: stefan.eichenberger@toradex.com, s-k6@ti.com, w.egorov@phytec.de,
 n-francis@ti.com, emanuele.ghidoli@toradex.com,
 francesco.dolcini@toradex.com, u-boot@lists.denx.de
Subject: Re: [PATCH v1] common/memsize.c: Fix get_ram_size() original data
 restore
Message-ID: <20250314132832.GA25644@francesco-nb>
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

Hello Tom,

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

This patch is for master, and it is hopefully fixing the last remaining
issue that is preventing our board to boot with current U-Boot.

Thanks,
Francesco

