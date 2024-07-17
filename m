Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9575FC3DA4B
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 12:00:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5D45889A2;
	Wed, 17 Jul 2024 14:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="btfyQ3CI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A44D88755; Wed, 17 Jul 2024 14:00:02 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEBE588126
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 13:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 46HBxwAA105529;
 Wed, 17 Jul 2024 06:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1721217598;
 bh=wo6t4nUWtOs8nd5qDK7Mxhxtxyfuz5U3pPRoOCAuUOY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=btfyQ3CIgNQhdxfYagpuM4p0Ce+l1eHVOtLgsaPM0E3j3bgEtq1F6Z8QpUiklWJ8s
 TcmcpJ3E15WAcOsBGtS+6b0VonmD0IgztJSygMgCvBmriYfyLZ7WZnzWC3+Aj26yub
 Urb90+8bR7aFlPd89wlHd8wc3dewmzPpnJwg5pNc=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 46HBxwib099686
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 17 Jul 2024 06:59:58 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Jul 2024 06:59:57 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Jul 2024 06:59:57 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 46HBxvFi121817;
 Wed, 17 Jul 2024 06:59:57 -0500
Date: Wed, 17 Jul 2024 06:59:57 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <trini@konsulko.com>, <bb@ti.com>, <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
Subject: Re: [RESEND PATCH] soc: ti: k3-socinfo: Add support for J721E SR2.0
Message-ID: <20240717115957.au47kqpmyl3hcxjn@aroma>
References: <20240715111550.543037-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240715111550.543037-1-n-francis@ti.com>
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

On 16:45-20240715, Neha Malcom Francis wrote:
> Add support for identifying J721E SR2.0
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
> Resending as it was not sent to the mailing-list earlier, sorry for the
> spam.
> 
> Boot logs:
> https://gist.github.com/nehamalcom/e5c3884961c3eb70464321aa4bfbcf78
> 
>  drivers/soc/soc_ti_k3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/soc_ti_k3.c b/drivers/soc/soc_ti_k3.c
> index f948914d218..a3acca4d394 100644
> --- a/drivers/soc/soc_ti_k3.c
> +++ b/drivers/soc/soc_ti_k3.c
> @@ -61,7 +61,7 @@ static const char *get_family_string(u32 idreg)
>  }
>  
>  static char *j721e_rev_string_map[] = {
> -	"1.0", "1.1",
> +	"1.0", "1.1", "2.0",
>  };
>  
>  static char *typical_rev_string_map[] = {
> -- 
> 2.34.1
> 

Reviewed-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
