Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17FFE7C4F4
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 07:54:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 987B386B9E;
	Thu,  5 Oct 2023 09:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1696492466;
	bh=nZGA/370ZyVxk9FGsULtgpQd8z6MjU2j3KYjnBU5pKk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sATjNflupgIVFuP9OdZGf74LfJ/ehVPdmE7m2LyyW98ZbL4nmdzWYrE91ERjDFBOZ
	 ONo4+Cdg9x8HAc6cqtKw4OGXzBnQWH5aNvnswjsp+Pm+Rr17nqQjyrpAmKsVf91z7v
	 3cARnEwj6gOFd6jWoIpPHrmtEPhN3DNu64HQUzUPxNh+FIZPt5rB2pl4vyY1AdqWPz
	 X5bj5kdkQRHukZwQ4UaJtAToT0DywnWe53rZ7RctjiQg8Cz/vz6xLO7dz8ZFIOmlR9
	 cKXw53NCcDUYV4yKWuqBRs3y2RBLiVFginOOeRXTU2gO8PbwCWTFw62Y2FN3hS8h4K
	 Y9G95iTDyrmHQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB59786EBB; Thu,  5 Oct 2023 09:54:24 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF93086B87
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 09:54:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4S1P3072W7z9sW7;
 Thu,  5 Oct 2023 09:54:20 +0200 (CEST)
Message-ID: <584ce229-7673-4c58-9459-7c63b32a903b@denx.de>
Date: Thu, 5 Oct 2023 09:54:19 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] arm: mvebu: x240: Disable SMBIOS
Content-Language: en-US
To: Chris Packham <judge.packham@gmail.com>, u-boot@lists.denx.de
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Tom Rini <trini@konsulko.com>
References: <20231003035800.2626121-1-judge.packham@gmail.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20231003035800.2626121-1-judge.packham@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4S1P3072W7z9sW7
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

On 10/3/23 05:57, Chris Packham wrote:
> The x240 doesn't make use of EFI or SMBIOS. Recently we started seeing
> boot failures such as
> 
>      WARNING: SMBIOS table_address overflow 23f60c020
>      Failed to write SMBIOS table
>      initcall failed at event 10/(unknown) (err=-22)
>      ### ERROR ### Please RESET the board ###
> 
> The error is because the physical address of the RAM on the AC5X SoC is
> above the 32GiB boundary. As we don't need SMBIOS or EFI this can be
> safely disabled.
> 
> Signed-off-by: Chris Packham <judge.packham@gmail.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
>   configs/x240_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/x240_defconfig b/configs/x240_defconfig
> index 7d2b8603e6f4..0d5a19df25aa 100644
> --- a/configs/x240_defconfig
> +++ b/configs/x240_defconfig
> @@ -84,3 +84,4 @@ CONFIG_USB_ETHER_MCS7830=y
>   CONFIG_USB_ETHER_RTL8152=y
>   CONFIG_USB_ETHER_SMSC95XX=y
>   # CONFIG_FAT_WRITE is not set
> +# CONFIG_SMBIOS is not set

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
