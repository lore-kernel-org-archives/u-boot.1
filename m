Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60062C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 14:23:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCFF0840AE;
	Fri, 11 Apr 2025 16:23:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jb4ASMjd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71DEA840AE; Fri, 11 Apr 2025 16:23:13 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA2AA840B1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 16:23:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53BEN7nL2152988
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 09:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744381388;
 bh=c2p93tP2ZflxQIXeEYvJ5BAid4kWcmZKGxtWvQ0luGo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=jb4ASMjdTjxgQFkLHHU5G97D3/OUJgyDiVlnSrdMg9S4G1q6v89wevS1F1oRi8ETW
 T2Rzm6Cih1mnTbBwFkQ6RI3qR1NICPF2vyoISrUyVuB42Pg5YxMCvAgMz6fE5WCsdS
 /z3ioIR6V/9nRq4WmBSCUH+G7olYlV+toolKTjoU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53BEN7bt010495
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 11 Apr 2025 09:23:07 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Apr 2025 09:23:07 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Apr 2025 09:23:07 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53BEN7LD030134;
 Fri, 11 Apr 2025 09:23:07 -0500
Date: Fri, 11 Apr 2025 09:23:07 -0500
From: Bryan Brattlof <bb@ti.com>
To: Parth Pancholi <parth105105@gmail.com>
CC: Tom Rini <trini@konsulko.com>, Parth Pancholi
 <parth.pancholi@toradex.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v1] arm: mach-k3: am62px: Fix MCU_CLKOUT0 parent clock mux
Message-ID: <20250411142307.byeft4cljksi73bv@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250408161211.3165588-1-parth105105@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250408161211.3165588-1-parth105105@gmail.com>
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

On April  8, 2025 thus sayeth Parth Pancholi:
> From: Parth Pancholi <parth.pancholi@toradex.com>
> 
> CU_CLKOUT0 can be driven by two input clocks: a 25 MHz and a 50 MHz source.
> Currently, the 25 MHz option is not selectable due to an incorrect mux
> configuration where the 50 MHz clock is duplicated in the parent list.
> 
> This patch fixes the mux setup, allowing proper selection of the 25 MHz
> clock source for MCU_CLKOUT0.
> 
> Similar configuration is already correctly implemented in AM62 clock
> data for 'hsdiv4_16fft_main_2_hsdivout1_clk10', where MCU_CLKOUT0
> parent switching behaves as expected.
> 
> Link: http://downloads.ti.com/tisci/esd/latest/5_soc_doc/am62px/clocks.html#clocks-for-board0-device
> Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
> ---

Good catch!

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
