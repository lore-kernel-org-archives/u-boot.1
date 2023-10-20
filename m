Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6632CDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 13:20:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3822871F6;
	Fri, 20 Oct 2023 15:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YPRwnuKX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABDC486FD9; Fri, 20 Oct 2023 15:20:22 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25BD587441
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 15:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39KDKEQL060128;
 Fri, 20 Oct 2023 08:20:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697808014;
 bh=caAdFk4NqR89QQtFXvhUmNrLv8oPLKVk5b+Mti0lTQA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=YPRwnuKXPVmqWaWQr2DXeGSZixBQaEssuhl5phf33CGCOntZg4HATA+UpzG6zSNNJ
 +sgCk9ywXabwhebZf0QPE/uRxHSvo3rbwSXudD0gRlXaX/YFefKvMes5mPRqIPR81P
 Z0lZxJrGigzpXvEyNEXfSpA53L62BwMC6hi6g/NM=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39KDKECx025526
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 20 Oct 2023 08:20:14 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 20
 Oct 2023 08:20:14 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 20 Oct 2023 08:20:14 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39KDKE84105628;
 Fri, 20 Oct 2023 08:20:14 -0500
Date: Fri, 20 Oct 2023 08:20:14 -0500
From: Bryan Brattlof <bb@ti.com>
To: Vishal Mahaveer <vishalm@ti.com>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/1] clk: ti: k3-pll: Add calibration support for non
 fractional mode
Message-ID: <20231020132014.h4dekqac2okadyby@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20231020124102.15493-1-vishalm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20231020124102.15493-1-vishalm@ti.com>
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

Hey Vishal!

On October 20, 2023 thus sayeth Vishal Mahaveer:
> PLL calibration needs to be enabled when operating in non fractional
> mode. Add the sequence to do a fast calibration when using PLL
> in this mode.
> 
> Signed-off-by: Vishal Mahaveer <vishalm@ti.com>

Reviewed-by: Bryan Brattlof <bb@ti.com>

> ---
>  drivers/clk/ti/clk-k3-pll.c | 81 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 75 insertions(+), 6 deletions(-)
> 

Thanks for fixing this! I've tested the am62x and the j721e and this 
appears to be working \o/ 

~Bryan
