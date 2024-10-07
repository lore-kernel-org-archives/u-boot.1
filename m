Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4304CFB440
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 11:51:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AAFC889AA;
	Mon,  7 Oct 2024 13:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BmD1joDX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7853588ABF; Mon,  7 Oct 2024 13:51:25 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4406883D4
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 13:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 497BpLqu014903;
 Mon, 7 Oct 2024 06:51:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728301881;
 bh=n2mNlNIxEu/6PGkxyZwqZP42EgKo8reDIM18clGszLY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=BmD1joDXVaP+eQFAeceyVaQo4pxAwM4B83zMa3vRviHhAY1fvFiBgrLF7laG/10IP
 EqpUy86pVkCXRsst7BRXsX+yKefeIRC9qvp8JMyMdSMLzEFqxxqdOsoyreXnuRbs2a
 6NsG5ctpj/x/fR1OFiZzpKkqdwdrNG0cCnFGSa+o=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 497BpLxM028459
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 7 Oct 2024 06:51:21 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Oct 2024 06:51:20 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Oct 2024 06:51:20 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 497BpKGO117644;
 Mon, 7 Oct 2024 06:51:20 -0500
Date: Mon, 7 Oct 2024 06:51:20 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Jaehoon Chung <jh80.chung@samsung.com>, <u-boot@lists.denx.de>, Neha
 Malcom Francis <n-francis@ti.com>, Keerthy J <j-keerthy@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>, Tom Rini
 <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis
 <afd@ti.com>
Subject: Re: [PATCH v4 3/7] arm: dts: k3-j7*-r5: Add MPU clock in clocks
 property
Message-ID: <20241007115120.kvtqmy42vhtxu2qv@create>
References: <20241004-b4-upstream-j721s2-avs-v4-0-6d71c6bab9f4@ti.com>
 <20241004-b4-upstream-j721s2-avs-v4-3-6d71c6bab9f4@ti.com>
 <20241004113001.h4cshh74q2bqfhqj@frolic>
 <20241007054848.ci5tls5wqrozxqnm@uda0497581>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241007054848.ci5tls5wqrozxqnm@uda0497581>
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

On 11:18-20241007, Manorit Chawdhry wrote:
> Hi Nishanth,
> 
> On 06:30-20241004, Nishanth Menon wrote:
> > On 11:54-20241004, Manorit Chawdhry wrote:
> > > MPU clock had been missing. Distinguish multiple clocks with clock-names
> > > and add MPU clock as well.
> > > 
> > > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > 
> > We have been a bit hacky with GTC - do we want to pull it out as a
> > separate IP?
> 
> Could you explain it a bit more..

I was thinking more like GTC as a device node by itself. I am a bit
split about the actual benefit of doing so, though..

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
