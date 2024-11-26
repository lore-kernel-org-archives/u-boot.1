Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7395ED5A6FE
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 08:31:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB10A89680;
	Tue, 26 Nov 2024 09:31:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732609866;
	bh=35nekdNaZmmZ1kI1jDJY02w/0ALU3QhpPhqbXTwRJMQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OsgiFUOQAYEKunDMQNtcYy0STBR0b7l8bMydnb/mB0ycrFCYl5GWlsnYWlwS0sxBe
	 zOZnnrNBA1XitJzUwzs9gvUYI9QGtiGHLeOwrDV28taIrJZRXk7+Nsu/Ln8d/mnNp2
	 +GNTINzwZDmhH2k68gH/dDJ1szgDdzxF0YtplrCuk9f43W+XLuZeD16rdkYMDFhfXz
	 7L3TOz6Dq3VyM9zPttRjA6I4VIgxT6BDCyW5mqwVtEpNltrp55rBj6SQe6cp/oN6nV
	 NYSmBOCFvayumO2sBEMi0V90/tTNlIQAC2w9ybrC0bnd1ffz6Im3h0WwtACphkPJAn
	 zEWoesIvVwRaw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FA4089680; Tue, 26 Nov 2024 09:31:03 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B30CE89677
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 09:31:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4XyG4M4pbRz9sjw;
 Tue, 26 Nov 2024 09:30:59 +0100 (CET)
Message-ID: <8f2ca68c-07fa-4642-8c45-83baf3474a39@denx.de>
Date: Tue, 26 Nov 2024 09:30:58 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 6/7] arm: mvebu: x530: Don't build mkeficapsule
To: Chris Packham <judge.packham@gmail.com>, u-boot@lists.denx.de
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Tom Rini <trini@konsulko.com>
References: <20241122003058.270163-1-judge.packham@gmail.com>
 <20241122003058.270163-7-judge.packham@gmail.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241122003058.270163-7-judge.packham@gmail.com>
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
> The x530 board doesn't use EFI and our toolchains don't include gnutls
> so disable the tool in the defconfig.
> 
> Signed-off-by: Chris Packham <judge.packham@gmail.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
>   configs/x530_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/x530_defconfig b/configs/x530_defconfig
> index 89612be631e3..a5b1cc3f8e89 100644
> --- a/configs/x530_defconfig
> +++ b/configs/x530_defconfig
> @@ -95,3 +95,4 @@ CONFIG_USB_ETHER_ASIX88179=y
>   CONFIG_WDT=y
>   CONFIG_WDT_ORION=y
>   CONFIG_SPL_TINY_MEMSET=y
> +# CONFIG_TOOLS_MKEFICAPSULE is not set

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

