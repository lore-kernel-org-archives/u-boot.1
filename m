Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4853D3B7DB
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 05:24:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AEE7899BF;
	Mon, 25 Nov 2024 06:24:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fJKNFpVF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3307899C0; Mon, 25 Nov 2024 06:24:16 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DA0989987
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 06:24:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AP5O2T7607515
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 24 Nov 2024 23:24:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732512242;
 bh=hEGdap0d9D12CxsuxYRbYfeoUMskEjkBWm+sF9sE9nY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=fJKNFpVFm1AadfTb6ToPJj2AnAunHak21v2a138kZL7u7eKElVVMVmpn0BQmcvzWJ
 nsyW/awd4RXMjYJRB3UoGq+eGxWS8SG1ZjDdIeHvr5ffeK5DuIwo5shCn8u9AC4+cE
 M9eClMtCFCjoswpDT3bzxaV26NIkWViG/TTdmup4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AP5O2CE114965
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 24 Nov 2024 23:24:02 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 24
 Nov 2024 23:24:01 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 24 Nov 2024 23:24:02 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AP5O05v009257;
 Sun, 24 Nov 2024 23:24:01 -0600
Date: Mon, 25 Nov 2024 10:54:00 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, 
 <trini@konsulko.com>, <j-humphreys@ti.com>, <m-chawdhry@ti.com>,
 <rogerq@kernel.org>, <nm@ti.com>, <sjg@chromium.org>,
 <devarsht@ti.com>, <ilias.apalodimas@linaro.org>, <afd@ti.com>,
 <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH v2 2/5] board: ti: j721e: evm: Set "dfu_alt_info" only if
 interface is Serial Flash
Message-ID: <lt53akzinsojp7fygqwzz7esfpqldumxissn4ywfde4rovmxqn@uikqgyrr5uot>
References: <20241124070828.617558-1-s-vadapalli@ti.com>
 <20241124070828.617558-3-s-vadapalli@ti.com>
 <2ee7f723-3744-471e-a94b-701d544fb5a4@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2ee7f723-3744-471e-a94b-701d544fb5a4@ti.com>
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

On Mon, Nov 25, 2024 at 09:27:08AM +0530, Kumar, Udit wrote:
> Hi Siddharth

Hello Udit,

> 
> On 11/24/2024 12:37 PM, Siddharth Vadapalli wrote:
> > Commit 9bd6cc292fa8 ("board: j721e: Define capsule update firmware info")
> > updated the "dfu_alt_info" variable to support use-cases with Serial Flash.
> > However, this breaks use-cases where interface is not Serial Flash ("sf").
> > Fix this by setting "dfu_alt_info" only when the interface is "sf".
> 
> 
> I am not sure, if we are on same page.
> 
> Setting this dfu_alt_info on shell works for me
> 
> https://gist.github.com/uditkumarti/e5185838bcc32b47f5d9dae48eff72c9

The fix is for DFU Boot i.e. loading tiboot3.bin, tispl.bin and
u-boot.img via USB DFU Boot. Please refer to the cover letter for
details on the issue observed when attempting to boot AM625-SK via USB
DFU Boot.

Regards,
Siddharth.
