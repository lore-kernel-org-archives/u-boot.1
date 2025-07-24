Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8287C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 11:55:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CC0F8386D;
	Thu, 24 Jul 2025 13:55:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Y9raddsc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E30808386D; Thu, 24 Jul 2025 13:55:55 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EADCE83297
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 13:55:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56OBtleZ1489885;
 Thu, 24 Jul 2025 06:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1753358147;
 bh=xjjnuo9er073/yOmOwgjRUveEnuSKSUvrDgo4RP2IZM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Y9raddscGBAWLGvgMMT1BzWGjBSb5XMQfZ91va/j1nSaWTH3s17Xs2ZxdVyQh4/kt
 9W4bVizr5AGBrc0Z7peoOZH8Gw8g7LOOh7ZFIoQrh9dZvePVMXsPohRgNpge90apxQ
 5jBg0smv4gIVr4SpbmZnlHNWpP9JpdTN1J+Zt9Y4=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56OBtlH01483118
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 24 Jul 2025 06:55:47 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 24
 Jul 2025 06:55:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 24 Jul 2025 06:55:47 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56OBtlnS093674;
 Thu, 24 Jul 2025 06:55:47 -0500
Date: Thu, 24 Jul 2025 06:55:47 -0500
From: Bryan Brattlof <bb@ti.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
CC: U-Boot mailing list <u-boot@lists.denx.de>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Leonard Anderweit <l.anderweit@phytec.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 0/2] bintool fixes
Message-ID: <20250724115547.e4uwkimmb4f6tbt7@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250724091342.59902-1-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250724091342.59902-1-jerome.forissier@linaro.org>
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

On July 24, 2025 thus sayeth Jerome Forissier:
> Two small fixes for binman (bintool). The first patch avoids a warning,
> the second one makes sure the APT package list is up-to-date when
> running apt_install(). That one fixes a CI issue I encountered.
> 
> Changes in v3:
> - Really use apt-get instead of apt
> 
> Changes in v2:
> - Use apt-get instead of apt
> 
> Jerome Forissier (2):
>   binman: bintool: use apt-get instead of apt
>   binman: bintool: run 'apt-get update -y' on first invocation of
>     apt_install()
> 
>  tools/binman/bintool.py | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
