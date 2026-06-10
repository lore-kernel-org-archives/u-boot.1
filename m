Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5947DCD98C7
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 08:39:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D7AC83FEC;
	Wed, 10 Jun 2026 10:39:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="lB7gPhxK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C7EA80086; Wed, 10 Jun 2026 10:39:39 +0200 (CEST)
Received: from mail-dl1-x1233.google.com (mail-dl1-x1233.google.com
 [IPv6:2607:f8b0:4864:20::1233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97D0780086
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 10:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-138129a622dso4763486c88.0
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 01:39:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781080774; cv=none;
 d=google.com; s=arc-20240605;
 b=ht/n8ob+YFuDqng9mawQPppi6tKPvnNausigM+HGBp28tUBu+n5e835dYMUFcjT/9Q
 B/CptUNkfkl4LSDZCm+c3f+8m3lII/+/RZJULyxaX/dshOSooMZVG3Y5sGvDd268vD5P
 iwJAlRtRWxr6/DtOhz8HqYwK7N4jffZw2kx3t3a6PuH8EpZpbXe2lqCFjdlFL4wHy19k
 4xcl4IMbQwtOeJJdkorUBSuy8oMsxKQQU0nDgYgUMnhapavrbTUMjZZjZkkEyaK3nV71
 X+O3tSWGa3qUuV321Fjx2cajnd4p6p0DZIH1p3WJoq6SNtV931P8kbSRAO5Tw0znPDWf
 92mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8RP9CLUCStwGVMbg8H0l0iOKwzmKvhbjylgjxMlG6U0=;
 fh=YWaiu2izYsAIoKe7SRHtoYNJj+VfbNlKVF7JjAts++o=;
 b=YjM6ICmFQxuFl9BpNff8FcWRfF7uCQizghZelbLG9fHrqp4r8vbj2OGMMhGUmgbxuh
 CUCi0xJp1tdxRRf8AitjOoyqIML/h8Yiren9VmeYuur5HXDrvCWSPgssIl7flL4t9GZp
 W5jCg2uy1uz1NH+JAIPtMVm/7SszCFAe48ni9GzT+jR4x+3soQgXWmmZ+cSfYPDHfKgg
 hSOy/+XF40kPCQ3edaOQzzXJu4PihGIAaJuCR7zTftqP4BnuDiFemjfAr1NG0bwoGYZw
 gni8zdqNGHlrLi2UKKBkP8QgjNDBx35q0DIBHkNbql1mBJI9nwHm3xYRXDdZGxHuEP4o
 7ctA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1781080774; x=1781685574; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8RP9CLUCStwGVMbg8H0l0iOKwzmKvhbjylgjxMlG6U0=;
 b=lB7gPhxKrCW6TVH13Q6Z7qXdOtZTS5nfdZJgJCDe3L30VeMWpNXinGDUeX1V8Sy9eB
 HXQFnZ2ZcCR8OOextMmDeb8gATul+sTv0pw+pxTeoqNoDMVNiVbZ42C3vnXqVwm1u0jc
 vV3JsO7e/IP93BZEqkJU7kr2YC3mVmYiJCnc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781080774; x=1781685574;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8RP9CLUCStwGVMbg8H0l0iOKwzmKvhbjylgjxMlG6U0=;
 b=qEbyDeSAS+2Q5+Labr2Y9Va9WWLbqwIrL/bCGVbwCD/EptjdOYI+BhOfGrSjb0laXh
 UFvWCsSoxjByKTwKvIP0fr/pNo+Vby54JGnkoOa0K2BdLH1nXEmFXJPVuGoEtE8JNBf4
 W+j6jX4fgZVBicuCeTZA6rpe8Te09f+BrspAlcA3kilzasjD6bCK45g+so3AKaN7x87y
 0SGg/l20KIDN9YUZj5VhiIScCyDb6YALRAisUOsgtoqvZx7g79jwlq9BcRflWGqT+9cL
 MC8HaiS74VoGSDcZ8h0VjuOTx8s1noptK6gUGVy81YOO2KfdFbWZcNGFyh8m9GJ2QnDz
 JgKw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/j2XYmAHHGp9kVlLEoGtAS7F0iwLBCj0UiwKaTaXbGYO4gf6LNfjfdwI1VjzY04niFJX81q9Y=@lists.denx.de
X-Gm-Message-State: AOJu0YxhcPobHuoROldUmOw9VfYcn/EIMa2pTDl7wPWkVxj+UFeP9PuG
 TYDMkfDRP5mELgCuGCMLTtaubnmpEINFunj2EI9xlTFcrtN/uvxgEWiZCzb9clD+pBvwdIVrimZ
 B6A9P1OWJkXEN5k17F+DqUNCTp/4rVvXDKfZIvwveAw==
X-Gm-Gg: Acq92OH5UmvZb/hpuaeTqCLIOrEJB4fPdJlheWB6cKB9yBGK65/hsCsi05LI/YLSRsx
 jtSTgtYgGJ3VxEEiucs1mQe+56VFjO7pn0iuiyghOr2EWDxXw1wsmSeu6UOPeAXkjQ3+k4NapyW
 q1LZxCmx5yUF0y2FeZB6yfCNGlTr9/H1L4TiMMwlZWCWDiukPNMOQK8fMVjxGxk+snFeXMXUczT
 egxDVu2e3nSekcQZSQ2PjjneOtVyobt2T1XuBVH7HYWDAs7YnZwOYLYUnP3Bi6Qp4mFlfUumOb7
 BHJgNSiKbD+A+8ZGaGIZoNBubjl+P/MNt4I9e96qMaK9B+z+wg==
X-Received: by 2002:a05:701b:4549:20b0:135:6914:87e1 with SMTP id
 a92af1059eb24-13831a5743bmr3176810c88.6.1781080772898; Wed, 10 Jun 2026
 01:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260608130606.121031-1-daniel@thingy.jp>
 <9b0b5a7c-3a6d-4a54-ad67-10433cbd3435@cherry.de>
 <20260608140454.GH382693@bill-the-cat>
 <0642ec3a-eeac-4d99-bf2c-23822a8d2df5@cherry.de>
In-Reply-To: <0642ec3a-eeac-4d99-bf2c-23822a8d2df5@cherry.de>
From: Daniel Palmer <daniel@thingy.jp>
Date: Wed, 10 Jun 2026 17:39:19 +0900
X-Gm-Features: AVVi8Cd_kDEYf6tQrTP9W0CaeWZXAJWIoyhqQb9WGFxC6nSwPp5pVM_kqbmvCSY
Message-ID: <CAFr9PXn2j1B6WxRdPFabHJg7Ym5KJYgDQTJ16A0uN7Tz-Ot+Vw@mail.gmail.com>
Subject: Re: [PATCH v2] xyz-modem: Select CRC16
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, sjg@chromium.org, u-boot@lists.denx.de
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

Hi Quentin, Tom

On Mon, 8 Jun 2026 at 23:22, Quentin Schulz <quentin.schulz@cherry.de> wrote:
> Also, lib/Makefile has
>
> obj-$(CONFIG_SPL_YMODEM_SUPPORT) += crc16-ccitt.o
>
> which is.... odd? Shouldn't this handle the case of "missing" SPL_CRC16
> dependency?

I didn't see this. So it seems like for now just adding
CONFIG_YMODEM_SUPPORT, making that select CONFIG_CRC16 and the
Makefile tweak would be enough for now.

Would that be acceptable for now? It seems like the xyzmodem thing
needs a bit of refactoring etc. I actually have an almost entirely
rewritten version of it somewhere that I wrote because of the issues
in the current version. I'd prefer to fix the build issue for now and
refactor + replace most of the code when I have time to do it
properly.

Thanks,

Daniel
