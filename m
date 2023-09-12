Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660B8CA0ECA
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 12:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91A3F86E76;
	Tue, 12 Sep 2023 14:28:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Hniyw/jO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F70486E76; Tue, 12 Sep 2023 14:28:30 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C22EC86E90
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 14:28:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38CCSNwQ051561;
 Tue, 12 Sep 2023 07:28:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694521703;
 bh=gn5JMDxufbU3ykHMOHmteN/9zSCPwKpZ1SEJEZxIRf0=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Hniyw/jOxZwjK2hJDvzwL4wYfxP/Qa0zVetW0Nhff1gjgdgIeny/Phqpgr/cYGUbB
 FP/D4PwNvHVoFTfw9BfnyyuB23JwkSIBBRcMCeTZaFacGd4ctRe0BQt8b/gNrYHSgj
 6vN40BqST0rBtFUIOhiYDRXf5E5b395kHygB7Ir0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38CCSNGF016426
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Sep 2023 07:28:23 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Sep 2023 07:28:23 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Sep 2023 07:28:23 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38CCSN8c034123;
 Tue, 12 Sep 2023 07:28:23 -0500
Date: Tue, 12 Sep 2023 07:28:23 -0500
From: Nishanth Menon <nm@ti.com>
To: Reid Tonking <reidt@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>,
 <vigneshr@ti.com>, <m-chawdhry@ti.com>, Neha Francis <n-francis@ti.com>
Subject: Re: [PATCH] drivers: misc: k3_avs: Add Linux compatibles to maintain
 sync
Message-ID: <20230912122823.swjwmaiz54e4kcu6@patrol>
References: <20230907180635.89011-1-reidt@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230907180635.89011-1-reidt@ti.com>
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

On 13:06-20230907, Reid Tonking wrote:
> The ti,j7200-vtm and ti,j721e-vtm compatibles are used for voltage
> and thermal monitoring (VTM) by (drivers/thermal/k3_j72xx_bandgap.c)
> in Linux, but the same hardware is used for adaptive voltage scaling
> (AVS) in u-boot, This brings both drivers in line with the same
> compatibles.
> 
> Since the j7200 uses the config as the j721e, the data is inherited
> from j721e vs creating a duplicate
> 
> Signed-off-by: Neha Francis <n-francis@ti.com>
> Signed-off-by: Reid Tonking <reidt@ti.com>
> ---
Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
