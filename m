Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61FDC2BD09
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 15:28:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34AE4886AA;
	Mon,  1 Jul 2024 17:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FRCy0IqN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB3AB886A0; Mon,  1 Jul 2024 17:28:33 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FA59886B8
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 17:28:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 461FSNHt022430;
 Mon, 1 Jul 2024 10:28:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719847704;
 bh=ubV4zUkKVUwYLhtxaQNpUiB+N2AbeesaPu6x0Qwj+N8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=FRCy0IqNpr2J597Gqp30u0ipQTtloDNwkZTwjezXV2J12v/nQEA+BMDHeYq89/3Ab
 uFJMNxSA2xapDLmhOlgkQbGGDtJXy8H8yMNRhb1T+adRPpFMbwcUyVLCYkXe8qKBmE
 6EFYe+IZTFjex9gDYBxoVwdghCimxzc256V/Ej7I=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 461FSN03050562
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 1 Jul 2024 10:28:23 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Jul 2024 10:28:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Jul 2024 10:28:23 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 461FSNQQ128198;
 Mon, 1 Jul 2024 10:28:23 -0500
Date: Mon, 1 Jul 2024 10:28:23 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Tom
 Rini <trini@konsulko.com>, Vaishnav Achath <vaishnav.a@ti.com>, Jayesh
 Choudhary <j-choudhary@ti.com>,
 Joe Hershberger <joe.hershberger@ni.com>, <u-boot@lists.denx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v2 0/4] Fix fdtfile for j722s and am62p
Message-ID: <20240701152823.qa73d3s3meln34es@accurate>
References: <20240701-b4-upstream-streamline-platform-v2-0-7539ff066b58@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240701-b4-upstream-streamline-platform-v2-0-7539ff066b58@ti.com>
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

On 10:48-20240701, Manorit Chawdhry wrote:
> fdtfile wasn't being populated in these boards, add the code in evm.c
> for the same.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
> Changes in v2:
> - Replace findfdt with fdtfile as that is what the series fixes. (Nishanth)
> - Drop findfdt as well for K3 platforms legacy support
> - Link to v1: https://lore.kernel.org/r/20240628-b4-upstream-streamline-platform-v1-0-17659af992c1@ti.com
> 
> ---


Please explain in your patches the impact the changes have on all
platforms - not just TI K3 platforms. that was already asked on previous
reviews, please provide the explanations in commit message to prevent
folks from having to guess.

> Dhruva Gole (1):
>       include: env: ti_common: Remove findfdt
> 
> Manorit Chawdhry (3):
>       include: env: ti: mmc: Change name_fdt usage to fdtfile
>       board: ti: am62p|j722s: Add ti_set_fdt_env for fdtfile
>       configs: am62p|j722s_a53: Add CONFIG_BOARD_LATE_INIT
> 
>  board/ti/am62px/evm.c            | 9 +++++++++
>  board/ti/j722s/evm.c             | 9 +++++++++
>  configs/am62px_evm_a53_defconfig | 1 +
>  configs/j722s_evm_a53_defconfig  | 1 +
>  include/env/ti/mmc.env           | 2 +-
>  include/env/ti/ti_common.env     | 2 +-
>  6 files changed, 22 insertions(+), 2 deletions(-)
> ---
> base-commit: 899b088674b6905710ce546f0a8848662904852a
> change-id: 20240628-b4-upstream-streamline-platform-f0d7453637b2
> 
> Best regards,
> -- 
> Manorit Chawdhry <m-chawdhry@ti.com>
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
