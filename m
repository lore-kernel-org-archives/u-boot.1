Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC77C83F1B
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 11:47:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E208783214;
	Wed, 16 Jul 2025 13:47:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BhdMrjd9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D65E883242; Wed, 16 Jul 2025 13:47:19 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 431AE831EA
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 13:47:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56GBlEMD2841149;
 Wed, 16 Jul 2025 06:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752666434;
 bh=4efkdxQiIGReOgpeQmUAKg7RMGuP1YzjNRYx31QMl7Y=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=BhdMrjd9rAGtXGGqJv8x3b/ArqQRg3jMRk1Z+K+CH7tLxmfFuVXvvBj8bgjbFlLbA
 Lx17U1q3SMPLWWocyNEC8eEToXTJvzoNEN8CtsgMPOfuweFdEWSdNNdjJGks3WzUFQ
 zuohy93nC6/aF3lFSPhuDFG1pRgRIPsrTVn72Org=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56GBlExf3540187
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 16 Jul 2025 06:47:14 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 16
 Jul 2025 06:47:13 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 16 Jul 2025 06:47:13 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56GBlDg5060737;
 Wed, 16 Jul 2025 06:47:13 -0500
Date: Wed, 16 Jul 2025 06:47:13 -0500
From: Bryan Brattlof <bb@ti.com>
To: Christian Marangi <ansuelsmth@gmail.com>
CC: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, Weijie
 Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/2] linux/sizes.h: add SZ_8G for 1GB RAM size
Message-ID: <20250716114713.ewd3tccn26velgrd@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250716073716.11698-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250716073716.11698-1-ansuelsmth@gmail.com>
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

On July 16, 2025 thus sayeth Christian Marangi:
> Add additional macro to handle a 1GB RAM size in 8Gb.
> 
> Drop the redundant entry from the Mediatek arch.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  arch/arm/mach-mediatek/mt7988/init.c | 2 --
>  include/linux/sizes.h                | 1 +
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mediatek/mt7988/init.c b/arch/arm/mach-mediatek/mt7988/init.c
> index 2efc8c6a88f..2b6f38983af 100644
> --- a/arch/arm/mach-mediatek/mt7988/init.c
> +++ b/arch/arm/mach-mediatek/mt7988/init.c
> @@ -12,8 +12,6 @@
>  
>  DECLARE_GLOBAL_DATA_PTR;
>  
> -#define SZ_8G				_AC(0x200000000, ULL)
> -
>  int dram_init(void)
>  {
>  	int ret;
> diff --git a/include/linux/sizes.h b/include/linux/sizes.h
> index fbde0bc7e88..35a23d714b7 100644
> --- a/include/linux/sizes.h
> +++ b/include/linux/sizes.h
> @@ -47,5 +47,6 @@
>  #define SZ_2G				0x80000000
>  
>  #define SZ_4G				_AC(0x100000000, ULL)
> +#define SZ_8G				_AC(0x200000000, ULL)

Should we just copy over linux/sizes.h from the kernel? It seems like 
we're missing more than just SZ_8G from them

~Bryan
