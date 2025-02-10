Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7923FC0219E
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 13:07:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCFFA807FE;
	Mon, 10 Feb 2025 14:07:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LO6oLyQw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8D0080821; Mon, 10 Feb 2025 14:07:31 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9448F803B5
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 14:07:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2f9f5caa37cso7496982a91.0
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 05:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739192848; x=1739797648; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HSIDGX5P17FiNXYwjdBjuc5gSsO8+speijNij0nsW9I=;
 b=LO6oLyQwr8R9YA6F+G+bTHrBudvxN+YB3ug6LXdKvfbFzf1lvkZwOsxGBKlu9QkmQW
 OR+647/Rz2GLo6X8ch/rco1bLeRpwhhVf3/RHixOKy+XRgdeyjowIUFHyEyhi41n8Xc1
 ak9CcizYZ8xbiChNEWeUgnSH8eTG+HyqM1624=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739192848; x=1739797648;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HSIDGX5P17FiNXYwjdBjuc5gSsO8+speijNij0nsW9I=;
 b=RcaQk93sn15v9RqE6yjJBNzjkZc97dVoScnQNdzjQAzqTCPZ3tjJ6CjP3cFdCumo11
 B+Qz2R9qBs6DeLjYIWtmHQWUndH6z7ySV5Lwi7mhy4xYH1Piyvo1D8GzKNaUd0WzA1m/
 N6m70LQ+Xm6jhlwq5yTelO1l+fBRbp6TDu4iqCozPuxxHcEPcg5V/fgzFMILhJn511iT
 idUB86Mjcle9D5QqXqfHAsKFnG+3GT2ZHII4xQfdZwTcHhUnI7fRhmrclAgI+/ASQmaJ
 a/MsGINN0fClZeIsfFK343264pZRmU2TQkRTaimIqlAzb+CHNbuIx23wly7iq+OGGPv1
 Z1pA==
X-Gm-Message-State: AOJu0YwanGanF0602l75iCCVlezihx3PlEJxSuVav8fGgYyDiNBxzeXg
 M1XaxxL7eV3UdpdkCFO/etCRqCZdOsQo1lFdUo9JUGXxkAD1+f4N9pevCuqMb/URA8WFMnk5lFr
 q8XBF5Tay+lk9vFhshB6qL/kRmdSmR9OIjwF+p66VFkjlQQI=
X-Gm-Gg: ASbGncvFsEiySUIlm9hi6O4TIprS8KTFipDp4tHnaq+TVbh8QVtrq8RtUdpvMDllie8
 uRZBT47JNbsnyp9zJWGkrKdDJjusIfXUDH7gFwN303wnUau5R9Ss0G4uIvGTkbJ7lwwednQdD+Q
 ==
X-Google-Smtp-Source: AGHT+IF5NQnzO9NuUvRjN+k3BaJ2V3gB0l5uvDmS2G0kK5SFoTa26O7L1G+AtraCXk+vL7mYVMY4SKxUjveNlAJdWh4=
X-Received: by 2002:a17:90b:4a09:b0:2fa:3f9f:26d6 with SMTP id
 98e67ed59e1d1-2fa3f9f290cmr15765651a91.4.1739192846717; Mon, 10 Feb 2025
 05:07:26 -0800 (PST)
MIME-Version: 1.0
References: <20250208171154.1305761-1-sjg@chromium.org>
 <20250208171154.1305761-2-sjg@chromium.org>
 <20250209180525.GR1233568@bill-the-cat>
In-Reply-To: <20250209180525.GR1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 10 Feb 2025 06:06:38 -0700
X-Gm-Features: AWEUYZlbs6HjKBPOTZtWEp_XsvO33nFIlcCnXC2ACEaXlmEQ9ZrQsoEnTCxMHnc
Message-ID: <CAFLszTirjS5kcqGc=NV1RF_7bHhhGPyKhnfV8WyV0H2y=GCW_A@mail.gmail.com>
Subject: Re: [PATCH v2 01/29] Makefile: Avoid using TEXT_BASE if not present
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>, 
 Masahiro Yamada <masahiroy@kernel.org>, Sumit Garg <sumit.garg@linaro.org>
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

On Sun, 9 Feb 2025 at 11:05, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Feb 08, 2025 at 10:11:21AM -0700, Simon Glass wrote:
> > This value is only available if CONFIG_HAVE_TEXT_BASE is enabled. Add
> > conditions to avoid introducing errors in link scripts when it is not.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Depend on CONFIG_EFI_APP instead
> > - Drop change to u-boot-elf rule
> >
> >  Makefile | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Makefile b/Makefile
> > index 2f7614191a1..f989c31073f 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1050,8 +1050,10 @@ LDFLAGS_u-boot += -z notext $(call ld-option,--apply-dynamic-relocs)
> >  LDFLAGS_u-boot += --build-id=none
> >
> >  ifeq ($(CONFIG_ARC)$(CONFIG_NIOS2)$(CONFIG_X86)$(CONFIG_XTENSA),)
> > +ifndef CONFIG_EFI_APP
> >  LDFLAGS_u-boot += -Ttext $(CONFIG_TEXT_BASE)
> >  endif
> > +endif
> >
> >  # make the checker run with the right architecture
> >  CHECKFLAGS += --arch=$(ARCH)
>
> We should just test for ifdef CONFIG_HAVE_TEXT_BASE as the second
> condition, that's already going to be never-true for EFI_APP.

Yes, that's what I had in v1.

The problem though is that the ARM app does have HAVE_TEXT_BASE
enabled at present.

The POSITION_INDEPENDENT thing is really a different feature.

Regards,
Simon
