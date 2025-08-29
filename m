Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9E9CA0FF2
	for <u-boot@archiver.kernel.org>; Fri, 29 Aug 2025 02:59:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C19C83443;
	Fri, 29 Aug 2025 04:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vnfqcyxo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDF9C83447; Fri, 29 Aug 2025 04:58:57 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC0938341A
 for <u-boot@lists.denx.de>; Fri, 29 Aug 2025 04:58:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57T2wiAP1706751;
 Thu, 28 Aug 2025 21:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756436324;
 bh=wscKFSjJp3iLEVzCWeCthkeZnEP8S2GL01kxjiz20lQ=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=vnfqcyxol9XavyG5t2nVJbCIMziAx3oKgLbuPy/DiWamEiGclu/aw7YanXgm03dCC
 fIIYZ8qQCBkUMQfiiYhCUFP+x/xhbO8BIO44NpbMf6YiDdmqAyixmQfYHrDfMxKlVz
 TawW6b9+wRlaWSRn8UMdjWQY7C6zlHGIQYMDxNK0=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57T2wiKx3339607
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 28 Aug 2025 21:58:44 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 28
 Aug 2025 21:58:44 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20; Thu, 28 Aug
 2025 21:58:44 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 28 Aug 2025 21:58:44 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57T2wg9O1649671;
 Thu, 28 Aug 2025 21:58:43 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 29 Aug 2025 08:27:27 +0530
Message-ID: <DCEKOOYNH8DL.PIOYJLAGX3W1@ti.com>
CC: Oliver Gaskell <Oliver.Gaskell@analog.com>, Greg Malysa
 <malysagreg@gmail.com>, Peng Fan <peng.fan@nxp.com>, "Nathan
 Barrett-Morrison" <nathan.morrison@timesys.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Andre Przywara <andre.przywara@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, Ye Li <ye.li@nxp.com>,
 "Simon Glass" <sjg@chromium.org>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/1] spl: SPL_DM_SPI_FLASH depends on SPL_DM_SPI
From: Anshul Dalal <anshuld@ti.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, Tom Rini
 <trini@konsulko.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250828135235.26711-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250828135235.26711-1-heinrich.schuchardt@canonical.com>
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

On Thu Aug 28, 2025 at 7:22 PM IST, Heinrich Schuchardt wrote:
> The SPI flash driver does not build without SPI support enabled.
>
> Fixes: 4151f4f822bb ("spl: Rework and tighten some dependencies")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Acked-by: Anshul Dalal <anshuld@ti.com>
