Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32378EE14D6
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 19:30:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AFC9868D7;
	Wed,  6 Sep 2023 21:30:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Hk4BAxkp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0277386940; Wed,  6 Sep 2023 21:30:00 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FD048655E
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 21:29:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=reidt@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 386JTtdW008303;
 Wed, 6 Sep 2023 14:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694028595;
 bh=j5TwOHgQLW2yv8Br7jIRkXeb72y4kDh3sB21cgXfBIQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Hk4BAxkpjc5VmHgS6w54Td+bklPzElWiKA8TpUamg36nHHfvVE9/FaD+VyF3P+96o
 A4NupEP9Mzu+S8h5G+TOaIm5vfPDboWF+RXK0LW9YkZUiZYIACoD1SCTTqALZQknRb
 bndHTOsPtMhLkV2rYXMn+jsi/ZKhCkKy59zawkLo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 386JTt7v051208
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Sep 2023 14:29:55 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Sep 2023 14:29:55 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Sep 2023 14:29:55 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 386JTsYQ037389;
 Wed, 6 Sep 2023 14:29:54 -0500
Date: Wed, 6 Sep 2023 14:29:54 -0500
From: reidt <reidt@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <n-francis@ti.com>,
 <u-kumar1@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>
Subject: Re: [PATCH 2/3] arm: mach-k3: j7200: Add mcu_timer0 id to the dev list
Message-ID: <20230906192954.kznmhemlwpep65av@reidt-HP-Z2>
References: <20230905181309.61666-1-reidt@ti.com>
 <20230905181309.61666-3-reidt@ti.com>
 <20230906180725.dscmjxv5tkets4t5@police>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230906180725.dscmjxv5tkets4t5@police>
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

On 13:07-20230906, Nishanth Menon wrote:
> On 13:13-20230905, Reid Tonking wrote:
> > mcu_timer0 is now used as the tick timer in u-boot, so this adds the
> > timer to the soc device list so it can be enabled via the k3 power 
> 
> Drop the trailing whitespace.
> 
> > controller.
> > 
> > Signed-off-by: Reid Tonking <reidt@ti.com>
> 
> with that:
> 
> Reviewed-by: Nishanth Menon <nm@ti.com>
>

will do, thanks for the review!

> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

Thanks,
Reid Tonking
