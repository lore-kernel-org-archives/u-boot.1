Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE3DE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 13:37:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF196801E8;
	Tue,  7 Jan 2025 14:37:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f8zsNXST";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 972438036B; Tue,  7 Jan 2025 14:37:47 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42D248007D
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 14:37:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e46c6547266so19757421276.3
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 05:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736257062; x=1736861862; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4P5dnOBiesAtWPq9HSPJoMSbo5ROEaZpVCkk67BgYaw=;
 b=f8zsNXST7GbbeX2bQiGhIibdeqxk/p/A9aO9KW5x0uTk4bFrpkVFmLyqJrRTLRy70j
 hkDTKhyQGmx55zQjh2Jl09okxJQnH6KxUOKUxd+aY+CHi0TIPIE3yQcuo77hgeK9Vy94
 iZTBOpS6PXNWu46pI6D9aVT3DQJIJ7B7SNwexGqv+8Qm4hDlghPIJ+d/zBzDvyt12FMz
 UFKOmZpheVaUAsoz/Gcie+qBE54eTKeSDS8b0ocb9Q5lACs2/0mrPREuRVZjOdNPr5N0
 USZE2TKEH0l92sEBuTbAys4KaVWZODfjLK86TseP3ujCLLsBPoYT6jZEWOd9xJm2ugCt
 leJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736257062; x=1736861862;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4P5dnOBiesAtWPq9HSPJoMSbo5ROEaZpVCkk67BgYaw=;
 b=BlnMKZXf61N7Sy6Gn5iEdW5v46NYA4Jyz/3XdMVrEyBepWpXlqq2N5ypAVHKp5SbLH
 5kkIC1qq8fNY3RAIfUPbe1TcWoqnhPZIoC25Dc+ZY9w61fBC6wF2KfMwp0NtqNE14aWm
 enbZ5WgQpywafNLOzAWKBaD3swbxarFbTbgHJN+h2dp4HHHDP+ukSBe6aSigBS00pq0i
 05PwwrHETrJQ21WBDeRWSn1sUX5QWldUEsCls+yKNxD3m10EPkd/W8l+0IK5WY6vGlhD
 pdR9Zq79TJnAh1GTTFjBzJ6EM1T9/SWb19imJyowAqxHo4aEVkZ+hxriqAPiDzRyVsEW
 Zemg==
X-Gm-Message-State: AOJu0YwPt5EUO8m1EhP6Q0VVtJPQ8oAwKDIov1eddJ8W3Ze6VlfNLJFk
 PKEvsuWZE15LzfrQVaHDSK8O/2jitK7YCl4POcieKAbNoXeTO3rFUWhbjePbx2zumwSMsflb60A
 z49fGuCNce9tQ2djMjxVvcmrzmkPBx8L52+jI8Q==
X-Gm-Gg: ASbGncuBNtPoV1SSz8ADGn7FLqflsHoUGqLnF7w/IZ7IvTRlVSnLQD2q+GFul4y0ix9
 ifOeJczslEy8THKqxNO2FC0MkRJJxY7wdUUxYMQ==
X-Google-Smtp-Source: AGHT+IHsO1HE9wJA3mABxbfIKqP0D0iNkjCJN1hyESN83RmVG/bW5aV4oMchyJT8+DH6acHC+4vT1fdhsW2Qt23unUg=
X-Received: by 2002:a05:6902:703:b0:e4c:ae89:1603 with SMTP id
 3f1490d57ef6-e538c3a31f7mr45839854276.41.1736257062067; Tue, 07 Jan 2025
 05:37:42 -0800 (PST)
MIME-Version: 1.0
References: <20250106144755.3054780-1-sjg@chromium.org>
 <20250106144755.3054780-3-sjg@chromium.org>
In-Reply-To: <20250106144755.3054780-3-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 7 Jan 2025 15:37:05 +0200
X-Gm-Features: AbW1kvY2NgSZDkUSbL_tuSMEGdtydn2A9N5SRF7O8SJMQIPpeNUBCC__uSKL88U
Message-ID: <CAC_iWjLrSEpHgTGK3WhHTGQ-SF5Zg6o_h14x++ot8FD+JAm3RA@mail.gmail.com>
Subject: Re: [PATCH 2/8] efi_loader: Fix display of addresses in log
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

Hi Simon,

On Mon, 6 Jan 2025 at 16:48, Simon Glass <sjg@chromium.org> wrote:
>
> The allocate/free-pages functions return an address, so there is no need
> to convert it. Fix this.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Fixes: c824a96d76d ("efi_loader: Use the log with memory-related...")

I can't find that commit in -master. Is there anything I am missing?

Thanks
/Ilias
> ---
>
>  lib/efi_loader/efi_log.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/lib/efi_loader/efi_log.c b/lib/efi_loader/efi_log.c
> index 4b9c6727fe7..ad490bb431c 100644
> --- a/lib/efi_loader/efi_log.c
> +++ b/lib/efi_loader/efi_log.c
> @@ -340,8 +340,7 @@ void show_rec(int seq, struct efil_rec_hdr *rec_hdr)
>                 show_ulong("pgs", (ulong)rec->pages);
>                 show_addr("mem", (ulong)rec->memory);
>                 if (rec_hdr->ended) {
> -                       show_addr("*mem",
> -                                 (ulong)map_to_sysmem((void *)rec->e_memory));
> +                       show_addr("*mem", rec->e_memory);
>                         show_ret(rec_hdr->e_ret);
>                 }
>                 break;
> @@ -349,7 +348,7 @@ void show_rec(int seq, struct efil_rec_hdr *rec_hdr)
>         case EFILT_FREE_PAGES: {
>                 struct efil_free_pages *rec = start;
>
> -               show_addr("mem", map_to_sysmem((void *)rec->memory));
> +               show_addr("mem", rec->memory);
>                 show_ulong("pag", (ulong)rec->pages);
>                 if (rec_hdr->ended)
>                         show_ret(rec_hdr->e_ret);
> --
> 2.34.1
>
