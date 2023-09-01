Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C200BCA0FF3
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 19:10:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 735CB85894;
	Fri,  1 Sep 2023 21:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uGFTc3pC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F01D185C98; Fri,  1 Sep 2023 21:10:48 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5567F8477A
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 21:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 381JAgn9019161;
 Fri, 1 Sep 2023 14:10:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693595442;
 bh=SEBw0NOX8BPYhQHWym1hrQjwwdv9ya2JWIUbok31ZbQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=uGFTc3pCSL882SHrN6NZksNeaTPCzYXaojY1vgNq2sba5wUjoWDkNLlLBqz7ziLaB
 wh8HHEaBGOS+kix/iK5PI9w8mUcMpblyG8+Ye59wJSdOv13jLe+R7UYHqc57kRqjIK
 d63fGhYfySpLWaz8lEdT/5kGvknxGw7DUrDKgFRI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 381JAgU2035883
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 1 Sep 2023 14:10:42 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Sep 2023 14:10:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Sep 2023 14:10:42 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 381JAgvd041994;
 Fri, 1 Sep 2023 14:10:42 -0500
Date: Fri, 1 Sep 2023 14:10:42 -0500
From: Nishanth Menon <nm@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: <vigneshr@ti.com>, <bb@ti.com>, <sjg@chromium.org>, <peng.fan@nxp.com>,
 <ye.li@nxp.com>, <robimarko@gmail.com>, <u-boot@lists.denx.de>,
 <n-francis@ti.com>
Subject: Re: [PATCH 1/2] thermal: k3-j72xx-bandgap: Add support for vtm
Message-ID: <20230901191042.7iq2tunocqjxnyh3@paramedic>
References: <20230901061500.2342452-1-u-kumar1@ti.com>
 <20230901061500.2342452-2-u-kumar1@ti.com>
 <20230901150640.u7nyi3hawwkz3rbs@leverage>
 <f3dfffb4-4a97-be0b-61d8-f0e4761b1714@ti.com>
 <20230901173344.fw7glgqmed3fm7ua@comfort>
 <8857fb8f-415b-2b59-585f-d6a3cff9327b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8857fb8f-415b-2b59-585f-d6a3cff9327b@ti.com>
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

On 23:43-20230901, Kumar, Udit wrote:
> 
> On 9/1/2023 11:03 PM, Nishanth Menon wrote:
> > On 22:54-20230901, Kumar, Udit wrote:
> > > > > +static const struct  udevice_id of_k3_j72xx_bandgap_match[] = {
> > > > > +	{
> > > > > +		.compatible = "ti,j721e-vtm",
> > > > > +		.data = (ulong)&k3_j72xx_bandgap_j721e_data,
> > > > So what happens to drivers/misc/k3_avs.c ?
> > > Could you help me to understand this comment.
> > > 
> > > Do you mean, why we can not add this support in AVS driver or
> > > 
> > > need of this porting ?
> > > 
> > > How I see, AVS driver to run at SPL/R5 time and this driver
> > > 
> > > to be probed in Main/A72 u-boot when needed.
> > you are saying the drivers are mutually exclusive - how about detecting
> > over-temp scenario at R5 boot? switching on A53 will be a mistake at
> > that point, no?
> 
> Yes these are  mutually exclusive.
> 
> Let me see, how I can add TSHUT value programming in avs driver to avoid
> above.
> 
> But in case, temperature reading is needed from u-boot shell, we still need
> this code.

One approach might be to merge the two.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
