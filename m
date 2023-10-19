Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E21CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:16:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 669BE8727D;
	Thu, 19 Oct 2023 17:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="sOcRpCW5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7100E87281; Thu, 19 Oct 2023 17:16:40 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69BA686F6C
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:16:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B99F0404AC
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 15:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1697728594;
 bh=UQjDY2OL66BNE9EnMRx7z9kky2wr1dVAx9Ko8T94Ock=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=sOcRpCW5/lIjOmHg8rs+XAW+5QUYFtZNVN/NKpP4Xt4+jiIsYTRany0UQsg+TxWJu
 ksJzbGJAJ0M1Wotvwtdmq666C99L0XtJX1EhfuejfpwWWk64Iw+oitWgnumf+sQL1I
 Hy7V1zmuExD26H51H1dfojCDpLYFY6wGuzwMkNCa02drEvNejqWyDAP8kqGYAMMlbZ
 Wryvui/UQyI/9a5DMAQ8n3X3wEyJAhPCafQNAEjAQ6gbwPP3N3aDC+3/T3d9sPDkYx
 Q7PJ5xhBeGsQbSI+txL47fQOdIGLzMLOLm0Kza1WOabss0lcDokODNYkbYM9OPjSn8
 /+fTreXWQpo0w==
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32da39f7f2bso3453813f8f.0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:16:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697728590; x=1698333390;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UQjDY2OL66BNE9EnMRx7z9kky2wr1dVAx9Ko8T94Ock=;
 b=UbOFwtEtfKkNlXaG+QmlF+f/pHlaLFEONkdXB4yW3sZtmUiWi4Td88onINLfB29fCE
 cuUrg6buswvPrWLH/t9E2M5P4kRKpIinTTmo944PTAbHJkYtS8UMcrzrc3XvzVPhXqJm
 eVpU524doP3NLGcoFN8tzYhEPTIQgFJ38LcKAvXBI7Zejop5WFaL5/7UDN71qbF8ksHw
 +zphGbY1JEeTXK2CSpYmDZ1/GdxWEFMmNxDotj+AxyzdFF+/DQhM+DZW4AohgFJ1SXvW
 FOydwWLHuyapfuFyd5+Y1zKaXybC8M6Xb8602PzkKkHQRGvkq3GV9CTrXoGQllS56wc6
 Eoew==
X-Gm-Message-State: AOJu0YwRiy2WsNRk3NE/0R8bF1/sckfxl5A3SEV/Qo0samJFHvv2VjrO
 XOKiJ1xCSxc52vLG9JH7VHAA07pdOc/hfjMBlOYpRkNnSrTLuukgDwmT9Zj1bSouhmXtcbFEl5U
 yM6lK/jB6yVM05phdfanIkz3z6uD20VA=
X-Received: by 2002:a05:6000:1042:b0:321:4de3:fd5c with SMTP id
 c2-20020a056000104200b003214de3fd5cmr1981269wrx.51.1697728590092; 
 Thu, 19 Oct 2023 08:16:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz3kCQLyCs6AwBe4FRq+IzdPDq1cShcfbrNfyjdpmMcFk1C5W/EVi4YDi6lsdRs2kt/i/EBA==
X-Received: by 2002:a05:6000:1042:b0:321:4de3:fd5c with SMTP id
 c2-20020a056000104200b003214de3fd5cmr1981250wrx.51.1697728589594; 
 Thu, 19 Oct 2023 08:16:29 -0700 (PDT)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 i7-20020adffdc7000000b00324853fc8adsm4652560wrs.104.2023.10.19.08.16.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 08:16:29 -0700 (PDT)
Message-ID: <4a17c974-fd56-4412-93e3-47bfe3268489@canonical.com>
Date: Thu, 19 Oct 2023 17:16:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 11/24] efi: Rearrange the Kconfig for CMD_BOOTEFI_BOOTMGR
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20231019150105.714407-1-trini@konsulko.com>
 <20231019150105.714407-11-trini@konsulko.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20231019150105.714407-11-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 19.10.23 17:00, Tom Rini wrote:
> From: Simon Glass <sjg@chromium.org>
> 
> The command should not be used to enable library functionality. Add a
> new BOOTEFI_BOOTMGR Kconfig for that. Adjust the conditions so that the
> same code is built.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
> Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Changes in v4:
> - Integrate AKASHI Takahiro's feedback from v3
> - Reword the help text on CMD_BOOTEFI_BOOTMGR slightly
> ---
>   cmd/Kconfig             | 11 ++++++++++-
>   lib/efi_loader/Kconfig  |  6 +++---
>   lib/efi_loader/Makefile |  2 +-
>   3 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 16e5cb8f0633..872cb49150cc 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -379,6 +379,15 @@ config CMD_BOOTEFI
>   	help
>   	  Boot an EFI image from memory.
>   
> +config CMD_BOOTEFI_BOOTMGR
> +	bool "UEFI Boot Manager command"
> +	depends on BOOTEFI_BOOTMGR && CMD_BOOTEFI
> +	default y
> +	help
> +	  Select this option to enable the 'bootmgr' subcommand of 'bootefi'.
> +	  This subcommand will allow you to select the UEFI binary to be booted
> +	  via UEFI variables Boot####, BootOrder, and BootNext.
> +
>   config CMD_BOOTEFI_HELLO_COMPILE
>   	bool "Compile a standard EFI hello world binary for testing"
>   	depends on CMD_BOOTEFI && !CPU_V7M
> @@ -2110,7 +2119,7 @@ config CMD_EFIDEBUG
>   config CMD_EFICONFIG
>   	bool "eficonfig - provide menu-driven uefi variables maintenance interface"
>   	default y if !HAS_BOARD_SIZE_LIMIT
> -	depends on CMD_BOOTEFI_BOOTMGR
> +	depends on BOOTEFI_BOOTMGR
>   	select MENU
>   	help
>   	  Enable the 'eficonfig' command which provides the menu-driven UEFI
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index d20aaab6dba4..13cad6342c36 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -32,14 +32,14 @@ config EFI_LOADER
>   
>   if EFI_LOADER
>   
> -config CMD_BOOTEFI_BOOTMGR
> +config BOOTEFI_BOOTMGR
>   	bool "UEFI Boot Manager"
>   	default y
>   	select BOOTMETH_GLOBAL if BOOTSTD
>   	help
>   	  Select this option if you want to select the UEFI binary to be booted
> -	  via UEFI variables Boot####, BootOrder, and BootNext. This enables the
> -	  'bootefi bootmgr' command.
> +	  via UEFI variables Boot####, BootOrder, and BootNext. You should also
> +	  normally enable CMD_BOOTEFI_BOOTMGR so that the command is available.
>   
>   choice
>   	prompt "Store for non-volatile UEFI variables"
> diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
> index 8d31fc61c601..0a2cb6e3c476 100644
> --- a/lib/efi_loader/Makefile
> +++ b/lib/efi_loader/Makefile
> @@ -42,7 +42,7 @@ targets += initrddump.o
>   endif
>   
>   obj-$(CONFIG_CMD_BOOTEFI_HELLO) += helloworld_efi.o
> -obj-$(CONFIG_CMD_BOOTEFI_BOOTMGR) += efi_bootmgr.o
> +obj-$(CONFIG_BOOTEFI_BOOTMGR) += efi_bootmgr.o
>   obj-y += efi_boottime.o
>   obj-y += efi_helper.o
>   obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += efi_capsule.o

This patch looks wrong.

Symbol CONFIG_CMD_BOOTEFI_BOOTMGR is used in a lot of places where it is 
not related to the 'bootefi bootmgr' subcommand.

I see no benefit in two separate symbols. If you want to rename the 
symbol, please, replace *all* occurrences:

%s/CONFIG_CMD_BOOTEFI_BOOTMGR/CONFIG_BOOTEFI_BOOTMGR/

Best regards

Heinrich
