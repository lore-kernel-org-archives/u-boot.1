Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80183C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 15:40:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A38F88798F;
	Fri, 12 Jan 2024 16:40:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Eo6GOpWB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21AF4879C3; Fri, 12 Jan 2024 16:40:24 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC07C87980
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 16:40:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40CFe7Ki038965;
 Fri, 12 Jan 2024 09:40:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705074007;
 bh=rAxoHK3mKqkfnXx8S7T8xMKDdWz00sz9K+f1H9lNwVo=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Eo6GOpWBwh7bf0CQ5WSVYGoXSIinyNUZmdDpOsuuAMvuqfE0iBu9ie+f9jRjewAy8
 Ez6dPGDzKpY1OzK6768H44wg1H0o6Ph6VeGa+BqCKRWQeqAUcAGdrTqfj230UCvhbA
 VVFlkFg4T3x95IdDU2+gKwBWvwI+PZ1u4fnJc4Q4=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40CFe77O065880
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 12 Jan 2024 09:40:07 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jan 2024 09:40:07 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jan 2024 09:40:06 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40CFe6jm002959;
 Fri, 12 Jan 2024 09:40:06 -0600
Date: Fri, 12 Jan 2024 09:40:06 -0600
From: Nishanth Menon <nm@ti.com>
To: Sjoerd Simons <sjoerd@collabora.com>
CC: <u-boot@lists.denx.de>, Martyn Welch <martyn.welch@collabora.com>, "Roger
 Quadros" <rogerq@kernel.org>, Andrew Davis <afd@ti.com>, Dave Gerlach
 <d-gerlach@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 "Nikhil M Jain" <n-jain1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>
Subject: Re: [PATCH v4 5/7] configs: am62x_evm_*: Enable USB and DFU support
Message-ID: <20240112154006.eywtthszzbzz3uj5@makeshift>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-6-sjoerd@collabora.com>
 <20240112123738.v76kpf6bfngtc2kr@zigzagged>
 <a1553b40223d017dc6cc03f35be9b8e07f813b0b.camel@collabora.com>
 <20240112131913.s6tc7wqgvjmflxpy@lyrically>
 <2bf954654a89c9e939dc27dca772fe57ea0077bf.camel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2bf954654a89c9e939dc27dca772fe57ea0077bf.camel@collabora.com>
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

On 16:06-20240112, Sjoerd Simons wrote:
[...]
> > 
> > I am starting to wonder if
> > https://lore.kernel.org/u-boot/20231101170519.39627-1-afd@ti.com/
> > will help us here.
> 
> Yes absolutely that would be perfect. Can i suggest we land it as is
> for now ("fat monolithic config") and once those patches land i'm happy
> to split things up? 
> 

https://libera.irclog.whitequark.org/u-boot/2024-01-12#35590530 I think
Tom agrees in principle (and Simon already acked), so we could go down
this road and refactor - I am always a bit squeamish about redoing work
if the baseline changes or has a reasonable chance of change.. Just
doing it once and cleanly is my preference.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
