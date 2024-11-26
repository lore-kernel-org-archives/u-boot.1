Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456ACD5A6FE
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 08:30:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D48B088F55;
	Tue, 26 Nov 2024 09:30:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732609806;
	bh=ft172msRSZg5Gtko/2I0z64kOcR5XOQpFhJJV2EWTaY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i17bnrLTGLT/qDAMj0aFKmpIPyADKGw2WyzH2bPBPFvlf93WmEX3fsaLp7I/9Ziry
	 5wGDTMK6NLnuoVnXlUnp7oaeEd2P5riwNtmkY47mVcat3NJdrk5H75Vnoq7R/zKYl9
	 OwEFgIhqQH51CFycJfiPI8ikc9EwHsGyjp3GtZOIMKoFqCybk2YG7JSKU1sSWlT29E
	 iQaYgmbVJIPz7LsKwbwAnpQQ2IkMWhwTYvqEhVF0/bIJS3WU2KuB7KrhnuxmhBLzlq
	 iwOdywrTS9FG1MRpI/qCcTMcqCtlTcvDRCOYIAL8z1uhfM1fAIMIUX7SHf1uBNjKjC
	 qssOZYoTX4Grg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EC2C89668; Tue, 26 Nov 2024 09:30:06 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F44588ECC
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 09:30:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4XyG3F0pyHz9t8h;
 Tue, 26 Nov 2024 09:30:01 +0100 (CET)
Message-ID: <86927b4b-f573-4d4c-83af-5b7fbe5adacb@denx.de>
Date: Tue, 26 Nov 2024 09:29:59 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/7] arm: mvebu: x240: Use default baudrate table
To: Chris Packham <judge.packham@gmail.com>, u-boot@lists.denx.de
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Tom Rini <trini@konsulko.com>
References: <20241122003058.270163-1-judge.packham@gmail.com>
 <20241122003058.270163-2-judge.packham@gmail.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241122003058.270163-2-judge.packham@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XyG3F0pyHz9t8h
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
> Remove CFG_SYS_BAUDRATE_TABLE as there's no reason not to use the
> defaults defined via config_fallbacks.h.
> 
> Signed-off-by: Chris Packham <judge.packham@gmail.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
>   include/configs/x240.h | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/include/configs/x240.h b/include/configs/x240.h
> index 3601df588d56..bc66e4e3c8e6 100644
> --- a/include/configs/x240.h
> +++ b/include/configs/x240.h
> @@ -11,9 +11,6 @@
>   /* additions for new ARM relocation support */
>   #define CFG_SYS_SDRAM_BASE   0x200000000
>   
> -#define CFG_SYS_BAUDRATE_TABLE   { 9600, 19200, 38400, 57600, \
> -				      115200, 230400, 460800, 921600 }
> -
>   /* Default Env vars */
>   
>   #define BOOT_TARGET_DEVICES(func) \

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

