Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29392E77183
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 04:55:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE63A80214;
	Wed, 18 Dec 2024 05:55:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="I6BWMAno";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 033738021A; Wed, 18 Dec 2024 05:55:41 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69D4080196
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 05:55:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BI4tSPV4071042
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 17 Dec 2024 22:55:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734497728;
 bh=TcMkQYGQM/EddZziyMEK2cFFJhT5Y9evmuw/P2ReAys=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=I6BWMAnoBIADP2+sfqZsV0MGWQm/F2rqVMvXnBn0luP9taWrKzqCh6FRyKI2B1JES
 JyoPdIwoe6MIFkvjDj6Q9Dd6LqOz5A0hxKuJ8GaVhqSoBocXJrZkxYAA5owWinYL8n
 414b1ulnx3tny3lkHMtdldWcL6wOXqgBticpmHLk=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BI4tSgk031856;
 Tue, 17 Dec 2024 22:55:28 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 17
 Dec 2024 22:55:28 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 17 Dec 2024 22:55:28 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BI4tRrg059666;
 Tue, 17 Dec 2024 22:55:27 -0600
Date: Wed, 18 Dec 2024 10:25:26 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Jon Humphreys <j-humphreys@ti.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, 
 <trini@konsulko.com>, <lukma@denx.de>, <n-francis@ti.com>,
 <mkorpershoek@baylibre.com>, <afd@ti.com>, <glaroque@baylibre.com>,
 <sjoerd@collabora.com>, <martyn.welch@collabora.com>,
 <rasmus.villemoes@prevas.dk>, <caleb.connolly@linaro.org>,
 <rogerq@kernel.org>, <nm@ti.com>, <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH 1/4] dfu: do not overwrite "dfu_alt_info"
Message-ID: <p7cti5gasig2ambea2mtu4ruhmzvsfmzidvvcqsk2hbxcygl6t@ucnebtamj64g>
References: <20241217131658.2920799-1-s-vadapalli@ti.com>
 <20241217131658.2920799-2-s-vadapalli@ti.com>
 <86ldwe3u8e.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <86ldwe3u8e.fsf@udb0321960.dhcp.ti.com>
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

On Tue, Dec 17, 2024 at 02:55:13PM -0600, Jon Humphreys wrote:
> Siddharth Vadapalli <s-vadapalli@ti.com> writes:
> 
> > From: Jonathan Humphreys <j-humphreys@ti.com>
> >
> > For use-cases such as USB DFU Boot, "spl_dfu_cmd()" will setup the
> > appropriate value for "dfu_alt_info". To facilitate such use-cases and
> > in order to avoid overwriting the value of "dfu_alt_info", invoke the
> > "set_dfu_alt_info()" function only when "dfu_alt_info" is not defined.
> >
> > Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> >  drivers/dfu/dfu.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/dfu/dfu.c b/drivers/dfu/dfu.c
> > index 756569217bb..ab8abae1d89 100644
> > --- a/drivers/dfu/dfu.c
> > +++ b/drivers/dfu/dfu.c
> > @@ -169,10 +169,13 @@ int dfu_init_env_entities(char *interface, char *devstr)
> >  	dfu_reinit_needed = false;
> >  	dfu_alt_info_changed = false;
> >  
> > +	str_env = env_get("dfu_alt_info");
> >  #ifdef CONFIG_SET_DFU_ALT_INFO
> > -	set_dfu_alt_info(interface, devstr);
> > +	if (!str_env) {
> > +		set_dfu_alt_info(interface, devstr);
> > +		str_env = env_get("dfu_alt_info");
> > +	}
> >  #endif
> > -	str_env = env_get("dfu_alt_info");
> >  	if (!str_env) {
> >  		pr_err("\"dfu_alt_info\" env variable not defined!\n");
> >  		return -EINVAL;
> > -- 
> > 2.43.0
> 
> Hi Siddharth, thanks. I went ahead and just posted a separate patch to fix
> this issue. I added a bit more explanation, and wanted it separate so that
> it can hopefully make the 2025.01 release.
> 
> See https://lore.kernel.org/r/20241217204835.3312765-1-j-humphreys@ti.com.

Thank you Jon. I will drop this patch in the v2 series. I have reviewed
your patch and shared feedback.

Regards,
Siddharth.
