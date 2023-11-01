Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16DDC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 15:37:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EE4387747;
	Wed,  1 Nov 2023 16:37:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fvATe4fc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76FB687744; Wed,  1 Nov 2023 16:37:06 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 566D487AD4
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 16:37:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A1Fau6F080420;
 Wed, 1 Nov 2023 10:36:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698853016;
 bh=/f/5rin7ZBQwvdeWV7I66GQP9Zl75KQO4UBUXC/RbCs=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=fvATe4fc5cpcnI1CHNMwwqPCKmI6vbkXv0L1mSp61xDAkRi8Qmy2ymXMuQYp3YNha
 5o1b9jia2lVyQ8qVLcyZP7su7YspRM5N8jHcZac3Vl9Bv7n5V2DawCdmja9dTkSLii
 01HxuYhhdkvoh7qCPz/QHlZaKNivHOsugaownXBg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A1FaumG028574
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 1 Nov 2023 10:36:56 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 1
 Nov 2023 10:36:56 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 1 Nov 2023 10:36:55 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A1Fat42067798;
 Wed, 1 Nov 2023 10:36:55 -0500
Date: Wed, 1 Nov 2023 10:36:55 -0500
From: Nishanth Menon <nm@ti.com>
To: Nitin Yadav <n-yadav@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <praneeth@ti.com>
Subject: Re: [PATCH 0/6] Add AM62SIP SK support
Message-ID: <20231101153655.g7knu5i3ojojdygp@overplay>
References: <20231031132809.1524341-1-n-yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231031132809.1524341-1-n-yadav@ti.com>
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

On 18:58-20231031, Nitin Yadav wrote:
> This series adds support of AM62SIP SK board. The AM62SIP SK
> is different from AM62x SK in terms of DDR Memory size which
> is reduced to 512 M and embedded as part of SoC.
> 
> Note:
>  - Please apply this series after applying AM62x LP SK support series.
>    (https://lore.kernel.org/all/20231030110138.1347603-1-n-yadav@ti.com/)
>  - The link provided in board documentaion will be active at
>    later point. (https://www.ti.com/tool/SK-AM62-SIP)
> 
> Nitin Yadav (6):
>   arm: dts: k3-am62x-sip-ddr-lp4-50-800: Add DDR configuration for
>     AM62-SIP
>   ram: k3-ddrss: k3-ddrss: Fix updating ddr size with ecc off
>   board: ti: am62x: Avoid overwriting reserve mem for AM62 SIP
>   arm: dts: Add support for AM62x SIP SKEVM at R5 SPL
>   board: ti: am62x: Add am62xsip_sk_r5.config defconfig fragment
>   doc: ti: Add AM62SIP SK Board information
> 
>  arch/arm/dts/Makefile                         |    1 +
>  arch/arm/dts/k3-am62sip-r5-sk.dts             |   23 +
>  arch/arm/dts/k3-am62x-sip-ddr-lp4-50-800.dtsi | 2191 +++++++++++++++++
>  board/ti/am62x/am62xsip_sk_r5.config          |    5 +
>  board/ti/am62x/evm.c                          |   11 +
>  doc/board/ti/am62x_sk.rst                     |    7 +
>  drivers/ram/k3-ddrss/k3-ddrss.c               |    3 -
>  7 files changed, 2238 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/dts/k3-am62sip-r5-sk.dts
>  create mode 100644 arch/arm/dts/k3-am62x-sip-ddr-lp4-50-800.dtsi
>  create mode 100644 board/ti/am62x/am62xsip_sk_r5.config
> 
> -- 
> 2.25.1
> 

How about we fix existing SoCs before considering new ones:

Both AM654 and AM62A need DT-sync:
https://gist.github.com/nmenon/a86f1384e62df1359d8da1cd42b5d4ad

Please consider my NAK to new SoCs till the existing ones boot at the
very least.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
