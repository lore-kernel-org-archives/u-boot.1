Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16335C54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 15:48:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 369BD83108;
	Thu, 22 May 2025 17:48:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UpQiCgZ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90F218312E; Thu, 22 May 2025 17:48:38 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03FA2830F4
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 17:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54MFmXQF1852842;
 Thu, 22 May 2025 10:48:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747928913;
 bh=3xK3A+NoOixDsToD0EjvzIEi/7sqy+SUejDQ7ttTzDU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=UpQiCgZ/kogh2WokYJ4/yIq0etPtDnsectveppSf4w8eefBrWJ2RCBZUT3WxjVrW/
 GZQCUictWjpWZN3eCXFXyY3eZldTPdEPRnd5kuZFcTicfBAOzxecsxFO7d8423kPU+
 YqeLhrcIWUi/N309ml6Ws0vHeOLFdpCjzmH9UnLo=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54MFmXGI1574653
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 22 May 2025 10:48:33 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 May 2025 10:48:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 May 2025 10:48:32 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 54MFmWdo683808;
 Thu, 22 May 2025 10:48:32 -0500
Date: Thu, 22 May 2025 10:48:32 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Beleswar Padhi <b-padhi@ti.com>, <afd@ti.com>, <hnagalla@ti.com>,
 <n-francis@ti.com>, <jm@ti.com>, <u-kumar1@ti.com>, <m-shah@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 6/6] DONOTMERGE: arm: dts: k3-j7*-mcu-wakeup: Enable
 split mode for MCU R5
Message-ID: <20250522154832.2phhu7i4e2t5dnrn@mountable>
References: <20250522071828.285462-1-b-padhi@ti.com>
 <20250522071828.285462-7-b-padhi@ti.com>
 <20250522144505.GK100073@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250522144505.GK100073@bill-the-cat>
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

On 08:45-20250522, Tom Rini wrote:
> On Thu, May 22, 2025 at 12:48:28PM +0530, Beleswar Padhi wrote:
> 
> > Previously, MCU R5F runs in lockstep mode. Enable split-mode on MCU R5F
> > as the support to shut down core1 and use it for loading other firmware,
> > while DM runs on core0, has been added.
> > 
> > Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
> > ---
> >  dts/upstream/src/arm64/ti/k3-j7200-mcu-wakeup.dtsi              | 2 +-
> >  dts/upstream/src/arm64/ti/k3-j721e-mcu-wakeup.dtsi              | 2 +-
> >  dts/upstream/src/arm64/ti/k3-j721s2-mcu-wakeup.dtsi             | 2 +-
> >  .../src/arm64/ti/k3-j784s4-j742s2-mcu-wakeup-common.dtsi        | 2 +-
> >  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> Please don't post DONOTMERGE patches. If the series can be applied
> without this patch, because the functionality is backwards compatible
> put these changes in the cover letter or link to a gist or similar to
> show how to test the changes locally. If the series can't be merged
> until the DTS changes are ready too, please mark the whole thing as RFC.
> For clarity, what is the case with this series?

While I appreciate the energy to get upstream,
<vent>
I think this habit of jumping ahead of kernel should be
stopped.
https://lore.kernel.org/all/20250522073426.329344-1-b-padhi@ti.com/ was
posted, but not reviewed or accepted. I understand that there is a
latency in picking things up in upstream kernel, but creating churn is
not the right way of doing things. It took us an year+ to get
OF_UPSTREAM settled down. At least wait for kernel maintainers to queue
things up before attempting to sync u-boot with non-mainlined patches.
</vent>


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
