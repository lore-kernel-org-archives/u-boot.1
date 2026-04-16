Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360FAF8A143
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 08:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0C24841D5;
	Thu, 16 Apr 2026 10:31:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="mtpMzXck";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E63A884206; Thu, 16 Apr 2026 10:31:36 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 019C483FC0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 10:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: a8ac5c0e396e11f1ae70033691e9ac7d-20260416
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=Coj2DEdljOhTjMLJdAJ+AsU1ATBYEYGUVBDZ6IqlleY=; 
 b=mtpMzXckUX2n3BA+G0nVDDVYjHDMDOD9wpQqW9WSvRCZbdSznL5v/UCuxxOGJWRXQa8kzFowcJQSFp59efuLl6ofwEYn6x9OEhhAzq+6ix+SHtLqDIOJ+UTA4ZhM0EPN8J/U6E269LT9FXrJgyZTHuM6htsAecMW4cPF07PW8I4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:f0aa15e4-d3f4-422d-8398-c65ef6905e9e, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:4d3b7e8f-6df4-4a3d-a7a4-fbdc42d669ce,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|865|888|898,TC:-
 5,Content:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC
 :-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a8ac5c0e396e11f1ae70033691e9ac7d-20260416
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 761357286; Thu, 16 Apr 2026 16:31:26 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 16 Apr 2026 16:31:25 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 16 Apr 2026 16:31:24 +0800
Message-ID: <9a2d4af913ac25e0e5b14194fc223137fa3c10ab.camel@mediatek.com>
Subject: Re: [PATCH] lib/Kconfig: Fix SUPPORTS_FW_LOADER option
From: Weijie Gao <weijie.gao@mediatek.com>
To: David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>
CC: Julien Stephan <jstephan@baylibre.com>, <u-boot@lists.denx.de>
Date: Thu, 16 Apr 2026 16:31:24 +0800
In-Reply-To: <20260415-lib-fix-supports_fw_loader-v1-1-3b27b4034981@baylibre.com>
References: <20260415-lib-fix-supports_fw_loader-v1-1-3b27b4034981@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK: N
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

On Wed, 2026-04-15 at 16:37 -0500, David Lechner wrote:
> Change the SUPPORTS_FW_LOADER option to be enabled by default.
> 
> This is a dependency-only option intended to be used like:
>     depends on SUPPORTS_FW_LOADER
> 
> Instead of having to always remember to do both:
>     depends on CMDLINE
>     depends on ENV_SUPPORT
> 
> In order to actually work though, the option has to be enabled.
> 
> Reported-by: Weijie Gao <weijie.gao@mediatek.com>
> Closes: 
> https://lore.kernel.org/u-boot/20260410015311.4066075-1-weijie.gao@mediatek.com/
>  
> Fixes: 4ed440e6be80 ("fw_loader: Introduce SUPPORTS_FW_LOADER
> symbol")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> I tested this a bit by fiddling with a local .config. It had
> CONFIG_SUPPORTS_FW_LOADER=y already because both dependencies
> were met. Then I manually set CONFIG_CMDLINE=n which caused
> CONFIG_SUPPORTS_FW_LOADER to disappear from the .config.
> ---
>  lib/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 4e6a0c6a1b6..0950b80ede5 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -72,7 +72,7 @@ config DYNAMIC_CRC_TABLE
>  	  This can be helpful when reducing the size of the build image
>  
>  config SUPPORTS_FW_LOADER
> -	bool
> +	def_bool y
>  	depends on CMDLINE
>  	depends on ENV_SUPPORT
>  

Tested-by: Weijie Gao <weijie.gao@mediatek.com>

Thanks
> 
> ---
> base-commit: 70fd0c3bb7c26d42f24d10145dd5f3168ac92eac
> change-id: 20260415-lib-fix-supports_fw_loader-af28afa23009
> 
> Best regards,
> --  
> David Lechner <dlechner@baylibre.com>
> 

