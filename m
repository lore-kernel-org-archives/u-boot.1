Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72A6C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 12:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5622D83F7D;
	Thu, 24 Aug 2023 14:11:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lehuH8E0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16FAC83F7D; Thu, 24 Aug 2023 14:11:08 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DFAE8056B
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 14:11:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37OCAvUT118081;
 Thu, 24 Aug 2023 07:10:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692879057;
 bh=G9jC8ceiAkm8zXfuq33phBXd0dzInrz+3AMePPb9ElQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=lehuH8E0Uz2V+pn5F0FOfU2cu/pddUSEaNpR53Mu8fZH/ZNXb9xsYKWuw2+1nsXww
 QsWhS29UkKhbrOEsELdAtdzSHpOgdgXiQsxHc+YSTdTq3hD8QRIFF9A1Qr0teuuySP
 X+1+WKfLwg4ZrW6yupMn166tYLUKybWylhISBEj4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37OCAvcd040858
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Aug 2023 07:10:57 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Aug 2023 07:10:57 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Aug 2023 07:10:57 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37OCAvZ5019652;
 Thu, 24 Aug 2023 07:10:57 -0500
Date: Thu, 24 Aug 2023 07:10:57 -0500
From: Nishanth Menon <nm@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Emanuele Ghidoli <ghidoliemanuele@gmail.com>, <u-boot@lists.denx.de>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Neha Malcom Francis
 <n-francis@ti.com>, Bryan Brattlof <bb@ti.com>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH v1 1/2] verdin-am62: add u-boot update wrappers
Message-ID: <20230824121057.zb6ugqbbmm6theny@rematch>
References: <20230824080850.1755724-1-ghidoliemanuele@gmail.com>
 <20230824080850.1755724-2-ghidoliemanuele@gmail.com>
 <ZOc8244kvlGRpHpj@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZOc8244kvlGRpHpj@francesco-nb.int.toradex.com>
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

On 13:19-20230824, Francesco Dolcini wrote:
> On Thu, Aug 24, 2023 at 10:08:49AM +0200, Emanuele Ghidoli wrote:
> > From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > 
> > Add update_tiboot3, update_tispl and update_uboot wrappers to update
> > R5 SPL, A53 SPL and A53 U-boot respectively.
> > 
> > Usage example:
> > > tftpboot ${loadaddr} tiboot3-am62x-gp-verdin.bin
> > > run update_tiboot3
> > 
> > > tftpboot ${loadaddr} tispl.bin
> > > run update_tispl
> > 
> > > tftpboot ${loadaddr} u-boot.img
> > > run update_uboot
> > 
> > Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Should you update documentation to indicate the usage?

Currently the documentation says:
Flash to eMMC
-------------

.. code-block:: bash

    => mmc dev 0 1
    => fatload mmc 1 ${loadaddr} tiboot3.bin
    => mmc write ${loadaddr} 0x0 0x400
    => fatload mmc 1 ${loadaddr} tispl.bin
    => mmc write ${loadaddr} 0x400 0x1000
    => fatload mmc 1 ${loadaddr} u-boot.img
    => mmc write ${loadaddr} 0x1400 0x2000



-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
