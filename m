Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C858C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 03:59:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4FA3876CC;
	Wed, 13 Dec 2023 04:58:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fDReiXw5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EEBB877B0; Wed, 13 Dec 2023 04:58:57 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06A2E86DC3
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 04:58:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BD3wj7F068991;
 Tue, 12 Dec 2023 21:58:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1702439925;
 bh=b5o4TklXyoAw16qpcAqJVzbp6hpEC+OAvUOpfH33fqM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=fDReiXw5qFYedp2QVSVabRnPRJAk+E2QIkzI2NVgYf07sjb5roeqjvakedCAdwcYt
 QZBNfsPsOgfWVNmjQKi2IFlFHidin76qWkMa0eMyBpuYZmLnBfnWxIp1lwS8bu6pBz
 NPCvCRzedllM0xMpovU7uMrS3HGeY2Vt+t7NBjQ8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BD3wj5Q059335
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Dec 2023 21:58:45 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Dec 2023 21:58:45 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Dec 2023 21:58:45 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BD3wjSo035613;
 Tue, 12 Dec 2023 21:58:45 -0600
Date: Tue, 12 Dec 2023 21:58:45 -0600
From: Bryan Brattlof <bb@ti.com>
To: Sjoerd Simons <sjoerd@collabora.com>
CC: <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>, Martyn Welch
 <martyn.welch@collabora.com>, Dave Gerlach <d-gerlach@ti.com>, "Marcel
 Ziswiler" <marcel.ziswiler@toradex.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v3 4/4] configs: am62x_evm_*: Enable USB and DFU support
Message-ID: <20231213035845.m77fgbgik7pu6mdo@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20231212210234.509309-1-sjoerd@collabora.com>
 <20231212210234.509309-5-sjoerd@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20231212210234.509309-5-sjoerd@collabora.com>
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

Hi Sjoerd!

On December 12, 2023 thus sayeth Sjoerd Simons:
> Enable USB host as well as USB gadget and DFU support for a53; For the
> r5 due to the smaller available size create a new config just for
> DFU support
> 
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
> 
> ---
> 
> Changes in v3:
> - Run savedefconfig to adjust to more recent u-boot
> 
> Changes in v2:
> - Create a seperate defconfig for R5
> 
>  configs/am62x_evm_a53_defconfig       |  31 ++++++-
>  configs/am62x_evm_r5_usbdfu_defconfig | 111 ++++++++++++++++++++++++++

One of the newer developments was the addition of config fragments[0] to 
try to minimize all the duplicate defconfigs for all the different 
evaluation boards for the same SoC we have in the pipeline. I'm 
wondering what people would think if we did this for the different 
boot-mode defconfigs for the 62xx extended family like this usbdfu and 
cpsw? 

idk how messy it would get trying to disable one of the primary boot 
modes like MMC and enable USB though... So this may be a idea for 
another day.

[0] https://lore.kernel.org/u-boot/20231130115552.3580995-16-a-nandan@ti.com/ 

~Bryan
