Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA10CAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 12:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60CB780325;
	Tue, 16 Sep 2025 14:22:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XZk5mA3W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BFFF8318E; Tue, 16 Sep 2025 14:22:57 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 933F480077
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 14:22:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58GCMjIZ008686;
 Tue, 16 Sep 2025 07:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758025365;
 bh=dGaYp56fpVwIa3T7WkAHT0S12kW4I1yiqbfQYEBKl6o=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=XZk5mA3WsURehZLywrg02bgsU3TssLSs16cNCjAgt4I0ThEARC9yMlpuBkllktk+7
 aflTzY/kqUlxQWryN74GuDtWCocLI2XLKuSNcnhwn9ROzt04ypJcklMt5q0vtl7AnL
 u5RbvqRYvQnRJzLNmtOqzLEReyeXsmb1R9a5sbLs=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58GCMjJW516423
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 16 Sep 2025 07:22:45 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 16
 Sep 2025 07:22:45 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Sep 2025 07:22:45 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58GCMjXw1296775;
 Tue, 16 Sep 2025 07:22:45 -0500
Date: Tue, 16 Sep 2025 07:22:44 -0500
From: Bryan Brattlof <bb@ti.com>
To: Aristo Chen <jj251510319013@gmail.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>, <al.kochet@gmail.com>,
 <paul.henrys_ext@softathome.com>, <y.moog@phytec.de>,
 <w.egorov@phytec.de>, <francesco.dolcini@toradex.com>,
 <ggiordano@phytec.com>, <n-francis@ti.com>, <afd@ti.com>,
 <d.schultz@phytec.de>, <d-gole@ti.com>, <ravi@prevas.dk>,
 <carlos.lopezr4096@gmail.com>, <quentin.schulz@cherry.de>,
 <alice.guo@nxp.com>, Aristo Chen <aristo.chen@canonical.com>
Subject: Re: [PATCH v2 4/7] arm: dts: k3-am6xx: Fix FIT image memory overlap
 in binman configurations
Message-ID: <20250916122244.a7rda2ouhou47hp7@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20250914110021.4103-5-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250914110021.4103-5-aristo.chen@canonical.com>
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

On September 14, 2025 thus sayeth Aristo Chen:
> Fix memory overlaps in FIT image configurations for TI AM62x and AM64x
> PHYCore and SK boards.
> 
> The overlaps occurred in two categories:
> 
> 1. TI firmware stub images (tifsstub-hs, tifsstub-fs, tifsstub-gp):
>    These mutually exclusive firmware variants were incorrectly assigned
>    the same load address within FIT configurations, causing overlap
>    detection to fail. Adjust addresses with 64KB spacing:
>    - tifsstub-hs: Keep original address
>    - tifsstub-fs: Move to +64KB offset
>    - tifsstub-gp: Move to +128KB offset
> 

Yeah I can see how this looks like an oversight and I like the idea of 
checking for binaries that collide with each other however we're using 
the board_fit_image_post_process() function to load only one of these
'tifsstub' binaries which matches the security variant of the SoC at 
runtime[0]. Because we only load one of these they don't actually 
overlap.

TBH I don't actually understand what is in these binaries which makes 
them so specific to each security variant or if we must load them to 
this specific address thanks to some IPC stuff between our vendor 
firmware. I'll ask around. But I don't think we can move these 
'tifsstub' binaries this easily.

~Bryan

[0] https://elixir.bootlin.com/u-boot/v2025.07/source/arch/arm/mach-k3/r5/common.c#L326

