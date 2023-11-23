Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C16C624B4
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 16:25:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1A6087617;
	Thu, 23 Nov 2023 17:25:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="J5A/sDxh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E637C875E9; Thu, 23 Nov 2023 17:25:16 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 259EB84956
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 17:25:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ANGPAa0046655;
 Thu, 23 Nov 2023 10:25:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700756710;
 bh=EAYms088EqTPddJNE2nI87DBYmHO25GsxKi5v7I1N+Q=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=J5A/sDxhs1Bh/corLghIFs93L6V7ot4+Yu+evzujcNezTO6U3G9oAC8ndaXNvwNw1
 6rRHIctjr5dr8zjurOtawUO9lEWB2+kRSJ5NosKkT8ooUijmVUGDQRn4HyTsruTSm1
 jz9sprZF28nRJwGDonr3WC6FbIiP7BHv5U47vGgo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ANGPARE001733
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 23 Nov 2023 10:25:10 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 Nov 2023 10:25:09 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 Nov 2023 10:25:09 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ANGP9wk032733;
 Thu, 23 Nov 2023 10:25:09 -0600
Date: Thu, 23 Nov 2023 10:25:09 -0600
From: Nishanth Menon <nm@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v2] arm: mach-k3: Let the compiler size the mem_map lists
Message-ID: <20231123162509.oug7dyhnkrd54ylc@glove>
References: <20231122211218.607757-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231122211218.607757-1-afd@ti.com>
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

On 15:12-20231122, Andrew Davis wrote:
> NR_MMU_REGIONS is a copy/paste from another platform that extends
> this list later. We do not do that, so let the list be the size
> of the initializer list.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
> 
> Changes for v2:
>  - Made same change for plats now in -next
> 

Reviewed-by: Nishanth Menon <nm@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>

j721e-idk-gw
am68_sk-fs
j721s2-evm
j721e-sk
j7200-hsevm
j7200-evm
am64xx-hsevm
am64xx_sk-fs
beagleplay-gp-uart
am62xx_sk-fs
am62xx-sk
am62axx_sk-fs

Though, I'd prefer this along with:
https://lore.kernel.org/all/20231122151411.11268-1-afd@ti.com/ be merged
in a single shot. I will reply to the other patch series. That one is
correct and should be the manner to remove board dependencies from MMU
table map.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
