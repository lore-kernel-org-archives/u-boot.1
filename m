Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD5AC2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 13:06:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D060A885BC;
	Fri, 28 Jun 2024 15:06:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OCaZZh0c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 95485885BF; Fri, 28 Jun 2024 15:06:54 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F55987EB4
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 15:06:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45SD6mWg092541;
 Fri, 28 Jun 2024 08:06:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719580008;
 bh=vlnNwYvUpGXgyDgnfsuzHsjq0gehKKszVwqeBosOdHc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=OCaZZh0cAp1zOe0PxQBuFdm4yswwu0XIqUgigOyxBPiY6wgUUmlwnFR/b6VZ8yXtn
 e5BAUtTh6RMbnR3O+18aAlOExrVZHDO18JjLlW1bdyPuypKx4Llqt8HUGsLpnzJlDJ
 ODKDawGu0rV+GVfu0RnjrgCYIvrZgXTC3GSVrtT8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45SD6mXD104955
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 28 Jun 2024 08:06:48 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jun 2024 08:06:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jun 2024 08:06:47 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45SD6lpn009206;
 Fri, 28 Jun 2024 08:06:47 -0500
Date: Fri, 28 Jun 2024 08:06:47 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Tom
 Rini <trini@konsulko.com>, Vaishnav Achath <vaishnav.a@ti.com>, Jayesh
 Choudhary <j-choudhary@ti.com>,
 Joe Hershberger <joe.hershberger@ni.com>, <u-boot@lists.denx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH 0/3] Fix findfdt for j722s and am62p
Message-ID: <20240628130647.slzitudem52xf5f3@wobble>
References: <20240628-b4-upstream-streamline-platform-v1-0-17659af992c1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240628-b4-upstream-streamline-platform-v1-0-17659af992c1@ti.com>
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

On 13:53-20240628, Manorit Chawdhry wrote:
> findfdt wasn't being populated in these boards, add the code in evm.c
> for the same.

why not just drop findfdt? I am ok with #2,3 more or less, but keeping
findfdt alive is just a bad direction when we are moving to stdboot
flow.


> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
> Manorit Chawdhry (3):
>       include: env: ti: mmc: Change name_fdt usage to fdtfile
>       board: ti: am62p|j722s: Add ti_set_fdt_env for findfdt
>       configs: am62p|j722s_a53: Add CONFIG_BOARD_LATE_INIT
> 
>  board/ti/am62px/evm.c            | 9 +++++++++
>  board/ti/j722s/evm.c             | 9 +++++++++
>  configs/am62px_evm_a53_defconfig | 1 +
>  configs/j722s_evm_a53_defconfig  | 1 +
>  include/env/ti/mmc.env           | 2 +-
>  5 files changed, 21 insertions(+), 1 deletion(-)
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
