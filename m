Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E757FC10F16
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 16:47:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 746D4882A5;
	Fri,  3 May 2024 18:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hjcDvHGL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CA77882AA; Fri,  3 May 2024 18:47:04 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E52098829C
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 18:47:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 443GkxB9082998;
 Fri, 3 May 2024 11:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714754819;
 bh=FZ4X2lO9JfKYd3uoweYzPi2Fz6rUtyJqG+Vn8Fq7z1k=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=hjcDvHGLo5BluAWqZkk7T90kHAmCUnO5/0pv5z5Fcs6yRmFMVHx3TaDLn4egEGT/Z
 4E1D1YWDFByeWcaPmgBa2Fy+tRceSIeJa7v24vYZ/hehKlsc/Q4/fV4PUnQP5vkJ74
 rOWb2buPkwD9yPodQ5/59c7PGTu9PlOURxY268Dw=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 443GkxiC052784
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 3 May 2024 11:46:59 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 3
 May 2024 11:46:59 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 3 May 2024 11:46:58 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 443GkwWe037121;
 Fri, 3 May 2024 11:46:58 -0500
Date: Fri, 3 May 2024 11:46:58 -0500
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Nitin Yadav <n-yadav@ti.com>, Dhruva Gole
 <d-gole@ti.com>
Subject: Re: [PATCH v2 0/2] introduce basic support for TI's am625-lp-sk
Message-ID: <20240503164658.bgsjyiepuqpqbpfi@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240429-am62q-wip-v2-0-e78f09174e65@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240429-am62q-wip-v2-0-e78f09174e65@ti.com>
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

Sorry everyone I hit send a little to fast on this one!

On May  3, 2024 thus sayeth Bryan Brattlof:
> Hello Everyone!
> 
> The am625-lp-sk is a variant of the am625-sk showcasing the low-power 
> features of the am625 SoC Family. Because it's essentially a board and 
> package spin of the am625-sk I've inherited the am625 configuration and 
> overridden what was needed.
> 
> This is a new spin of Nitin's original work which has been updated 
> significantly since October 2023
> 
>   https://lore.kernel.org/u-boot/20231030110138.1347603-1-n-yadav@ti.com/
> 
> Unfortunately a patch is need on top of this series to boot:
> 
>   https://lore.kernel.org/u-boot/20240429214936.15187-1-jm@ti.com
> 
> For those of us interested here is proof of life using buildroot:
> 
>    https://paste.sr.ht/~bryanb/40f7787f7760bee383aa8fbc342a29e8544dbdab
> 
> Thank you for reviewing
> ~Bryan
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
> Changes in v2:
> - updated copyright year
> - Link to v1: https://lore.kernel.org/r/20240429-am62q-wip-v1-0-927fd2e0a53b@ti.com
> 

Didn't actually fixup the copyright year. Just sent out v3 which 
actually did what I said I was going to :/

Sorry for the spam.

~Bryan
