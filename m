Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C5AC4706C
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 20:00:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30FFE87729;
	Tue,  9 Jan 2024 21:00:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JfO8ujmU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C382E877F4; Tue,  9 Jan 2024 21:00:21 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFF9787509
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 21:00:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 409K0FOj019178;
 Tue, 9 Jan 2024 14:00:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704830415;
 bh=RfUrMekcD09O7aydlNQSuZalRL+UiTOMWEfeFj1k9ZA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=JfO8ujmU+vrPGx7bb5+gwybIXM/pq+JJz3L77WFrYmdzxU+X+kH6QLoHIgxtdyLLW
 XDJRU3qAqn0r9awr5OW0k1R+EGzz1/VO+JIVDpMrLGdk5ToIUEa5dUVPVDy6Zljm0I
 LgQiHfaS0GFfmKOU/BGn3bUckmnCLVrhisfTTZIc=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 409K0FUA122147
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 9 Jan 2024 14:00:15 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 9
 Jan 2024 14:00:14 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 9 Jan 2024 14:00:14 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 409K0EWl025156;
 Tue, 9 Jan 2024 14:00:14 -0600
Date: Tue, 9 Jan 2024 14:00:14 -0600
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Roger Quadros <rogerq@kernel.org>, <michael@amarulasolutions.com>,
 <dario.binacchi@amarulasolutions.com>, <afd@ti.com>, <vigneshr@ti.com>,
 <praneeth@ti.com>, <srk@ti.com>, <r-gunasekaran@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 4/4] configs: am64x_evm_a53_defconfig: Enable NAND
Message-ID: <20240109200014.wda3anzu4gljeic6@glitch>
References: <20240109122605.51951-1-rogerq@kernel.org>
 <20240109122605.51951-5-rogerq@kernel.org>
 <20240109191627.jn2b4nsczlsynik2@carpenter>
 <20240109194807.GX1610741@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240109194807.GX1610741@bill-the-cat>
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

On 14:48-20240109, Tom Rini wrote:
[...]
> > > -- 
> > > 2.34.1
> > > 
> > 
> > Why not a config fragment?
> 
> To me, this makes sense to keep in the main config. It can be turned off
> as needed, and at run time if it's not present, it's safe.

Three reasons:
* There is going to be duplication across multiple boards
* It confuses the affair of trying to find the minimal configuration needed
  to boot the board.
* SRAM is limited already - we have been playing all kind of dances
  around this - NAND is a daughter card addon - while I am not trying to
  diminish NAND support, we are in a constant struggle to keep SRAM
  viable and adding additional boot modes to a single config, IMHO is
  the wrong direction to go.


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
