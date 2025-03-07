Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE98C19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 04:55:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 971A2805D7;
	Fri,  7 Mar 2025 05:55:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ioN6JRy9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16602808A2; Fri,  7 Mar 2025 05:55:10 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 397EB8056A
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 05:55:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5274t46d156578
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Mar 2025 22:55:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741323304;
 bh=4kjYFB50MBFs0PLv4zNmpVjkC8qP6GIGFPH3Im12Pnk=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ioN6JRy9z8UnRl1U7wsDJ8ypPaL299Y4FIOu9Ev78fbRzKBht1QcMb1CS7a9xi1XL
 e9wWc0xE7OrZPdWcIrD4+CBKcR5Gq3MYVMRf06vAu+oZZ7fxBZG+Pmz9DqUwCXf3TH
 mSHgloGAp0qIsI7qhofR+WiIReE1kUrEcwjXpX3Q=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5274t4Zu040727
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 6 Mar 2025 22:55:04 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 6
 Mar 2025 22:55:04 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 6 Mar 2025 22:55:04 -0600
Received: from [172.24.227.136] (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5274t1B8130654;
 Thu, 6 Mar 2025 22:55:01 -0600
Message-ID: <67398051-7282-4cfd-a805-45268f41e84c@ti.com>
Date: Fri, 7 Mar 2025 10:25:00 +0530
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
 <dd69f417-c6ef-4595-8d60-56f9dc6e2b8c@ti.com>
 <CAFLszTjS3SoyGzaFsdbjTxP7rUfc71roNzvtgixPaJ6G2YZ7ww@mail.gmail.com>
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <CAFLszTjS3SoyGzaFsdbjTxP7rUfc71roNzvtgixPaJ6G2YZ7ww@mail.gmail.com>
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


On 26/02/25 02:57, Simon Glass wrote:
> Hi Moteen, On Thu, 13 Feb 2025 at 22: 05, Moteen Shah 
> <m-shah@ ti. com> wrote: > > > On 13/02/25 19: 31, Simon Glass wrote: 
> > > Hi Moteen, On Wed, 12 Feb 2025 at 02: 18, Moteen Shah > > <m-shah@ 
> ti. com> wrote: >
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK!tDdkczlA_gRXoUoEULhq8lPl3ziRhLj9IlA3ZXDoziTij0dPBpn6-DgWRD6rC1BVPnBWST9bilaw10uU17sjumdmw40nkGdzZUT48cV7qkEDIlAys_tcmpU$> 
>
> ZjQcmQRYFpfptBannerEnd
> Hi Moteen,
>
> On Thu, 13 Feb 2025 at 22:05, Moteen Shah <m-shah@ti.com> wrote:
> >
> >
> > On 13/02/25 19:31, Simon Glass wrote:
> > > Hi Moteen, On Wed, 12 Feb 2025 at 02: 18, Moteen Shah
> > > <m-shah@ ti. com> wrote: > > Add a new config when set will traverse
> > > through all the subnodes of > a given node scanning for bootph-all
> > > property and propagate it to > all of
> > > ZjQcmQRYFpfptBannerStart
> > > This message was sent from outside of Texas Instruments.
> > > Do not click links or open attachments unless you recognize the source
> > > of this email and know the content is safe.
> > > Report Suspicious
> > > <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK!tDdkczlA_gRXoUgIvDspkOY_N58UTgTbK8UGS8zfYNsuu6kFHonhYC9p6QDyxO6fEM-jwDoJbz7g9IYZuow6CShwWbGJRkE39jUS3OLaz9G1-q9eGLvRc6M$>
> > >
> > > ZjQcmQRYFpfptBannerEnd
> > > Hi Moteen,
> > >
> > > On Wed, 12 Feb 2025 at 02:18, Moteen Shah <m-shah@ti.com> wrote:
> > > >
> > > > Add a new config when set will traverse through all the subnodes of
> > > > a given node scanning for bootph-all property and propagate it to
> > > > all of its parent node up the hierarchy.
> > > >
> > > > Signed-off-by: Moteen Shah <m-shah@ti.com>
> > > > ---
> > > >  arch/arm/Kconfig | 11 +++++++++++
> > > >  1 file changed, 11 insertions(+)
> > > >
> > > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > > index 314916527c9..51fc952b0db 100644
> > > > --- a/arch/arm/Kconfig
> > > > +++ b/arch/arm/Kconfig
> > > > @@ -805,6 +805,7 @@ config ARCH_K3
> > > >         select FIT
> > > >         select REGEX
> > > >         select FIT_SIGNATURE if ARM64
> > > > +       imply BIND_FROM_CHILD_BOOTPH
> > > >         imply TI_SECURE_DEVICE
> > > >
> > > >  config ARCH_OMAP2PLUS
> > > > @@ -2232,6 +2233,16 @@ config SYS_KWD_CONFIG
> > > >           Path within the source directory to the kwbimage.cfg file to use
> > > >           when packaging the U-Boot image for use.
> > > >
> > > > +
> > > > +config BIND_FROM_CHILD_BOOTPH
> > >
> > > How about DM_F_STRICT_BOOTPH ?  or DM_F_CHILD_BOOTPH ?
> >
> > Yes, this should be more descriptive, will include this in v2.
> >
> > >
> > > It indicates that it relates to driver model before relocation.
> > >
> > > This behaviour is actually required by the schema. I agree it should
> > > be optional, but only due to its performance issues.
> > >
> > > A Binman solution would not have any performance issues.
> >
> > Will explore on this more, if you have some more pointers on this,
> > then do let me know.
>
> As you requested on the call today:
>
> PrepareImagesAndDtbs() fiddles with the dtb so you can add some code there.
>
> My suggestion is to insert something after this chunk:
>
>      # Get the device tree ready by compiling it and copying the compiled
>      # output into a file in our output directly. Then scan it for use
>      # in binman.
>      dtb_fname = fdt_util.EnsureCompiled(dtb_fname)
>      fname = tools.get_output_filename('u-boot.dtb.out')
>
> here you can read in the file and modify it, e.g.:
>
> dtb = fdt.FdtScan(dtb_fname)
> add_bootph_nodes(dtb)
> dtb.Sync(True)
> tools.write_file(fname, dtb.GetContents())
>
>      tools.write_file(fname, tools.read_file(dtb_fname))   # delete this line
>      dtb = fdt.FdtScan(fname)
>
> It might need some tweaking. It will need some sort of test, see
> ftest.py for that. As an example, testCompressSectionSize() reads back
> the dtb to check it., so you can follow that You need to create a .dts
> file in tools/binman/test, containing nodes other than 'binman'.


Thanks for the pointers Simon. I'll start with the implementation soon 
after checking the time delta
we get with this patch but with direct binding rather than propagating 
bootph-* properties.


> >
> >
> > Regards,
> > Moteen
> >
> > >
> > > > +       bool "Bind drivers from bootph* in subnode"
> > > > +       depends on ARCH_K3
> > > > +       help
> > > > +        This config must be set to bind drivers in pre reloc stage whose
> > > > +        compatible parent nodes are implicitly declared to be bound to
> > > > +        their respective drivers by having bootph* property in one of
> > > > +        their subnodes.
> > > > +
> > > >  source "arch/arm/mach-apple/Kconfig"
> > > >
> > > >  source "arch/arm/mach-aspeed/Kconfig"
> > > > --
> > > > 2.34.1
> > > >
> > >
> > > Regards,
> > > Simon
>
> Regards,
> Simon


Regards,
Moteen

