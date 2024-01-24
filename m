Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D3FC47DDF
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 10:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92B8487BF2;
	Wed, 24 Jan 2024 11:43:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ymfK7NsU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13AA287C30; Wed, 24 Jan 2024 11:43:54 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80AFC87BEF
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 11:43:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OAhn0U088162;
 Wed, 24 Jan 2024 04:43:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706093029;
 bh=PBQKST+ZzOmiGyPIjlsk7JlXWpen+q9HgcRPgrBwFSE=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=ymfK7NsUMl0piQs2GpeWxwz33lmmwTlJ8UQVpFZvg3KnH1t0J4J8EsmUbsTZ5u0kD
 Mxg09/1Z9JsS8xZ4dmZi90x1tY9u3oVCGxV1nkv+/eIqID+gFGe+xLb4Ev+eazL/rT
 udtFl8gsWWILZubZHOAt1g+x/jm9JlzYG2FHeBMI=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OAhnqU030958
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 24 Jan 2024 04:43:49 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 04:43:49 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 04:43:49 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OAhmQs127542;
 Wed, 24 Jan 2024 04:43:49 -0600
Date: Wed, 24 Jan 2024 16:13:48 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Neha Francis <n-francis@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Kamlesh
 Gurudasani <kamlesh@ti.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] firmware: ti_sci: fix the secure_hdr in do_xfer
Message-ID: <20240124104348.kstoyx6wxsyvy37o@dhruva>
References: <20240124101558.184411-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240124101558.184411-1-d-gole@ti.com>
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

On Jan 24, 2024 at 15:45:58 +0530, Dhruva Gole wrote:
> The secure_hdr needs to be 0 init-ed however this was never being put
> into the secure_buf, leading to possibility of the first 4 bytes of
> secure_buf being possibly garbage.
> 
> Fix this by initialising the secure_hdr itself to the secure_buf
> location, thus when we make it 0, it automatically ensures the first 4
> bytes are 0.
> 
> Fixes: 32cd25128bd849 ("firmware: Add basic support for TI System Control Interface (TI SCI)")
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
> 
> Boot tested for sanity on AM62x SK
> https://gist.github.com/DhruvaG2000/724ceba3a0db03f4b0bff47de1160074
> 
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Tom Rini <trini@konsulko.com>
> 
>  drivers/firmware/ti_sci.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Kindly ignore this patch, seems like it's from an older u-boot. I have
rebased an sent new patch with updated boot logs.

Please forgive the spam.

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
