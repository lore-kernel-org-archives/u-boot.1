Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492E2C3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 14:10:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC34B884E2;
	Wed, 17 Jul 2024 16:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="g1sUsLhG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 670EE88A34; Wed, 17 Jul 2024 16:10:29 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AD9C8800C
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 16:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46HEAJmK011833;
 Wed, 17 Jul 2024 09:10:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1721225419;
 bh=FzyvriWcOh2Js37fT14+XA2l8OJeruoT6NhpGtgyhu0=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=g1sUsLhGl01iRTlicE0AJX6SawfOkswpztjbcqQNvy4Ge05zNU1GR9cRppMmUM3wq
 6NO0Aq0ACn34CPCrQ522iueofg6bJif+e97ZCsdhSPjwRxt4JlC+TtnWjYazJM18pu
 EJoFIStVRaBbDiw8GW0GaA3GhbeY3L2YsQq8XN+Y=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46HEAJL1046074
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 17 Jul 2024 09:10:19 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Jul 2024 09:10:19 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Jul 2024 09:10:19 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46HEAJFf065162;
 Wed, 17 Jul 2024 09:10:19 -0500
Date: Wed, 17 Jul 2024 09:10:19 -0500
From: Nishanth Menon <nm@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: "Kumar, Udit" <u-kumar1@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <j-humphreys@ti.com>,
 <marcel.ziswiler@toradex.com>, <vigneshr@ti.com>, <b-padhi@ti.com>
Subject: Re: [PATCH] configs: j784s4_evm : Increase Dynamic memory allocation
 size
Message-ID: <20240717141019.xy2rjdnlukh542d6@eternity>
References: <20240715174301.2688466-1-u-kumar1@ti.com>
 <20240716200555.GC85916@francesco-nb>
 <ddef3081-76a2-4985-bc47-9a18bcd7ed93@ti.com>
 <20240717073342.GA3312@francesco-nb>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240717073342.GA3312@francesco-nb>
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

On 09:33-20240717, Francesco Dolcini wrote:
> Hello,
> 
> On Wed, Jul 17, 2024 at 09:40:11AM +0530, Kumar, Udit wrote:
> > On 7/17/2024 1:35 AM, Francesco Dolcini wrote:
> > > On Mon, Jul 15, 2024 at 11:13:01PM +0530, Udit Kumar wrote:
> > > > Increase malloc size to 32 MB to align with other J7
> > > > family devices.
> > > Is this needed for any specific reason? I am asking to understand if
> > > other boards using the same SOC should be updated to prevent
> > > $random_issue.
> > Since DFU is not supported yet in mainline u-boot, so I avoided to mention
> > that failure.
> > 
> > Also this change is generic, so i thought of pushing it now instead of
> > waiting for DFU series.
> 
> Thanks for the update, on our board DFU works fine on our j784s4 based
> board (UUU or UMS are not working, but this is off topic for this
> conversation ;-)

I still think your comment is valid - commit message does need to
explain something like "make space for future standard features such as
DFU etc.."

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
