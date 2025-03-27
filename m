Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9142AC3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 06:59:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5D1B8070C;
	Thu, 27 Mar 2025 07:58:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MCUVEhjC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97C84807D7; Thu, 27 Mar 2025 07:58:58 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8360806FC
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 07:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52R6wrHs1775623
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Mar 2025 01:58:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1743058733;
 bh=eb93PDNXb6ExeYd7k5lZwf6oO+SwpM2Ty+X6G299EHs=;
 h=Date:Subject:From:To:CC:References:In-Reply-To;
 b=MCUVEhjCI6v4U/3ATL9GPgmKWsvuzacgMlcWMZKt7QszzHrU+7Z9Y6addG+egR/da
 wh2PU39q9XFfT7GwYvsP/W9mkCyEPa2QKa4GkLXeH3T0iLZBdoxkafIrLv9hwYY/uX
 n+NgArugRDwGw5P6KiyARFOl/JE+oYag20wRgQGw=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52R6wr5e001052
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 27 Mar 2025 01:58:53 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Mar 2025 01:58:52 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Mar 2025 01:58:52 -0500
Received: from [172.24.227.136] (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.136])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52R6wns1083154;
 Thu, 27 Mar 2025 01:58:50 -0500
Message-ID: <de6090ed-2a2d-43e1-8a87-0da736bb2506@ti.com>
Date: Thu, 27 Mar 2025 12:28:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [RFC PATCH 1/2 v1] arch: arm: Kconfig: Add config
 to use subnode's bootph property for binding drivers
From: Moteen Shah <m-shah@ti.com>
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <m-chawdhry@ti.com>,
 <n-francis@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>, <a-chavda@ti.com>
References: <20250212091820.213895-1-m-shah@ti.com>
 <20250212091820.213895-2-m-shah@ti.com>
 <CAFLszTjCT7ubR=k0Gd5AAt+m9cH7qgQzT1S8z5LCVHSrgAnCow@mail.gmail.com>
 <dd69f417-c6ef-4595-8d60-56f9dc6e2b8c@ti.com>
 <CAFLszTjS3SoyGzaFsdbjTxP7rUfc71roNzvtgixPaJ6G2YZ7ww@mail.gmail.com>
 <67398051-7282-4cfd-a805-45268f41e84c@ti.com>
Content-Language: en-US
In-Reply-To: <67398051-7282-4cfd-a805-45268f41e84c@ti.com>
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

Hello Simon,

On 07/03/25 10:25, Moteen Shah wrote:
>
> On 26/02/25 02:57, Simon Glass wrote:
>> Hi Moteen, On Thu, 13 Feb 2025 at 22: 05, Moteen Shah 
>> <m-shah@ ti. com> wrote: > > > On 13/02/25 19: 31, Simon Glass wrote: 
>> > > Hi Moteen, On Wed, 12 Feb 2025 at 02: 18, Moteen Shah > > 
>> <m-shah@ ti. com> wrote: >
>> ZjQcmQRYFpfptBannerStart
>> This message was sent from outside of Texas Instruments.
>> Do not click links or open attachments unless you recognize the 
>> source of this email and know the content is safe.
>> Report Suspicious
>> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK!tDdkczlA_gRXoUoEULhq8lPl3ziRhLj9IlA3ZXDoziTij0dPBpn6-DgWRD6rC1BVPnBWST9bilaw10uU17sjumdmw40nkGdzZUT48cV7qkEDIlAys_tcmpU$> 
>>
>> ZjQcmQRYFpfptBannerEnd
>> Hi Moteen,
>>
>> On Thu, 13 Feb 2025 at 22:05, Moteen Shah <m-shah@ti.com> wrote:
>> >
>> >
>> > On 13/02/25 19:31, Simon Glass wrote:
>> > > Hi Moteen, On Wed, 12 Feb 2025 at 02: 18, Moteen Shah
>> > > <m-shah@ ti. com> wrote: > > Add a new config when set will traverse
>> > > through all the subnodes of > a given node scanning for bootph-all
>> > > property and propagate it to > all of
>> > > ZjQcmQRYFpfptBannerStart
>> > > This message was sent from outside of Texas Instruments.
>> > > Do not click links or open attachments unless you recognize the 
>> source
>> > > of this email and know the content is safe.
>> > > Report Suspicious
>> > > 
>> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK!tDdkczlA_gRXoUgIvDspkOY_N58UTgTbK8UGS8zfYNsuu6kFHonhYC9p6QDyxO6fEM-jwDoJbz7g9IYZuow6CShwWbGJRkE39jUS3OLaz9G1-q9eGLvRc6M$>
>> > >
>> > > ZjQcmQRYFpfptBannerEnd
>> > > Hi Moteen,
>> > >
>> > > On Wed, 12 Feb 2025 at 02:18, Moteen Shah <m-shah@ti.com> wrote:
>> > > >
>> > > > Add a new config when set will traverse through all the 
>> subnodes of
>> > > > a given node scanning for bootph-all property and propagate it to
>> > > > all of its parent node up the hierarchy.
>> > > >
>> > > > Signed-off-by: Moteen Shah <m-shah@ti.com>
>> > > > ---
>> > > >  arch/arm/Kconfig | 11 +++++++++++
>> > > >  1 file changed, 11 insertions(+)
>> > > >
>> > > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> > > > index 314916527c9..51fc952b0db 100644
>> > > > --- a/arch/arm/Kconfig
>> > > > +++ b/arch/arm/Kconfig
>> > > > @@ -805,6 +805,7 @@ config ARCH_K3
>> > > >         select FIT
>> > > >         select REGEX
>> > > >         select FIT_SIGNATURE if ARM64
>> > > > +       imply BIND_FROM_CHILD_BOOTPH
>> > > >         imply TI_SECURE_DEVICE
>> > > >
>> > > >  config ARCH_OMAP2PLUS
>> > > > @@ -2232,6 +2233,16 @@ config SYS_KWD_CONFIG
>> > > >           Path within the source directory to the kwbimage.cfg 
>> file to use
>> > > >           when packaging the U-Boot image for use.
>> > > >
>> > > > +
>> > > > +config BIND_FROM_CHILD_BOOTPH
>> > >
>> > > How about DM_F_STRICT_BOOTPH ?  or DM_F_CHILD_BOOTPH ?
>> >
>> > Yes, this should be more descriptive, will include this in v2.
>> >
>> > >
>> > > It indicates that it relates to driver model before relocation.
>> > >
>> > > This behaviour is actually required by the schema. I agree it should
>> > > be optional, but only due to its performance issues.
>> > >
>> > > A Binman solution would not have any performance issues.
>> >
>> > Will explore on this more, if you have some more pointers on this,
>> > then do let me know.
>>
>> As you requested on the call today:
>>
>> PrepareImagesAndDtbs() fiddles with the dtb so you can add some code 
>> there.
>>
>> My suggestion is to insert something after this chunk:
>>
>>      # Get the device tree ready by compiling it and copying the 
>> compiled
>>      # output into a file in our output directly. Then scan it for use
>>      # in binman.
>>      dtb_fname = fdt_util.EnsureCompiled(dtb_fname)
>>      fname = tools.get_output_filename('u-boot.dtb.out')
>>
>> here you can read in the file and modify it, e.g.:
>>
>> dtb = fdt.FdtScan(dtb_fname)
>> add_bootph_nodes(dtb)
>> dtb.Sync(True)
>> tools.write_file(fname, dtb.GetContents())
>>
>>      tools.write_file(fname, tools.read_file(dtb_fname))   # delete 
>> this line
>>      dtb = fdt.FdtScan(fname)
>>
>> It might need some tweaking. It will need some sort of test, see
>> ftest.py for that. As an example, testCompressSectionSize() reads back
>> the dtb to check it., so you can follow that You need to create a .dts
>> file in tools/binman/test, containing nodes other than 'binman'.
>
>
> Thanks for the pointers Simon. I'll start with the implementation soon 
> after checking the time delta
> we get with this patch but with direct binding rather than propagating 
> bootph-* properties.
>

I checked the time delta with the above mentioned approach, here are the 
results:

Board         Baseline   Previous delay  New delay
J7200-evm       2.2s       ~100 ms         ~60ms
J784s4-evm     2.7s        ~350 ms     300ms-350ms

The time delta is still significant, a binman solution should be the 
right approach to this, a binman based approach should be the right step 
I think. Will send a v2 based on it.


>
>> >
>> >
>> > Regards,
>> > Moteen
>> >
>> > >
>> > > > +       bool "Bind drivers from bootph* in subnode"
>> > > > +       depends on ARCH_K3
>> > > > +       help
>> > > > +        This config must be set to bind drivers in pre reloc 
>> stage whose
>> > > > +        compatible parent nodes are implicitly declared to be 
>> bound to
>> > > > +        their respective drivers by having bootph* property in 
>> one of
>> > > > +        their subnodes.
>> > > > +
>> > > >  source "arch/arm/mach-apple/Kconfig"
>> > > >
>> > > >  source "arch/arm/mach-aspeed/Kconfig"
>> > > > --
>> > > > 2.34.1
>> > > >
>> > >
>> > > Regards,
>> > > Simon
>>
>> Regards,
>> Simon
>
>
> Regards,
> Moteen


Regards,
Moteen

