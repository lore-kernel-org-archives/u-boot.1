Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3415C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 19:29:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E1F08775C;
	Mon,  4 Dec 2023 20:29:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eeri3fZa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC0DD87706; Mon,  4 Dec 2023 20:29:45 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B44F58071F
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 20:29:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B4JTeZX073665;
 Mon, 4 Dec 2023 13:29:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701718180;
 bh=Yh5EaFBJevktAN4RpCPce3DtWsGjit/Vrp322fMCqYc=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=eeri3fZam7JP+Y2t3+wVATzFBzPKCTnKc2pyrlO+kZxkYWQnmJoIjHzamxd17asq+
 pcA4Ei2GDP2lxK/EiAZibq5gH4XEmS0eJ2ewJ9ocwKEvkgoOxazl1M4+esAC7WY5vM
 UZlyarH5O5MAA9smSJGxh00Vy4Ck9EgHNqvZCaeI=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B4JTeCK124948
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 4 Dec 2023 13:29:40 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Dec 2023 13:29:40 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Dec 2023 13:29:40 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B4JTe5L103530;
 Mon, 4 Dec 2023 13:29:40 -0600
Date: Mon, 4 Dec 2023 13:29:40 -0600
From: Nishanth Menon <nm@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>
Subject: Re: [PATCH 1/2] doc: board: beagle: am62x_beagleplay: Delete SW_PRNG
 flag for OPTEE
Message-ID: <20231204192940.yfeqv7fewj6izrpk@tightly>
References: <20231201102954.47582-1-d-gole@ti.com>
 <20231201102954.47582-2-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231201102954.47582-2-d-gole@ti.com>
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

On 15:59-20231201, Dhruva Gole wrote:
> Delete the flag CFG_WITH_SOFTWARE_PRNG as it's not necessary/ boot
> requirement for this SoC
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>  doc/board/beagle/am62x_beagleplay.rst | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/doc/board/beagle/am62x_beagleplay.rst b/doc/board/beagle/am62x_beagleplay.rst
> index 7784e62b0b71..50d7d3c620d7 100644
> --- a/doc/board/beagle/am62x_beagleplay.rst
> +++ b/doc/board/beagle/am62x_beagleplay.rst
> @@ -63,7 +63,6 @@ Set the variables corresponding to this platform:
>    # we dont use any extra TFA parameters
>    unset TFA_EXTRA_ARGS
>    export OPTEE_PLATFORM=k3-am62x
> -  export OPTEE_EXTRA_ARGS="CFG_WITH_SOFTWARE_PRNG=y"
>  
>  .. include::  ../ti/am62x_sk.rst
>      :start-after: .. am62x_evm_rst_include_start_build_steps
> -- 
> 2.34.1
> 
NAK. RNG is needed to seed standard distros.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
