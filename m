Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA1FC4332F
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 20:22:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E29287C27;
	Sat, 28 Oct 2023 22:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XRjr2El3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12F1887C27; Sat, 28 Oct 2023 22:22:27 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6BA486EB9
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 22:22:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39SKMHp8075113;
 Sat, 28 Oct 2023 15:22:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698524537;
 bh=zyAoMVStRHEX2lUHNJKZ2M3Ixe+7rFvj77PxX6o2tno=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=XRjr2El3tbs6t8VNqLGmbXEWEEfjzwFXbiEFyk3CDly7wSUI/VOrZKde3bAMVWTw8
 T37D5BlAEiUq2qVdJC8fzfH0Y1ma+kGKbjN984mt/vOqSAkt/KFaU7ltYoNrCEJs9h
 b/WL8sFiYhZtOzdHPNYaxiLVtTQmOzfsBpvbw4mk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39SKMHJl040940
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 28 Oct 2023 15:22:17 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 28
 Oct 2023 15:22:17 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 28 Oct 2023 15:22:17 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39SKMHbt102438;
 Sat, 28 Oct 2023 15:22:17 -0500
Date: Sat, 28 Oct 2023 15:22:17 -0500
From: Nishanth Menon <nm@ti.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
CC: "rogerq@kernel.org" <rogerq@kernel.org>, "trini@konsulko.com"
 <trini@konsulko.com>, "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
 "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>, "vigneshr@ti.com"
 <vigneshr@ti.com>, "srk@ti.com" <srk@ti.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/3] arm: dts: k3-am6: Fix Ethernet/DMA
Message-ID: <20231028202217.7feiiaho67es3eyn@shifting>
References: <20231027134630.244886-1-rogerq@kernel.org>
 <20231027204620.oz5hemkw3wwhh3u6@latter>
 <949fda91000f00565ce88f2db7899bdb6f883623.camel@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <949fda91000f00565ce88f2db7899bdb6f883623.camel@toradex.com>
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

On 08:16-20231028, Marcel Ziswiler wrote:
[..]
> > https://lore.kernel.org/linux-arm-kernel/20230810174356.3322583-1-vigneshr@ti.com/
> > 
> > Marcel, could the Toradex team confirm as well?
> 
> Yes, I just successfully tested it. With what you say above I also assume eventually those properties will move
> to the SoC dtsi rather than having to be separately defined U-Boot-specific in each and every board.
> 

Correct, that is the plan once we get through the maintainers in
upstream kernel.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
