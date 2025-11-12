Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0233BCCFA1A
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 10:50:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44D5283C46;
	Wed, 12 Nov 2025 11:50:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W+ymAE21";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF1C883C51; Wed, 12 Nov 2025 11:50:31 +0100 (CET)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A01A83C08
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 11:50:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ranquet.guillaume@gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7afd7789ccdso608539b3a.2
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 02:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762944628; x=1763549428; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7/zioW7Q/pgup7bbh7O0s79YhTPcyAJ2acEDRHir4sI=;
 b=W+ymAE21G7ss+h2o85t4GsWzhM3mwIqIqQqtVnLoUBKkCTUraZdM0XlK2wKHdM1OdM
 2Ez3M7JdU/fXBEDpUABON2XJewcf7yMEsMzSagnK5FFxhzqUtXoDzgHMyWjOM/l93AqS
 f9de/AVyXnSTSSygRk1HDCODOgRUQLPYHrzZ9hyk18nwrEw3CkL7WAa9XLoe1x+Oivtt
 r0aUUHxYU4wlS2hxOYU9CzXpJvIURjDZJyJYEZ5y+ylGsw3O3DzwiYP935Llyd5yrV/H
 s/xaguXJx5PE2mqrOTjoDqGlwbmmSxh+Oo7RSQQE9OP3JxTh1pQ78YHXNumpO6AYgpbT
 /9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762944628; x=1763549428;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7/zioW7Q/pgup7bbh7O0s79YhTPcyAJ2acEDRHir4sI=;
 b=FSrBMOS8RYZ6eJglzdNJbl8AaC0bvhoivfA6igfOb1/POZ8jE3G6w+p3kN9VID1+fN
 zjDolS6+VPJcg+PKOb9lsBDWXjPZ1oYyODf+g6C3gOjd867lLFX7OW7JfzfB2AEIURQW
 B+dhjeXhalER44TZS6btoDitgCdpZk5IBvrbMKyV2I52ga6PSOdq6Cv/Bj03SWtiPSs+
 gLUYnPCbXYBLCKg/zFfJRfxiorQjqwGgUrKFhbI7IMB0GCFY382iz1JVARkfeknlREUO
 md1Kq8hofM9P+YEYdGvHtkjZO84o5roPL3WFA+YmcGhFOM4w7yf0lHe3VG8TmOHDQagG
 S3Dg==
X-Gm-Message-State: AOJu0Ywxnv38wZV1Lasa02le1gfqjX615FZ71eeKPfnMyOpB+9O4S6Yu
 cspQjRnnMQM+xPdCN55PJEd0n20eTdOrbNpC2955P9J1RkTzt63E9Qi64A4f+RxQRwpUPDRzsKA
 HAd+vngMfxyZOg6kukDpW/W/FdI4ifvE=
X-Gm-Gg: ASbGncswWlt54/jNtTm286xgmidiU511ZuGnl9p97SHKs/TeWyUc71YtSot9K/Yx4oM
 c7F8jMUh5km+Mmhy9MpCqLD77l7yIS/dJ+bdFh3raAnVhu8DeO4laAulYMb7UkiUeEhYi4K8EFk
 FWT59Mda6xQ2gty67SN0PSYlNUxaRABVuzeCxZb67Z2PNISD6zG3nkaWrOk8w66RTMINeMs0MkO
 A8SWqPSIJBbIQYwN7PHtLqtAegpJH7ba06cMyvGbxQPL9s4NU2/AMEVKg==
X-Google-Smtp-Source: AGHT+IFSA97y9CePWsNWz2peU+GpdUwP611kinBGjhsW9IYq4w7IkL/Hi/3ZvKTD1GFpfYshYgvtUWjmxK6A5ngyY3Y=
X-Received: by 2002:a17:90b:50:b0:33b:938c:570a with SMTP id
 98e67ed59e1d1-343ddefbbbemr3286894a91.33.1762944627887; Wed, 12 Nov 2025
 02:50:27 -0800 (PST)
MIME-Version: 1.0
References: <20250911-fix_fit_zimage-v1-1-bd779ef56b22@gmail.com>
In-Reply-To: <20250911-fix_fit_zimage-v1-1-bd779ef56b22@gmail.com>
From: ranquet guillaume <ranquet.guillaume@gmail.com>
Date: Wed, 12 Nov 2025 11:50:16 +0100
X-Gm-Features: AWmQ_bn-w3SqDKYwSJwk_O82vPWEErg0b1tfVEx-HDzRBkLi7V68tkaeZk1XMt0
Message-ID: <CAD+NunZzju5gJjrCBTVrC7xFBftaLpW5JOc0n+MgDDCpYgYjsw@mail.gmail.com>
Subject: Re: [PATCH] x86: boot: fix unreachable else branch in boot_prep_linux
To: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Thu, Sep 11, 2025 at 3:35=E2=80=AFPM Guillaume Ranquet
<ranquet.guillaume@gmail.com> wrote:
>
> The else if branch uses the is_zimage boolean which is initialized to 0
> and never set before being tested here.
>
> remove the test on is_zimage to make this code reachable.
>
> Signed-off-by: Guillaume Ranquet <ranquet.guillaume@gmail.com>
> ---
>  arch/x86/lib/bootm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
> index 0827a884b1d245ecb8a55d46105a1d67d0cdfb56..7a94dc877e31dc8c02131699b=
9318c35e4fcfe79 100644
> --- a/arch/x86/lib/bootm.c
> +++ b/arch/x86/lib/bootm.c
> @@ -103,7 +103,7 @@ static int boot_prep_linux(struct bootm_headers *imag=
es)
>                 }
>                 is_zimage =3D 1;
>  #if defined(CONFIG_FIT)
> -       } else if (images->fit_uname_os && is_zimage) {
> +       } else if (images->fit_uname_os) {
>                 ret =3D fit_image_get_data(images->fit_hdr_os,
>                                          images->fit_noffset_os,
>                                          (const void **)&data, &len);
>
> ---
> base-commit: c85b8071e7d3fd333f8a2fdd28083cb5ec3a0645
> change-id: 20250703-fix_fit_zimage-57bd629f5ab5
>
> Best regards,
> --
> Guillaume Ranquet <ranquet.guillaume@gmail.com>
>

Hello.

Seems this has gone a bit unnoticed. So let me try to add a bit of
context on why I ended up sending this fix.

I'm running Xen on x86 using fitImage with hyperlaunch (I can give
details on what is hyperlaunch and how I'm using it, but this [1]
should help already).
So my fitImage has 2 configurations:
* Xen with Linux as a loadable
* Linux as a baremetal image (used for recovery/provisioning)

Why am I using a bzImage as a linux loadable for Xen? Because this is
the easiest thing to start with Xen (it might be possible to load a
gzipped elf without the setup bit of the bzImage) but I haven't spent
time looking into it and a bzImage is what my OEM is working with.

So, in order to keep things simple, I want to also boot linux as a
bzImage from a fit image in my recovery configuration.

Hope this bit of context helps with the review.

Thx,
Guillaume.

[1]: https://docs.u-boot.org/en/latest/usage/fit/multi-with-loadables.html
