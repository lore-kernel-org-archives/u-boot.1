Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079ACCDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B10088EC6;
	Thu, 26 Sep 2024 23:34:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N/tSCQ6Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90B8488EAA; Thu, 26 Sep 2024 23:34:22 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A23D88ED7
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:34:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cb29ff33c5so11024996d6.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727386457; x=1727991257; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EEEvUAQtR1gw5+rTg2bHgVjsv1uPb4P3vTXWlg0/ebo=;
 b=N/tSCQ6Zws/+OtqEdwcFTMFpoe6Yhpw7LDWgRHqXJtnK/rlvQKPsT+gngSbZwFGyZC
 f77m0ehgjtEWL12h605HLbnnX7YsXULw3O/0ZdKMzrGzsPb80izWxjiuvm9cn6rtwecB
 zWFkhHKZd9oyceIfXGhUhByJ/c8txhnnz5px8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727386457; x=1727991257;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EEEvUAQtR1gw5+rTg2bHgVjsv1uPb4P3vTXWlg0/ebo=;
 b=e7PUoQHP9WvKZI/jJzTL77ubX3OuQr5tVRfba3U2JRHXHZVeQcv0OD78mHuhPU++WA
 KBmxe4TOm6b3dYrGGoIY/1XB47gxJ7VYZ2m0DP1XPd5KI7Peo9v6Bj5p9tydfd8VzCu1
 5Ih/S0w8vEEcOoZdP/1Ani9VKT80w0hxOsNpSeqbKWdV9JJ7gf9uv3WJd4sm8WiaDqsG
 hGoDfOpcmXJbdJSF7brR+A/Cw3dmdqaXPNWFyVbR8iEFr0dfMEik+d/7inIg93HQXYXL
 oGtOV0VU8wdg9xIZzSbt8aUDTpx6lRNM2H3MmxRwB+noaffdKbSh9d4s7hqpV6YrxbD5
 zgrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6A85Aso5Lk950iy3mrHB0HRSyxtTMphW+mTSN7QGAtIYj32Du1zx6G1XPa82qSEP/OFf57qE=@lists.denx.de
X-Gm-Message-State: AOJu0YwntX7J/U/p1EwrVC86TTwoq+i3TcCr/edIxWfzP6hLqqziVEpi
 VaYhR1M/R47OPNM4jvcW+JfEugs0FEMR9nzXFXetUhijUR48XC9qkWn/ZLlFeJSipJipK2h9mpi
 I4GlKL9O48I65EKuYoV2V7KKgAjV0djkGOELb6lSyluZaGcT8G8e1wrY=
X-Google-Smtp-Source: AGHT+IGyoMQ+Iu5qi/Uhr47dcjyhRD4WGHChulTf4HyDY5E50TnZeqqmDOiFK67Qjasu09tivmgBY4SzWKy/n9S8Tr4=
X-Received: by 2002:a05:6214:419c:b0:6cb:3091:9069 with SMTP id
 6a1803df08f44-6cb3b638055mr11945286d6.40.1727386456752; Thu, 26 Sep 2024
 14:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240925014058.1679074-1-mikhail.kshevetskiy@iopsys.eu>
 <20240925014058.1679074-11-mikhail.kshevetskiy@iopsys.eu>
In-Reply-To: <20240925014058.1679074-11-mikhail.kshevetskiy@iopsys.eu>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 23:34:05 +0200
Message-ID: <CAFLszTidH3dXXDw4nwq8pQoDFaYpPsLOr9b9uKYM_KGFgPCwLg@mail.gmail.com>
Subject: Re: [PATCH v8 10/13] net/net: fix include ordering
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Anand Moon <linux.amoon@gmail.com>, Marek Vasut <marex@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Baruch Siach <baruch@tkos.co.il>, Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 u-boot@lists.denx.de
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

On Wed, 25 Sept 2024 at 03:41, Mikhail Kshevetskiy
<mikhail.kshevetskiy@iopsys.eu> wrote:
>
> fix include ordering to follow
>   https://docs.u-boot.org/en/latest/develop/codingstyle.html#include-files
>
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  net/net.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/net/net.c b/net/net.c
> index 86182cc504e..92156b5058b 100644
> --- a/net/net.c
> +++ b/net/net.c
> @@ -88,41 +88,43 @@
>  #include <errno.h>
>  #include <image.h>
>  #include <log.h>
> +#if defined(CONFIG_LED_STATUS)
> +#include <miiphy.h>
> +#endif
>  #include <net.h>
>  #include <net6.h>
>  #include <ndisc.h>
> +#if defined(CONFIG_LED_STATUS)
> +#include <status_led.h>
> +#endif
> +#include <watchdog.h>
> +#include <linux/compiler.h>
>  #include <net/fastboot_udp.h>
>  #include <net/fastboot_tcp.h>
> -#include <net/tftp.h>
>  #include <net/ncsi.h>
>  #if defined(CONFIG_CMD_PCAP)
>  #include <net/pcap.h>
>  #endif
> -#include <net/udp.h>
> -#if defined(CONFIG_LED_STATUS)
> -#include <miiphy.h>
> -#include <status_led.h>
> -#endif
> -#include <watchdog.h>
> -#include <linux/compiler.h>
> -#include <test/test.h>
>  #include <net/tcp.h>
> +#include <net/tftp.h>
> +#include <net/udp.h>
>  #include <net/wget.h>
> +#include <test/test.h>
>  #include "arp.h"
>  #include "bootp.h"
>  #include "cdp.h"
> +#include "dhcpv6.h"
>  #if defined(CONFIG_CMD_DNS)
>  #include "dns.h"
>  #endif
>  #include "link_local.h"
> +#include "net_rand.h"
>  #include "nfs.h"
>  #include "ping.h"
>  #include "rarp.h"
>  #if defined(CONFIG_CMD_WOL)
>  #include "wol.h"
>  #endif
> -#include "dhcpv6.h"
> -#include "net_rand.h"
>
>  /** BOOTP EXTENTIONS **/
>
> --
> 2.45.2
>

Reviewed-by: Simon Glass <sjg@chromium.org>
