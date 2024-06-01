Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B693C25B76
	for <u-boot@archiver.kernel.org>; Sat,  1 Jun 2024 09:24:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C2038816D;
	Sat,  1 Jun 2024 11:24:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="rpnuw6im";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97AE58827D; Sat,  1 Jun 2024 11:24:33 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAB1C87FFB
 for <u-boot@lists.denx.de>; Sat,  1 Jun 2024 11:24:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id E4BC41FE3A;
 Sat,  1 Jun 2024 11:24:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1717233871;
 bh=UcuhTud8A9+ZnHLSHeGbd2dgsYhIn5F0/27RIDDDNas=; h=From:To:Subject;
 b=rpnuw6immwSMuKyYeS3zxdkTKLAzK/vd2IT/d3+hm5B3kaVqOsev0SYrfFj/eY6Er
 Z2yOjlgj29x5nGUyWAia4O28myNmih1FAZ5UUaW7D2y60wQNg6M2iuy2V9fpj7HvBw
 hyrMxNthd2Nhg2O7WOWWNaSPyThFCiDIUIVmBwgDrEPGr/FS/X4v05OcAKk7V30Bt3
 m3FL3KfJHjwq6aKe7f4Vpuqj/E7eGtRbRkg7k04sOUZB+HPFcOef3GUif3wQhKOfQt
 kqlK2vlaPt8dBp//Bw8V2XyD5qyShmiRUHUBI9bwQqR4soU01f1qim/vAPLbZIBb9a
 HpBvY/JvJWXDw==
Date: Sat, 1 Jun 2024 11:24:27 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Nishanth Menon <nm@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Dhruva Gole <d-gole@ti.com>, u-boot@lists.denx.de, n-francis@ti.com
Subject: Re: [PATCH] spl: Kconfig: ARCH_K3: Set default
 SPL_STACK_R_MALLOC_SIMPLE_LEN for R5 build
Message-ID: <20240601092427.GA4947@francesco-nb>
References: <20240531144636.288599-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531144636.288599-1-vigneshr@ti.com>
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

On Fri, May 31, 2024 at 08:16:36PM +0530, Vignesh Raghavendra wrote:
> All ARCH_K3 platforms need about of 2MB of malloc space post
> reallocation. Since, this space is allocated from SDRAM, provide a
> generous 2MB space by default.
> 
> Platforms requiring more than 2MB can override in defconfig as needed.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco

