Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3261DCFB440
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 09:51:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A54FC889E1;
	Mon,  7 Oct 2024 11:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RgcZJ2z1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1DE588AB9; Mon,  7 Oct 2024 11:51:12 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3AA6889AA
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 11:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20b5affde14so31412415ad.3
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 02:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728294669; x=1728899469; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u+XmQYflNq0jmdr+0Ma06wbL2ZgkxEH6wn4p46iAz8A=;
 b=RgcZJ2z1ZU9vNOX2BWSJccan9QkKysew7748fnJZO/RKTkPalA7Ei6fS268qTDfNMb
 NcMJKgN970QtDLBbxYxM4DTY/g3vZfA12QlMXJZMMDMUrYCdlQhDv3qt91GPHTgk7Upa
 vaefxNMDMCxn7HdPORxz2xVERgULKa/daHA6rGR8j3hw11PKAl14Cv33lsXeE7Mi9umo
 HskPoQfYes/Lh5KZ7TCaZE2WvfI8cWwjZvuOaSdllAIzbDigzL9PPkxQOxBlGFORMO3/
 D0ppOe6Jk2H0/Z/aGwtmaWu1UnuieOJ2I0qSnNfShek69IFa+Ch9hPA4atJYBJThwb/i
 04zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728294669; x=1728899469;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u+XmQYflNq0jmdr+0Ma06wbL2ZgkxEH6wn4p46iAz8A=;
 b=VACjkYOWm/xfH+RM+sglf07V2RRm4RdJq/eZPzgSWptmwjdITNz8GZkLIvl7k6mZrm
 GatJdPL2I/GZkH0Awv8+/WUCJL8FQffkUATgfo1uYbGBewoHT6z0IneTgVut+7WDEREy
 RmZxwgCIsmBcmNh9vv0ZjXNGmfp4mRxZYIWhIVV1Haz5QzsyEdfOTUyIYEBWo1wYVXkd
 e1pkdjxhYbqVMFKlE1zQtLOTjhAv/u+g/oZTqaAVUvL4m2xp8WSgprUoSCdG/rqpY7wR
 XZ0cKuhXluVyVeioKNqAQGt+FUMuD6gmy7VvqOcbIePRvcC3ZdBdsMVCcBJE8tO4WInD
 cteQ==
X-Gm-Message-State: AOJu0YypgqIyTi79Laqj1CEruyNmz5ec4IyRjzo5KPxpdGGwBYCAbMWs
 wngf81noVTG+IYHYzLYyY6GAwLkMC750Ge5nnKE7ysxNhaK0ao97fjGxAO1/0iDSOr4OHSIvsw6
 y8W5AKupRZ/5K/3viR9N4cJQhMVwlpjU5vRFIJQ==
X-Google-Smtp-Source: AGHT+IGpE6J8P3wX6Fyz3I8qn/DK2Q/P2h89DxJFakr4zyip0SgYdz62F6mhdXTW14WMaHEyhsuOaKI1LZ6VBesJ10Q=
X-Received: by 2002:a17:90a:17e3:b0:2d3:c87e:b888 with SMTP id
 98e67ed59e1d1-2e1e636f481mr13744674a91.27.1728294669162; Mon, 07 Oct 2024
 02:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20241007094206.2928071-1-jerome.forissier@linaro.org>
In-Reply-To: <20241007094206.2928071-1-jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 7 Oct 2024 12:50:32 +0300
Message-ID: <CAC_iWjJST9aiZQoppzBaEOi=o+1TWGB_mB5idZepQNNiRWHtEg@mail.gmail.com>
Subject: Re: [PATCH] linker_lists: set LINKER_LIST_ALIGN to 8 if 64BIT
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Alexander Gendin <agendin@matrox.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 7 Oct 2024 at 12:42, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> CPU_MIPS64 needs 8-byte alignment on the linker lists, otherwise an
> exception may occur. In fact all 64BIT architectures should default
> to 8; that's what this patch does.
> Fixes an issue found on malta64 with QEMU:
>
>  Breakpoint 1, lists_driver_lookup_name (name=0xffffffffbe043578 "root_driver") at /home/uboot/u-boot/drivers/core/lists.c:31
>  31                      if (!strcmp(name, entry->name))
>  [...]
>  ld      a1,0(s0)
>
>  (gdb) p/x &entry->name
>  0xffffffffbe04b0d4
>  (gdb) p/x $s0
>  0xffffffffbe04b0d4
>
>  $ grep __u_boot_list /tmp/malta64/u-boot.objdump
>  4 __u_boot_list 000018e0  ffffffffbe04a4d4  ffffffffbe04a4d4  0004a584  2**2
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  arch/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 8f1f4667012..72bf4029251 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -45,7 +45,7 @@ config SYS_CACHELINE_SIZE
>  config LINKER_LIST_ALIGN
>         int
>         default 32 if SANDBOX
> -       default 8 if ARM64 || X86
> +       default 8 if 64BIT
>         default 4
>         help
>           Force the each linker list to be aligned to this boundary. This
> --
> 2.40.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
