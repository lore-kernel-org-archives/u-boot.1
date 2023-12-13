Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E6DC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 14:56:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32A1A8779D;
	Wed, 13 Dec 2023 15:56:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Mm24NoyY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7358D87509; Wed, 13 Dec 2023 15:56:53 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EB1B877F8
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 15:56:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BDEuR1L043394;
 Wed, 13 Dec 2023 08:56:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1702479387;
 bh=5juCWlj059/fjNoFoMupOnMt6nTi9VWN+TN9rK64Yms=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Mm24NoyY/5Q5t3DijMZ/fWUDtH4a5SySX/sQgGG6KSgbhzHFjkX8agBaWq/ZnD/GL
 jThl0QGwpY2VRYq8lBtQdnqD8XJ69Gpn9tTTJIQmAHoFZShgyj3xsakcLMXn00rBEt
 /iMv/ngxfrdGt1AQtbQMgVeJDJiQbzuTfo+r8/pk=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BDEuRhx099783
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 13 Dec 2023 08:56:27 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Dec 2023 08:56:27 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Dec 2023 08:56:26 -0600
Received: from [172.24.227.6] (devarsht.dhcp.ti.com [172.24.227.6])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BDEuMWG069212;
 Wed, 13 Dec 2023 08:56:23 -0600
Message-ID: <871ec46f-feb6-146f-91f9-6f02c0da3b45@ti.com>
Date: Wed, 13 Dec 2023 20:26:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 0/8] Move framebuffer reservation for SPL to RAM end
Content-Language: en-US
To: <u-boot@lists.denx.de>, <sjg@chromium.org>, <agust@denx.de>,
 <trini@konsulko.com>, <bmeng.cn@gmail.com>, <msuchanek@suse.de>,
 <rasmus.villemoes@prevas.dk>, <yangshiji66@outlook.com>
CC: <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>, <a-bhatia1@ti.com>,
 <j-luthra@ti.com>, <nsekhar@ti.com>, <n-jain1@ti.com>
References: <20231205155523.721784-1-devarsht@ti.com>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20231205155523.721784-1-devarsht@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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

Hi Antoine,

On 05/12/23 21:25, Devarsh Thakkar wrote:
> Move video memory reservation for SPL at end of RAM so that it does
> not interefere with reservations for next stage so that the next stage
> need not have holes in between for passed regions and instead it can
> maintain continuity in reservations.
> 
> Also catch the bloblist before starting reservations to avoid the same
> problem.
> 
> While at it, also fill missing fields in video handoff struct before
> passing it to next stage.
> 
> This is as per discussions at :
> For moving SPL framebuffer reservation at end of RAM:
> 
> https://lore.kernel.org/all/CAPnjgZ3xSoe_G3yrqwuAvoiVjUfZ+YQgkOR0ZTVXGT9VK8TwJg@mail.gmail.com/
> 
> For filling missing video handoff fields :
> https://lore.kernel.org/all/CAPnjgZ1Hs0rNf0JDirp6YPsOQ5=QqQSP9g9qRwLoOASUV8a4cw@mail.gmail.com/
> 
> Changelog:
> V2:
> - Make a generic function to reserve video memory at SPL stage.
> - Add debug prints while skipping framebuffer allocation at uboot.
> - Correct commenting style as suggested.
> 
> V3:
> - Change spl_reserve_video to spl_reserve_video_from_ram_top
>   which enforce framebuffer reservation from end of RAM.
> - Use gd->ram_top instead of local ram_top and update
>   gd->reloc_addr after each reservation.
> - Print error message on framebuffer reservation.
> - Update SPL doc with spl splash screen specific info.
> 
> V4:
> - Split patches into atomic commits.
> - Remove duplicate check for video blob passed addresses and error out
>   if invalid address/size received from blob.
> - Improve SPL documentation memory reservation scheme and print message
>   for video memory reservation from bloblist. 
> - Add Reviewed-By.
> 
> V5:
>  - Add comment for filling video handoff size with aligned size
>  - Use PHASE_BOARD_F while checking for U-boot proper stage
>  - Add Reviewed-by
> 

Is it possible to pull this series in if no further comments ?

Regards
Devarsh

> Test logs:
> https://gist.github.com/devarsht/30a3c1591270c9ebae00714b48d33058
> 
> Devarsh Thakkar (8):
>   spl: Enforce framebuffer reservation from end of RAM
>   arm: mach-k3: common: Reserve video memory from end of the RAM
>   board: ti: am62x: evm: Remove video_setup from spl_board_init
>   common/board_f: Catch bloblist before starting reservations
>   video: Skip framebuffer reservation if already reserved
>   video: Fill video handoff in video post probe
>   doc: spl: Add info for missing Kconfigs
>   doc: spl: Add info regarding memory reservation
> 
>  arch/arm/mach-k3/common.c    | 17 ++++++++++-----
>  board/ti/am62x/evm.c         | 18 ----------------
>  common/board_f.c             | 41 +++++++++++++++++++++++++++++++-----
>  common/spl/spl.c             | 19 +++++++++++++++++
>  doc/develop/spl.rst          | 37 ++++++++++++++++++++++++++++++++
>  drivers/video/video-uclass.c | 40 ++++++++++++++++++++++++-----------
>  include/spl.h                | 10 +++++++++
>  7 files changed, 142 insertions(+), 40 deletions(-)
> 
