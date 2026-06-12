Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71F3CD98CE
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 13:12:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8E5D83FEC;
	Fri, 12 Jun 2026 15:11:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="O3ofnvLX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE3EE83FF5; Fri, 12 Jun 2026 15:11:58 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9D9B839A8
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 15:11:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-33-46-52.ip42.fastwebnet.it [93.33.46.52])
 by mail11.truemail.it (Postfix) with ESMTPA id 463B41FC22;
 Fri, 12 Jun 2026 15:11:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1781269916;
 bh=AfQAkd5VLKpOPLRQ9KpsUMcVcQsdsqbtLMJgVIap8R8=; h=From:To:Subject;
 b=O3ofnvLXa7rCzXmuhbBL4NeFIHGFkW+hzkyHZBiPT9i4B49M2nj6nAG13E/WjQ+zl
 OuHZUlImj7vXcaccfVGmRhLZtkSI88b0gWBERBWHwHbrs9zwZTiYoQBlRyB2LXbykU
 OCLedcjVK2dnfsFFQeXzKe2z95XKdiJa9xKUQUKZ1nE2jqtqRp2TA0GzbsfHUNUByI
 yBxTrPyaVfUhM3LaUDyAvnHe1OO43SMloul1J8uH5AEc/se8TlN6O9tOPrBRt3ZiEA
 jvuQThEbtvhczVSKkIZtjLbN+tPshTEuBgDZNUpJiaq4xyN+2+1oXomQC8whcydEoW
 02U7U5/MRjabg==
Date: Fri, 12 Jun 2026 15:11:49 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Franz Schnyder <fra.schnyder@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Franz Schnyder <franz.schnyder@toradex.com>
Subject: Re: [PATCH 0/2] configs: imx95: enable PCI_INIT_R for Toradex modules
Message-ID: <20260612131149.GA8915@francesco-nb>
References: <20260612-fix-smarc-verdin-imx95-eth-v1-0-851197b36dcc@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612-fix-smarc-verdin-imx95-eth-v1-0-851197b36dcc@toradex.com>
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

On Fri, Jun 12, 2026 at 10:58:59AM +0200, Franz Schnyder wrote:
> Currently, on the Toradex SMARC iMX95 and the Verdin iMX95 the ENETC 
> device is not enumerated before network initialization because 
> pci_init() is not called. As a result, no Ethernet device is registered.
> 
> Enable CONFIG_PCI_INIT_R so the PCI buses are enumerated early enough
> for the Ethernet Controller to be detected and used.
> 
> Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Fabio: to me this is material for the current release (master), up to
you the final decision on this.

