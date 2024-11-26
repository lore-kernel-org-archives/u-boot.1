Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5499D5A6FD
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 08:30:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E50F89140;
	Tue, 26 Nov 2024 09:30:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732609855;
	bh=lXN2wKm1IA+Pj553lyFRCHY2TmHJY14MwLZuV2nVpNM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oTfItgOK6/UQ/QqHsUfnMR9XniSRA+t2c4i7V3H5RNZjnrgIFj/MSdbyegft/tu9+
	 vvJ3kC5eq03WOvnYfzELTB1teipgZbD+jkCrNtNHEyU6KM28ML5O3Oxf6axU6FMipB
	 ruqIePjkCIKA1GaXMk2GF2pILH7vcik7tvkowX0BQcZmEl38OQbhG5hZrOcc/MRQhr
	 Nww7rfI3+OQtqqrRKlnxcuUkJwH6kJMsYZX314h8IJirJCzRl5uZE0t/mwPr4odvEF
	 Ff+wTymfExoVM1hbbkCNW5O0iwTBm0z6rT0zPtkMK6jezlpMKanHvFKxA2ChB6cH4T
	 E8UHcSXx6Nmrg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB14A88ECC; Tue, 26 Nov 2024 09:30:54 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3D9089C42
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 09:30:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4XyG4C3zHMz9t5J;
 Tue, 26 Nov 2024 09:30:51 +0100 (CET)
Message-ID: <07f3ae29-844b-477b-a354-c9a4f533a372@denx.de>
Date: Tue, 26 Nov 2024 09:30:48 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 5/7] arm: mvebu: x530: Remove dead comments
To: Chris Packham <judge.packham@gmail.com>, u-boot@lists.denx.de
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <20241122003058.270163-1-judge.packham@gmail.com>
 <20241122003058.270163-6-judge.packham@gmail.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241122003058.270163-6-judge.packham@gmail.com>
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

On 22.11.24 01:30, Chris Packham wrote:
> As things have been moved to Kconfig there are a number of dead comments
> left over in x530.h. Remove them.
> 
> Signed-off-by: Chris Packham <judge.packham@gmail.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
>   include/configs/x530.h | 16 ----------------
>   1 file changed, 16 deletions(-)
> 
> diff --git a/include/configs/x530.h b/include/configs/x530.h
> index 982b12928734..c7bfd1de17c5 100644
> --- a/include/configs/x530.h
> +++ b/include/configs/x530.h
> @@ -18,30 +18,14 @@
>   #define CFG_SYS_NS16550_COM1		MV_UART_CONSOLE_BASE
>   #endif
>   
> -/*
> - * Serial Port configuration
> - * The following definitions let you select what serial you want to use
> - * for your console driver.
> - */
> -
>   /* NAND */
>   
>   #define BBT_CUSTOM_SCAN
>   #define BBT_CUSTOM_SCAN_PAGE 0
>   #define BBT_CUSTOM_SCAN_POSITION 2048
>   
> -/* SPI NOR flash default params, used by sf commands */
> -
>   #define MTDPARTS_MTDOOPS		"errlog"
>   
> -/* Partition support */
> -
> -/* Additional FS support/configuration */
> -
> -/* Environment in SPI NOR flash */
> -
> -/* NAND */
> -
>   #include <asm/arch/config.h>
>   
>   /* Keep device tree and initrd in low memory so the kernel can access them */

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

