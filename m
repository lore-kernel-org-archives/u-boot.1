Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EB3C3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 10:14:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CD9288ADB;
	Thu,  1 Aug 2024 12:14:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BPOC8RK0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E8B988ADF; Thu,  1 Aug 2024 12:14:56 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F6F08874D
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 12:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2cd5d6b2581so4643759a91.2
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 03:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722507293; x=1723112093; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hM9D8LND/1wqRtCnxzUdyFBdKrgx1iqrxT1jUxpCfak=;
 b=BPOC8RK0J/MlYVpsGM/4weB7HrEQ7uQ+0JSANDGS2E/rsaoGOs4PYY+Pl4GqKHVv2Y
 Ttqn5ndGnWDiu2yDrHjkxxFZ6F2sTWfl7q9zUzSWMqj+3qOFkfRwXOnVTotvXDnbtTZH
 ARhdqgtQnDI6mI4WmyMDwn98dUsUUACRZpgTyE1+c3iu6fFUlmFOn48UUtp/j9c+ejQK
 Slyre7GclcqxqLuMrzPlTK8opNuHZgqYdMhkWsUuwFp3ZnAWGbyyeGin/+33HAXsFchz
 quCKvtkr7g2cvUTfkjVjzG5OQFnYuG9Q52uoEy9nsNfhhvAIKDBxjaB7Gw3FUrikpEJL
 /tfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722507293; x=1723112093;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hM9D8LND/1wqRtCnxzUdyFBdKrgx1iqrxT1jUxpCfak=;
 b=r+r4d/G0/bWohKSXRJxhNrlYgikO4kXJzgyJduH3Fiw31nNEZj8ziK9sDDsHpE5yIT
 X1sLmSMf5LTnxc9V8ZMZ4HE7e4EUnjETWUfvYn8fQhT8sEz+BYRbH1qc0snrEY0lUdQQ
 3JVWxt0ZRxw/XuS6CjiJozlTgz9qNqoMNdkYdDXYk5+d/Rl6iZs4VW6uwO4+M0uSNFrM
 2Y08FeeUM+tEMU1czHqMhAG2lwYdmiN0U4ZruEKL5HSw3cN/uCjNVmgacXTHF6bcnX0s
 noNBxhyOqSuihQhARgJOKF9asszhLSifEd9sHOwCRK5ZX+xZK91QY+/IeHCBJTmjntUo
 lG2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGRef5HbxIpuvnfagT9A4KXGb9g5+/5DHU3e8yCuXABg4ixZPB4YJmBzojzsbdqUtovFwvhUwpdpI4GkF83qMyJrZEvA==
X-Gm-Message-State: AOJu0Yx20/8XPSnxq6Ec5jckzYcgwZ6q0DEvS17COA4myigiPyOeI9fC
 6DeRBuvlQqkqJFmZbxWajYA+ADFhpLSMhnrXC64yZkincXXcJtwOWpppp5kUlr7T5MYOlTsu8of
 XmgJDDINUdaQqtFyfduOIJk/T1AIucMW0PHeVjQ==
X-Google-Smtp-Source: AGHT+IGurCh5lBJd8jlLCrjbjXTxXN1ssaMjcfqm6qclLJb6v0VJxWY4cExscSgYZ5619cUNPaYMQfb8wr+ANi6b49A=
X-Received: by 2002:a17:90b:4b8c:b0:2cd:1e60:9c31 with SMTP id
 98e67ed59e1d1-2cfe7b24f10mr2343635a91.30.1722507289824; Thu, 01 Aug 2024
 03:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAC_iWjJapZD2dvzVh9XGn9hy0YecoyDN6-vtMASv7oF_j8LS-A@mail.gmail.com>
 <CAFLszTgQuvgCHrV2Eej6rrnaxRt_xwtJrdgQtuhmp1oU6pgMGg@mail.gmail.com>
 <20240730152447.GU989285@bill-the-cat>
 <CAFLszTjVXzmwqbciQSF7a=teuhx_xSJHL2jy23oK5BgfP_3EDg@mail.gmail.com>
 <20240730194919.GA3794063@bill-the-cat>
 <CAFLszTiM0faJ2Dru7ZgLiuqRPS7R8kmtKqkco0x-_PfNM5+p_w@mail.gmail.com>
 <20240730201129.GB3794063@bill-the-cat>
 <CAFLszThWZUZabbysC15aLaCRt8EL1=qts45hn0Usp5htR-dp1A@mail.gmail.com>
 <20240730212009.GC3794063@bill-the-cat>
 <CAFLszThsMiQWfkVJ0POMJAFDyYWErLssG5vsQOG4V2WTWoE=4w@mail.gmail.com>
 <20240731171726.GF3794063@bill-the-cat>
In-Reply-To: <20240731171726.GF3794063@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 1 Aug 2024 13:14:13 +0300
Message-ID: <CAC_iWjLrCM209h=mghHSNi=9aURY5P_-NyidQRJY1hR8D1FFBA@mail.gmail.com>
Subject: Re: [PATCH 5/6] efi: Use malloc() for the EFI pool
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
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

Hi Tom

On Wed, 31 Jul 2024 at 20:17, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Jul 31, 2024 at 08:39:23AM -0600, Simon Glass wrote:
>
> [snip]
> > > > > so that
> > > > > step three can be seeing what tweaks may be needed in where things
> > > > > allocate memory.
> > > >
> > > > So my series is step 3?
> > >
> > > Or at least understanding what the problems may still be, yes.
> >
> > In that case I would like to clean up EFI's memory management before
> > doing step 2, since I believe many of the problems will just go away
> > if we can get that right.
>
> Well, I think that's where some of the big points of contention are,
> yes. You say "fix" and Ilias and Heinrich say "but the spec".

Using malloc on efi_allocate_pool() would be ok spec-wise. Simon's
current patch is ignoring the efi memory type metadata we have to
preserve. On top of that using malloc for a *single* memory type, just
kicks the can down the road until an EFI app chooses a different type
and we are back to the same problem.

It's fine to teach efi_allocate_pool to use malloc with 2 conditions
- memory types are preserved for all allocations
- malloc area is big enough

Cheers
/Ilias

>
> Perhaps once step one is done it will be easier to find a way to address
> your concerns without also breaking "the spec".
>
> --
> Tom
