Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809FAC35FF1
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 14:43:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1E2B81D3B;
	Fri, 14 Mar 2025 15:43:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AoLuciVe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4392081D27; Fri, 14 Mar 2025 15:43:45 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 241D081D27
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 15:43:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac2c663a3daso445833966b.2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 07:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741963422; x=1742568222; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yA7cttECxEJsG4GyuGm7cSfe8hNtt7g5KvOlwdXiRuE=;
 b=AoLuciVePrfEKMoVuzBW3zO2Di1hoyqeDL2yMeeW+BUqYOjL5VzwCS0PDbsmun9c+d
 rd9sgLxB2UHQaduBdTz0uwdqbLBS7ZpOCJ3JGMgI5SRjQW7IZcTl9/RwRst031Xy2RqO
 Z2mXYrOjNFnqsM4jfT8XXMsj8K2L8dSpabmn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741963422; x=1742568222;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yA7cttECxEJsG4GyuGm7cSfe8hNtt7g5KvOlwdXiRuE=;
 b=UA9LXa9VTSm4TiG2u74zBr/CCqvHCpAeKUgKgbqlSGvW6zl9Q74fmyaKg3Ybz7IUjx
 VOWvupGq1ArF68SsI6JsagUBrTbrWurQdGUwqVtXUY5DnAILDs9GNSRmb9F54fOBxHdV
 JZMXmCnkc49Z0wPyLdDorzssxwgZynN5p0qW0o1NHiD9A8iDoUXVPTp4BXuA4BwWPN9k
 2d1tT0842tFWmPSWPUCHsem+373scm/M38NjjEQvjDveXShQCHNW+kCOnHAG9LGWZt8i
 +E2cGmTY3YxqeGOFcEjxJJARJ2mknQ1HSDB2X0d7gpLOwJKHGmWE3thE7npjjUmdMD2P
 zf6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHeRG+GkjkVrZbhuUYcnZ3a0OBdiMlih4Z67AnZeXLS7ZA9Xn5qCR2qmzE9FAeMoDcW7MB5D4=@lists.denx.de
X-Gm-Message-State: AOJu0YzIfqZFv+jIvX4aPmK8r3o/uAFak8tDy6wVTmW3wxRmslMxa/lz
 gk5mxAL0MzjlFoXekfSFCZ16jpesiJmijD9UMr+vEueZZDxNL0lfCAZaInxcsbhkoFWC3ZZPpoh
 aFKsgOszJTO6LWzplohFhuyfzOB+r3gjXI2rf
X-Gm-Gg: ASbGnctolPtusS0CRFGihlMZla50osOnnNs52b9qvii+TXSwEOXf9OruXA8JGAdkf1z
 vimBSzCAZp1BO08ZwLHmLhynyoiIIK5qNdDgpMita9JHiPpSsP3i4mVo9mU5GgCzYJ8VJNUCG14
 bBRXR70gD3iI/d1ErY55WCdUTIUCo8
X-Google-Smtp-Source: AGHT+IFDasuvie2a1VszHkUsoYyPbpkH1ZQkdpk+T5vpBDXvtO6YWzuFI/DI8WxkEsaYobE5C5ubMd/2aaON43UJt9I=
X-Received: by 2002:a17:907:7f86:b0:ac3:1605:3805 with SMTP id
 a640c23a62f3a-ac3302515afmr326642666b.33.1741963422429; Fri, 14 Mar 2025
 07:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250306002533.2380866-1-sjg@chromium.org>
 <20250306002533.2380866-7-sjg@chromium.org>
 <b3fab4fc-7e4f-4359-bf15-813158d16b80@gmx.de>
In-Reply-To: <b3fab4fc-7e4f-4359-bf15-813158d16b80@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Mar 2025 14:43:29 +0000
X-Gm-Features: AQ5f1JrP-aM3BBs5da6jOK0zS_qRKeXPB0SrwkLqItiJCbG6FUH4wwwp49RSi-E
Message-ID: <CAFLszThKCtNk5t93KTGo=mLGK497xhOjHu=qcAnqQPMy1cemjw@mail.gmail.com>
Subject: Re: [PATCH v5 06/29] x86: Move the bootm state for zimage into cmd/
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Sat, 8 Mar 2025 at 05:07, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 3/6/25 01:25, Simon Glass wrote:
> > Rather than holding the state in the implementation code, move it to the
> > command code. The state is now passed to the implementation functions
> > and can there (with future work) be pass in from bootstd, without going
>
> Nits
> %s/pass/passsed/
>
> > through the commands.
>
> One of our (not yet achieved) development targets is to be able to build
> without a command line interface.

This is actually possible with bootstd today, at least with some bootmeths.

> Moving the bootm state to cmd/ sounds
> like going into a contrary direction.

It is passed from cmd/ to the implementation, so that (in future)
bootstd can pass it in, without needing the cmd/ code.

>
> Maybe it is just the commit message that is not clear enough.

Can you suggest an update?

>
> Best regards
>
> Heinrich
>
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >   arch/x86/include/asm/zimage.h | 22 +++++-----
> >   arch/x86/lib/zimage.c         | 75 +++++++++++++++++------------------
> >   cmd/bootflow.c                |  5 ++-
> >   cmd/x86/zboot.c               | 20 ++++++----
> >   include/bootm.h               |  8 +++-
> >   5 files changed, 73 insertions(+), 57 deletions(-)
> >

[..]

Regards,
SImon
