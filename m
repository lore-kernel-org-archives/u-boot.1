Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F7AC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 08:09:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8B0B88F22;
	Fri, 26 Apr 2024 10:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="E4XY2ObG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E5FD88F2D; Fri, 26 Apr 2024 10:09:45 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 908D788BEA
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 10:09:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43Q89Zkx107355;
 Fri, 26 Apr 2024 03:09:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1714118975;
 bh=Mf/bRvcaAX9Jnen+/mCl2YF+OUwKSGaEZWmV/Ro3kN4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=E4XY2ObGsRIm8I3dOesuOs2zadCjIKBtN42bhut5w/O/EGofiR+WLw44KcaGFTo3J
 bxXXdKpDJ/gLk06UmSD85RlvV08mHjsvwnsxDxOPRzBXo214Zo4S1Xw7vWywbIvxx7
 dtqe1HIRgmi6981yS1K/nj/mesPX9hlQQxICZTcQ=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43Q89Zi1015215
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 26 Apr 2024 03:09:35 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Apr 2024 03:09:35 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Apr 2024 03:09:35 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43Q89YOF107722;
 Fri, 26 Apr 2024 03:09:35 -0500
Date: Fri, 26 Apr 2024 13:39:34 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
CC: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 MD Danish Anwar <danishanwar@ti.com>, Jai Luthra <j-luthra@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Suman Anna <s-anna@ti.com>,
 <u-boot@lists.denx.de>, <u-boot@ew.tq-group.com>
Subject: Re: [PATCH 1/5] net: eth-uclass: guard against reentrant
 eth_init()/eth_halt() calls
Message-ID: <2d0e7f23-54a9-4435-bb2e-e22378331ccf@ti.com>
References: <de7fe2da7ae4a85252d63904fae61585e4641936.1714117337.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de7fe2da7ae4a85252d63904fae61585e4641936.1714117337.git.matthias.schiffer@ew.tq-group.com>
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

On Fri, Apr 26, 2024 at 10:02:24AM +0200, Matthias Schiffer wrote:
> With netconsole, any log message can result in an eth_init(), possibly
> causing an reentrant call into eth_init() if a driver's ops print
> anything:
> 
>     eth_init() -> driver.start() -> printf() -> netconsole -> eth_init()
>     eth_halt() -> driver.stop() -> printf() -> netconsole -> eth_init()
> 
> Rather than expecting every single Ethernet driver to handle this case,
> prevent the reentrant calls in eth_init() and eth_halt().
> 
> The issue was noticed on an AM62x board, where a bootm after
> simultaneous netconsole and TFTP would result in a crash.

Link: https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1350550/sk-am62a-lp-am65_cpsw_nuss_port-error-in-u-boot-while-using-netconsole-functionality/

> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  net/eth-uclass.c | 40 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 32 insertions(+), 8 deletions(-)
> 
> diff --git a/net/eth-uclass.c b/net/eth-uclass.c
> index 3d0ec91dfa4..193218a328b 100644
> --- a/net/eth-uclass.c
> +++ b/net/eth-uclass.c
> @@ -48,6 +48,8 @@ struct eth_uclass_priv {
>  
>  /* eth_errno - This stores the most recent failure code from DM functions */
>  static int eth_errno;
> +/* Are we currently in eth_init() or eth_halt()? */
> +static bool in_init_halt;
>  
>  /* board-specific Ethernet Interface initializations. */
>  __weak int board_interface_eth_init(struct udevice *dev,
> @@ -285,11 +287,19 @@ U_BOOT_ENV_CALLBACK(ethaddr, on_ethaddr);
>  
>  int eth_init(void)
>  {
> -	char *ethact = env_get("ethact");
> -	char *ethrotate = env_get("ethrotate");
>  	struct udevice *current = NULL;
>  	struct udevice *old_current;
>  	int ret = -ENODEV;
> +	char *ethrotate;
> +	char *ethact;
> +
> +	if (in_init_halt)
> +		return -EBUSY;
> +
> +	in_init_halt = true;
> +
> +	ethact = env_get("ethact");
> +	ethrotate = env_get("ethrotate");
>  
>  	/*
>  	 * When 'ethrotate' variable is set to 'no' and 'ethact' variable
> @@ -298,8 +308,10 @@ int eth_init(void)
>  	if ((ethrotate != NULL) && (strcmp(ethrotate, "no") == 0)) {
>  		if (ethact) {
>  			current = eth_get_dev_by_name(ethact);
> -			if (!current)
> -				return -EINVAL;
> +			if (!current) {
> +				ret = -EINVAL;
> +				goto end;
> +			}
>  		}
>  	}
>  
> @@ -307,7 +319,8 @@ int eth_init(void)
>  		current = eth_get_dev();
>  		if (!current) {
>  			log_err("No ethernet found.\n");
> -			return -ENODEV;
> +			ret = -ENODEV;
> +			goto end;
>  		}
>  	}
>  
> @@ -324,7 +337,8 @@ int eth_init(void)
>  
>  					priv->state = ETH_STATE_ACTIVE;
>  					priv->running = true;
> -					return 0;
> +					ret = 0;
> +					goto end;
>  				}
>  			} else {
>  				ret = eth_errno;
> @@ -344,6 +358,8 @@ int eth_init(void)
>  		current = eth_get_dev();
>  	} while (old_current != current);
>  
> +end:
> +	in_init_halt = false;
>  	return ret;
>  }
>  
> @@ -352,17 +368,25 @@ void eth_halt(void)
>  	struct udevice *current;
>  	struct eth_device_priv *priv;
>  
> +	if (in_init_halt)
> +		return;
> +
> +	in_init_halt = true;
> +
>  	current = eth_get_dev();
>  	if (!current)
> -		return;
> +		goto end;
>  
>  	priv = dev_get_uclass_priv(current);
>  	if (!priv || !priv->running)
> -		return;
> +		goto end;
>  
>  	eth_get_ops(current)->stop(current);
>  	priv->state = ETH_STATE_PASSIVE;
>  	priv->running = false;
> +
> +end:
> +	in_init_halt = false;
>  }
>  
>  int eth_is_active(struct udevice *dev)
> -- 
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> https://www.tq-group.com/
> 
