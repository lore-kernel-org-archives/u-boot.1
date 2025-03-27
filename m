Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0449C3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 11:05:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 441B18070C;
	Thu, 27 Mar 2025 12:05:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39323807D7; Thu, 27 Mar 2025 12:05:27 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id EF019806D8
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 12:05:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 764D71063;
 Thu, 27 Mar 2025 04:05:29 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A192E3F58B;
 Thu, 27 Mar 2025 04:05:21 -0700 (PDT)
Date: Thu, 27 Mar 2025 11:05:17 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Michal Simek <michal.simek@amd.com>, <u-boot@lists.denx.de>, Adam Ford
 <aford173@gmail.com>, Fabio Estevam <festevam@denx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, Kever Yang
 <kever.yang@rock-chips.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Oliver Gaskell
 <Oliver.Gaskell@analog.com>, Paul Alvin <alvin.paulp@amd.com>, Prasad
 Kummari <prasad.kummari@amd.com>, Sumit Garg <sumit.garg@kernel.org>, Tom
 Rini <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>, Venkatesh Yadav
 Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH] topic: zynqmp: Remove zynqmp-xilinx-xdp platform
Message-ID: <20250327110517.538d29d0@donnerap.manchester.arm.com>
In-Reply-To: <d986be35-bfbb-4f11-98dd-19bbec102d5e@amd.com>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.68f99027-b22f-4bd9-9418-ab6179f4cea2@emailsignatures365.codetwo.com>
 <20250326161534.183270-1-mike.looijmans@topic.nl>
 <d986be35-bfbb-4f11-98dd-19bbec102d5e@amd.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 27 Mar 2025 10:00:50 +0100
Michal Simek <michal.simek@amd.com> wrote:

Hi Mike,

I don't have this board, so don't really care, but was wondering:

> On 3/26/25 17:15, Mike Looijmans wrote:
> > The "xdp" board went out of production years ago,

I have the feeling that this is true for many boards in the U-Boot tree,
pretty surely for like 80-90% of the Allwinner (sunxi) boards.
So is there any particular reason other than lack of professional capacity
for "official" maintenance to remove support? Because the removed code
doesn't look like it would need a lot of hand holding, in fact it shares a
lot with other ZynqMP boards that are still maintained. And I guess there
might still be users out there who would benefit from general U-Boot fixes
and improvements.

Cheers,
Andre

> > remove the remnants
> > from the U-boot codebase as there is no point in maintaining them.
> > 
> > Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> > ---
> > 
> >   arch/arm/dts/Makefile                         |    1 -
> >   .../zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts  |  117 --
> >   .../psu_init_gpl.c                            | 1030 -----------------
> >   configs/xilinx_zynqmp_virt_defconfig          |    2 +-
> >   4 files changed, 1 insertion(+), 1149 deletions(-)
> >   delete mode 100644 arch/arm/dts/zynqmp-topic-miamimp-xilinx-xdp-v1r1.dts
> >   delete mode 100644 board/xilinx/zynqmp/zynqmp-topic-miamimp-xilinx-xdp-v1r1/psu_init_gpl.c  
> 
> I still have this board and happy to continue to maintain it.
> 
> Cheers,
> Michal

