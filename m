Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD31C54ED1
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 11:50:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A43C8304A;
	Tue, 27 May 2025 13:50:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gwcu3e7M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F3278304C; Tue, 27 May 2025 13:50:55 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EE8C82B7C
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 13:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54RBooNa2927165;
 Tue, 27 May 2025 06:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748346650;
 bh=ezoWKKLCzi05HJCXZFZQH8WAs+SR6+RvHTMXZzl9Ldk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=gwcu3e7MIi1jJRfWz2TNQd+imqiEYzRw1uAUslwb5TnvggYkz0YYgwU5vxlsCAnCC
 3i00QQ9MHIWIfm/dOU5Ub3nbSIVxg8UcqAVfNyAiFF96bpawOa/udqZtGQ3YAYEDG6
 kiNZhWVHODNkrhfQIyWogySNevEIFkKzaCUGXa7Y=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54RBooVC2841814
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 27 May 2025 06:50:50 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 May 2025 06:50:49 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 May 2025 06:50:49 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 54RBonJ2092578;
 Tue, 27 May 2025 06:50:49 -0500
Date: Tue, 27 May 2025 06:50:49 -0500
From: Nishanth Menon <nm@ti.com>
To: Peter Robinson <pbrobinson@gmail.com>
CC: Robert Nelson <robertcnelson@gmail.com>, Tom Rini <trini@konsulko.com>,
 Dhruva Gole <d-gole@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] doc: board: ti: Add missing firmware for BB-AI64
Message-ID: <20250527115049.7v3y44vg5gz5p6cx@amuck>
References: <20250525121102.415770-1-pbrobinson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250525121102.415770-1-pbrobinson@gmail.com>
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

On 13:10-20250525, Peter Robinson wrote:
> The details of the sysfw.itb from the R5 build that
> also needs to be copied as part of the target images
> is missing, but is included in the image formats a
> little further down, so add it to the instructions.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  doc/board/beagle/j721e_beagleboneai64.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/doc/board/beagle/j721e_beagleboneai64.rst b/doc/board/beagle/j721e_beagleboneai64.rst
> index 090b2b3b86a..a57bc743569 100644
> --- a/doc/board/beagle/j721e_beagleboneai64.rst
> +++ b/doc/board/beagle/j721e_beagleboneai64.rst
> @@ -83,6 +83,7 @@ Target Images
>  Copy the below images to an SD card and boot:
>  
>  * tiboot3-j721e-gp-evm.bin from R5 build as tiboot3.bin
> +* sysfw-j721e-gp-evm.itb from R5 build as sysfw.itb
>  * tispl.bin_unsigned from Cortex-A build as tispl.bin
>  * u-boot.img_unsigned from Cortex-A build as u-boot.img
>  
> -- 
> 2.49.0
> 

Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
