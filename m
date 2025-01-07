Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7041E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 13:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 517A280609;
	Tue,  7 Jan 2025 14:59:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NpQj2YGC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7547680608; Tue,  7 Jan 2025 14:59:07 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40FDC8007D
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 14:58:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 507Dwcqv2579440
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jan 2025 07:58:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736258319;
 bh=D3OFKK7+H4dViPO9yqzNJoYwlj4FKpjdbqd7XY91900=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=NpQj2YGCxlJqjdrzP84qfOOVX/W5YVsj3ZoRXyDZFR1Voa/tiDUNjmLUag4TdqFVq
 DrsimbDBTDL1nvkl8yZM+PW5ED8WlFgejAJNZhsXSHEicSaOr+exlDJoZepozPueku
 w0ad1cOVI3kLUICMIDsLo633SeKVouM+762RgHsE=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 507Dwc2W051813
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 7 Jan 2025 07:58:38 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 Jan 2025 07:58:37 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 Jan 2025 07:58:37 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 507DwbH2053133;
 Tue, 7 Jan 2025 07:58:37 -0600
Date: Tue, 7 Jan 2025 07:58:37 -0600
From: Bryan Brattlof <bb@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
CC: AKASHI Takahiro <akashi.tkhro@gmail.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Nishanth Menon <nm@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Hari Nagalla <hnagalla@ti.com>, Jonathan Humphreys
 <j-humphreys@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, Simon Glass
 <sjg@chromium.org>, Jayesh Choudhary <j-choudhary@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Ramon Fried
 <rfried.dev@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Tom
 Rini <trini@konsulko.com>,
 <srk@ti.com>, <s-vadapalli@ti.com>, <danishanwar@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 08/13] arm: mach-k3: am62p: Update SoC auto-gen data to
 enable CPSW boot
Message-ID: <20250107135837.vjjgcagi4yzwodyh@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250107093840.2211381-1-c-vankar@ti.com>
 <20250107093840.2211381-9-c-vankar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250107093840.2211381-9-c-vankar@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On January  7, 2025 thus sayeth Chintan Vankar:
> From: Andreas Dannenberg <dannenberg@ti.com>
> 
> This data was generated using the ksswtool-autogen project with the
> followig commit:
> 
> cd9dfa5 ("soc: am62px: Add cpsw_3guss_am67_main_0 id to the dev list")
> 

Unfortunately because these scripts are so closely tied to our HW 
designs tools they will never be seen by anyone outside of TI. We should 
probably update this commit message for Andreas.

Or find a way to publish these scripts ;)

~Bryan

> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>

~Bryan
