Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A22CA0FEB
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 17:33:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A17A865DE;
	Fri,  1 Sep 2023 19:33:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="yEnWsgpE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FBBE866AA; Fri,  1 Sep 2023 19:33:50 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D2868074B
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 19:33:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 381HXjME117461;
 Fri, 1 Sep 2023 12:33:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693589625;
 bh=qq8jxV8G6k7hD55e1wOrwGfgj+89LJffCtZlBbUvVtA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=yEnWsgpEDxHhlAy6TCjsT93OqKKRtqZldlwtnWVQsqsQQ/frkriBtVFhDa+hhtY5d
 U4WNXW4uzia42dItsAPCfcL7HCCu8DWuQWEuXICITq13+rPIYS47Rq/yGY+sYhu0ia
 8EeF3Cyvk/v7z9KDDEhW4RQ4aWotqxais54ED1Vs=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 381HXjfe002443
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 1 Sep 2023 12:33:45 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Sep 2023 12:33:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Sep 2023 12:33:44 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 381HXiUU112801;
 Fri, 1 Sep 2023 12:33:44 -0500
Date: Fri, 1 Sep 2023 12:33:44 -0500
From: Nishanth Menon <nm@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: <vigneshr@ti.com>, <bb@ti.com>, <sjg@chromium.org>, <peng.fan@nxp.com>,
 <ye.li@nxp.com>, <robimarko@gmail.com>, <u-boot@lists.denx.de>,
 <n-francis@ti.com>
Subject: Re: [PATCH 1/2] thermal: k3-j72xx-bandgap: Add support for vtm
Message-ID: <20230901173344.fw7glgqmed3fm7ua@comfort>
References: <20230901061500.2342452-1-u-kumar1@ti.com>
 <20230901061500.2342452-2-u-kumar1@ti.com>
 <20230901150640.u7nyi3hawwkz3rbs@leverage>
 <f3dfffb4-4a97-be0b-61d8-f0e4761b1714@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f3dfffb4-4a97-be0b-61d8-f0e4761b1714@ti.com>
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

On 22:54-20230901, Kumar, Udit wrote:
> > > +static const struct  udevice_id of_k3_j72xx_bandgap_match[] = {
> > > +	{
> > > +		.compatible = "ti,j721e-vtm",
> > > +		.data = (ulong)&k3_j72xx_bandgap_j721e_data,
> > So what happens to drivers/misc/k3_avs.c ?
> 
> Could you help me to understand this comment.
> 
> Do you mean, why we can not add this support in AVS driver or
> 
> need of this porting ?
> 
> How I see, AVS driver to run at SPL/R5 time and this driver
> 
> to be probed in Main/A72 u-boot when needed.
you are saying the drivers are mutually exclusive - how about detecting
over-temp scenario at R5 boot? switching on A53 will be a mistake at
that point, no?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
