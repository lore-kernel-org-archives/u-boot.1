Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E921C001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 18:39:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87CC38699C;
	Tue, 15 Aug 2023 20:39:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Cmbdp/A8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17161869AD; Tue, 15 Aug 2023 20:39:52 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75F7986995
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 20:39:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5255ce77d70so3670861a12.0
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 11:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692124789; x=1692729589;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9p1nsXJfUKPPaJcU+CDBB3SPkYAt0SpZfmCeoRcZcYc=;
 b=Cmbdp/A8g/9joQ0tqXEnZm7HaViDkh2mSVn1b30AGR37IFGC+940MGCyCInNa1ytz9
 kT/kIm7amS0dvjCiYSoGobYgnISB8fO5ApzazfbhBhBlcx2gVT21mpaFt29ZNPHmHyIJ
 lgpkRVT19F/UPSh2YiSFxD+AiXtboctEnumvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692124789; x=1692729589;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9p1nsXJfUKPPaJcU+CDBB3SPkYAt0SpZfmCeoRcZcYc=;
 b=O+FcRUGtcXR2Yw0bKJ9e8p0HFC9jkv13anQ3XZg+VwD9PaSwyBgrxV41KUrHPragbk
 KDdGyivOIsFjg0UIQcCNNyB9zfEF+QbuxkHFrT81UKkWTm0w+TSL7OnRa8MhkilIce86
 qixY4P5Anp54I92+rGvPOcT2UlS9YsM7zoZ5wcK9tcOmZ8DgEz7u80X7LApTgJZaaCme
 zOZ5IfI33eqmE56Bs8ki/iueh9hfaRSsAmXUldNh9T99zmCcECwV1YlrhfRFgLs1tZzV
 zh4hd/YkJn3ZvPW0QCTOGG09lLlz5RnL2k9fVTqgBb8Ysxrf3rJFk68aZv2RA51RP0QS
 RAYw==
X-Gm-Message-State: AOJu0YwyNmCu/9vxth70Wb95c8X+XnRt3wZ1Oq48uT+Lqow5zUb4Nmev
 aD4zwFrHUKtmuQqGVJ8Skmfy1DFFTgfN7tcOznf6W5QHcssLPJn9Nro=
X-Google-Smtp-Source: AGHT+IGK/7zg4tHAWpfNqrgvBkqeznlrcLVG5aygr/NUWfmaC3dpz3DAD91w7c6iavfuUYhnCuv4FC8/SAZfqS1jmz0=
X-Received: by 2002:a17:907:7883:b0:99b:e464:bf49 with SMTP id
 ku3-20020a170907788300b0099be464bf49mr10737574ejc.51.1692124788829; Tue, 15
 Aug 2023 11:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230803185957.1769543-1-sjg@chromium.org>
 <20230815144234.GJ3630934@bill-the-cat>
In-Reply-To: <20230815144234.GJ3630934@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 15 Aug 2023 12:39:37 -0600
Message-ID: <CAPnjgZ0C3Qpauto980cmPZoBkem_OVUOzusxRfRgDkJQeVOgJA@mail.gmail.com>
Subject: Re: [PATCH] buildman: Allow more results while building
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Tue, 15 Aug 2023 at 08:42, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 03, 2023 at 12:59:55PM -0600, Simon Glass wrote:
>
> > The -v option enables display of build results while building, instead of
> > needing to do a separate summary step later (or in another terminal). But
> > this resets the build results after each commit, so that all errors are
> > reported fresh, without trying to diff them against previous errors
> > already shown.
> >
> > Drop this reset, as an experiment, so see if this is useful.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  tools/buildman/builder.py | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/tools/buildman/builder.py b/tools/buildman/builder.py
> > index ecbd368c47a..5ee2b5959b2 100644
> > --- a/tools/buildman/builder.py
> > +++ b/tools/buildman/builder.py
> > @@ -536,7 +536,6 @@ class Builder:
> >              if self._verbose:
> >                  terminal.print_clear()
> >                  boards_selected = {target : result.brd}
> > -                self.reset_result_summary(boards_selected)
> >                  self.produce_result_summary(result.commit_upto, self.commits,
> >                                            boards_selected)
> >          else:
>
> Nope, this doesn't change any of the output I see in how I usually do my
> world builds.

For me it allows using -S and -B during the build phase, and seeing some output.

However, the patch is not correct...it is just a concept. I should
have marked it as RFC.

Regards,
Simon
