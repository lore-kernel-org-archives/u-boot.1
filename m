Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58403CF042D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:54:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B6AA890B9;
	Wed,  9 Oct 2024 03:53:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hZBNspI2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B32A78909E; Wed,  9 Oct 2024 03:52:57 +0200 (CEST)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49E2E89093
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:52:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7ea0728475dso262843a12.0
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438772; x=1729043572; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kTudPwDe/NPzNDaXILxCotCoD7Z0Z8Z8mGK78sXdTLs=;
 b=hZBNspI2l7563E7HZeMVj0Iv2LFsAB1vVlgqfG8w2mlVMBRcBHmixRMY/etUFGrdnq
 IUwyPjW2esaO+QWB8MB7z0Y0oNdf2Smqz0Lkx4WltVLwZNgwQIVLqjdxZkzzX2gLYTCX
 C4xxi3QkrYmacbeYAjeiFere1P5h7mJQmQW6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438772; x=1729043572;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kTudPwDe/NPzNDaXILxCotCoD7Z0Z8Z8mGK78sXdTLs=;
 b=pOqQgAcU9QBNNGmNl5nnmu86OHEvwfHSjgPT4q4WiCNgKMb4UC/Vw/47W9VbBHdzQ+
 vgYUv2bMDTB2nsZFuul5KWvf1xOxr1kFpBwN7b1qcRVBP/BXM94AGM/OwaVqd/uCv+Ns
 MeZZeuADNZ3OM+SuGAnUmMXVZO8uMeDjZd7I9nKaGQWp79E1FqGfNrfnrjzydH+4UYyi
 yVJk/cxCsuU5NOJGqvw6akBOeWGtP1GsvNmMOUEkSLsEyaYN2ty5Fa2KzNMmsLF3bzui
 YOpqdB3PyT3Ir4akzrFIgtpp+YSWocaNDDBb5CIAnhztWYFaTBoZwlrobPttw4ZQ6iVy
 aIyw==
X-Gm-Message-State: AOJu0YwS7QlmSpAxx5noSmLsjCIIOO/QM40HCa54iAej852ZI6o94zGq
 64OErVolgQKB3A9a9qvp/ENffyf8+N8AHXGj326/t2hY2eqriwRJKGtOGtMpO/kN2O1t1TeHbkn
 guhXCRuLpX/U3dDogHbhP7WZjJAlU7us25W3T
X-Google-Smtp-Source: AGHT+IH1KvFaBcc3BDHxx2WGruYVDHwx0NOFWsWA/48PvmmAmEq3VeBgb+q5yTy8f5qdfS5Tay5dUEEooQTCibdBcN8=
X-Received: by 2002:a05:6a20:12d1:b0:1cf:2d22:564e with SMTP id
 adf61e73a8af0-1d7073d38f6mr7618430637.6.1728438772214; Tue, 08 Oct 2024
 18:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20241003212802.3810-1-ravi@prevas.dk>
 <20241003212802.3810-2-ravi@prevas.dk>
In-Reply-To: <20241003212802.3810-2-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:52:37 -0600
Message-ID: <CAFLszTjjBbazmfmvEQ9gHWc+kP4x_gX+aFoGqJiC7=6cpMNn_Q@mail.gmail.com>
Subject: Re: [PATCH 01/13] doc: cyclic: remove reference to WATCHDOG_RESET
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
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

On Thu, 3 Oct 2024 at 15:28, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> WATCHDOG_RESET is no more. Replace the reference by schedule().
>
> While here, rearrange the sentence a bit so that "cyclic_run()"
> becomes the object and "the main function responsible for calling all
> registered cyclic functions" a parenthetical rather than the other way
> around, which at least to me makes it more readable.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>  doc/develop/cyclic.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>



> diff --git a/doc/develop/cyclic.rst b/doc/develop/cyclic.rst
> index 893c269099a..6f1da6f0d9b 100644
> --- a/doc/develop/cyclic.rst
> +++ b/doc/develop/cyclic.rst
> @@ -49,8 +49,8 @@ executed all 10ms.
>  How is this cyclic functionality integrated /  executed?
>  --------------------------------------------------------
>
> -The cyclic infrastructure integrates the main function responsible for
> -calling all registered cyclic functions cyclic_run() into the common
> -WATCHDOG_RESET macro. This guarantees that cyclic_run() is executed
> -very often, which is necessary for the cyclic functions to get scheduled
> -and executed at their configured periods.
> +The cyclic infrastructure integrates cyclic_run(), the main function
> +responsible for calling all registered cyclic functions, into the
> +common schedule() function. This guarantees that cyclic_run() is
> +executed very often, which is necessary for the cyclic functions to
> +get scheduled and executed at their configured periods.
> --
> 2.46.2
>
