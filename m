Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22927CCD185
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 11:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A5EE84319;
	Thu,  9 Oct 2025 13:16:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="lPQ7SWxS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDFA684459; Thu,  9 Oct 2025 13:16:09 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75AD183E92
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 13:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 31EAA25DBC;
 Thu,  9 Oct 2025 13:16:07 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id De2SfFwZeLOL; Thu,  9 Oct 2025 13:16:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760008566; bh=t+Y0dSf+u+GUlVdxzfeALGZc01qEK2i17KzauenGa4A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=lPQ7SWxSijCLofh82UV1Q/T8wj2dEE9wPYeve2IWsKRUKUzLbjA7jGb5zstqtc5FN
 8/gv086tzxXLzkIaX/s0Jw62FFMgw1kcyjTzGgwuR0For7KuExUI8eh6BiVpcBSiFS
 jRxyPzJSDEo85FZPmnaHkif9fTi61uDbSV/WFq/BwD4CcqpzC9aB+oM1JeqnHQESI4
 3VDNLYhvlG//oX1a8EVmsxhEfnqyJVmV08STg1DZFhUjoLW+aDt33h4nDNEmWX6Dzp
 aFyuogfxMIlkxf7LiDXhSH6uLuFzAz2ZnEPanQWzgkKzmqiWonjRsBmCYaiYMWSzsH
 ZSPtSvmDKoOVg==
Date: Thu, 9 Oct 2025 11:15:57 +0000
From: Yao Zi <ziyao@disroot.org>
To: Uros Stajic <uros.stajic@htecgroup.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>
Subject: Re: [PATCH v4 09/10] riscv: boston: Add support for LED character
 display command
Message-ID: <aOeZbQ_Ew64f1ohn@pie>
References: <20250819103021.1518687-1-uros.stajic@htecgroup.com>
 <20250819103021.1518687-10-uros.stajic@htecgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819103021.1518687-10-uros.stajic@htecgroup.com>
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

On Tue, Aug 19, 2025 at 10:34:01AM +0000, Uros Stajic wrote:
> From: Chao-ying Fu <cfu@mips.com>
> 
> Add basic support for the 8-char LED display on P8700-based Boston
> Board using display_set() and display_putc(), enabling the generic
> 'display' command with clear and home support.

I noticed the similar "display" command has been removed back to 2019
in commit 005a804d0f3 (cmd: remove unused `display` command,
2019-05-21).

To me, It doesn't seem a good idea to add it back, at least more
discussion is necessary for it.

Could the driver be implemented as a stdio device instead? And could it
be described in devicetree to avoid non-DM code as much as possible?

Regards,
Yao Zi

> Signed-off-by: Chao-ying Fu <cfu@mips.com>
> Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
> ---
>  board/mips/boston-riscv/Kconfig         |  4 ++
>  board/mips/boston-riscv/MAINTAINERS     |  3 ++
>  board/mips/boston-riscv/Makefile        |  1 +
>  board/mips/boston-riscv/display.c       | 33 ++++++++++++++++
>  board/mips/boston-riscv/lowlevel_init.S |  2 +
>  cmd/Kconfig                             |  8 ++++
>  cmd/Makefile                            |  1 +
>  cmd/display.c                           | 51 +++++++++++++++++++++++++
>  doc/README.LED_display                  | 26 +++++++++++++
>  include/led-display.h                   | 33 ++++++++++++++++
>  10 files changed, 162 insertions(+)
>  create mode 100644 board/mips/boston-riscv/display.c
>  create mode 100644 cmd/display.c
>  create mode 100644 doc/README.LED_display
>  create mode 100644 include/led-display.h
