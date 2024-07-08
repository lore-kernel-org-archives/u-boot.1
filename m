Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591CBC3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 14:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E10848878B;
	Mon,  8 Jul 2024 16:17:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720448253;
	bh=D6PUgNTvZT9HF1YRGYiSLOcVBu71GUn5rZx11iwPriA=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KoVef937PsVC+XOGK7yF8yawLqGQsO7x40+bCLCu+iTS/P7vpG9r/DZd2fRlqzDJR
	 GSgBabRjcvaF9lZ0EsPtk/9EPbnUBAlfRd8+5b71hEZvEjl1qus8ZzUpn4G/1wGdiX
	 5L052SlgKIfD8xliFSSMYZ6rnbFshQfHXLx79wpODAYRuw2EWFa5arurXNptE2IGzt
	 ILdgm0/EshdGhAKZzptVe2a9xQrFA/pHCOPiljFip8BYwzNxY2v48r3YLPUhxgJZoK
	 X9GvXQvxljSjUAiSwJmECtJCIpCuKrYa0mamgwy/upsgP9H8+c+F7i8PVzbPfVaBXm
	 s/B2C3qD92hlQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61DC38879C; Mon,  8 Jul 2024 16:17:32 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B8BD88756
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 16:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4WHmRD3t5Sz9s37;
 Mon,  8 Jul 2024 16:17:28 +0200 (CEST)
Message-ID: <3b675b0f-130d-45b6-822a-2f67c786d3a6@denx.de>
Date: Mon, 8 Jul 2024 16:17:28 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] mvebu: armada-8k: respect CONFIG_DISTRO_DEFAULTS
Content-Language: en-US
To: Robert Marko <robimarko@gmail.com>, trini@konsulko.com,
 u-boot@lists.denx.de
References: <20240621094613.1438806-1-robimarko@gmail.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240621094613.1438806-1-robimarko@gmail.com>
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

On 6/21/24 11:46, Robert Marko wrote:
> Currently, Armada 8k config header is setting boot devices and including
> <config_distro_bootcmd.h> regardless of the CONFIG_DISTRO_DEFAULTS being
> enabled or not, thus populating the environment for distro boot even on
> devices that have no need for it.
> 
> So, lets simply respect the value of CONFIG_DISTRO_DEFAULTS.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Applied to u-boot-marvell/master

Thanks,
Stefan

> ---
>   include/configs/mvebu_armada-8k.h | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/configs/mvebu_armada-8k.h b/include/configs/mvebu_armada-8k.h
> index 239a09763a..6fedbe9ee3 100644
> --- a/include/configs/mvebu_armada-8k.h
> +++ b/include/configs/mvebu_armada-8k.h
> @@ -30,7 +30,7 @@
>   /*
>    * PCI configuration
>    */
> -
> +#ifdef CONFIG_DISTRO_DEFAULTS
>   #define BOOT_TARGET_DEVICES(func) \
>   	func(MMC, mmc, 1) \
>   	func(MMC, mmc, 0) \
> @@ -40,6 +40,9 @@
>   	func(DHCP, dhcp, na)
>   
>   #include <config_distro_bootcmd.h>
> +#else
> +#define BOOTENV
> +#endif
>   
>   #define CFG_EXTRA_ENV_SETTINGS	\
>   	"scriptaddr=0x6d00000\0"	\

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
