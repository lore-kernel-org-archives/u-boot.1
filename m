Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F6CC25B74
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 15:42:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E85788258;
	Thu, 16 May 2024 17:42:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YytVlCnC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CA0E86DBD; Thu, 16 May 2024 17:42:05 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A1B088263
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 17:42:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44GFfxUq067801;
 Thu, 16 May 2024 10:41:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715874119;
 bh=7fOtvmMUr5m+xhq8WVVCoMb1x0YlBEp9QOQxVlVY4uw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=YytVlCnCL4/jNRK1rywcVjXT3GtQ5AblnTbi34R+/6sxI18QmyhhBOw7YTymULJbn
 k07dPmoIFq9aN0lKZeur8wA9konNESQaJs0EX/oQJlENC38ie13FffV23wra4RzHeN
 aafPN1h6Ce+YYQqtIWvrxVSaoTO2YTnzGkL3Oypk=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44GFfxqm054699
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 16 May 2024 10:41:59 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 16
 May 2024 10:41:58 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 16 May 2024 10:41:58 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44GFfwg0115891;
 Thu, 16 May 2024 10:41:58 -0500
Date: Thu, 16 May 2024 10:41:58 -0500
From: Bryan Brattlof <bb@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Nitin Yadav
 <n-yadav@ti.com>, Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v3 2/2] configs: add defconfigs for the am625-lp-sk
Message-ID: <20240516154158.3vg7qdjmfnddrraa@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240429-am62q-wip-v3-0-17dcfdb1075a@ti.com>
 <20240429-am62q-wip-v3-2-17dcfdb1075a@ti.com>
 <20240515182123.GY2568172@bill-the-cat>
 <098126c3-ac13-46b1-8983-dc6bfcd284f6@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <098126c3-ac13-46b1-8983-dc6bfcd284f6@ti.com>
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

On May 15, 2024 thus sayeth Andrew Davis:
> On 5/15/24 1:21 PM, Tom Rini wrote:
> > On Fri, May 03, 2024 at 11:44:29AM -0500, Bryan Brattlof wrote:
> > 
> > > The am62x-lp-sk is a package and reference board spin of the am62x-sk to
> > > showcase the low-power features of the am62x SoC family. Because it so
> > > closely resembles the am62x-sk board, use the preprocessor to inherit
> > > its configuration making the needed changes for this board where
> > > necessary.
> > > 
> > > Reviewed-by: Dhruva Gole <d-gole@ti.com>
> > > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > > ---
> > >   configs/am62x_lp_sk_a53_defconfig | 3 +++
> > >   configs/am62x_lp_sk_r5_defconfig  | 2 ++
> > >   2 files changed, 5 insertions(+)
> > > 
> > > diff --git a/configs/am62x_lp_sk_a53_defconfig b/configs/am62x_lp_sk_a53_defconfig
> > > new file mode 100644
> > > index 0000000000000..904b2142b2f53
> > > --- /dev/null
> > > +++ b/configs/am62x_lp_sk_a53_defconfig
> > > @@ -0,0 +1,3 @@
> > > +#include <configs/am62x_evm_a53_defconfig>
> > > +CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am62-lp-sk"
> > > +CONFIG_OF_UPSTREAM=y
> > 
> > So, there's a problem here. The #include trick for defconfig files isn't
> > working as intended, exactly. The example here doesn't work right.
> > First, it shows up as a variant of "sandbox" (as buildman will show and
> > leads to https://source.denx.de/u-boot/u-boot/-/jobs/835067#L119)
> > 
> > And this becomes clearer if you look at configs/am69_sk_r5_defconfig
> > which has to set some symbols already found in
> > configs/j784s4_evm_r5_defconfig in order to work. This is seemingly very
> > not equivalent to invoking "make foo_defconfig bar.config" to combine
> > things.
> > 
> 
> This is equivalent when running make. The issue is with buildman which
> manually checks the content of the defconfig to find what ARCH it should
> run the defconfig with. buildman doesn't understand the #include yet.
> Until buildman can be fixed, you'll need to do what we did with
> am69_sk_r5_defconfig and redefine the ARCH/SOC/TARGET info in the
> defconfig file so buildman can find it without following the #include.

Ah Okay, I'll take a stab at the buildman fix. Also noticed in the logs 
I didn't add the configs to a MAINTAINERS entry.

~Bryan
