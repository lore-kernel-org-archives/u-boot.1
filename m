Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FA6D41D74
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 07:49:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26F3680050;
	Mon, 15 Dec 2025 08:49:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SlPLOku+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2424880081; Mon, 15 Dec 2025 08:49:18 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FD328003E
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 08:49:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dVByy1nJqz9tSS;
 Mon, 15 Dec 2025 08:49:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765784954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DIiwuH2h7Eskb0MdNl7C3sS3XJMRTsMv28wYzbhIi7M=;
 b=SlPLOku+bqwfdu7NqG1D97JQojsEhBTAPBPTRqkWsLhhPFY573eYSkP/UoHm6xP5EXyx5z
 l3uVK6wa01dJMaaGjuVy/8N4SVFzpbT6G1xjLGAAzce7rYHDRGojyDBMw+NjJN38Obaw5E
 ih6BnBYAP/qMeDjWK9x/c1J3bSbzi3mEiooZ/vLxOWQBJqqV0GsihBZVMvKIDVQx+1JsZB
 Q3s+rg1o5vhdtsM17SUboQxV1nFZS/lj7EvvEbNioLaGeIS3UpO+v0eEm9f04UmtF1FbWO
 XgXunvYzv5qCfngu7Bv/Zc102n7hGTMRVJaprouR4XWgIokYN2qmLAP8hmEaLA==
Message-ID: <45c7bb4c-b106-4e05-8346-71febd156416@mailbox.org>
Date: Mon, 15 Dec 2025 08:49:13 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] arm: kirkwood: Remove unnecessary watchdog GPIO for ZyXEL
 NSA325 board
To: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20251210222754.23535-1-mibodhi@gmail.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20251210222754.23535-1-mibodhi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 0e9b075a17c01a523b0
X-MBO-RS-META: d9tfmjotinsh3f7fysne44o961a19unu
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

On 12/10/25 23:27, Tony Dinh wrote:
> Watchdog was already disabled in board/zyxel/nsa325/kwbimage.cfg.
> 
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
> 
>   board/zyxel/nsa325/nsa325.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/board/zyxel/nsa325/nsa325.c b/board/zyxel/nsa325/nsa325.c
> index 38340b33c8b..894c2ef293c 100644
> --- a/board/zyxel/nsa325/nsa325.c
> +++ b/board/zyxel/nsa325/nsa325.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   /*
> - * Copyright (C) 2014-2023 Tony Dinh <mibodhi@gmail.com>
> + * Copyright (C) 2014-2025 Tony Dinh <mibodhi@gmail.com>
>    *
>    * Based on
>    * Copyright (C) 2014  Jason Plum <jplum@archlinuxarm.org>
> @@ -51,11 +51,10 @@ DECLARE_GLOBAL_DATA_PTR;
>   #define HDD1_GREEN_LED		BIT(9)
>   #define HDD1_RED_LED		BIT(10)
>   #define HDD2_POWER		BIT(15)
> -#define WATCHDOG_SIGNAL		BIT(14)
>   
>   #define NSA325_OE_HIGH		(~(COPY_GREEN_LED | COPY_RED_LED | \
> -				   HDD1_GREEN_LED | HDD1_RED_LED | HDD2_POWER | WATCHDOG_SIGNAL))
> -#define NSA325_VAL_HIGH		(WATCHDOG_SIGNAL | HDD2_POWER)
> +				   HDD1_GREEN_LED | HDD1_RED_LED | HDD2_POWER))
> +#define NSA325_VAL_HIGH		(HDD2_POWER)
>   
>   #define BTN_POWER				46
>   #define BTN_RESET				36

