Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393C8C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 15:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E3858711D;
	Mon, 13 Nov 2023 16:59:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C789C870FC; Mon, 13 Nov 2023 16:59:40 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09869870B3
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 16:59:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 0261B1F8C9;
 Mon, 13 Nov 2023 16:59:37 +0100 (CET)
Date: Mon, 13 Nov 2023 16:59:33 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Tom Rini <trini@konsulko.com>, Neha Malcom Francis <n-francis@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Jai Luthra <j-luthra@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sjoerd Simons <sjoerd@collabora.com>,
 Robert Nelson <robertcnelson@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH 2/4] arm: dts: k3-am625: Drop SoC provided bootph params
 from board u-boot/r5 dtsi
Message-ID: <ZVJH5QFfCb4G23Yc@francesco-nb.int.toradex.com>
References: <20231113145919.1928812-1-nm@ti.com>
 <20231113145919.1928812-3-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113145919.1928812-3-nm@ti.com>
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

On Mon, Nov 13, 2023 at 08:59:17AM -0600, Nishanth Menon wrote:
> k3-am62* SoC dtsi files now provide the following:
> 
> bootph-all: dmss secure_proxy_main dmsc k3_pds k3_clks k3_reset
>    main_pmx0 main_timer0 mcu_pmx0 wkup_conf chipid
> 
> bootph-pre-ram: secure_proxy_sa3 main_esm mcu_esm
> 
> Drop these from board r5 and u-boot.dtsi files as these are duplicate in
> them now.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

I had just a quick look and I have not tested the change, with that said

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

