Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F207EEC1117
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 17:52:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74CFC83E21;
	Mon, 23 Feb 2026 18:52:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f5a8T8I8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0D5983E7F; Mon, 23 Feb 2026 18:52:49 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9518A83E13
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 18:52:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2aad1dc8856so33047285ad.1
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 09:52:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771869166; cv=none;
 d=google.com; s=arc-20240605;
 b=MMUirPe/ajUI2XjR/zBNxtRl6ieJle8dfTjufEAAuu26nQmPUAUhIiKWWEBLb3FKye
 B31SPZwwA7dgtQt0DUKcHhNhaPMDErsAnjUmB60mcKsQhhyWY3eFY41qReq6mHvmUoZP
 upSpzZ2CLO9ruIOjxVGGCrrW7VO36RD6HQgOjdE0u/mevuRgq6dbaCUxHAaU+tH6Of8F
 H8QntdzTOpx3qwupCwq46xXRjuU747PRMIOJQh2/bBB+JUU1hIX8EJ3rcEGGtpQTDASy
 XN3INeb463yjYXkPqRFjYEz5dOOBtLUR7ENHdKoT0ERfhAqv7HMHhkVtfeEmpgHk+yg6
 3yKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EaYngeh4MnVUIs5KnJmhNHfjnl9zRc04Up5IDBVBm6A=;
 fh=89JGekwhSyYOPQOy2uyR8LelJwXS2WWWd2nllJCIfB4=;
 b=RRWrVUCBjhN14jlrFG3aiT/B+Nw9+08BhmwfFz6ua2KSm/uO8lD2ltvjoXrKcyx02Q
 h7OhnczzYsLbMA0ogAk/S40Zsd/re7cNol6+o2eQRjFrrv6iskaY/5I0AC+7avZKH06J
 1r6iYZc0w19j/oi3C7FwSTTNTOZRucuv+Fwkmw7uQe6294qscT3mcUsFlTGO1kgJH7Mz
 QAWGZ1lX+GiWE7fOxl7IEsjO2vVOerFoJIBLvIZXpGh8cyMzSHVT/8ug3hTTkp4kz56b
 lTrr89Hb2TEc8WR0dlIdIWQBusLDDvTrB1QX/F6lUuROHZZMJkOrXq/LtcIsNykKJeF6
 8goA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771869166; x=1772473966; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EaYngeh4MnVUIs5KnJmhNHfjnl9zRc04Up5IDBVBm6A=;
 b=f5a8T8I8qz/k9QUYAiNO9L12ip5RjgHq77DLQr6u30zv7a3VGIsyEFB+Sf/35WatkW
 2UefbaXcdU7vtX/+LaYy1cyk5GkEuSU5+eCFD9BN3sfUMPAK0xYuCtA5GJHKx0OuW9FW
 2UlUdAhQsO9FGmt8fAquHzOhCguuJ1NPnoM+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771869166; x=1772473966;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EaYngeh4MnVUIs5KnJmhNHfjnl9zRc04Up5IDBVBm6A=;
 b=WIDW1hc4x8omb02J0IMmOaXo2NMLlWcOezZkocw+yOTOGg54wmRTENdPXmLHoN/RaM
 eRW0IDRtR9uWH75q7ZgbkUmFDqKyWXN9JDjgPVX6yKdvoQqwDoPRWTExMrUR0m/fZaRb
 qX4Z5cCYsHPPvsz3yLsBtTapLcFqP4cdR6FivuZFpjs7IpWKDP0am1pgnLz3DQa1wxI/
 w2DCAAijmDxqCH8+msacyCHWTpWwKMyNHaWRd0dH8sIDzfMOTbHWhAznUpVVKybjM1ZC
 M5lum25BspyLHTXMcG06ZcCdPvh439giy5DEef4kjDEd4lB46B41pqIyUe7ytzcLnG8t
 alpA==
X-Gm-Message-State: AOJu0Yw0SqlqEIHigu4ELsIW46nbO3q6ncNRRNK7XbkrPpd7aYc5Wjwr
 qpU1Ft2As6oZSNGlAjs2Hx04/XBnU7U937GRPB6kHnv/HF2gGU2wFrbeoka1/A2UY/YfmyrYxaY
 FYaSAx6v6jNuCaCzkuGdoAqNvd5p8UJGc5RF07COb
X-Gm-Gg: ATEYQzxFbjUJBFwPS3dScnXdOvXWN0ieWylnhg17rnVzAW8CWpudgX6z4pm5djuQGP3
 1lpJBPbrFAwX8+eHkMHcPNhcYWzHaupZbgksTLPkUqFUohVG1NNbhJQLqvaqPahOEJ95roX8xUg
 8O2rTIaKgjgVNxCv7cfiU5ruQzDYxghzxUA9aSguWuCcDzzOeG8M+KDR8aRre2NsBP87CHGgfzi
 L96hV6+VVtadzBfvb+noLjH23J1jXNBMuHpt7MLsYeD/GYu1EJ7fD220keqeZKVo52IwyT1DDG4
 szoc8w==
X-Received: by 2002:a17:903:9cf:b0:2a0:8ca7:69de with SMTP id
 d9443c01a7336-2ad74540793mr90868775ad.41.1771869165900; Mon, 23 Feb 2026
 09:52:45 -0800 (PST)
MIME-Version: 1.0
References: <20260220091518.180641-1-Wojciech.Dubowik@mt.com>
 <20260220091518.180641-5-Wojciech.Dubowik@mt.com>
In-Reply-To: <20260220091518.180641-5-Wojciech.Dubowik@mt.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 23 Feb 2026 10:51:23 -0700
X-Gm-Features: AaiRm53x0AxezURCWrNq_6Z02QQ7M3gOfzIoYiXqDLSUUF1SAfzdnu-UtBHZV1E
Message-ID: <CAFLszTgRSXTQ5H7NM8W_QxdXHJ2vB=hgRg9zLkr7_agRF8660g@mail.gmail.com>
Subject: Re: [PATCH v7 4/6] binman: Add dump signature option to mkeficapsule
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, trini@konsulko.com, 
 simon.glass@canonical.com, quentin.schulz@cherry.de
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

On Fri, 20 Feb 2026 at 02:15, Wojciech Dubowik <Wojciech.Dubowik@mt.com> wrote:
>
> It will be used to capsule signature verification.
>
> Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
> ---
>  tools/binman/btool/mkeficapsule.py | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <simon.glass@canonical.com>


>
> diff --git a/tools/binman/btool/mkeficapsule.py b/tools/binman/btool/mkeficapsule.py
> index f2ac654db81e..7638c941a8ee 100644
> --- a/tools/binman/btool/mkeficapsule.py
> +++ b/tools/binman/btool/mkeficapsule.py
> @@ -38,7 +38,8 @@ class Bintoolmkeficapsule(bintool.Bintool):
>
>      def generate_capsule(self, image_index, image_guid, hardware_instance,
>                           payload, output_fname, priv_key, pub_key,
> -                         monotonic_count=0, version=0, oemflags=0):
> +                         monotonic_count=0, version=0, oemflags=0,
> +                         dump_sig=False):
>          """Generate a capsule through commandline-provided parameters
>
>          Args:
> @@ -53,6 +54,7 @@ class Bintoolmkeficapsule(bintool.Bintool):
>              monotonic_count (int): Count used when signing an image
>              version (int): Image version (Optional)
>              oemflags (int): Optional 16 bit OEM flags
> +            dump_sig (bool): Dump signature to a file (Optional). Default no.
>
>          Returns:
>              str: Tool output
> @@ -73,6 +75,8 @@ class Bintoolmkeficapsule(bintool.Bintool):
>                  f'--private-key={priv_key}',
>                  f'--certificate={pub_key}'
>              ]
> +        if dump_sig:
> +            args += [f'--dump-sig']
>
>          args += [
>              payload,
> --
> 2.47.3
>
