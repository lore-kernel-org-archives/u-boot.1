Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F71CAC58E
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 05:42:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D0928317B;
	Mon, 15 Sep 2025 07:42:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="c9jgFIpl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECE1383192; Mon, 15 Sep 2025 07:42:45 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCD1483106
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 07:42:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58F5gZYn974987;
 Mon, 15 Sep 2025 00:42:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757914955;
 bh=FuOvpaOoKXCkb6RwoGt24O4WqstRjoy22tA2V1kK6qE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=c9jgFIplv1tgSWXHNgbrgR8WQqidTtsQj2WniRnUiRI4UbfwMDbYHXR37AIffjckK
 rP4ZKKo4ICWflJayGL9shim7e8+pELsI+Pku88UVixlaASN7ikWoziU2URoPnzAW8E
 OjQp3H2TGkiZccoompHoB1GDLjkDVxAnCmqLYci0=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58F5gYtk3728682
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 15 Sep 2025 00:42:34 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 15
 Sep 2025 00:42:34 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 15 Sep 2025 00:42:34 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58F5gWLn3518305;
 Mon, 15 Sep 2025 00:42:33 -0500
Date: Mon, 15 Sep 2025 11:12:32 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Aristo Chen <jj251510319013@gmail.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>, <al.kochet@gmail.com>,
 <paul.henrys_ext@softathome.com>, <bb@ti.com>, <y.moog@phytec.de>,
 <w.egorov@phytec.de>, <francesco.dolcini@toradex.com>,
 <ggiordano@phytec.com>, <n-francis@ti.com>, <afd@ti.com>,
 <d.schultz@phytec.de>, <ravi@prevas.dk>, <carlos.lopezr4096@gmail.com>,
 <quentin.schulz@cherry.de>, <alice.guo@nxp.com>, Aristo Chen
 <aristo.chen@canonical.com>
Subject: Re: [PATCH v2 1/7] binman: Fix typo for the test case name
Message-ID: <20250915054232.ky5s2do4rzlcy6mv@lcpd911>
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20250914110021.4103-2-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250914110021.4103-2-aristo.chen@canonical.com>
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

On Sep 14, 2025 at 10:59:26 +0000, Aristo Chen wrote:
> Fix typo from `Singature` to `Signature`
> 
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> ---
>  tools/binman/ftest.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index a90db3c9351..6ed8b8637cd 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -7986,7 +7986,7 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>              'Node \'/binman/fit\': multiple key paths found',
>              str(e.exception))
>  
> -    def testFitSignNoSingatureNodes(self):
> +    def testFitSignNoSignatureNodes(self):

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
