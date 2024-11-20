Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101B6D6E2C9
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 07:15:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A001895D0;
	Wed, 20 Nov 2024 08:15:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="R5sMjiZ0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08365895D0; Wed, 20 Nov 2024 08:15:45 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95CF0895BE
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 08:15:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A499614859A8; Wed, 20 Nov 2024 08:15:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1732086941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8AU72QUE6CV99QQXP4h0WoCxUgq+YHbL5N4XyciihZg=;
 b=R5sMjiZ0J3wtEC2XasitZz+YK3aAdfpwlS7nYT3ygoZY+KdpxkD7X9w83cfJXvWrMMwVhI
 nPoxuuukzq4k/vrBnadPBiACCmIjoxSFPJqyYiZuVuQPUCOaj5fE7jviCbA/Bw+nFkMhAN
 9+TbOr3/aKmcNTgAvsC+8HX1NgzspE0UAeJ7OOlSRkdqhlWkw0QFu3kTEL8tNVDTIOWrQa
 cODbi4FwkHdznEl1AeWGozJW9pO1KjFm1YTKsk3hBjnDgP/FqN8CeX9Gh3THOdKHhInl6O
 BG+ZRUK856V/Vi6FsUJNxNVCk0Djb+G5BKGSdUbS4W4f+G1yBj4EvwZPO38YEg==
Date: Wed, 20 Nov 2024 08:15:33 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: sjg@chromium.org, trini@konsulko.com, alpernebiyasak@gmail.com,
 ada@thorsis.com, xypron.glpk@gmx.de, mkorpershoek@baylibre.com,
 dario.binacchi@amarulasolutions.com, pbrobinson@gmail.com,
 n-francis@ti.com, afd@ti.com, al.kochet@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH v1 2/3] doc: develop: Fix typos and wording in gdb.rst
Message-ID: <20241120-employer-haunt-ff43822eb5f3@thorsis.com>
Mail-Followup-To: Lothar Rubusch <l.rubusch@gmail.com>, sjg@chromium.org,
 trini@konsulko.com, alpernebiyasak@gmail.com, xypron.glpk@gmx.de,
 mkorpershoek@baylibre.com, dario.binacchi@amarulasolutions.com,
 pbrobinson@gmail.com, n-francis@ti.com, afd@ti.com,
 al.kochet@gmail.com, u-boot@lists.denx.de
References: <20241119222837.27550-1-l.rubusch@gmail.com>
 <20241119222837.27550-3-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119222837.27550-3-l.rubusch@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
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

Hello Lothar,

Am Tue, Nov 19, 2024 at 10:28:36PM +0000 schrieb Lothar Rubusch:
> Fix some typos and duplicate words in gdb.rst.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  doc/develop/gdb.rst | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/doc/develop/gdb.rst b/doc/develop/gdb.rst
> index 4e359c7f22..dc38435227 100644
> --- a/doc/develop/gdb.rst
> +++ b/doc/develop/gdb.rst
> @@ -8,12 +8,12 @@ Using a JTAG adapter it is possible to debug a running U-Boot with GDB.
>  A common way is to connect a debug adapter to the JTAG connector of your
>  board, run a GDB server, connect GDB to the GDB server, and use GDB as usual.
>  
> -Similarly QEMU can provide a GDB server.
> +Similarly, QEMU can provide a GDB server.
>  
>  Preparing build
>  ---------------
>  
> -Building U-Boot with with reduced optimization (-Og) and without link time
> +Building U-Boot with reduced optimization (-Og) and without link time

ack

>  optimization is recommended for easier debugging::
>  
>      CONFIG_CC_OPTIMIZE_FOR_DEBUG=y
> @@ -24,8 +24,8 @@ Otherwise build, install, and run U-Boot as usual.
>  Using OpenOCD as GDB server
>  ---------------------------
>  
> -`OpenOCD <https://openocd.org/>`_ is an open source tool supporting hardware
> -debug probes, and providing a GDB server. It is readily available in major Linux
> +`OpenOCD <https://openocd.org/>`_ is an open-source tool supporting hardware
> +debug probes and provide a GDB server. It is readily available in major Linux

NACK.  It would read "OpenOCD is a tool supporting x and provide y"
now.  This is most probably wrong?

>  distributions or you can build it from source.
>  
>  Here is example of starting OpenOCD on Debian using a J-Link adapter and a
> @@ -124,7 +124,7 @@ with the command *bdinfo*:
>      Early malloc usage: cd8 / 2000
>  
>  Look out for the line starting with *relocaddr* which has the address
> -you need, ``0x27f7a000`` in this case.
> +You need, ``0x27f7a000`` in this case.

NACK.  These are not two sentences but one, containing "the address you
need".  Splitting that makes no sense.

Greets
Alex

>  On most architectures (not sandbox, x86, Xtensa) the global data pointer is
>  stored in a fixed register:
> @@ -144,7 +144,7 @@ riscv        gp
>  sh           r13
>  ============ ========
>  
> -On these architecture the relocation address cat be determined by
> +On this architecture the relocation address can be determined by
>  dereferencing the global data pointer stored in register, *r9* in the example:
>  
>  .. code-block:: console
> @@ -153,7 +153,7 @@ dereferencing the global data pointer stored in register, *r9* in the example:
>       $1 = 0x27f7a000
>  
>  In the GDB shell discard the previously loaded symbol file and add it once
> -again with the relocation address like this:
> +again, with the relocation address like this:
>  
>  .. code-block:: console
>  
> -- 
> 2.39.2
> 
