Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD709C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 14:25:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5386082935;
	Tue,  6 May 2025 16:25:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1746541544;
	bh=C4QRHiUWyNLSLnEDms6k81Rb8pXxMwEC0xQDW0KtPjs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lbSmlBFUMfqLpIHF0aFs4/W9XIRF1KBRoeBWVZC4aT81tPT9x0xIp46yHP+pyyX7U
	 XSR+rk+YSZJW6iy3bsW1JgzsCxIpeyxVyyGRcyddiwC9Mcn+9ulFhqifsj0q4SVaS+
	 tn4d2ADX2KphxWnhB96QzXcBFLm3cUsUA+DAzK+NWzjdcsLRazRLgr8nG/fViXb66Z
	 iYdzce6YRdbToe/Oo/I/igt1bATxLm2JHRjHtGYvYLT+Bi2Y4pUH+vyEM+evkrfdrm
	 BPgKb3T22Dzn2mba2K4v7ZnJBnB/PluYKN4o5zs2tJ3dnG+ZNvgVq8h0DJSJWWqR6u
	 oMkCllZxLlORw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF77582999; Tue,  6 May 2025 16:25:42 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B35B582163
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 16:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4ZsLKF3trxz9tdR;
 Tue,  6 May 2025 16:25:37 +0200 (CEST)
Message-ID: <550f8d50-8fd2-4177-8648-a38cb8156fe6@denx.de>
Date: Tue, 6 May 2025 16:25:35 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm: kirkwood: Convert to DM_SERIAL for Kirkwood boards
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
References: <20250505220853.23679-1-mibodhi@gmail.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250505220853.23679-1-mibodhi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ZsLKF3trxz9tdR
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

On 06.05.25 00:08, Tony Dinh wrote:
> Enable DM_SERIAL for Marvell Kirkwood boards that have not been converted.
> 
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
>   arch/arm/mach-kirkwood/Kconfig | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
> index 6761a9cb393..26fcd3732d1 100644
> --- a/arch/arm/mach-kirkwood/Kconfig
> +++ b/arch/arm/mach-kirkwood/Kconfig
> @@ -55,6 +55,7 @@ config TARGET_GURUPLUG
>   	bool "GuruPlug Board"
>   	select KW88F6281
>   	select SHEEVA_88SV131
> +	select KIRKWOOD_COMMON
>   
>   config TARGET_SHEEVAPLUG
>   	bool "SheevaPlug Board"
> @@ -86,6 +87,7 @@ config TARGET_DNS325
>   	bool "dns325 Board"
>   	select FEROCEON_88FR131
>   	select KW88F6281
> +	select KIRKWOOD_COMMON
>   
>   config TARGET_ICONNECT
>   	bool "iconnect Board"
> @@ -103,15 +105,18 @@ config TARGET_NET2BIG_V2
>   	bool "LaCie 2Big Network v2 NAS Board"
>   	select FEROCEON_88FR131
>   	select KW88F6281
> +	select KIRKWOOD_COMMON
>   
>   config TARGET_NETSPACE_V2
>   	bool "LaCie netspace_v2 Board"
>   	select FEROCEON_88FR131
> +	select KIRKWOOD_COMMON
>   
>   config TARGET_IB62X0
>   	bool "ib62x0 Board"
>   	select FEROCEON_88FR131
>   	select KW88F6281
> +	select KIRKWOOD_COMMON
>   
>   config TARGET_DOCKSTAR
>   	bool "Dockstar Board"
> @@ -129,6 +134,7 @@ config TARGET_NAS220
>   	bool "BlackArmor NAS220"
>   	select FEROCEON_88FR131
>   	select KW88F6192
> +	select KIRKWOOD_COMMON
>   
>   config TARGET_NSA310S
>   	bool "Zyxel NSA310S"
> @@ -146,11 +152,13 @@ config TARGET_SBx81LIFKW
>   	bool "Allied Telesis SBx81GS24/SBx81GT40/SBx81XS6/SBx81XS16"
>   	select FEROCEON_88FR131
>   	select KW88F6281
> +	select KIRKWOOD_COMMON
>   
>   config TARGET_SBx81LIFXCAT
>   	bool "Allied Telesis SBx81GP24/SBx81GT24"
>   	select FEROCEON_88FR131
>   	select KW88F6281
> +	select KIRKWOOD_COMMON
>   
>   endchoice
>   

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

