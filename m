Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BA2C02194
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 19:12:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D346805A1;
	Tue,  4 Feb 2025 20:12:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fb0NF6F6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 318E0805D7; Tue,  4 Feb 2025 20:11:58 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E3BC80540
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 20:11:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 514JBrgS2389704
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Feb 2025 13:11:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738696313;
 bh=Xd/n+b300lQv1Gob2kFRnDlIEMwQwwyMQn5173OyUh0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=fb0NF6F6MBRdaTj2o0BbQetDjd52iWvgvMTY69A1fCkViB31baaz7thx7L2vQjFvo
 9BxtZn940cjs9o/uDk5MoqHBKMCUmZ9j6WiHvcJ0uAtLLqzJqQjeOt2QneCyhRIoJT
 DFYMyud5w9x3q9rrgnqy4vy/9Xuhee1SnqY3u8Co=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 514JBrPO022706
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 4 Feb 2025 13:11:53 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Feb 2025 13:11:52 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Feb 2025 13:11:52 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 514JBqOI017639;
 Tue, 4 Feb 2025 13:11:52 -0600
Message-ID: <7d568824-8829-4eba-ba97-70bdae0e1ed3@ti.com>
Date: Tue, 4 Feb 2025 13:11:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Introduce K3 remoteproc driver for M4 subsystem
To: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Hari Nagalla <hnagalla@ti.com>,
 Andrew Davis <afd@ti.com>, Daniel Schultz <d.schultz@phytec.de>
References: <20250130223256.1944522-1-jm@ti.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250130223256.1944522-1-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

Hi all,

On 1/30/25 4:32 PM, Judith Mendez wrote:
> Some K3 devices like am62x and am64x have a M4 processor in the MCU
> voltage domain. This patch series introduces remoteproc M4 driver which
> will be used to load firmware into and start the M4 remote core.
> 
> This series also adds support for R5F cores on am64x SoCs in patch 2/4,
> sets up environment to load FW in remote cores in patch 3/4, and enables
> config options for R5F and M4 remoteproc support in patch 4/4.
> 
> This patch series was tested on am64x EVM using commands:
> 
> => setenv dorprocboot 1
> => run boot_rprocs
> 

I have missed one warning introduced by the driver in this patch series,
so will respin one more time to add the fix.

~ Judith

