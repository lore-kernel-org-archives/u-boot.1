Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69191CCF9E5
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 00:48:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D149F82C7F;
	Mon, 27 Oct 2025 01:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lTAya6la";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92D38832AD; Mon, 27 Oct 2025 01:48:53 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D61E980107
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 01:48:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-7836853a0d6so70363077b3.1
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 17:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761526130; x=1762130930; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tmk0Q/b9ZouYJUcN4eAX+qAwa8V7Hl9LuVC+q1NY6WA=;
 b=lTAya6lai5hd7L3cfJ2kqBwRRdJUvlg5lyLNH70X2q2Ims5knBnZLoSRVBPYF14ZS5
 3wQmiymLBjapgxB3QTwsnIMusaJoAgXcP9/4H5lJZhYLQxXCK8q8OADVRt6GiCKQw62M
 8bZpjSPVhWewAS9acst01YkYLVGNabAACfNaNa4Wzd2Q9iOs73FlZ0cPfHFD7A8iwnCV
 thgiWt+POJO8sLAtbJxTLbcwxOIrUlksSja/oKK1hhmouBQHjuExxFqflW6+PUHOHUNW
 xYO4GCL9wB7qwjaOcq7+QCviDFVDehtN16/rUr72PrVbe+kySAPc1O+d8BGkKT+XZmRF
 6PFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761526130; x=1762130930;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tmk0Q/b9ZouYJUcN4eAX+qAwa8V7Hl9LuVC+q1NY6WA=;
 b=PyDiFoPIVt8kMYO1rXWB4zOMeioK2ZcnENT+MkwzFqtajsh+uG5Cf5ZSbyI9f/JBZ/
 vLu/48+KeVvMEhlN1LJ6qxYpNr2qiZT3CBPBNKWuvq0Gi+dLaEiy6z4GYOaEH0M3UIGu
 ZnI5LDXfKDNdWggjm1d79+l3a34HYh6kj/iLvBxxwZEiIo2IoLTeTmSWN0I2o4fOObEq
 ZHwAOyRy4+OeLP8wILpxz6I36EMFERkMI92uqFeRnVsCpLgNoS+jfv3OwEtf+ao/alpn
 VQI4a/gmzh1H4jO2C4EmbS/4wpVACcxnLKxgY2ve/G1vVj7+z1jVDc5nfohYbZ5Kf/6I
 in/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzgPyaMDMf4EYkKRvIRWJ1/fWTMYWg+Hj03OR0PvnwCCMXiYR/53UA+8OFUSbd/Ac8XER9xx4=@lists.denx.de
X-Gm-Message-State: AOJu0Yy02ZwxC/dJ5hE1/+5Fr62HC6oJlA28zunRVvUlDjJnm6OpfB81
 q5INj/t6ZfwjlFISxbi833QcBEcOTIN+IIkop91zYEQ/J6icZrY/lDCfEeaYIdmHkVLRGoTe17O
 N8WtpB1vFRvZ421RCXceDKuS7y26C1uUH3/E7tyPIBw==
X-Gm-Gg: ASbGncvGoAX+wJWXq2a+tuJdqb20PD0L0n+lqGEHF3n7hktI4sGxeeXW4xl4GzV/NTM
 z5CCHyTr+dmeFKkltlGe+ICKa1tRwqGnUioKT/FjMcW9qV5XC78+EzFrzyx6R1EKyKIjUO4gsJC
 XIekLkBJ5KbPxfwbwEQXE+Nukpy0EmKuSoFgXqOjY9V3HTSg7Nzhdg9PPutcuLxY0HaU2/cyhpr
 OQ2aAQBdH+0KdqMUSrMXGJcOob4nVidMRwRKGB5g3vC5Qiysvc1SgTm3LeCVSK6/0U6FpOFmrEs
 NhanEg3LX4d/ZhXR8X0=
X-Google-Smtp-Source: AGHT+IHRo55ldyoix8iwdj7ovPNNtxJP2dr6Zklr9+r7FEOHdW0JUdS3lw3KLrFokSi+k7XgaFGwTHdTFDay5QxX4m4=
X-Received: by 2002:a05:690c:724a:b0:781:4c5a:8d35 with SMTP id
 00721157ae682-785dd516655mr80839677b3.3.1761526129624; Sun, 26 Oct 2025
 17:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20251027002458.16741-1-semen.protsenko@linaro.org>
 <CAPLW+4=EFer-nSnh-yKbAHU9o_GG2bJCL=KEu6ONuhr6+1RODg@mail.gmail.com>
In-Reply-To: <CAPLW+4=EFer-nSnh-yKbAHU9o_GG2bJCL=KEu6ONuhr6+1RODg@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Sun, 26 Oct 2025 19:48:38 -0500
X-Gm-Features: AWmQ_bnktsYJm39f9RdtX5TLt-svBMvFBS11Z6Z2HtjRKhgqAxUUWC2fHF94AfI
Message-ID: <CAPLW+4m-CDQfm+Hi_Dy8D9NxmMCJNDXDpg_1QYg0q+1Hu1JSmA@mail.gmail.com>
Subject: Re: [PATCH] autoboot: Fix inconsistent countdown output
To: Tom Rini <trini@konsulko.com>
Cc: David Zang <davidzangcs@gmail.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
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

On Sun, Oct 26, 2025 at 7:37=E2=80=AFPM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> On Sun, Oct 26, 2025 at 7:24=E2=80=AFPM Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
> >
> > Commit 5f70be08b015 ("Fix autoboot countdown printing wrong") introduce=
s
> > inconsistency in how the countdown is displayed. For example, in case
> > when BOOTDELAY=3D5, the next output is observed during the boot:
> >
> >     Hit any key to stop autoboot:  5
> >     Hit any key to stop autoboot: 4
> >     Hit any key to stop autoboot: 3
> >
> > That happens due to different printf format (%2d vs %1d). Moreover, the
> > mentioned commit fails to handle the case when the user is holding some
> > key before the countdown is shown. E.g. if BOOTDELAY=3D101, the next
> > malformed output is being produced:
> >
> >     Hit any key to stop autoboot: 1 0
> >
> > That's because the fast path code wasn't modified accordingly, and stil=
l
> > tries to erase the number using '\b\b\b' format.
> >
> > Fix both issues by introducing a dedicated routine for printing the
> > whole countdown line.
> >
> > Fixes: 5f70be08b015 ("Fix autoboot countdown printing wrong")
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
>

+ Heinrich, Simon

Also, I remember when I suggested using ANSI escape codes back in
2018, Wolfgang wasn't very happy about that [1]. But I noticed those
being used in cmd/bootmenu.c and common/menu.c nowadays. What's our
stance on this matter currently?

Just a thought: if we don't want to use ANSI escape codes, we can
simply get back to using \b and add more spaces in the end of the line
to account for large possible countdown values like 100 or 1000. Any
thoughts?

Thanks!

[1] https://lore.kernel.org/u-boot/20180719194321.16321240175@gemini.denx.d=
e/
