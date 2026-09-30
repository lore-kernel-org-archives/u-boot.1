Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E5DCA5FC7
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 16:47:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F5D960845;
	Wed, 30 Sep 2026 16:47:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PQfgXxVQB_QS; Wed, 30 Sep 2026 16:47:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 3F5D360897
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790786827;
	b=V+2f8V1Y9Dss2iMcqxe2MsypJgDVs9vYNlXITBY4vxAATN/+YNcTY5bjrm1G8H1L4d8F
	 BdHBN6920gP2BqEfC4xXa6dox6are+gAPskBISS3t5J22bJdPiKPqFeCQFBYjfhw6pQuy
	 /YEFzcnwVYUCCXy9LyWhmGbu1KW9KxyeWhZbs+xXzruirMfwikpn7mu30xBhyAsDYwBEK
	 gD0TrUwOh/57cVwaFGqYvIe/+nsn4krd9smwP01vgpkm5Iu4dwdmJNpf2p9gLG+YfMHkT
	 4iGtZ9Jj3m04BQGZ1M/VQOghatQU/t8ZRxAz/Vys9VdyeHoOpYxSeK/mpg2g/N4Vv9g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790786827;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZmMclxusyI7VrNFYLPe3i6nFaIyI+TZ/YPUQbpzy6ck=;
	b=cfmziVbmv+7GOOTe45hKTLNpD5xk1Avjud9iS3turjU6uF0jS9C2BBpklH9ZWwPTV4SU
	 Dnau638EFGVWWV5uo+IOs0PVaxpFApmhxnIvDIHKEaufSjbdw9vnMZfK5m43Nfbq2XjSu
	 e2D6ZT3+w5Iussn/SeZuRKe4H/Dz7Wx4S3MihMoH/Ssbbrlle2ifBGNPzk2mrYCSGyAzk
	 KacGysXMZVI0wkk97nnPQqsT70iOcQr/3a8hr2jaVOXH8UyFb78arWKdHXtBhCxs3m9id
	 QQ32RGdiXN639RsheFYrBx/bgNBAQ/q+mgug1MABbiXZy3IEG1pcES5qqvBEsKZ3ZOg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790786827;
	bh=ZmMclxusyI7VrNFYLPe3i6nFaIyI+TZ/YPUQbpzy6ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ctVVuHb1ufToVTpiaoIqa0/glsGqic0MlD1GUHipr9ntg0GVl3c6K0EPB2CQTbXvJ
	 cX2jDa9WajX+o9G2VK233hLYZslYqJu82G7X+QVIqp9K/jXRyExh89c6/DdkEIjhIW
	 AJgdgOp+kJwBzYDEzA6s8sEJzjbSTHtZiCQoRLQI/kIS9io4bM0cLv49evQfYKvewp
	 qao0PlsyBX8uPVA0f5M63VpSiw8DvwPqrzIcYeR91sSXejXeNRCQ+aR9iRVofZsXoF
	 LbEYvcDib9Tma5PB9iKqSTgtk2tYp2EmDLc3yYdjJwuTGpLXvWZ3R/bQNfX6SPVlOV
	 xuv5CGUxd6h/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F5D360897;
	Wed, 30 Sep 2026 16:47:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9859732A
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 16:47:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7DF5781109
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 16:47:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r84pxY4PO6p6 for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 16:47:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9C2FF81107
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790786825;
 b=NmAC0VQJFq33FATsjpbyUODxw0aOG6kQIvYzKi2HW2BLVrz8Ob+x3L47iZbqeCAABDwU
 gkk4pmPMHbKD2lggXGRpYXJOEFVzx052l3kRLTEDFB52XutpbsdfwRsgJkLKOLykJNqpv
 VH+gYBb3XKj69x2kebGT9tQxmMCKeOWiyT7/PjXxmMf5mv+9p2Y8nvkPq+GdQo/S0cRNU
 5RJ7wo+ZQxpMUUe+tV5dOA/D4WTm6p+EgKW4eZPnIJOtAqXlblpdefE2HTM+xHCaJui06
 Hh0tKRenjmpx1Hn9hDca+x6DXl819t43qNjn4ggP2t5jLhByPFaLe+uBvblzIhxOBzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790786825;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=ZmMclxusyI7VrNFYLPe3i6nFaIyI+TZ/YPUQbpzy6ck=;
 b=sPKo19yzeeHrTxSuCd/fcMz7DeTcxrbXyXa4D62xMcRTZlP24JgKHCMmdH5g5nRRb03F
 IAsYvJ8LldsXbfv2c942PmpG85lBNYVk8Rki6MXHNreHQ7DqZ4MvjdPywV58gUye25D0N
 nnral2eTKLsYYjubCjYAlA1xyOxp8+UuGvou3MiInwACRL/11oxKGlqYkwtfHG5zqJHFv
 8Vqsc3DQ28SfUkOvNbcqG74qS9PLTpeB2fmVVx847/ZvWHPnF/rxfHVT1plnaHDgLTYMu
 8h1NuBZdEzqcphDzdtbiuL1LkhxmK0Va4KijMg6MBWy3R6luL/a7gotzU58eh327uJQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=EF+bfF+I; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=EF+bfF+I
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9C2FF81107
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 16:47:00 +0000 (UTC)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49fff72474fso24706605e9.3
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 09:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790786819; x=1791391619;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZmMclxusyI7VrNFYLPe3i6nFaIyI+TZ/YPUQbpzy6ck=;
 b=EF+bfF+IF1E/uiEKv+V/9ugJQK8ry+lErLyXYfJVO7pQakkMc1pkKX9myAJOAtH9ni
 +pXq1Rmyd5cBXdqceXynJ/5XGa0eAbIuuasLkM8KPsmr2wFBic6LLbkD3zEpGosHHSCz
 mJABvOjp+ZhMALDMRp+HZX3nIdgqDjw7q3ShLf4B4jc0S4ApAcyL06HPU2G3o/AZi9lW
 tDtnS+HHw22PwISkMzSWbu9UZ7InB1MvSyFvnChDLV2ZyS7gs3vWMNLqRkD9AhOH41zX
 7CIn7P+yv1SVAXxSI83onzZB0Ejv90Asun/GdUmyzjgCauPq7qq1ewawaJB68XFXSIMi
 Spkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790786819; x=1791391619;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZmMclxusyI7VrNFYLPe3i6nFaIyI+TZ/YPUQbpzy6ck=;
 b=PfExzGsZnNMpp7IE3DVLm3iQxOv1gjBpaKMAYaclIoNnF4mj2cgThRbLVGaEnW6Jls
 eoHwkFhmxNcoBDYQCOmwWGsDSV98THOv3aCObHxwuLBaiD8jSYLZJw6bgyiloq7yfusa
 W0t4Fa+p8MIvsIStMiR+aup9oPQDFVrAhuGJbgvHO3XDd98EJXGlqsGaFYOmj75HEL/3
 1aSD2A0U7ecvfAp0KFSCqzgaZFz50gLt8aj/2biOqpv+/QI/vv+U3Ed1RS+5QiKoX8ea
 UndHkOmsPrGRxV50JiWyuL9V6YzPvre+q3e0qd5rfRXI0EsKRAfkrZUEnx6coj6PLE5r
 uDHA==
X-Gm-Message-State: AFuF++lqs/Oa8k8Jy41jajN92gj0PyirDtCxub0HLiKo0oMZK+oSB0KI
 u4kfoOT95V5DXtL5TkZzS19RzGvLPxscuYKZUzCsWlkP94VGkX5ZZ2fbpj8z4tcNpVQ=
X-Gm-Gg: AYBFou2GqHoX/JsnctG3pI05jgr572lmpilIK3PPNNMF25W8JsUQvuhPip45g1CV/BW
 iwikbxNkzwPMgVV3Ut2NYT350jdOQzfG4D+dOD3wYbVoMQhk5vAfgQ4yQkgcQ++3oweVbuq0W2G
 W3DzIytlNMXLHzXl1tyIomma2/2Kd8lho/uJ/ZNwbZAyyU1/1deQyHE30sKxopkdyowtFDxbqnO
 CxKtFz07VGNOhvqd4FJhQkiqGc7ZHzT+mzxPlBjiaf+8bEo/JsOE1LZEK9LoNGORIXc48DiJojP
 UgmqZ7UPoWByQMvZc8N1oAp0OYK7TU7TIYX0e8yPpIkCOsBRYA1THZQenFCyZBtXNDGs2+OwvGM
 UeEhPRZkBWFgAlN0SvjsMt+jRLIPEW7KZbeXr2WoKn7r3M6c/BMfo6p/L2DbLlGxplNVvUD4Vq2
 5RxdVJ6EONLzvTycyg7knHkep1J4U04ZeUR+RhYU84fQHaoofAfGtsYpQmAVnBdHuKjL62W7eua
 45jCB1wniKHbYzgVFzS9L0cPhT5FfW6JHbMSNufGAaV4NRiFsVObRLr2WD8pJqG3MLsdT4Xp0ky
 lCw=
X-Received: by 2002:a05:600c:6206:b0:49f:ce78:3561 with SMTP id
 5b1f17b1804b1-4a01b01a78dmr36181295e9.18.1790786818421; 
 Wed, 30 Sep 2026 09:46:58 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (mob-83-225-28-196.net.vodafone.it. [83.225.28.196])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01cd06778sm16208135e9.3.2026.09.30.09.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 09:46:57 -0700 (PDT)
Date: Wed, 30 Sep 2026 18:46:51 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Simon Glass <sjg@chromium.org>,
 Julien Masson <jmasson@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, Torsten Rupp <torsten.rupp@8tronix.de>,
 Eric Chung <eric.chung@riscstar.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>,
 James Hilliard <james.hilliard1@gmail.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>
Subject: Re: [PATCH] arm: mediatek: support firmware A/B selection in SPL
Message-ID: <ar03tIBOMqLDnugm@macbook.homenet.telecomitalia.it>
References: <20260924-ccaione-upstream-mt8390-ab-v1-1-352e05af3c35@baylibre.com>
 <9b70c0b2-96f1-4fb9-a40d-2199ab054fdf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b70c0b2-96f1-4fb9-a40d-2199ab054fdf@baylibre.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Tue, Sep 29, 2026 at 14:38:08 +0100, David Lechner wrote:
> On 9/24/26 3:44 PM, Carlo Caione wrote:
> > Genio firmware updates use MediaTek v1 metadata in misc to choose
> > between bootloaders and bootloaders_b. Support this ABI in SPL so
> > systems replacing BL2 can retain their firmware update and boot-success
> > handling.
> > 
> > Make selection opt-in, since trial boots need an updater and a
> > boot-success owner to maintain the retry state. Reject corrupt metadata
> > and failed state updates rather than silently restarting the retry
> > budget.
> > 
> > Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> > ---
> > This is intended for systems with an updater and a boot-success owner
> > that maintain the MediaTek v1 metadata. The option stays disabled in the
> > standard defconfigs. It covers the firmware FIT slots; the DDR loader and
> > SPL in boot0 remain shared.
> 
> Hmm... this might not get compile-tested if it isn't enabled somewhere by
> default. Will have to think about that more. I don't really want a bunch
> of defconfigs for every possible usage senario either because it takes time
> to compile each one and gets confusing as to which one someone should
> actually use.

I can probably add this to sandbox_spl but you probably want a more
robust and general solution for the architecture?
 
> > This patch depends on the dynamic MMC partition selection series V3 [1].
> > The mediatek-staging base e3ed6c6436ab includes both that series and the
> > Genio SPL support.
> > 
> > [1] https://lore.kernel.org/all/20260914-ccaione-upstream-part-dynamic-v3-0-a38c19e74563@baylibre.com/
> > ---
> >  arch/arm/mach-mediatek/Kconfig          |  17 ++++
> >  arch/arm/mach-mediatek/Makefile         |   1 +
> >  arch/arm/mach-mediatek/spl_ab.c         |  35 ++++++++
> >  doc/board/mediatek/mt8188-genio-evk.rst |  88 +++++++++++++++++++-
> >  include/mediatek/mtk_ab.h               |  48 +++++++++++
> >  include/mmc.h                           |   1 +
> >  lib/Kconfig                             |   1 +
> >  lib/Makefile                            |   2 +
> >  lib/mediatek/Kconfig                    |   9 +++
> >  lib/mediatek/Makefile                   |   3 +
> >  lib/mediatek/mtk_ab.c                   | 139 ++++++++++++++++++++++++++++++++
> 
> I don't see any other vendor libraries in lib/. Probably should live in
> arch/arm/mach-mediatek/ with the rest of it.

Fair point. I'll move it.
 
> >  11 files changed, 340 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
> > index 13d5819510e..316337949b4 100644
> > --- a/arch/arm/mach-mediatek/Kconfig
> > +++ b/arch/arm/mach-mediatek/Kconfig
> > @@ -221,6 +221,23 @@ config MTK_BROM_HEADER_INFO
> >  	default "media=emmc" if TARGET_MT8516 || TARGET_MT8365 || TARGET_MT8366 || TARGET_MT8183 || TARGET_MT8189 || TARGET_MT8195
> >  	default "lk=1" if TARGET_MT7623
> >  
> > +config SPL_MTK_FIRMWARE_AB
> > +	bool "MediaTek firmware A/B boot in SPL"
> > +	depends on TARGET_MT8188 && SPL_MMC && SPL_LOAD_FIT && SPL_BLK
> > +	depends on !SPL_RAW_IMAGE_SUPPORT && !SPL_LEGACY_IMAGE_FORMAT
> > +	depends on SPL_EFI_PARTITION
> > +	depends on SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC
> > +	depends on !SPL_OS_BOOT && !SPL_FS_FAT && !SPL_FS_EXT4
> > +	depends on !SPL_FS_SQUASHFS && !SPL_RAM_SUPPORT && !SUPPORT_EMMC_BOOT
> > +	select SPL_MTK_AB
> > +	select SPL_MMC_WRITE
> > +	help
> > +	  Select firmware FITs from the bootloaders and bootloaders_b GPT
> > +	  partitions using MediaTek A/B metadata in misc. Track trial boots
> > +	  and switch slots when retries are exhausted.
> > +
> > +	  An updater and a boot-success owner must maintain the metadata.
> > +
> >  config MTK_GENIO_BOOT_IMAGES
> >  	bool "Build MediaTek firmware images"
> >  	depends on TARGET_MT8188 && SPL
> > diff --git a/arch/arm/mach-mediatek/Makefile b/arch/arm/mach-mediatek/Makefile
> > index be3604a6776..96eb3ccb35c 100644
> > --- a/arch/arm/mach-mediatek/Makefile
> > +++ b/arch/arm/mach-mediatek/Makefile
> > @@ -5,6 +5,7 @@ obj-y	+= cpu.o
> >  obj-$(CONFIG_MTK_TZ_MOVABLE)	+= tzcfg.o
> >  obj-$(CONFIG_XPL_BUILD)	+= spl.o
> >  obj-$(CONFIG_MTK_BROM_DOWNLOAD_AGENT_SPL_FASTBOOT)	+= spl_fastboot.o
> > +obj-$(CONFIG_$(PHASE_)MTK_FIRMWARE_AB) += spl_ab.o
> >  
> >  obj-$(CONFIG_TARGET_MT7622) += mt7622/
> >  obj-$(CONFIG_TARGET_MT7623) += mt7623/
> > diff --git a/arch/arm/mach-mediatek/spl_ab.c b/arch/arm/mach-mediatek/spl_ab.c
> > new file mode 100644
> > index 00000000000..1a4b2f0bcc5
> > --- /dev/null
> > +++ b/arch/arm/mach-mediatek/spl_ab.c
> > @@ -0,0 +1,35 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/* Copyright (c) 2026 BayLibre SAS */
> > +
> > +#include <mmc.h>
> > +#include <mediatek/mtk_ab.h>
> > +#include <spl.h>
> > +
> > +int spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device)
> > +{
> > +	struct blk_desc *desc = mmc_get_blk_desc(mmc);
> > +	unsigned int slot;
> > +	int ret;
> > +
> > +	/* This platform boots firmware FITs from the eMMC user area only. */
> > +	if (IS_SD(mmc) || desc->hwpart || !mmc->ext_csd) {
> 
> mtk_ab_select() already checks desc->hwpart so we don't need to do it here too.

Agreed, I'll remove it.

> > +		ret = -ENODEV;
> > +		goto error;
> > +	}
> > +	/* U-Boot does not enable the eMMC cache; reject an unexpected cache. */
> 
> What code path could lead to this?

It was a speculative protection. I just checked if the cache is enabled
and it is not, so we can remove the check.

> > +	if (mmc->ext_csd[EXT_CSD_CACHE_CTRL]) {
> > +		ret = -EOPNOTSUPP;
> > +		goto error;
> > +	}
> > +
> > +	ret = mtk_ab_select(desc, &slot);
> > +	if (ret < 0)
> > +		goto error;
> > +
> > +	printf("MediaTek A/B: slot %c, partition %d\n", 'A' + slot, ret);
> > +	return ret;
> > +
> > +error:
> > +	printf("MediaTek A/B: selection failed (%d)\n", ret);
> > +	return ret;
> > +}
> > diff --git a/doc/board/mediatek/mt8188-genio-evk.rst b/doc/board/mediatek/mt8188-genio-evk.rst
> > index 43948bb4365..2f1d80c04cb 100644
> > --- a/doc/board/mediatek/mt8188-genio-evk.rst
> > +++ b/doc/board/mediatek/mt8188-genio-evk.rst
> > @@ -36,7 +36,8 @@ followed by U-Boot SPL. The DDR loader initializes DRAM, copies the fixed
> >  ``CONFIG_MTK_GENIO_DDR_LOADER_SIZE`` to ``CONFIG_SPL_TEXT_BASE`` and enters
> >  SPL at EL3 with exceptions masked.
> >  
> > -SPL reads a FIT image from partition 1 of the eMMC user area. The FIT contains
> > +By default, SPL reads a FIT image from partition 1 of the eMMC user area.
> > +Optional firmware A/B selection is described below. The FIT contains
> >  Arm Trusted Firmware-A (BL31), OP-TEE (BL32), U-Boot proper (BL33) and the
> >  U-Boot control devicetree. It is an ordinary, directly parseable FIT whose
> >  first word is the FDT magic; the complete FIT container must not be compressed.
> > @@ -225,7 +226,9 @@ For example, after enabling ``CONFIG_MTK_GENIO_BOOT_IMAGES`` as above::
> >           --enable SHA256 \
> >           --enable SPL_FIT_SIGNATURE \
> >           --enable SPL_RSA \
> > -         --enable SPL_SHA256
> > +         --enable SPL_SHA256 \
> > +         --disable SPL_RAW_IMAGE_SUPPORT \
> > +         --disable SPL_LEGACY_IMAGE_FORMAT
> 
> This seems unrelated. Should be a separate patch? Or not necessary? Seems
> like these should already be the default.

Ouch, this is actually something not related to this series. I'll push
it as standalone.

> >     $ make olddefconfig
> >     $ make BINMAN_INDIRS=/path/to/firmware-and-keys
> >  
> > @@ -252,12 +255,12 @@ Image                Destination
> >  ===================  ================================================
> >  
> >  The standard Genio 510 and Genio 700 partition layouts name GPT partition 1
> > -``bootloaders``. SPL selects the partition by number through
> > +``bootloaders``. By default, SPL selects the partition by number through
> >  ``CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION``; it does not locate it by name.
> >  
> >  Writing an invalid image to eMMC boot0 can make the board unbootable. Preserve
> >  the platform recovery path and any backup bootloader partition while testing.
> > -Selection of a backup partition is not implemented by this SPL configuration.
> > +Selection of a backup partition requires the optional firmware A/B support.
> >  
> >  Using Genio Tools
> >  ~~~~~~~~~~~~~~~~~
> > @@ -360,3 +363,80 @@ Use raw images with the eMMC boot-area aliases ``mmc0boot0`` and
> >  ``mmc0boot1``: these aliases write the downloaded bytes without expanding
> >  Android sparse images. Sparse flashing is supported for GPT partitions and
> >  the eMMC user-area alias.
> > +
> > +Firmware A/B in SPL
> > +------------------
> > +
> > +``CONFIG_SPL_MTK_FIRMWARE_AB`` enables A/B selection for the firmware loaded
> > +by SPL from eMMC. It is disabled by default. Enable it only with an updater
> > +that activates firmware slots and a service that confirms successful boots.
> > +After selecting the board defconfig, enable it with::
> > +
> > +   $ scripts/config --file "${KBUILD_OUTPUT}/.config" \
> > +         --disable SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION \
> > +         --enable SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_DYNAMIC \
> > +         --disable SPL_RAW_IMAGE_SUPPORT \
> > +         --disable SPL_LEGACY_IMAGE_FORMAT \
> > +         --enable SPL_MTK_FIRMWARE_AB
> > +   $ make olddefconfig
> > +
> > +Install a complete ``bootloaders.img`` FIT in each of the ``bootloaders``
> > +(slot A) and ``bootloaders_b`` (slot B) GPT partitions. The ``misc`` partition
> > +stores the selected slot and boot-attempt counters. When migrating from BL2,
> > +replace the FIP images in both slots with FIT images. If FIT signing is
> > +enabled, both images must be signed with a key trusted by the installed SPL.
> 
> And we would need the extra option enabled from the previous secton too
> for signed FIT images?

No, that is unrelated.

> > +
> > +The DDR loader and SPL in boot0 are shared by both firmware slots. Keep A/B
> > +disabled in download-agent builds.
> 
> Why does it matter? If there is a technical reason, maybe we should enforce
> that in Kconfig.

Wording is probably a bit too strong, it is just not used or tested,
especially if the user tries to issue a 'fastboot continue' when in DA.

> > +
> > +With SPL installed in the standard RITY eMMC layout, the boot flow is::
> > +
> > +              BootROM
> > +                 |
> > +                 v
> > +   +---------------------------+     +---------------------------+
> > +   | boot0                     |     | boot1                     |
> > +   | DDR loader -> SPL         |     | U-Boot environment        |
> > +   | shared by slots A and B   |     | not a firmware slot       |
> > +   +-------------+-------------+     +---------------------------+
> > +                 |
> > +                 v
> > +   +-------------------------------------------------------------+
> > +   | eMMC user area (GPT partitions)                             |
> > +   |                                                             |
> > +   |   +-----------------------------------------------------+   |
> > +   |   | misc                                                |   |
> > +   |   | Selected firmware slot and boot-attempt counters    |   |
> > +   |   +-------------------------+---------------------------+   |
> > +   |                             |                               |
> > +   |                     select A or B                           |
> > +   |              +--------------+--------------+                |
> > +   |              v                             v                |
> > +   |   +-----------------------+   +-------------------------+   |
> > +   |   | bootloaders (slot A)  |   | bootloaders_b (slot B)  |   |
> > +   |   | FIT: BL31, BL32, BL33 |   | FIT: BL31, BL32, BL33   |   |
> > +   |   +-----------------------+   +-------------------------+   |
> > +   +-------------------------------------------------------------+
> > +
> > +Firmware updates and rollback
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +Use an updater and boot-success service compatible with MediaTek firmware
> > +A/B metadata:
> > +
> > +1. Write and verify the new FIT in the inactive slot.
> > +2. Activate that slot for trial booting.
> > +3. After booting and completing the required health checks, mark the booted
> > +   slot successful.
> > +
> > +A newly activated trial slot has eight boot attempts. Without confirmation,
> > +even a working image eventually exhausts its attempts. SPL then selects the
> > +other slot on the following boot, provided that slot has attempts remaining
> > +or was previously marked successful. Blank metadata initially selects slot A.
> > +
> > +A failed FIT load or verification stops the current boot. Configure a watchdog
> > +or another reset mechanism if unattended retries are required. Keep a working
> > +download/recovery path for exhausted slots or damaged metadata, including
> > +damage caused by an interrupted metadata update. A slot already marked
> > +successful is no longer subject to trial retries; a later failure of that
> > +image requires recovery.
> 
> Are we going to need to add hooks for these extra recovery paths?

That would require an entirely different work not related to this IMO.
We are assuming a user intervention for recovery for these edge cases.

> > diff --git a/include/mediatek/mtk_ab.h b/include/mediatek/mtk_ab.h
> > new file mode 100644
> > index 00000000000..515c8c68f59
> > --- /dev/null
> > +++ b/include/mediatek/mtk_ab.h
> > @@ -0,0 +1,48 @@
> > +/* SPDX-License-Identifier: BSD-3-Clause */
> 
> I think code added to U-Boot is supposed to be GPL-2.0-or-later, so this
> needs AND with both licenses.

Indeed.

> > +/*
> > + * Copyright (c) 2023, Mediatek Inc. All rights reserved.
> > + * Copyright (c) 2026 BayLibre SAS
> > + */
> > +
> > +#ifndef __MEDIATEK_MTK_AB_H
> > +#define __MEDIATEK_MTK_AB_H
> > +
> > +#include <linux/types.h>
> > +
> > +struct blk_desc;
> > +
> > +#define MTK_AB_MAGIC	0x544f494d
> > +#define MTK_AB_VERSION	1
> > +#define MTK_AB_MAX_TRIES	9
> > +
> > +/* MediaTek v1 disk ABI, including the original AArch64 structure padding. */
> > +struct mtk_ab_control {
> > +	__le32 slot;
> > +	__le32 magic;
> > +	u8 version;
> > +	u8 tries[2];
> > +	u8 padding;
> > +	u8 reserved[12];
> > +	__le32 crc32;
> > +};
> > +
> > +/**
> > + * mtk_ab_select() - Select and account for a MediaTek firmware slot
> > + * @desc: Block device containing the GPT user area
> > + * @slot: Returns the selected slot (0 for A, 1 for B), only on success
> > + *
> > + * Resolve bootloaders, bootloaders_b and misc by name, validate the v1 record
> > + * at the start of misc, and persist any required retry update before returning.
> > + * The caller must provide a valid, non-overlapping GPT layout.
> > + * A zero counter denotes success; counters 1..8 consume a trial and 9 is
> > + * exhausted. Only an all-zero or all-0xff record is initialized automatically.
> > + * Writes preserve the rest of the block and are verified with an uncached read.
> > + * This single-copy format does not provide power-fail atomicity. The caller
> > + * must ensure device write caching cannot hide an uncommitted metadata write.
> 
> These last two sentances don't sound reasuring. Does our spl_mmc_boot_partition()
> implementation handle these?

This was the reason for the cache check. Not needed anymore.

> > + *
> > + * Return: Positive GPT partition number to boot, or a negative error. The
> > + * caller must stop booting on error; a failed write may have changed storage.
> > + */
> > +int mtk_ab_select(struct blk_desc *desc, unsigned int *slot);
> > +
> > +#endif
> > diff --git a/include/mmc.h b/include/mmc.h
> > index 9a796e0655f..623ca027ccf 100644
> > --- a/include/mmc.h
> > +++ b/include/mmc.h
> > @@ -212,6 +212,7 @@ static inline bool mmc_is_tuning_cmd(uint cmdidx)
> >  /*
> >   * EXT_CSD fields
> >   */
> > +#define EXT_CSD_CACHE_CTRL		33	/* R/W */
> >  #define EXT_CSD_BOOT_SIZE_MULT_MICRON	125	/* R/W, vendor specific field */
> >  #define EXT_CSD_ENH_START_ADDR		136	/* R/W */
> >  #define EXT_CSD_ENH_SIZE_MULT		140	/* R/W */
> 
> Would be good to split this out into a separate patch since it touches a
> separate subsytem.
> 
> I would also expect an explantion of why we need EXT_CSD_CACHE_CTRL when
> U-Boot hasn't needed it until now.

This is going to be entirely removed in the next version.

> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index b6e65b17ab6..147bf6865be 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -1364,3 +1364,4 @@ config UTHREAD_STACK_SIZE
> >  endmenu
> >  
> >  source "lib/fwu_updates/Kconfig"
> > +source "lib/mediatek/Kconfig"
> > diff --git a/lib/Makefile b/lib/Makefile
> > index 8710be39f3f..646a25a4630 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -3,6 +3,8 @@
> >  # (C) Copyright 2000-2006
> >  # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
> >  
> > +obj-$(CONFIG_$(PHASE_)MTK_AB) += mediatek/
> > +
> >  ifndef CONFIG_XPL_BUILD
> >  
> >  obj-$(CONFIG_EFI_CLIENT) += efi_client/
> > diff --git a/lib/mediatek/Kconfig b/lib/mediatek/Kconfig
> > new file mode 100644
> > index 00000000000..20110734e1e
> > --- /dev/null
> > +++ b/lib/mediatek/Kconfig
> > @@ -0,0 +1,9 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +
> > +config SPL_MTK_AB
> > +	bool
> > +	depends on SPL && SPL_EFI_PARTITION
> > +	select SPL_CRC32
> > +	help
> > +	  Select and account for firmware boot attempts using MediaTek v1
> > +	  metadata in the misc GPT partition.
> > diff --git a/lib/mediatek/Makefile b/lib/mediatek/Makefile
> > new file mode 100644
> > index 00000000000..71f8dbb374c
> > --- /dev/null
> > +++ b/lib/mediatek/Makefile
> > @@ -0,0 +1,3 @@
> > +# SPDX-License-Identifier: GPL-2.0+
> > +
> > +obj-y += mtk_ab.o
> > diff --git a/lib/mediatek/mtk_ab.c b/lib/mediatek/mtk_ab.c
> > new file mode 100644
> > index 00000000000..8fa69bc1dbc
> > --- /dev/null
> > +++ b/lib/mediatek/mtk_ab.c
> > @@ -0,0 +1,139 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) 2023, Mediatek Inc. All rights reserved.
> > + * Copyright (c) 2026 BayLibre SAS
> > + *
> > + * Disk format and valid-record transitions follow MediaTek's TF-A mtk_ab.c.
> > + */
> > +
> > +#include <blk.h>
> > +#include <log.h>
> 
> Either should be including <stdio.h> instead for printf() or switch to log
> functions.

I'll fix this.

> > +#include <malloc.h>
> > +#include <memalign.h>
> > +#include <mediatek/mtk_ab.h>
> > +#include <part.h>
> > +#include <linux/build_bug.h>
> > +#include <linux/errno.h>
> > +#include <linux/log2.h>
> > +#include <u-boot/crc.h>
> 
> And a few more that are only included indirectly.
> 
> linux/string.h (memcmp), asm/byteorder.h (cpu_to_le32), linux/kernel.h
> (ARRAY_SIZE).

ACK

> > +
> > +#define MTK_AB_MISC_INDEX	2
> > +
> > +static_assert(sizeof(struct mtk_ab_control) == 28);
> > +static_assert(offsetof(struct mtk_ab_control, padding) == 11);
> > +static_assert(offsetof(struct mtk_ab_control, reserved) == 12);
> > +static_assert(offsetof(struct mtk_ab_control, crc32) == 24);
> > +
> > +static u32 mtk_ab_crc(const struct mtk_ab_control *ctrl)
> > +{
> > +	return crc32(0, (const void *)ctrl, offsetof(struct mtk_ab_control, crc32));
> > +}
> > +
> > +static int mtk_ab_layout(struct blk_desc *desc, struct disk_partition *parts,
> > +			 int *numbers)
> > +{
> > +	static const char * const names[] = { "bootloaders", "bootloaders_b", "misc" };
> > +	int i;
> > +
> > +	part_init(desc);
> > +	if (desc->part_type != PART_TYPE_EFI)
> > +		return -EPROTONOSUPPORT;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(names); i++) {
> > +		numbers[i] = part_get_info_by_name(desc, names[i], &parts[i]);
> > +		if (numbers[i] < 0)
> > +			return numbers[i];
> > +	}
> > +
> > +	/* The metadata read-modify-write needs one block in misc. */
> > +	if (!parts[MTK_AB_MISC_INDEX].start || !parts[MTK_AB_MISC_INDEX].size ||
> > +	    parts[MTK_AB_MISC_INDEX].start >= desc->lba)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +int mtk_ab_select(struct blk_desc *desc, unsigned int *slot)
> > +{
> > +	struct disk_partition parts[3];
> > +	struct mtk_ab_control *ctrl;
> > +	unsigned int selected;
> > +	int numbers[3], ret;
> > +	void *block, *verify;
> > +	bool changed = false;
> > +
> > +	if (!desc || !slot || !desc->lba || desc->hwpart || desc->blksz < 512 ||
> > +	    desc->blksz > 4096 || !is_power_of_2(desc->blksz) ||
> > +	    desc->blksz % ARCH_DMA_MINALIGN)
> > +		return -EINVAL;
> > +
> > +	/* Locate all required partitions before updating the metadata. */
> > +	ret = mtk_ab_layout(desc, parts, numbers);
> > +	if (ret)
> > +		return ret;
> > +
> > +	block = malloc_cache_aligned(2 * desc->blksz);
> > +	if (!block)
> > +		return -ENOMEM;
> > +	verify = block + desc->blksz;
> > +	ctrl = block;
> > +
> > +	ret = -EIO;
> > +	blkcache_invalidate(desc->uclass_id, desc->devnum);
> > +	if (blk_dread(desc, parts[MTK_AB_MISC_INDEX].start, 1, block) != 1)
> > +		goto out;
> > +
> > +	if (!memchr_inv(ctrl, 0, sizeof(*ctrl)) ||
> > +	    !memchr_inv(ctrl, 0xff, sizeof(*ctrl))) {
> > +		puts("MediaTek A/B: initializing blank metadata\n");
> > +		memset(ctrl, 0, sizeof(*ctrl));
> > +		ctrl->magic = cpu_to_le32(MTK_AB_MAGIC);
> > +		ctrl->version = MTK_AB_VERSION;
> > +		ctrl->tries[0] = 1;
> > +		ctrl->tries[1] = 1;
> > +		selected = 0;
> > +		changed = true;
> > +	} else {
> > +		ret = -EINVAL;
> > +		selected = le32_to_cpu(ctrl->slot);
> > +		if (le32_to_cpu(ctrl->magic) != MTK_AB_MAGIC ||
> > +		    ctrl->version != MTK_AB_VERSION || selected > 1 ||
> > +		    ctrl->tries[0] > MTK_AB_MAX_TRIES ||
> > +		    ctrl->tries[1] > MTK_AB_MAX_TRIES)
> > +			goto out;
> > +		ret = -EBADMSG;
> > +		if (le32_to_cpu(ctrl->crc32) != mtk_ab_crc(ctrl))
> > +			goto out;
> > +
> > +		if (ctrl->tries[selected] == MTK_AB_MAX_TRIES) {
> > +			selected ^= 1;
> > +			ret = -ENOENT;
> > +			if (ctrl->tries[selected] == MTK_AB_MAX_TRIES)
> > +				goto out;
> > +			ctrl->slot = cpu_to_le32(selected);
> > +			changed = true;
> > +		}
> > +		if (ctrl->tries[selected]) {
> > +			ctrl->tries[selected]++;
> > +			changed = true;
> > +		}
> > +	}
> > +
> > +	if (changed) {
> > +		ctrl->crc32 = cpu_to_le32(mtk_ab_crc(ctrl));
> > +		ret = -EIO;
> > +		if (blk_dwrite(desc, parts[MTK_AB_MISC_INDEX].start, 1, block) != 1)
> > +			goto out;
> > +		/* Do not verify a write against U-Boot's cached copy. */
> > +		blkcache_invalidate(desc->uclass_id, desc->devnum);
> > +		if (blk_dread(desc, parts[MTK_AB_MISC_INDEX].start, 1, verify) != 1 ||
> > +		    memcmp(block, verify, desc->blksz))
> > +			goto out;
> > +	}
> > +
> > +	*slot = selected;
> > +	ret = numbers[selected];
> > +out:
> > +	free(block);
> > +	return ret;
> > +}
> > 
> > ---
> > base-commit: e3ed6c6436abc18af0c7a0298ac72f83ebf2b5d1
> > change-id: 20260924-ccaione-upstream-mt8390-ab-631b4d4537f7
> > 
> > Best regards,
> > --  
> > Carlo Caione <ccaione@baylibre.com>
> 

Thanks!

--
Carlo Caione
