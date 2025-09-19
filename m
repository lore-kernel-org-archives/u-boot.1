Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3121CAC592
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 11:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A6AC81E13;
	Fri, 19 Sep 2025 13:59:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BbF1LDUl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD76083071; Fri, 19 Sep 2025 13:59:06 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E50B98004F
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 13:59:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58JBx1Aq710314;
 Fri, 19 Sep 2025 06:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1758283141;
 bh=t/uJIEKm1EuHEo1b4VU7dFE5k0nBj5ijX4i4inx1Sd8=;
 h=Date:Subject:From:To:CC:References:In-Reply-To;
 b=BbF1LDUlY9UqM3f4Hw4rK4dOIUNQHYSpQOaPE3C4C8sL/xfwXpRVOCdRI9pLc+UMm
 e44l0HXLpzjUYmcYCj0pk8ayHubfBAwD5Um+C7jRi/iCyeUHTnqkX/RNAmZ4cKpQUF
 /EIexwXF3Ki1oEAaoCKZxzmMTP5ot+jOJYku11vg=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58JBx1ep3130465
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 19 Sep 2025 06:59:01 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 19
 Sep 2025 06:59:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 19 Sep 2025 06:59:01 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58JBx02X2528270;
 Fri, 19 Sep 2025 06:59:00 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 19 Sep 2025 17:28:59 +0530
Message-ID: <DCWRCRBERKOZ.3QATM9M067WNX@ti.com>
Subject: Re: [PATCH 1/2] board: phytec: phycore_am6xx: Update scriptaddr
From: Anshul Dalal <anshuld@ti.com>
To: Wadim Egorov <w.egorov@phytec.de>, <trini@konsulko.com>,
 <ggiordano@phytec.com>, <d.schultz@phytec.de>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250919063948.3093358-1-w.egorov@phytec.de>
 <20250919063948.3093358-2-w.egorov@phytec.de>
In-Reply-To: <20250919063948.3093358-2-w.egorov@phytec.de>
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

On Fri Sep 19, 2025 at 12:09 PM IST, Wadim Egorov wrote:
> After switching our boards to standard boot, we observed that the
> kernel hangs when booting with the "script" boot method over the
> network.
>
> The original scriptaddr value was copied from ti_common.env and
> remained unused for some time. On phycore-am62x and phycore-am62ax,
> however, this address conflicts with the current location where
> ATF is loaded (CONFIG_K3_ATF_LOAD_ADDR).
>

We should look into doing similar for K3 as well, would be useful when
we switch to std boot as well.=20

> Move scriptaddr to 0x89100000, directly after fdtoverlay_addr_r.
> The phycore-am64x is not affected by this issue, but we update it
> as well to keep all phycore-am6xx boards consistent.
>
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---

Reviewed-by: Anshul Dalal <anshuld@ti.com>

Regards,
Anshul
