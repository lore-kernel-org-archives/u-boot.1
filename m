Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB512CE79A8
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 03:00:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 715BD86BF9;
	Wed, 20 Sep 2023 04:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e5jCCDZL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B530186BD9; Wed, 20 Sep 2023 04:59:46 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B85A686BEB
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 04:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-59bdad64411so65063957b3.3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 19:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695178783; x=1695783583; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CU9KME8ZIYZnXnjGz58ZOZT3YMAVCbPo/o6vIQ3AMFM=;
 b=e5jCCDZLU8rkCfdemiSXTwA8mxywCU8ZEOPbxQQhauPSY/cDxbbeYT/dhRGK+nEr2r
 4ITcGAVyFnmeCB1t4eywmB6oWqc+wkntGJKmgHF5Ln3AFkEc1UFXGqw9QeaZIhzDCvc+
 O8hQ6yi4JPi7dvEVAAAGIqspCuZn5bz3KTnKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695178783; x=1695783583;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CU9KME8ZIYZnXnjGz58ZOZT3YMAVCbPo/o6vIQ3AMFM=;
 b=eWr3uRhgTi38CzyyqVGk1gO1jkLjr2p+XVr7W4Z2F5oA4mt9MyPJSO+4xnZLI11ZB5
 Ggart9tYA20POv+gxWXoVPf8GMftWdyvB2R67feCVqZvqwlnCjfPeRuTrgUrt/HsSUXk
 jEPdG4bn2CbK/siKJlJ/73TeSfce6BkIjlbQpk6uX2RTgm0KUZJD7nIU75kN1ULrGLrn
 3bpCG6y8qabq/yKW1fPk35zVyU2AikcsunSWIfUYq+pTFet/1r8BQTEUJ7Ht3qtxWrQa
 4lWUoKtQtiV0a+qHv8mVsyWLSlRJFBXVbtq6dtJh5R6DywQZeOGkV670aECSc+l1Md2m
 YdMg==
X-Gm-Message-State: AOJu0YxMivvZCB6xLtyM2uHHrAlTtWtjsAFgvv/ALD55EQYJ6mojLCtF
 FH5qckqpqHYQPLbrUIszgDdChlwja9SJD6lWpsEyYQ==
X-Google-Smtp-Source: AGHT+IESm6/N8YWf2x6AO6+C3uopnGxWIwzz9B1HI/sBUe+JC0zfQ44tXgmXMlUq4BfPbyAj2sS4yXYLSVFDUKdvEBc=
X-Received: by 2002:a0d:ca86:0:b0:589:e66e:abe4 with SMTP id
 m128-20020a0dca86000000b00589e66eabe4mr1292069ywd.11.1695178783067; Tue, 19
 Sep 2023 19:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230823211059.1235147-1-sjg@chromium.org>
 <20230823211059.1235147-8-sjg@chromium.org>
 <CAEUhbmVLr+B7sU7MQjKjgbzNaB6XGB84p0RuPhKcHSDVytPQ-A@mail.gmail.com>
In-Reply-To: <CAEUhbmVLr+B7sU7MQjKjgbzNaB6XGB84p0RuPhKcHSDVytPQ-A@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Sep 2023 20:58:58 -0600
Message-ID: <CAPnjgZ3QVt_tddadLuiLLWEQzN1q4XwMb-2b_rv0j2nKG1tMjA@mail.gmail.com>
Subject: Re: [PATCH v4 07/20] x86: coreboot: Enable CONFIG_SYS_NS16550_MEM32
To: Bin Meng <bmeng.cn@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Bin,

On Tue, 19 Sept 2023 at 01:19, Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Simon,
>
> On Thu, Aug 24, 2023 at 5:11=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > The debug UART on modern machines uses a 32-bit wide transfer. Without
> > this, setting debug output causes a hang or no output. It is not obviou=
s
> > (when enabling CONFIG_DEBUG_UART) that this is needed.
> >
> > Enable 32-bit access to avoid this trap.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  configs/coreboot64_defconfig | 1 +
> >  configs/coreboot_defconfig   | 1 +
> >  2 files changed, 2 insertions(+)
> >
>
> Can we use CONFIG_NS16550_DYNAMIC?

We do actually use this for coreboot.

>
> Hardcode CONFIG_SYS_NS16550_MEM32 in the defconfig just works for one
> configuration like yours, but it fails on some other configurations,
> e.g.: IO port based ns16550.

This is for the debug UART which does not support CONFIG_NS16550_DYNAMIC

Regards,
Simon
