Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3010CC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 21:30:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EF3588305;
	Wed,  1 May 2024 23:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kaa.org.ua
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AB5A885A0; Wed,  1 May 2024 23:30:56 +0200 (CEST)
Received: from smtp.220.in.ua (smtp.220.in.ua [89.184.67.205])
 by phobos.denx.de (Postfix) with ESMTP id 584D787F6E
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 23:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kaa.org.ua
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=oleg@kaa.org.ua
Received: from [192.168.202.193] (unknown [95.67.115.55])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.220.in.ua (Postfix) with ESMTPSA id 415D21A203DA;
 Thu,  2 May 2024 00:30:53 +0300 (EEST)
Message-ID: <bc799867-6c43-4a9d-bb6e-404a8c9b6f27@kaa.org.ua>
Date: Thu, 2 May 2024 00:30:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 102/149] board: out4: Remove <common.h> and add needed
 includes
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-102-trini@konsulko.com>
Content-Language: uk
From: Oleh Kravchenko <oleg@kaa.org.ua>
In-Reply-To: <20240501024316.1767971-102-trini@konsulko.com>
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

ACK

01.05.24 05:42, Tom Rini:
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
> ---
>   board/out4/o4-imx6ull-nano/o4-imx6ull-nano.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/board/out4/o4-imx6ull-nano/o4-imx6ull-nano.c b/board/out4/o4-imx6ull-nano/o4-imx6ull-nano.c
> index edb200e9e55b..10469aecd0bb 100644
> --- a/board/out4/o4-imx6ull-nano/o4-imx6ull-nano.c
> +++ b/board/out4/o4-imx6ull-nano/o4-imx6ull-nano.c
> @@ -5,7 +5,6 @@
>   #include <asm/arch/sys_proto.h>
>   #include <asm/global_data.h>
>   #include <asm/mach-imx/boot_mode.h>
> -#include <common.h>
>   #include <env.h>
>   
>   DECLARE_GLOBAL_DATA_PTR;
