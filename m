Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97BE0C021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 09:25:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0102C80FE2;
	Thu, 27 Feb 2025 10:25:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740648339;
	bh=5kjG56vlbRZ0H/4ts8h801jzs7ZogaU+QyVenVur/yw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZO4pdh408xXWCHCa5lQ+OySE6+alU313MTBxYRkp1KTppsMZCcOVoU5ifbC4OME0+
	 Uv8siZoghanpjkDHfwmXHpsVqmVX9mGkur2IL1JdaFIE2AGj2vSGcJZHGe6TiJzSzb
	 JF6IIbijnVQYEU6V2yv9hOM/vBAf28BdOdk6Tn7ZubOZ5S1oEEJ2Aen9Y9UwvxTTGI
	 2S/LDpF9pIgSe6UdQHoX2F0R8J56cutV0Pzm11GxZE2seY6m12A/34VUWbPpuYkKFM
	 yQ1HFJ4HvfLxqMrZaj1NojxhLFTcfJDCCtkJEYPSS6HQapG1SmcPs9njbZEG2CiFvR
	 AGeMNkjct0u+w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82D7880FF2; Thu, 27 Feb 2025 10:25:37 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B49080FE1
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 10:25:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4Z3QtP05m9z9tsd;
 Thu, 27 Feb 2025 10:25:33 +0100 (CET)
Message-ID: <a154ee92-ba2d-49b7-b128-2fcabd084bf5@denx.de>
Date: Thu, 27 Feb 2025 10:25:32 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] cmd: mvebu/bubt: Correct usage of IS_ENABLED() macro
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Tim Harvey <tharvey@gateworks.com>
References: <20250226203118.3831940-1-trini@konsulko.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250226203118.3831940-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4Z3QtP05m9z9tsd
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

On 26.02.25 21:31, Tom Rini wrote:
> This file was using IS_ENABLED() to test for CONFIG flags but omitted
> the CONFIG_ prefix and so did not work as expected.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Stefan Roese <sr@denx.de>
> 
> This does change how some platforms are built.

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   cmd/mvebu/bubt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cmd/mvebu/bubt.c b/cmd/mvebu/bubt.c
> index 5e4ffc40d729..6b7d9ee061d5 100644
> --- a/cmd/mvebu/bubt.c
> +++ b/cmd/mvebu/bubt.c
> @@ -931,7 +931,7 @@ static int check_image_header(void)
>   	size = le32_to_cpu(hdr->blocksize);
>   
>   	if (hdr->blockid == 0x78) { /* SATA id */
> -		struct blk_desc *blk_dev = IS_ENABLED(BLK) ? blk_get_devnum_by_uclass_id(UCLASS_SCSI, 0) : NULL;
> +		struct blk_desc *blk_dev = IS_ENABLED(CONFIG_BLK) ? blk_get_devnum_by_uclass_id(UCLASS_SCSI, 0) : NULL;
>   		unsigned long blksz = blk_dev ? blk_dev->blksz : 512;
>   		offset *= blksz;
>   	}

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

