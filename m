Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E9EC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 14:25:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08003869CA;
	Mon,  6 Nov 2023 15:25:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZBtRwoY5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2E2F86F8D; Mon,  6 Nov 2023 15:25:34 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FEEF85C98
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 15:25:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A6EPQXj020807;
 Mon, 6 Nov 2023 08:25:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699280726;
 bh=Wo9oiAN7mWnzHqnqbnc0nRcDMnfpFOZeDo1lfemgUvk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=ZBtRwoY5tIVg8IBRqa2wbW+5EGY+qMEhnmQ/Ct9/auJZoZAtSkpTb1FKDJeZraQOa
 YdMf3+EEr5DJpwA3oFvclLy/fNAunFA9SwpQIrxwWOz7ttO3DmG99QAHpTmveZ7g5n
 /L0Di5HA0tL2klcqirefoASKdeFk+aEclbT1fP+0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A6EPQth012197
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 6 Nov 2023 08:25:26 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 6
 Nov 2023 08:25:25 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 6 Nov 2023 08:25:26 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A6EPPLI068901;
 Mon, 6 Nov 2023 08:25:25 -0600
Date: Mon, 6 Nov 2023 08:25:25 -0600
From: Bryan Brattlof <bb@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sinthu Raja <sinthu.raja@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Reid Tonking <reidt@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Andrew Davis <afd@ti.com>, Simon Glass <sjg@chromium.org>, Robert Nelson
 <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, <u-boot@lists.denx.de>,
 <praneeth@ti.com>
Subject: Re: [PATCH 4/5] doc: board: Move am62x_beagleplay to it's own vendor
Message-ID: <20231106142525.g5x2a3iyjnt4popt@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20231104080137.9628-1-nm@ti.com> <20231104080137.9628-5-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20231104080137.9628-5-nm@ti.com>
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
> Move BeaglePlay documentation to beagle as a board vendor and update
> references accordingly.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Bryan Brattlof <bb@ti.com>

> ---
>  doc/board/{ti => beagle}/am62x_beagleplay.rst | 22 +++++++++----------
>  .../{ti => beagle}/img/beagleplay_emmc.svg    |  0
>  doc/board/beagle/index.rst                    | 13 +++++++++++
>  doc/board/index.rst                           |  1 +
>  doc/board/ti/k3.rst                           |  2 +-
>  5 files changed, 26 insertions(+), 12 deletions(-)
>  rename doc/board/{ti => beagle}/am62x_beagleplay.rst (96%)
>  rename doc/board/{ti => beagle}/img/beagleplay_emmc.svg (100%)
>  create mode 100644 doc/board/beagle/index.rst
> 

Looks good to me :)

~Bryan
