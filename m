Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB6DD15DA5
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 15:18:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D303F88EAF;
	Mon, 21 Oct 2024 17:18:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RntH1rFz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5EE4883D4; Mon, 21 Oct 2024 17:18:17 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8709388DC8
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 17:18:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49LFI26q080484;
 Mon, 21 Oct 2024 10:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1729523882;
 bh=R4d3RcGY94A93RMbg1cJVLIJgvzLKPySUQmIhtHTKkY=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=RntH1rFzzMOpFCwaC92hYUUxPBWSagS/6e3H6mvCZsT8zeP8U++1ObTrjoEVtlSDi
 80SIjcImZrhBR7CGh5x6lwzbZO+AXklL3V4kViKBQtxB50Eju6UFQaRzqjVB73TvZ4
 aEmtNwa5f5lr7MxiwVupTBMZeh00CfLZQtjFEV4U=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49LFI2vS117570
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 21 Oct 2024 10:18:02 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 21
 Oct 2024 10:18:01 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 21 Oct 2024 10:18:01 -0500
Received: from [172.24.227.193] (devarsht.dhcp.ti.com [172.24.227.193] (may be
 forged))
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49LFHtDe055340;
 Mon, 21 Oct 2024 10:17:56 -0500
Message-ID: <66434f62-e7e6-5414-cc5e-64f516288795@ti.com>
Date: Mon, 21 Oct 2024 20:47:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/3] Simple-framebuffer node related updates
Content-Language: en-US
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <bb@ti.com>
CC: <sjg@chromium.org>, <agust@denx.de>, <praneeth@ti.com>, <nm@ti.com>,
 <vigneshr@ti.com>, <s-jain1@ti.com>, <r-donadkar@ti.com>,
 <j-humphreys@ti.com>, <ilias.apalodimas@linaro.org>,
 <xypron.glpk@gmx.de>, <akashi.tkhro@gmail.com>,
 <mkorpershoek@baylibre.com>, <eajames@linux.ibm.com>,
 <caleb.connolly@linaro.org>, <quentin.schulz@cherry.de>,
 <martinstolpe@gmail.com>, <iivanov@suse.de>, <n-jain1@ti.com>
References: <20240925151354.480704-1-devarsht@ti.com>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20240925151354.480704-1-devarsht@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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

Gentle reminder.

Hi Tom, Bryan,

On 25/09/24 20:43, Devarsh Thakkar wrote:
> This series fixes some compilation issues related to FDT_SIMPLEFB
> and VIDEO and along with that enables support for dynamic simplefb
> node enablement for AM62x platform.
> 
> Devarsh Thakkar (3):
>   boot/Kconfig: Add Video Kconfig as dependency for FDT_SIMPLEFB
>   boot: fdt_simplefb: Remove conditional compilation checks for VIDEO
>     Kconfig
>   board: ti: am62x: evm: Update simple-framebuffer node in device-tree
> 


Is it possible to pull in this series for -next branch ? It is already
carrying a R-B for first two patches and last one was peer reviewed informally
too [1].

[1]:
https://lore.kernel.org/all/CAPHZmLZopucK5uMwENuF83pRMLYR2A5sC7fes4-1JXE4jX7=rw@mail.gmail.com/

Regards
Devarsh
