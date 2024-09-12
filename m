Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81F3EE57F6
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:04:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D6BB88E4A;
	Thu, 12 Sep 2024 03:01:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nYf04HvN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0217D88D09; Thu, 12 Sep 2024 03:01:25 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAF0E88DF0
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:01:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7d4fbe62bf5so324225a12.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102881; x=1726707681; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JlQjW4KCY1QuP+STMYQVDmqQfNoDpNzJE4k0ZUEm7iM=;
 b=nYf04HvNVFUUqxVCoO0LWZX1iifZfPHMksmvGnyzCyMvs5MUjh40fsi+TYbhjkwjmM
 JNJNJqDFwNVYy2XyK4qcxf1D06Ha1hW/tWxT1PS4IdpGuLoyepEo1rAMYMYOrc38c2i6
 GuvDWem+I1BqzchbAwdk/r/SjSUQhqCDk/EmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102881; x=1726707681;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JlQjW4KCY1QuP+STMYQVDmqQfNoDpNzJE4k0ZUEm7iM=;
 b=RaPZFIdNpMBeMpO3xyO+KFydpauLXx5jZORvvEHPJ5fiWSN912i5SquIQ3pnfaXjOk
 ARn2t2P+24mgEziZIs/uv33G1WL1k2YLS+B+hIXKDUFI/8bByk3B/zYkCK7iAevFVwNs
 im+0XhSXAM0xkwddbD/sXK67lRlnPWLfWAVVM2siA6ekeEc/yO7XvFibe4ctuPG4CP1q
 cPOLUodOisOEPfHrZFrUEffO47dUn7brciw0RYcfQV3+q3BCatEybMeIqg7KzhahCwCW
 /zcItdoNpUbrK+MSxoIFmRkiie5uWy1JU9VRZ9QbaEvvotQXjXtYz8d166W+NJI53Gu2
 pFsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzBWmbsuBEg7+IMcBQwaPP0//vnqy34JUMmL/AvEoGoZiGFiN73moIZSmQA+R4AI/IXYqdd3k=@lists.denx.de
X-Gm-Message-State: AOJu0YzYqCH5TLa70GiwWuLBL1tIe3tW9BNGkC6ylw0D01rD14WKVxpd
 pkvU4qyPSq6AxDilmb0j7LbIOeWEP8XSud8mYZ3RWqlgcqub7V6z/Ci8j+F5MgzHbPBzZWLDABD
 rZUQVAdaMu92qBGwWR6m9qvZ+GhVALxj9RvHi
X-Google-Smtp-Source: AGHT+IFp+mByppLcWyDccKYsoZlGMgfbxbW8xwdN3eGCRKU5YEr1Q1sRiE0NKTvGSULy6KNcFS1JqhxxacrncblSCKI=
X-Received: by 2002:a05:6a20:c70b:b0:1cf:44ac:7144 with SMTP id
 adf61e73a8af0-1cf7620c0eemr1280033637.31.1726102880672; Wed, 11 Sep 2024
 18:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240911214945.15873-1-ddrokosov@salutedevices.com>
 <20240911214945.15873-4-ddrokosov@salutedevices.com>
In-Reply-To: <20240911214945.15873-4-ddrokosov@salutedevices.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 19:00:59 -0600
Message-ID: <CAFLszTioqS8tS4a8iexdbLJ710nwxJrDMS6MpeN6i6hD7iQk2w@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] cmd: bcb: change strcmp() usage style in the
 do_bcb_ab_select()
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: igor.opaniuk@gmail.com, mkorpershoek@baylibre.com, 
 semen.protsenko@linaro.org, trini@konsulko.com, colin.mcallister@garmin.com, 
 4.shket@gmail.com, avromanov@salutedevices.com, u-boot@lists.denx.de, 
 kernel@salutedevices.com, rockosov@gmail.com
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

On Wed, 11 Sept 2024 at 15:49, Dmitry Rokosov
<ddrokosov@salutedevices.com> wrote:
>
> In the entire cmd/bcb.c file, the return value of strcmp() is not
> directly compared to 0. Therefore, it would be better to maintain this
> style in the new do_bcb_ab_select() function as well.
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  cmd/bcb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

And throughout U-Boot


>
> diff --git a/cmd/bcb.c b/cmd/bcb.c
> index a56535a743c0..a888549eed3a 100644
> --- a/cmd/bcb.c
> +++ b/cmd/bcb.c
> @@ -432,7 +432,7 @@ static int do_bcb_ab_select(struct cmd_tbl *cmdtp, int flag, int argc,
>         bool dec_tries = true;
>
>         for (int i = 4; i < argc; i++) {
> -               if (strcmp(argv[i], "--no-dec") == 0)
> +               if (!strcmp(argv[i], "--no-dec"))
>                         dec_tries = false;
>                 else
>                         return CMD_RET_USAGE;
> --
> 2.43.0
>
