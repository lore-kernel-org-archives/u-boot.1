Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C40C4829A
	for <u-boot@archiver.kernel.org>; Sun, 11 Feb 2024 17:54:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85438878C6;
	Sun, 11 Feb 2024 18:54:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aY9+tlma";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E26C9878E9; Sun, 11 Feb 2024 18:54:02 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA9DA8789B
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 18:54:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40fb7427044so4126235e9.0
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 09:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707674040; x=1708278840; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yhq0kAw20By/gnbMmHyXdBv5Eyj0HrE6bVKc1VBE6os=;
 b=aY9+tlma8Ou1lX4078iZZ+SbhlO4BfJB1Qk6OrKf2vS35YZ+j0M7KJnfkl/664jhvK
 NhCA3TGB/Q9cOeQEoRbbe43t7eiW4WRwj48H5PPQdkuTARN1HdalGQ1f0opdV9u2nJb7
 FrIriGf8zwuYQtl3xRLU4ANdAXgfiRImxKCnvfKSaIJJdjoCYhDEpuJR0LQQbfRTZc23
 yYl+OzXjE5GWkoSfU7a9rPQaLL1eKzQ1cLRfMCPrzjKGGzSYDxGmS+qtpHU8c32Iramr
 L3G/IQOkNzF8r02/FMCqD6ZbaXmoeix/X6IJeYWMY6+YiX193qHL60w4YE7GxCKldWJc
 kLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707674040; x=1708278840;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yhq0kAw20By/gnbMmHyXdBv5Eyj0HrE6bVKc1VBE6os=;
 b=Ox+6+G2+yh+Cby76fBBhdZ0rmo4SDaZ4VU8TFP1sgXDk+ZzvJwckmyROSHnSStxcNk
 uTqrO/5o0Pc3dLzulU18J4LCIBt3P/9lHCZJP+MQvfxDjV7d5redMkB3sDNaMx0iODNq
 dMt60fPaeYQzOvI43W4Lz3zzAZCvB9SHR2hERYYM81uiXFB00mWOHLxUKXSLeWCdmv/6
 yXu/JFAaY9Gcl9bCsU6DEEyR1kebDGt+c9QNC+zPn/9u/I28ls2xxzNdH3yZA3f4d4FU
 k07vK3Ism7peEb1lVvBsdbLrdhHr5O2roPc+oaH6RT3fOVXJxMjOk155HalQX66Ceoot
 FxNg==
X-Gm-Message-State: AOJu0Yy05E19QycAq8wnn3Ig14kOoapOCda54pLrBmq/Av1Czz3w7xIS
 VU91smHHWp7H9+KtC+3ciWKX2kiBhCEaSUBOpU6Kbr7C4akDfHuzyFViWHFhG6cQEBtPHLOx5ky
 6mjiSJULCDanA+Tx1VoAP1I9bbtQ3MRTBcarSWCj5
X-Google-Smtp-Source: AGHT+IHsnDYDXdPLU/5PC4lXjpucyfvD/ilFzHfB1TI/Er8fGAElFQ/Ls4VtW6m5rQ+4aYmhPSHhNPqRycWLnMwz/T4=
X-Received: by 2002:a05:6000:3c8:b0:33b:5b4c:a088 with SMTP id
 b8-20020a05600003c800b0033b5b4ca088mr3994314wrg.0.1707674039752; Sun, 11 Feb
 2024 09:53:59 -0800 (PST)
MIME-Version: 1.0
References: <20240209143520.2724221-1-trini@konsulko.com>
In-Reply-To: <20240209143520.2724221-1-trini@konsulko.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Sun, 11 Feb 2024 18:53:47 +0100
Message-ID: <CAByghJYCzN4Nm0mThc1QXMKk8KSPRZwwL2pp4ucLv7iwJsMSJg@mail.gmail.com>
Subject: Re: [PATCH] doc/develop/codingstyle.rst: Clarify include section
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Hi Tom,

On Fri, Feb 9, 2024 at 3:52=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote:
>
> Rework the section about includes slightly. We should not be using
> common.h anywhere, so remove that from examples and ask people to send
> patches removing it when found. Doing this also means we need to reword
> other parts of this section. Be clearer about using alphabetical
> ordering.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  doc/develop/codingstyle.rst | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/doc/develop/codingstyle.rst b/doc/develop/codingstyle.rst
> index b25bfbd271f0..cdf5aedfcbb0 100644
> --- a/doc/develop/codingstyle.rst
> +++ b/doc/develop/codingstyle.rst
> @@ -108,30 +108,29 @@ expected size, or that particular members appear at=
 the right offset.
>  Include files
>  -------------
>
> -You should follow this ordering in U-Boot. The common.h header (which is=
 going
> -away at some point) should always be first, followed by other headers in=
 order,
> -then headers with directories, then local files:
> +You should follow this ordering in U-Boot. In all cases, they should be =
listed
> +in alphabetical order. First comes headers which are located directly in=
 our
> +top-level include diretory. This excludes the common.h header file which=
 is to
> +be removed. Second are headers within subdirectories, Finally directory-=
local
> +includes should be listed. See this example:
>
>  .. code-block:: C
>
> -   #include <common.h>
>     #include <bootstage.h>
>     #include <dm.h>
>     #include <others.h>
>     #include <asm/...>
> -   #include <arm/arch/...>
> +   #include <asm/arch/...>
>     #include <dm/device_compat.h>
>     #include <linux/...>
>     #include "local.h"
>
> -Within that order, sort your includes.
> -
> -It is important to include common.h first since it provides basic featur=
es used
> -by most files, e.g. CONFIG options.
> -
>  For files that need to be compiled for the host (e.g. tools), you need t=
o use
> -``#ifndef USE_HOSTCC`` to avoid including common.h since it includes a l=
ot of
> -internal U-Boot things. See common/image.c for an example.
> +``#ifndef USE_HOSTCC`` to avoid including U-Boot specific include files.=
  See
> +common/image.c for an example.
> +
> +If you encounter ccode which still uses <common.h> a patch to remove tha=
t and
nitpick: s/ccode/code/g
> +replace it with any required include files directly is much appreciated.
>
>  If your file uses driver model, include <dm.h> in the C file. Do not inc=
lude
>  dm.h in a header file. Try to use forward declarations (e.g. ``struct
> --
> 2.34.1
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@gmail.com>

--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
http://ua.linkedin.com/in/iopaniuk
