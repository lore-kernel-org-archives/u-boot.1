Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26081C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 10:21:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94D2E88AE0;
	Thu,  8 Aug 2024 12:21:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WfBHmHt7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 831EA88AF4; Thu,  8 Aug 2024 12:21:27 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25F6388A7D
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 12:21:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2cb5787b4a5so625340a91.2
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 03:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723112484; x=1723717284; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s0h1vKK4Dz3U2W/jxsR8mjopo2GNob9JQI8RvhCVoGA=;
 b=WfBHmHt7Bb8UafZfxRI53vRoiOosQ53JyAYiV1VVesO3dp1v6v9BG5NF/E3jGqqbNb
 6hgAcjhj6vEbkrg/WyP7Qmxsn1oCYAmKoAvOTI6TrKIZKiVO8ZLpPaELn/RJEnTVZgJk
 1ybM5/azpSCPaLgzFpS2lKdMEb2Jiq5ym5i4oEjMaIaO7T24Is1S8ZBrNqze21Q7f0pE
 71DFSQv7XDWFTfWn/0vw18PoN60WrKKWR1xSnO0+5Y4w/FapuTQ+veqmOBbrJdcWxwEw
 wYMFOeK5A7It3nyoM/ZCjYYb+YoGeXJbO5lRKT0T7i1i7ByGkM7duZCPrSWQPjVyGDPv
 oaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723112484; x=1723717284;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s0h1vKK4Dz3U2W/jxsR8mjopo2GNob9JQI8RvhCVoGA=;
 b=C0fa5jB2RScqNm3HL73wJ8yxkkG7M0gL7Lng+dPyqvp5/0ZROJHmrBRwZ/CNXNxyeR
 +0qsnbqiRgfWOCjTB8Ql16rp5damSQcIUzG2373PqJNLdqA4F9ELpjVmnPzHqZEbIiRL
 cO+Ijvl1T0sL4Dm18h5Dm5jOEvBWT9blmGikTENHVNO7RHxRas3lGHhCxU5vUzMr6CuC
 /I3y8Zz0czDVnIqBOSctW+afRSQoNCzR3CcLR3Z4HTBvnqBuhCl5RIzWoZirhWytF32Q
 w1478RBuDKrTDfClNNcAInk7h92v/aAgZInulz2o0+uZmuL6RHlAmoUKfMvq7rcIpcGL
 ujIQ==
X-Gm-Message-State: AOJu0YxPiKHTrEcl+lHoKzkOi1tYrQzaPYd2gTZ8VmDmbgSf1FYk5l00
 eQnCg4oqYQ2pddwvFroOwZEekAqd7uuDTGjGD2mXDjnpebfgpDWYW9dHPLZI9j7cg1SnX+VFfOd
 OLHEGgborRP96HytfEXLDByWXhm08ZbzQsBVpMQ==
X-Google-Smtp-Source: AGHT+IHJeeWXRvREs4Q7Kq6nnSEH7CNgBGHI8E6rvUUix1DPr6xK7hSATClcRf32OsP5j5C/xh0IMcNu4JQ3ZDa0D5s=
X-Received: by 2002:a17:90a:4b07:b0:2c9:7e6e:3578 with SMTP id
 98e67ed59e1d1-2d1c3363086mr1608028a91.7.1723112483426; Thu, 08 Aug 2024
 03:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240806125850.2316956-1-sjg@chromium.org>
 <20240806125850.2316956-20-sjg@chromium.org>
In-Reply-To: <20240806125850.2316956-20-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 8 Aug 2024 13:20:47 +0300
Message-ID: <CAC_iWjLUta=sZDst2TZjDo1vTG7rHsvGaSMxY48Xm8-xkB_S-A@mail.gmail.com>
Subject: Re: [PATCH v2 19/39] read: Use map_sysmem() with buffers in the read
 command
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Tue, 6 Aug 2024 at 15:59, Simon Glass <sjg@chromium.org> wrote:
>
> The current implementation casts an address to a pointer. Make it more
> sandbox-friendly by using map_sysmem().

Isn't the code already using map_sysmem? All I see is some fixes for
unmapping it and a rename

>
> Rename the variable to 'ptr' since it is a pointer, not an address.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  cmd/read.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/cmd/read.c b/cmd/read.c
> index af54bd17654..8e21f004423 100644
> --- a/cmd/read.c
> +++ b/cmd/read.c
> @@ -20,7 +20,7 @@ do_rw(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>         struct disk_partition part_info;
>         ulong offset, limit;
>         uint blk, cnt, res;
> -       void *addr;
> +       void *ptr;
>         int part;
>
>         if (argc != 6) {
> @@ -33,7 +33,7 @@ do_rw(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>         if (part < 0)
>                 return 1;
>
> -       addr = map_sysmem(hextoul(argv[3], NULL), 0);
> +       ptr = map_sysmem(hextoul(argv[3], NULL), 0);
>         blk = hextoul(argv[4], NULL);
>         cnt = hextoul(argv[5], NULL);
>
> @@ -48,13 +48,15 @@ do_rw(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>
>         if (cnt + blk > limit) {
>                 printf("%s out of range\n", cmdtp->name);
> +               unmap_sysmem(ptr);
>                 return 1;
>         }
>
>         if (IS_ENABLED(CONFIG_CMD_WRITE) && !strcmp(cmdtp->name, "write"))
> -               res = blk_dwrite(dev_desc, offset + blk, cnt, addr);
> +               res = blk_dwrite(dev_desc, offset + blk, cnt, ptr);
>         else
> -               res = blk_dread(dev_desc, offset + blk, cnt, addr);
> +               res = blk_dread(dev_desc, offset + blk, cnt, ptr);
> +       unmap_sysmem(ptr);
>
>         if (res != cnt) {
>                 printf("%s error\n", cmdtp->name);
> --
> 2.34.1
>
