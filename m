Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D14C0218D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 06:47:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5911280F47;
	Fri, 31 Jan 2025 07:47:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="DN+hYC6k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9613180F50; Fri, 31 Jan 2025 07:47:17 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E858680F42
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 07:47:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 2f268fb4df9f11efbd192953cf12861f-20250131
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID;
 bh=IqkvYAFCisLR+tIbyMkXS+H9q+ZJGBUaF0Tkfa3L8cY=; 
 b=DN+hYC6kvblEe36Vx51Qe7DsYlgK944T+r9DlC5AR/flp/yKyapjfKlZodTO+ej56thqMaAox/9E7boOEU2azdO4AB1FaEG6JOjIXH/ixJzi880Gl0syhqmk60NpxjP76J7IcJ6TOIQXXJDum/ye0geQsL2aIAAEdB99GWvlRYw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46, REQID:d0f80412-dcfb-4e9b-9050-5b3620c732d0, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:60aa074, CLOUDID:bb56f5fe-c190-4cfe-938d-595d7f10e0dc,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
 EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
 A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2f268fb4df9f11efbd192953cf12861f-20250131
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 268708747; Fri, 31 Jan 2025 14:47:05 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 31 Jan 2025 14:47:04 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 31 Jan 2025 14:47:03 +0800
Message-ID: <cf776c4b739e312c95cdd59939ceb3160761abcf.camel@mediatek.com>
Subject: Re: [PATCH 1/8] pinctrl: mediatek: mt7981: rename reg-names to
 upstream linux format
From: Weijie Gao <weijie.gao@mediatek.com>
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Sam Shih
 <sam.shih@mediatek.com>, SkyLake.Huang <skylake.huang@mediatek.com>, John
 Crispin <john@phrozen.org>, Dong Huang <dong.huang@mediatek.com>,
 <u-boot@lists.denx.de>
Date: Fri, 31 Jan 2025 14:47:03 +0800
In-Reply-To: <20250127134046.26345-2-ansuelsmth@gmail.com>
References: <20250127134046.26345-1-ansuelsmth@gmail.com>
 <20250127134046.26345-2-ansuelsmth@gmail.com>
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

On Mon, 2025-01-27 at 14:40 +0100, Christian Marangi wrote:
> External email : Please do not click links or open attachments until
> you have verified the sender or the content.
> 
> 
> Rename reg-names to upstream linux format. Upstream linux drop the
> "_base". To make use of upstream DTSI, align to the upstream naming.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  arch/arm/dts/mt7981.dtsi                  | 6 +++---
>  drivers/pinctrl/mediatek/pinctrl-mt7981.c | 5 +++--
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/dts/mt7981.dtsi b/arch/arm/dts/mt7981.dtsi
> index 2844ab010de..3c8b9ab0574 100644
> --- a/arch/arm/dts/mt7981.dtsi
> +++ b/arch/arm/dts/mt7981.dtsi
> @@ -117,9 +117,9 @@
>                       <0x11f00000 0x1000>,
>                       <0x11f10000 0x1000>,
>                       <0x1000b000 0x1000>;
> -               reg-names = "gpio_base", "iocfg_rt_base",
> "iocfg_rm_base",
> -                           "iocfg_rb_base", "iocfg_lb_base",
> "iocfg_bl_base",
> -                           "iocfg_tm_base", "iocfg_tl_base", "eint";
> +               reg-names = "gpio", "iocfg_rt", "iocfg_rm",
> +                           "iocfg_rb", "iocfg_lb", "iocfg_bl",
> +                           "iocfg_tm", "iocfg_tl", "eint";
>                 gpio: gpio-controller {
>                         gpio-controller;
>                         #gpio-cells = <2>;
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7981.c
> b/drivers/pinctrl/mediatek/pinctrl-mt7981.c
> index 047e37bc9cd..d1c8afd9252 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mt7981.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt7981.c
> @@ -1012,8 +1012,9 @@ static const struct mtk_function_desc
> mt7981_functions[] = {
>  };
> 
>  static const char *const mt7981_pinctrl_register_base_names[] = {
> -       "gpio_base", "iocfg_rt_base", "iocfg_rm_base",
> "iocfg_rb_base",
> -       "iocfg_lb_base", "iocfg_bl_base", "iocfg_tm_base",
> "iocfg_tl_base",
> +       "gpio", "iocfg_rt", "iocfg_rm", "iocfg_rb",
> +       "iocfg_lb", "iocfg_bl", "iocfg_tm", "iocfg_tl",
> +       "eint",
>  };
> 
>  static const struct mtk_pinctrl_soc mt7981_data = {
> --
> 2.47.1
> 

Thanks!

Reviewed-by: Weijie Gao <weijie.gao@mediatek.com>
Tested-by: Weijie Gao <weijie.gao@mediatek.com>


