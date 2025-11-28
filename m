Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925FDCFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 11:12:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14D42844F5;
	Fri, 28 Nov 2025 12:12:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MkSrMpwv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 146D6844F7; Fri, 28 Nov 2025 12:12:29 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF5F5844EC
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 12:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-641677916b5so3270480a12.0
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 03:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764328346; x=1764933146; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TxnwDx/ZR8k3viaBd1y2cytDja5TtVSqwTGOYqFNb24=;
 b=MkSrMpwvm0YIzK9NiXaccvrhg+ZewnHB8ONqtHfMi8I4DygMQ4qXSJnglkbjrD43i6
 1NMxMdS1ofWt7VEmVKIxlngqLEuL6tupiK8biFBfB1Mzz4dq/2FUZM4hzPSpQ32U9skm
 9g42jfNsTvy1UeIfDBXwbRWNs97E3jwddGe/pPOqFw1TqjojcYqDXJF5kSXv7XE7ED/0
 FQS9mja6w+q01VGLkIQueiHB3ncn3pkgtf3tJmTkIc4QDvze20zyZt2hXRgOiZoEf4ga
 i2w13lR1fW2zyCfuWmTJ8JlsRUs363VG59ZPvGPP738mZI45XWA8YzcOT1KFiMSTtfZ5
 xjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764328346; x=1764933146;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TxnwDx/ZR8k3viaBd1y2cytDja5TtVSqwTGOYqFNb24=;
 b=cPBbtDcRTxdB8NqtZQAJ3PCoN3FMUZ1UYd+S1lsEA8yUqK6D7XaRYxIWH8lYYTlNWz
 QDGOS8NLPatsyv3lv56Do+MTLATp1fX06pW5pInYpA3Au/9khbFs+F4zkVytz2rf4cs0
 e6tXlPGwpQpoMM0kyxRrbytftUJrSHi9wVEHucjKFLJ6JByiZfBUapzcy7nRZYzxG/iD
 rmyji+zFlMBUiyf6FcF9aXRYiW2HbW/+jrqH6p09Us+CZC9f/NPSHmKSFdt/htV3t2We
 +MkApNoVoavZgUDp+x+1uo73/RFzOe7wyESBc+TjxWk9K37VOSABym38ANcvBlb26Gf6
 P9Gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYt4NJPjtx5fJbEZf7IX4AbG+LMuMiB1CGHHkwj9bmrLHyv8cZWBYac/aS9tHYyThR77ceo60=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9Zi8q/M9V8GIWA4tziAiAxtSnT6g1q1d7I8LFX4DqBinAaFq2
 DNstpe1RQbg19WQmkc6aS0XGA556q28aMOyzGyIkL3CmJMsPpUjVY6k95ZYgZMHtrOkTtqYW3zW
 Wmv4cUjkAfoQatVySE7l4zXTekZnreeQJUWFy
X-Gm-Gg: ASbGncvdSerDsi09kxkjkfRv6SU2X55ui9vm/QQ9mvb//4ayaK7mFtbe12akOspodFR
 9xYZ5K8JWd4ZEt3myf3zT2TCZSa+Rqqp2Shn04isWF8LHkk4VdWdszbjiBpNNyEI5aGfy5pTixJ
 k3WMzaLFxOnCtJZBRrr+TWW7mDdNi28F/fOXwOE4wSnN4iYaeEVDaWbLBeSEm6AGF5urXIqRk29
 bdeLhKAjghTesza3+IzA/7YVC4EYy/x2YY8PDfWTBOzbqVLG2nbilw/C2Jy0UqS+E0H99MCf3Wn
 aWcpkUWsVTK+vBpnOQc6KfuD0iDs0WbXquV1kscgwWb0A5bZLlgBMu4/1EKJmvR/70IurFInqAi
 jeXOL6TF7EDJqi0Igj4iWuaz8I9NCS5SdStkg7+sfBnf2dA9qej+4hkjGs/If+ys6
X-Google-Smtp-Source: AGHT+IELisVz3Ef77FBR6A3AAe8Ks2VJFF5MXASJ/+UHNhH+9/PMyfCwAdTrsB/LzMoJD5a4xc3//j1+J04E0iLFftc=
X-Received: by 2002:a05:6402:2114:b0:640:9d56:50a7 with SMTP id
 4fb4d7f45d1cf-6455433d44bmr22871955a12.9.1764328346002; Fri, 28 Nov 2025
 03:12:26 -0800 (PST)
MIME-Version: 1.0
References: <20251110133758.1644822-1-bmeng.cn@gmail.com>
In-Reply-To: <20251110133758.1644822-1-bmeng.cn@gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 28 Nov 2025 11:12:14 +0000
X-Gm-Features: AWmQ_bnV1vtUtA6cLq_hKch8_C20a90PEM5HawSgONjtNVzzn5v_OBu9_rvh6Ko
Message-ID: <CALeDE9OdRuey0yWsXU2R4cPiuG_poPCb5c8g+XnQjUBk=M9VPQ@mail.gmail.com>
Subject: Re: [PATCH] docker: Use GitHub-mirrored TF-A repository to avoid
 clone failures
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Mon, 10 Nov 2025 at 14:03, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> GitHub Actions consistently fails to clone the upstream TF-A repo,
> returning the error: "The requested URL returned error: 403".
>
> To improve compatibility in building the docker image with GitHub
> Actions, switch to the GitHub-mirrored TF-A repository instead.
>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>
>  tools/docker/Dockerfile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index d2384219c06..201a1cdbac1 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -243,7 +243,7 @@ RUN git clone --depth=1 https://github.com/OP-TEE/optee_os.git /tmp/optee_os \
>
>  # Build fiptool, bl1 and fip for fvp and qemu_arm64
>  RUN git clone --depth=1 -b mbedtls-3.6 https://github.com/ARMmbed/mbedtls.git /tmp/mbedtls
> -RUN git clone --depth=1 https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git /tmp/tf-a \
> +RUN git clone --depth=1 https://github.com/ARM-software/arm-trusted-firmware.git /tmp/tf-a \

If you're going to use a github mirror use the TFA one, I've seen
issues with the way they sync to the one above in the past where
things like tags disappear.

https://github.com/TrustedFirmware-A/trusted-firmware-a/

>         -b v2.13.0 && \
>         cd /tmp/tf-a/ && \
>         make CROSS_COMPILE=/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarch64-linux- \
> --
> 2.34.1
>
