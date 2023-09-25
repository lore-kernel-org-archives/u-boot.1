Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1EECE7A81
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 13:42:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 88DDB86C56;
	Mon, 25 Sep 2023 15:42:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="e80wACHb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B941386C71; Mon, 25 Sep 2023 15:42:31 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8194F86B2E
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 15:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38PDgRTW047828;
 Mon, 25 Sep 2023 08:42:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695649347;
 bh=usP2L26LDjn3EzDLImlDi67QkIKdTG9joJZrgErCIAg=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=e80wACHbLTgtaAj2jlV3nd66YV2BhQ830aT1JKajR7SM4mxBkOj3oNUcDzYUOywmz
 SSuUGd65K5+InDvFfrzFp8yqPCOXXeBrSXd7urv6l16t2odjMenFApUw6YiOrtbdtq
 NO5iTXQ0LOkCk8dc4sRJAW2pcNxH8zyy4xi0uAfs=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38PDgRMl000780
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 25 Sep 2023 08:42:27 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Sep 2023 08:42:27 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Sep 2023 08:42:26 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38PDgQBO006893;
 Mon, 25 Sep 2023 08:42:26 -0500
Date: Mon, 25 Sep 2023 08:42:26 -0500
From: Nishanth Menon <nm@ti.com>
To: Keerthy <j-keerthy@ti.com>
CC: <trini@konsulko.com>, <u-kumar1@ti.com>, <u-boot@lists.denx.de>,
 <vigneshr@ti.com>
Subject: Re: [PATCH 0/2] arm64: ti: k3-j7: Add the ESM nodes
Message-ID: <20230925134226.3kx5eco6vmmn542n@palace>
References: <20230925132614.3747-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230925132614.3747-1-j-keerthy@ti.com>
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

On 18:56-20230925, Keerthy wrote:
> Hi Tom,
> 
> https://lore.kernel.org/linux-arm-kernel/5187c590-ee9a-4c46-b326-655f4c371aaf@linaro.org/T/#me178708007a6b3b9695ae0ff84475fa4f49f283c
> 
> I have posted the ESM patches to the linux kernel device tree mailing
> list. These are neeeded in R5 SPL to enable watchdog support.
> 
> 
> Keerthy (2):
>   arm64: dts: ti: k3-j721s2: Add ESM instances
>   arm64: dts: ti: k3-j7200: Add MCU domain ESM instance
> 
>  arch/arm/dts/k3-j7200-mcu-wakeup.dtsi  |  7 +++++++
>  arch/arm/dts/k3-j721s2-main.dtsi       |  7 +++++++
>  arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi | 14 ++++++++++++++
>  3 files changed, 28 insertions(+)

Get this as part of kernel dt sync.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
