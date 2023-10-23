Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39265CDB474
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 14:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4542887733;
	Mon, 23 Oct 2023 16:04:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KqM6SJ5r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42D9D87733; Mon, 23 Oct 2023 16:04:03 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09FFC86F23
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 16:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39NE3uGX086911;
 Mon, 23 Oct 2023 09:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698069836;
 bh=1KT+KP147522JgLdSJz+/wJROj++wGwTWvKi6K2RqSY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=KqM6SJ5r40veSw+YKXv0GvZcc+E4QawJsR3RFqL6Cvk3Op9pqehyrmsUM32BxHtYi
 pKkIo+lmjJLv3HMW+IZAiDdiSyNYqFhddiBM30MqSrrELEBU5nWj1UG0xDMhKMSlOj
 DsW/QIvQEbgOHa1NRi14/++RzKuuaroPheEKEaLA=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39NE3uYi029110
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 23 Oct 2023 09:03:56 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 23
 Oct 2023 09:03:56 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 23 Oct 2023 09:03:56 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39NE3tP8015860;
 Mon, 23 Oct 2023 09:03:55 -0500
Date: Mon, 23 Oct 2023 09:03:55 -0500
From: Bryan Brattlof <bb@ti.com>
To: Vishal Mahaveer <vishalm@ti.com>, Tom Rini <trini@konsulko.com>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 <u-boot@lists.denx.de>
Subject: Re: [RESEND PATCH 1/1] clk: ti: k3-pll: Add calibration support for
 non fractional mode
Message-ID: <20231023140355.dpdame5x64v5wypb@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20231023133546.32283-1-vishalm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20231023133546.32283-1-vishalm@ti.com>
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

Hi Vishal!

+Tom

On October 23, 2023 thus sayeth Vishal Mahaveer:
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
appears to properly setup the PLLs without firmware's help after :)

~Bryan
