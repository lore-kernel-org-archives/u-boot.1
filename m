Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64480C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 20:33:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCF6D8716E;
	Mon, 13 Nov 2023 21:33:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="frwbLqaK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2304A87185; Mon, 13 Nov 2023 21:33:54 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A77A286940
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 21:33:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ADKXlH5120358;
 Mon, 13 Nov 2023 14:33:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699907627;
 bh=FEBs3NARKNkMlzkm++Mi7nNJR2BCOyCOZDs161Ll9KE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=frwbLqaKvZ0rAZx86uGydPA6/m2Ur4BUPiNj059Mrk5zZpFzHJadw+GrT38VfKjYU
 VcIWeADPy0z49EIjCIfHhWwg1xAJsxodEJu5dweJ0IjAOd1rqQAxwVMnN3RmugrPRs
 Mbon8C2PnOiAJ6e4xDsOy1IsQ7h6rOXK3aGYaaQg=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ADKXlAB016741
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 13 Nov 2023 14:33:47 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 Nov 2023 14:33:47 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 Nov 2023 14:33:47 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ADKXlSR014525;
 Mon, 13 Nov 2023 14:33:47 -0600
Date: Mon, 13 Nov 2023 14:33:47 -0600
From: Nishanth Menon <nm@ti.com>
To: Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>
CC: Andrew Davis <afd@ti.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, Joao Paulo Goncalves <joao.goncalves@toradex.com>
Subject: Re: [PATCH 1/1] arm: k3: Enable instruction cache for main domain SPL
Message-ID: <20231113203347.kxrerzedrpnyqyvt@buckle>
References: <20231113190721.1841748-1-jpaulo.silvagoncalves@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231113190721.1841748-1-jpaulo.silvagoncalves@gmail.com>
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

On 16:07-20231113, Joao Paulo Goncalves wrote:
> From: Joao Paulo Goncalves <joao.goncalves@toradex.com>
> 
> Change spl_enable_dcache so it also enable icache on SPL
> initialization for the main domain part of the boot flow. This
> improves bootloader booting time.
> 
> Link: https://lore.kernel.org/all/20231109140958.1093235-1-joao.goncalves@toradex.com/
> Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
> ---

Tested-by: Nishanth Menon <nm@ti.com>
https://gist.github.com/nmenon/ee47a34d6b581916d6fba164617ea93b

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
