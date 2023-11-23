Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFF0C61D97
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 16:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88F1A875E9;
	Thu, 23 Nov 2023 17:29:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GDbksEme";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F19887678; Thu, 23 Nov 2023 17:29:20 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1441E86F99
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 17:29:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ANGTDgh020676;
 Thu, 23 Nov 2023 10:29:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700756953;
 bh=Lp1lrZ46Xkc/++QIXxyrgFvTWeIbD0WZ85Yx5jdxFag=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=GDbksEmesaIJw1WbDer6ULVePpTwVy2Ss+MzubTfSd6BiBRb2bEGk02Q8zIVFnety
 6KwIwZ9cIZ6eCQVKtQAVT8c9WASMWy+kPV2jehYzLg/wQaF1L8bIxcFAfLa3MucVZe
 1ZuhO4EXr5o3+2s3ooc7F4QfxlfwNeqKIKcZu2gs=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ANGTD2q030471
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 23 Nov 2023 10:29:13 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 Nov 2023 10:29:13 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 Nov 2023 10:29:12 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ANGTClN092393;
 Thu, 23 Nov 2023 10:29:12 -0600
Date: Thu, 23 Nov 2023 10:29:12 -0600
From: Nishanth Menon <nm@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Apurva Nandan <a-nandan@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH RFC 0/2] Unify K3 initial memory map
Message-ID: <20231123162912.vobn72jiy5ntq4ha@wired>
References: <20231122151411.11268-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231122151411.11268-1-afd@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 09:14-20231122, Andrew Davis wrote:
> Hello all,
> 
> This is just an RFC as it probably breaks remoteproc loading.
> I wanted to post anyway as the complexity of having a dedicated
> memory map for each SoC came up in a different series.
> 
> Or maybe we can take this now and that will expose the issue in
> remoteproc loading better and force someone to go fix it. :)
> 
> This series depends on this[0].
> 
> Thanks,
> Andrew
> 
> [0] https://patchwork.ozlabs.org/project/uboot/patch/20231106165205.22066-1-afd@ti.com/
> 
> Andrew Davis (2):
>   arm: mach-k3: Remove non-cached memory map areas
>   arm: mach-k3: Merge initial memory maps
> 
>  arch/arm/mach-k3/arm64-mmu.c | 253 +----------------------------------
>  1 file changed, 2 insertions(+), 251 deletions(-)
> 
> -- 
> 2.39.2
> 
Could you rebase and submit as non-RFC? Please free to add:

Reviewed-by: Nishanth Menon <nm@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>

tested along with the v2 of dependency patch https://lore.kernel.org/all/20231122211218.607757-1-afd@ti.com/
on top of:
next 054222eb68f6 Merge branch '2023-11-22-TI-K3-cleanups' into next

platforms tested:
beagleplay-gp-uart
j721s2-evm
am68_sk-fs
j721e-sk
j721e-idk-gw
j7200-hsevm
j7200-evm
am64xx-hsevm
am64xx_sk-fs
am62xx_sk-fs
am62xx-sk
am62axx_sk-fs

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
