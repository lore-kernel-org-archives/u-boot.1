Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB61C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 12:30:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB4B487CE2;
	Tue, 30 Jan 2024 13:30:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AvpOmD2C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B8B787CE9; Tue, 30 Jan 2024 13:30:25 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 060A886FCE
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 13:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40UCULcU109404;
 Tue, 30 Jan 2024 06:30:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706617821;
 bh=0CuiLC4EeLbJExH6Sgr6S5rvYu3VfZ80oRHSN8fJQR0=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=AvpOmD2CElFaKQqOm9g/dO+uLxhzP49P2QyzaOrBNP9RwVLrQTXEMfPr3VNWXwUeh
 u7lRrFUGQe7ikxKPpQl/sqwMtYmN/C7EuRDxjjDalVdVREiNSg76OLL1lhWGV4eLhh
 ou1UzAfczYwQwlFzdRnhH/XZZNHR+MoO0wdqs5YA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40UCUL8m020299
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 30 Jan 2024 06:30:21 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 06:30:20 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 06:30:21 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40UCUK8m053817;
 Tue, 30 Jan 2024 06:30:20 -0600
Date: Tue, 30 Jan 2024 06:30:20 -0600
From: Nishanth Menon <nm@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH V4 2/2] firmware: ti_sci: Add comment explaining the
 is_secure code
Message-ID: <20240130123020.mob7ij2mguiqhp36@stipend>
References: <20240130115847.860345-1-d-gole@ti.com>
 <20240130115847.860345-3-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240130115847.860345-3-d-gole@ti.com>
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

On 17:28-20240130, Dhruva Gole wrote:
> Add a comment to explain the code under is_secure condition of
> ti_sci_do_xfer. This will help avoid confusion amongst people who may in
> future touch upon this code.
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
>  drivers/firmware/ti_sci.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 49d2696a6d09..d969470b5221 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -239,6 +239,12 @@ static int ti_sci_do_xfer(struct ti_sci_info *info,
>  	struct ti_sci_secure_msg_hdr *secure_hdr = (struct ti_sci_secure_msg_hdr *)secure_buf;
>  	int ret;
>  
> +	/*
> +	 * The reason why we need the is_secure code is because of boot R5.
> +	 * boot R5 starts off in "secure mode" when it hands off from Boot
> +	 * ROM over to the Secondary bootloader. The initial set of calls
> +	 * we have to make need to be on a secure pipe.
> +	 */
>  	if (info->is_secure) {
>  		/* ToDo: get checksum of the entire message */
>  		secure_hdr->checksum = 0;
> -- 
> 2.34.1
> 

Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
