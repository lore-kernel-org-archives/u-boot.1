Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98F5FC618A
	for <u-boot@archiver.kernel.org>; Sat,  3 Jan 2026 20:16:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2033A83AB7;
	Sat,  3 Jan 2026 21:16:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lelnAhv5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B567F83AED; Sat,  3 Jan 2026 21:16:20 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A802583AAE
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 21:16:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-64b9cb94ff5so16537579a12.2
 for <u-boot@lists.denx.de>; Sat, 03 Jan 2026 12:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767471378; x=1768076178; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QrJWPHtV9gKBYpQaUCB+6wwoQoy4p6zZgVQwNs1eHpI=;
 b=lelnAhv5+rbaMUcVQObPUDlHVdLab1xmRvsny3CSyTxSfJb+W9tHVh09pDEWq0+svf
 ta2n3XSYOO3MIY388tHMbJOmWfw1Ra9LKgh1ogQ8pgANpZ+hDuSQwZ8qXFxHDFzyfStd
 Sqg1gPlKI09ofJNkpxQ9FKfr7m63iSwBHomak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767471378; x=1768076178;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QrJWPHtV9gKBYpQaUCB+6wwoQoy4p6zZgVQwNs1eHpI=;
 b=MXE19zoXedU2hhv7HlTcO4yITwFXuVkM0S1GdDmYe1LKvXNLRG94PjnxiV/TWXIWiK
 0KdZxfF1uzhn0k00TKW17K5fVJFtqTHmRJIQzClc9e7yEnUBfJOSwIAW0lmMILJ74Zs2
 6ZChwy3glAvZJGzhUUgxZtubUkU2zNL/dSKohh1iSIXHo7JpMykvIuBiTncWbDgNvtVn
 eMZOqEAG3RSEZg7Ca6gvPGa4EVggAJoqQJCOiPNwaewRhW64qINg2fhQzdoNfRSeXEMa
 HWft448xW1uARV3HMin11WiaF6Jl5cJUHMvMFRhodIEx+Dxpw6MesBzNcnTcmHNXT9hK
 tB9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSbwM8s8wk4SeIEwROBDZr8xfVZqqK3Djaml+3zLigMQ9OJ2jf9r9EKQKcflWqzcLnSzbhDGY=@lists.denx.de
X-Gm-Message-State: AOJu0YwLQJmn4RNPATXr0N3VQczwhmFQoXbZTj3Zqt1jT8mEPJNNi2SA
 SlmJnmrnx0fVfy+wsOboUt3j1cnBUc8Z1ScudmbB+BviD/B1DUc1ALumettmmMebRT+ELxR+uhI
 lO8Th5H+tmTm8eUyyy+N+Vf2bMkeVWG7lw9smSc20
X-Gm-Gg: AY/fxX5l5rPqqc4OQcjIduLac5GvxOMF8sbFuwyexIfuIb8webjcFyvJafLbNQbiU1K
 zkudAJQT13m4gdOzE5E8HvGS5xHrIGzup2txZGfgQiXZky4ScXygzKZHARQlBATd5R5OCK63VtS
 trb5ZdZz3k8ZkJJj1iNazs6jZ9ymB0WhY7xP57DSkaYlX4L5S3LXncvBZyquSjOG7eyYG02ZLIn
 wL66Hi89YQDAe1jemTwF1bWs0LXHpp69R77CpsRA/+W6O81zQnpkX1rJKfiNzmdzRquSw==
X-Google-Smtp-Source: AGHT+IEBMpNMOnHBWOT/palC5ZF+KMUbMd/gJHTjFBDxlx4XHghu2z3wv6khmxx+6xg3j3bA6r7a23JNC650YiZIVMk=
X-Received: by 2002:a17:907:97c2:b0:b73:4b22:19c5 with SMTP id
 a640c23a62f3a-b803722a7f4mr4340747566b.44.1767471378058; Sat, 03 Jan 2026
 12:16:18 -0800 (PST)
MIME-Version: 1.0
References: <20251231191054.247270-1-heinrich.schuchardt@canonical.com>
 <20251231191054.247270-3-heinrich.schuchardt@canonical.com>
 <CAFLszTinaB_wvQKijgW=CvP8Qz5dgjOv0ykGrSfEpUG3Jjevtw@mail.gmail.com>
 <7befea69-0f45-4d7c-88e2-04450563cc29@canonical.com>
In-Reply-To: <7befea69-0f45-4d7c-88e2-04450563cc29@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Jan 2026 13:16:05 -0700
X-Gm-Features: AQt7F2qK1-nhzQ71YGt3ZCYYUo95jqHOhBa6oUx-tLpXB6ldgmQGNCVVz1OPK-s
Message-ID: <CAFLszTik1iwwpwTxM14vTR9c8vjJE3OwCJkhAVijzUWvZ++EWQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] test: do not imply os_malloc() outside of the sandbox
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marex@nabladev.com>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Fri, 2 Jan 2026 at 08:19, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 1/2/26 13:29, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Wed, 31 Dec 2025 at 12:11, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> When compiling with CONFIG_CC_OPTIMIZE_FOR_DEBUG=y the C compiler does not
> >> execute all optimization paths and add a reference to os_malloc().
> >>
> >> Remove the reference if CONFIG_SANDBOX=n using #ifdef.
> >>
> >> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> >> ---
> >>   test/test-main.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/test/test-main.c b/test/test-main.c
> >> index 3254325e8b1..1815d60acf7 100644
> >> --- a/test/test-main.c
> >> +++ b/test/test-main.c
> >> @@ -734,6 +734,7 @@ int ut_run_list(struct unit_test_state *uts, const char *category,
> >>
> >>          uts->of_root = gd_of_root();
> >>          uts->runs_per_test = runs_per_test;
> >> +#ifdef CONFIG_SANDBOX
> >>          if (fdt_action() == FDTCHK_COPY && gd->fdt_blob) {
> >>                  uts->fdt_size = fdt_totalsize(gd->fdt_blob);
> >>                  uts->fdt_copy = os_malloc(uts->fdt_size);
> >> @@ -743,6 +744,7 @@ int ut_run_list(struct unit_test_state *uts, const char *category,
> >>                  }
> >>                  memcpy(uts->fdt_copy, gd->fdt_blob, uts->fdt_size);
> >>          }
> >> +#endif
> >>          uts->force_run = force_run;
> >>          ret = ut_run_tests(uts, prefix, tests, count, select_name,
> >>                             test_insert);
> >> --
> >> 2.51.0
> >>
> >
> > Oddly I hit this same problem some months back but I didn't end up
> > needing to patch it.
> >
> > Which board are you building here and which toolchain?
>
> I am on Ubuntu 26.04 (gcc 15.2.0-7ubuntu1) and the board was
> qemu-riscv64_smode_defconfig.

OK thanks, I see it.

Could you use IS_ENABLED(CONFIG_SANDBOX) instead? It seems to work for me.

Regards,
Simon
