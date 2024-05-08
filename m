Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46630C04FFE
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 17:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0845882B1;
	Wed,  8 May 2024 19:39:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=posteo.net header.i=@posteo.net header.b="U8aG34R+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3849C87FCC; Wed,  8 May 2024 19:39:54 +0200 (CEST)
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49E2B87ED0
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 19:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan_b@posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id E499D240101
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 19:39:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
 t=1715189991; bh=Orlqb90XcpoISQn3Tvgz+Xf5D8HT8P8MFhW3QComh7o=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
 Content-Transfer-Encoding:From;
 b=U8aG34R+zPSi5L0sbFUDtLdwqwGrsKTEISWMUvwlfaGn17znxVe1CaAIX2FmvFns2
 U2I384cHcmk2Yfa5c1gKmySWrcuf7iNxH9yaALH+xCK+q4/ygp7NllkCIAGpac1fkK
 vQD7PLswv+ol0FmteykYcVn9hb9KQ65yG0ToH35FGmbxasuvzHreeJWgKtkdFc0V/z
 RKBIOuJ2jASm1sHk9l/bMw3QchinZcMCTV3GnKaX6W6RVuN+3JSl6fdZICxh3zkUBR
 1b9GwS02nPEDJQNDI+AC1TiqUgBru7CISwh742EdZvjGgnFuukN1z/kRpAP14DMFWC
 uOCvccaegklBw==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4VZMpt1dpFz9rxF;
 Wed,  8 May 2024 19:39:50 +0200 (CEST)
Message-ID: <edb978c6-b13f-eb1a-958d-1bd22ae9859f@posteo.net>
Date: Wed,  8 May 2024 17:39:22 +0000
MIME-Version: 1.0
Subject: Re: [PATCH 062/149] board: friendlyarm: Remove <common.h> and add
 needed includes
Content-Language: en-US, de-DE
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-62-trini@konsulko.com>
From: Stefan Bosch <stefan_b@posteo.net>
In-Reply-To: <20240501024316.1767971-62-trini@konsulko.com>
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



On 01.05.24 04:41, Tom Rini wrote:
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Stefan Bosch <stefan_b@posteo.net>
Tested-by: Stefan Bosch <stefan_b@posteo.net>

Looks good, tested on FriendlyElec-Board NanoPC-T2.

Thanks a lot!

> ---
> Cc: Stefan Bosch <stefan_b@posteo.net>
> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> Cc: Eugen Hristev <eugen.hristev@collabora.com>
> Cc: Igor Prusov <ivprusov@salutedevices.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   board/friendlyarm/nanopi2/board.c   | 1 -
>   board/friendlyarm/nanopi2/hwrev.c   | 1 -
>   board/friendlyarm/nanopi2/lcds.c    | 1 -
>   board/friendlyarm/nanopi2/onewire.c | 1 -
>   4 files changed, 4 deletions(-)
> 
> diff --git a/board/friendlyarm/nanopi2/board.c b/board/friendlyarm/nanopi2/board.c
> index 393c5a447d6f..c8cbc5a15fa8 100644
> --- a/board/friendlyarm/nanopi2/board.c
> +++ b/board/friendlyarm/nanopi2/board.c
> @@ -5,7 +5,6 @@
>    */
>   
>   #include <config.h>
> -#include <common.h>
>   #include <command.h>
>   #include <fdt_support.h>
>   #include <log.h>
> diff --git a/board/friendlyarm/nanopi2/hwrev.c b/board/friendlyarm/nanopi2/hwrev.c
> index 585e08c944f9..cd9c2414a320 100644
> --- a/board/friendlyarm/nanopi2/hwrev.c
> +++ b/board/friendlyarm/nanopi2/hwrev.c
> @@ -5,7 +5,6 @@
>    */
>   
>   #include <config.h>
> -#include <common.h>
>   #include <i2c.h>
>   #include <asm/io.h>
>   
> diff --git a/board/friendlyarm/nanopi2/lcds.c b/board/friendlyarm/nanopi2/lcds.c
> index 7303e53af925..b37367300cf0 100644
> --- a/board/friendlyarm/nanopi2/lcds.c
> +++ b/board/friendlyarm/nanopi2/lcds.c
> @@ -4,7 +4,6 @@
>    */
>   
>   #include <config.h>
> -#include <common.h>
>   #include <errno.h>
>   #include <fdtdec.h>
>   #include <fdt_support.h>
> diff --git a/board/friendlyarm/nanopi2/onewire.c b/board/friendlyarm/nanopi2/onewire.c
> index 4f0b1e33c2df..31cc871330ca 100644
> --- a/board/friendlyarm/nanopi2/onewire.c
> +++ b/board/friendlyarm/nanopi2/onewire.c
> @@ -5,7 +5,6 @@
>    */
>   
>   #include <config.h>
> -#include <common.h>
>   #include <errno.h>
>   #include <asm/io.h>
>   #include <asm/arch/clk.h>
