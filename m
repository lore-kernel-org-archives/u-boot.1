Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97584CD1288
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 06:06:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 142F8881BD;
	Wed,  3 Apr 2024 08:06:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="m2nWhF3I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2794C881C7; Wed,  3 Apr 2024 08:06:08 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D801880E8
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 08:06:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r-gunasekaran@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433660J3055330;
 Wed, 3 Apr 2024 01:06:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712124360;
 bh=dJYKBJTtepdtBHLLa4pr5StGou24o8tHKv5UKsgCVVo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=m2nWhF3IBiVTdu5a0DP8jeh+D4apgnDFY8w9fRg6rQH9IH29xuBC4jFOUKwDMvwIP
 +N3tp0N0/MzCtroAvQUtvpSM7GpMZMpx31cPxNc6/aU1s5Ke9RY7U4/z6/yfgDLPsg
 MOKMjhO/5/FilV+5XDazQAHt68jWHVIJydIfrYc0=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433660dV121858
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Apr 2024 01:06:00 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 01:06:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 01:06:00 -0500
Received: from [172.24.227.88] (uda0500640.dhcp.ti.com [172.24.227.88])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43365o6e116545;
 Wed, 3 Apr 2024 01:05:52 -0500
Message-ID: <adbb0d7d-7f11-a6e8-9a36-393d95984b4b@ti.com>
Date: Wed, 3 Apr 2024 11:35:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 5/5] net: ti: icssg: Add support sending FDB command to
 update rx_flow_id
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Maxime Ripard <mripard@kernel.org>, Nishanth Menon
 <nm@ti.com>, Roger Quadros <rogerq@kernel.org>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Devarsh Thakkar <devarsht@ti.com>, Aradhya
 Bhatia <a-bhatia1@ti.com>,
 Nikhil M Jain <n-jain1@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Manorit
 Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, Ramon Fried
 <rfried.dev@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>
References: <20240327052841.1692469-1-danishanwar@ti.com>
 <20240327052841.1692469-6-danishanwar@ti.com>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240327052841.1692469-6-danishanwar@ti.com>
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



On 3/27/24 10:58 AM, MD Danish Anwar wrote:
> ICSSG firmware supports FDB commands. Add support to send FDB commands
> from driver. Once rx_flow_id is obtained from dma, let firmware know that
> we are using this rx_flow_id by sending a FDB command.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  drivers/net/ti/icssg_config.c | 68 +++++++++++++++++++++++++++++++++++
>  drivers/net/ti/icssg_config.h | 18 ++++++++++
>  drivers/net/ti/icssg_prueth.c |  6 ++++
>  drivers/net/ti/icssg_prueth.h |  6 ++++
>  4 files changed, 98 insertions(+)
> 

Reviewed-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

-- 
Regards,
Ravi
