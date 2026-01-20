Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF5CD2ED0F
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 12:07:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDF0E83A8F;
	Tue, 20 Jan 2026 13:07:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HAFelywd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8A4583A91; Tue, 20 Jan 2026 13:07:45 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C255283A8D
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 13:07:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 93A706012A;
 Tue, 20 Jan 2026 12:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055ACC16AAE;
 Tue, 20 Jan 2026 12:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768910861;
 bh=YrkURLYRGh72OQblPbiYaCHMzsmJ3QJk0/EERlstCWQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HAFelywd8th6AjyBqA+rcx8U25W69QzKL/QeKtr7hrtGwqsj4NdBs5CoxluIhaPi+
 GxVfq95QGqJQM19K6AOshbhvYtB+d0wRW+47OiAyKe2y6LFf0khcPIt/RsSjSZpMzQ
 zpjQsQP06x+T3Cm4H2kGsVg+ZdSJBbxXEwFqAOonDaqlWjEzweUy54x47W44/wad98
 JJo2sRvgoRgtc+43bACP7XCQx+ZnPl8gRi82WTRp5SgPhqamUuf/AUz2UwwDBH9tUn
 cK1PP896wjorHAnA+0/U8Ue9y4rURsO5Jh/dftVVAmFCLaubT1u9dvBqdm9JNY6WRO
 WDoeZfPvlMjPw==
Date: Tue, 20 Jan 2026 17:37:34 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: trini@konsulko.com, aswin.murugan@oss.qualcomm.com, lukma@denx.de,
 seanga2@gmail.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, alexeymin@postmarketos.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v1 1/3] arm: dts: qcs615-ride: Remove unsupported USB
 clock reference
Message-ID: <aW9wBo-noyn8YefX@sumit-xelite>
References: <20251114063804.3835132-1-balaji.selvanathan@oss.qualcomm.com>
 <20251114063804.3835132-2-balaji.selvanathan@oss.qualcomm.com>
 <aU5h8TrvG7GALEMc@sumit-xelite>
 <55809fdb-1da8-4e4a-810a-62d034d1e745@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55809fdb-1da8-4e4a-810a-62d034d1e745@oss.qualcomm.com>
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

On Tue, Jan 20, 2026 at 10:00:58AM +0530, Balaji Selvanathan wrote:
> Hi Sumit,
> 
> Thanks for the feedback. Please find reply below.
> 
> On 12/26/2025 3:52 PM, Sumit Garg wrote:
> > On Fri, Nov 14, 2025 at 12:08:02PM +0530, Balaji Selvanathan wrote:
> > > Remove GCC_USB3_PRIM_CLKREF_CLK from the USB controller node as it is
> > > not implemented in the U-Boot clock driver. Keep only the supported
> > > clocks to avoid clock warnings during boot.
> > Rather than overriding DT, why can't this be implmented in U-Boot? And
> > how why it isn't an essential clock for U-Boot operation?
> > 
> > -Sumit
> 
> GCC_USB3_PRIM_CLKREF_CLK seems to be a reference clock that is enabled by
> earlier boot stages before U-Boot starts: The clock is already ON when
> U-Boot starts - verified during boot. This is a reference clock with
> hardware voting mechanism, not typically controlled by software.
> 
> Without this override, we get "Clock 152 not found" warning message (as it
> is not there in the QCS615 clock driver.

Why not implement this clock handling in the U-Boot as it is being
handled in the kernel (see: drivers/clk/qcom/gcc-qcs615.c +2886)? You
can also seek a reference from sdm845, qcm2290 clk drivers in U-Boot
too.

Using DT overrides for missing simple functionality in U-Boot isn't
acceptable since we want to avoid as much overrides as possible.

-Sumit

> 
> Regards,
> 
> Balaji
> 
> 
> > 
> > > Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> > > ---
> > >   arch/arm/dts/qcs615-ride-u-boot.dtsi | 14 ++++++++++++++
> > >   1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/arch/arm/dts/qcs615-ride-u-boot.dtsi b/arch/arm/dts/qcs615-ride-u-boot.dtsi
> > > index 68fffc70fcb..d8af124cc27 100644
> > > --- a/arch/arm/dts/qcs615-ride-u-boot.dtsi
> > > +++ b/arch/arm/dts/qcs615-ride-u-boot.dtsi
> > > @@ -11,4 +11,18 @@
> > >   		      <0x0 0xc0000000 0x0 0xc0000000>,
> > >   		      <0x1 0x80000000 0x1 0x00000000>;
> > >   	};
> > > +	soc@0 {
> > > +		/* Remove GCC_USB3_PRIM_CLKREF_CLK from usb_1 node to avoid U-Boot clock warnings */
> > > +		usb_1: usb@a6f8800 {
> > > +			/delete-property/ clocks;
> > > +			/delete-property/ clock-names;
> > > +			/* Keep only the clocks that are implemented in U-Boot clock driver */
> > > +			clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
> > > +				 <&gcc GCC_USB30_PRIM_MASTER_CLK>,
> > > +				 <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
> > > +				 <&gcc GCC_USB30_PRIM_SLEEP_CLK>,
> > > +				 <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>;
> > > +			clock-names = "cfg_noc", "core", "iface", "sleep", "mock_utmi";
> > > +		};
> > > +	};
> > >   };
> > > -- 
> > > 2.34.1
> > > 
