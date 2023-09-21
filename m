Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C63E7D0A2
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 20:45:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CBDD863DE;
	Thu, 21 Sep 2023 22:45:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TT/heBMG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4080D805CA; Thu, 21 Sep 2023 22:45:29 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39E3A805CA
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 22:45:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-59c0281d72dso17469357b3.0
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 13:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695329126; x=1695933926; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VuJ/M9qZhNRMIw1OJNhCwNax5GGjaFhakAPBT54OXy0=;
 b=TT/heBMGZvF54wIbgoOb/bxiDvRQRHK2dt6d7i+kxGtLINbWGOXNC44N+KHnfV1hDc
 ttu2/LOa4vbgX0xwtvp08xDuYCe1MKDrzSirsuRiWDAltaRRQjqQNSnUsnEOiU5VFuMG
 +Sq0Td+3+k2whlJnuJz/Jl6BDufaM4qX5nf2Uk+CupzIKxqzpm1gp3/LOjWV65uFkYr0
 Jk0vS40aaxBTjWnjfqcpNcjpNrvEBmQxf45D8yObbF+Z7OPPyAyO70eLvnwUmQ7tp7xT
 t5cB7HQYJniitcYlC35Tk1KL0ZAa8mWLBDH4uufQHXIxtbi8I8z3dpEHvwL8aUrmwpSV
 8GgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695329126; x=1695933926;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VuJ/M9qZhNRMIw1OJNhCwNax5GGjaFhakAPBT54OXy0=;
 b=jHyYqyeZpwVc0N78N5ya80J5XhmmFRaXp0PiaTpT6++iVQTIbh3OFrLt/uihzUxUK4
 /A6q3dEy8p7cIK44UNcC+OlR/x1g0qhR2e8EltwSn6j7o/2u+/4bcWTwm+fqvtToa4Lu
 XP0PeQc5f+JSvtAxH6odVBECs0QXYnr9kZEO1c28tEPFM537I7cMtfBNiZTSmM5LKBP3
 mDFuEqlvCAvQTietqIFMU02lZ8unmLOqTLMMoPArLdd8mrA66KxF6ejrMC8n+H5mH11b
 2KT0Sm+DwXPraClOe+0c6wI3lfj+TBnBfFhulmL3SHWFXTGajR0eLRSNAxwcQKSBY32e
 K/3g==
X-Gm-Message-State: AOJu0YwIUyD9iAYUua3q6a9LLsRYsRvcB1rIbXLeKUHrvHauqE+Nmn77
 wouHK81iPrC29V6v+0BAXzYZeoSzzP6cPytzuEzuDQ==
X-Google-Smtp-Source: AGHT+IEqx7pX/esSOHjWQJWj5f0afnyYARsCON6Hc0Fs+5TTrceB93t0WuBaISsz6xCMl+ls7eotghTmFOZkOzLTHn4=
X-Received: by 2002:a0d:dd07:0:b0:591:4f2b:7eea with SMTP id
 g7-20020a0ddd07000000b005914f2b7eeamr6945885ywe.18.1695329124999; Thu, 21 Sep
 2023 13:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230918061139.810552-1-linus.walleij@linaro.org>
 <61ebf7f5-7990-0134-2eee-dc5a6881ccd0@gmail.com>
In-Reply-To: <61ebf7f5-7990-0134-2eee-dc5a6881ccd0@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 21 Sep 2023 22:45:13 +0200
Message-ID: <CACRpkdZpjSTuCJVsM6+2a2gD-SOKWnedS8UrBz0xSh-sg+PvMQ@mail.gmail.com>
Subject: Re: [PATCH] RFT: mips: implement __udivdi3
To: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Mauro Condarelli <mc5686@mclink.it>
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

On Thu, Sep 21, 2023 at 3:42=E2=80=AFPM Daniel Schwierzeck
<daniel.schwierzeck@gmail.com> wrote:

> I played around a bit and following simplified code compiles on various
> MIPS32 and MIPS64 boards. (E.g. "echo CONFIG_FS_SQUASHFS=3Dy >>
> configs/malta[|64|el|64el]_defconfig && make malta[|64|el|64el]_defconfig=
")
>
>
>
> /* SPDX-License-Identifier: GPL-2.0 */
>
> #include "libgcc.h"
>
> #if BITS_PER_LONG =3D=3D 32
>
> #include <div64.h>
>
> long long __udivdi3(long long u, word_type b)
> {
>         long long ret =3D u;
>
>         __div64_32(&ret, b);
>         return ret;
> }
>
> #endif /* BITS_PER_LONG =3D=3D 32 */
>
> What do you think?

Looks good to me!

You can just modify the patch, sign off and apply,
I guess? Go ahead!

Yours,
Linus Walleij
