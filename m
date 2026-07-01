Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8EAC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 12:01:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A0F684C25;
	Wed,  1 Jul 2026 14:01:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ac4N7bOe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 580C684C28; Wed,  1 Jul 2026 14:01:02 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B560841F2
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 14:01:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6982e71dfb0so807885a12.0
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 05:01:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782907260; cv=none;
 d=google.com; s=arc-20260327;
 b=PwlnnNWJW2zcoTCj34v8ZCd0aBawBNIzEeUEt+5ny+f0n3rYHZsCi2lgi9W5h+OwdL
 7HDiNl9FSJ5hDE7ks+xD3xCdUUJ1cemUBwXPzvrs4NdCiIKwPo0R53q01Iq0+6giKNnU
 gY2wofOvU7JdH4hUWxytpjfgwWbDjklc0j7KnNlSMpunFkwtHp6QUV/9vXQGKqGXGs/p
 moWEZGvjt2b+jRvq0Fysi2QDONw4mxgdwXQXdpdLocwHiCBYpkVdo+zlLJh1I58Ots0q
 K/pdTiMEtfyCXBo28iy32BWu3unnWEKncALx6xvlD/+NxeyQIT7SM9jovPvAJWAQMvND
 bk3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=fy6ocGKKUN3jBftaS32ofuVDbZp3pqmj9VHjTMu8w7s=;
 fh=EW719RRI1+TSQ0b7Uq71gckk5Xa0g7qpM5sjmsYLI8A=;
 b=bd1h0l0mNagWhijmK53MdC9p6zY18dFNUZKGU7Gd0K0NArbxswqCM4B1gJn0Cb9a7L
 UFwtAJ1Wirg1LTdmKU/ZlpXf78iTDTnRQpKZh7++N1fSnUEb4JS6BfmRmxEG54AokIba
 HTtFXER/je06eDlJqUJpNI/shzm2J7U7i7ZDxAqqeY3gz8NHJ13LqevGDlzq59IvMbPp
 s/uHc1sge4hiOzZQPPpUceOWk/lqVe5T7HdkdD4iCsFjt8+1niccNohkpUI9IEDAG3QA
 wTfu+k2HDDNUHkt8D71EDJXIUkN7RmVIrbNKJE4uPFkhfp+7NzAJJkONqkg2d+QRHgDJ
 5sdg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782907260; x=1783512060; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fy6ocGKKUN3jBftaS32ofuVDbZp3pqmj9VHjTMu8w7s=;
 b=ac4N7bOeXtQen0jYKbY5tHk/chm1WbP9zphnzRVD+F3zPeEM0pW0E8jvy3E1xHa55w
 w/ZPRWXOdhvMC+vuY9fju5yNUOYEuMqdKm2PNloPzg+OhnS5EpW6f1va3loqXojPMm0b
 62yxd6s2sWOwTseHtfic2vJrje8BHvvzBjPhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782907260; x=1783512060;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fy6ocGKKUN3jBftaS32ofuVDbZp3pqmj9VHjTMu8w7s=;
 b=A+hnbWGzstZZ3S7HH9tveaiTcKToLOx9ephF4hkmmABA1xOKH6X/5cE2ewmuv5vO0a
 0l2ie3T3/rgKGo75RN+hJZ/6ATg2SZg1Y9QP19ZFpmT12de7gNd8JrBG0dlcWPTBFaDR
 SlKxU9ggBbW9Jgt+CqZlX+HFWccdS5euCTg+wkryYZ5v1ACZg1KEAqWjQVRLqWjaIpz0
 hgK0v70md3ml2/Cp1RqEAkZQJPn8sTCj/6yynSptSIyPOMISSZ1MFmmBkFdHe0TW1I+8
 bR9b8XZtiKGlkxnmtXXebxGP750YIrVzli8pxt7WmaT2P3TcNT/bEngxd1mjqWIKfYTq
 Bcjg==
X-Forwarded-Encrypted: i=1;
 AHgh+RomKU8zzNb/hEA2IvExZwAzuV/avPV0R/+k5r18JabgdeZleUxdWKugpgRjBbz7Rgp1SQw6abk=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5GDuABS+El/0cn/AS6IFwwIo11GDDyDw1GJo77UL4m4eiIW25
 anma5AzlO+CLMLfm2IRhcf1f4ZcwznJL3sWQ1Ff8SOmD7WicKIhchpGxbGeMcJewQnwoIEtc6x3
 qvhMb+NKGDaUzm4xB7t/plqmSKhbBk87lk/0p/Aa+
X-Gm-Gg: AfdE7cl5lRGS3s4cOpLsq13U4NRXxiqJEXWQUVAQZdo+uh7lyJBoc8bkqlUZpB+uJB3
 1SP8TPnrhdBWXsPoBoahdElUomfc7/F3wJ9OYRThCtd8KwKGg+hSFtc2yjAZKA86E1oOnD1H+4F
 KnfWMOoBUwpZXJk0TF6/Jm82jEOl8kZymac70OJbX9/UMVupLv/QqW2Y7DpS5SQR9qzzvh9HCfe
 t8wsLaDOvRO2Lmhr6H7kTC22taPMD6sidV92XcEpu9uY5PQK4+fQBNBaOHZLGBQh4ZasrufEA==
X-Received: by 2002:a05:6402:2b91:b0:698:81ab:c61a with SMTP id
 4fb4d7f45d1cf-6989f37807dmr718172a12.23.1782907259715; Wed, 01 Jul 2026
 05:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260628082810.175862-1-heinrich.schuchardt@canonical.com>
 <20260628082810.175862-10-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260628082810.175862-10-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Jul 2026 13:00:47 +0100
X-Gm-Features: AVVi8CeSa2do77cvrWNZMqcLV9I4FeC5xZz3cHxfPQejHMGbcRhuVER8oxuviyI
Message-ID: <CAFLszTgzxgfF+qQXnC1UA4HW6aJ9VVk8_S7TZu6CMEtq2uHjeQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] efi_loader: move efi_main and command loop to
 efi_app_common
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

On 2026-06-28T08:27:58, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> efi_loader: move efi_main and command loop to efi_app_common
>
> Add the remaining shared code to efi_app_common to complete the
> refactoring:
>
> * efi_main() - common entry point; calls efi_app_init(), prints
>   app_banner, calls command_loop(), then clears the screen on exit.
> * struct efi_app_cmd - table entry holding the keyword, help text,
>   and a handler of type void (*fn)(u16 *args).
> * command_loop() - iterates app_cmds[], matches keywords with
>   starts_with(), and falls back to efi_app_help() on no match.
> * efi_app_help() - prints each table entry's help line plus the
>   built-in 'exit' line.
>
> Each dump app is updated accordingly:
> * efi_main is removed; command_loop becomes non-static.
> * app_banner[] is defined at file scope with the application's
>   title string.
> * Per-app duplicate state (bs, handle, systable) is removed; apps
>   now use the common module's state.
> [...]
>
> lib/efi_loader/dbginfodump.c    | 100 +++++++---------------------------
>  lib/efi_loader/dtbdump.c        | 109 ++++++++-----------------------------
>  lib/efi_loader/efi_app_common.c | 108 ++++++++++++++++++++++++++++++++++-
>  lib/efi_loader/efi_app_common.h |  38 +++++++++----
>  lib/efi_loader/initrddump.c     |  95 ++++++--------------------------
>  lib/efi_loader/smbiosdump.c     | 116 ++++++++++------------------------------
>  6 files changed, 222 insertions(+), 344 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
