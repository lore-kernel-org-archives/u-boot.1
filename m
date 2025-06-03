Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6DCC5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 21:00:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8A93822D7;
	Tue,  3 Jun 2025 23:00:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wNvR5XCF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 539208283E; Tue,  3 Jun 2025 23:00:53 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0164082103
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 23:00:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-b1f7357b5b6so3881642a12.0
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 14:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748984449; x=1749589249; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lYhR7C1TQUOQF5T+YMeW5uSOlbwk0uTVakAcHjLx8D8=;
 b=wNvR5XCFzFSQhCMpvPkRye5vY5z60NWHkFcnuvVqVDMGPeAZma4YCdTGQgmUEZ2eYo
 RfciqsHTVvgNnfd9JybM5wrE+vjNN0BixVVhPqDTajvfQ2GCafZx8o48Bmx/trLL0Z9m
 rnqjla5H68g3+b0ddELVMqmQuvKEr3aIQCCErRM7464Fu9PFuGNUZRvVVCy7oSB3FtTQ
 kQCewnTHaDphm1oZi0XZYa+PwCqImeOp3kqcmokEkH9JWtk5pVEFkqb/AtSEnQdQk9M2
 ZwB2PyDqcr1vHWzS/RLLUbRVwC0qCJhCnrRoIsyYUGvQVdx4WODdEvc6Op8Fyy2tRfUV
 y1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748984449; x=1749589249;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lYhR7C1TQUOQF5T+YMeW5uSOlbwk0uTVakAcHjLx8D8=;
 b=D9HH+DhLrihO2AqIeJuHKC6P1CctqNXhCMwtRT1pj6mBhtWC9WptrNBsMIpcX+p/+p
 pOM5/5zfQEJCsmGdCedZ2MNqfdNcMkM+rJoOLReKBLt4rIoeN+QwpXT/pvUuDTovNjCI
 kDgyrqWsUuZvnPnsAxmdgs6lo4sIQ64LeM1cCpSZB0Y881Wr1VQR+3xWb7ZOaPJrjHMs
 px/tB0c0Zcjf/L7nSkYJDCdi7FfeXFFI1xgwxLV913mKRjhzZum8EW/RkRvUfRlDOjOM
 sL2ZaXCVlIf0i/5N+uuNDQ5feFnL+lIe0QgbC5O6DH6LKfrVbYgbX8ha7YaPiUl4sRM5
 slkA==
X-Gm-Message-State: AOJu0YxPGCzBpXkmzmzFKrXA8e3WI9qBYV+LLZxkveb/uHde8nOkzWpI
 vcW/Sr5ehgY34ef+JyHRi2Ar/yumXCjeqM/ZSHpGrmCqkpdVZ9v0iBws2DSsgsITmuVDZd8JGyj
 9VPVelwH9bMRfyoxvN5Q5p7qo4icZSMjTAiy0X915XA==
X-Gm-Gg: ASbGncsCTHnDGCYfW2tnZ077ohSyJHva1RuybC3sfAF6KwwOgeyMAEblj+IEub9AvkU
 PVRNzIyUaezq1u6cKTKe6bJkqcFCeMVMQH0THoReTsGwcL6Odgpaf5gXVwZZFCaZ+49RNcyVo7P
 U+c/p4wKM1R7/qJfd7FrsGGjyMUdQTyL9o+w==
X-Google-Smtp-Source: AGHT+IERVFFk8zD9bPHRsFQjEXUAyMX8OE7vR+lM8r/wnl4+48xct7bmhGrsIbmiNnoa45pbzayAlpuI3y4q1litQdU=
X-Received: by 2002:a17:90b:35c5:b0:311:be51:bdf8 with SMTP id
 98e67ed59e1d1-3130cd6d85emr748574a91.3.1748984444499; Tue, 03 Jun 2025
 14:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250603151401.1709532-1-raymond.mao@linaro.org>
 <20250603154748.GG1382132@bill-the-cat>
 <CAEfUkU+7BaEcmQ1NL2TSMLpHYQt1DhPLKZPtkB_Fd6u_Oq4qEA@mail.gmail.com>
 <20250603192345.GL1382132@bill-the-cat>
In-Reply-To: <20250603192345.GL1382132@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 3 Jun 2025 17:00:33 -0400
X-Gm-Features: AX0GCFuShcZSm-VgcwH_GwOpD2s3GCprvAhwhh1qTT8CHYN5bGEt3FKSzxx4iYw
Message-ID: <CAEfUkULmB2PckAKf+euT8Mj3ehirw-TjmNT20-+AfVy6SpRB=Q@mail.gmail.com>
Subject: Re: [PATCH] sandbox: solve undefined reference to pthread_kill symbol
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Jonathan Humphreys <j-humphreys@ti.com>, Sam Edwards <cfsworks@gmail.com>, 
 Prasad Kummari <prasad.kummari@amd.com>
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

Hi Tom,

On Tue, 3 Jun 2025 at 15:23, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Jun 03, 2025 at 02:00:23PM -0400, Raymond Mao wrote:
> > Hi Tom,
> >
> > On Tue, 3 Jun 2025 at 11:47, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Jun 03, 2025 at 08:13:58AM -0700, Raymond Mao wrote:
> > >
> > > > This patch is to solve the sandbox building error:
> > > > $ make O=build-sandbox -s sandbox_defconfig
> > > > $ make O=build-sandbox -s -j2
> > > > /usr/bin/ld: /tmp/u-boot.27rzOu.ltrans58.ltrans.o: undefined reference to symbol 'pthread_kill@@GLIBC_2.2.5'
> > > > /usr/bin/ld: /lib/x86_64-linux-gnu/libpthread.so.0: error adding symbols: DSO missing from command line
> > > > collect2: error: ld returned 1 exit status
> > > > [...]
> > > >
> > > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > > ---
> > > >  arch/sandbox/config.mk | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > OK, but how do you get this failure to start with? What host?
> > It failed when I started any sandbox unit test like:
> > ./test/py/test.py --bd sandbox --build -k <any_test>
> > My local host: Ubuntu v20.04, x86_64
>
> We don't see that normally, is there something odd about your compilers?
> This is the kind of thing which should be failing everywhere, but isn't.
> Thanks.
>
This failure occured in my host since v2025.07-rc1, but with the same
host, same setup and same instructions it worked fine in v2025.04-rc5.
Seems that some impacts were introduced during v2025.04-rc5 ~
v2025.07-rc1, which might be worth investigating.

Regards,
Raymond

> --
> Tom
