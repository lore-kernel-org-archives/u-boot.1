Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50C2C02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 05:05:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB60C80756;
	Fri, 14 Feb 2025 06:05:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hltjqeIt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5516A80C77; Fri, 14 Feb 2025 06:05:12 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 840CF806FE
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 06:05:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51E554Fi4149015
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Feb 2025 23:05:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739509504;
 bh=F/8EoEnJsyYhb/Ivs7t2QWssmMn3dqwoQIkLnMk6lbM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=hltjqeItaS+OniwPLuyfoYYw+8r8TD7br8of+SDkPlpX7WGlwPU12qAFAxsXR2pyi
 E4eVPAbasGzfoPGW7qNRy9k64UPpF5Pe0S7pzVRlEQKa8NzDJdhZqXYVW0FezeUwIE
 vn3im2bRQ18C1s1mAbh1NeplmO1aHQYhVqeA283s=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51E554UU018569
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 13 Feb 2025 23:05:04 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Feb 2025 23:05:04 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Feb 2025 23:05:04 -0600
Received: from [172.24.227.18] (moteen-ubuntu-desk.dhcp.ti.com [172.24.227.18])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51E551du009110;
 Thu, 13 Feb 2025 23:05:02 -0600
Message-ID: <dd69f417-c6ef-4595-8d60-56f9dc6e2b8c@ti.com>
Date: Fri, 14 Feb 2025 10:35:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [RFC PATCH 1/2 v1] arch: arm: Kconfig: Add config
 to use subnode's bootph property for binding drivers
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <m-chawdhry@ti.com>,
 <n-francis@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>, <a-chavda@ti.com>
References: <20250212091820.213895-1-m-shah@ti.com>
 <20250212091820.213895-2-m-shah@ti.com>
 <CAFLszTjCT7ubR=k0Gd5AAt+m9cH7qgQzT1S8z5LCVHSrgAnCow@mail.gmail.com>
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <CAFLszTjCT7ubR=k0Gd5AAt+m9cH7qgQzT1S8z5LCVHSrgAnCow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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


On 13/02/25 19:31, Simon Glass wrote:
> Hi Moteen, On Wed, 12 Feb 2025 at 02: 18, Moteen Shah 
> <m-shah@ ti. com> wrote: > > Add a new config when set will traverse 
> through all the subnodes of > a given node scanning for bootph-all 
> property and propagate it to > all of
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK!tDdkczlA_gRXoUgIvDspkOY_N58UTgTbK8UGS8zfYNsuu6kFHonhYC9p6QDyxO6fEM-jwDoJbz7g9IYZuow6CShwWbGJRkE39jUS3OLaz9G1-q9eGLvRc6M$> 
>
> ZjQcmQRYFpfptBannerEnd
> Hi Moteen,
>
> On Wed, 12 Feb 2025 at 02:18, Moteen Shah <m-shah@ti.com> wrote:
> >
> > Add a new config when set will traverse through all the subnodes of
> > a given node scanning for bootph-all property and propagate it to
> > all of its parent node up the hierarchy.
> >
> > Signed-off-by: Moteen Shah <m-shah@ti.com>
> > ---
> >  arch/arm/Kconfig | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 314916527c9..51fc952b0db 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -805,6 +805,7 @@ config ARCH_K3
> >         select FIT
> >         select REGEX
> >         select FIT_SIGNATURE if ARM64
> > +       imply BIND_FROM_CHILD_BOOTPH
> >         imply TI_SECURE_DEVICE
> >
> >  config ARCH_OMAP2PLUS
> > @@ -2232,6 +2233,16 @@ config SYS_KWD_CONFIG
> >           Path within the source directory to the kwbimage.cfg file to use
> >           when packaging the U-Boot image for use.
> >
> > +
> > +config BIND_FROM_CHILD_BOOTPH
>
> How about DM_F_STRICT_BOOTPH ?  or DM_F_CHILD_BOOTPH ?

Yes, this should be more descriptive, will include this in v2.

>
> It indicates that it relates to driver model before relocation.
>
> This behaviour is actually required by the schema. I agree it should
> be optional, but only due to its performance issues.
>
> A Binman solution would not have any performance issues.

Will explore on this more, if you have some more pointers on this,
then do let me know.


Regards,
Moteen

>
> > +       bool "Bind drivers from bootph* in subnode"
> > +       depends on ARCH_K3
> > +       help
> > +        This config must be set to bind drivers in pre reloc stage whose
> > +        compatible parent nodes are implicitly declared to be bound to
> > +        their respective drivers by having bootph* property in one of
> > +        their subnodes.
> > +
> >  source "arch/arm/mach-apple/Kconfig"
> >
> >  source "arch/arm/mach-aspeed/Kconfig"
> > --
> > 2.34.1
> >
>
> Regards,
> Simon
