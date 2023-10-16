Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE1ECDB474
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 08:32:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 094F286BB4;
	Mon, 16 Oct 2023 10:32:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697445171;
	bh=uqaMNcuqkOpySuY1W0aORcQICVkPsc0VDIxqJPsiZPU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x6EH137Y8vbv2PLMz3q2Kog8wTLziDPZKGzlJpaF9/ZX2jvJJkEKFkj1guIEs7G1+
	 JcdTfzBaQThbTOt2r7cBKUdh03JR1Ts+9p4QtOrya0ocb9bkSR7BnYkKPQSVymuQHm
	 KLxlHe47g8ENo5BfdE4qYpenAokkOocjk8OvL30/JE+MzKEdX/s7D2ZrWB0ghq+TTA
	 ej1+6kZpGcgPKAXuhHuExTb/RI7Ji8xlY1XzbnS2cq7LCzgxesKkGWmd+3VKXOWN9R
	 E3dwOHzboPvZ/VPWQhMBMxBAoOAH8qIxce3GW6fkyQe1TqE/zbrCogo5n+s/yAP9g7
	 22pYYPAq5hNJA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA6DD86B1D; Mon, 16 Oct 2023 10:32:31 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7A9C86B79
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 10:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4S89Mv500yz9sTS;
 Mon, 16 Oct 2023 10:32:27 +0200 (CEST)
Message-ID: <5e93d3d4-39ee-4ab9-92e1-1dd7aa4ff68a@denx.de>
Date: Mon, 16 Oct 2023 10:32:27 +0200
MIME-Version: 1.0
Subject: Re: [RESEND PATCH] bootstd: sata: bootdev scanning for ahci sata with
 no drive attached
Content-Language: en-US
To: Tony Dinh <mibodhi@gmail.com>, Simon Glass <sjg@chromium.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20231007033429.25109-1-mibodhi@gmail.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20231007033429.25109-1-mibodhi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/7/23 05:34, Tony Dinh wrote:
> It's normal to have no SATA drive attached to the controller, so return a
> successful status when there is no block device found after probing.
> 
> Note: this patch depends on the previous patch
> https://patchwork.ozlabs.org/project/uboot/patch/20230917230649.30357-1-mibodhi@gmail.com/
> 
> Resend the right patch.
> 
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
>   drivers/ata/sata.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/ata/sata.c b/drivers/ata/sata.c
> index f126b84e05..dcb5fcf476 100644
> --- a/drivers/ata/sata.c
> +++ b/drivers/ata/sata.c
> @@ -79,6 +79,12 @@ int sata_rescan(bool verbose)
>   
>   	ret = uclass_probe_all(UCLASS_AHCI);
>   
> +	if (ret == -ENODEV) {
> +		if (verbose)
> +			printf("No SATA block device found\n");
> +		return 0;
> +	}
> +
>   	return ret;
>   }
>   

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
