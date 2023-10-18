Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86244CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 22:42:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4620686EE0;
	Thu, 19 Oct 2023 00:42:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="h6bXKc4G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66BA686F2A; Thu, 19 Oct 2023 00:42:20 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F37B86EA5
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 00:42:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39IMgB15067136;
 Wed, 18 Oct 2023 17:42:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697668931;
 bh=+68imQfUyZXKKH/1qCsLvE27C1m8F58AVJ/s7Zb2ubA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=h6bXKc4GlsMgTujgahvwr+ig3mC3/NxIEmZEQgUPWChQemymI4fZpCKtI2B4igYZe
 2KKQj+WdQrjePAV6R0jA/AR3L199nCMwRc2MkElUJm1lSL2dImFvmh4olIaVVtYl3+
 NfWnbRmaWoH+dJVpUpZLCcfG/iWSjuBVeHTVWS6M=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39IMgBgd094749
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 18 Oct 2023 17:42:11 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Oct 2023 17:42:11 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Oct 2023 17:42:11 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39IMgBO3062027;
 Wed, 18 Oct 2023 17:42:11 -0500
Date: Wed, 18 Oct 2023 17:42:11 -0500
From: Bryan Brattlof <bb@ti.com>
To: Thomas Richard <thomas.richard@bootlin.com>
CC: <u-boot@lists.denx.de>, <nm@ti.com>, <thomas.petazzoni@bootlin.com>,
 <gregory.clement@bootlin.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH 5/9] ram: k3-ddrss: Add exit retention support
Message-ID: <20231018224211.o6u2bck4niqolonp@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20231016141135.325698-1-thomas.richard@bootlin.com>
 <20231016141135.325698-6-thomas.richard@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20231016141135.325698-6-thomas.richard@bootlin.com>
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

Hi Thomas!

On October 16, 2023 thus sayeth Thomas Richard:
> Add the exit retention support.
> The enter retention is done by DM-Firmware.
> A part of the exit retention sequence is specific to the board.
> It is done in board_k3_ddrss_lpddr4_release_retention.
> 
> Based on the work of Gregory CLEMENT <gregory.clement@bootlin.com>
> 
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
> 
>  drivers/ram/k3-ddrss/k3-ddrss.c | 302 ++++++++++++++++++++++++++++++++
>  1 file changed, 302 insertions(+)
>

Do you mind putting this behind some type of Kconfig option? For the 
am62* class of devices the amount of SRAM we have is really stretched 
thin. I'm worried this may put us over the top. 

~Bryan
