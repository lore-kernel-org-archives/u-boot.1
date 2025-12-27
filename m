Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC8FE8FDCC
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 14:25:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2559F83BD2;
	Sat, 27 Dec 2025 15:25:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XL5GX196";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5526E83BDD; Sat, 27 Dec 2025 15:25:04 +0100 (CET)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13B5883BD2
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 15:25:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-34c363eb612so7861198a91.0
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 06:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1766845499; x=1767450299; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2HtW6+r3UT9RrDtdKU4TipftlkxuRXs1faKttfsVxwU=;
 b=XL5GX196cHJ9ZxcbONpfw6bX3Yx9ib81Oe5mSemn69khl70rQyqc6LFBUKqhUOVisE
 PYOckbUUuYrp5BrzEJc+BKUEZFJjjhustymBmJkNZZsZEV/eDuD4yVgy2Xl2lrehohVW
 cC9CW/AjBH3e9gxm/G7+6WsgS9dYsR/3oGID4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766845499; x=1767450299;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2HtW6+r3UT9RrDtdKU4TipftlkxuRXs1faKttfsVxwU=;
 b=bC/ecGNMDfUZBLIojj77l/+DIVkRI7Wiy0CWNg5wMwHocJ/I5IQU3mTYzTzU5sFSsa
 zW1vUR2h/OtfsybBg9wmtNM7ckPw7bEXqgwUZQtm0pNhzLNM72/zlPzIiS9LcRL2Tr/C
 qLRwJnkFcmK32RhYZgdRMDjtLy8Y5d4aTpCp4SfrYSWdiqN0Br5RTm+DBVQzwPWKAtSU
 K8JS1VUn/ptpOH6H0puMBKvESuRQxBfa468oHCIzEfpve+xzskn0GouWZhjPnk9/SCyH
 cqTESAx14R0EoEdSlsO7CP6gu/iNt0EV9sSE5ifBZToOW15iadynBxmE+i4ln85tRqpD
 EkIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAUixU7eH8d49Rj5yj8xw2yQyQ+g8fkwlJ1fwleAG0r3RrMaTa71NZ+GpRLO9cCV9vKwNH7yc=@lists.denx.de
X-Gm-Message-State: AOJu0YxoHt5pJjt2ifCA0dMPnnhfMFSHmZeE+unDz7mLY/B5PVPUdtIf
 te8bFh0DltUDpkg626fymVc6U6pc+DcLdwhMOkeINu7krJxZZgAX//KIH8y5EAMTy+vgD35sSoi
 Q/Jtx+pbtc4xkVigdyhZfQQlVUsZE7TW9nhzWQ4Bt
X-Gm-Gg: AY/fxX6qEBxL23pzkU/yissngdiXFwpFPc5wGQ3XsyC/Wt3n6Et46z9rGEoNyaJANEh
 4oikO8tsIdi/G/jijXVpV3nk+YsRS1f4e2hTaqwuUIbRp5qaxg0LqSxTPyXymk+0Xaq5ad15YO1
 IDUlGN8RErFimtAxh2PYrkD7ePBrQfO9TMDZP98j/NzbvPI1FlhhlmyR3euJQggSRXvQhawqddn
 ydMvUkpcJsQH/idjjl+HylQfJazSKQAFaUGRKjiE/jdPbOw++tcyU6VTZ6yUXgEwqx//A==
X-Google-Smtp-Source: AGHT+IHxBbWiimbjbG47b66y+4yPGZFY52xng8Sh8BklhavYneqpcNoEPAY1oYXqD+oGQOTsPM4D69oT7x89HHvAVlM=
X-Received: by 2002:a17:90b:56cb:b0:341:abdc:8ea2 with SMTP id
 98e67ed59e1d1-34e9220008fmr23914476a91.37.1766845499538; Sat, 27 Dec 2025
 06:24:59 -0800 (PST)
MIME-Version: 1.0
References: <20251221015859.738112-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251221015859.738112-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 27 Dec 2025 07:24:31 -0700
X-Gm-Features: AQt7F2qHXEIx4z2Xz7MM9p3zMW_j56_PoSgaoNhj3gSqmVY2OVGWuKTqu4UXl2M
Message-ID: <CAFLszTi4C8-d_FhgP=1kffFeJN7D3RtXfJ1LLvYWzXw6FaZuzQ@mail.gmail.com>
Subject: Re: [RFC 0/8] trace: improve support
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Yao Zi <me@ziyao.cc>, 
 Raymond Mao <raymondmaoca@gmail.com>, Sean Edmond <seanedmond@microsoft.com>, 
 Heiko Schocher <hs@nabladev.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Rasmus Villemoes <ravi@prevas.dk>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
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

On Sat, 20 Dec 2025 at 18:59, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> In the current state the trace functionality is not usable.
> With CONFIG_TRACE=y not even QEMU can boot.
>
> With this series CONFIG_TRACE becomes usable on
> qemu-riscv64_smode_defconfig.

I would be great to enable this feature on QEMU!

>
> It all starts with correcting the handling of recursive calls
> to the measuring functions at the entry and exit points.
>
> When a function is entered we record the time and reading the
> timer leads to a recursion which should not switch of recording

off

> traces but just be ignored.

See my comment on the patch.

>
> The meminfo patches are in the series because the output
> of the meminfo command depends on CONFIG_TRACE.
>
> Also the Pythontrace test does not consider that output depends on
> configuration.
>
> There are still issues with qemu-x86_64_defconfig when trying to
> trace. But I would like to collect early feedback.

We have sandbox tests for tracing, so eventually I suppose this could
be added to CI.

>
> Thanks to Patrick Rudolph for pointing to his issues with tracing.
>
> Heinrich Schuchardt (8):
>   trace: correct handling of recursive call
>   trace: initr_trace must succeed initr_dm
>   test: test_trace: remove invalid assert
>   trace: increase TRACE_CALL_DEPTH_LIMIT
>   cmd/meminfo: display of addresses above 4 GiB
>   test: cmd: consider configuration in meminfo test
>   test: initf_malloc is only traced with EARLY_TRACE
>   test: clean up test_trace.py code
>
>  cmd/meminfo.c               |  8 ++---
>  common/board_r.c            |  2 +-
>  lib/Kconfig                 |  2 +-
>  lib/trace.c                 | 59 +++++++++++++++++--------------------
>  test/cmd/meminfo.c          | 20 +++++++++----
>  test/py/tests/test_trace.py | 52 +++++++++++++-------------------
>  6 files changed, 68 insertions(+), 75 deletions(-)
>
> --
> 2.51.0
>

Regards,
Simon
