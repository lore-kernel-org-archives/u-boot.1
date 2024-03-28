Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D54C54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 09:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4B9D880C5;
	Thu, 28 Mar 2024 10:58:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711619887;
	bh=I3cdVcY/khqUoaX+WEAlBeAqvsFmy352yF0zct2fB98=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rmyYJOXfkdNDpLEhZQrZsZuPYto4fApzVA7OVnpUFpAUvU6CCDYMauQvfT8dZBgVb
	 nC8pCPbkyI1Ev5EP/CY1UXy/4kVLWnJ1ardx6DgXt21GUvLaaQCuLxqbRfpLiBkcnY
	 oa7FmmO4av1D5u2nz4Ad/khB80RQAfshQw5AJDEzhKXxeBVlM2/Btf3Gzh92/juAUd
	 9E6/9IsZgAMwB2u5F9qoS2pX5cwUymHlx+4UOly2aaM8fRXPvBv4wXNoYgHdVEKAxO
	 Eq2lSms7X7YYdLsRgnlkHAMFL2YL5a3+VoqTRrkfPftTiC+4b1TRNjCcQhumwiZro8
	 OmpwgJ5BdE2yQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E6B688123; Thu, 28 Mar 2024 10:58:07 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3B1987E75
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 10:58:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4V4zVz4wPjz9sNw;
 Thu, 28 Mar 2024 10:58:03 +0100 (CET)
Message-ID: <72cfc08c-e1fb-407a-bf8e-91d90a0302c5@denx.de>
Date: Thu, 28 Mar 2024 10:58:03 +0100
MIME-Version: 1.0
Subject: Re: [PATCH u-boot-mvebu v3 08/18] arm: mvebu: spl: Do not build
 mvebu-reset in SPL
Content-Language: en-US
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: u-boot@lists.denx.de
References: <20240327162355.24584-1-kabel@kernel.org>
 <20240327162355.24584-9-kabel@kernel.org>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240327162355.24584-9-kabel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4V4zVz4wPjz9sNw
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
> Commit 35e29e89a386 ("arm: mvebu: Implement simple mvebu-reset driver
> for enabling/disabling PCIe ports") made it so that the mvebu reset
> driver for enabling/disabling PCIe ports is build if CONFIG_DM_RESET is
> enabled. This is because PCI_MVEBU depends on DM_RESET.
> 
> But the driver should not be built for SPL. Indeed the PCI_MVEBU driver
> is not supported in SPL now, and so the mvebu-reset driver is not needed.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   arch/arm/mach-mvebu/Makefile | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
> index 0584ed2be5..ef790d97fe 100644
> --- a/arch/arm/mach-mvebu/Makefile
> +++ b/arch/arm/mach-mvebu/Makefile
> @@ -22,13 +22,14 @@ else # CONFIG_ARCH_KIRKWOOD
>   obj-y	= cpu.o
>   obj-y	+= dram.o
>   obj-y	+= lowlevel.o
> -obj-$(CONFIG_DM_RESET) += system-controller.o
>   ifndef CONFIG_SPL_BUILD
>   obj-$(CONFIG_ARMADA_375) += ../../../drivers/ddr/marvell/axp/xor.o
>   obj-$(CONFIG_ARMADA_38X) += ../../../drivers/ddr/marvell/a38x/xor.o
>   obj-$(CONFIG_ARMADA_XP) += ../../../drivers/ddr/marvell/axp/xor.o
>   obj-$(CONFIG_ARMADA_MSYS) += ../../../drivers/ddr/marvell/axp/xor.o
>   
> +obj-$(CONFIG_DM_RESET) += system-controller.o
> +
>   ifdef CONFIG_ARMADA_38X
>   obj-$(CONFIG_MVEBU_EFUSE) += efuse.o
>   endif

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
