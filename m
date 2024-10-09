Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE241CEE34F
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 21:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 404AE88D38;
	Wed,  9 Oct 2024 23:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BFjUbPDD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B52A788D5B; Wed,  9 Oct 2024 23:14:05 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 944AA88CAE
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 23:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cbcc2bd800so2571126d6.0
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 14:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728508442; x=1729113242; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ghvtyQccgVn17rEGgzmVL1TPZSwkQrky+4OpnjbxUr0=;
 b=BFjUbPDD2qsB7nQVMWaExeICMa/Fx7iZ1Q9CuOYRsEYpqKsafSBCf1t7JVCYYeUo1m
 WKuf1eTegeFk46j32ow7emZEpmqZMtEVLB72EAowSZHoTyZeDSMcI0C4Rfmg2RnWP3vM
 2nF/8iKWxdkX1b3rI40yErCOvI9LfvZJKaeus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728508442; x=1729113242;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ghvtyQccgVn17rEGgzmVL1TPZSwkQrky+4OpnjbxUr0=;
 b=PfrqHEWidoSj0B9nui+8U/L9X19PLogfZi0dDcBtUbdIr80oJE1809g4/KuA3tatMd
 kcnxhNx+GcitAdIPQj/qFbg6MoKYIaekrCY/FWv0ZtXGUrfX0rkAKBSi24Of17DGW6gu
 RNPTeveCzpejfHtSY3Ke3gWkckK2cOTIIzbj3KnQV7shhm69w7q9PgN5awmU5IHJbArC
 7QuDnChexwFkkJB+Be+MezuaVUtgRkGSHVnZHaVB+5lY6v/1tqWsAdjBqx8cA/uKW7PG
 s6l11EAeJgcULquHgEFUL1iW2mrxLvdOOvi6ynfEoxuUmlfK0wqaNfg9vAz9H4ARGs9V
 oUzg==
X-Gm-Message-State: AOJu0Yx+BI66h+lmFvc4hoOkmxpkmqHSVSKafNcaglvKyzbZYJmR0hgP
 DOSjt+JdnXzYhRZU1qRAuAxPqtTw+9rELlbu5EUvtkqqzhbAHnAK/D7Rr7dtFvIAAQZSZYkjZ71
 iKPLeVneobaIiVCJMDDgmvn38BN7/qWkCP6wz
X-Google-Smtp-Source: AGHT+IGx0IneXM30EUXKb0Pj9P3EXI5cD+ZHdl+7ybZmSVAXx4FMmpPcjT43EToFyVzA03xqp6dbvhTOrpxbqfNmHjc=
X-Received: by 2002:a05:6214:5c02:b0:6cb:d3e2:ea0d with SMTP id
 6a1803df08f44-6cbe522d3cbmr14976106d6.12.1728508442482; Wed, 09 Oct 2024
 14:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20241003212802.3810-1-ravi@prevas.dk>
 <20241003212802.3810-3-ravi@prevas.dk>
 <CAFLszTiiCgKGrn2vuMSfrg9Et=Oi+VcEEycQjYK7qS7zAQEesA@mail.gmail.com>
 <875xq15yaq.fsf@prevas.dk>
In-Reply-To: <875xq15yaq.fsf@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 9 Oct 2024 15:13:51 -0600
Message-ID: <CAFLszTgDUaiwUda9bf4rvxGO8sWgX9b0bsPZS+4jGz9MZ2eWTA@mail.gmail.com>
Subject: Re: [PATCH 02/13] cyclic: introduce u-boot/schedule.h
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
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

Hi Rasmus,

On Wed, 9 Oct 2024 at 05:08, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> Simon Glass <sjg@chromium.org> writes:
>
> > On Thu, 3 Oct 2024 at 15:28, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> >>  common/cyclic.c           |  1 +
> >>  include/cyclic.h          | 12 +-----------
> >>  include/u-boot/schedule.h | 24 ++++++++++++++++++++++++
> >>  3 files changed, 26 insertions(+), 11 deletions(-)
> >>  create mode 100644 include/u-boot/schedule.h
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > But could it just be include/schedule.h ?
>
> I think the last paragraph in the commit message should answer that:
>
> >> Testing of later patches that explicitly include <schedule.h> when
> >> schedule() is used revealed a problem with host tool build on win32,
> >> which apparently picked up a host <schedule.h>. To avoid that problem,
> >> put the new header in include/u-boot/ and hence make the include
> >> statements say <u-boot/schedule.h>.
>
> So I tried that at first, and it worked fine for all my local builds,
> but the CI told me it couldn't. I can try to find the old github PR
> where I got the CI to tell me this (it's months ago I started doing
> this), but I don't know if the azure logs still exist.

Ah yes, thanks.

Regards,
Simon
