Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DA2C4707B
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 19:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19401878DF;
	Tue,  9 Jan 2024 20:29:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oUBi2IiS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17C608797B; Tue,  9 Jan 2024 20:29:34 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 352CC878D7
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 20:29:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 409JTQ9X067934;
 Tue, 9 Jan 2024 13:29:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704828566;
 bh=SVW5avyHIcrB8Q8gKHDX28NjhHJgK3LRvM2a+WqD7Q4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=oUBi2IiSdHs2J4puDAN5a8CmdJDmDHtEVx4OenAca+E+wcNTJoEJjSEe4mpYX93sE
 lAhMKpRhoawLBgPc9K0ChWGQDxipYa+Pnv8KeDONk14HZpjSU/BFISont+hXV5wijU
 kY8GICXb1Xr6NrhCRnJ1B0BvYTH0pnDiKInxK+wk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 409JTQ4b005496
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Jan 2024 13:29:26 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jan 2024 13:29:25 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jan 2024 13:29:25 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 409JTPfp119687;
 Tue, 9 Jan 2024 13:29:25 -0600
Date: Tue, 9 Jan 2024 13:29:25 -0600
From: Nishanth Menon <nm@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <praneeth@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] board: ti: am64: Support TMDS64EVM
Message-ID: <20240109192925.yzod5ttvxhnlr6a2@dreamy>
References: <20240108131650.100519-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240108131650.100519-1-rogerq@kernel.org>
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

On 15:16-20240108, Roger Quadros wrote:
> The TMDS64EVM [1] ships with AM64X SR2.0 HS-FS chip
> and a slightly different board name in the board information
> EEPROM header. Support this board.
> 
> [1] https://www.ti.com/tool/TMDS64EVM
> 
> Gets rid of below message at boot
> "Unidentified board claims AM64-EVM in eeprom header"
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  board/ti/am64x/evm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
> index a6dcff2eb4..a7ca6be436 100644
> --- a/board/ti/am64x/evm.c
> +++ b/board/ti/am64x/evm.c
> @@ -18,6 +18,7 @@
>  #include "../common/board_detect.h"
>  
>  #define board_is_am64x_gpevm() (board_ti_k3_is("AM64-GPEVM") || \
> +				board_ti_k3_is("AM64-EVM") || \
>  				board_ti_k3_is("AM64-HSEVM"))
>  
>  #define board_is_am64x_skevm() (board_ti_k3_is("AM64-SKEVM") || \
> 
> base-commit: c2c598e87cfe56f5991730762c00733c5aa9a994
> -- 
> 2.34.1
> 

Reviewed-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
