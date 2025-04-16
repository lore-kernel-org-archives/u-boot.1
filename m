Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C736C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 13:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A64C282DB4;
	Wed, 16 Apr 2025 15:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1744810313;
	bh=oA1+so6vJatq0CDuK4bQWZJNBLMt6iqp5Fih7B/qR3E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QQ3fajywiO6mTcHAMfhaVErGIV/OnJggTGICvlTYqIG9hMYMDOq5cYKS3zYswQSeO
	 w6/32R5duGqY+tJXezytHEtf9x9kOHXt3uy1X207i2jD3lTEZ9fcdim+6Z3dPEd1zZ
	 KON2Ox2KmJBgGhHo8M7DF0wSoNEThr1mBBr8L6bP1Ing9lUQjkmUL7/1hs5BmWR/0Y
	 uXIleBLVN4iTXVwkLX6yA0vtJ8HJEyXOZOUkqoAIkZRZC2sgVC25ZYZuKuBm56E24q
	 Zq2vQociT+UWSMSdvQUSr1TzCB61b6JHFhpcXD+yhqYlFNJp84CGfCrgzvE2nta1wL
	 NiMIQk8G64kpQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1257782E34; Wed, 16 Apr 2025 15:31:52 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07A31812BC
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 15:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4Zd24M4gpJz9tBt;
 Wed, 16 Apr 2025 15:31:47 +0200 (CEST)
Message-ID: <c978e12c-e96c-4397-800c-e7d9b9ca720d@denx.de>
Date: Wed, 16 Apr 2025 15:31:46 +0200
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
X-Rspamd-Queue-Id: 4Zd24M4gpJz9tBt
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

Applied to u-boot-marvell/master

Thanks,
Stefan

> ---
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Stefan Roese <sr@denx.de>
> 
> This does change how some platforms are built.
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

