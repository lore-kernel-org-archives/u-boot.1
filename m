Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67053CD4F2B
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 08:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55E92864DD;
	Fri, 22 Sep 2023 10:47:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BPwmwKt9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F105864DD; Fri, 22 Sep 2023 10:47:48 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DCFF864D8
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 10:47:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38M8lJgG050081;
 Fri, 22 Sep 2023 03:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695372439;
 bh=dbgxohvwZZ3dB//Otiq+mQA7bX2/9Po51Buanp9uWnc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=BPwmwKt9Qgdi90PgulN5w7GtkpQ1mIbQEp5ITExvP4CPCKEhUr0v+i8dSIBteaSSw
 kTu3k5ouc5q0pfcn1Ihtf5LigZfZ4qcKZxwL0eQpzRMkSZVDqpkAGvK+FZ2+2/9GsB
 qdszP9rMRTuHobOz0PKBepS8LBzmnbQGOXVdtItU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38M8lJ61016108
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 22 Sep 2023 03:47:19 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 22
 Sep 2023 03:47:19 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 22 Sep 2023 03:47:19 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38M8lIf3013571;
 Fri, 22 Sep 2023 03:47:19 -0500
Date: Fri, 22 Sep 2023 14:17:18 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Udit Kumar
 <u-kumar1@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Aniket Limaye
 <a-limaye@ti.com>
Subject: Re: [PATCH v2] env: ti: ti_common.env: Fix get_overlaystring for FIT
 Image
Message-ID: <20230922084718.ei47zmf5kwwsumxy@ula0497581>
References: <20230921-b4-upstream-overlaystring-v2-1-22e0b71e3334@ti.com>
 <7e57d094-6b2d-d535-40d0-84a562889370@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7e57d094-6b2d-d535-40d0-84a562889370@ti.com>
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

On 12:03-20230921, Andrew Davis wrote:
> On 9/21/23 5:49 AM, Manorit Chawdhry wrote:
> > After the refactor with conf- nodes in fitImage, overlaystring wasn't
> > didn't handle the new conf- nodes in FIT Booting. Fix get_overlaystring
> > to handle conf- nodes.
> > 
> > Fixes: 837833a724b7 ("environment: ti: Add get_fit_config command to get FIT config string")
> > Reported-by: Aniket Limaye <a-limaye@ti.com>
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> > Test Logs:
> > => setenv name_overlays ti/k3-dt.dtbo ti/k3-dt1.dtbo
> > => run get_overlaystring
> > => printenv overlaystring
> > overlaystring=#conf-ti_k3-dt.dtbo#conf-ti_k3-dt1.dtbo
> > ---
> > Changes in v2:
> > - Fix tabs
> > - Link to v1: https://lore.kernel.org/r/20230919-b4-upstream-overlaystring-v1-1-4c56e8d66173@ti.com
> > ---
> >   include/env/ti/ti_common.env | 11 ++++++++---
> >   1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
> > index e87a41a6590b..bc554fe7ca6d 100644
> > --- a/include/env/ti/ti_common.env
> > +++ b/include/env/ti/ti_common.env
> > @@ -16,9 +16,14 @@ addr_fit=0x90000000
> >   name_fit=fitImage
> >   update_to_fit=setenv loadaddr ${addr_fit}; setenv bootfile ${name_fit}
> >   get_overlaystring=
> > -	for overlay in $name_overlays;
> > -	do;
> > -	setenv overlaystring ${overlaystring}'#'${overlay};
> > +	for overlay in $name_overlays; do;
> > +		if test ${boot_fit} -eq 1;
> > +			then
> 
> Why is the `then` tabbed out here, you can make it on the end of
> the above line, same as you changed for `do`. Then untab all this
> by one.
> 
> > +				setexpr name_fit_overlay gsub / _ conf-${overlay};
> > +				setenv overlaystring ${overlaystring}'#'${name_fit_overlay};
> > +			else
> > +				setenv overlaystring ${overlaystring}'#'${overlay};
> 
> If you set `overlay` using setexpr, then this line is common and doesn't need to
> be out here. Also do we use this overlaystring for anything other than the
> FIT case? And if not, why do we need this boot_fit == 1 check at all?

Ah, I see this is only for FIT usecase. I'll refactor the name too to
get_fit_overlaystring as that makes more sense then.

Regards,
Manorit

> 
> Andrew
> 
> > +		fi;
> >   	done;
> >   get_fit_config=setexpr name_fit_config gsub / _ conf-${fdtfile}
> >   run_fit=run get_fit_config; bootm ${addr_fit}#${name_fit_config}${overlaystring}
> > 
> > ---
> > base-commit: 2fe4b54556ea6271237b35de68dc458bfceab94c
> > change-id: 20230915-b4-upstream-overlaystring-207e28b8c5fb
> > 
> > Best regards,
