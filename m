Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADD1C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:48:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1915878CD;
	Tue, 26 Dec 2023 10:47:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dCCquzDm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54E758781A; Tue, 26 Dec 2023 10:47:19 +0100 (CET)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11CD387831
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:47:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6d93d15db24so3748922b3a.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584035; x=1704188835; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gUEJ8hfFDAlfCk2jtTuRuBV2hFhM9mPu4vcD1cEmois=;
 b=dCCquzDm7d/7WnX/Jnl3HVPOZwCeehdmyAuxCg3LFUDwB05fyNvNzo3bmOjw2qZ3qk
 /V2DEZPX7/ejUpr73dTGdTLX/PCFq+GhYcgQmJR4bFbrGFQlOlWj4UpUBqEhTnLisshl
 tJzvnLh82aCVmhJUNF6HuBGtKQXqcYwkHXWiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584035; x=1704188835;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gUEJ8hfFDAlfCk2jtTuRuBV2hFhM9mPu4vcD1cEmois=;
 b=h690XcRPHP9fSjX3LGXZsvNHGWPRXI2/LaxBoiWu+HtXjielmUx8dvGyzcAVZCBdhi
 6PXRj0qDZE3TL5Q63gsWJFA6L4AFmWUU6t8bMUQZQbeR0Std0DUS7nmqBV1jTvcEm/Rg
 JyTlEdvcrJjFDsMJhMQdMmYCXR8bCGxBomHpAJ2xfqUKIPtWGduXvZ2sFCKlHot83KAV
 fF1HHON4/meg+HPg/TCaAFfQ24PIxHA3CnQ5vGipTkVQmtflfvBl7wx8W8CvRm7Sj/bl
 tjH1W7POj7l0TxonKGR9y3gGlKB1mEkhaRDLPIazGmMOgtI+W2rHmA4W8iVHiH58e5We
 6GVQ==
X-Gm-Message-State: AOJu0YxVxXkd+Ffytt0/TiLMjIIv7ssX2Bk4f9CBvLBAz8J7wqn3/Ii+
 YzIM7XXMeWV+uVwSeHR+xAipMe7mQVH9Ac5NukGtAE5UftSK
X-Google-Smtp-Source: AGHT+IHlNF4tBFiUfaof5cwU1Em8NBA6B/OimHkLAX4VKxk2lxetnJjZBxJqsUGYjRGRL153J2+gTROJu5lznBX+qD4=
X-Received: by 2002:aa7:82cd:0:b0:6d9:ad07:e860 with SMTP id
 f13-20020aa782cd000000b006d9ad07e860mr3784536pfn.35.1703584035387; Tue, 26
 Dec 2023 01:47:15 -0800 (PST)
MIME-Version: 1.0
References: <20231219103418.3445886-1-danishanwar@ti.com>
 <20231219103418.3445886-16-danishanwar@ti.com>
In-Reply-To: <20231219103418.3445886-16-danishanwar@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:47:02 +0000
Message-ID: <CAFLszTjVBzpM-GiraSSNtXtbbQGPDUrCo7ZDjyeByx7Xtg+t_A@mail.gmail.com>
Subject: Re: [RFC PATCH 15/16] tools/fdtgrep: Include __symbols__ table
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
Content-Transfer-Encoding: quoted-printable
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

On Tue, Dec 19, 2023 at 10:34=E2=80=AFAM MD Danish Anwar <danishanwar@ti.co=
m> wrote:
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
>                 disp.fout =3D stdout;
>         }
>
> +       if (IS_ENABLED(CONFIG_SPL_LOAD_FIT_APPLY_OVERLAY)) {
> +               /* include symbol table */
> +               if (value_add(&disp, &disp.value_head, FDT_IS_NODE, 1, "/=
__symbols__"))
> +                       usage("Cannot add __symbols__ value");
> +       }
> +
>         /* Run the grep and output the results */
>         ret =3D do_fdtgrep(&disp, filename);
>         if (disp.output_fname)
> --
> 2.34.1
>

I may have replied elsewhere, but please use a new fdtgrep option for this.

Regards,
Simon
