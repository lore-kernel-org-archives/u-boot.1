Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77280C5478C
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 18:48:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA28E88005;
	Tue, 27 Feb 2024 19:47:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pK+jLUzH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 895B587FFB; Tue, 27 Feb 2024 19:40:21 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3D8C87FFF
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 19:40:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41RIeEhm003148;
 Tue, 27 Feb 2024 12:40:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709059214;
 bh=l3aYv1IppZYUcNYgmSHx32yr4dlJUhCxE0Y0HKamV8M=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=pK+jLUzHUlyxpt9lq08ElR1PUD/lPz0IKXTYo3hNa4zi+LNBpWCOCnGZCJ8Q4Jk4L
 PPxUXztSauiGdI5ttef7+p1xiUv0Osuy1n7ghtXXnN8E8STh/rCrGO7qLe0PkeocMn
 vrNjby6xar6AjNf4YBFFrNPB+/m6oo7DIx63gSfM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41RIeDGv041149
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 27 Feb 2024 12:40:14 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Feb 2024 12:40:13 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Feb 2024 12:40:13 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41RIeDWe070781;
 Tue, 27 Feb 2024 12:40:13 -0600
From: Jon Humphreys <j-humphreys@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <vigneshr@ti.com>, <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 2/2] arm: dts: k3-am642-evm/sk: Enable OSPI support
 in SPL
In-Reply-To: <20240227181656.GL3040305@bill-the-cat>
References: <20240224001702.2283727-1-j-humphreys@ti.com>
 <20240224001702.2283727-3-j-humphreys@ti.com>
 <20240224135959.GC3040305@bill-the-cat>
 <86o7c5rck3.fsf@udb0321960.dhcp.ti.com>
 <20240227181656.GL3040305@bill-the-cat>
Date: Tue, 27 Feb 2024 12:40:13 -0600
Message-ID: <86frxdrbsi.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Tue, 27 Feb 2024 19:47:50 +0100
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

Tom Rini <trini@konsulko.com> writes:

> On Sat, Feb 24, 2024 at 11:34:36AM -0600, Jon Humphreys wrote:
>> Tom Rini <trini@konsulko.com> writes:
>> 
>> > On Fri, Feb 23, 2024 at 06:17:02PM -0600, Jonathan Humphreys wrote:
>> >> Add bootph DT tags to enable OSPI in SPL.
>> >> Set OSPI regs for R5 SPL to address OSPI's boot region.
>> >> 
>> >> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
>> >> ---
>> >>  arch/arm/dts/k3-am642-evm-u-boot.dtsi | 16 ++++++++++++++++
>> >>  arch/arm/dts/k3-am642-r5-evm.dts      |  5 +++++
>> >>  arch/arm/dts/k3-am642-r5-sk.dts       |  5 +++++
>> >>  arch/arm/dts/k3-am642-sk-u-boot.dtsi  | 16 ++++++++++++++++
>> >>  4 files changed, 42 insertions(+)
>> >> 
>> >> diff --git a/arch/arm/dts/k3-am642-evm-u-boot.dtsi b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
>> >> index b843078243..60b219c0be 100644
>> >> --- a/arch/arm/dts/k3-am642-evm-u-boot.dtsi
>> >> +++ b/arch/arm/dts/k3-am642-evm-u-boot.dtsi
>> >> @@ -182,3 +182,19 @@
>> >>  &cpsw_port2 {
>> >>  	status = "disabled";
>> >>  };
>> >> +
>> >> +&ospi0_pins_default {
>> >> +	bootph-all;
>> >> +};
>> >> +
>> >> +&fss {
>> >> +	bootph-all;
>> >> +};
>> >> +
>> >> +&ospi0 {
>> >> +	bootph-all;
>> >> +
>> >> +	flash@0 {
>> >> +		bootph-all;
>> >> +	};
>> >> +};
>> >
>> > So this gets back to what I was asking in the first series, is this
>> > needed in SPL or full U-Boot as well? The bootph-* properties are
>> > supposed to be transitive, but originally the tooling didn't handle this
>> > and now the tooling handles SPL but not full U-Boot. Which also brings
>> > back the is this _needed_ question and is bootph-all right, rather than
>> > just the big hammer?
>> >
>> By "this", are you referring to the original phypattern partition nodes,
>> or the ospi0 node itself?  The partition nodes are not needed at all, so
>> removed.  The ospi node is needed in both SPL and U-Boot.  In that case,
>> using the bootph-all tag is the proper way, correct?
>> 
>> What do you mean by the 'big hammer'?
>> 
>> Please advise and thanks.
>
> So, part of the answer is that the documentation isn't as clear and well
> formatted as I'd like (aside, include/dm/ofnode.h::ofnode_pre_reloc
> comment should be reworded to render better). First, I want to point to
> the schema itself:
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/bootph.yaml
> and then next:
> https://docs.u-boot.org/en/latest/develop/driver-model/design.html#pre-relocation-support
>
> And in this case, the "pre" options are a bit less clear as TI platforms
> don't do the TPL->SPL->Full U-Boot dance that others like say Rockchip
> do but instead the Cortex-R/Cortex-A dance for the K3 architecture.
>
> Which gets back to what I was trying to ask. What, functionally,
> requires that property to be present? And then, for the cortex-a
> platforms these should be in the upstream dtb and I forget if you said
> that's in progress for these platforms or not.

Without those properties, the on-board OSPI flash is not available to
u-boot.

There is a separate action to move the bootph properities (not just the
above) to the upstream DT.

>
> -- 
> Tom
