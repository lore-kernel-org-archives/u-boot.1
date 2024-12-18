Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB50E77183
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 04:54:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48AB080214;
	Wed, 18 Dec 2024 05:54:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oMCx3kBF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1782C8021A; Wed, 18 Dec 2024 05:54:49 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A91880196
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 05:54:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BI4savr3577643
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 17 Dec 2024 22:54:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734497676;
 bh=4r0+779TPc0jGcXbBroYn9S715WJbrKayGHD21sO1EU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=oMCx3kBF7NJ9eMKwRN5rqWvzyh1ll+jaWj0xd10zRAo1ZNjfEFqlkX17H8478YmVh
 l8CY5Yl9yWEJtFevsm73D1I94Qhf1AJtzzwXNLv0OqgCQdCIlPRX8+HHPFm4lmOY6w
 HkoEl5gDD3mtqQnIcpLg5i3I73tUbmI1tP4tMjLk=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BI4sa4P031336;
 Tue, 17 Dec 2024 22:54:36 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 17
 Dec 2024 22:54:36 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 17 Dec 2024 22:54:36 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BI4sYCe128991;
 Tue, 17 Dec 2024 22:54:35 -0600
Date: Wed, 18 Dec 2024 10:24:34 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Jonathan Humphreys <j-humphreys@ti.com>
CC: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Caleb Connolly
 <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>, Mattijs
 Korpershoek <mkorpershoek@baylibre.com>,
 Lukasz Majewski <lukma@denx.de>, <s-vadapalli@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] dfu: Prevent set_dfu_alt_info() from overwriting a
 previous value
Message-ID: <iiteoppwfxw26tpj3jk7roybyvs6dznt72yhfv74ik67pwyrgt@oh7pnotncwze>
References: <20241217204835.3312765-1-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241217204835.3312765-1-j-humphreys@ti.com>
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

On Tue, Dec 17, 2024 at 02:48:35PM -0600, Jonathan Humphreys wrote:

Hello Jon,

Thank you for posting this patch. I will drop the equivalent of this
patch when I post the v2 series for:
https://patchwork.ozlabs.org/project/uboot/cover/20241217131658.2920799-1-s-vadapalli@ti.com/

> If CONFIG_SET_DFU_ALT_INFO is enabled, the dfu_alt_info environment
> variable is dynamically set when initializing the DFU entities, which is
> done as part of normal flow of a DFU operation.
> 
> The USB DFU boot support will set it's own specific value for dfu_alt_info

nitpick: s/it's/its

> before performing the DFU operation. This means that if
> CONFIG_SET_DFU_ALT_INFO is enabled, the dfu_alt_info environment variable
> that the USB DFU boot path had set is overwritten, causing USB DFU boot to
> fail.
> 
> Likewise, if the user sets their own value for dfu_alt_info, say at the
> U-Boot prompt, it get's overwritten if CONFIG_SET_DFU_ALT_INFO is enabled.

nitpick: s/get's/gets

> 
> This patch will first check that dfu_alt_info isn't already set before
> calling set_dfu_alt_info(), when CONFIG_SET_DFU_ALT_INFO is enabled.

Rather than referring to "patch", we could rephrase the above as:

Check that dfu_alt_info isn't already set before calling set_dfu_alt_info()
when CONFIG_SET_DFU_ALT_INFO is enabled, in order to avoid overwriting it.

> 
> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>  drivers/dfu/dfu.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dfu/dfu.c b/drivers/dfu/dfu.c
> index 756569217bb..ab8abae1d89 100644
> --- a/drivers/dfu/dfu.c
> +++ b/drivers/dfu/dfu.c
> @@ -169,10 +169,13 @@ int dfu_init_env_entities(char *interface, char *devstr)
>  	dfu_reinit_needed = false;
>  	dfu_alt_info_changed = false;
>  
> +	str_env = env_get("dfu_alt_info");
>  #ifdef CONFIG_SET_DFU_ALT_INFO
> -	set_dfu_alt_info(interface, devstr);
> +	if (!str_env) {
> +		set_dfu_alt_info(interface, devstr);
> +		str_env = env_get("dfu_alt_info");
> +	}
>  #endif
> -	str_env = env_get("dfu_alt_info");
>  	if (!str_env) {
>  		pr_err("\"dfu_alt_info\" env variable not defined!\n");
>  		return -EINVAL;

Regards,
Siddharth.
