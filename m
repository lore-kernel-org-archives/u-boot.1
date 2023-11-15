Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C922C48BD7
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 13:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A4FC871F3;
	Wed, 15 Nov 2023 14:41:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RvaK61sh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3DAB86FBB; Wed, 15 Nov 2023 14:41:17 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BED4F871AF
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:41:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9c3aec5f326so172724066b.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 05:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700055675; x=1700660475; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I72UdGUwj6rdGboI2TElQnohV9dD9X/Gy0KJuq+fmY0=;
 b=RvaK61shz0zumDtHHwlMugcCE24ZoONqK/1Md8jy81YIz3UqyS3kSVvIWb2v/vMnd/
 IW1MvUq595fijSvPqnhMHhbCycHwhN9h/kF/yxkbyBDpwyGFNkEaRHXxRZxfgt6tLFjA
 eeAWyG14XEXgv5KljGlMKzldxq8PC9OHDtm0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700055675; x=1700660475;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I72UdGUwj6rdGboI2TElQnohV9dD9X/Gy0KJuq+fmY0=;
 b=Td5Npg75nJRbX6z4kWR8I4gS2kqu+w1/7Xj8Pv5cuoTjab55jf1L3S1JRfyLx1ikhQ
 cU4WPuWV4lMVBlN9hFNhjhVXlVR4pf+vGlrutpb5GF6TmngSqERL4gkngDWRcvjQqHYT
 Sd0Yz3nQMIO3P/I0yhIJnL+6hVPynR03rUktyjrgnaHTJoaZ1VDaxVvIOdBeECN0oCEk
 rNxy9Amf5M22RRiQ2x9fJ4qpzE3HP7uJPtVrxAMjYx385DBnmec5n+9tjYwMvY66xj2C
 PLNcNz925mNeFeRd26LJSVNWkhopJxedinoNmsvHDI7CIss8zPll0a5IPLUSy/+tmrDb
 85hA==
X-Gm-Message-State: AOJu0YyegwOlW9gvwoQjwfk60Rz8zIfY84DiTpzr1xXaFyp85kK65Elk
 K9LatC78rVx5pRtFlng4XLTVZhoPpY1lOUi+ZESKSLVQi7WxHr/Sors=
X-Google-Smtp-Source: AGHT+IGMBQO67Dup1q7QqlBs04l4b/gfVEPVrF1hZryLuOwZvsV6GBka6Ou9glZensSlHQU3VqZ2bi5j1guDZntwshE=
X-Received: by 2002:a17:906:d0c6:b0:9ad:8a9e:23ee with SMTP id
 bq6-20020a170906d0c600b009ad8a9e23eemr4961032ejb.13.1700055674979; Wed, 15
 Nov 2023 05:41:14 -0800 (PST)
MIME-Version: 1.0
References: <126302ea0fc8f986421dd65c73d4f138642354d0.camel@physik.fu-berlin.de>
In-Reply-To: <126302ea0fc8f986421dd65c73d4f138642354d0.camel@physik.fu-berlin.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Nov 2023 06:40:57 -0700
Message-ID: <CAPnjgZ2pMHjOqEEqQy3+p_YzWXsYsr=DRz=vGRuTfZWMEnwd9A@mail.gmail.com>
Subject: Re: u-boot fails to build on sparc64 due redefinition of 'struct
 termio'
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: u-boot <u-boot@lists.denx.de>
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

Hi Adrian,

On Wed, 15 Nov 2023 at 00:27, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hello!
>
> On Linux sparc64, building u-boot fails with [1]:
>
> cc   -o tools/mkenvimage tools/mkenvimage.o tools/os_support.o tools/lib/crc32.o
> In file included from /<<PKGBUILDDIR>>/tools/termios_linux.h:33,
>                  from /<<PKGBUILDDIR>>/tools/kwboot.c:153:
> /usr/include/sparc64-linux-gnu/asm/termbits.h:14:8: error: redefinition of 'struct termio'
>    14 | struct termio {
>       |        ^~~~~~
> In file included from /usr/include/sparc64-linux-gnu/sys/ioctl.h:29,
>                  from /<<PKGBUILDDIR>>/tools/termios_linux.h:30:
> /usr/include/sparc64-linux-gnu/bits/ioctl-types.h:36:8: note: originally defined here
>    36 | struct termio
>       |        ^~~~~~
>
> Reading through tools/termios_linux.h, it seems like the problem is that <asm/ioctl.h>
> and <asm/termbits.h> are included at the same time. Not sure whether this is allowed
> according to the glibc documentation.

Can you send a patch to fix it?

(BTW gmail tells me you are John when I start the email, but I noticed
it this time and changed it)

Regards,
Simon


>
> Full build log available in [1].
>
> Adrian
>
> > [1] https://buildd.debian.org/status/fetch.php?pkg=u-boot&arch=sparc64&ver=2023.07%2 Bdfsg-1&stamp=1699723544&raw=0
>
> --
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
