Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AB3CE79AA
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 11:30:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0565B86B34;
	Wed, 20 Sep 2023 13:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="K6hz2c7c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBD8786CE7; Wed, 20 Sep 2023 13:30:35 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C57C86AFA
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 13:30:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38KBUUiX006909;
 Wed, 20 Sep 2023 06:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695209430;
 bh=Z5TtGP+7VfKUhBGtk68MtlVF+XRLMi1ec29x/ZkafcU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=K6hz2c7cLqK2N5jcVfF0lOJUUhFwCAkmUadf6w2JJ/oFv2avNvYyttdmltSzHWk0o
 Gw0G7n7XKrKLatKJMM4H5rCQ91f3tGaAA7xWBI2CVbOrf7/J7Zag4lp9MBS4eV0fq/
 mfzsqjRD8RM4B955tOKpCaMNphcX02jxFA5TnVcw=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38KBUU2i049716
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 20 Sep 2023 06:30:30 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 20
 Sep 2023 06:30:29 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 20 Sep 2023 06:30:29 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38KBUTGB030286;
 Wed, 20 Sep 2023 06:30:29 -0500
Date: Wed, 20 Sep 2023 06:30:29 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Andrew Davis <afd@ti.com>
Subject: Re: [RESEND PATCH v5 4/7] k3-j721s2: Sync from Linux tag v6.6-rc1
Message-ID: <20230920113029.vhul4mldyyahdpfw@abroad>
References: <20230920-b4-upstream-j721s2-r5-pinmux-v5-0-9e0a1c558586@ti.com>
 <20230920-b4-upstream-j721s2-r5-pinmux-v5-4-9e0a1c558586@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230920-b4-upstream-j721s2-r5-pinmux-v5-4-9e0a1c558586@ti.com>
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

On 10:26-20230920, Manorit Chawdhry wrote:
> The following commit syncs the device tree from Linux tag
> v6.6-rc1 to U-boot and fixes the following to be compatible with
> the future syncs -
> 
> - Include k3-j721s2-common-proc-board.dts file
> 
>     Remove the duplicated pinmuxes from r5 and -u-boot.dtsi files and
>     include k3-j721s2-common-proc-board.dts for Linux fixes to propagate
>     to U-boot.
> 

Please fix your $subject arm: dts: k3-j721s2: ....


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
