Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C59C47DDB
	for <u-boot@archiver.kernel.org>; Tue, 23 Jan 2024 20:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6079887A23;
	Tue, 23 Jan 2024 21:57:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PUTrCc8b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A95F687D47; Tue, 23 Jan 2024 21:57:26 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72FD5879FB
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 21:57:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NKvLht039501;
 Tue, 23 Jan 2024 14:57:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706043441;
 bh=L0VxVf157Ft5MMi0MsOtvLCKqOgg67WXWl37UPKIC8A=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=PUTrCc8bh1ZpdVZK7E4IuFxvl/OGt+ufF1srMVVnVyrG7UC7nI9lZ/kJILxqina0Z
 73RTAmK/7yyhWweElWaBxRcLNfgUKmfSLqwqNHBjO2xnVfiWo9cSuyNw/2yPrSXAgV
 GsCeXAAwfX8OlBJ66UQxADfHnfVFGVKo37cqrVFQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NKvKa1031888
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 23 Jan 2024 14:57:20 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 14:57:20 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 14:57:20 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NKvKaB079710;
 Tue, 23 Jan 2024 14:57:20 -0600
Date: Tue, 23 Jan 2024 14:57:20 -0600
From: Nishanth Menon <nm@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <trini@konsulko.com>,
 <sjg@chromium.org>, <afd@ti.com>, <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, <dannenberg@ti.com>, <srk@ti.com>
Subject: Re: [PATCH 07/10] arm: mach-k3: am625_init: Probe AM65 CPSW NUSS
Message-ID: <20240123205720.vqfua5i2qkfuryms@flatness>
References: <20240112064759.1801600-1-s-vadapalli@ti.com>
 <20240112064759.1801600-8-s-vadapalli@ti.com>
 <20240112123055.5h3qio3w55godccy@gallstone>
 <1c0040f2-0113-4580-9af7-510d9320407b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1c0040f2-0113-4580-9af7-510d9320407b@ti.com>
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

On 15:49-20240122, Chintan Vankar wrote:
> 
> On 12/01/24 18:00, Nishanth Menon wrote:
> > On 12:17-20240112, Siddharth Vadapalli wrote:
> > > From: Kishon Vijay Abraham I <kishon@ti.com>
> > > 
> > > In order to support Ethernet boot on AM62x, probe AM65 CPSW NUSS driver
> > > in board_init_f().
> > Why? doesn't the DM framework handle this?

> Can you suggest how can we do this ?

Did'nt you guys  just discuss this in
https://lore.kernel.org/all/48c63fc4-9f06-4066-b206-a0a548936dcd@ti.com/
?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
