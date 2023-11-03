Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA160C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 02:55:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F92E86F31;
	Fri,  3 Nov 2023 03:55:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CNaIWjPg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB15A86F31; Fri,  3 Nov 2023 03:55:38 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52F6586FC3
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 03:55:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A32tSqf036916;
 Thu, 2 Nov 2023 21:55:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698980128;
 bh=KLAxhGMc5+octQo5qyFOwWAPS2/Uls6BJhKq1/DMp/A=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=CNaIWjPgI8efvK+jEufGz3t6INT4BGc0kbIUe3WRuk+L15IBYLH5KQovSFFP1kjMW
 no0R1erFivApPbm3v6XUXfsPlXudjeYAX3mkk7GyjCIAgTjMQC0HfTyQGyFs44ENcw
 RFNh4x6vP4I+hrEQ1kZ155RLzvlFdn2JiShm0xZQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A32tSnI101832
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 2 Nov 2023 21:55:28 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 Nov 2023 21:55:28 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 Nov 2023 21:55:28 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A32tSaM028273;
 Thu, 2 Nov 2023 21:55:28 -0500
Date: Thu, 2 Nov 2023 21:55:28 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: Neha Malcom Francis <n-francis@ti.com>, Bryan Brattlof <bb@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/3] doc: board: ti: Cleanup ::prompt usage
Message-ID: <20231103025528.x2o5thjly3f6rrwn@whiff>
References: <20231103000915.2413501-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231103000915.2413501-1-nm@ti.com>
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

On 19:09-20231102, Nishanth Menon wrote:
> Due to the sequence of merges, it looks like many of k3 documentation
> used code-blocks while the rest of the docs migrated to ::prompt.
> 
> Sync all to a common style.
> 
> based off:
> master 07fe79c93c5c Merge tag 'i2cfixes-for-v2024-01-rc2' of https://source.denx.de/u-boot/custodians/u-boot-i2c
> 
> Nishanth Menon (3):
>   doc: board: ti: Use prompt prompt_style to simplify documentation
>   doc: board: ti: k3: Use ::prompt for gdb commands
>   doc: board: ti: k3 docs: Use ::prompt
> 

I apologize for the noise. I just realized I have the formatting
off by one leading space and introduced a pervasive bug in this
series. please ignore this series, I will post a follow on v2.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
