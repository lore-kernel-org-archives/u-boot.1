Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD3DC3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 21:12:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F26A878A7;
	Wed,  3 Jan 2024 22:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tNrcWg5s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA924878AA; Wed,  3 Jan 2024 22:12:13 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDB5187897
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 22:12:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 403LBvtG027730;
 Wed, 3 Jan 2024 15:11:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704316317;
 bh=abY8B8Wvkpa/Fd6f8M/ePOUipvk2EDBpyHU80QOmzOc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=tNrcWg5sDVAg8fxI9o2n1BEj71rzAStxXjWOHgqdH0eRKYHw5zdoRkm8/pD5ROKa6
 3vIMTROfbXqc5dkVi/ztRk8vOe7pVIqzqq3d7lSzEYs4matU6VIdRwkleStb75jiim
 qRBv9lqrY1cfP+rrTdGAl1pzL3Vypx/7Mv08iaKg=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 403LBvis069339
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Jan 2024 15:11:57 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Jan 2024 15:11:57 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Jan 2024 15:11:57 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 403LBv0d112248;
 Wed, 3 Jan 2024 15:11:57 -0600
Date: Wed, 3 Jan 2024 15:11:57 -0600
From: Bryan Brattlof <bb@ti.com>
To: Apurva Nandan <a-nandan@ti.com>
CC: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Neha
 Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, Andrew
 Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya
 <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia
 <a-bhatia1@ti.com>, Christian Gmeiner <christian.gmeiner@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jayesh
 Choudhary <j-choudhary@ti.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>, Nishanth
 Menon <nm@ti.com>
Subject: Re: [PATCH v7 06/17] arm: mach-k3: j784s4: Add clk and power support
Message-ID: <20240103211157.qyjfqbygzckx34df@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20231219191537.4039361-1-a-nandan@ti.com>
 <20231219191537.4039361-7-a-nandan@ti.com>
 <20240103171107.w6maz7nhior64lsh@circulate>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240103171107.w6maz7nhior64lsh@circulate>
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

On January  3, 2024 thus sayeth Nishanth Menon:
> On 00:45-20231220, Apurva Nandan wrote:
> > Add clk and device data which can be used by respective drivers
> > to configure clocks and PSC.
> > 
> > Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> > Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> > Reviewed-by: Sean Anderson <seanga2@gmail.com>
> > ---
> 
> Cursory look (have not verified actual data), looks fine..
> 
> Reviewed-by: Nishanth Menon <nm@ti.com>
> 

These look to be correct, just a little old.

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
