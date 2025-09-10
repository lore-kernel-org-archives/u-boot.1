Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F008DCA0FED
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 05:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 345C2830B4;
	Wed, 10 Sep 2025 07:11:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uCnV7NwR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C7A3831A4; Wed, 10 Sep 2025 07:11:11 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2505E830A0
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 07:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58A5B5JM494979;
 Wed, 10 Sep 2025 00:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757481065;
 bh=JiV0nOgOg1r58Au9R7VFiJKFL6IasZjIIQvdNw8sJCI=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=uCnV7NwRfomvFhV0N+rtUE3SHXsSN0xXRybmPERPuVNRiHIVxoWHSgndNu7A4QcZB
 T4J5jrUkKOB1SBdMj022tjuqzz6XbisLPw4NY2Nkx5VAGroh+f5tn9V5PGyx6fxqN/
 z+fzfIutn7yU1stRD81sBNXZyNqd9enR8ywYjMqQ=
Received: from DFLE20.ent.ti.com (dfle20.ent.ti.com [10.64.6.57])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58A5B46Z3681270
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 10 Sep 2025 00:11:04 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE20.ent.ti.com
 (10.64.6.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Sep
 2025 00:11:04 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Sep 2025 00:11:04 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58A5B3sQ3850543;
 Wed, 10 Sep 2025 00:11:03 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 10 Sep 2025 10:41:02 +0530
Message-ID: <DCOV1IAT8POW.2FSM1HT913MBE@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Wadim Egorov <w.egorov@phytec.de>, <ggiordano@phytec.com>,
 <trini@konsulko.com>, <d.schultz@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: Re: [PATCH 1/2] configs: phycore_am62ax_r5_defconfig: eMMC boot
 from raw offsets
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250909103654.3341398-1-w.egorov@phytec.de>
In-Reply-To: <20250909103654.3341398-1-w.egorov@phytec.de>
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

On Tue Sep 9, 2025 at 4:06 PM IST, Wadim Egorov wrote:
> From: Daniel Schultz <d.schultz@phytec.de>
>
> Enable CONFIG_SPL_SYS_MMCSD_RAW_MODE and set the offset address to
> boot from raw addresses instead of a FAT partition.
>
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  configs/phycore_am62ax_r5_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/configs/phycore_am62ax_r5_defconfig b/configs/phycore_am62ax=
_r5_defconfig
> index 01d100842de..584a6415ca5 100644
> --- a/configs/phycore_am62ax_r5_defconfig
> +++ b/configs/phycore_am62ax_r5_defconfig
> @@ -42,6 +42,8 @@ CONFIG_SPL_SYS_MALLOC=3Dy
>  CONFIG_SPL_HAS_CUSTOM_MALLOC_START=3Dy
>  CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=3D0x84000000
>  CONFIG_SPL_EARLY_BSS=3Dy
> +CONFIG_SPL_SYS_MMCSD_RAW_MODE=3Dy
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D0x400
>  CONFIG_SPL_DMA=3Dy
>  CONFIG_SPL_DM_MAILBOX=3Dy
>  CONFIG_SPL_MTD=3Dy

Looks good to me,
Acked-by: Anshul Dalal <anshuld@ti.com>

Regards
