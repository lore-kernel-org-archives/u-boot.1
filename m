Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C56C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 13:12:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CD07882D6;
	Fri, 28 Jun 2024 15:12:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bwkLITqP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0C0A88453; Fri, 28 Jun 2024 15:12:33 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FB0888239
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 15:12:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45SDCMlM081501;
 Fri, 28 Jun 2024 08:12:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719580342;
 bh=0M3Vr2HXHHLAdaZi9uy1cGWeubHk5BlF7yMoxIWheYQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=bwkLITqPypZjx71R3p1wo8FTChpJYsPsk5/W6yjgXUP4zbEB8TFOWmNXlErBaZy83
 RqNTMC7BWMu1Q/BBaOpvvdrvmItLwZHU2lmJ+nuQwuF0lZj6r8Fno5fm4sjsSGvyET
 PedONPOMQ+5dV9Ez3stKPIyFPunwm1k3Ilwt5tiU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45SDCMOj110875
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 28 Jun 2024 08:12:22 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jun 2024 08:12:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jun 2024 08:12:22 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45SDCMLA018336;
 Fri, 28 Jun 2024 08:12:22 -0500
Date: Fri, 28 Jun 2024 08:12:22 -0500
From: Nishanth Menon <nm@ti.com>
To: Dhruva Gole <d-gole@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, <c-shilwant@ti.com>,
 <m-chawdhry@ti.com>, <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH v4 0/2] k3-am625-beagleplay: Add symlinks for tiboot3 and
 tispl
Message-ID: <20240628131222.4ev5rhmqepmc7qnk@reward>
References: <20240618044946.270299-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240618044946.270299-1-d-gole@ti.com>
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

On 10:19-20240618, Dhruva Gole wrote:
> Add symlinks for both tiboot3.bin and tispl.bin because a user has to
> anyway rename these files to get the platform to boot up.
> Also update the documentation to reflect above change.
> 
> Changes in v4:
> * Add the docs patch.
> 
> Cc: Nishant Menon <nm@ti.com>
> Cc: Robert Nelson <robertcnelson@gmail.com>
> 
> Dhruva Gole (2):
>   arm: dts: k3-am625-beagleplay: Add symlinks for tiboot3 and tispl
>   doc: beagle: am62x_beagleplay: Rename the boot bins
> 
>  arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi | 1 +
>  arch/arm/dts/k3-am625-r5-beagleplay.dts      | 1 +
>  doc/board/beagle/am62x_beagleplay.rst        | 7 +++----
>  3 files changed, 5 insertions(+), 4 deletions(-)


Robert/Jason:

Can you folks confirm that we will ONLY have GP version of BeaglePlay
for even a new update of the board? If that is confirmed, then this
series is good.

Any thoughts?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
