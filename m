Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C4F6C27C6E
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 12:02:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 000FF882B7;
	Fri, 14 Jun 2024 14:02:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WKclg6hD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 808318839F; Fri, 14 Jun 2024 14:02:20 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2475688113
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 14:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45EC2FTR117322;
 Fri, 14 Jun 2024 07:02:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1718366535;
 bh=+vzw+pnrTl3XlIi347ZfTynRDoZSXfF6zerGulyIFg0=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=WKclg6hDGhW5WtO51Dxu109pwooHpXGomyniKNoVrcs4ot3XuFuo20ElX93hYGvK0
 n8QsYfuhcUCJjMz3ltN9b5DI0dR25BBE1YxzlcZwHrQ4ILHmFTVstLrvDP6FOE6PoZ
 wWfb81xJHfJWTn6PR+pvtO95e7gRfBkRsWsDaR54=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45EC2FZU129484
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 14 Jun 2024 07:02:15 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 14
 Jun 2024 07:02:15 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 14 Jun 2024 07:02:15 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45EC2Eed108010;
 Fri, 14 Jun 2024 07:02:15 -0500
Date: Fri, 14 Jun 2024 17:32:14 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishant
 Menon <nm@ti.com>, <c-shilwant@ti.com>, <m-chawdhry@ti.com>,
 <vigneshr@ti.com>, Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH V2] arm: dts: k3-am625-beagleplay: Add symlinks for boot
 binaries
Message-ID: <20240614120214.2nu25zwnxujlg4iq@dhruva>
References: <20240614115340.4091211-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240614115340.4091211-1-d-gole@ti.com>
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

On Jun 14, 2024 at 17:23:40 +0530, Dhruva Gole wrote:
> Add symlinks for tiboot3.bin, tispl.bin & u-boot.img because a user has to
> anyway rename these files to get the platform to boot up.
> This just makes it more intuitive and convenient.
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
> 
> Changes:
> Add symlink for u-boot.img as well as per Manorit's suggestion.
> 
> Link to prev. patch:
> https://lore.kernel.org/u-boot/20240614084052.4029849-1-d-gole@ti.com/
> 
> Cc: Manorit Chawdhry <m-chawdhry@ti.com>
> Cc: Nishant Menon <nm@ti.com>
> Cc: Robert Nelson <robertcnelson@gmail.com>
>  [...]

NAK.
Please do not apply this patch, it seems that u-boot.img file didn't
need a symlink in the first place as it was getting generated without a
symlink. I am not sure why u-boot.img is special in this regard but
tispl and tiboot3 still require the symlinks. I'll resend the first
correct patch again.

Please excuse the noise.

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
