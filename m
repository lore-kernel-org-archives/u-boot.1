Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2ABDC4167D
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 08:55:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA95A8771C;
	Thu,  2 Nov 2023 09:55:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E8C1876CB; Thu,  2 Nov 2023 09:55:18 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EDB7876CB
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 09:55:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 67BDB20145;
 Thu,  2 Nov 2023 09:55:15 +0100 (CET)
Date: Thu, 2 Nov 2023 09:55:07 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Andrew Davis <afd@ti.com>
Cc: Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Bryan Brattlof <bb@ti.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Le Jin <le.jin@siemens.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 5/7] arm: mach-k3: am62x: Move board selection to mach-k3
Message-ID: <ZUNj6yyW/DdMYAV4@francesco-nb.int.toradex.com>
References: <20231101203530.80359-1-afd@ti.com>
 <20231101203530.80359-5-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101203530.80359-5-afd@ti.com>
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

Hello Andrew,

On Wed, Nov 01, 2023 at 03:35:28PM -0500, Andrew Davis wrote:
> Currently each set of board targets from a vendor is selected inside
> the board directory for that vendor. This has the problem of multiple
> targets, one from each vendor, being selectable at the same time.
> For instance you can select both TARGET_AM654_A53_EVM and
> TARGET_IOT2050_A53 in the same build.
> 
> To fix this we need to move the target board choice to a common location
> for each parent SoC selection. Do this in arch/arm/mach-k3.

Is this oddity specific of ti k3 based board or is this a generic issue
in u-boot? Asking to understand if a k3-specific fix is the correct one
here.

Francesco

