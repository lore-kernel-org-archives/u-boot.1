Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C553C30658
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 05:47:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6EFD885F7;
	Fri,  5 Jul 2024 07:47:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WyGN1e9f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB2B9885EC; Fri,  5 Jul 2024 07:47:50 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94386882F0
 for <u-boot@lists.denx.de>; Fri,  5 Jul 2024 07:47:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4655ljXC130083;
 Fri, 5 Jul 2024 00:47:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720158465;
 bh=QAnHAZE8opNDXx8ErK/s8qR/ko2kh9qnM/n1Wqbu2dw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=WyGN1e9f8EvWF+KX35340VFnbas7uHbPhZJHFHl6mdFV/2vsGj/uqE9X2VWXx64/1
 KnOPIl5BQz7b/8+ORDF7tH4gtS/bRVLfZfR17M20Uz9rpjslyRK6Q9l3RMcyd0Rxjx
 oQUkfEbvkFCvFQ6n55N8xkSenmOVsoUwJcJc15WU=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4655liIf015898
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 5 Jul 2024 00:47:45 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 5
 Jul 2024 00:47:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 5 Jul 2024 00:47:44 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4655lhX2118246;
 Fri, 5 Jul 2024 00:47:44 -0500
Date: Fri, 5 Jul 2024 11:17:43 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Daniel Schultz <d.schultz@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, <trini@konsulko.com>, 
 <m.othacehe@gmail.com>, <joe.hershberger@ni.com>, <w.egorov@phytec.de>,
 <t.remmet@phytec.de>, <festevam@gmail.com>,
 <mkorpershoek@baylibre.com>, <sjg@chromium.org>
Subject: Re: [PATCH 8/9] board: phytec: phycore_am62x: Use k3_mmc.env logic
Message-ID: <20240705054743.rzsyiofrlmu5farz@dhruva>
References: <20240703054202.2812540-1-d.schultz@phytec.de>
 <20240703054202.2812540-9-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240703054202.2812540-9-d.schultz@phytec.de>
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

On Jul 02, 2024 at 22:42:01 -0700, Daniel Schultz wrote:
> Use our common environment file to implement MMC boot.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---

Reviewed-by: Dhruva Gole <d-gole@ti.com>

>  board/phytec/phycore_am62x/phycore_am62x.env | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
[...]

-- 
Best regards,
Dhruva
