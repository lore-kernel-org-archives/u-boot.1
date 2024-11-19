Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E83DD60D1A
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 05:01:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 018E2894DA;
	Tue, 19 Nov 2024 06:01:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="g5r+GKg0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EDD9894DA; Tue, 19 Nov 2024 06:01:03 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B5418926F
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 06:01:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AJ50eOs3802963
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Nov 2024 23:00:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1731992440;
 bh=Ke8au9aQ49RDHSy7CDMENnTM0F8I2yTSBZLB+45+OcQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=g5r+GKg0XwYaILIwvN5AQh8rPElwVE4TJOsgh9TCJMNGSduqRDNd+657cxerIUIif
 ZFEP8Kb7+F32v9qwyfgz6mKw8KWqVg2RD2Ff3AqFOHVv6h0Mtaz+ubwG25Lpo294Js
 tvdRqsrxJP2oPMjwQyHTksPAJ0hI+XPa2YSHjSgk=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AJ50eGA025212
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 18 Nov 2024 23:00:40 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Nov 2024 23:00:39 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Nov 2024 23:00:39 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ50dU8013122;
 Mon, 18 Nov 2024 23:00:39 -0600
Date: Tue, 19 Nov 2024 10:30:38 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Garrett Giordano <ggiordano@phytec.com>
CC: <trini@konsulko.com>, <w.egorov@phytec.de>, <t.remmet@phytec.de>,
 <sumit.garg@linaro.org>, <kever.yang@rock-chips.com>, <marex@denx.de>,
 <festevam@denx.de>, <jonas@kwiboo.se>, <Oliver.Gaskell@analog.com>,
 <aford173@gmail.com>, <prasad.kummari@amd.com>,
 <neil.armstrong@linaro.org>, <mibodhi@gmail.com>, <n-francis@ti.com>,
 <afd@ti.com>, <sjg@chromium.org>, <bb@ti.com>, <nm@ti.com>,
 <d.schultz@phytec.de>, <nmorrisson@phytec.com>,
 <francesco.dolcini@toradex.com>, <vishalm@ti.com>, <vigneshr@ti.com>,
 <y.moog@phytec.de>, <othacehe@gnu.org>, <m-chawdhry@ti.com>,
 <j-humphreys@ti.com>, <j-choudhary@ti.com>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>
Subject: Re: [PATCH v2 2/2] doc: board: phytec: Add phyCORE-AM62ax
Message-ID: <20241119050038.h7irymzyl66hjz7r@lcpd911>
References: <20241118231606.3161665-1-ggiordano@phytec.com>
 <20241118231606.3161665-3-ggiordano@phytec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241118231606.3161665-3-ggiordano@phytec.com>
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

On Nov 18, 2024 at 15:16:06 -0800, Garrett Giordano wrote:
> Add documentation for PHYTEC phyCORE-AM62ax SoM.
> 
> Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
> Reviewed-by: Wadim Egorov <w.egorov@phytec.de>
> ---

Reviewed-by: Dhruva Gole <d-gole@ti.com>



-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
