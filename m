Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CC3C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 464E68892B;
	Mon, 15 Jul 2024 15:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ohm2E+Db";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBD5F8892B; Mon, 15 Jul 2024 15:32:06 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB2EC88953
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6b73dc6e7aaso27931376d6.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721050318; x=1721655118; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zT3nXbeQCEm0I0jzchFdJLb5I/PihpmZAcaIdvXeRSk=;
 b=Ohm2E+Db+CHFdgiFBi4iuU6x8oOoygqMCTpIEFARMVkfR8w3GIAryd53IcOCZh0tmG
 O0fVL+YBBjgeH9XuIMNc9mxGe7CbC7/5uya9q/sP1xIse8TVs6whNi4/c8D2w1lIyr8H
 sXBjnAEZNLK0w1e/BquaGEVqYO5WfeBPo3jF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050318; x=1721655118;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zT3nXbeQCEm0I0jzchFdJLb5I/PihpmZAcaIdvXeRSk=;
 b=K7syVLUKV+/17WqM5YlCNnPCJmRVsggfMVfRt1u8nybPeCOAc7WfjczJdpTYbFII+/
 dvSajPlJQwY8ohg1aaRjkupcm5+Yx9+CtCrzqrER8I0nM43mjacYF7LQziqLj1LcdAoU
 BDoobU0MOzKxwGekZzsIKr7OgD/CJGvT5wGWLEzkWqzlANt/YRNbsSL9C3Y/mI6bFmr7
 IEkoILZTzEB5H58t9Ya9wmUrbZ3fpsj4J7naZEaumnCqypvGdm4iOF/wdq04Fz1Srzp9
 29m8GT/0gggLHWhVV+yqHMgTlMjeDHz6fqfX5fRB3qY/sBbrNOS0JD74R3CCr5XmHul8
 xvSA==
X-Gm-Message-State: AOJu0YymWKCDqw0IqWhEYGjZuwsnk+f983ll052plYkyCmXzxM9RBe12
 nwrOpUr1QBEeW09CjZw9sif57zB9PXeZ1Pp5HhTZE4JRK3qpWgvw9wYRjmZHUwaTFFGQazPYEgE
 8r+1sc2ddcH4XKxvLRwgd2y7A7UqDIr9UOU3sfpYPcGc1fQo=
X-Google-Smtp-Source: AGHT+IHj84ALFb/u7cEH/oYW6iN6x/GbVedrG2NAlLjreWDUeJ2qwNJlUEjjXhzWYxbe1KwMU4mFliYdSL37XyPoh48=
X-Received: by 2002:a05:6214:260a:b0:6b5:149:eac5 with SMTP id
 6a1803df08f44-6b61bca387amr264301256d6.15.1721050317855; Mon, 15 Jul 2024
 06:31:57 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 06:31:56 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTg6OyE1tnQTjkci1Q5J2X3NOj4L738BEd80pdTLX-T5eg@mail.gmail.com>
References: <CAFLszTg6OyE1tnQTjkci1Q5J2X3NOj4L738BEd80pdTLX-T5eg@mail.gmail.com>
 <20240419023632.29078-1-seanga2@gmail.com>
 <20240419023632.29078-3-seanga2@gmail.com>
Date: Mon, 15 Jul 2024 06:31:56 -0700
X-Google-Sender-Auth: U6mXyTFFEx53PsPC6QexLr-w_Dg
Message-ID: <CAFLszTgw0rwEZV=uNp6=0Ow6uQg7ryObd966_qbfjyUV4=6M5g@mail.gmail.com>
Subject: Re: [PATCH 2/3] patman: Add Commit-cc as an alias for Patch-cc
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Sean Anderson <seanga2@gmail.com>
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

On Fri, 19 Apr 2024 at 03:36, Sean Anderson <seanga2@gmail.com> wrote:
>
> Most tags referring to commits (or patches) are named Commit-something. The
> exception is Patch-cc. Add a Commit-cc alias so we can use whichever one is
> convenient.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  tools/patman/func_test.py                                    | 5 ++++-
>  tools/patman/patchstream.py                                  | 2 ++
>  tools/patman/patman.rst                                      | 2 +-
>  ...dt-Correct-cast-for-sandbox-in-fdtdec_setup_mem_siz.patch | 1 +
>  tools/patman/test/test01.txt                                 | 1 +
>  5 files changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
