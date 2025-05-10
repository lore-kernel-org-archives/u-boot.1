Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFED8C3ABCB
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:26:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1511282AB1;
	Sat, 10 May 2025 13:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="npUz2P4a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52C3F82AFD; Sat, 10 May 2025 13:25:58 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F0A18295C
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5fc9c49c8adso2341255a12.3
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746876356; x=1747481156; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lyFqzx+bRw40VsgcqLRhAiiFxpTBEVWdRqV/pUJX66c=;
 b=npUz2P4arc9iFCYq8SKe4Gl4nv0vEuXDcpx1iqAMpADiTdL8a4vZO2jLOIwt+p1WUr
 2LkaGSLXg3BnbmKfgsuYjwGnhD08WjH/KjGp1dYOcje9NJL6wAKPzbIzr0piD+v6Uu0f
 ioGnXOAlDgYhHLyjzGnm6SHOKWYZENLIsAtEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746876356; x=1747481156;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lyFqzx+bRw40VsgcqLRhAiiFxpTBEVWdRqV/pUJX66c=;
 b=NetD5kId8Q+DlnsZ5FmE9pj1WN+H2afLZ8d/3iht/8mg0ocWOQN5mDdobIKtUuANcr
 4JCUm1yvKumAYDoVEe8KYMGI5ZdRFg1qxoj02x8ZFSTwchduyTRvAwERDrIQgYjQ2pat
 nuMOKHTe0nWmx3V4soQ+oyqyZMy1OPGTX3mRDyypGjO1jSgwrHl2ZqynUN5jLjNk03AP
 u6CKWerlIh9XFB1bPSq61pZf3yH2/R/Lot7oPqVCxp4bmoRvs2V8l2Y0TP9+376vb2GL
 bl9qsuNQl0cnU1Xro2Vd/BwtsXSP9jsVTfDtF20bHiTBYjIqso9dOfOvfRSfqLvS0zHC
 FVoA==
X-Gm-Message-State: AOJu0YyhUM+/OQFa02BhyjiTIt0f5apeCmmAvr2nL+DdygC74pxVDa1K
 X5FBd2cprL9DhZPr9iYFoQGb19zHtBJx27b9YOjt1d5CzjmmftzP72lG3cqOJ/CB/TYrF2CznyE
 D4qCs+i8+E9JpMtEci4IQdorsU2m/R72nQZPd
X-Gm-Gg: ASbGncuIkt1ckLb/oHfA/bCZDxUAFxe/9gv5SZzTOaq5q6AuH2w7nEr1Bj2MgmrOFZR
 wh1tzPrgDlQw/qPcBn+a48VZDYJORyLHkb3oZ2QPEFvURGKKyCs2bcVWE8J7LVYSfozcKO7XNh3
 P/9RjwYKU/vn+YOwFBHmE/7OpZu/nm4li/iyf7mxMAI+BW
X-Google-Smtp-Source: AGHT+IG9DnE/86Kqy88LrzSK/H0rC4a5w9ZMSMCuqOwL6o2fdVZe2GL0w8tsAfgz57gAFoudosEBMpKTOIKfS8bKfgc=
X-Received: by 2002:a05:6402:2684:b0:5d0:bf5e:eb8 with SMTP id
 4fb4d7f45d1cf-5fca07ee2b1mr5022249a12.23.1746876355919; Sat, 10 May 2025
 04:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250507221112.518041-1-trini@konsulko.com>
 <20250507232500.527782-1-trini@konsulko.com>
 <20250507232500.527782-3-trini@konsulko.com>
In-Reply-To: <20250507232500.527782-3-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 10 May 2025 13:25:34 +0200
X-Gm-Features: AX0GCFuCoHFePE-XJNzRy5I8IGrGI_fpZOGKafwL91EUl1P9npXfuinIs4kZfbI
Message-ID: <CAFLszThB-kTo6wQ5-PJd5E06912OOzXZgPMXze59sJpWKOSNTQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] doc: pytest: Document the test_bootstage test
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, 8 May 2025 at 01:25, Tom Rini <trini@konsulko.com> wrote:
>
> Add this test to the documentation. We need to move the import to follow
> the main comment so that it renders correctly, and add a code-block
> annotation to the example and indent it correctly. Next, neither of the
> functions had comments themselves, so document them now.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  doc/develop/pytest/index.rst          |  1 +
>  doc/develop/pytest/test_bootstage.rst |  8 ++++++
>  test/py/tests/test_bootstage.py       | 35 +++++++++++++++++++++------
>  3 files changed, 37 insertions(+), 7 deletions(-)
>  create mode 100644 doc/develop/pytest/test_bootstage.rst

Reviewed-by: Simon Glass <sjg@chromium.org>
