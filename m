Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47F4C3ABA3
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 12:27:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4238C8059D;
	Thu,  1 May 2025 14:27:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fw26apQ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A789C8081A; Thu,  1 May 2025 14:27:22 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3C9A8056A
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 14:27:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 541CRHUl3611421
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 1 May 2025 07:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746102437;
 bh=RiK7oEi0zsElFp1OH1W7wrIeHHncX7C5qYXsYQXOMX8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=fw26apQ93/btc2Y4mLmuJqpjEUapR/MmxNPPwkUsEdPtv0hCJovDN0FyM2tneDFjJ
 iH1vmaIs/pT5trdzJMKzIuW88L3b2Mr9UZ9GSfhrvwmqvhMFHBjasWHLY7C6zW7AFm
 PxTPAv67Icdh6sMXr5vD85Xjxbu5VP9mkBBZB+i8=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 541CRHmA030302
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 1 May 2025 07:27:17 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 May 2025 07:27:17 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 May 2025 07:27:17 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 541CRHab068941;
 Thu, 1 May 2025 07:27:17 -0500
Date: Thu, 1 May 2025 07:27:17 -0500
From: Nishanth Menon <nm@ti.com>
To: Udit Kumar <u-kumar1@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <d-gole@ti.com>,
 <n-francis@ti.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>,
 <ilias.apalodimas@linaro.org>, <c-vankar@ti.com>
Subject: Re: [PATCH v2] firmware: ti_sci: Add Initialization of dev_info head
 node
Message-ID: <20250501122717.jxuiwwuo5ziyb7cp@craftsman>
References: <20250429171440.2524557-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250429171440.2524557-1-u-kumar1@ti.com>
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

On 22:44-20250429, Udit Kumar wrote:
> On K3 devices two drivers ti_sci and ti_sci_dm are supporting firmware
> functions. At run time one of driver is used.
> 
> Driver ti_sci already initializing head for dev_list in its probe
> function, but it was missed in ti_sci_dm driver.
> 
> So add head list init support for ti_sci_dm driver.
> While at this, move init of list before usages in both functions.
> 
> Fixes: 5d5a699855a7("firmware: ti_sci: Add support for Resoure Management at R5 SPL stage")
> Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>

Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
