Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EBAC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 19:30:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B810876E0;
	Mon,  4 Dec 2023 20:30:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RpuPGCRH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9922F87706; Mon,  4 Dec 2023 20:30:35 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0F648071F
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 20:30:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B4JUVk8088102;
 Mon, 4 Dec 2023 13:30:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701718231;
 bh=R4OQWeU0Ixtl3tE5DZicwybFUwd7QgbhJI2O2Q3kwiQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=RpuPGCRHPzrmHFZ8lEm0Wd3rtMfXuE1qkR+IRit+I+KDFEsqRkEsV/+8sC7uvheD6
 INLW9KxY+EwDc8sFYaR8+306GDXCJvuUQuszM3JUmf5e0KcycX5M1GvOemo2dZi4+n
 j2M0SXalIAqzK9VJQZm5WYUNOQcheR2m4XC4wCY0=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B4JUV20003003
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 4 Dec 2023 13:30:31 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Dec 2023 13:30:31 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Dec 2023 13:30:31 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B4JUVJh008801;
 Mon, 4 Dec 2023 13:30:31 -0600
Date: Mon, 4 Dec 2023 13:30:31 -0600
From: Nishanth Menon <nm@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Kamlesh <kamlesh@ti.com>, Vibhore Vardhan
 <vibhore@ti.com>, Wadim Egorov <w.egorov@phytec.de>
Subject: Re: [PATCH 0/2] docs: AM62x: Remove SW_PRNG Flag for OPTEE
Message-ID: <20231204193031.57p64bitdb7agoh7@client>
References: <20231201102954.47582-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231201102954.47582-1-d-gole@ti.com>
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
> The CFG_WITH_SOFTWARE_PRNG option was needed once when there were some
> issues with system crashes/ hangs after a suspend-resume cycle. However
> this seems to no longer be the case with newer firmwares, and this
> config is not needed for basic boot support of the SoC either, hence
> remove it from the docs.
> 
> Cc: Kamlesh <kamlesh@ti.com>
> Cc: Vibhore Vardhan <vibhore@ti.com>
> Cc: Wadim Egorov <w.egorov@phytec.de>
> 
> Dhruva Gole (2):
>   doc: board: beagle: am62x_beagleplay: Delete SW_PRNG flag for OPTEE
>   doc: board: ti: am62x_sk: Remove SW_PRNG Flag for OPTEE
> 
>  doc/board/beagle/am62x_beagleplay.rst | 1 -
>  doc/board/ti/am62x_sk.rst             | 1 -
>  2 files changed, 2 deletions(-)
> 

NAK to the series. RNG seed is needed for KASLR. either enable h/w RNG
or at least enable S/W RNG in OPTEE.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
