Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E59CFC501
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 08:21:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A75C688F5E;
	Mon, 14 Oct 2024 10:21:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="i21ZLz3V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 685BA88F68; Mon, 14 Oct 2024 10:21:54 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 387B188EE0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 10:21:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49E8LbdC071209;
 Mon, 14 Oct 2024 03:21:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728894097;
 bh=5f4qoZ2myIH1RghOD0Sgvt6Ik13lQejux2r1e1saA2M=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=i21ZLz3VLKWS3GPhdfWCacf5uUXCuf1lLBzuwhfnoeJGV6RqpaNgfdy02lhGQNXD1
 a8cXvz0bak9GAvDbcC6GPk4cj+IxsNoybqyQkpko4fyadLHiML5zJouuG4Pt0cP5Q0
 ZvnzTWB+O1oMy9r17WtEMDAaf5YX2hmzonqimJPA=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49E8Lbob006348
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Oct 2024 03:21:37 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Oct 2024 03:21:37 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Oct 2024 03:21:37 -0500
Received: from localhost (prasanth-server.dhcp.ti.com [172.24.227.197])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49E8Lass119240;
 Mon, 14 Oct 2024 03:21:36 -0500
Date: Mon, 14 Oct 2024 13:51:36 +0530
From: Prasanth Mantena <p-mantena@ti.com>
To: Peter Robinson <pbrobinson@gmail.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>, <vaishnav.a@ti.com>, <s-k6@ti.com>
Subject: Re: [PATCH v2 0/4] Cleanup dma device in spl and move dma channel[0]
Message-ID: <20241014082136.dene6rbt3k6lixuy@prasanth-server>
References: <20241009145703.1970034-1-p-mantena@ti.com>
 <CALeDE9O9STcttgbMe9NgLzaLJM97FVmXE5Ncb_Nc+W9d+tROAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALeDE9O9STcttgbMe9NgLzaLJM97FVmXE5Ncb_Nc+W9d+tROAg@mail.gmail.com>
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

On 23:10, Peter Robinson wrote:
Hi Peter,

> Hi Prasanth,
> 
> > The channel allocation and deallocation for dma copy was happening on every
> > dma transfer. This is a overhead for transactions like NAND, which does
> > page reads recursively for complete data.
> >
> > So, moving the dma allocation to probe and implement corresponding
> > remove function and cleanup dma device while exiting from spl.
> >
> > Enable SPL_DM_DEVICE_REMOVE, for device removal capability in SPL.
> >
> > v2 <==> v1
> > ==========
> > 1> Improve subject of commit.
> > 2> Add warning on dma device not found.
> > 3> Do channel allocation only for udma and bcdma. Passthrough for all other types.
> >
> > Prasanth Babu Mantena (2):
> >   mach-k3: common.c: Remove dma device in spl exit
> >   configs: k3: Enable device removal in SPL
> >
> > Santhosh Kumar K (2):
> >   dma: ti: k3-udma: Move udma_probe() below all APIs
> >   dma: ti: k3-udma: Move DMA channel[0] allocation to probe and add
> >     udma_remove()
> >
> >  arch/arm/mach-k3/common.c        |  25 ++-
> >  configs/am62ax_evm_a53_defconfig |   1 +
> >  configs/am62ax_evm_r5_defconfig  |   1 +
> >  configs/am62x_evm_a53_defconfig  |   1 +
> >  configs/am62x_evm_r5_defconfig   |   1 +
> >  configs/j7200_evm_a72_defconfig  |   1 +
> >  configs/j7200_evm_r5_defconfig   |   1 +
> >  configs/j721e_evm_a72_defconfig  |   1 +
> >  configs/j721e_evm_r5_defconfig   |   1 +
> >  configs/j721s2_evm_a72_defconfig |   1 +
> >  configs/j721s2_evm_r5_defconfig  |   1 +
> >  configs/j784s4_evm_a72_defconfig |   1 +
> >  configs/j784s4_evm_r5_defconfig  |   1 +
> 
> Is there any reason why devices like j721e_beagleboneai64 and
> m62x_beagleplay and other TI devices aren't changed as part of this
> change?

We donot have DMA enabled in SPL for these devices, as a result of which
doesn't require removal of them at spl exit in current context. We donot
have any onboard flashes on beagle boards, and hence DMA is not enabled in
SPL for these boards, which is generally required for flash boot.

Thanks
Prasanth

> 
> Peter
