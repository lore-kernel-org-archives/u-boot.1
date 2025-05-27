Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0C4C54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 15:00:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8E1983096;
	Tue, 27 May 2025 17:00:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SfR2Tlaf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C0F7830CE; Tue, 27 May 2025 17:00:14 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8EDF8294C
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 17:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54RF07OD1788495;
 Tue, 27 May 2025 10:00:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748358007;
 bh=QOOU5rnmSj/eThKTtpbGrc94Jaoz1qDg1VUTIR/dS6U=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=SfR2TlafqsdgUxkvmc7Jc4Yj/gP8patttYhYrvmyU//DizNqnhg9o3KhqRFUrUVGN
 1Ilw0L/EyFLnX2ohsiV308GJSxPd/IBiiBrcbj/zU20G/RchT1uIbQssi3D7NTdcAC
 HYLjFIV1gEiP0vSJFsU1V9ZmEZW3vUcbH8pnnwsc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54RF06ko2900645
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 27 May 2025 10:00:07 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 May 2025 10:00:06 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 May 2025 10:00:06 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 54RF05sN3431613;
 Tue, 27 May 2025 10:00:05 -0500
Date: Tue, 27 May 2025 20:30:04 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Peter Robinson <pbrobinson@gmail.com>
CC: Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Tom
 Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] doc: board: ti: Add missing firmware for BB-AI64
Message-ID: <20250527150004.bniix33re7os2lqj@lcpd911>
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

Hi Peter,

On May 25, 2025 at 13:10:58 +0100, Peter Robinson wrote:
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

Thanks for adding this, and I am okay with the changes.

But also, does it make sense to make all of this inherit from a label that
we can add inside [1] and include that here directly?
I am okay if you just wanna label the gp part and include it here as
well.

Either way,
Reviewed-by: Dhruva Gole <d-gole@ti.com>

[1] https://docs.u-boot.org/en/latest/board/ti/j721e_evm.html#target-images



-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
