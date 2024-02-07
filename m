Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323A3C4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 10:07:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9395A87BC3;
	Wed,  7 Feb 2024 11:07:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dzmkk8fM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 999E887CEA; Wed,  7 Feb 2024 11:07:46 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CB40876AE
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 11:07:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 417A7gJw069656;
 Wed, 7 Feb 2024 04:07:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1707300462;
 bh=l50mQZSK9btb9VZdbjLgSY0+Ur7x7Xb8uuDu0xaiX18=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=dzmkk8fMyMTWn8c7jQyXMlegS6ef8Zz17PKtK2CWEeQ5OKSm5zHu/3U8O8fBQLnjb
 O8iBq5rQvCqYn6Q2CEIKpp13BBfPYFT4d2ty+8Xc8q7MEwk+1O5yswmREkqvmRIxEr
 avErNkLLbl6gmc4r7g3PqdMAN/waK/iOlUQOccGk=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 417A7g8v031781
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 7 Feb 2024 04:07:42 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 04:07:42 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 04:07:42 -0600
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 417A7fiV119725;
 Wed, 7 Feb 2024 04:07:41 -0600
Date: Wed, 7 Feb 2024 15:37:40 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>, <u-boot@lists.denx.de>, Neha
 Malcom Francis <n-francis@ti.com>, Keerthy J <j-keerthy@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>, Tom Rini
 <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon
 <nm@ti.com>
Subject: Re: [PATCH 02/10] arm: dts: k3-am68*: Sync with 6.8-rc1
Message-ID: <20240207100740.jvvbkfblhrsf4spn@uda0497581>
References: <20240206-b4-upstream-j721s2-avs-v1-0-b75043c59969@ti.com>
 <20240206-b4-upstream-j721s2-avs-v1-2-b75043c59969@ti.com>
 <eb8c6fdf-642b-40a5-be41-d555b2488c4a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <eb8c6fdf-642b-40a5-be41-d555b2488c4a@ti.com>
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

Hi Andrew,

On 11:38-20240206, Andrew Davis wrote:
> On 2/6/24 6:21 AM, Manorit Chawdhry wrote:
> > Syncs the DT from Linux v6.8-rc1.
> > 
> > Remove udmap overrides and handle location change of chipid node.
> 
> Message doesn't match the patch. This patch should just be squashed
> into the previous one anyway.
> 

Ah yeah, oversight. Would see what should be done about it after Tom's
reply for OF_UPSTREAM, would change accordingly.

Regards,
Manorit

> Andrew
> 
> > 
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> >   arch/arm/dts/k3-am68-sk-base-board.dts | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/dts/k3-am68-sk-base-board.dts b/arch/arm/dts/k3-am68-sk-base-board.dts
> > index 1e1a82f9d2b8..d0cfdeac21fb 100644
> > --- a/arch/arm/dts/k3-am68-sk-base-board.dts
> > +++ b/arch/arm/dts/k3-am68-sk-base-board.dts
> > @@ -31,6 +31,7 @@
> >   		can1 = &mcu_mcan1;
> >   		can2 = &main_mcan6;
> >   		can3 = &main_mcan7;
> > +		ethernet0 = &cpsw_port1;
> >   	};
> >   	vusb_main: regulator-vusb-main5v0 {
> > 
