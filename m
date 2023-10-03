Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369AEE7AD46
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 13:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 806F086E28;
	Tue,  3 Oct 2023 15:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QM0R7cZB";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="q7xVR7Mw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9C4E86E1E; Tue,  3 Oct 2023 15:40:43 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA53586E28
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 15:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4S0JqX4Q1wz9spZ;
 Tue,  3 Oct 2023 15:40:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=urDJqzqG1o3ubA3QzhDZShlYMlEDP8n3zJBX437fKaE=;
 b=QM0R7cZBu8EzSRym/CGSg+TXOCnpJTcQMW++yIqq1jBoVV/kgxWPdNwz862tCFR/pU16oF
 1OrBLEqhPOvQtZFhYxYlK340qmpK0mjspDa1e42FhaHaeaCAZ2aPn7Ytu9hl5Z8dzyp6Q8
 LTEpNncQSqL+ZsUfp+e/re22OpuMsUsQgQGNL0YWAy7X7x+CVInfohrhzDrtpf0/ydSnLo
 wrV3pG6bW6AGBuj6G8P+eIe1NFN88MnA3iQjoavOxWhIHEeRPoIHUwca1xtCsVQmieT3qk
 hK2p2qmmLKqnn71NmuSgPnMDB93NdkIZ1hocH9rrfAGk/G4ud9yfdiLtZ90VtQ==
Message-ID: <ce466f52-f91d-9fb9-fe18-b58cefac5b20@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=urDJqzqG1o3ubA3QzhDZShlYMlEDP8n3zJBX437fKaE=;
 b=q7xVR7MwwvEONYlUv2Y/VMwjn/Axe1FEO2PEEfLi1k/WTGrDGAx/i2Rxh1yTXGqpM0PdA2
 kif+t1qf2sNeI7YvieSz5D4GuhdPWrwTltNpdTO0UjvSTrhLpOCE6BVIaqaqN4IsijD+Zp
 TjD2ZeLZPQJnCuYXmWsX0A0K9Xi6JuWVz79qmEM/zLCaOxBkB3D1b0dj1D8R4x0j/w8RjA
 dVlAB1IkIisM/lpCt2V76dnrjngr/zwO7pbMPCtCmUQj1mySk7A8jztNu9d2es2su6116i
 PXxVu2ynGEfZ9T8kEOoGodo5SI8h+bUYY4/i2oBPCfqxNLLxW5HsiqFXnLNKdQ==
Date: Tue, 3 Oct 2023 14:42:40 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 01/16] serial: sh: Fix compile error when lacking HSCIF
 support
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, Simon Glass <sjg@chromium.org>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-2-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230920124212.63535-2-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8ba742d30136e15bd9c
X-MBO-RS-META: 6babgzrauzbf4guuw9g77ygkzz4r3b5s
X-Rspamd-Queue-Id: 4S0JqX4Q1wz9spZ
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

On 9/20/23 14:41, Paul Barker wrote:
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
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Hai Pham <hai.pham.ud@renesas.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>   drivers/serial/serial_sh.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/serial/serial_sh.c b/drivers/serial/serial_sh.c
> index 20cda5dbe272..5e543dbf3d58 100644
> --- a/drivers/serial/serial_sh.c
> +++ b/drivers/serial/serial_sh.c
> @@ -58,8 +58,10 @@ static void sh_serial_init_generic(struct uart_port *port)
>   	sci_out(port, SCSPTR, 0x0003);
>   #endif
>   
> +#if IS_ENABLED(CONFIG_RCAR_GEN2) || IS_ENABLED(CONFIG_RCAR_GEN3) || IS_ENABLED(CONFIG_RCAR_GEN4)

There should be CONFIG_RCAR_64 for GEN3+GEN4, please use it.

With that fixed:

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
