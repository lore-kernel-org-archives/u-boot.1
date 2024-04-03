Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272A7C6FD1F
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 07:35:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A042881E3;
	Wed,  3 Apr 2024 09:35:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="h7StAN/b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ACA387EAF; Wed,  3 Apr 2024 09:35:01 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58C7B87D08
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 09:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4337YmYW127777;
 Wed, 3 Apr 2024 02:34:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712129688;
 bh=zgcw65ED4kTgb9J0n5WzO0CJS+KUnD1IY8N5WTMAo2Q=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=h7StAN/b+OwJDL+NMYTEQn68C1hGrC9WSKmKqBnjlYs6BdRviFLE2V5SnCKfTvJAz
 U3Rce36jeYf+dZiEMel+tjwciSw3yhVXORxhjJzRQrgZO/h6ph7iyxkyOQ1eLBAAF9
 GIu1KvduDACIpXCivGyvfcqKwfB/RH6BpTYx1/XM=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4337Ym5H089103
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Apr 2024 02:34:48 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 02:34:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 02:34:47 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4337YkHF063135;
 Wed, 3 Apr 2024 02:34:47 -0500
Date: Wed, 3 Apr 2024 13:04:46 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Marcel Ziswiler <marcel@ziswiler.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Andrew Davis <afd@ti.com>, Bryan Brattlof
 <bb@ti.com>, Caleb Connolly <caleb.connolly@linaro.org>, Emanuele Ghidoli
 <emanuele.ghidoli@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Jonas Karlman <jonas@kwiboo.se>, Kamlesh
 Gurudasani <kamlesh@ti.com>, Kever Yang <kever.yang@rock-chips.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Marek Vasut <marex@denx.de>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>, Peng Fan
 <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>, Sumit Garg
 <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, Tim Harvey
 <tharvey@gateworks.com>, Wadim Egorov <w.egorov@phytec.de>
Subject: Re: [PATCH v1] verdin-am62: move verdin am62 to OF_UPSTREAM
Message-ID: <20240403073446.scnd72h3kycz6g5h@dhruva>
References: <20240403071518.400771-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240403071518.400771-1-marcel@ziswiler.com>
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

On Apr 03, 2024 at 09:15:10 +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Move verdin-am62 to OF_UPSTREAM:

Thanks!

> - handle the fact that dtbs now have a 'ti/' prefix
> - imply OF_UPSTREAM
> - remove redundant files from arch/arm/dts leaving only the
>   *-u-boot.dtsi files
> - update MAINTAINERS file
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva
