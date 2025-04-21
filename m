Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F27C369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 12:23:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 705F2809D4;
	Mon, 21 Apr 2025 14:23:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="W94y9S43";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5943C80BAD; Mon, 21 Apr 2025 14:23:44 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4C308070C
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 14:23:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53LCNbxu914779
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Apr 2025 07:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745238217;
 bh=bTHsccIxJpV1nItk+6GalqP0MnsS2Ays4OwNWjxqf50=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=W94y9S43bXwpzVOf6brXz4k6/qxMXZq7aYXFcP4IT9OKqJfN3x5vUxVnKgqgZg2Uh
 Rg1SYbGfMWfP1Dq1sKHIFzXNgDXIW/AytPtD2e4j0lbvjJXLgVhendhaDDP5P/BBv1
 W8cDy48IcqeJsYHj/AGlXzq4TflOUqxSToewKOYk=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53LCNbQj001561
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 21 Apr 2025 07:23:37 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 21
 Apr 2025 07:23:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 21 Apr 2025 07:23:36 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53LCNalb045128;
 Mon, 21 Apr 2025 07:23:36 -0500
Date: Mon, 21 Apr 2025 07:23:36 -0500
From: Nishanth Menon <nm@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Beleswar Padhi <b-padhi@ti.com>, Jonathan
 Humphreys <j-humphreys@ti.com>, Andrew Davis <afd@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH V2 5/9] beagle: beagley-ai: env: Enable DFU env options
Message-ID: <20250421122336.2mznwxkbf7i45pzc@simple>
References: <20250418193943.953952-1-nm@ti.com>
 <20250418193943.953952-6-nm@ti.com>
 <cb2e9c5a-e0c3-4078-8a85-f7de24de23cf@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb2e9c5a-e0c3-4078-8a85-f7de24de23cf@ti.com>
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

On 18:45-20250419, Kumar, Udit wrote:
> Hello Nishanth
> 
> On 4/19/2025 1:09 AM, Nishanth Menon wrote:
> > We just have sd/mmc, so set things up for the same
> > 
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> > Changes Since v1:
> > - None
> > 
> > V1: https://lore.kernel.org/r/20250411225717.3117370-6-nm@ti.com
> > 
> >   board/beagle/beagley-ai/beagley-ai.env | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/board/beagle/beagley-ai/beagley-ai.env b/board/beagle/beagley-ai/beagley-ai.env
> > index 16a03acfca3c..26f12c8814cc 100644
> > --- a/board/beagle/beagley-ai/beagley-ai.env
> > +++ b/board/beagle/beagley-ai/beagley-ai.env
> > @@ -1,5 +1,6 @@
> >   #include <env/ti/ti_common.env>
> >   #include <env/ti/mmc.env>
> > +#include <env/ti/k3_dfu.env>
> >   #if CONFIG_CMD_REMOTEPROC
> >   #include <env/ti/k3_rproc.env>
> > @@ -20,5 +21,6 @@ mmcdev=1
> >   bootpart=1:2
> >   bootdir=/boot
> >   rd_spec=-
> > +dfu_alt_info=${dfu_alt_info_mmc}
> 
> IMO  dfu_alt_info_ram could be another valid target for DFU ,
> 
> Other platform, set this dfu_alt_info variable before using,
> 
> Can we consider this as similar to other platforms ?

Thanks for catching it, will drop the default dfu_alt_info and retain
the env header inclusion.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
