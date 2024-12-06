Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCBCE7717B
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 06:49:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 436278938E;
	Fri,  6 Dec 2024 07:49:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="c4Huxtaw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5061E892A1; Fri,  6 Dec 2024 07:49:22 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE2ED8938E
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 07:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4B66n9Vk1872389
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 6 Dec 2024 00:49:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1733467749;
 bh=6bGFE3khj97YIu4MFYRs2i3jf/PgSsTdnezsMZiigoA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=c4HuxtawS+vFZN0kZKlbZRv5GcC/oBnpQPoCWozgPMK1gvwnbzGhwr5MSnqBn16u+
 ODF40V2855Hybw6xACdabcmPv9RPNl6II9uuGLF9L1N3hA5EZXq9bmz02dpX4AI4eR
 CAiMHSypKvsuYJthvshvSCgzYCOvZHI0wp2+LyS0=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B66n9mI111541;
 Fri, 6 Dec 2024 00:49:09 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 6
 Dec 2024 00:49:09 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 6 Dec 2024 00:49:09 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4B66n8Kr004633;
 Fri, 6 Dec 2024 00:49:08 -0600
Date: Fri, 6 Dec 2024 12:19:07 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Tom Rini <trini@konsulko.com>, <vigneshr@ti.com>, <nm@ti.com>,
 <j-humphreys@ti.com>, <srk@ti.com>, <s-vadapalli@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] phy: don't spam console if phys property is absent in
 device node
Message-ID: <owa6pi4wm5tjmwdtfhavftcfw3d54v5bx64pd6lmcevd3rofdu@x276i3ylhda4>
References: <20241203-nophys-v1-1-a5fdbccd2af9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241203-nophys-v1-1-a5fdbccd2af9@kernel.org>
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

On Tue, Dec 03, 2024 at 10:57:36PM +0200, Roger Quadros wrote:
> In generic_phy_get_bulk(), if 'phys' property is absent in
> the device node then it is not an error condition.
> 
> Change print message verbosity to debug to avoid spamming
> console in such cases.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.
