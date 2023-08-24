Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F64C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 16:22:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B736865A7;
	Thu, 24 Aug 2023 18:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KnZVxPY8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D65DB86672; Thu, 24 Aug 2023 18:22:55 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10DB38077D
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 18:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37OGMlUA090444;
 Thu, 24 Aug 2023 11:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692894167;
 bh=y0ir+Utju7AtD6Us7hh/xyC/Tw195sVMgY9WC/+GUyk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=KnZVxPY8oOJeuPzCQZU4bdXILKFAm0psptn0IlsmAP9KKEe8E8OVfncLwsGqqaxOx
 +6JIaxG6xNDbMBhUJxw14HN/3xvqiBzxCh+dLWU1aIs+kuN9Aw/o5k9S7FiY+AtW3S
 4srHwqBHLKBtKJl+JnHxfQ1qe7W/vEZwQv98F81M=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37OGMlIZ032648
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 24 Aug 2023 11:22:47 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Aug 2023 11:22:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Aug 2023 11:22:47 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37OGMllL080975;
 Thu, 24 Aug 2023 11:22:47 -0500
Date: Thu, 24 Aug 2023 11:22:47 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Neha Francis <n-francis@ti.com>, Simon Glass <sjg@google.com>, Bryan
 <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH V5 08/17] include: env: ti: ti_common: Add a generic
 findfdt
Message-ID: <20230824162247.oeqooi3454skobnc@connected>
References: <20230824031101.3460411-1-nm@ti.com>
 <20230824031101.3460411-9-nm@ti.com>
 <20230824151439.GY3953269@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230824151439.GY3953269@bill-the-cat>
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

On 11:14-20230824, Tom Rini wrote:
> On Wed, Aug 23, 2023 at 10:10:52PM -0500, Nishanth Menon wrote:
> > ti_mmc bootmethod uses a findfdt routine that is expected to be
> > implemented by all platforms.
> > 
> > Define a default findfdt based on configured DEFAULT_DEVICE_TREE option
> > for u-boot. This saves duplication across multiple boards and handles
> > architecture folder location changes centrally.
> > 
> > TI ARMV7 platforms will need to override default_device_tree_subarch
> > in the env file to point to the appropriate platform. Note: default
> > "omap" is used to cater to "most common" default.
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> > New patch (part of bootstd transition)
> > 
> >  include/env/ti/ti_common.env | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
> > index e87a41a6590b..322f849a5560 100644
> > --- a/include/env/ti/ti_common.env
> > +++ b/include/env/ti/ti_common.env
> > @@ -32,3 +32,15 @@ bootcmd_ti_mmc=
> >  	else;
> >  		run get_kern_${boot}; run get_fdt_${boot}; run get_overlay_${boot}; run run_kern;
> >  	fi;
> > +default_device_tree=CONFIG_DEFAULT_DEVICE_TREE
> > +default_device_tree_arch=ti
> > +#ifdef CONFIG_ARM64
> > +findfdt=
> > +	setenv name_fdt ${default_device_tree_arch}/${default_device_tree}.dtb;
> > +	setenv fdtfile ${name_fdt}
> > +#else
> > +default_device_tree_subarch=omap
> > +findfdt=
> > +	setenv name_fdt ${default_device_tree_arch}/${default_device_tree_subarch}/${default_device_tree}.dtb;
> > +	setenv fdtfile ${name_fdt}
> > +#endif
> 
> How does this override work in practice?  I fear that it's relying on
> the (not exactly documented) mechanic of "last one set generally work".

I was depending on that -> since we work with #includes anyways - I had
assumed it implicitly.

> So perhaps we don't want this in ti_common.env but instead
> include/env/ti/default_findfdt.env and then #include that, and then
> platforms that need different just don't #include this.

Sure, I can do that in the next spin. Will wait a couple of days for any
further feedback to fixup (without broadening scope unless mandatory).


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
