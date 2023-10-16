Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964EECDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 08:35:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAAB086BC8;
	Mon, 16 Oct 2023 10:35:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697445333;
	bh=72msSf6wSf4y9yvWWhcxq8DInW4AxwyB0M8uu0DQ+W0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o2kwAsIhsRIlAIqOE2jPBAq85WoGbpa9Vxrx1UjHFkmjp8yY9DBd5rnkt4+BxxQPg
	 rZ9Dk/7kc3lt1u7srO0rgX8hLYX3DbnvrYQouI9hQgKcmEYQhtYeh3ECsp/pVDNRl4
	 8hAG0DcZCADDUKsuj7VXus8UQY18XlgN82frDRFKjJYxGGnm815K+9hShsdRQ5JI6P
	 Bwhq+LUXRiny0kg9SGKIA/4iZc9x12SyJ67XvThkL62krEBwUUCuwJJPPp3CwWUNpE
	 7Oz+az4NnDEnvoju6HYPugB2zJ5XAesVXV74t4fVuGd8dpXDJSz/12vnb8VXWBEbs0
	 yNT+evBr9NlCQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3549786CFE; Mon, 16 Oct 2023 10:35:29 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02C1386BD7
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 10:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4S89R73J3Tz9smy;
 Mon, 16 Oct 2023 10:35:15 +0200 (CEST)
Message-ID: <35d71cbd-d952-4689-8cf2-ee3df024a7a1@denx.de>
Date: Mon, 16 Oct 2023 10:35:15 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] cmd: mvebu/bubt: move eMMC data-partition uboot from
 LBA-0 to 4096
Content-Language: en-US
To: Josua Mayer <josua@solid-run.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, kabel@kernel.org
References: <20231008124621.18803-1-josua@solid-run.com>
 <20231008124621.18803-3-josua@solid-run.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20231008124621.18803-3-josua@solid-run.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4S89R73J3Tz9smy
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

On 10/8/23 14:46, Josua Mayer wrote:
> A38x bootrom only searches 2 sectors when booting from eMMC,
> irregardless of data or boot partition: 0 & 4096.
> 
> For eMMC boot partitions sector 0 is fine, but on data partition it
> conflicts with MBR.
> 
> Change bubt command default to 4096 for eMMC data partition only, to
> allow using an MBR partition table on the eMMC data partition while also
> booting from it.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   cmd/mvebu/bubt.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/cmd/mvebu/bubt.c b/cmd/mvebu/bubt.c
> index ca24a5c1c4b..eb1fef9243d 100644
> --- a/cmd/mvebu/bubt.c
> +++ b/cmd/mvebu/bubt.c
> @@ -240,9 +240,14 @@ static int mmc_burn_image(size_t image_size)
>   #endif
>   
>   	/* SD reserves LBA-0 for MBR and boots from LBA-1,
> -	 * MMC/eMMC boots from LBA-0
> +	 * MMC/eMMC boots from LBA-0 and LBA-4096
>   	 */
> -	start_lba = IS_SD(mmc) ? 1 : 0;
> +	if (IS_SD(mmc))
> +		start_lba = 1;
> +	else if (!part)
> +		start_lba = 4096;
> +	else
> +		start_lba = 0;
>   #ifdef CONFIG_BLK
>   	blk_count = image_size / mmc->write_bl_len;
>   	if (image_size % mmc->write_bl_len)

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
