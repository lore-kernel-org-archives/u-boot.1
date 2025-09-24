Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B35CAC5A5
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 11:43:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D43E1833ED;
	Wed, 24 Sep 2025 13:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xR3NFgng";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D1AD83448; Wed, 24 Sep 2025 13:43:32 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 580EC80B9B
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 13:43:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58OBhIHC1199727;
 Wed, 24 Sep 2025 06:43:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758714198;
 bh=jhZZW8I8/tq9pGvClB6yjieARVh+X9LcV/kuNbZ/uPI=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=xR3NFgngIhloOGZ+p0npTfveNvdQSENn9usOI9L8W/4zeKqoQLSmrCLizd+4A5Zqi
 RMzkqK7TdDIDmLUc4osJKfAs/lKpmfA5FNaC1znfbVBQKKpjxgfCHAFKczWbNRzszE
 cU6f7rPuikzkLn9PSbHdjHLbFGAHPAWpqWVcrek4=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58OBhHnL2725984
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 24 Sep 2025 06:43:17 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 24
 Sep 2025 06:43:17 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 24 Sep 2025 06:43:17 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58OBhH3t1681583;
 Wed, 24 Sep 2025 06:43:17 -0500
Date: Wed, 24 Sep 2025 06:43:17 -0500
From: Nishanth Menon <nm@ti.com>
To: Aristo Chen <jj251510319013@gmail.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <alpernebiyasak@gmail.com>, <al.kochet@gmail.com>,
 <paul.henrys_ext@softathome.com>, <bb@ti.com>, <y.moog@phytec.de>,
 <w.egorov@phytec.de>, <francesco.dolcini@toradex.com>,
 <ggiordano@phytec.com>, <n-francis@ti.com>, <afd@ti.com>,
 <d.schultz@phytec.de>, <d-gole@ti.com>, <ravi@prevas.dk>,
 <carlos.lopezr4096@gmail.com>, <quentin.schulz@cherry.de>,
 <alice.guo@nxp.com>, Aristo Chen <aristo.chen@canonical.com>
Subject: Re: [PATCH v2 0/7] mkimage: Detect FIT image load address overlaps
 and fix related test/DTS issues
Message-ID: <20250924114317.742ae4ntrb4mvuyq@expert>
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20250924113733.uz6hozszbuynemtc@giddy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250924113733.uz6hozszbuynemtc@giddy>
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

On 06:37-20250924, Nishanth Menon wrote:
> On 10:59-20250914, Aristo Chen wrote:
> > This patch series enhances FIT image robustness by adding **memory
> > region overlap detection** to `mkimage` and fixing existing overlaps
> > in DTS files and `binman` tests.

[...]
> > 
> 
> Looks like i see a build regression in linux-next after this series.

I fat fingered that one.. sorry, I meant u-boot next.


Fails at commit 4d84fa1261eb, last pass was on commit d81c1118580f

> 
> https://gist.github.com/nmenon/b2fc9e7680cc296062c7dced94105f76

I  believe there are outstanding comments on V1 that have'nt been
addressed either. Can we revert/drop this series for now while the
comments are addressed?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource
