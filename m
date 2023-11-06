Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D5BC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 14:29:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37DBD86758;
	Mon,  6 Nov 2023 15:29:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lSPakch0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9975A86B75; Mon,  6 Nov 2023 15:29:43 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED2BC86538
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 15:29:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A6ETWua007942;
 Mon, 6 Nov 2023 08:29:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699280972;
 bh=ypxFzVxZwhIwtCWkXbrhT34DxCCk5SjTlsngbTDBYMk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=lSPakch0tU6l7ZMPblF+oRPSDO+52oLWwKA3lGaKbw1pQgfe8i7od5tQzmJBioeQP
 +HaZEWCVLnZk+jxul0xon9Pdkhb2HirIxWsdciyNNxWCre8/hmg4VBYyqz/tyoPWEF
 4bNOi1nsRrhyb1PIj5M0psXt/COHmbV0PXTkvuZg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A6ETWh7071174
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 6 Nov 2023 08:29:32 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 Nov 2023 08:29:32 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 Nov 2023 08:29:32 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A6ETWHl072717;
 Mon, 6 Nov 2023 08:29:32 -0600
Date: Mon, 6 Nov 2023 08:29:32 -0600
From: Bryan Brattlof <bb@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sinthu Raja <sinthu.raja@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Reid Tonking <reidt@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Andrew Davis <afd@ti.com>, Simon Glass <sjg@chromium.org>, Robert Nelson
 <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, <u-boot@lists.denx.de>,
 <praneeth@ti.com>
Subject: Re: [PATCH 3/5] board: Move beagleplay under beagle vendor folder
Message-ID: <20231106142932.yobr4ejnoofza4y2@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20231104080137.9628-1-nm@ti.com> <20231104080137.9628-4-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20231104080137.9628-4-nm@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hi Nishanth!

On November  4, 2023 thus sayeth Nishanth Menon:
> Move beagleplay support away from ti/am62x to it's own beagle vendor
> folder.
> 
> This forms the starting point for new beagle platforms added under it's
> own board vendor folder.
> 
> As part of this create all the associated files with a bare minimum
> beagleplay.c file.
> 
> Suggested-by: Andrew Davis <afd@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Bryan Brattlof <bb@ti.com>


> ---
>  arch/arm/mach-k3/Kconfig                      |    1 +
>  board/beagle/beagleplay/Kconfig               |   60 +
>  board/beagle/beagleplay/MAINTAINERS           |    6 +
>  board/beagle/beagleplay/Makefile              |    9 +
>  board/beagle/beagleplay/beagleplay.c          |   29 +
>  .../beagleplay}/beagleplay.env                |    0
>  board/beagle/beagleplay/board-cfg.yaml        |   36 +
>  board/beagle/beagleplay/pm-cfg.yaml           |   12 +
>  board/beagle/beagleplay/rm-cfg.yaml           | 1088 +++++++++++++++++
>  board/beagle/beagleplay/sec-cfg.yaml          |  379 ++++++
>  board/ti/am62x/MAINTAINERS                    |    7 -
>  configs/am62x_beagleplay_a53_defconfig        |    3 +-
>  configs/am62x_beagleplay_r5_defconfig         |    3 +-
>  13 files changed, 1622 insertions(+), 11 deletions(-)
>  create mode 100644 board/beagle/beagleplay/Kconfig
>  create mode 100644 board/beagle/beagleplay/MAINTAINERS
>  create mode 100644 board/beagle/beagleplay/Makefile
>  create mode 100644 board/beagle/beagleplay/beagleplay.c
>  rename board/{ti/am62x => beagle/beagleplay}/beagleplay.env (100%)
>  create mode 100644 board/beagle/beagleplay/board-cfg.yaml
>  create mode 100644 board/beagle/beagleplay/pm-cfg.yaml
>  create mode 100644 board/beagle/beagleplay/rm-cfg.yaml
>  create mode 100644 board/beagle/beagleplay/sec-cfg.yaml
> 

~Bryan
