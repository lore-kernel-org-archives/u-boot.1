Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A85FC3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 14:26:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0E1B829E7;
	Tue,  6 May 2025 16:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1746541579;
	bh=EzHn1f0PgRtJSGXSL/rkLx+DgICQ/dj4BlKDWy5fHc4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PBXzHo7Es5e27yTjUDjsvMUht690SxSSD+obpP7uCDSKxtGuXJMNAqcYOqUnHjNYP
	 TgHwnzB67bzi1borIzzdc2MF0iCr5oG8GC5iGiZO34ssTGONmETIqriVl8B/ALDlKm
	 1pMhzuSYBZFn9o4ycB/63mThW2vXMbMBFOwK4v3CivqwzRuEH5m/MUGFFPXmwdhhR1
	 hGonAmjNuZBTWEyRanfRgJxDWlmqqsQ2hSsJygv5Nb3L3jOIW6DTMnD0SnpMrE9o+Z
	 zRGr0AGaMbEMdJo4fYgESZl4tXkYUeQnD8FrAUNIs3iiCCUeihGQxqE+3IV40ryoQa
	 gurfBLo2kVpQQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DA31829EF; Tue,  6 May 2025 16:26:19 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [80.241.59.204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 138E982163
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 16:26:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4ZsLKy2GWRz9tdS;
 Tue,  6 May 2025 16:26:14 +0200 (CEST)
Message-ID: <242c3bff-4793-4524-8534-2bd235183645@denx.de>
Date: Tue, 6 May 2025 16:26:13 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] arm: kirkwood: Convert to DM_SERIAL for Synology
 DS109 board
To: Tony Dinh <mibodhi@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Walter Schweizer <swwa@users.sourceforge.net>
References: <20250506025843.11019-1-mibodhi@gmail.com>
 <20250506025843.11019-2-mibodhi@gmail.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250506025843.11019-2-mibodhi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ZsLKy2GWRz9tdS
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

On 06.05.25 04:58, Tony Dinh wrote:
> Enable DM_SERIAL for Marvell Kirkwood Synology DS109.
> 
> Note that this patch depends on:
> https://patchwork.ozlabs.org/project/uboot/patch/20250505220853.23679-1-mibodhi@gmail.com/
> 
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
>   arch/arm/mach-kirkwood/Kconfig | 1 +
>   configs/ds109_defconfig        | 2 --
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
> index 26fcd3732d1..f1ccedba5d7 100644
> --- a/arch/arm/mach-kirkwood/Kconfig
> +++ b/arch/arm/mach-kirkwood/Kconfig
> @@ -50,6 +50,7 @@ config TARGET_DS109
>   	bool "Synology DS109"
>   	select KW88F6281
>   	select SHEEVA_88SV131
> +	select KIRKWOOD_COMMON
>   
>   config TARGET_GURUPLUG
>   	bool "GuruPlug Board"
> diff --git a/configs/ds109_defconfig b/configs/ds109_defconfig
> index ef805eca562..1dafef3529b 100644
> --- a/configs/ds109_defconfig
> +++ b/configs/ds109_defconfig
> @@ -54,8 +54,6 @@ CONFIG_MVGBE=y
>   CONFIG_MII=y
>   CONFIG_DM_RTC=y
>   CONFIG_RTC_MV=y
> -CONFIG_SYS_NS16550_SERIAL=y
> -CONFIG_SYS_NS16550_REG_SIZE=-4
>   CONFIG_SPI=y
>   CONFIG_DM_SPI=y
>   CONFIG_KIRKWOOD_SPI=y

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

