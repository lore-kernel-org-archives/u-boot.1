Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CB6C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 11:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 946CA8789F;
	Thu, 25 Jul 2024 13:59:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mveNAV33";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C73AD8708B; Thu, 25 Jul 2024 13:59:41 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B57E187C38
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 13:59:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46PBxa0c008479;
 Thu, 25 Jul 2024 06:59:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1721908776;
 bh=6oyo++KwrkC1LFjR39l6TR+1i9XnZbL+Opm+mAEiV2Q=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=mveNAV33xKrDKz4pRn6+K0YClExj6M+Nt2/4g4zn7LzPPo0eK2xZMWsZiNY3J32Z6
 Yv7xCTxTf0P93/nGSFvcRrKcZXKXQzITMpNOHvtx/0NtLCxZ5EEMkR89zyZRrlEG9k
 YjW5FbyPW2K1CrtTrn3U/wy/i8Vqk/MP8Pu5G/wk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46PBxala118166
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 25 Jul 2024 06:59:36 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Jul 2024 06:59:36 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Jul 2024 06:59:36 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46PBxa2D104606;
 Thu, 25 Jul 2024 06:59:36 -0500
Date: Thu, 25 Jul 2024 06:59:36 -0500
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
Subject: Re: [PATCH V7 4/7] doc: ti: am62*: Mention TIFS Stub in img fmts and
 boot flow
Message-ID: <20240725115936.lrxzueooqowaeiw3@germinate>
References: <20240725093546.4193107-1-d-gole@ti.com>
 <20240725093546.4193107-5-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240725093546.4193107-5-d-gole@ti.com>
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
> Since AM62x, AM62P and AM62A all use similar boot flows and their low
> power mode s/w ARCH is also similar in the way that they make use of the
> TIFS Stub, update their documentation to show where TIFS Stub is.
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>  doc/board/ti/am62ax_sk.rst                 |    4 +-
>  doc/board/ti/am62px_sk.rst                 |    4 +-
>  doc/board/ti/am62x_sk.rst                  |    4 +-
>  doc/board/ti/img/boot_diagram_am62.svg     | 1983 ++++++++++++++++++++
>  doc/board/ti/img/tifsstub_dm_tispl.bin.svg |  353 ++++
>  5 files changed, 2342 insertions(+), 6 deletions(-)
>  create mode 100644 doc/board/ti/img/boot_diagram_am62.svg
>  create mode 100644 doc/board/ti/img/tifsstub_dm_tispl.bin.svg
> 

Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
