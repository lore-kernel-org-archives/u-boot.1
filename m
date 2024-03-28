Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C533CC54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 10:18:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0CA288140;
	Thu, 28 Mar 2024 11:18:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711621127;
	bh=sMM4I6VQ0As82ZKBPkMkLfZQfJ6vvNw4SaaaJ7X2N0U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WYVbzaEvUzRp+tU1fcaBMh9oG8pKYQoJxvuFJ0SpOedu7iu6Vga5v0qdpAnXG/aH3
	 UppFMLoX/tmWXI1C6voPAzUT90W4ClBtyaWa8vz44rBoI45ilZcKhkIpeXYffKO83q
	 ZZKgKCcfbiteiEu8tV5Gg2BcsEygdXFPccjibA4dQ3bCKAx50GFWmDrRNIdftQ4vPM
	 USpJq0P7GMGLu3Rs9OJ5q+2wV/MO1F8MTb4PyXvvRx7gkMTuA40ytybwDzpZWctsHB
	 22zJ6e24pJ2Hdlt3Slv/92xC+OSpmt3nVkwKGLLvUSv6QjkMxTrpYYwqT9r5zKAlr6
	 Sc2bhXelV279A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D65A8813C; Thu, 28 Mar 2024 11:18:47 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80F9688141
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 11:18:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4V4zyq4nCbz9srk;
 Thu, 28 Mar 2024 11:18:43 +0100 (CET)
Message-ID: <929e3d62-e62e-49a1-98f3-06a7e7fc8909@denx.de>
Date: Thu, 28 Mar 2024 11:18:43 +0100
MIME-Version: 1.0
Subject: Re: [PATCH u-boot-mvebu v3 15/18] arm: mvebu: turris_omnia: Enable
 poweroff command via sysreset in defconfig
Content-Language: en-US
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: u-boot@lists.denx.de
References: <20240327162355.24584-1-kabel@kernel.org>
 <20240327162355.24584-16-kabel@kernel.org>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240327162355.24584-16-kabel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4V4zyq4nCbz9srk
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
> Enable support for the poweroff command via sysreset for Turris Omnia.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   configs/turris_omnia_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
> index 9d5171c6a8..0df0f3c90b 100644
> --- a/configs/turris_omnia_defconfig
> +++ b/configs/turris_omnia_defconfig
> @@ -65,6 +65,7 @@ CONFIG_CMD_I2C=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_MTD=y
>   CONFIG_CMD_PCI=y
> +CONFIG_CMD_POWEROFF=y
>   CONFIG_CMD_SATA=y
>   CONFIG_CMD_SPI=y
>   CONFIG_CMD_USB=y
> @@ -114,6 +115,7 @@ CONFIG_DEBUG_UART_SHIFT=2
>   CONFIG_SYS_NS16550=y
>   CONFIG_KIRKWOOD_SPI=y
>   CONFIG_SYSRESET=y
> +CONFIG_SYSRESET_CMD_POWEROFF=y
>   CONFIG_USB=y
>   CONFIG_USB_XHCI_HCD=y
>   CONFIG_USB_EHCI_HCD=y

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
