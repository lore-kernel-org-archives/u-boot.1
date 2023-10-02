Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70012E784BF
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 15:52:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3EC880842;
	Mon,  2 Oct 2023 17:52:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qWnIiDGc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB71286E06; Mon,  2 Oct 2023 17:52:38 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DFDD80842
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 17:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 392FqP9c054854;
 Mon, 2 Oct 2023 10:52:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696261945;
 bh=beHlTwX+n87LvD5IbsRNb4FnHujcS/b9YAchFl7jD5c=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=qWnIiDGcO8dHJQ0QSW0ifMILAFuF82hb9Cxklesyo82GFoL3gbTOekoCMcP3VAG3+
 bO+vmO8KF8b3TcrMmg1HNTGqjEbfCqPeBFzmmA113KY2oiHJJeupYq1o1MtMjVMc3k
 +IPhrqWKqzUG9xzI6dzkucyGWgxxJtTbXw/Oaz74=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 392FqPRb126920
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 2 Oct 2023 10:52:25 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Oct 2023 10:52:25 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Oct 2023 10:52:25 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 392FqOwp070596;
 Mon, 2 Oct 2023 10:52:24 -0500
Date: Mon, 2 Oct 2023 10:52:24 -0500
From: Nishanth Menon <nm@ti.com>
To: Apurva Nandan <a-nandan@ti.com>
CC: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Neha
 Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, Andrew
 Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya
 <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia
 <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Roger Quadros
 <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph Siemsen
 <ralph.siemsen@linaro.org>, Yanhong Wang <yanhong.wang@starfivetech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v4 07/16] remoteproc: k3-r5: Extend support for R5F
 clusters on J784S4 SoCs
Message-ID: <20231002155224.ya7egwx34abqnz5m@trapeze>
References: <20231001165545.494212-1-a-nandan@ti.com>
 <20231001165545.494212-8-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231001165545.494212-8-a-nandan@ti.com>
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

On 22:25-20231001, Apurva Nandan wrote:
> From: Hari Nagalla <hnagalla@ti.com>
> 
> The K3 J784S4 SoC has four dual-core R5F subsystems, one in MCU
> voltage domain and the other three in MAIN voltage domain. These R5F
> clusters are similar to the R5F clusters in J7200 and J721S2 SoCs.
> 
> Extend support to the R5F clusters for J784S4 with J721S2 compatible
> string.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  drivers/remoteproc/ti_k3_r5f_rproc.c | 2 ++
>  1 file changed, 2 insertions(+)

Would really appreciate if we can keep these remote processors
as a follow on series. Makes the series hard to comprehend.
> 
> diff --git a/drivers/remoteproc/ti_k3_r5f_rproc.c b/drivers/remoteproc/ti_k3_r5f_rproc.c
> index 6f3e12d915..fafbfd778f 100644
> --- a/drivers/remoteproc/ti_k3_r5f_rproc.c
> +++ b/drivers/remoteproc/ti_k3_r5f_rproc.c
> @@ -864,6 +864,7 @@ static const struct udevice_id k3_r5f_rproc_ids[] = {
>  	{ .compatible = "ti,am654-r5f", .data = (ulong)&k3_data, },
>  	{ .compatible = "ti,j721e-r5f", .data = (ulong)&k3_data, },
>  	{ .compatible = "ti,j7200-r5f", .data = (ulong)&j7200_data, },
> +	{ .compatible = "ti,j721s2-r5f", .data = (ulong)&j7200_data, },
>  	{}
>  };
>  
> @@ -901,6 +902,7 @@ static const struct udevice_id k3_r5fss_ids[] = {
>  	{ .compatible = "ti,am654-r5fss"},
>  	{ .compatible = "ti,j721e-r5fss"},
>  	{ .compatible = "ti,j7200-r5fss"},
> +	{ .compatible = "ti,j721s2-r5fss"},
>  	{}
>  };
>  
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
