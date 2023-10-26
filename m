Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBF0C25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 07:10:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77FB580EEB;
	Thu, 26 Oct 2023 09:10:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698304256;
	bh=BUBfTsZ62boHmFCtBJZ3lNmYCtAEgqZFMUA6VtHNpTk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iKEtdQgOzIqgBQcGmQ0Ng0/es46+N6mx9Az0zmIGVpGNB/8fyLYFcR/3VJ15SSBRL
	 U5yfItNm4oO6Sh3PPLc0k3yHHImGtF/RckyuFvIqTPIdKE89gdm4Mme0Nb9RZddeiL
	 sX0maQm1evOmrwqVofZcqTK8Gqgp6/kp2VrniwVZvMt4QRuZSU6VgAbw+YiZ3pXbMP
	 VRror7GFtsDT8kZt2tEdr/RyZCQFU4l5JNkGCeXR3hRuiZqGhfOX/biYuvqE5aM5y0
	 hqDQXA+yPIY/wrMUJufxTWQMY0lxsOZnxkSz/yJop+txcr+2LRrzXyEGwkz1Az+oUe
	 EN2dHCPitkdBA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5F1E86785; Thu, 26 Oct 2023 09:10:55 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A4BF80EEB
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 09:10:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4SGH581XrVz9sNv;
 Thu, 26 Oct 2023 09:10:52 +0200 (CEST)
Message-ID: <676d7ab5-da65-426e-a2fd-bf49539c9cca@denx.de>
Date: Thu, 26 Oct 2023 09:10:51 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] cmd: mvebu/bubt: move eMMC data-partition uboot
 from LBA-0 to 4096
Content-Language: en-US
To: Josua Mayer <josua@solid-run.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, kabel@kernel.org
References: <20231025082254.31630-1-josua@solid-run.com>
 <20231025082254.31630-3-josua@solid-run.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20231025082254.31630-3-josua@solid-run.com>
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

On 10/25/23 10:22, Josua Mayer wrote:
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
> V1 -> V2: fixed build without CONFIG_SUPPORT_EMMC_BOOT
> 
>   cmd/mvebu/bubt.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/cmd/mvebu/bubt.c b/cmd/mvebu/bubt.c
> index ca24a5c1c4b..744b1c20aa8 100644
> --- a/cmd/mvebu/bubt.c
> +++ b/cmd/mvebu/bubt.c
> @@ -240,9 +240,16 @@ static int mmc_burn_image(size_t image_size)
>   #endif
>   
>   	/* SD reserves LBA-0 for MBR and boots from LBA-1,
> -	 * MMC/eMMC boots from LBA-0
> +	 * MMC/eMMC boots from LBA-0 and LBA-4096
>   	 */
> -	start_lba = IS_SD(mmc) ? 1 : 0;
> +	if (IS_SD(mmc))
> +		start_lba = 1;
> +#ifdef CONFIG_SUPPORT_EMMC_BOOT
> +	else if (part)
> +		start_lba = 0;
> +#endif
> +	else
> +		start_lba = 4096;
>   #ifdef CONFIG_BLK
>   	blk_count = image_size / mmc->write_bl_len;
>   	if (image_size % mmc->write_bl_len)

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
