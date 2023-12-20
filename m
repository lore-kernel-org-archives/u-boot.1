Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC67C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 04:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5228F8744F;
	Wed, 20 Dec 2023 05:46:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J/yc9spu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F48C874B7; Wed, 20 Dec 2023 05:46:03 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D89B870B7
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:46:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40c3ceded81so53058155e9.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 20:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703047561; x=1703652361; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eku3lJFPGsEdC1S5l9YE9ViaQ9M7CKQqEiFxiYHk5KQ=;
 b=J/yc9spu5gYJuLH4Hs6B2tZtgleUaK5e2EBmYx5WN98KEezjHozbCwTEmLBpWcYCL/
 X2NG7DsG/yDkK3PCGhJ9VPG3bT38vjsr20DBneodtk4Nt/ESFDfeUNL81qnK40MRohpw
 UaJ7Dp1nRa9uk5dFNFDJoL4Az4IAkG+DznADU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703047561; x=1703652361;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eku3lJFPGsEdC1S5l9YE9ViaQ9M7CKQqEiFxiYHk5KQ=;
 b=l5vLmEC3OS+1jxqtkbbtxW5S4162613xmdl27Sj2ijLl3txkBZ5p1uQdaZGA2udxB5
 iro04E3oVWR0lLV2pMdNg+3WTXvob2/Ccujon9R7aqXEtnsA/1qANOkPFOIsv0+ZCmBk
 Wg3JLXQz6vdO/T/dvuf9CL0Yumjlo1jsbsDsY2/sTxGKEi70KH/ai0KhJTF0nnGsswOV
 RdgiTvDYIG3hrV2fASgD7OwaAuPO6ua95PcBjgwmXGndxP03UXvYrWOmbF0uIxaswgyi
 KXHQW16clGUzdK/P4U/sUgTb81n+9N4G194qh7v2/p8CxG0hvR3XDTex8OtSJKgHRTt7
 gwlQ==
X-Gm-Message-State: AOJu0YzizZxNtnPjL032jnq4OTksk3Fc8XjacRveJeT2TkpZGao0WxL3
 4D3XbzDph2V2hggW6xVCt2/0eQBQdC7yPeq6QVcjUQ==
X-Google-Smtp-Source: AGHT+IHGCIZ57IvjU5BbVRLPoNrTuD1nVe7TnuAu4BnqP6tQM03wfj/ghuyygRy36rV/1XVWCyj+fDKPpmDybFNu6ZU=
X-Received: by 2002:a05:600c:3c89:b0:40c:4a4d:b53c with SMTP id
 bg9-20020a05600c3c8900b0040c4a4db53cmr8080964wmb.162.1703047560451; Tue, 19
 Dec 2023 20:46:00 -0800 (PST)
MIME-Version: 1.0
References: <20231219101225.3443978-1-danishanwar@ti.com>
 <20231219101225.3443978-29-danishanwar@ti.com>
In-Reply-To: <20231219101225.3443978-29-danishanwar@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Dec 2023 21:45:48 -0700
Message-ID: <CAPnjgZ24Q_kAx4wkHtcWzwZr-K3DfMzUOABWGGEO80+_m7duKQ@mail.gmail.com>
Subject: Re: [RFC PATCH 14/16] tools/fdtgrep: Include __symbols__ table
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Andrew Davis <afd@ti.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, srk@ti.com,
 r-gunasekaran@ti.com
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

Hi,

On Tue, 19 Dec 2023 at 03:13, MD Danish Anwar <danishanwar@ti.com> wrote:
>
> This is required for overlays to work at SPL.
>
> Loading of symbol table depends on DT Overlay support in SPL
> so make it compile-time dependent. Without this SPL fails to
> boot some platforms where this feature is not enabled
> (e.g. dra71-evm.)
>
> Without including the <linux/kconfig.h> file, the symbol
> CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY will not be visible and
> we will never include the symbol table.
>
> So include <linux/kconfig.h>
>
> Due to some reason it needs to be included after
> [#include "fdt_host.h"] otherwise it causes a build error.
>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  tools/fdtgrep.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/fdtgrep.c b/tools/fdtgrep.c
> index 7eabcab439..706b4a35f4 100644
> --- a/tools/fdtgrep.c
> +++ b/tools/fdtgrep.c
> @@ -22,6 +22,8 @@
>  #include "fdt_host.h"
>  #include "libfdt_internal.h"
>
> +#include <linux/kconfig.h>
> +
>  /* Define DEBUG to get some debugging output on stderr */
>  #ifdef DEBUG
>  #define debug(a, b...) fprintf(stderr, a, ## b)
> @@ -1234,6 +1236,12 @@ int main(int argc, char *argv[])
>                 disp.fout = stdout;
>         }
>
> +       if (IS_ENABLED(CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY)) {
> +               /* include symbol table */
> +               if (value_add(&disp, &disp.value_head, FDT_IS_NODE, 1, "/__symbols__"))
> +                       usage("Cannot add __symbols__ value");
> +       }

This will need to be a new fdtgrep flag as we cannot build different
versions of fdtgrep.

Also, can we not update Makefile.lib to pass something like '-n __symbols__' ?

> +
>         /* Run the grep and output the results */
>         ret = do_fdtgrep(&disp, filename);
>         if (disp.output_fname)
> --
> 2.34.1
>

Regards,
Simon
