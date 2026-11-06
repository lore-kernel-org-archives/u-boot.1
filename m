Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FE1606A337
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YfNGYcpE;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=QMx+SZgt
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9723F818D4;
	Fri,  6 Nov 2026 16:39:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZrSA5ezeO1Dl; Fri,  6 Nov 2026 16:39:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 89F4981836
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793983170;
	b=eOObbo81k0fyfeAJ8udK5G+Ch5qkiXwX+FcNLLFMKC5xNhdSBNe/8tQA+jWqwFivXmXD
	 KptgOgaz6LN6V5FMxBRr274nMoHBaybs3xBjQvneI6rMSaTw+qxze/Md1Q0GH+HTDkt4L
	 En8ihWWUJeb3bJa8Nb/ZoEvmml2rTYED7IsGyJ2LgeYdR2W3ei2lM1HYfhjXcsLsQ2ZOk
	 p08eL1SvHaHA94JRvhaZTl9aki5PxCNF3/oDiuxFwXQM2XwqM3uXYkCDbQ3x4C3rEL/f2
	 lVRvL3/+6goUd+rvw/sg9vxpFhNmmLHGMrDs00tPJ9dVLrixN/6Q0+O0S5D+ozuuPpg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793983170;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-Amp-Result:Received:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=fDoAJNuLjB6/I1Ma8vqALXDIFAxRkOLidNUoRZHeTQ8=;
	b=difTVr/J8gozcH3yg0i3DdVoG5R0vBtYtTgp3GOsq8j6U1LSsgD1LkwrvGqSsTr+BpHo
	 hRKoVlR2YuVjMHmY8PpiSfK/7KdIFAi8nc/e5sHaeT9hX7R2UKA/xrTyN1Kvk6omVMFyr
	 J6QUdpdSgSdsIMRmUleFy1cX4q9AHzkC3elfeM7r3hSR03tchqKUcCAxQGe53b+shn+bd
	 HBiveeLOD7hu0NhPrrxbwyA0AxWk2P4uXHiBFYikxf8UmprtChDt/E2bbCkCySlHW7mhs
	 nHB2MTsnyD10iDpc9t96KVnKfoz7vcwf7NWwmGLdTL6Hp4/b28fJhHQwD8KOu+y7mow==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793983170;
	bh=fDoAJNuLjB6/I1Ma8vqALXDIFAxRkOLidNUoRZHeTQ8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YfNGYcpE57H3zzwVnZtQc2bMkj1HE3eQ8TTKXparTDgSHpd6cjLLLchf04ipdTYFE
	 5OktYq/Oci9MpeDNV19Q9fXwPtzWscnBy9OVFIcdNXKHIfQ7NbU3ctHG3DmtcerDV8
	 H/eq1Oy6V5ShxR6Qg0eo0Kqn1W4+6ah4Bd34/rSU6NZjVIuUs3pkL7xhGgoUzYy2gl
	 6KrD3fN5FlQEz4dVeW0/jxBsGSgEFGKkRAUzFv1rMgxu5Z1UtSsfifJXC2WfgS8qrl
	 aUJkD0WbMcxl6Tr1UigZd69aHwk/O0u9CsrWduoH0ZMoM/R9fAie+oBEaPW1fW1Ype
	 JaR2DzjAnckKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 89F4981836;
	Fri,  6 Nov 2026 16:39:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B1602E5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:39:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 502DA407D4
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:39:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YDC73qvHiEb4 for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 16:39:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 129D3407AD
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=68.232.153.233
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=68.232.153.233;
 helo=esa.microchip.iphmx.com;
 envelope-from=prvs=763bc877a=charles.perry@microchip.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=QMx+SZgt
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 129D3407AD
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 16:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1793983168; x=1825519168;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=PceiXT3aqcDAlin06fkY1W5eCC60LFPE5Ogc5W//egc=;
 b=QMx+SZgtZxs4QLi1XiftsqGXHyTV3PHPrVhQkU0nmJ2VN9KrEED9Gyv4
 IhcaamlNq8GgM9zJqDEW48DV30nzKEQVUJXi7vjcES1sAE8NQqcxZDAmS
 r3IYExxJka1bbFzWyWWnn5VkIToaiBs9NGlHoDIJwHKcdJHS/bdvZQ4Th
 24mtvaKBf+MxMBAAePzFX7Ye+aRKJ6ELUWEgMpLgJ+xLzi4z1R9rKxAdg
 zG8gONyQKOfweu/6VW9rIujYgT+uUooW71HuEMH9AODo9aygM2HFq8PKp
 9DPLkRXyY/ZE+651S5GdgY6VYARLU+7oe+hmIlPFaQWpU1Z/hLSX5r1sN g==;
X-CSE-ConnectionGUID: 1v0sXiz8TJGicD8mub5yXg==
X-CSE-MsgGUID: /9sLQl5XTOewwcK6dx8duA==
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; d="scan'208";a="297568006"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 09:39:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 6 Nov 2026 09:39:24 -0700
Received: from MON-LT-C78453.mchp-main.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Fri, 6 Nov 2026 09:39:22 -0700
Date: Fri, 6 Nov 2026 11:39:20 -0500
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
Message-ID: <au4CuFTPqdet6Vir@MON-LT-C78453.mchp-main.com>
References: <20261014-rpmi_v4-v4-0-d53d34a49780@microchip.com>
 <20261014-rpmi_v4-v4-4-d53d34a49780@microchip.com>
 <auioPabD3tEPCMQV@lliang-1876.localdomain>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <auioPabD3tEPCMQV@lliang-1876.localdomain>
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 02, 2026 at 11:11:57PM +0800, Leo Liang wrote:
> On Wed, Oct 14, 2026 at 10:17:08AM -0400, Charles Perry wrote:
> > The RISC-V Platform Management Interface (RPMI) defines a service group
> > for control and monitoring of clocks [1]. This can be exposed as a
> > UCLASS_CLK driver.
> > 
> > [1]: https://github.com/riscv-non-isa/riscv-rpmi (chapter 4.8)
> > 
> > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> > ---
> > Changes in v4: None
> > Changes in v3: None
> > 
> > Changes in v2: (from Yao Zi review)
> >  - Reorder headers
> >  - Don't null check pointers before free()
> >  - Remove transition_latency from struct rpmi_clk_def as its unused
> >  - Simplify last return path of _rpmi_clk_enable_disable()
> >  - Move the call to _rpmi_clk_get_rate() from _rpmi_clk_set_rate() to
> >    rpmi_clk_set_rate()
> > ---
> >  MAINTAINERS            |   1 +
> >  drivers/clk/Kconfig    |   7 +
> >  drivers/clk/Makefile   |   1 +
> >  drivers/clk/clk_rpmi.c | 344 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/rpmi_proto.h   |  39 ++++++
> >  5 files changed, 392 insertions(+)
> > 
> > ...
> >
> > +config CLK_RPMI
> > +	bool "Enable RPMI clock driver"
> > +	depends on CLK && RPMI_FIRMWARE
> > +	help
> > +	  Enable this option if you want to support clock devices exposed
> > +	  by RISC-V Platform Management Interface (RPMI).
> > +
> >  config SANDBOX_CLK_CCF
> >  	bool "Sandbox Common Clock Framework [CCF] support"
> >  	depends on SANDBOX
> > diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> > index 4b241a9240ac..9e19e6f6d845 100644
> > --- a/drivers/clk/Makefile
> > +++ b/drivers/clk/Makefile
> > @@ -46,6 +46,7 @@ obj-$(CONFIG_CLK_OWL) += owl/
> >  obj-$(CONFIG_CLK_QCOM) += qcom/
> >  obj-$(CONFIG_CLK_RENESAS) += renesas/
> >  obj-$(CONFIG_$(PHASE_)CLK_RS9_PCIE) += clk-renesas-pcie.o
> > +obj-$(CONFIG_CLK_RPMI) += clk_rpmi.o
> 
> Should we add $(PHASE_) as well, otherwise, the platform that uses
> SPL and CLK_RPMI could fail to link with the rpmi_uclass.c API.

Hello Leo,

Yes, we can add a $(PHASE_) here and probably one in
drivers/firmware/rpmi/Makefile for CONFIG_RPMI_SHMEM to get RPMI running on
SPL but there's another issue that we will run into.

You might have noticed that I need to use two different device tree, one
for M-mode where the clock-controller node mbox property points to the RPMI
shmem node and one for S-mode where clock-controller points to the RPMI
mpxy node. If we enable RPMI in SPL, it means that we want to do some RPMI
accesses from M-mode using the shmem driver, boot OpenSBI, then u-boot
proper in S-mode and do some more RPMI accesses using MPXY this time around.

This can be solved by using two device tree, one for SPL and one for u-boot
proper but I don't know if this is the reference solution RISCV wants to
provide to this problem.

Another solution would be to always use the S-mode bindings and add some
logic to rpmi_get_by_index() to figure out the correct mailbox controller.
As a refresher, the S-mode bindings will look like this:

    rpmi_shmem_mbox: mailbox@10080000 {
        compatible = "riscv,rpmi-shmem-mbox";
        reg = <0x10080000 0x10000>,
              <0x10090000 0x10000>;
        reg-names = "a2p-req", "p2a-ack";
        riscv,slot-size = <64>;
        #mbox-cells = <1>;
    };

    clock-service {
        compatible = "riscv,rpmi-mpxy-clock";
        mboxes = <&rpmi_shmem_mbox 0x8>;
        riscv,sbi-mpxy-channel-id = <0x1000>;
    };

    mpxy_mbox: mailbox {
          compatible = "riscv,sbi-mpxy-mbox";
          #mbox-cells = <2>;
    };

    clock-controller {
        compatible = "riscv,rpmi-clock";
        mboxes = <&mpxy_mbox 0x1000 0x0>;
        #clock-cells = <1>;
    };

Looking at SCMI, I don't think they have a solution to that problem either
because the dt bindings [1] dictates how the firmware is being accessed and
there's no sign of SPL support (no $(PHASE_)) in drivers/firmware/scmi.

[1]: https://elixir.bootlin.com/linux/v7.3.1/source/Documentation/devicetree/bindings/firmware/arm,scmi.yaml#L417

> 
> >  obj-$(CONFIG_$(PHASE_)CLK_SCMI) += clk_scmi.o
> >  obj-$(CONFIG_CLK_SIFIVE) += sifive/
> >  obj-$(CONFIG_CLK_SOPHGO) += sophgo/
> >
> > ...
> >
> 
> Best regards,
> Leo

-- 
Thanks,
Charles
