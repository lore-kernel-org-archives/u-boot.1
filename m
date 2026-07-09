Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8634EC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 14:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 216BC84A8F;
	Thu,  9 Jul 2026 16:54:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="yCcqpirI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E38B484B7F; Thu,  9 Jul 2026 16:54:45 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26DCA84A78
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 16:54:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=643ffd917=Charles.Perry@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1783608883; x=1815144883;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=lPBtbLhlH+1DdsYjjXdvTrJhZ6Hpl/CEbK/SC9W0mek=;
 b=yCcqpirIkwuQz/i2v7kiHXEqORqeR4iIt9eingX4Awo967VqIYK4N42/
 THQMyE1bHPmN5VaW5MI13Z0u9YesUFAmCSlNWRK4UGLrHExV3Q1k0b+mf
 JiljAu6/oeGFNCdmiRZObnBdZ67heaQnbNR3m9ZNqflubxVz+6vLiYdJ5
 YFCo4NtiHrhfnKs6DAe/tBl00X7qGTOX9+lchXzdvX7cgyQQ3PdBisb2X
 z+OQtrbNtEmohY4S/e7TzDEpfNUg0Ja+GePqiPhfYkD69KQVC6llKs4iO
 /LZPJMTDuAEVxrcsGc4vcen13Q4CBJokBaPJEGchg7goGMYrdf3tnKBQ0 A==;
X-CSE-ConnectionGUID: vrOT1SBCTOyCy20HTw/pHg==
X-CSE-MsgGUID: g7nLYsBYRvyPlAsCuEl4Rg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="69690274"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 07:54:40 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Thu, 9 Jul 2026 07:54:40 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Thu, 9 Jul 2026 07:54:39 -0700
Date: Thu, 9 Jul 2026 07:54:37 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Michal Simek <michal.simek@amd.com>
CC: Charles Perry <charles.perry@microchip.com>, <u-boot@lists.denx.de>,
 "Rahul Pathak" <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 "Paul Walmsley" <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert
 Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Romain Caritey
 <romain.caritey@microchip.com>, Mame Maria Mbaye
 <MameMaria.Mbaye@microchip.com>, Tom Rini <trini@konsulko.com>, "Heinrich
 Schuchardt" <heinrich.schuchardt@canonical.com>, Rick Chen
 <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>, "Souvik
 Chakravarty" <Souvik.Chakravarty@arm.com>
Subject: Re: [PATCH v2 0/5] Add support for RPMI to U-Boot
Message-ID: <ak+2LeDbngEr7oqj@bby-cbu-swbuild03.eng.microchip.com>
References: <20260708215200.1331416-1-charles.perry@microchip.com>
 <c2c87ebf-e26b-4987-bf78-cc2508ec7ca8@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c2c87ebf-e26b-4987-bf78-cc2508ec7ca8@amd.com>
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

On Thu, Jul 09, 2026 at 03:02:11PM +0200, Michal Simek wrote:
> 
> 
> On 7/8/26 23:51, Charles Perry wrote:
> > Hello,
> > 
> > This series adds support for RISC-V Platform Management Interface (RPMI) to
> > U-Boot. RPMI is an OS-agnostic protocol for communication between an
> > Application Processor (AP) and a Platform Microcontroller (PuC) [1]. The
> > goals and purpose of RPMI are similar to ARM's SCMI.
> 
> From the first look it looks like SCMI. Why do you introducing something
> what can be replaced by SCMI?
> And SCMI has only specific ARM transport layer but the rest is arch independent.

Yes, there are alot of similarities between RPMI and SCMI. I found some
justification for this in some Linux Plumbers slide deck on RISC-V power
management by Paul Walmsley [1]:

 * The hardware is more sophisticated
 * The software is more sophisticated
 * Some stakeholders haven’t had input in the past
 * RISC-V “big tent” philosophy

I think this is referring to the SBI spec of RISC-V vs arm's PSCI but the
same arguments may as well apply to RPMI vs SCMI.

Some other arguments:

 * The microcontroller side is made easier with RPMI because of librpmi [2].
   SCMI has SCP-firmware [3] which is a quite complex project compared to
   librpmi. Also SCP-firmware doesn't accept contribution anymore.
 * RPMI is already in Linux.

For what I'm doing, RPMI is what gave me the first results (controlling
clocks) the quickest because all the pieces were present in Linux, OpenSBI
and librpmi. There are however lots of missing service drivers in Linux and
some other important OS like u-boot don't have support for RPMI at all. So
even though I gave you a bunch of reason for saying yes to RPMI, I do have
some doubt about how long it will take to bring RPMI on par with SCMI,
making the SCMI-for-RISCV transport that you suggest more appealing.

[1]: https://lpc.events/event/2/contributions/197/attachments/133/165/RISC-V_Platform_Power_Management.pdf (slide 22)
[2]: https://github.com/riscv-software-src/librpmi
[3]: https://gitlab.arm.com/firmware/SCP-firmware

> 
> In our case where we have Microblaze V in programmable logic I can't see any
> reason to use RPMI for talking to the same server if I need to do it from
> ARM side too via SCMI.
> 
> I pretty much think that there should be communication with ARM and instead
> of creating another firmware interface talk to each other and have only one
> which can be used across multiple architectures.
> 
> Thanks,
> Michal

Thanks,
Charles

