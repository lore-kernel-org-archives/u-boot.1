Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFC7C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 11:47:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AB17885B5;
	Wed, 17 Jul 2024 13:47:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Bs16/Z1D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26472886E7; Wed, 17 Jul 2024 13:47:41 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38F888859B
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 13:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46HBlOPu101110;
 Wed, 17 Jul 2024 06:47:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1721216844;
 bh=ivfCUc0IG1yWExmkshmWACThhw7kE9GQrUbPgVuoRuI=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Bs16/Z1Dh5KlMINbyeha5K3zISO4wdSBeGT8P8l1HiFasEaJvOtg++nUB51qkpWnQ
 cSWL+FYVjE54QB6gKXE2Z0a3RbEKWknuCDaDw2PyX/JW3t7nAZSTlmL2e2uFUvIylj
 m97fyk/4hzxqe+NNWMB6P5Fe2nY8Q4K6q7j9OLLE=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46HBlOiX032480
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 17 Jul 2024 06:47:24 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Jul 2024 06:47:24 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Jul 2024 06:47:24 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46HBlOja119650;
 Wed, 17 Jul 2024 06:47:24 -0500
Date: Wed, 17 Jul 2024 06:47:24 -0500
From: Nishanth Menon <nm@ti.com>
To: Scaria Kochidanadu <s-kochidanadu@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, <sjg@chromium.org>, 
 <mkorpershoek@baylibre.com>, <abdellatif.elkhlifi@arm.com>,
 <sumit.garg@linaro.org>, <neil.armstrong@linaro.org>,
 <caleb.connolly@linaro.org>, <semen.protsenko@linaro.org>,
 <marek.vasut+renesas@mailbox.org>, <nathan.morrison@timesys.com>,
 <devarsht@ti.com>, <j-luthra@ti.com>, <vigneshr@ti.com>,
 <praneeth@ti.com>, <khasim@ti.com>, <rogerq@kernel.org>,
 <francesco.dolcini@toradex.com>, <afd@ti.com>, <jan.kiszka@siemens.com>
Subject: Re: [EXTERNAL] Re: [PATCH 1/6] sound: ti: Add sound support for
 am625 board in Uboot
Message-ID: <20240717114724.fhs4227cdzk2fuve@shove>
References: <20240708075207.37207-1-s-kochidanadu@ti.com>
 <20240708075207.37207-2-s-kochidanadu@ti.com>
 <20240708154656.GE38804@bill-the-cat>
 <16c5d0dc-145c-4d59-bdfb-5a5df170f090@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <16c5d0dc-145c-4d59-bdfb-5a5df170f090@ti.com>
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

On 16:56-20240709, Scaria Kochidanadu wrote:
> I wanted to reuse the sound card DT node in the upstream kernel
> device-tree. The U-boot upstrem repo does not have the node as it is
> using an older version of DT.

Please DONOT do this. migrate to OF_UPSTREAM is it is not done (and as I
recollect I have now spend close to an year getting u-boot TI dts to get
to kernel.org dts and OF_UPSTREAM should now be enabled on master for
am625), so what are you talking about? be specific what node is missing
- contribute upstream kernel to enable the node and then do the changes.


> But if using the simple-audio-card node is not preferred, then can we
> create TI specific compatible and a separate DT node?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
