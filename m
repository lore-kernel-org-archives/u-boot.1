Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD9EC41513
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 08:34:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 689BA868C0;
	Mon, 16 Oct 2023 10:34:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697445285;
	bh=CQiwtQf8CsGxPFGe1O5zNbRBaUVlOFkPR2cIOWQkcT8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LObd00ju7QbbdkKUHetNnOEF7C4qebo6UegqK7L8YsSOj5X1uxELe59XEtH7V1uVW
	 8ydjVVV3JcisOe5xXgUWwGmYsFSrnfyxNT9aZ+scN4Z461RBLII1/s98P5IJH9cizz
	 z7xV25SUmiNOLw/k++Wpe3/uJ7wmH8UPTl8ijcLXg28G6pYpQf8VAn9VM6dKhwtBqd
	 ypJgMSFwRQJ9rmZ/QCT0HnPx/TOUCZo02dZQwefFgW9N2d5BSGW0Z37tLkZg0l/yRX
	 oxUzxNSMWusERUpCldoy3014YeDxoamF1tzmr3GsPWNuz32wFt85X6Q/+pVjQciz4A
	 2Xo+NNz8QE98Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4ECDB868AE; Mon, 16 Oct 2023 10:34:41 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEAD28656E
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 10:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4S89QP6D6Lz9sq7;
 Mon, 16 Oct 2023 10:34:37 +0200 (CEST)
Message-ID: <cc07a6d2-8dbf-4e56-af16-ffe263002401@denx.de>
Date: Mon, 16 Oct 2023 10:34:37 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] arm: mvebu: allow additional 4096 offset for bootable
 mmc image
Content-Language: en-US
To: Josua Mayer <josua@solid-run.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, kabel@kernel.org
References: <20231008124621.18803-1-josua@solid-run.com>
 <20231008124621.18803-2-josua@solid-run.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20231008124621.18803-2-josua@solid-run.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4S89QP6D6Lz9sq7
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
> Disarm the error message forcing u-boot/spl image to be located at
> sector 0 on eMMC data-partition and microSD.
> Offset 0 makes sense on eMMC boot partitions only, data partition must
> use 4096 to avoid conflicting with MBR.
> 
> Valid offsets when booting from microSD, reported by boot-rom v1.73:
> 
> BootROM: Bad header at offset 00000200
> BootROM: Bad header at offset 00004400
> BootROM: Bad header at offset 00200000
> BootROM: Bad header at offset 00400000
> BootROM: Bad header at offset 00600000
> BootROM: Bad header at offset 00800000
> BootROM: Bad header at offset 00A00000
> BootROM: Bad header at offset 00C00000
> BootROM: Bad header at offset 00E00000
> BootROM: Bad header at offset 01000000
> BootROM: Bad header at offset 01200000
> BootROM: Bad header at offset 01400000
> BootROM: Bad header at offset 01600000
> BootROM: Bad header at offset 01800000
> BootROM: Bad header at offset 01A00000
> BootROM: Bad header at offset 01C00000
> BootROM: Bad header at offset 01E00000
> BootROM: Bad header at offset 02000000
> BootROM: Bad header at offset 02200000
> BootROM: Bad header at offset 02400000
> BootROM: Bad header at offset 02600000
> BootROM: Bad header at offset 02800000
> BootROM: Bad header at offset 02A00000
> BootROM: Bad header at offset 02C00000
> BootROM: Bad header at offset 02E00000
> 
> Valid offsets when booting from eMMC:
> 
> BootROM: Bad header at offset 00000000
> BootROM: Bad header at offset 00200000
> Switching BootPartitions.
> BootROM: Bad header at offset 00000000
> BootROM: Bad header at offset 00200000
> 
> Fixes: 2226ca17348 ("arm: mvebu: Load U-Boot proper binary in SPL code based on kwbimage header")
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   arch/arm/mach-mvebu/spl.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-mvebu/spl.c b/arch/arm/mach-mvebu/spl.c
> index 379daa88a4d..0dbc12f66ea 100644
> --- a/arch/arm/mach-mvebu/spl.c
> +++ b/arch/arm/mach-mvebu/spl.c
> @@ -71,8 +71,9 @@
>   #error CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR must be set to 0
>   #endif
>   #if !defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET) || \
> -    CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET != 0
> -#error CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET must be set to 0
> +    (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET != 0 && \
> +     CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET != 4096)
> +#error CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET must be set to either 0 or 4096
>   #endif
>   #endif
>   

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
