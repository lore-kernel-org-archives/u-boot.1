Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E542D3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:15:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B84289166;
	Fri, 18 Oct 2024 01:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P/ylfOQA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64CE3890FE; Fri, 18 Oct 2024 01:12:02 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01F9089130
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:12:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b153047b29so53248085a.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206719; x=1729811519; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Te8LApd2rkARF3c1xOMTNgun7VEgAY9ddszDvHLpDy8=;
 b=P/ylfOQA33vFuzCa/WvhCff9vof04RvtW88Rru5hV/lJqnSibvk0F9h3pr8q+MaI5P
 +/pH+DfSHIaJZKmf85jWM8XcnVXmKWiTzDuJ2zfgaKJMPfcvVy8RWeVCB1J01wN2ACC7
 I6KWCVqyc5M1C/LNe1xF44kuZemmBfQVIOSxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206719; x=1729811519;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Te8LApd2rkARF3c1xOMTNgun7VEgAY9ddszDvHLpDy8=;
 b=QCHXWJ9Ln3+sriWCEa7hzoJQbF0t56Enbj3nT0gSfv9dJ0phL1kbBZ5pqDZ8lU+zD3
 F95P4y7jdA70KAIko314XfA/M/Y4eqYrtbeCA1XytvwekiEa11DWa6thPN8MLVskJIry
 eNcLwPxM5qL+6FWtM/ZLE1E3VUu8SIhiq0oUqpnYJoA0R3SI5CD7jedSicDQjrQVp8rD
 s2Q0FGxdzEMkwv0u1nYWP+YbdsoaoynFTy04wRZRHAi18JNBcpryj8603kQGG387qI2A
 j26niUr+RArm04TuRsgQU/tkmWudTls1lQMgcTabG47zoH4yvjbEiEYHC9IWNJRbYWvI
 b8hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo5DQ27CZclhFGWnyv2ZYKJaloP9Hjml41cWxlcEs/5CNGjvwgE9yowNgNjDvyyBItJK9hsJ0=@lists.denx.de
X-Gm-Message-State: AOJu0YzaZ0/dIV2vTXJMhXZXZ2PMzZpDkY+1XyTek6a+h9LKIuU4QM5o
 3cKz8CsyVp2ymFvTXJF57TcGyCU31nk24ZIVQlo85cnWfA3+jmbHxNflEzFxOYEjEh0j8zlG8Eg
 jcPUX+YQ1CbzV+7F2bXZKhtQHOP7YWpr4+2DS
X-Google-Smtp-Source: AGHT+IEpiAzm45F3zwpDZYeken4QPyezreJPRx7+5X4HUQLE/QDpRPmRjPReYT4BxYInra178nKGmNZRC7uTENqLgaQ=
X-Received: by 2002:a05:6214:3c86:b0:6cb:c487:24b5 with SMTP id
 6a1803df08f44-6cde15f1700mr7948936d6.32.1729206718987; Thu, 17 Oct 2024
 16:11:58 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:11:57 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszThLE=PADovhbDTH9v+0XkGygBNGtAFrOnyte1FcUhpGyg@mail.gmail.com>
References: <CAFLszThLE=PADovhbDTH9v+0XkGygBNGtAFrOnyte1FcUhpGyg@mail.gmail.com>
 <20240925104501.44457-1-sjg@chromium.org>
 <478ac7c2-88cd-4880-88da-2c786930ad2c@gmx.de>
Date: Thu, 17 Oct 2024 16:11:57 -0700
X-Google-Sender-Auth: -PEzlLXPfdieP3JXbV1wnkdrNjw
Message-ID: <CAFLszThD-gOf1UqOLP2K9zWvLT=GjvsVZzDEi1F1SHGd-kVkiA@mail.gmail.com>
Subject: Re: [PATCH] sandbox_spl: Restrict use of UPL when not enabled
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Wed, 25 Sept 2024 at 13:55, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 25.09.24 12:44, Simon Glass wrote:
> > With sandbox_spl we want to use the file-based boot in CI, so that this
> > flow is tested. The recent UPL change enabled booting via that method,
> > thus overriding the file-based boot.
> >
> > Correct this by using UPL only when the --upl flag is given.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Fixes: 91fde8e1764 ("sandbox: Add an SPL loader for UPL")
> > ---
> >
> >   arch/sandbox/cpu/spl.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
Applied to u-boot-dm, thanks!
