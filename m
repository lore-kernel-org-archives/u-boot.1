Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F891C5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 09:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D115D87E93;
	Fri,  8 Mar 2024 10:02:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kIfvEKIT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACFA288072; Fri,  8 Mar 2024 10:02:20 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03CBF80245
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 10:02:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42892B4Z011920;
 Fri, 8 Mar 2024 03:02:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709888531;
 bh=rwFMSaa6dX5KlR5Ea1H+xdI+we88z36Unfsqx71pcwQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=kIfvEKITUHdF3f62ggi4fmn4vu5O3zLQBIaF/hC0gMf5l+JHxeTAfep5cJOmEcMS6
 KGpvVfDWFF44eW01E69I0+e6mA1d1fNIw9y6f6l3Bx+wugse38uTnbqqHEALZGwKZ6
 8OL+NYVovh31qNtqmH6IEs0czWdcxAGD+u2rhfPw=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42892B1H054503
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Mar 2024 03:02:11 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Mar 2024 03:02:10 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Mar 2024 03:02:10 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42892Aoh048401;
 Fri, 8 Mar 2024 03:02:10 -0600
Date: Fri, 8 Mar 2024 14:32:09 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Bhargav Raviprakash <bhargav.r@ltts.com>
CC: <u-boot@lists.denx.de>, <jh80.chung@samsung.com>, <sjg@chromium.org>,
 <m.nirmaladevi@ltts.com>, <trini@konsulko.com>, <dan.carpenter@linaro.org>
Subject: Re: [PATCH v2 1/5] power: tps65941: Add macros of TPS65224 PMIC
Message-ID: <20240308090209.7zrcs4s23mkz2mtv@dhruva>
References: <20240306133947.160354-1-bhargav.r@ltts.com>
 <20240306133947.160354-2-bhargav.r@ltts.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240306133947.160354-2-bhargav.r@ltts.com>
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

On Mar 06, 2024 at 19:09:43 +0530, Bhargav Raviprakash wrote:
> Re-use the TPS65941 PMIC driver for TPS65224 PMIC.
> Add additional macros of TPS65224 to aid in the driver
> re-use.
> 
> Signed-off-by: Bhargav Raviprakash <bhargav.r@ltts.com>
> ---

Reviewed-by: Dhruva Gole <d-gole@ti.com>

>  include/power/tps65941.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
