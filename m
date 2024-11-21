Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2290BD75BC8
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 07:00:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 621FE89667;
	Thu, 21 Nov 2024 08:00:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="lJL1QNBt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8A1989669; Thu, 21 Nov 2024 08:00:21 +0100 (CET)
Received: from mail.thorsis.com (mail.thorsis.com [IPv6:2003:a:e28:26e4::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8068B8911A
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 08:00:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 243B114843E6; Thu, 21 Nov 2024 08:00:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1732172418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zVmxk8ZVpLJN31mORSly9SB4JWFlc/RQnAcvY5dE/Cw=;
 b=lJL1QNBt91Ggg3nwU52FPAxY/CMa6vdpV1SjQUeX3BBfzBa6hXkrdhBlcwuDo5nxAiLXnj
 aeDUW7J6Y6W4cuhtKvYwdCM5H21y1EiVDys6S9BbJ3Nb8RqbsCZ+qa+8dBboFASwLAggvM
 MH1jsWm8FRrnvtayRqbyzlFMFkK7vYIodfQWW7l0qFzdy7znhIk+BcAB5gofQXtqS7JHhp
 DQhZ1BNLltJqbc1h/CE5boC9ArSzLQ5meMN5h7nCeqfmgpQxG0C4qNxXSD2Ld9mO1Y2YAr
 7moe7sWq4rxSI/IQ++YUYMH+j5iz4ZywVUnAp1XVyB4kzGFEhcAtjGo/+AywFA==
Date: Thu, 21 Nov 2024 08:00:11 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: sjg@chromium.org, trini@konsulko.com, alpernebiyasak@gmail.com,
 ada@thorsis.com, xypron.glpk@gmx.de, mkorpershoek@baylibre.com,
 dario.binacchi@amarulasolutions.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] doc: develop: Fix typos and wording in gdb.rst
Message-ID: <20241121-mortally-baritone-478f3c8107cf@thorsis.com>
Mail-Followup-To: Lothar Rubusch <l.rubusch@gmail.com>, sjg@chromium.org,
 trini@konsulko.com, alpernebiyasak@gmail.com, xypron.glpk@gmx.de,
 mkorpershoek@baylibre.com, dario.binacchi@amarulasolutions.com,
 u-boot@lists.denx.de
References: <20241120185717.29768-1-l.rubusch@gmail.com>
 <20241120185717.29768-3-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120185717.29768-3-l.rubusch@gmail.com>
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

Moin,

Am Wed, Nov 20, 2024 at 06:57:17PM +0000 schrieb Lothar Rubusch:
> Fix some typos and duplicate words in gdb.rst.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  doc/develop/gdb.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/doc/develop/gdb.rst b/doc/develop/gdb.rst
> index 4e359c7f22..79510ee94d 100644
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
>  optimization is recommended for easier debugging::
>  
>      CONFIG_CC_OPTIMIZE_FOR_DEBUG=y
> @@ -24,7 +24,7 @@ Otherwise build, install, and run U-Boot as usual.
>  Using OpenOCD as GDB server
>  ---------------------------
>  
> -`OpenOCD <https://openocd.org/>`_ is an open source tool supporting hardware
> +`OpenOCD <https://openocd.org/>`_ is an open-source tool supporting hardware
>  debug probes, and providing a GDB server. It is readily available in major Linux
>  distributions or you can build it from source.
>  
> @@ -144,7 +144,7 @@ riscv        gp
>  sh           r13
>  ============ ========
>  
> -On these architecture the relocation address cat be determined by
> +On these architectures the relocation address can be determined by
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

Acked-by: Alexander Dahl <ada@thorsis.com>

Greets
Alex

