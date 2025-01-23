Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F6AC02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 06:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11CBC80243;
	Thu, 23 Jan 2025 07:23:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iv5KprfZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33CC6803B5; Thu, 23 Jan 2025 07:23:08 +0100 (CET)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0375780214
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 07:23:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e573136107bso885331276.3
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 22:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737613385; x=1738218185; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ME2QZQlm1vxb+OCNhGzgy2QdwemSGzFQw8Qpoztsjrk=;
 b=iv5KprfZ37IMFxw4/6mgawTpRI+xZXYMpc67fzIIqwFH0aMS8vZZistTmWe1xu9I3E
 kPt3aMPOPmpkiMj21kumR/TpT0N+XOezTOMFOQ3tYZyMdF9O/+z244lhGlGgaAjczvxC
 mvRKF+PsmhMbTldEbLRYuZyWHmJm2dplKrN4QHUwsol/Gm6i4sNKGeDqF6NJlZLpI+nO
 Zhm4W9nVLd5CLtIAeSpC0XAZOwBnAX9zJpVojSiLDqDZeeyY7jYo7M16cap7WzO7l07Y
 sinl7nVKAKUEBEuqfAnbbxawaHBkkdOMmqjyQiY+tVffQHVyP7vCF39E73nxltCV4cBe
 Y71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737613385; x=1738218185;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ME2QZQlm1vxb+OCNhGzgy2QdwemSGzFQw8Qpoztsjrk=;
 b=ARwwBQtUM8LLqM8IkfWIN1hv5dkvS4SpxqLqVudfPiX4jYqzf2166G7NVVIiVBwfL5
 MgsY0dLrtZfKS/ntCJ20icmztSb1W7507Fbt3MF8wQCfefvXw49yFHKznNnk3Elc6gVd
 NhmKBMDfHCKKfoEotUf4+nB5yuuLSMC9q2gwVb/4s3eRThO0/mDQ1qij0Og3orxGUsXN
 JgtWCFTVdrQE59ZMHA0wnASVIwfHKgA9g6og+k90msT2dXLbDWR3rfX9s1XSjnuhU7om
 gU8PnQdHXM89F+KfeBz/iG4G2hUhitWezlUvZfTcQKZixxp5ITC8YoAuZ+PCdzdWiJsM
 UHXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXURDUN2DBsp5l7nePhsIN9Evua2DBbGfSDcmhpyqkETVZOLTW0x4TLkDIonlW23xrlenLyFEs=@lists.denx.de
X-Gm-Message-State: AOJu0YwDG+rOJHYRHxcnziditq5+T6g6fY60XHoYmbW7QWWFaJUROOJU
 91gLNVA3tHwjpKt6oy4YtGl/+2DkPdWeeB35ZqO7QyC99EsuSHM1NtUArAUUPtGM9eLWJI/P7ja
 tKQGCNEfPOF5c6IbR8TrWxlSElT0rLAVRw6sOjw==
X-Gm-Gg: ASbGncul7KuajHi4MPBkXvz5P4GvR7Bud4fDsqXyu45ruUWOo4UgH/TE03z9A42wxWt
 2mzrYWuO0vqkWMoD+oiUZZhHiJn9EPp3jsmVs5xx4M2qvysAr4KnoSuZ7Ev4Qfg==
X-Google-Smtp-Source: AGHT+IHYXUN6M5QZX/C+6JhJi42e9tOd15xtAVKaUHHyJfq/qCcjADHmmGs4hxD9swcwFK87/oB6c+MVnG30F4M0Rbk=
X-Received: by 2002:a05:6902:11c3:b0:e53:75ed:8321 with SMTP id
 3f1490d57ef6-e57b1310762mr19419076276.35.1737613384924; Wed, 22 Jan 2025
 22:23:04 -0800 (PST)
MIME-Version: 1.0
References: <20250115200144.951530-1-raymond.mao@linaro.org>
 <20250115200144.951530-3-raymond.mao@linaro.org>
 <CAFLszTjYm8UBchOffiayzjbJrTsj0_HsV3qL6zwmAVQZSv++rg@mail.gmail.com>
In-Reply-To: <CAFLszTjYm8UBchOffiayzjbJrTsj0_HsV3qL6zwmAVQZSv++rg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 23 Jan 2025 08:22:29 +0200
X-Gm-Features: AbW1kvb4wDQxCfrTp63Qk6WGKmOwJR_1UZ8p8IYEDK-x3rQrkowlAhorlB2XoRk
Message-ID: <CAC_iWjLM7dxJ8_gU0Fd13nfkY-_Z2ttsVM_rwNJ_dBoRQOF3wQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] tmp: add TPM2_PCR_Allocate command
To: Simon Glass <sjg@chromium.org>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Tim Harvey <tharvey@gateworks.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Michal Simek <michal.simek@amd.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>
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

Hi Simon,

On Sat, 18 Jan 2025 at 06:31, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Raymond,
>
> On Wed, 15 Jan 2025 at 13:02, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > TPM2_PCR_Allocate command is required to re-configurate a TPM device
> > to enable or disable algorithms in run-time, thus this patch introduces
> > the implementation of PCR allocate APIs and adds related cmd functions
> > for testing.
> >
> > To test the feature, ensure that TPM is started up.
> > Run pcr_allocate command to turn on/off an algorithm, multiple calls
> > are supported and all changes will be cached:
> > `tpm2 pcr_allocate <algorithm_name> <on|off>`
> > Run startup command with argument 'off' to shutdown the TPM.
> > `tpm2 startup TPM2_SU_CLEAR off`
> > Reboot the board via `reset` to activate the changes.
>
> It would be better to have an automated test.
>
> You could create one using the sandbox TPM, and you could add a pytest which can run on my lab (coral has a TPMv2).

The sandbox does not support PCR allocations and I don't personally
see the point writing device emulation code.
The TPM subsystem definitely needs better testing and I've already
discussed this with Raymond. He will start sending tests later on.
We can test simple features on the sandbox, but whatever complex
features we need to test will take place in QEMU

Thanks
/Ilias
>
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> >  cmd/tpm-v2.c     |  94 +++++++++++++++++++++++++++++++++++
> >  include/tpm-v2.h |  29 +++++++++++
> >  lib/tpm-v2.c     | 124 +++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 247 insertions(+)
>
> Regards,
> Simon
