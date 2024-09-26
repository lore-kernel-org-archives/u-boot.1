Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBF1CCF9E9
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 10:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C0D488582;
	Thu, 26 Sep 2024 12:03:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kP57RJf7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC07188C91; Thu, 26 Sep 2024 12:03:08 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB7B4884DB
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 12:03:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c40aea5c40so1465554a12.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 03:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727344985; x=1727949785; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QsiRRy9CrFD/+OqvdfCVE+0mQoP0jYmMfnS8QSWyGO8=;
 b=kP57RJf7IzQ+k5+aiRUbsc4OND0C9yjSNpeBPgYJ10TEgL7xcLE+F12lsykTxOB8ie
 bueKRShC3GW15D4CUaw1K9kzPIuc9kIUMDX0tjExTasy3ycefmzzaqpA1ckMLeS5gUaS
 CIitzj2EsfMOvl9v5dSJOUmFdp/vGnGaIerW2fAxJZ8yB3vQZbgmiMtLcBjwLWqIl/KK
 tXbgglfMHvGMvCFBJHpkcQ7bU8XoVHD89aRIiP2CpNECxFiWQ9Piwlj3djw4ITN8JAk6
 A9eXJOyglrg4RpDXDktra3UsKznUZtTiHIAurUCkZR/ddDOuF6m3STxbQ8+z2cU2x8ou
 4QSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727344985; x=1727949785;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QsiRRy9CrFD/+OqvdfCVE+0mQoP0jYmMfnS8QSWyGO8=;
 b=wN1eMZJgubMWhu34BJyb3gHlw5p8sXKcbL/Z/5CxkM9dnf79UKFc21WjJM84B+jIAt
 36tk8cqO1MboTvTJhytM1XhXTUI46F72foCwKfoD+TFG6x5iVXX9EV80F/mWnJRol7Vj
 rYO6A0Jka5rnpmzsM+mZc36Qtzp7G7XdFJ45kcFC+SQTXcrxaxrJJtChwG/z4iJkwUOY
 7zQRq0l9tSeCz2UWAyIs43bB29E6wZv3BnyNo0tw9YytQrYpU7H6WBBJW9nkXpHzyAgj
 qjTPSvDblwEecmpKVBRg05FuHVaSSoWtTyJTC4wNWlG5HmR0wy66rxT6g+Z8RTDPZWGl
 2kAw==
X-Gm-Message-State: AOJu0Yx+LQRez4AOZiv01A0gizIAMkEF0OekdFaD05pkF03PT2T3ikLi
 2aPrWdRWM5Cy/5Ne3VJtwUfXkwmbvH6YbO5S3L1LO3F61iQtpYvKDekEo3dDN2bLUGnKFJiEphd
 PqCwBLT5SDChOuaXe/8ndFe9e4xvtXQ==
X-Google-Smtp-Source: AGHT+IFon6FzOlxvQe4WxeN3+ZX5T4QVb/nJvJpT3FM/BSy+2hcZiZMDmX/IRmSlrJbJpcyu6wKmai185jJHNycGLfU=
X-Received: by 2002:a05:6402:520b:b0:5c4:aea:5833 with SMTP id
 4fb4d7f45d1cf-5c8777dcc01mr2209351a12.18.1727344984959; Thu, 26 Sep 2024
 03:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240926094103.196416-1-lekkit@cheems.de.box.skhron.com.ua>
In-Reply-To: <20240926094103.196416-1-lekkit@cheems.de.box.skhron.com.ua>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 26 Sep 2024 11:04:03 +0100
Message-ID: <CALeDE9Mms4QhaNbgcPY=tSdQV+w8gcZVbNH_fuR-_ZdakmwTkw@mail.gmail.com>
Subject: Re: [PATCH] video: simplefb: Fix build warn with CONFIG_FDT_64BIT=n
To: lekkit@at.encryp.ch
Cc: u-boot@lists.denx.de, nyandarknessgirl@gmail.com
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

You need to include a summary in the commit as well as a signoff line.

Peter

On Thu, 26 Sept 2024 at 10:52, <lekkit@at.encryp.ch> wrote:
>
> From: LekKit <50500857+LekKit@users.noreply.github.com>
>
> ---
>  drivers/video/simplefb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
> index 33bb78bc..f497bb1b 100644
> --- a/drivers/video/simplefb.c
> +++ b/drivers/video/simplefb.c
> @@ -28,7 +28,7 @@ static int simple_video_probe(struct udevice *dev)
>                 return -EINVAL;
>         }
>
> -       debug("%s: base=%llx, size=%llu\n", __func__, base, size);
> +       debug("%s: base=%llx, size=%llu\n", __func__, (unsigned long long)base, (unsigned long long)size);
>
>         /*
>          * TODO is there some way to reserve the framebuffer
> --
> 2.46.0
>
