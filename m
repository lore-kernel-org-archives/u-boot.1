Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0918FEE801F
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 17:04:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35BE186A6D;
	Fri,  8 Sep 2023 19:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="k09TvA46";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9254986A7D; Fri,  8 Sep 2023 19:04:03 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D16FC86A1C
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 19:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 388H3mPH086105;
 Fri, 8 Sep 2023 12:03:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694192628;
 bh=nP8z2SmSAPPP4wMpkvOzgAaUcpOL7lODV/J6o/SndN0=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=k09TvA462iSuhrczDOPTkA2kfL2A4tpOzsaA5mTB7fb5iYnk+jZV7GwS1WnKNAQWJ
 lmcg+X5qsvYlNEnQbut8eLGYgkOAmyWZ6gugJctcWAZsCt3eXrTGsIwvp2Ome9wJiQ
 wM0G0Za2u57OG+xFFG4T1tjXMhH0QOYh3Tc/z2jc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 388H3mN3025077
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Sep 2023 12:03:48 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Sep 2023 12:03:46 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Sep 2023 12:03:46 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 388H3kfr115259;
 Fri, 8 Sep 2023 12:03:46 -0500
Date: Fri, 8 Sep 2023 12:03:46 -0500
From: Nishanth Menon <nm@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Dasnavis Sabiya <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Roger Quadros
 <rogerq@kernel.org>, Jason Kacines <j-kacines@ti.com>, Jayesh Choudhary
 <j-choudhary@ti.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 11/16] board: ti: j784s4: Add support for board
 detection by EEPROM read
Message-ID: <20230908170346.frwfoahna3qu37lg@dinginess>
References: <20230908110551.861575-1-a-nandan@ti.com>
 <20230908110551.861575-12-a-nandan@ti.com>
 <20230908144237.qd4ito3c656hmfp2@degrading>
 <0ea3625a-c647-fc80-36c6-93e46685c750@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0ea3625a-c647-fc80-36c6-93e46685c750@ti.com>
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

On 10:59-20230908, Andrew Davis wrote:
> On 9/8/23 9:42 AM, Nishanth Menon wrote:
> > On 16:35-20230908, Apurva Nandan wrote:
> > > From: Dasnavis Sabiya <sabiya.d@ti.com>
> > > 
> > > The board name is programmed in the EEPROM. Add support for board
> > > detection and choose the right dtb based on the board name read
> > > from EEPROM.
> > > 
> > > The J784S4/AM69 has two platforms naming J784S4-EVM and AM69-SK. The
> > > J784S4 has EEPROM populated at 0x50. AM69 SK has EEPROM
> > > populated at next address 0x51. So start looking for TI specific EEPROM
> > > at 0x50, if not found look for EEPROM at 0x51.
> > > 
> > > Also, add support for setup_serial() to read the serial number from EEPROM
> > > and update the serial environment variable with the same.
> > > 
> > > Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> > > Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> > 
> > 
> > NAK. go with the approach similar to AM62x. AM69-SK has it's own
> > fragment.
> > 
> 
> NAK to your NAK, there is no reason to introduce more fragments here
> when both boards can be supported with one defconfig.

Sorry, but no. the evm.c has become a mess. Time to stop it is in the
introduction itself

Need the eeprom stuff clearly pulled out of evm.c -> evm.c should still
work with CONFIG_EEPROM_DETECT disabled and should be board independent.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
