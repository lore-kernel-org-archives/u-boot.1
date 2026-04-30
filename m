Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2C2CCFA13
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 21:54:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01568803C6;
	Thu, 30 Apr 2026 23:54:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=xs4all.nl header.i=@xs4all.nl header.b="rSqko0Wb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AE198063E; Thu, 30 Apr 2026 23:54:44 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AB1480086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 23:54:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mark.kettenis@xs4all.nl
X-KPN-MessageId: 30bf0a4d-44df-11f1-bea8-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 30bf0a4d-44df-11f1-bea8-005056992ed3;
 Thu, 30 Apr 2026 23:54:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=csepfKb/hLQx0xLRCFqiZI1KiVAN9Hc7H1Lk9AcuYpw=;
 b=rSqko0WbQWkuajesUc/6x0xTrxLfszkiydkEtao2khqrS5+M8M4uMu5t/qIz36f5NJNgnBj1mm2KK
 dxAt+v/CnjBttGDdVnV2ZdOwO12/hxrj+m4QRL3z7n9iv0mX69dedcLhnQRxZpvwnlRavMPvhoAJnE
 +kLmf/VAaZ9Pyy6fx3D32WBfXZVr+4BZYOC36P+GJrdfV3C+ji4wzIh2M/0Oh2tfZy0qyqNbUuG6BS
 fVubsaZc9g1l8qQLLROVGzbKk510rE6tN/Kt2a3w1QSSx2Rs4ItXlMOz2M+5CyodZFSsEBqU+nZ+D9
 koLLWrTyS8+tqfmq6ZUnuMImgzO1isw==
X-KPN-MID: 33|1g8/ztXWVYs4qjaPjwDRstw2UBPTvLFA2MU74AdRNjQgTB5dnzTxZ/3hgZ9b3n5
 Fwp4305NL8Cs2pQtOFUi0K2cFUFbXEvmoE9MlP14j+AE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|KQ5oM+px7Qm0xG7n7pKTQmKymj0O0FdwUiTcJsAHVrLLemyPjvoihJ91hjvaIrM
 gj5daTz/L1XBHLFyEoXkE5A==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 304eed13-44df-11f1-9c0c-00505699d6e5;
 Thu, 30 Apr 2026 23:54:41 +0200 (CEST)
Date: Thu, 30 Apr 2026 23:54:40 +0200
Message-Id: <87fr4c8673.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.denx.de, trini@konsulko.com, kettenis@openbsd.org,
 j@jannau.net
In-Reply-To: <20260430-apple-dt-upstream-v1-1-dda66c16e0da@jannau.net>
 (message from Janne Grunau on Thu, 30 Apr 2026 23:25:46 +0200)
Subject: Re: [PATCH 1/3] doc: board: apple: Mention M2 and M2 Pro/Max/Ultra
 SoCs
References: <20260430-apple-dt-upstream-v1-0-dda66c16e0da@jannau.net>
 <20260430-apple-dt-upstream-v1-1-dda66c16e0da@jannau.net>
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

> From: Janne Grunau <j@jannau.net>
> Date: Thu, 30 Apr 2026 23:25:46 +0200
> 
> These SoCs are supported since 2022/2023 but were never added to the
> documentation. The devices very similar to the equivalent M1 devices.
> The biggest difference is that the M2 and M2 Pro/Max based laptops no
> longer use SPI for the keyboard.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>

Acked-by: Mark Kettenis <kettenis@openbsd.org>

> ---
>  doc/board/apple/m1.rst | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/doc/board/apple/m1.rst b/doc/board/apple/m1.rst
> index 8fa7637629e..5d2cf750fde 100644
> --- a/doc/board/apple/m1.rst
> +++ b/doc/board/apple/m1.rst
> @@ -8,14 +8,18 @@ developed by the Asahi Linux project.  At this point the machines with
>  the following SoCs work:
>  
>   - Apple M1 SoC (t8103)
> + - Apple M2 SoC (t8112)
>   - Apple M1 Pro SoC (t6000)
>   - Apple M1 Max SoC (t6001)
>   - Apple M1 Ultra SoC (t6002)
> + - Apple M2 Pro SoC (t6020)
> + - Apple M2 Max SoC (t6021)
> + - Apple M2 Ultra SoC (t6022)
>  
>  On these SoCs the following hardware is supported:
>  
>   - S5L serial port
> - - SPI keyboard (on laptops)
> + - SPI keyboard (on M1 laptops)
>   - Framebuffer
>   - NVMe storage
>   - USB 3.1 Type-C ports
> @@ -77,7 +81,7 @@ supported SoCs.
>  
>     * - SoC
>       - Base Address
> -   * - M1 (t8103)
> +   * - M1 (t8103) and M2 (t8112)
>       - 0x235200000
> -   * - M1 Pro/Max/Ultra (t6000/t6001/t6002)
> +   * - M1 Pro/Max/Ultra (t6000/t6001/t6002) and M2 Pro/Max/Ultra (t6020/t6021/t6022)
>       - 0x39b200000
> 
> -- 
> 2.53.0
> 
> 
