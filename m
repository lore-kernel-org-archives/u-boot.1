Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD988C27C53
	for <u-boot@archiver.kernel.org>; Sat, 22 Jun 2024 14:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CAAE87A09;
	Sat, 22 Jun 2024 16:38:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N9BWBrzt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18F6387D8E; Sat, 22 Jun 2024 16:38:35 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99A5C87923
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 16:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2c7b14bb4a5so2087663a91.0
 for <u-boot@lists.denx.de>; Sat, 22 Jun 2024 07:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719067111; x=1719671911; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PGQyRXvw17xDShpDmgSmmPWCvrl6GTxjQUrOwmvF8og=;
 b=N9BWBrztptFUvJ2EWQmwPp4YShneAwnSaeGPSFhZgCwRqt+YrMDABA/iay/09JZnG7
 5gF0YGx5t+gjhelPaay6na4zTfjrrxzPEQbnDIS2QXs3eaBTBwTtLE2Tn768XOD8Xrv1
 475SUVP5MDOychacqindVupoIpBS6ZK6d/hunywKoYAvqV7vrouskMyGmNb5nP3EVcjY
 ZlPfPuz0qObfRJgRROsWBLCktPeR+sOs989VUfxAA0P27wNm5iXpT4hdBFJpswHCyAtQ
 MU8sSHUu/BrXoQg0D2tLJ5BYegBOnSvJ2JQqGtmno/MABOloqqbpFMxzqz6QtxFES1yF
 aJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719067111; x=1719671911;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PGQyRXvw17xDShpDmgSmmPWCvrl6GTxjQUrOwmvF8og=;
 b=he79q/k9eKXSItMOnl27kk6/XgHYkVYY3Ii75kcoNbSA20UyTzRhxrwGNKo4UXk9bZ
 fvdiyCp+IUFL9i+vDWBgee+0zhZExfUcECGhkT5hSEan5nRxScgPx0ep4ze9nb9yQWXx
 gY4MuwpZ0H1fRLteDx0gAN2Jw2URlm7/eRB/5HgXDPf5Ugfj/1GXQSUdawyj7MzsW1Ng
 miVII21dpINe1/cWgm3b6AV0RMMiLT47fCsA1X32aYBgaa7S7R1XKuGAf4dhLDmmLJV4
 nVNPz2u9aT4fl/Sq8+M3Pmp0GtKfC2kYCWGwFllXW2RKx0Xk6AaJ2mHgV2Y3/Lk9LXMV
 qGjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUogINSXDLntUORa7+cv+qpLV5BDWuM1rYVrbESSlov8THBp2ckbDS3oKL0zyUHbsDZ6V8ln/yaw6Crk0uQ4vgE7GwSvw==
X-Gm-Message-State: AOJu0YwDIRgzkPSHhWa4knQWI6DUAyBP/kjozJXLWZlQiJA4WX58lOP8
 0+v4A8U1p+TLatG/V84sAcVU88VddN7YnASXgicwOb5fRzHILp1S8tsUomgFSS62GmjqiRICzbY
 GqDBTW3p2tUHTnID0TCNCf4DwmfvOOyZM6lNwLsM3EDv4B4wrsSbhMA==
X-Google-Smtp-Source: AGHT+IEZA58SJlsVorHOV0M6rs1PHFuKsFo+VhRy0IPwF1/Dy5QsqcL2HcLPf6ymHST7ti6rxGo74AkY7UXCxJxz9f4=
X-Received: by 2002:a17:90a:d48d:b0:2c2:f0a7:f8be with SMTP id
 98e67ed59e1d1-2c849bf8334mr1993380a91.9.1719067110864; Sat, 22 Jun 2024
 07:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240620191631.28811-1-ilias.apalodimas@linaro.org>
 <CAC_iWjKafGj7wMtWAD0G_g-ArfQBoL_22oWjo69jjzjOvC030g@mail.gmail.com>
In-Reply-To: <CAC_iWjKafGj7wMtWAD0G_g-ArfQBoL_22oWjo69jjzjOvC030g@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 22 Jun 2024 17:37:54 +0300
Message-ID: <CAC_iWjK7_3VYezYO8gfFerWWjaCiA1X4SNZDq+fObCorKn1RZA@mail.gmail.com>
Subject: Re: [PATCH 1/2] tpm: Fix return code, if the eventlog buffer is full
To: xypron.glpk@gmx.de
Cc: Tom Rini <trini@konsulko.com>, Eddie James <eajames@linux.ibm.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de
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

On Thu, 20 Jun 2024 at 22:19, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 20 Jun 2024 at 22:16, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > We currently return 'No space left on device' if the eventlong buffer
> > we allocated is not enough. On a similar check later on that function
> > during the call to tcg2_log_init() we return 'No buffer space
> > available'. So switch both error codes to -ENOBUFS since we are always
> > checking a buffer and not a device.
> >
> > Fixes: 97707f12fdab ("tpm: Support boot measurements")
>
> and now I wonder why checkpatch didn't warn on this. There's a
> 'commit' missing after the Fixes tag. Sorry!
>
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  lib/tpm-v2.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> > index a67daed2f3c1..91526af33acb 100644
> > --- a/lib/tpm-v2.c
> > +++ b/lib/tpm-v2.c
> > @@ -554,7 +554,7 @@ int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
> >                 if (elog->log_size) {
> >                         if (log.found) {
> >                                 if (elog->log_size < log.log_position)
> > -                                       return -ENOSPC;
> > +                                       return -ENOBUFS;
> >
> >                                 /*
> >                                  * Copy the discovered log into the user buffer
> > --
> > 2.45.2
> >

This is now included in
https://lore.kernel.org/u-boot/20240622143601.187723-1-ilias.apalodimas@linaro.org/T/#t

Cheers
/Ilias
