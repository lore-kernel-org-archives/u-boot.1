Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB5ACD4F3D
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 20:42:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 491B2847EF;
	Wed, 20 May 2026 22:42:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MDqoZTeM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C022B8480B; Wed, 20 May 2026 22:42:36 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D14318467A
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 22:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b936331786dso694383866b.3
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 13:42:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779309754; cv=none;
 d=google.com; s=arc-20240605;
 b=Qf0k4Z0Ug825IlNNRJHVwYbzuyLVh2LpyJdfGjGrjNEfhRK+kaboMkEyfKJTLZ123R
 FZlhSCkkaItfcYqUV8WxkdflhWcFL8gDF8lL19WqnqhCg/C/11KIYY0i5SbVEIf/exz7
 avU+yNoonIPxqG+hi5+Om4xIqhrC1oyG2To+bsgO7JFArIvYV6bKJUOSwORcwvPhfkP4
 rb9ejXg25kSfDIQlehscbF8BmtrO++ZY3UUHPVLF9nGZYyaEOohZ5MaDygJn4MeLqGeA
 LrQ5l9oDPftZPYOuGlXwSPIkbZhW85Pf4RpjRdiHh2Dx6WznKcf7CIUSnCm7u+0VieP4
 VKlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dDZJv7UlUn74A/Z+OhfVHmGeZ/3pnTEAEt/ElPY3xUE=;
 fh=MVM4ZlGZWTuxUGEWXkl1dd9aJOIC98oiujcWy8v7d4I=;
 b=aJ7tz3Su4zfT6gFnI48UOarqP0dRxiRmv84tsWbN4H2o3aRrTYjgv2kpmKsFvwJz3J
 X2iayB7Gsn71wUHUSyH0UQtbA7pdrS5ikJk0i2+BriQUW/g5mTxcrX7kC0QyB4ULatE9
 ycVxQ5T8DtdqVDmT/iuOtAeXAcJF79cfGHlbhpUEnVkGi1bsj8Fy0ZJrM68bl68p8rt1
 kPfFhBf7fdaIV912SQsiZZTgXuQHCIYbn69cg+EQec0FQoV0K8803fi9q9Ts4bGa3vFe
 uZqO9eedPdBxyc/p0v5yNj5lF7EcdwN7igz0loX0PY/tQLyZ9LuEKvPEFjiZSpG+fnDY
 N2/w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779309754; x=1779914554; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dDZJv7UlUn74A/Z+OhfVHmGeZ/3pnTEAEt/ElPY3xUE=;
 b=MDqoZTeMCMUaKRtnMOZXuixr32n6H7G8Y9ub7cVtJuhiEsoRXovWkklQ1+0VRRU9pe
 fBUP9MfXJVfnTOOZoo3FI3OJ8MJ8wsOYk6BlS114S1MYZzQV9KCjXVJoErh0hRJ2IC4v
 o2Pra4/Gc09Npb4SOiXmhwPM7uLIBgO9Rw2OM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779309754; x=1779914554;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dDZJv7UlUn74A/Z+OhfVHmGeZ/3pnTEAEt/ElPY3xUE=;
 b=Uz31Yk8Rq1XLxjuRhwsnVOb3DxmpnhxGqKaMToM9oUndlIAlG1SYqXHMeo5Z0/bn4W
 oTfH9D5sCzo8jdap6St8BD0l1OrvETb6G/iCzErfHQarclN+yy1mLAVCCSbZxfvwfY8D
 LVZHsCo2A7OoW95sttx4hMwka9CFf20dWDgQnfTcjsrj/ja39HqvUJ77yy5Tnguo2jSN
 c8knurB4BNe9iXJYtN9ZipvfZF5uUGdAfrsN95/gRYJQE73xvq4XxCxNUPb5mdWz0hS6
 oearb9NTEh+HbhB3wxwxDPwega1ZTy1nFXpfdQpZY1MtJybkBWlq1DPOe6PrTmGIGG3Q
 HokQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Wx+2TgpG9yUtb+QH4FepFlQLAaZdbfOiSJ3H+/7Vd60r0slGyuSWx9sVZ4YznG9tdvtKvmeU=@lists.denx.de
X-Gm-Message-State: AOJu0YxEUTCYB/JyTSl4dJgdy2Kyxx5UTevCyGORGE4TJ5OBCMIdBMnL
 jqdkM78Ijo3sXecJsGdVzcRRrS6rcpwf0gXLa6NRQjIQmlM+L77WSUw0tnsNTXgd80/vrYCscQl
 ise0+bwhUpmitPLWvZZKdIN17eZA+VjMWC0hIcBaq
X-Gm-Gg: Acq92OFr4TPTZt97adDzucCesbQT5O9VAR2lQ3/QL8gux10sxEKYNhaEasGo0eisCHT
 2ByReVku/6FlB0LiX0xonRksvRhsyR6sN/yau8o2LDtTR3nh7BRzrTrL6563akCk6eh0uUKHCew
 NVbXCeGFWZ/cgjiO7H3fw/nudYvc9LJvKfWREXFyL3+Gb7HRe/2xYTAVRPgMmBcwqv3EaOGdjqm
 Y6NV6f1Jh/fLDRue3x41jzQUQH+gMZvjJ0qjZqAvTwo4UDQ4vHBWTGJ5B5VHSXg7sIr7VyM2Z8r
 dpByMg==
X-Received: by 2002:a17:907:7295:b0:bce:259:3d64 with SMTP id
 a640c23a62f3a-bd51795b057mr1406996266b.37.1779309753854; Wed, 20 May 2026
 13:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
 <20260518055728.178507-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260518055728.178507-4-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 May 2026 15:42:19 -0500
X-Gm-Features: AVHnY4LDiDqOlen9UUrA2bhfoboGGdOX8RI-NTpbl0URCz40H9NEbYtHKc4rZus
Message-ID: <CAFLszTgZ=ciSU-ny1+X+8jYsvRD-jc-TVQ3WwfyZ3DYvmR81Ug@mail.gmail.com>
Subject: Re: [PATCH 3/9] fs: ext4: print change date in directory listing
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Huang Jianan <jnhuang95@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tony Dinh <mibodhi@gmail.com>, 
 =?UTF-8?Q?Timo_tp_Prei=C3=9Fl?= <t.preissl@proton.me>, 
 Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Daniel Palmer <daniel@thingy.jp>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.denx.de, linux-erofs@lists.ozlabs.org
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

Hi Heinrich,

On Mon, 18 May 2026 at 00:57, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Declare FS_CAP_DATE in the ext4 fstype_info entry so that fs_ls_generic()
> displays the modification date alongside the file size:
>
>  4096 2024-03-15 09:30 filename.txt
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  fs/fs.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/fs.c b/fs/fs.c
> index f8e4794c10e..482a5523712 100644
> --- a/fs/fs.c
> +++ b/fs/fs.c
> @@ -261,6 +261,9 @@ static struct fstype_info fstypes[] = {
>                 .fstype = FS_TYPE_EXT,
>                 .name = "ext4",
>                 .null_dev_desc_ok = false,
> +#if !IS_ENABLED(CONFIG_XPL_BUILD)
> +               .caps = FS_CAP_DATE,
> +#endif
>                 .probe = ext4fs_probe,
>                 .close = ext4fs_close,
>                 .ls = fs_ls_generic,
> --
> 2.53.0
>

I would prefer having a head-file macro which expands to nothing for
xPL builds, rather than adding preprocessor macros.

Regards,
Simon
