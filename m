Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39AECC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 18:41:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43EFC87AD2;
	Wed,  5 Jun 2024 20:41:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cfEpfFPl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A6F887F39; Wed,  5 Jun 2024 20:41:17 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9F37878F7
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 20:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 455IfCja101693;
 Wed, 5 Jun 2024 13:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717612872;
 bh=xMltKgda/ZoHvS1hSzexmADlIQ+iGxPjOLK3Bwvsibw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=cfEpfFPl4ZjPFeO59XY1Pe0bQ/btAzcXrfkqc773DdtSxKkKbhDO5LIYFIloqH/Pr
 dSeUDwMBvSZw/tsf3zjhcqAGNb5DCkt4JsX/q4+qOkYweTzjHT0RzZYb7mUgpG3Igz
 8CVU9xlVRtrPtL8fPa4S9JUwEwqg1R+BQ5F/0aRE=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 455IfCkO007843
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 5 Jun 2024 13:41:12 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 5
 Jun 2024 13:41:12 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 5 Jun 2024 13:41:12 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 455IfBZd021611;
 Wed, 5 Jun 2024 13:41:11 -0500
Date: Thu, 6 Jun 2024 00:11:10 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/3] arm: dts: am625/am62a7: Switch over to OF_UPSTREAM
Message-ID: <20240605184110.jytanjglt5ddpbrq@dhruva>
References: <20240605152752.1711835-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240605152752.1711835-1-nm@ti.com>
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

Hi,

On Jun 05, 2024 at 10:27:49 -0500, Nishanth Menon wrote:
> Cleanup am625 on by switching over the last two platforms (SK and
> beagleplay) over to OF_UPSTREAM, and while at it, switch over am62a7
> (last of the am62* family) over as well.

Thanks for the cleanup.

> 
> This superscedes the previous version of beagleplay only patch[1]
> 
> Test logs: https://gist.github.com/nmenon/ba310d3750a80789aca6a4fd90190135
> 
> Nishanth Menon (3):
>   arm: dts: am625_beagleplay: Switch to OF_UPSTREAM
>   arm: dts: am625_sk: Switch to OF_UPSTREAM
>   arm: dts: am62a7_sk: Switch to OF_UPSTREAM
> 

For the series,
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
