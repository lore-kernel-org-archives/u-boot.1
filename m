Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A097ACD54AF
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 11:13:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B51E86B33;
	Tue, 19 Sep 2023 13:13:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hT0g0/D4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E988686B38; Tue, 19 Sep 2023 13:13:21 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5D0486B28
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 13:13:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38JBDF3s004573;
 Tue, 19 Sep 2023 06:13:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695121995;
 bh=Qqw6fqECcZ4W2RMXnpP92go5jvtIN4fubPku1a4QCuM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=hT0g0/D4vSI/epnsRyc+VeROCiYqEHxiHiVzljc4rmy0jjXXXdV3hmQ7HMtGoCovs
 7SPoi2Eum539j3ixWv3d7tNLK24QBEVmChzxuap9GpnkDPrdZgo9M8EWMKn0cbEe4Y
 bS31JdxZtrG9Xg7Rsa1lAuChWVmrwjkh2dp3eVRY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38JBDFdP023743
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 19 Sep 2023 06:13:15 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 19
 Sep 2023 06:13:15 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 19 Sep 2023 06:13:15 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38JBDEvg063286;
 Tue, 19 Sep 2023 06:13:14 -0500
Date: Tue, 19 Sep 2023 06:13:14 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Apurva Nandan
 <a-nandan@ti.com>,
 Andrew Davis <afd@ti.com>, Nikhil M Jain <n-jain1@ti.com>
Subject: Re: [PATCH] J721S2 DTS Sync from v6.6-rc1 to u-boot
Message-ID: <20230919111314.aumeucsnla6bk6zn@librarian>
References: <20230919-b4-upstream-j721s2-r5-pinmux-v5-0-a54d6ee26310@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230919-b4-upstream-j721s2-r5-pinmux-v5-0-a54d6ee26310@ti.com>
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

On 14:09-20230919, Manorit Chawdhry wrote:
> The sync tries to ensure that U-boot remains functional with the updated
> Linux DTS and all the fixes from Linux move to U-boot during the sync.
> 
> The series tries to sync from Linux v6.6-rc1 along with addition of
> the documentation for J721S2 that had been previously missing.
> 
> DMA fixes [0] are currently being upstreamed to Linux. 
> 
> Test Logs are included in [1]
> 
> [0]: https://lore.kernel.org/all/20230810174356.3322583-1-vigneshr@ti.com/
> [1]: https://gist.github.com/manorit2001/dbad09fd00e8b7c3872e85874c8e648c
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
> Changes in v5:
> - Fix the link ( Apurva )
> - Sync with v6.6-rc1
>     - Remove mcu_ringacc override from -u-boot.dtsi
> - Added a patch revert that bring some instability in SK-AM68
> - Update the commit messages to that of 6.6-rc1
> - Link to v4: https://lore.kernel.org/r/20230816-b4-upstream-j721s2-r5-pinmux-v4-0-dc114bece5d7@ti.com
> 
> ---
> Manorit Chawdhry (6):
>       Revert "arm: dts: k3-j7*: ddr: Update to 0.10 version of DDR config tool"
>       arm: mach-k3: j721s2: Add mcu_timer0 id to the dev list
>       k3-j721s2: Sync from Linux tag v6.6-rc1
>       k3-am68: Sync from Linux tag v6.6-rc1
>       docs: board: ti: Add j721s2_evm documentation
>       board: ti: j721s2: MAINTAINERS: Update the MAINTAINERS File.
> 
> Udit Kumar (1):
>       configs: j721s2_evm_r5_defconfig: Increase malloc pool size in DRAM
> 

Not sure what happened to your patches, but they are missing sequence
numbering and versioning info.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
