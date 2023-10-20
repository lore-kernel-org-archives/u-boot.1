Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A49BCDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 09:30:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF96B87459;
	Fri, 20 Oct 2023 11:30:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697794243;
	bh=Ufsjf2embr5DDNmEdbVdC3IjX2054maszAujS7ivENw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E63dGANhl9a7W9Hr+Gw7Ug0Vf8ctnvSVHB1n4JFTZnmC2OffUp5YqQwg7MEOAbiKc
	 KrlRETFqIsbSZHrN9F37XKwnAJtIxvtF/E4ZfSx7MgXPT1SXp+ldcy4cGOkisq+F6b
	 Ys8529b2HKKvFut+OYwnGKglWioVSYeUmr9Z2xa7dWaKoPQgnAWZR9m8+Ou/F8lWO5
	 J84JwkyA0Gpmbsc5mkZr5gJDZGP2JLnR+Mr+5tblaiVaF+VQROfNjrcrOcftatDGyB
	 ruWPFLgBA5OlMH9QwodPa2pgrJqv+ddO2L3isT9ZZgkI1FwtmQ0j5Dk3Z9nkOEqXrG
	 5fjPYqumYomTQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02AEC8745B; Fri, 20 Oct 2023 11:30:43 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DADD87280
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 11:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4SBfT80hvkz9t4F;
 Fri, 20 Oct 2023 11:30:36 +0200 (CEST)
Message-ID: <42f08b26-ad20-4edd-9e70-4e2d676c7f5a@denx.de>
Date: Fri, 20 Oct 2023 11:30:31 +0200
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
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4SBfT80hvkz9t4F
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

This patch leads to this error, e.g. for turris_mox_defconfig:

cmd/mvebu/bubt.c: In function 'mmc_burn_image':
cmd/mvebu/bubt.c:247:19: error: 'part' undeclared (first use in this 
function)
   247 |         else if (!part)
       |                   ^~~~
cmd/mvebu/bubt.c:247:19: note: each undeclared identifier is reported 
only once for each function it appears in

Could you please check and fix?

Thanks,
Stefan
