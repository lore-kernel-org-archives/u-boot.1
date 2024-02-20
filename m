Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1468C5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 14:47:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBD1587FB5;
	Tue, 20 Feb 2024 15:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Vd/Q3FbY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D88F387FB5; Tue, 20 Feb 2024 15:47:18 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C629687ED6
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 15:47:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41KCohkY097648;
 Tue, 20 Feb 2024 06:50:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708433443;
 bh=bG1d83WEyKiJBDjzQxbM4VXeiM0QACiz9Z5I4OcrQ+Y=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Vd/Q3FbYOPrR660sQcw1gMBUtmb1KuXe5znmPLmGAy31AsE9sqc99cJSUrv+snz6J
 NXoC23W04OqCbVg48zCLrJUVvoqhjlJBMRuxK5rqRxFDNsyGBI52AANN8lHLdPrNmQ
 bsFurA/xn2sVefZAvFQUC4cNwWOcWCt7zrlYXCmU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41KCohnf009042
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 20 Feb 2024 06:50:43 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 06:50:43 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 06:50:43 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41KCohav128538;
 Tue, 20 Feb 2024 06:50:43 -0600
Date: Tue, 20 Feb 2024 06:50:43 -0600
From: Nishanth Menon <nm@ti.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
CC: Alexander Sverdlin <alexander.sverdlin@gmail.com>, Neha Francis
 <n-francis@ti.com>, Tom Rini <trini@konsulko.com>, Simon Glass
 <sjg@google.com>, Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew
 <afd@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vignesh
 <vigneshr@ti.com>, <u-boot@lists.denx.de>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Simon Glass <sjg@chromium.org>, Andreas
 Dannenberg <dannenberg@ti.com>, Romain Naour <romain.naour@smile.fr>
Subject: Re: [PATCH V6 07/20] configs: am62x_evm_a53_defconfig: Switch to
 bootstd
Message-ID: <20240220125043.5mahfosfudxpztts@caregiver>
References: <20230825180305.69515-1-nm@ti.com>
 <20230825180305.69515-8-nm@ti.com>
 <87f154591fee4979570e78cbc8c73eb0a56469eb.camel@gmail.com>
 <e6222770-cbcd-45e2-94fe-eb55fb0a2f94@siemens.com>
 <5679ced7e927e1eb858a47d25abbd4025b4b67b7.camel@gmail.com>
 <dba0d25f-121d-4146-a78b-ac3beeeb1531@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dba0d25f-121d-4146-a78b-ac3beeeb1531@siemens.com>
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

On 19:37-20240219, Jan Kiszka wrote:
> My personal observation is that continuous integration testings with
> all-upstream components is not really a common thing. I saw that with
> multiple active SoCs from various vendors.

For what it is worth, https://software-dl.ti.com/cicd-report/upstream/
-> we are trying to do that on TI side, though it is still in infancy
and test coverage is still more to be desired.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
