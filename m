Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A483E7E637
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 13:57:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3820986D8C;
	Tue, 26 Sep 2023 15:57:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="afKAieEN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 432D386D9C; Tue, 26 Sep 2023 15:57:48 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2064886D73
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 15:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38QDvf9I116828;
 Tue, 26 Sep 2023 08:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695736661;
 bh=SzxjTPY0bPnkiDDlneq2ebQoZ6jJPsbG2qyZgtsmG4E=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=afKAieENqpND4SyWPoHn+KakYJrE1nsuhfgdF03Cf+b920U1SCk7zBCtp73mGmo9R
 m1V89CXybqMq6z/GzMQyANnR9A/kK9cwZLOek/HS6N0JNOcd6guA8atjog9qagdzAR
 6yG3fDED6HKN6G0s/VFuhakJX4OgsPJMp9JuOaJQ=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38QDvf56002488
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 26 Sep 2023 08:57:41 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Sep 2023 08:57:40 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Sep 2023 08:57:40 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38QDve5w011450;
 Tue, 26 Sep 2023 08:57:40 -0500
Date: Tue, 26 Sep 2023 08:57:40 -0500
From: Nishanth Menon <nm@ti.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
CC: Andreas Dannenberg <dannenberg@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, 
 <u-boot@lists.denx.de>, <u-boot@ew.tq-group.com>
Subject: Re: [PATCH] mailbox: k3-sec-proxy: fix error handling for missing
 scfg in FDT
Message-ID: <20230926135740.eojuak7ckmid6vmu@deflation>
References: <20230926124254.127465-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230926124254.127465-1-matthias.schiffer@ew.tq-group.com>
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

On 14:42-20230926, Matthias Schiffer wrote:
> The wrong field was checked.
> 
> Fixes: f9aa41023bd9 ("mailbox: Introduce K3 Secure Proxy Driver")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  drivers/mailbox/k3-sec-proxy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/k3-sec-proxy.c b/drivers/mailbox/k3-sec-proxy.c
> index 815808498f2..27072610462 100644
> --- a/drivers/mailbox/k3-sec-proxy.c
> +++ b/drivers/mailbox/k3-sec-proxy.c
> @@ -326,7 +326,7 @@ static int k3_sec_proxy_of_to_priv(struct udevice *dev,
>  	}
>  
>  	spm->scfg = devfdt_get_addr_name(dev, "scfg");
> -	if (spm->rt == FDT_ADDR_T_NONE) {
> +	if (spm->scfg == FDT_ADDR_T_NONE) {
>  		dev_err(dev, "No reg property for Secure Cfg base\n");
>  		return -EINVAL;
>  	}

Uggh.. Thanks for catching this.

Reviewed-by: Nishanth Menon <nm@ti.com>
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
