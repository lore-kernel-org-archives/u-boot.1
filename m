Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD49CD3447
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 07:20:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 023FD86AA7;
	Tue, 19 Sep 2023 09:19:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cBkToTCZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 373CC86A21; Tue, 19 Sep 2023 09:19:56 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6705086A21
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 09:19:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5310aec4121so2423312a12.2
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 00:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695107994; x=1695712794; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9uJGLRjNGP/0VTVFp0r6+uB0nCbqxTKEEAVsEFSYmyA=;
 b=cBkToTCZnxcKi6kVQ49ti+XmETmzeh1QRT69V+sXxVpmoxtdzSnqr7mQgWzQ3qoqRK
 LTocSE25YE3wT3gD5HNcg+GqJo7B/Yt4YuXktcM20PlBLZzlkbE2vn2+o5IbVbeXcPRO
 uVBjxljzgNhiofUOirBlsquG6fm94MWDO3hCo7JLuz9qTKqA1NsiE8nkU6xe+VNUW2Av
 OZh4swEmFH9+wOeIPv4lf/nctDzyzmGgeuOvM3FEaYPo8cIUdUTPLkyn4GAy7YDtgSfn
 X48fV1OMnUdhYRezvycAGCUaPQ8FNVudipqC1wQLysslRjyYrF0Uj/OTk/k8Ph6vcdnK
 sN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695107994; x=1695712794;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9uJGLRjNGP/0VTVFp0r6+uB0nCbqxTKEEAVsEFSYmyA=;
 b=qyqiHQUbJq33UUvpqkjIYijeaP9E80bnpn6iT9lGnWM/ll+2H7zDC75j7XJ/pe2V5E
 ZYyHbINcA4NcOsAjRdYzgNt0bEkHXv5j2Aj8Gb+ZsOOypedra+eK1JWLH8kkr/8ulu39
 YDJ1C1HZnqr3xRRYrE6T4s0RmEB2pMMWshQgn8+7TBP586C4rChjv2YHUUmRXW2K78eE
 JDRaI0U1CfhC9nXfib7x8JN6kidikvsgWVrKdBNji/7bYd8IN84fMOwnQWruuhQIUyW7
 43sjn7+sisNBrrmZ5xI+Ew7TPFzfkWI3Bfc1noKfTeFtcg17bg5GoXfobVuAC68yFjyR
 4sFA==
X-Gm-Message-State: AOJu0YxPERTAjJeZnyHeDWXqlXahuZmnmM5zRuJ7Ub1UXhFzDyAsYUqY
 xNt2BpFvsU0HaQURFZ+ahUjBu7qEbn7GAUKoFZQ=
X-Google-Smtp-Source: AGHT+IGbo/zcosFtstziOwvTXF4Z+xTN77ioGiIV7CqK4kN5rxJpcXzwcvohcifJUkzXmovKzLBko4QKSKORK/38VE4=
X-Received: by 2002:a05:6402:644:b0:523:aef9:3b7b with SMTP id
 u4-20020a056402064400b00523aef93b7bmr9849477edx.4.1695107993978; Tue, 19 Sep
 2023 00:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230823211059.1235147-1-sjg@chromium.org>
 <20230823211059.1235147-9-sjg@chromium.org>
In-Reply-To: <20230823211059.1235147-9-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 15:19:38 +0800
Message-ID: <CAEUhbmXe2_DN6ZEv_DwSuWq_inXXNtpHvkiyWkfnekFqWOkumA@mail.gmail.com>
Subject: Re: [PATCH v4 08/20] x86: coreboot: Drop USB init on startup
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Simon,

On Thu, Aug 24, 2023 at 5:11=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> This is very annoying as it is quite slow on many machines. Also, U-Boot
> has an existing 'preboot' mechanism to enable this feature if desired.
>
> Drop this code so that it is possible to choose whether to init USB or
> not.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  arch/x86/cpu/coreboot/coreboot.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/arch/x86/cpu/coreboot/coreboot.c b/arch/x86/cpu/coreboot/cor=
eboot.c
> index c2ceaa9a56c..567f1ab116c 100644
> --- a/arch/x86/cpu/coreboot/coreboot.c
> +++ b/arch/x86/cpu/coreboot/coreboot.c
> @@ -86,10 +86,6 @@ static int last_stage_init(void)
>         if (IS_ENABLED(CONFIG_SPL_BUILD))
>                 return 0;
>
> -       /* start usb so that usb keyboard can be used as input device */
> -       if (IS_ENABLED(CONFIG_USB_KEYBOARD))
> -               usb_init();

Dropping this causes USB keyboards to fail to be usable as the U-Boot
input device.

> -
>         board_final_init();
>
>         return 0;
> --

Regards,
Bin
