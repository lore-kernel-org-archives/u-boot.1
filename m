Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4587EC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 08:28:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0E3881F0D;
	Tue,  3 Jun 2025 10:28:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Y4szpuy7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39DAB81FFC; Tue,  3 Jun 2025 10:28:47 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47A9181E72
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 10:28:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5538SffJ3450948;
 Tue, 3 Jun 2025 03:28:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748939321;
 bh=hPOmetAt8isBV4aPjRaj1FTcUCNDZj9bF/A26oPmuNI=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Y4szpuy78ZZOiOaa1m9fqjUlUu/QqgUlfQtjictHXsqoEKHU0kklZKLtFbdgx7mDX
 JX30EQVrxy878wqJp292l59SnV6JTudxsUilZgW07ft5IMj/dRO427mwwO3aDydgXJ
 b56GYjTcPGu0i4mSHVNcZPRiZ3e/oMXqptHV6A7Y=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5538Sfda1190878
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 3 Jun 2025 03:28:41 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Jun 2025 03:28:41 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Jun 2025 03:28:41 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5538Se5Y155935;
 Tue, 3 Jun 2025 03:28:40 -0500
Date: Tue, 3 Jun 2025 13:58:39 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Moteen Shah <m-shah@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>
Subject: Re: [PATCH 1/6] ti_sci_*: Add utility to access tisci firmware and
 SOC capability
Message-ID: <20250603082839.z554qglc35gh4zxc@lcpd911>
References: <20250528080519.677750-1-m-shah@ti.com>
 <20250528080519.677750-2-m-shah@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250528080519.677750-2-m-shah@ti.com>
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

On May 28, 2025 at 13:35:14 +0530, Moteen Shah wrote:
> Introduce response and request structs for receiving information
> regarding FW/SOC capability from DM. The received capability can
> further be used to call API's based on the feature supported by
> the DM firmware.
> 
> Signed-off-by: Moteen Shah <m-shah@ti.com>
> ---

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
