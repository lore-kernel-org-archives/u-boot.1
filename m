Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F351C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 19:53:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66CA087823;
	Wed, 13 Dec 2023 20:52:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IM93dKnD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C45587854; Wed, 13 Dec 2023 20:52:32 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47908869CA
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 20:52:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-dafe04717baso6983446276.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 11:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702497149; x=1703101949; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=neh6LojXgTPwtwLEz2OH3xXtlCrSfMYJTL+9zFgY6KQ=;
 b=IM93dKnDCGniUuZiwjJYPyzOp6Kp3mKoLFZgKaWWq08EHtK6WSVRiVzqNf5YugwXZR
 YticH6hEZeo1U0oZwyH4WSk5/NzGp3E2aw8chtYeWG/760JLnC3Ct+JLaMZOePUkBrmY
 VAKKpgqHhArw9+NpnEu4qvOHgI6iz190Xe9X0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702497149; x=1703101949;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=neh6LojXgTPwtwLEz2OH3xXtlCrSfMYJTL+9zFgY6KQ=;
 b=g8ILwmu0LzMVJMjTISCYpgOFZVCydEBouhf86uU4NE8wNGGEcRge2YZeBR1Y+pPUlT
 2H5tn1ZmfWSOcJwzAnJM4JFoWxwqL+Afjg/hx6/Z3mX21yJH8uSymRD0PsH5BGiNT8kX
 PBx5BQ205WLjOvZTFnCc9paaNp/i4tJ8CBNKs6r2rDqWxSBiHQ/QAGrxTCZoxusRGAwO
 aOltjibrmHm2/X2jylQDeAMGqt0Xoeet2aSuRBrGrpCULIQEfVgm9AmmwXI8INkn7g4j
 59A1u3FEEWvP4Yk/T/NqwMGd44O9FEeahkPGi7J50/joKu7DpC+vo1TnipB6RrioqmWE
 1KLg==
X-Gm-Message-State: AOJu0YwH9OwEi6iFlbNaNCKxtLuwLDouoT/3tpqkgcgPNo+dOHIvXV76
 MCGuCPZMdwuPNzKcL3BuHU1BYryq+aW+UzWC2qUpzu+vS8hO55km4Pg=
X-Google-Smtp-Source: AGHT+IEvmiHcUm54G0eGrSQOnhAsQbghBb9KyfzHahDdyiJJJUgUkqEPdOUEjQJc6ilkAFByzckmCsnXZI53jkTooCQ=
X-Received: by 2002:a5b:f81:0:b0:db7:dacf:6fc7 with SMTP id
 q1-20020a5b0f81000000b00db7dacf6fc7mr5922679ybh.79.1702497148638; Wed, 13 Dec
 2023 11:52:28 -0800 (PST)
MIME-Version: 1.0
References: <20231202205255.169670-1-marek.vasut+renesas@mailbox.org>
 <CAPnjgZ0zNGCiPUaEZ3NTdebm8a9uApBWasZa+=WHewpSVWcVuw@mail.gmail.com>
 <cfd0c67c-adfd-4dae-9341-1ce0ed3f70d0@mailbox.org>
In-Reply-To: <cfd0c67c-adfd-4dae-9341-1ce0ed3f70d0@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:51:16 -0700
Message-ID: <CAPnjgZ22Dg895xd386VjNE4PnrxGgOmLZaBzw7XGyg4U9SYXgA@mail.gmail.com>
Subject: Re: [PATCH 1/2] command: Allocate history buffer using calloc()
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
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

Hi Marek,

On Sun, 3 Dec 2023 at 13:44, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 12/3/23 18:44, Simon Glass wrote:
> > Hi Marek,
> >
> > On Sat, 2 Dec 2023 at 13:53, Marek Vasut
> > <marek.vasut+renesas@mailbox.org> wrote:
> >>
> >> The history buffer is currently a static array which can be some
> >> 10-40 kiB depending on configuration, and so adds considerably to
> >> the U-Boot binary size. Allocate it dynamically instead to reduce
> >> the U-Boot binary size.
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >> ---
> >> Cc: Simon Glass <sjg@chromium.org>
> >> ---
> >>   common/cli_readline.c | 26 +++++++++++++++++---------
> >>   1 file changed, 17 insertions(+), 9 deletions(-)
> >
> > This is very intriguing...
> >
> > I would expect this to end up in BSS, so not part of the image, but
> > allocated when U-Boot starts.
> >
> > What do you mean by U-Boot binary size? Which architecture is this?
>
> ARM64 , I spotted it at rcar3_salvator-x_defconfig but it has been a
> while since I created those patches , they were on hold for a while .

Yes, then really we should fix that bug.

E.g. __rel_dyn_start (OVERLAY) is missing for arm64. This affects all boards:

For firefly-rk3288 (ARMv7):
 11 .bss_start    00000000  0106c578  0106c578  0007d0a4  2**0
                  CONTENTS
 12 .bss          0000cc44  0106c578  0106c578  0007d0a8  2**3
                  CONTENTS
 13 .bss_end      00000000  010791bc  010791bc  00089cec  2**0
                  CONTENTS

For rcar3_salvator-x (ARMv8):

 10 .bss_start    00000000  00000000000f1a18  00000000000f1a18  00101a18  2**0
                  CONTENTS, ALLOC, LOAD, DATA
 11 .bss          00011108  00000000000f1a40  00000000000f1a40  00101a18  2**6
                  ALLOC
 12 .bss_end      00000000  0000000000102b48  0000000000102b48  00112b48  2**0
                  CONTENTS, ALLOC, LOAD, DATA

The 'LOAD' attributes are a bug.

Regards,
Simon
