Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0163FEE49A4
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 10:00:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C811C86EE9;
	Sun, 20 Aug 2023 12:00:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="KPaJqpuS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B121A86EF7; Sun, 20 Aug 2023 12:00:44 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A167C86824
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 12:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692525640; x=1693130440; i=xypron.glpk@gmx.de;
 bh=egka8db7gpcSOmdEnKKUst5JrODYdJ3yQtfJ1AQ8rD8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=KPaJqpuSg9oAwmu4Sct25e7vlo63Gqu7nKfZqQjGDgwORCNHXQQi0k645k1ZjRuJISvX4Dj
 TNYyUoi+zNHK9mG7HDOpoeZLp1Dik3l17/hZRLJTJ6rnFiWUE4j0NusArNphL2la745cPD3nH
 kKUaQzApy5obBi0nDpjotVmd8BcUxoFRBbNpiaiavmYO/nBzCfrZ2r8hds5I7/DsCDgjHUyGd
 MDHYjHSJBCa+DsI1VTw0UJepKo8cbANPa5L/WP+9sB+qtQJjx6O8lX2FS/tMFE8fB78rtSpCQ
 Iz/MynLad2SSOMVkzbX1aFcmI+A08SvB613t46dMsX5fN7qEMAsA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.94] ([62.143.244.162]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrQEn-1pvHpP0mGN-00oT3P; Sun, 20
 Aug 2023 12:00:40 +0200
Message-ID: <4d09f5d8-bf1f-f9fe-e607-c6cf648789b6@gmx.de>
Date: Sun, 20 Aug 2023 12:01:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 12/19] x86: smbios: Add a Kconfig indicating
 SMBIOS-table presence
Content-Language: en-US, de-DE
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20230819212309.1094440-1-sjg@chromium.org>
 <20230819212309.1094440-13-sjg@chromium.org>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20230819212309.1094440-13-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fDcEZTpy/eEXAeH59JPGEAKxQTGaaVyvym96n4Gk7j4jMr/DKmq
 TX3DoeRYiipDpBeWxs9GJXvdYNOouSXhUE/4uljXEQoJeUygEwc/gXPV8zLP98T5vqikPjG
 Dwa0MqkcmkzuBbcizwgx1pGZmWJ8kTGsOMqKw520Ghis/Q7J+s79jW50DY95QD87W7g0gZN
 a/utZS3GVKkMKANTfTdzg==
UI-OutboundReport: notjunk:1;M01:P0:8Uz5lgtrehY=;rPfPklUq/RR0j2ezPaDBWpCAF1b
 NKr81IkOJ19pA6Yt+DVXZfLtx8Qx3gizxu0aYLZG828fqoMSqJJst5a3xeVd/2D4edP7R/M7t
 1e7sxAR7YItYDiADJFHdhO61eJQCduZMhpxLtH9Ypu7Tnmrmv1XxgyePEuJJPlKIC5SK7quH2
 AI1307H89Zd57ol3h5mXBGq5PvhGd5n+hWMRvJvywTJIS2+LPhk4d/WIxwodTYbVNQ/WEpCgq
 jozLP/tdRYhIj9H3sTFYG1wVk0vLFMyf8twI8Ox5Bp0w5vxpiMfjfwlggxP2ez4+meiFs/Ppi
 EXE2TQ/HZY/863PJfRtuGO8i2jjxNbeJQljZVYmF/ZbbH7Bgb1oLHvaPc/U0xz9/dd+rMGDPP
 pSZgTKldQhyg4p7srEjH4xJEQmTRBbalpXv13U5/Q71rkctfSOFs8qSWKBHEYKdJERQpdyZKL
 B3XwApvQ1wyCRvkrJGoSkF6UX+x8HCBC4UOQTNUDaWVFahlhs1ZLQBvsFBX+QrAmd5Jl2nhR9
 ++ogViu8ESchgkCnHWH3IY0zhFYLdt8idBUsswsfMeCSISXBMW/qnVpbbN439FLKLc22HiR1Y
 TMovBAGXnSq52DiY26RqtsV/s5eQu6tIHY/nx02DTv6e7Vsddzzko20LaiZWSZsSWdWe2FB9L
 2IxvsL8RmVRHt2nYoQNW4bgR/vbD2h7OsM7o80OThXSg7OndT4UGT1oprpHn3qsWmupX8NQuT
 otYEE73cajRoXxoDu+vG33Zoo3OEih5Eel2t1EljKh/WHlZV+qmRpAnbc1UbAWwdImFLiuzy/
 S9Yo6DVIvexVishMg1H+BZt1rWkU4YEzI2w7pN23dggjtGsx5DSsu6UvlzWKfFj3pkWPSNiEv
 gzJvQJykOEILBRxLhkJj+22VfkvbyiGXFSmsHrLcuJUmeUjYaL77PVzLzXYMaGvsp2FsAPOXY
 fVRnJAL129ONKziOnc89U54U66o=
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

On 8/19/23 23:22, Simon Glass wrote:
> When booted from coreboot, U-Boot does not build the SMBIOS tables, but
> it should still pass them on to the OS. Add a new option which indicates
> whether SMBIOS tables are present, however they were built.
>
> Flip the ordering so that the dependency is listed first, which is less
> confusing.
>
> Adjust GENERATE_SMBIOS_TABLE to depend on this new symbol.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v3:
> - Allow SMBIOS if EFI_LOADER is enabled
> - Reword the help
>
> Changes in v2:
> - Add new patch
>
>   lib/Kconfig | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index a9dca5f52b5a..8901b3a87fc2 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -984,8 +984,8 @@ config BLOBLIST_TABLES
>
>   config GENERATE_SMBIOS_TABLE
>   	bool "Generate an SMBIOS (System Management BIOS) table"
> +	depends on SMBIOS
>   	default y
> -	depends on X86 || EFI_LOADER
>   	help
>   	  The System Management BIOS (SMBIOS) specification addresses how
>   	  motherboard and system vendors present management information about
> @@ -1054,6 +1054,19 @@ config SPL_OID_REGISTRY
>   	  unambiguous persistent name (https://en.wikipedia.org/wiki/Object_i=
dentifier).
>   	  Enable fast lookup object identifier registry in the SPL.
>
> +config SMBIOS
> +	bool "SMBIOS support"
> +	depends on X86 || EFI_LOADER

Is there a calling convention for the legacy entry point of Linux to
pass SMBIOS tables on arm64 and riscv64?

> +	default y
> +	help
> +	  Indicates that this platform can support System Management BIOS
> +	  (SMBIOS) tables. These provide various pieces of information about
> +	  the board, such as the manufacturer and the model name.
> +
> +	  See GENERATE_SMBIOS_TABLE which controls whether U-Boot actually
> +	  creates these tables, rather than them coming from a previous firmwa=
re

Thanks for updating the help text.

This implies that CONFIG_SMBIOS must be used to decide if
efi_smbios_register() is called in efi_init_obj_list(). This change is
in patch 14/19.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> +	  stage.
> +
>   config SMBIOS_PARSER
>   	bool "SMBIOS parser"
>   	hel
