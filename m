Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1ACC35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 05:34:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 982EA80F70;
	Tue, 25 Mar 2025 06:34:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YKHIGYb5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFAE581026; Tue, 25 Mar 2025 06:34:28 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F38A680EEF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 06:34:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52P5YMhW1134236
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Mar 2025 00:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742880863;
 bh=85N8s14gljBNpjglQmgaLrEvDFj5rNkNQ9f90kZaaGY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=YKHIGYb5c4FrlMafkwi5NDFhblM/WLMqYL3Za2HS4A7O3a1qUQKm3BECXhvL3okQQ
 3yw8vT3eEYh0ym1PGVlm6kUdNiinkmIAb2PwDVgiYBYRfB2x3/MqEDhNEgO2V8NYHS
 vpTzaXTk3foDO5c0uYleUHk1bNdBZAmuWKSk+UlE=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52P5YML8028158
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 25 Mar 2025 00:34:22 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Mar 2025 00:34:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Mar 2025 00:34:22 -0500
Received: from localhost (prasanth-server.dhcp.ti.com [172.24.227.142])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52P5YLlL094358;
 Tue, 25 Mar 2025 00:34:22 -0500
Date: Tue, 25 Mar 2025 11:04:20 +0530
From: Prasanth Mantena <p-mantena@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <sjg@chromium.org>, <alpernebiyasak@gmail.com>, <u-boot@lists.denx.de>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>,
 <vaishnav.a@ti.com>
Subject: Re: [PATCH] common: spl: Enable Instruction cache after relocation
 in board_init_r
Message-ID: <20250325053420.4wuenxmlnqsojuyt@prasanth-server>
References: <20250317064507.1702120-1-p-mantena@ti.com>
 <20250317151318.GR2640854@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250317151318.GR2640854@bill-the-cat>
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

On 09:13, Tom Rini wrote:
> On Mon, Mar 17, 2025 at 12:15:07PM +0530, Prasanth Babu Mantena wrote:
> 
> > ICACHE is enabled in board_init_f which executes only before relocation.
> > Instruction cache invalidation is needed after relocation as well in the
> > common spl, which is taken care in the u-boot init_sequence, but missing
> > for the spl. So, enable it at the start of board_init_r for spl, which
> > invalidates icache needed after instruction relocation.
> > 
> > Fixes: 52a86e69e20 ("arm: k3: Enable instruction cache for main domain SPL")
> > Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
> > ---
> >  arch/arm/mach-k3/common.c | 1 +
> >  common/spl/spl.c          | 1 +
> >  2 files changed, 2 insertions(+)
> 
> What's missing from spl_enable_cache() in K3 already? And looking more
> at this, since Rockchip does this slightly differently I wonder if we
> need to think harder about making some of these hook points generic.

spl_enable_cache is getting called in the board_init_f and the
enable_cache here is getting called in the board_init_r, which is
basically doing the cache invalidate after the relocation. If this is
the case, I doubt, if we have to enable this directly in board_init_r
only, instead doing it in board_init_f.

Regards,
Prasanth


> 
> -- 
> Tom


