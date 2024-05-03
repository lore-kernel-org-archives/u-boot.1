Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC29C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 15:50:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32E74882D7;
	Fri,  3 May 2024 17:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vuTMYOTL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5C17882F6; Fri,  3 May 2024 17:50:44 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C452882D4
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 17:50:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 443FoeBP029942;
 Fri, 3 May 2024 10:50:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714751440;
 bh=dDTeXuQ0s/1XI/Kn89ciWZ+uuW68HSTEy0420tyKNMM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=vuTMYOTLUTvmB0IfpnrG8Fe7zQ9VFdblyLXnbEm4X4Vf3743M3YZbR/j1/3rl79Cd
 aWPlmdZNBQEGLJFJ1IAOOmra14VxiPvSTdnnsCylCtnX21rx5QLDqenph/YwpfAXnq
 PWVVjbVJfg8aE3HYhzcNZlOliZsgYZ2QKcLTdnBk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 443Foe7Q012153
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 3 May 2024 10:50:40 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 3
 May 2024 10:50:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 3 May 2024 10:50:40 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 443FoeBX014695;
 Fri, 3 May 2024 10:50:40 -0500
Date: Fri, 3 May 2024 10:50:40 -0500
From: Bryan Brattlof <bb@ti.com>
To: Judith Mendez <jm@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] configs: am62x_evm_r5: Increase size of malloc_simple
 heap after relocation
Message-ID: <20240503155040.asmbixaf6ld3tyos@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240429214936.15187-1-jm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240429214936.15187-1-jm@ti.com>
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

Thanks Judith!

On April 29, 2024 thus sayeth Judith Mendez:
> On AM62x SK we can see a boot failure with signature "alloc space
> exhausted", so fix by increasing size of SPL_STACK_R_MALLOC_SIMPLE_LEN.
> 
> Fixes: 128f81290b ("arm: dts: k3: binman: am625: add support for signing TIFSSTUB Images")
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  configs/am62x_evm_r5_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 

This fixes the 62 for me

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
