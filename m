Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B9AC54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 10:00:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A7DE880DB;
	Thu, 28 Mar 2024 11:00:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711620008;
	bh=mBCM6kw7EK00lOyEzIwK32tRV0g7YN/S+rk+LFSVL7s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YK6A7RBFlZXotMRmG+Qj8SPlzD4oc7bHf09XLDHmrCIuiUqt3/2UzJDMTriFHiEX+
	 9BrqibKrl/dK0C0ZvtGAqJm5rqmqukb1Lm0FgcGzSTRpU1B9SXDAmCVHVmZvKiIzq9
	 s3ZBNle4q/Lvr4Gj+QhMpGpfIN6JIQ7BcTx9uVKnVYTA7hyjCsqdYJJ9uPElbiTgMX
	 d802iIIBQQxHofrYbGm1Vkio6bmS7gKtahSUCd/52jHpdkGneaYVlP1B0Nie4gZmnK
	 h7XTPGyrFu4X36lmF5la8X+hRGAihgVjmzzbcY2XtSc5TJ7HOpNO+ZtzneSJ6CErOI
	 womAcEUVuNRbw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DE98880FA; Thu, 28 Mar 2024 11:00:06 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68B1287E75
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 11:00:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4V4zYG3d23z9smW;
 Thu, 28 Mar 2024 11:00:02 +0100 (CET)
Message-ID: <aa448173-bdec-4b35-b0ba-036b7acfd379@denx.de>
Date: Thu, 28 Mar 2024 11:00:02 +0100
MIME-Version: 1.0
Subject: Re: [PATCH u-boot-mvebu v3 10/18] arm: mvebu: system-controller:
 Select mvebu-reset if DM_RESET && PCI_MVEBU
Content-Language: en-US
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: u-boot@lists.denx.de
References: <20240327162355.24584-1-kabel@kernel.org>
 <20240327162355.24584-11-kabel@kernel.org>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240327162355.24584-11-kabel@kernel.org>
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

On 3/27/24 17:23, Marek Behún wrote:
> The mvebu-reset driver is only needed by the mvebu PCIe driver, but
> currently it is automatically selected if DM_RESET is enabled. Add the
> condition of PCI_MVEBU also being enabled for mvebu-reset to be
> selected.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   arch/arm/mach-mvebu/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index 62a2bc5958..623432a60e 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -18,7 +18,7 @@ config ARMADA_32BIT
>   	select TOOLS_KWBIMAGE if SPL
>   	select SPL_SYS_NO_VECTOR_TABLE if SPL
>   	select ARCH_VERY_EARLY_INIT
> -	select ARMADA_32BIT_SYSCON_RESET if DM_RESET
> +	select ARMADA_32BIT_SYSCON_RESET if DM_RESET && PCI_MVEBU
>   
>   # ARMv7 SoCs...
>   config ARMADA_375

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
