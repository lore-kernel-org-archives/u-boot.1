Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B70F327A8
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 06:14:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D463D83FFA;
	Tue, 21 Apr 2026 08:14:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="fGLt/j2c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E203B84258; Tue, 21 Apr 2026 08:14:11 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF9E083E36
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 08:14:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 883C1C5C9A4;
 Tue, 21 Apr 2026 06:14:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 1C092600D2;
 Tue, 21 Apr 2026 06:14:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 99E5410460A28; 
 Tue, 21 Apr 2026 08:14:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776752048; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=kyIoU9avsajY2oOI8JIrKcVmC4WLY1vm9vyDx5gyw4k=;
 b=fGLt/j2c2qNDJpXotyjqjg53X/RPnofI0s03FPp48MxqtozliJ63Bnqcl3IFtYOwlG1U8x
 a1p1MWQSeXkbFQoyy9AmZQ5MzTj5FptGIRv7DG+qfOTSyH4Vk/0uLI6QOC8qyhDY8mckOL
 2GscjJZREmJAIc+CCy1Vtknfq5kcBDC9z4kjXgEVwnfkR3vQJRFIzLgdgfbyNlW6kDfvge
 kmEhbmWbTxWfq8nBra5M1/uq5DXXRhZKjHXvRojOcFHXZvR1GM5uPYMZS0w6ufZqRWP7Pe
 I+qmD/3OS4NGa3DGbwQUaEKYd6qUQFHWOZ4HYIEizUWmss9DXgVdv0DSZAR+DQ==
Message-ID: <3514db3f-f49f-4446-a21f-27d9da01c540@bootlin.com>
Date: Tue, 21 Apr 2026 08:14:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/squashfs: Set ret to 0 on successful read
To: Michael Zimmermann <sigmaepsilon92@gmail.com>, u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Eric Kilmer <eric.kilmer@trailofbits.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <simon.glass@canonical.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>,
 Tom Rini <trini@konsulko.com>
References: <20260420163551.515651-1-sigmaepsilon92@gmail.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <20260420163551.515651-1-sigmaepsilon92@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hi Michael,

Le 20/04/2026 à 18:35, Michael Zimmermann a écrit :
> It might still be a positive number due to the call to sqfs_disk_read.
> This only happens when reading a file from an uncompressed squashfs.
> 
> I found this by trying to boot using the extlinux bootmethod, where
> positive values are treated as errors.
> 
> Signed-off-by: Michael Zimmermann <sigmaepsilon92@gmail.com>

Good catch!

Acked-by: Richard Genoud <richard.genoud@bootlin.com>

> ---
> 
>   fs/squashfs/sqfs.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
> index 543db8c7e9e..0768fc4a7b2 100644
> --- a/fs/squashfs/sqfs.c
> +++ b/fs/squashfs/sqfs.c
> @@ -1636,6 +1636,8 @@ static int sqfs_read_nest(const char *filename, void *buf, loff_t offset,
>   		*actread = finfo.size;
>   	}
>   
> +	ret = 0;
> +
>   out:
>   	free(fragment);
>   	free(datablock);

Thanks!

Regards,
Richard
