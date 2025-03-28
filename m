Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26691C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 12:20:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A130809A4;
	Fri, 28 Mar 2025 13:20:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Idv+sDWI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C8A2810EA; Fri, 28 Mar 2025 13:20:45 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4330A8082A
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 13:20:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e60cab0f287so1604502276.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 05:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743164441; x=1743769241; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=upGcCft+qE9YjN1hbcSB+pXBUbxn7dV2NeXANW0cuxY=;
 b=Idv+sDWIkA8c8Ke+d6LH6UIXgiYnDAnDeQbbFDXN/e5Nqw7RHqM8T1lm7YWMjlKhog
 we+zgSgSYMyhWBE0gT7w42Ldyd7326nKBAGKLWYiZnbFRt2qrzqCzrpgz20DM8lvNxnk
 7+YEAhg6nYlXzhD8uLAKtv7x4XP804RlcL7/gi8zBU6g37uigkx1jpP0/g/YIwMe4CEn
 YNdlleyiWVP4NkngW4/VEaK1oMsWu+NRc0RpXdIqb8Ig6dHXJjb0tfNGAvUsK3Vq1Pw6
 dalelpqvpQouxqEZlaG1zF60cGIlkp9A5YBJ7ctNu/pYwZoACtaRQqLtIp9XOxhoN43K
 T/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743164441; x=1743769241;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=upGcCft+qE9YjN1hbcSB+pXBUbxn7dV2NeXANW0cuxY=;
 b=OIc9bLdo9APAOaUSb0gXamSTxDSbYe2KiCcFTPrh5LibbVWr0586rsosjVaz0ithiN
 nFh0fx1BIlsod51p5FfWgSurEYj1nctFi9JXsQYke72NtGTHyYaw/wvH84Az1Tlw6jFp
 d+DwlpDTvVn4PcoQ++nLpFDquyVDj2llSJaUYSjYHvqge6hqYQ1c65VOeHmtL6KeQOI0
 ptgH3eJhbmGtXDO8/2wO42nYfc24BYLuFu7DMmgY/tN3nClEdoqIbNipz9jplA7aRGQI
 K9/5A5mpseaKiEIpvoSZnNFG5oUvCsP8uKZMNIgyhQmnyreKRqktFQF1Vspq+6m+Kl+r
 4Ypg==
X-Gm-Message-State: AOJu0YzSULFa38p3zXZIWuSvFMzy4Eva9IHyNGVg9G5XGfHT0SOtpF50
 xYXE3ZCoOT3+jh0xfo6rvMHc9KX9WaOHX27fK/hVb+0U/3Awk3QbVCLNhHgqmVqixYegCbNQlAt
 s77Ynk5cIC7/QQPj8LQXp+AldnsDAyZewm7YVPg==
X-Gm-Gg: ASbGncusMJLxQJ/wZ7+hv2/tGHuCCPmFQDrjgvqnrtti9wUS591av7Snrv3kBFkFNsY
 ltPKdCSVcIGj1ffGyfxPXwsxuPjKCgP7k4Kk1mbPyfSoRNLL6FZwyKXhqgxtsDJl0NqOkPnZZqo
 Io6KI8DEUNpBgkNiuGRjb2L3gr
X-Google-Smtp-Source: AGHT+IGMx5cxMbItv5M9lwcXwGec4PsOL8OPQag0CNy92JcSHUsTOs6iUikWsx2wq72ZAow0Zl9GnAeHiBqUwHInPj4=
X-Received: by 2002:a05:6902:2409:b0:e60:5d76:f7a8 with SMTP id
 3f1490d57ef6-e694376af34mr9487791276.43.1743164441396; Fri, 28 Mar 2025
 05:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250327231318.2713201-1-raymond.mao@linaro.org>
In-Reply-To: <20250327231318.2713201-1-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 28 Mar 2025 14:20:05 +0200
X-Gm-Features: AQ5f1Jrpc223rv7IUGqJ855mGUWUXL2JIiAWUbGpJTFqx3URlZRQvnoKcF2YTXg
Message-ID: <CAC_iWjJc1FWrJguL+d_zKn08=PaA10WR2QtLtnXkrah5YRH+3w@mail.gmail.com>
Subject: Re: [PATCH 1/2] bloblist: fix the overriding of fdt from bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ravi Minnikanti <rminnikanti@marvell.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Matthias Brugger <mbrugger@suse.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>,
 Caleb Connolly <caleb.connolly@linaro.org>
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

On Fri, 28 Mar 2025 at 01:13, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> When a bloblist is valid and contains fdt, it explicitly means
> a previous boot stage is passing transfer list compliant with
> Firmware Handoff specification, thus the fdt from bloblist should
> not be overridden with the ones from board or env variables.
>
> Fixes: 70fe23859437 ("fdt: Allow the devicetree to come from a bloblist")
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  lib/fdtdec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> index f09c9926a7a..c38738b48c7 100644
> --- a/lib/fdtdec.c
> +++ b/lib/fdtdec.c
> @@ -1708,7 +1708,7 @@ int fdtdec_setup(void)
>                                 gd->fdt_src = FDTSRC_BLOBLIST;
>                                 log_debug("Devicetree is in bloblist at %p\n",
>                                           gd->fdt_blob);
> -                               ret = 0;
> +                               goto setup_fdt;
>                         } else {
>                                 log_debug("No FDT found in bloblist\n");
>                                 ret = -ENOENT;
> @@ -1752,6 +1752,7 @@ int fdtdec_setup(void)
>                 }
>         }
>
> +setup_fdt:
>         if (CONFIG_IS_ENABLED(MULTI_DTB_FIT))
>                 setup_multi_dtb_fit();
>
> --
> 2.25.1
>\
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
