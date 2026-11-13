Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE03606A334
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 19:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=u6uL8x/R;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=WOjHogTI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 29F4981775;
	Fri, 13 Nov 2026 19:38:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z__vUGic3DPN; Fri, 13 Nov 2026 19:38:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0FD7381395
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794598698;
	b=YISGSgpcX7Dx+l2ALBIsuCFaxZiWcBpwpI3xEAfJ3BS2Y9Ld4OjvuHvVTMfTHTUOvLjK
	 L6D9d8aYupklekITp16wtuXbeoEobawefyTtd2FJTwQhLwTTj/Ud5Tviap8P6URPdVJrW
	 N6shHMeCdXEKuDJ1/tquT0RZzth3kYgTsNSqArn/eHlr1PlULmdOX/t9wF3Al1u6cUE7N
	 6zvwpPvQBmuuWTgFYCn6N6ZDEBdx6aps4nhoxotcO1UhQWVo4iiIetknz+baDh4GEARwZ
	 fz8HbVyFv1XMKnhj+m9JH/yfCuDptZ+LnDM9vSOUOtAmDPW1kDaTAKnC65lseUqqPIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794598698;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=KwBv40SiYhj/7hXcbceFjYYU+N39L2PjqWtJCeQiQ0o=;
	b=LiNv4rjwyJPOYiONHBdnIHvlXK2vYGI1EeqXKIKVDxi5sTSmytHoX+L72iHcdL9dr89m
	 2Wa3ACEVL1Zz+HBNPJOUVQkyKm5uYVrYLlE/ETDjRIgucZnk9c8Cru8VjqLLIBAisCg5J
	 Twq9OwHEsSeuz0awlfxPxsX6Picc47VAgo9BPNTbZAGCeuk+IDAVELp3vSNzxmx1uNjnM
	 v2GKAdGW97b42HFJfh0zrIK7pdH+df9I1YqyLMu4Hr8TcABhLvY6/lHKv7EUvHPuz+lJ3
	 QFx+kIhhF5E9874h0EHPj2bjMtdLgh1SP9JzN9Km5mYKcGYr+ne9vGHxu5+Ef8n/luQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794598698;
	bh=KwBv40SiYhj/7hXcbceFjYYU+N39L2PjqWtJCeQiQ0o=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u6uL8x/RqxGVxQ2mcz3wDDnCkgjnWYMq8/BDId05GzLs9BJKlqPA2rYB6AhQYHJAS
	 TonKxWAkv9NGY316JHJLaPmz1ZSWFn8WN+YY9pudmtl5Ize5pgQh4Z4uboCBJfyY6E
	 A7pNWFlBg9YfP6KTnxLd3Yy39T40ePIryhIjeIswychKr2ub4JABtX4yqGlq1BGz5G
	 ZWD0u/pGSPpb0ea26fBTXVlGvcILD9rNLDabknRzIykmqww9HiJOtAi77fLKEI+cB8
	 dRu39/Q1isXi8E3Fkv3Gx8cDcfYSvcsBtw8CLRYtjM8sA2ogqR9Tbg3o2hkk2bmwyv
	 HMlkmnJ9ofFcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FD7381395;
	Fri, 13 Nov 2026 19:38:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E2E1B286
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 19:38:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D48564022B
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 19:38:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RtWGvl6qyX6U for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 19:38:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B54C5400AE
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=68.232.154.123
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.154.123;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=7708869e7=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=WOjHogTI
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B54C5400AE
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 19:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1794598703; x=1826134703;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=dVKEqWXpMVIUmNdTv4/osfmB/Nm5Z5c/aTtLztmZYgg=;
 b=WOjHogTIdB8f8la8t/sSH2PiXAW/uV1y2wLWVY7+3PU/q0A+I5/k+qjm
 oGRIXnzyOuANGlNxGYjLc8FZfZuMqMwZ0rhCoInDQkDHC//R+FZtlIR8Y
 G2hnerbqbPUIcLA2AlFn6saDfSsrOEq00trUlqjhCZ0mk+R/sG2g59hml
 DxVoz9ME0lIiR6yA9m87uIQV/+zCuTRfU5P8IeG3Q1V5OxsfDVv1fAyrZ
 Nd3L2Wkuhm+IgPJfgVRPZiQyrG4biNp6nuSYs3DHAZOor1tveroiAzden
 Ra7TSpnRe/jznNB6bOi74ogh5f4tFJ/AtPa2LF2HRcpiaqc8lgLauwjHY Q==;
X-CSE-ConnectionGUID: NKq/0o7RQse/XOzZtCn1kg==
X-CSE-MsgGUID: +FYS5g52R9CQsr5f82kZPg==
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; d="scan'208";a="233536114"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 13 Nov 2026 12:38:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 13 Nov 2026 12:38:12 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Fri, 13 Nov 2026 12:38:09 -0700
Date: Fri, 13 Nov 2026 14:38:07 -0500
From: Charles Perry <charles.perry@microchip.com>
To: Leo Liang <leo.liang@sifive.com>
CC: Charles Perry <charles.perry@microchip.com>,
 <u-boot@lists.u-boot-project.org>, Yao Zi <me@ziyao.cc>, Rahul Pathak
 <rahul@summations.net>, Anup Patel <anup@brainfault.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Romain Caritey
 <romain.caritey@microchip.com>, Mame Maria Mbaye
 <MameMaria.Mbaye@microchip.com>, Tom Rini <trini@konsulko.com>, Rick Chen
 <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, Michal Simek
 <michal.simek@amd.com>, Conor Dooley <conor@kernel.org>, Peng Fan
 <peng.fan@oss.nxp.com>, Subrahmanya Lingappa
 <subrahmanya.lingappa@oss.qualcomm.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>
Subject: Re: [PATCH v4 4/8] drivers: clk: add support for RPMI clocks
Message-ID: <avdnH2BRZwT9BAmO@MON-LT-C78453.mchp-main.com>
References: <20261014-rpmi_v4-v4-0-d53d34a49780@microchip.com>
 <20261014-rpmi_v4-v4-4-d53d34a49780@microchip.com>
 <auioPabD3tEPCMQV@lliang-1876.localdomain>
 <au4CuFTPqdet6Vir@MON-LT-C78453.mchp-main.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <au4CuFTPqdet6Vir@MON-LT-C78453.mchp-main.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 11:39:20AM -0500, Charles Perry wrote:
> On Mon, Nov 02, 2026 at 11:11:57PM +0800, Leo Liang wrote:
> > On Wed, Oct 14, 2026 at 10:17:08AM -0400, Charles Perry wrote:
> > > The RISC-V Platform Management Interface (RPMI) defines a service group
> > > for control and monitoring of clocks [1]. This can be exposed as a
> > > UCLASS_CLK driver.
> > > 
> > > [1]: https://github.com/riscv-non-isa/riscv-rpmi (chapter 4.8)
> > > 
> > > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> > > ---
> > > Changes in v4: None
> > > Changes in v3: None
> > > 
> > > Changes in v2: (from Yao Zi review)
> > >  - Reorder headers
> > >  - Don't null check pointers before free()
> > >  - Remove transition_latency from struct rpmi_clk_def as its unused
> > >  - Simplify last return path of _rpmi_clk_enable_disable()
> > >  - Move the call to _rpmi_clk_get_rate() from _rpmi_clk_set_rate() to
> > >    rpmi_clk_set_rate()
> > > ---
> > >  MAINTAINERS            |   1 +
> > >  drivers/clk/Kconfig    |   7 +
> > >  drivers/clk/Makefile   |   1 +
> > >  drivers/clk/clk_rpmi.c | 344 +++++++++++++++++++++++++++++++++++++++++++++++++
> > >  include/rpmi_proto.h   |  39 ++++++
> > >  5 files changed, 392 insertions(+)
> > > 
> > > ...
> > >
> > > +config CLK_RPMI
> > > +	bool "Enable RPMI clock driver"
> > > +	depends on CLK && RPMI_FIRMWARE
> > > +	help
> > > +	  Enable this option if you want to support clock devices exposed
> > > +	  by RISC-V Platform Management Interface (RPMI).
> > > +
> > >  config SANDBOX_CLK_CCF
> > >  	bool "Sandbox Common Clock Framework [CCF] support"
> > >  	depends on SANDBOX
> > > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> > > index 4b241a9240ac..9e19e6f6d845 100644
> > > --- a/drivers/clk/Makefile
> > > +++ b/drivers/clk/Makefile
> > > @@ -46,6 +46,7 @@ obj-$(CONFIG_CLK_OWL) += owl/
> > >  obj-$(CONFIG_CLK_QCOM) += qcom/
> > >  obj-$(CONFIG_CLK_RENESAS) += renesas/
> > >  obj-$(CONFIG_$(PHASE_)CLK_RS9_PCIE) += clk-renesas-pcie.o
> > > +obj-$(CONFIG_CLK_RPMI) += clk_rpmi.o
> > 
> > Should we add $(PHASE_) as well, otherwise, the platform that uses
> > SPL and CLK_RPMI could fail to link with the rpmi_uclass.c API.

My last reply wasn't too helpful. I just threw another problem at you.

I did a bit of testing with RPMI and SPL and here's what I found:

We don't need to add a $(PHASE_) to CONFIG_CLK_RPMI because
CONFIG_SPL_CLK can act as the switch for enabling or not the rpmi
clock driver in SPL.

For the same reason, none of the drivers in drivers/firmware/rpmi need a
$(PHASE_) because CONFIG_SPL_FIRMWARE act as the switch to put
firmware drivers in SPL.

I did however found that SPL has linker errors if the MPXY driver is
enabled in u-boot proper and CONFIG_SPL_FIRMWARE=y. This can be fixed by
adding the following lines around rpmi-sbi-mpxy:

ifeq ($(CONFIG_$(PHASE_)RISCV_SMODE),y)
obj-$(CONFIG_RPMI_SBI_MPXY) += rpmi-sbi-mpxy.o
endif

which results in adding the MPXY driver in SPL only if SPL is in S-mode and
CONFIG_SPL_FIRMWARE=y.

> 
> Hello Leo,
> 
> Yes, we can add a $(PHASE_) here and probably one in
> drivers/firmware/rpmi/Makefile for CONFIG_RPMI_SHMEM to get RPMI running on
> SPL but there's another issue that we will run into.
> 
> You might have noticed that I need to use two different device tree, one
> for M-mode where the clock-controller node mbox property points to the RPMI
> shmem node and one for S-mode where clock-controller points to the RPMI
> mpxy node. If we enable RPMI in SPL, it means that we want to do some RPMI
> accesses from M-mode using the shmem driver, boot OpenSBI, then u-boot
> proper in S-mode and do some more RPMI accesses using MPXY this time around.
> 
> This can be solved by using two device tree, one for SPL and one for u-boot
> proper but I don't know if this is the reference solution RISCV wants to
> provide to this problem.
> 
> Another solution would be to always use the S-mode bindings and add some
> logic to rpmi_get_by_index() to figure out the correct mailbox controller.
> As a refresher, the S-mode bindings will look like this:
> 
>     rpmi_shmem_mbox: mailbox@10080000 {
>         compatible = "riscv,rpmi-shmem-mbox";
>         reg = <0x10080000 0x10000>,
>               <0x10090000 0x10000>;
>         reg-names = "a2p-req", "p2a-ack";
>         riscv,slot-size = <64>;
>         #mbox-cells = <1>;
>     };
> 
>     clock-service {
>         compatible = "riscv,rpmi-mpxy-clock";
>         mboxes = <&rpmi_shmem_mbox 0x8>;
>         riscv,sbi-mpxy-channel-id = <0x1000>;
>     };
> 
>     mpxy_mbox: mailbox {
>           compatible = "riscv,sbi-mpxy-mbox";
>           #mbox-cells = <2>;
>     };
> 
>     clock-controller {
>         compatible = "riscv,rpmi-clock";
>         mboxes = <&mpxy_mbox 0x1000 0x0>;
>         #clock-cells = <1>;
>     };
> 
> Looking at SCMI, I don't think they have a solution to that problem either
> because the dt bindings [1] dictates how the firmware is being accessed and
> there's no sign of SPL support (no $(PHASE_)) in drivers/firmware/scmi.
> 
> [1]: https://elixir.bootlin.com/linux/v7.3.1/source/Documentation/devicetree/bindings/firmware/arm,scmi.yaml#L417
> 
> > 
> > >  obj-$(CONFIG_$(PHASE_)CLK_SCMI) += clk_scmi.o
> > >  obj-$(CONFIG_CLK_SIFIVE) += sifive/
> > >  obj-$(CONFIG_CLK_SOPHGO) += sophgo/
> > >
> > > ...
> > >
> > 
> > Best regards,
> > Leo
> 
> -- 
> Thanks,
> Charles

-- 
Thanks,
Charles
