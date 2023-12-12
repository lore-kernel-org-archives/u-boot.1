Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114E8C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 11:48:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C76C877B0;
	Tue, 12 Dec 2023 12:48:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E6E6877D3; Tue, 12 Dec 2023 12:48:38 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1EDF8718A
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 12:48:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id C844F206CE;
 Tue, 12 Dec 2023 12:48:35 +0100 (CET)
Date: Tue, 12 Dec 2023 12:48:31 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Fabio Estevam <festevam@gmail.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>, u-boot@lists.denx.de,
 Hiago De Franco <hiago.franco@toradex.com>,
 Hiago De Franco <hiagofranco@gmail.com>
Subject: Re: [PATCH v1] board: colibri_imx7: fix emmc detection
Message-ID: <ZXhIj+3mrn95CyNB@francesco-nb.int.toradex.com>
References: <20231212112815.7880-1-hiagofranco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212112815.7880-1-hiagofranco@gmail.com>
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

Hello Fabio,

On Tue, Dec 12, 2023 at 08:28:15AM -0300, Hiago De Franco wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Later versions of Colibri iMX7D V1.1B modules use a "new" SoC fusing. The
> difference lies in whether we enable the boot ROM to use the eMMC reset
> signal. Depending on the SoC fuse, the boot ROM configures this pin as a
> GPIO output to drive the reset signal. Our eMMC vs NAND detection
> currently only sets that signal to a GPIO without explicitly setting any
> direction. Previously, by default, it was set as an input. As the boot ROM
> now configures it as an output, we receive a value of zero instead of one,
> indicating the absence of the pull-up on eMMC modules.
...
> Fixes: 0c39564d ("toradex: colibri_imx7: Enable nand/emmc detection and set boot variant")

It would be nice to have this fix in for 2024.01, if possible, thanks!

Francesco

