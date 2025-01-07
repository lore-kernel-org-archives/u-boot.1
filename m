Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6DCE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 13:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 519C28007D;
	Tue,  7 Jan 2025 14:42:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oE/2Shz9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47F91801C3; Tue,  7 Jan 2025 14:42:14 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D050D8007D
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 14:42:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 507DfwBI2649822
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 7 Jan 2025 07:41:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1736257318;
 bh=ibXt+IcemzHEu07kyO6o27ykf9xaEWA02twQQUZVkMQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=oE/2Shz9VabAR1lasgCRp5BCdDKHbBhkguI0E72kbfoLEkA7pDF4PQqBghyGSVY5q
 c4EuWr8jxgIad50iBNuaQrNvulsYYbEW5kJBc+2O1WbNagpikbqah2mzSiSNHKj3xc
 H8WIaYRQE3UpNkmDAjEFMJn9vcsMD/olRP7fVYhg=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 507DfwSZ068923;
 Tue, 7 Jan 2025 07:41:58 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 Jan 2025 07:41:57 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 Jan 2025 07:41:57 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 507DfvXA035157;
 Tue, 7 Jan 2025 07:41:57 -0600
Date: Tue, 7 Jan 2025 07:41:57 -0600
From: Bryan Brattlof <bb@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
CC: AKASHI Takahiro <akashi.tkhro@gmail.com>, Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Nishanth Menon <nm@ti.com>, Roger Quadros
 <rogerq@kernel.org>, Hari Nagalla <hnagalla@ti.com>, Jonathan Humphreys
 <j-humphreys@ti.com>, Andreas Dannenberg <dannenberg@ti.com>, Simon Glass
 <sjg@chromium.org>, Jayesh Choudhary <j-choudhary@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Ramon Fried
 <rfried.dev@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Tom
 Rini <trini@konsulko.com>,
 <srk@ti.com>, <s-vadapalli@ti.com>, <danishanwar@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 02/13] arm: mach-k3: j721s2: Update SoC auto-gen data to
 enable Ethernet boot
Message-ID: <20250107134157.joqhjuogmr5hahyc@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250107093840.2211381-1-c-vankar@ti.com>
 <20250107093840.2211381-3-c-vankar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250107093840.2211381-3-c-vankar@ti.com>
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

On January  7, 2025 thus sayeth Chintan Vankar:
> Update dev-data and clk-data generated using ksswtool-autogen to include
> CPSW device which is required for Ethernet Boot, also use ARRAY_SIZE()
> MACRO to avoid hard-coding array size.
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
>  arch/arm/mach-k3/r5/j721s2/clk-data.c | 58 +++++++++++++++++++++++++--
>  arch/arm/mach-k3/r5/j721s2/dev-data.c |  3 +-
>  2 files changed, 57 insertions(+), 4 deletions(-)
> 

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
