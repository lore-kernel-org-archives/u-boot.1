Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163DBCA0FEC
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 17:39:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 674DE8522C;
	Fri,  1 Sep 2023 19:39:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rZhWKX4m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24FE08619A; Fri,  1 Sep 2023 19:39:30 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F93F81FA8
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 19:39:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 381HdICw118885;
 Fri, 1 Sep 2023 12:39:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693589958;
 bh=b31iOOhlnfWpAGapHUIaHkytBxYpDn1DsbDZ9dBmtZg=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=rZhWKX4mocoUSHXDg8oknE+A+iBnPc2VzEMThFUdKJQGyBkP9Kuu68G1/vLcZqugW
 +SAd46EJP82+sgn1eaT0kyFdtx2fKNsOSaYQfLDNmWPYkRFS4N7VXXi23qAJX57Kq7
 LyprNTQO1g7u+vpUVJRJVya0oZdbmPzGqJ8zEmdI=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 381HdIVr070688
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 1 Sep 2023 12:39:18 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Sep 2023 12:39:18 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Sep 2023 12:39:18 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 381HdIN5109836;
 Fri, 1 Sep 2023 12:39:18 -0500
Date: Fri, 1 Sep 2023 12:39:18 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v3 3/6] k3-j721s2: Sync from Linux tag v6.5-rc1
Message-ID: <20230901173918.l7vrojbxpyetfzdi@snare>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v3-0-fd6602912536@ti.com>
 <20230816-b4-upstream-j721s2-r5-pinmux-v3-3-fd6602912536@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230816-b4-upstream-j721s2-r5-pinmux-v3-3-fd6602912536@ti.com>
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

On 12:32-20230901, Manorit Chawdhry wrote:
> The following commit syncs the device tree from Linux tag
> v6.5-rc1 to U-boot and fixes the following to be compatible with
> the future syncs -
> 
> - Include k3-j721s2-common-proc-board.dts file
> 
>     Remove the duplicated pinmuxes from r5 and -u-boot.dtsi files and
>     include k3-j721s2-common-proc-board.dts for Linux fixes to propagate
>     to U-boot.
> 
> - Fixing the mcu_timer0
> 
>     Remove timer0 and use the mcu_timer0 defined in mcu-wakeup.dtsi
> 
>     The device manager is not functional at this point so we can't
>     configure the clocks for the mcu_timer0, delete the properties
>     that enable the clocks and power domains for it.
> 
> - Fixing secure proxy nodes
> 
>     Linux DT now have these nodes defined so remove them and rename to
>     use the Linux DT ones.
> 
> - Remove cpsw node
> 
>     The compatible is now fixed and the node is not required in
>     -u-boot specifically
> 
> - Remove aliases and chosen node
> 
>     Use these from Linux and don't override when not required.
> 
> - Remove /delete-property/ from sdhci nodes
> 
>     We have the necessary clock and dev data so remove these.
> 
> - Remove dummy_clocks and fs_loader0
> 
>     These weren't being used anywhere so remove it.
> 
> All these have been put in a single commit to not break the
> bisectability.
> 
> Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---

Thank you for cleaning this up.

Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
