Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BE7C3DA60
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 18:49:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B71B688763;
	Wed, 17 Jul 2024 20:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="E+XkvUbx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8C4C88ABD; Wed, 17 Jul 2024 20:49:13 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DD9A884CA
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 20:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46HIn8DE125802;
 Wed, 17 Jul 2024 13:49:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1721242148;
 bh=s0j6hLF/kGqZkG5xwDewHQ9SMI0MHEGcBnSTffNZLIM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=E+XkvUbx33nPCgl2sG89i5LlZP0CpxPmI+hrsK+ZMdL1hIHqpGWZ3RWKPXM3RKSKi
 DGrHA7yem8zWQLC0uW3EdzGWo7j06C+NPhQu7p6r6Vfv/q+jrhAWd6j+oH8y1NzDsf
 5DhebY9CajW/gcdzs9KH96Yy/odEQO+2IGszdFDo=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46HIn8OX070503
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 17 Jul 2024 13:49:08 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Jul 2024 13:49:07 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Jul 2024 13:49:07 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46HIn799120069;
 Wed, 17 Jul 2024 13:49:07 -0500
Date: Wed, 17 Jul 2024 13:49:07 -0500
From: Nishanth Menon <nm@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, <c-shilwant@ti.com>,
 <m-chawdhry@ti.com>, <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vibhore Vardhan
 <vibhore@ti.com>, Vishal Mahaveer <vishalm@ti.com>, Sebin Francis
 <sebin.francis@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, <t.remmet@phytec.de>,
 <mkorpershoek@baylibre.com>, Daniel Schultz <d.schultz@phytec.de>
Subject: Re: [PATCH V5 0/6] Low Power Mode: Package TIFS Stub in BeaglePlay
Message-ID: <20240717184907.5bmjwwn6tfmn3jfo@swarm>
References: <20240705164833.2386549-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240705164833.2386549-1-d-gole@ti.com>
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

On 22:18-20240705, Dhruva Gole wrote:
> This series includes the binman related changes required to package TIFS
> Stub to support Low Power Modes on BeaglePlay.
> It also documents the boot flow and tispl packaging details regarding
> the same.
> 
> Changelog:
> * Add more documentation around last time's discussion[1] on packaging TIFS
>   Stub in DM.
> 
> Link to previous series:
> https://lore.kernel.org/u-boot/20240704084207.2211801-1-d-gole@ti.com/
> 
> [1] https://lore.kernel.org/u-boot/20240705151753.7v3geqkupqu673x3@ambiance/
> 
> Thanks for the explanation given in [1] Sebin,
> Cc: Sebin Francis <sebin.francis@ti.com>
> 
> Dhruva Gole (6):
>   arm: dts: k3-am625-beagleplay: Package TIFS Stub
>   doc: beagle: am62x_beagleplay: Update the boot flow to show TIFS Stub
>   doc: beagle: am62x_beagleplay: Add TIFS Stub in image format
>   doc: ti: k3: Add TIFS Stub documentation
>   doc: ti: am62*: Mention TIFS Stub in img fmts and boot flow
> 
	Please change the ordering of the patches:

MAINTAINERS: Include the TI docs under ARM TI
doc: ti: k3: Add TIFS Stub documentation
doc: ti: am62*: Mention TIFS Stub in img fmts and boot flow

then do the stuff for beagleplay - first fix, then add new stuff, NOT
the other way around - yes, i claim that a feature added without
documentation is a bug.


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
