Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74F9C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 14:53:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28CCC88341;
	Wed,  5 Jun 2024 16:53:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eRu1coGV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08CE687A9C; Wed,  5 Jun 2024 16:53:03 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06E28871C7
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 16:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 455Eqsl9078797;
 Wed, 5 Jun 2024 09:52:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717599174;
 bh=5+O60DRFBqtWwSNm19+bZvcXz3h2oB0pxxfj0YW0X6U=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=eRu1coGVZRN/P9U0zq88tt/XkaX+CobaYzmskdaRPZkfKV6VCP/8mIpiHAfzJo0AI
 nXtYp+Ok3jpZoC3wcS/quTTt8zSvmjpFllX9SW8uZ8GBn0nBN7LEeGa993NEnhed5Z
 yvqs+z3g9f6xMwca6M92N3W4MRaLHiNTp8a8BUF4=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 455Eqs7b069643
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 5 Jun 2024 09:52:54 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Jun 2024 09:52:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Jun 2024 09:52:54 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 455EqsSD055577;
 Wed, 5 Jun 2024 09:52:54 -0500
Date: Wed, 5 Jun 2024 09:52:54 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Robert Nelson <robertcnelson@gmail.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] arm: dts; am625_beagleplay: Switch to OF_UPSTREAM
Message-ID: <20240605145254.gubybixcdbtgftxm@sadden>
References: <20240604134751.249048-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240604134751.249048-1-nm@ti.com>
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

On 08:47-20240604, Nishanth Menon wrote:
> Enable OF_UPSTREAM for AM625-beagleplay board. Remove DT files that
> are now available in dts/upstream. Update the appended files based on
> version of latest OF_UPSTREAM sync point (v6.10-rc1).
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> Based off u-boot
> next 15d0dcc0ec1f Merge tag 'u-boot-imx-next-20240603' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx into next
> 

Doing a bit more cleanup since I got a few mins to do it.. will resubmit
this patch as part of a series.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
