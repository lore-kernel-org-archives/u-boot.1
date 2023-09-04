Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB96CC83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 16:15:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6BBB8643D;
	Mon,  4 Sep 2023 18:15:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="N8T4pxbn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0EC88682B; Mon,  4 Sep 2023 18:15:33 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DCE886380
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 18:15:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 384GFSLk063007;
 Mon, 4 Sep 2023 11:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693844128;
 bh=+LCLlFgPuh8QANl3uQ/syoIvywFg3Bi6Bcph1V/UOg8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=N8T4pxbnHE0DRfIcLsNT0YpGh+MSi5BhKGohCheA+aPQAskl/JejQ3YQqE6zsFqVO
 zHGMRjNri0GH/o4LwL8La8zLHuLwAyDPxE1ppIeuIJSIXxmePdw64F1hUvxAPhgD03
 qUofXPoQol2M7+Y/jyDZ08ikr+eakoPcxJhd8DzY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 384GFSLk027768
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 4 Sep 2023 11:15:28 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Sep 2023 11:15:28 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Sep 2023 11:15:27 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 384GFRvx125368;
 Mon, 4 Sep 2023 11:15:27 -0500
Date: Mon, 4 Sep 2023 11:15:27 -0500
From: Bryan Brattlof <bb@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <trini@konsulko.com>, <m-chawdhry@ti.com>, <u-boot@lists.denx.de>,
 <vigneshr@ti.com>
Subject: Re: [PATCH] arm: dts: k3-j7*: ddr: Update to 0.10 version of DDR
 config tool
Message-ID: <20230904161527.bxpw6kz62zs23o63@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20230828114405.2537829-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20230828114405.2537829-1-n-francis@ti.com>
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

Hi Neha!

On August 28, 2023 thus sayeth Neha Malcom Francis:
> Update the DDR settings to those generated using 0.10 version of Jacinto
> 7 DDRSS Register Configuration tool.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  arch/arm/dts/k3-j721e-ddr-evm-lp4-4266.dtsi  |  98 ++--
>  arch/arm/dts/k3-j721s2-ddr-evm-lp4-4266.dtsi | 464 +++++++++----------
>  2 files changed, 281 insertions(+), 281 deletions(-)

Reviewed-by: Bryan Brattlof <bb@ti.com>

This works for me :)

~Bryan
