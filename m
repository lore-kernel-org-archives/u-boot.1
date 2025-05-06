Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120EEC3ABBF
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 13:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7717B820F6;
	Tue,  6 May 2025 15:01:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tvPUWADW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EC6C8210D; Tue,  6 May 2025 15:01:38 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F34F820EB
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 15:01:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 546D1V8Z527454
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 6 May 2025 08:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746536491;
 bh=nkezEC3qotAUjd9Fup2PkT7frpNjbUbLlAob9UqWrsE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=tvPUWADWMd0SMTg2xp1zrrt0Lof5Jyj3FA/Pq/8sw3FCXaVMlrbuuvU/7paiCaXbg
 FMQpP2y/LECCT3noAt5gBJ6eckCrnumEuesCCf11mpmH9mIs7Tf2cZkHYsd/5xQkSD
 hIR8RRNK70xUHy8FyNvmnXNuZJktSl4qhnSvkAP4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 546D1VSJ092513
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 6 May 2025 08:01:31 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 May 2025 08:01:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 May 2025 08:01:30 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 546D1Urn060036;
 Tue, 6 May 2025 08:01:30 -0500
Date: Tue, 6 May 2025 08:01:30 -0500
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Wadim Egorov <w.egorov@phytec.de>, Nishanth Menon <nm@ti.com>, "Robert
 Nelson" <robertcnelson@gmail.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Garrett Giordano <ggiordano@phytec.com>,
 Apurva Nandan <a-nandan@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] arm: dts: k3: require mandatory firmware in binman
Message-ID: <20250506130130.av3ffctyoi7u4olv@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250429-non-optional-v1-1-b4cad3bc7789@ti.com>
 <20250505202012.GA51730@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250505202012.GA51730@bill-the-cat>
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

On May  5, 2025 thus sayeth Tom Rini:
> On Tue, Apr 29, 2025 at 03:01:56PM -0500, Bryan Brattlof wrote:
> 
> > TI's Foundational Security (TIFS), Device Management (DM) and Device
> > Management and Security Control (DMSC) firmware are required for a
> > successful boot. Remove the 'optional' flag so binman will emit an error
> > if these firmware components are not found
> > 
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> 
> Can you please rebase this to master? Thanks.

Ah yeah my bad. I completely forgot about Andrew's stuff

~Bryan
