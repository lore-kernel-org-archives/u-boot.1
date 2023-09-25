Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC71ECE7A89
	for <u-boot@archiver.kernel.org>; Mon, 25 Sep 2023 08:14:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D22786BBC;
	Mon, 25 Sep 2023 10:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1695629663;
	bh=cKouzqBbRfZWEFzNKJ6hFOLyvVZ8Z1gH1Z1xdSZuTAc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VYFXHllXXKKXFWgFBtDsSZUYvauEymhGHZuSbudvTmAQrqMPbFP/PgsjpNEZAwrbY
	 vHTES4MMP5EAN+PLi/yNGBRvwuDFfGIWLDAsOIlp/tmizw0ePf5N2lvPc5W3m+OsVZ
	 Gey2QVb/SUR4Nerv+QhasrzSiN5dSZKnmUGgIAfcXxp3LBzsBipPNNjkQ2Kazd0CqE
	 ckRH0VFioaBAKm7w3yXKTaBifQeCUyvucIa80L6r2A0ZOh8+N+x1GnswY6mQUIMbP6
	 4CGXDYpIbs4C5/sXX+5/su5LGTplWWX68oaUaWK5eXEByXkPYuASRXimrp+Uy+pYrX
	 53QKdp0OQVE0Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC89586B7E; Mon, 25 Sep 2023 10:14:21 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09ADC86BBC
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 10:14:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4RvFyf03B4z9sqK;
 Mon, 25 Sep 2023 10:14:18 +0200 (CEST)
Message-ID: <e5f5a68d-9f2f-9c39-b969-508275da454f@denx.de>
Date: Mon, 25 Sep 2023 10:14:16 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm: mvebu: sata_mv: Add bootstd hook to enable
 sata_bootdev
To: Tony Dinh <mibodhi@gmail.com>, Simon Glass <sjg@chromium.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20230906052242.21568-1-mibodhi@gmail.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20230906052242.21568-1-mibodhi@gmail.com>
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

On 9/6/23 07:22, Tony Dinh wrote:
> Add hook in sata_mv probe to enable bootstd bootdev.
> 
> Note: bootdev_setup_for_sibling_blk() invocation is a noop if bootsd is
> not enabled for ahci sata yet.
> 
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
>   drivers/ata/sata_mv.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
> index 18c7a66db1..55a5365b5a 100644
> --- a/drivers/ata/sata_mv.c
> +++ b/drivers/ata/sata_mv.c
> @@ -34,6 +34,7 @@
>   #include <common.h>
>   #include <ahci.h>
>   #include <blk.h>
> +#include <bootdev.h>
>   #include <cpu_func.h>
>   #include <dm.h>
>   #include <log.h>
> @@ -1104,6 +1105,12 @@ static int sata_mv_probe(struct udevice *dev)
>   			/* TODO: undo create */
>   			continue;
>   
> +		ret = bootdev_setup_for_sibling_blk(blk, "sata_bootdev");
> +		if (ret) {
> +			printf("%s: Failed to create bootdev\n", __func__);
> +			continue;
> +		}
> +
>   		/* If we got here, the current SATA port was probed
>   		 * successfully, so set the probe status to successful.
>   		 */
> @@ -1116,7 +1123,6 @@ static int sata_mv_probe(struct udevice *dev)
>   static int sata_mv_scan(struct udevice *dev)
>   {
>   	/* Nothing to do here */
> -
>   	return 0;
>   }
>   

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
