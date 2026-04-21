Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21791EA71A4
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 05:19:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 615FE83E36;
	Tue, 21 Apr 2026 07:19:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OXEaVibO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F3D184119; Tue, 21 Apr 2026 07:19:32 +0200 (CEST)
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF7F583C51
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 07:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-65427236e94so1430573d50.1
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 22:19:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776748769; cv=none;
 d=google.com; s=arc-20240605;
 b=D5Zr5ucJgc4NtA021p9DTJ75UYpKzOQu/P2hXhrAH45tU2j25oj1KLq/KgQxrCoFl0
 6jX+AYaJEMyfNaiDRFBpueFN8CBNSOXOtzKsJxe2GAoYqldUWwWLeuNPyXgkCs47/6Cn
 d+VTmWVHoW6oqAOmgrJHjAOnUhxN4qeBCx6fLv6PTQxnqjUPGEk7oMeF0F6e74NJFZvN
 vk1REcod8z5D0C7EQPdBT3PlxztpECdV64LtSIt5sUR6hWSbFFCCH1ECULnLm7rt+Hpb
 WZwmwCBsrbipjX4bbQ7VHseY5guo0gqbKu6OB4r7rSDyRd5Zf1aXcWSu611f2XeOD2iW
 gf9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2DUhkibQch8TCV78QjRlEaeCy9J1S6+PdSdPi7AOTQA=;
 fh=PB49UQrExre2XgPw117xJEq8OADtrEIe1sQL3awB/vI=;
 b=ldC/88oKubVAtm1NRAfM3EQ/UEw+muaSltFweN7ghG5yHEqNkUVZ7wZtMoz98gtKfR
 EQXDTAYoxBgYwVPTLgnGl33WIsg40o9eeEpCYxEeslssD88d5u/II3HofOIsaw+OUjdt
 /VswIgif2xB0GLOPMSdPFFtCpX6VOCE7zmbq1eNO6OPo4zG+yAzf+NrZOObUl8NBMbHp
 FfjqH2sEWed2Ut+IccVjjKfbq31w/+cWey0Jcsdpss2Aa18kD82tmKhuLMFj9riv/sdb
 HXhAUnyuwCGTdPRW4xXCz4inBBKU/XJdJn1XO2OlVfhHQGZvecvG58F/ZKikvdP3mEgm
 AULA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748769; x=1777353569; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2DUhkibQch8TCV78QjRlEaeCy9J1S6+PdSdPi7AOTQA=;
 b=OXEaVibO+BfzXdAeMK9DLmHVLw5j59dzYoDfUZiWKYRAiAzap/yYXZ/1kV78hsNk6+
 Dr+Mfp4tQ4/g2Lfu+okJa1wzZz04nm6Wy1piLSrh+YRmMr7qHgKrjCIV9R9Ohp74SKgf
 1vhFl3FqsCV8DGort6Pw8bift6rFIZ0iRFQvKYbqSeNucdD2/8W8xVM/Z+8k6lg6LttO
 lo7qgv1zr1UdMx/qIWXIq8KtxRdwZjTQ/yqKzaB4ZiNkAfOCjEmlQ1yl+FG1KGMeUAXW
 b/3VvMX7SK+8/rrWRkO9ptGyX3sp3SVLMfM+GKKNo9swDA8fSNt0qhQIOhBAqll7349Y
 onYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748769; x=1777353569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2DUhkibQch8TCV78QjRlEaeCy9J1S6+PdSdPi7AOTQA=;
 b=PbY1jLvQiRD0NsKpzOTpsAlCbQ0ypTjLfUUvDs4TFRtNqMKzgSBOlSNnnRv76T3/6G
 q+kJVAjg+sj7SCw7W2V8ns4SOziHvRauQiJ4ZPJNdP0bvT50aOk+bsnQWQRTwNxPhY3m
 vyfkk3YyVVV3sBHEBUbHhnRT0m2jhm68C7M+cLQTUnacXVrx5IO+I/KLH3vk1PM2WJjk
 AR92EEGg2fUjLJlL1Nf+VVPc21SbYusaAWmf5PW89R4472/P5UELa/+HjdgYecLZg1Tr
 PYU+YdE13yI/r0sohSQO+hQazt5Nx72aIF3bQg42Rsz7yTEL8ZxJVOr/Veef4YNjQEmV
 a13w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Pq/nC7NkP6AaIBu5zRjhj1N8Q6zv7zUD+UFJEM6b/uw3j9o0TSbQEMYPDTA3t+afc31SsQbM=@lists.denx.de
X-Gm-Message-State: AOJu0YxH8aFnoreISFL+kqvOUeDMEXFwnSdIU91MCc+QFFFd6kuEQoW3
 RjGommHntY2+wN5ABhy/LZda+kyLoUuawq/fZuvjSt5ZzhaMKZhUdoewOZ/lhWIpaA7AWoDKPj4
 f61lsxUSBI9UrFHOH9V55hPud7KH9726i3Nm7wDAoAA==
X-Gm-Gg: AeBDievMjeekiC+DNSX3w2ss0FNIQcERya7cPoh+snk87x6G3bSLc0eIb2dJMNP1+dv
 3K3cLPGG1aWcm1e6Ggo8gOVClcYG4KwSWsJ/Bs1R2f5x1NaJcI+d5w/atw2JNYv5IeFcNjniC6o
 HNw2UGnRxlbNh+8Osz6qpUOBA0W86WmH2w922FB/GrPut9vzaSZty1EaGFBw/BE+AI4e94p1pmn
 KFX0yvEpyG8b28dExve9TMlnD7/7vhKMiumnNk2dYLO1ooiXQLkNA6mbzP4F6SCXjSrwv+u0gRN
 ODP5c7ciyPtF5M1QMZXtN5V/rleB2piNsJe85ww8UOEvGi88oFFYQygJuVyHCZz2Bh+v2qEP1SZ
 +3PJqjuqFzJqkDakU7D8oGdHJeslgp/ERligZcGxCxQi/CBN/kobSadVqkW9vG9k6MuIcPnPBSp
 oqP36xpK8Cp48yFHpEnI0HCJ3H3EJX97ouPDQup09T16DPWZ8RAQZ7wq56zaXYFHc23g/9vWtmU
 GIKkY8IdpzmqYKAiME/F88tUquUT2viHDbeh7xeYDDXh3wbous21BuBvmPERZSzeO4x5LncqhED
 ePID6A9iiVoMqK5vjqrOJxqid/Put89Q0gmU7Qqoo4B0aq61zT+S44jMMX7FzWDLvA==
X-Received: by 2002:a05:690e:408a:b0:654:2882:42ae with SMTP id
 956f58d0204a3-654288245cbmr6926997d50.25.1776748768638; Mon, 20 Apr 2026
 22:19:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260420220321.71147-1-heinrich.schuchardt@canonical.com>
 <20260420220321.71147-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260420220321.71147-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 21 Apr 2026 08:18:52 +0300
X-Gm-Features: AQROBzDtQntUHJy-mQSXsaO2JY0Ij7B_b5VNjLg1H7iUYIKM2TUTLVG2kO5N_vo
Message-ID: <CAC_iWjJUiRRdnLeGrbtUwkjN2cgNKuNjZhCX69ZL+qqTKTwEXA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] efi_loader: correct return value of
 efi_bootmgr_run()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mark Kettenis <kettenis@openbsd.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Peng Fan <peng.fan@nxp.com>, Christian Marangi <ansuelsmth@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Casey Connolly <casey.connolly@linaro.org>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Adriano Cordova <adrianox@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Martyn Welch <martyn.welch@collabora.com>, Javier Tia <floss@jetm.me>, 
 Ying-Chun Liu <paul.liu@linaro.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 u-boot@lists.denx.de
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

On Tue, 21 Apr 2026 at 01:03, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> efi_bootmgr_run() is expected to return an efi_status_t value.
>
> Reported-by: Simon Glass <sjg@chromium.org>
> Fixes: 0bef4b0123f2 ("cmd: bootefi: move library interfaces under lib/efi_loader")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
> v2:
>         new patch
> ---
>  lib/efi_loader/efi_bootmgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index a687f4d8e85..52ccebab19f 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -1313,7 +1313,7 @@ efi_status_t efi_bootmgr_run(void *fdt)
>         if (ret != EFI_SUCCESS) {
>                 log_err("Error: Cannot initialize UEFI sub-system, r = %lu\n",
>                         ret & ~EFI_ERROR_MASK);
> -               return CMD_RET_FAILURE;
> +               return ret;
>         }
>
>         ret = efi_bootmgr_load(&handle, &load_options);
> --
> 2.53.0
>
