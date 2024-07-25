Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB12C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 12:05:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7589987C7E;
	Thu, 25 Jul 2024 14:05:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GOd4ETzt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32BB887D8C; Thu, 25 Jul 2024 14:05:04 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27A5286E85
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 14:05:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46PC4wKk114811;
 Thu, 25 Jul 2024 07:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1721909098;
 bh=f5VCEFHdBESy3XatQ7G268Tl+piSboW+pnifXZ2YPZg=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=GOd4ETztN8/cLC3o19CcYLzfY+3gV1bdc5uAmee/8+uOQ+mqbNhN3ifp4Yt68Xqqx
 pGyGl4X3QN471UYMOKj6nPX46Wu82mSzzVdpCM6J/cvt3y40FpFyNJara3daFCnTdW
 BGQ7MOsXu7hERsHLRTE0pme8V7stI4auGnfIJHnY=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46PC4wOG098443
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 25 Jul 2024 07:04:58 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Jul 2024 07:04:58 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Jul 2024 07:04:58 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46PC4wDn019767;
 Thu, 25 Jul 2024 07:04:58 -0500
Date: Thu, 25 Jul 2024 07:04:58 -0500
From: Nishanth Menon <nm@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, <c-shilwant@ti.com>,
 <m-chawdhry@ti.com>, <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vibhore Vardhan
 <vibhore@ti.com>, Vishal Mahaveer <vishalm@ti.com>, Sebin Francis
 <sebin.francis@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, <t.remmet@phytec.de>,
 <mkorpershoek@baylibre.com>, Daniel Schultz <d.schultz@phytec.de>
Subject: Re: [PATCH V7 6/7] doc: beagle: am62x_beagleplay: Document the use
 of TIFS Stub
Message-ID: <20240725120458.vj6mhgajsi2xidtl@thousand>
References: <20240725093546.4193107-1-d-gole@ti.com>
 <20240725093546.4193107-7-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240725093546.4193107-7-d-gole@ti.com>
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

On 15:05-20240725, Dhruva Gole wrote:
> * Include the actual common documentation about the TIFS Stub and role
>   it plays to enable Low Power Modes in the platform.
> * Add the AM62x boot flow to show at which point the TIFS Stub actually
>   gets loaded.
> * Mention the TIFS Stub in the TISPL image format.
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>  doc/board/beagle/am62x_beagleplay.rst | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
