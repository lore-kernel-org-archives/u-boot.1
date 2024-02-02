Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AACC47258
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 04:50:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14FE887CDB;
	Fri,  2 Feb 2024 05:50:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="avQ6C1bW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CE5E87CEA; Fri,  2 Feb 2024 05:50:21 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D70587C1F
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 05:50:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r-gunasekaran@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4124oBQ8092628;
 Thu, 1 Feb 2024 22:50:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706849411;
 bh=aHESBlrvQie/IFfYbAHLaf3Svo0R4JgqluiyxWuvE8s=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=avQ6C1bWvOizbIPrVIolsvuYZlSg5eV0xyEo3n/X9xUdL7bJtIe9Wk/lGsQyJUHXA
 Ffu8QROhe8AzWMQHST08VOPJLUv8JmDAF95YUSIYrOwQtGWpdLk3tnjOJweNsQ13Gk
 oRSpYKQlhjiUIEBmGwhUoQI3MQsIFXyhBeiGWSFc=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4124oB64003566
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 1 Feb 2024 22:50:11 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 22:50:11 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 22:50:11 -0600
Received: from [10.249.129.226] ([10.249.129.226])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4124o5P6004602;
 Thu, 1 Feb 2024 22:50:07 -0600
Message-ID: <c563a375-7d45-409d-aa4a-3ca770168550@ti.com>
Date: Fri, 2 Feb 2024 10:20:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] misc: fs-loader: Use fw_storage_interface instead of
 storage_interface
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>, Sean Anderson <seanga2@gmail.com>,
 Qu Wenruo <wqu@suse.com>, Michal Simek <michal.simek@amd.com>, Simon Glass
 <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>
References: <20240130062627.2344282-1-danishanwar@ti.com>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240130062627.2344282-1-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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



On 1/30/2024 11:56 AM, MD Danish Anwar wrote:
> The fs-loader driver reads env storage_interface and uses it to load
> firmware file into memory using the medium set by env. Update the driver
> to use env fw_storage_interface as this variable is only used to load
> firmwares. The env storage_interface will act as fallback so that the
> existing implementations do not break.
>
> Also update the FS Loader documentation accordingly.
>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
> Changes from v3 to v4:
> *) No functional change. Splitted the patch out of the series as suggested
>    by Nishant.
> *) Droppped the RFC tag.
>
> v3: https://lore.kernel.org/all/20240124064930.1787929-3-danishanwar@ti.com/

Acked-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
