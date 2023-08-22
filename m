Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BC5EE49AF
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 21:38:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86ADB864A1;
	Tue, 22 Aug 2023 23:38:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Hx2UCx2f";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="mCe5edi1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72667864A4; Tue, 22 Aug 2023 23:38:43 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CAE086410
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 23:38:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RVjQS2g8Sz9t5K;
 Tue, 22 Aug 2023 23:38:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692740320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wlArJU2TVDHfo6v7BMRcjS6DiOmDdC9gLvcG5fhVH5U=;
 b=Hx2UCx2fmE3m05AAkJHUoq1Cmh+uc4EG3g+UWi7Rq0fCazSQqndGn9zkvybz/SmHpuRYys
 +RPaRAQiURAlhtwKwGTTcS5Uf7sFBI7tsL3Ddw7QD0DyBk3WXv93msNcDCoIRtttcBGO99
 pC+gP5OUNwFvh+KSL5ruY6o0Vl4e5YQThvLq1sAgILK7Jl75wmeHCLP7Bhc8t8as482bJy
 MK+ibunf46KmAUC0m7WQgRGVNc1QYPYPUkcb00oq5+tz4sqi4jTvHGf+JwqH6b2JVUUr7F
 dqT6ZKhKxHhg0YU37Vnn6CbE5mt6zPKCNou9xG0RWjBUR0vZroa0t7vRhxMG0Q==
Message-ID: <e6fc0067-b5bf-bbd0-57de-0f71d20d2e63@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692740317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wlArJU2TVDHfo6v7BMRcjS6DiOmDdC9gLvcG5fhVH5U=;
 b=mCe5edi1xb8UNPGFWSXO25o0+z0nBW992YgY2hZ6/gzUUwzOM+AHPmpGWFueakORIoF9Dy
 Ieqvvj4FwU5bx1brNDb5LCMyGwMx8oknRSvhCZ6Y6GcZKQES3+rxcCueRVo0sL08DL8w0+
 +bWEllAOzSfC+eL88ACKAXkPzJs3BEuyr5LhPG9fvaNqW7YcuSeE3iLV/vxWW5jyu94exn
 Ir3LMQga7Y+Byyu9Op+bn+57WzPu4Ry3B3fn/szVt9UMADs30GjRaSDBZFJMl2+JAvjcyA
 u1LqO/HahZvyCdw0oyXKcNAm4rNVG2b6Y+EuHMIs1A8UPjPGaK4SAHpV5pjXLA==
Date: Tue, 22 Aug 2023 23:38:35 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] serial: sh: Fix compile error when lacking HSCIF
 support
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Hai Pham <hai.pham.ud@renesas.com>, Simon Glass <sjg@chromium.org>
References: <20230822181025.339748-1-paul.barker.ct@bp.renesas.com>
 <20230822181025.339748-2-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230822181025.339748-2-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0102d2433d633144806
X-MBO-RS-META: 4xkjj51dgnenir4ub8ehrxgd1t1yb7st
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

On 8/22/23 20:10, Paul Barker wrote:
> If we attempt to compile serial_sh.c for a system which lacks HSCIF
> support (e.g. R8A7740), we see the following compilation error:
> 
>      In file included from drivers/serial/serial_sh.c:20:
>      drivers/serial/serial_sh.c: In function ‘sh_serial_init_generic’:
>      drivers/serial/serial_sh.h:429:35: warning: implicit declaration of function ‘sci_HSSRR_out’; did you mean ‘sci_SCSCR_out’? [-Wimplicit-function-declaration]
>        429 | #define sci_out(port, reg, value) sci_##reg##_out(port, value)
>            |                                   ^~~~
>      drivers/serial/serial_sh.c:62:17: note: in expansion of macro ‘sci_out’
>         62 |                 sci_out(port, HSSRR, HSSRR_SRE | HSSRR_SRCYC8);
>            |                 ^~~~~~~
> 
> To fix this, only try to support access to the HSSRR register for SoCs
> where it actually exists.
> 
> Fixes: bbe36e29ca2c ('serial: sh: Add HSCIF support for R-Car SoC')
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Hai Pham <hai.pham.ud@renesas.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>   drivers/serial/serial_sh.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/serial/serial_sh.c b/drivers/serial/serial_sh.c
> index 20cda5dbe272..cd9bcf4f0a25 100644
> --- a/drivers/serial/serial_sh.c
> +++ b/drivers/serial/serial_sh.c
> @@ -58,8 +58,10 @@ static void sh_serial_init_generic(struct uart_port *port)
>   	sci_out(port, SCSPTR, 0x0003);
>   #endif
>   
> +#if defined(CONFIG_RCAR_GEN2) || defined(CONFIG_RCAR_GEN3) || defined(CONFIG_RCAR_GEN4)

You can use CONFIG_RCAR_64 instead of GEN3+GEN4 test.

Also, can does

#if IS_ENABLED(CONFIG_RCAR_GEN2) || IS_ENABLED(CONFIG_RCAR_64)

work ?
