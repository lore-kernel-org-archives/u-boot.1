Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF92CA0EED
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 14:50:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94CBE83321;
	Thu, 28 Aug 2025 16:50:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="P8xFOb/0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E17C8334A; Thu, 28 Aug 2025 16:50:50 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94075832C8
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 16:50:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57SEodOW2029897;
 Thu, 28 Aug 2025 09:50:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756392639;
 bh=tiKMIeVet7ni77lTRUQwYQlRoSXK6B78q4y76q36NqQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=P8xFOb/04e0VWRE/M3w4640LK7Xq7Kkq4WjlrLHc8H4DCiCrKhfGEFEkq5r0Ub8Ld
 8CvY1mJRPnezZPcaWkJGrvPkXacdB+/CkDQ2jy6LAEhOpfgAaypkDAH0OaJBdcw/vQ
 shwrwzs2PLNG4RrscbUwR39yPUJ9a+OM34QP2B38=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57SEodh13306932
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 28 Aug 2025 09:50:39 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 28
 Aug 2025 09:50:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 28 Aug 2025 09:50:38 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57SEocYu505782;
 Thu, 28 Aug 2025 09:50:38 -0500
Date: Thu, 28 Aug 2025 09:50:38 -0500
From: Bryan Brattlof <bb@ti.com>
To: Jared McArthur <j-mcarthur@ti.com>
CC: <u-boot@lists.denx.de>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom
 Rini <trini@konsulko.com>, Neha Malcom Francis <n-francis@ti.com>, Bhupesh
 Sharma <bhupesh.linux@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/2] ufs: Add support for setting bRefClkFreq attribute
Message-ID: <20250828145038.hwyjt2uzkhhzckxl@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250827185056.954640-1-j-mcarthur@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250827185056.954640-1-j-mcarthur@ti.com>
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

On August 27, 2025 thus sayeth Jared McArthur:
> Currently, U-Boot doesn't set the bRefClkFreq attribute before
> changing power mode of the UFS device. If there is a difference
> between the UFS device and the host controller, all commands will fail
> after switching to high speed.
> 
> This behavior is rarely observed, because Linux sets the bRefClkFreq
> attribute on probe, and the bRefClkFreq is a persistent attribute. In
> other words, once Linux has booted once, the issue will never be seen.
> 
> If trying to provision and boot from an unprovisioned UFS device,
> U-Boot will fail. Fix this by adding support for setting the
> bRefClkFreq attribute.
> 
> Jared McArthur (2):
>   ufs: Add support for sending UFS attribute requests
>   ufs: Add bRefClkFreq attribute setting
> 
>  drivers/ufs/ufs.c | 184 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/ufs/ufs.h |  10 +++
>  2 files changed, 194 insertions(+)

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
