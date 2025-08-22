Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F403CCA0EFC
	for <u-boot@archiver.kernel.org>; Fri, 22 Aug 2025 12:13:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C46E280422;
	Fri, 22 Aug 2025 14:13:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hifmaVbw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F92180548; Fri, 22 Aug 2025 14:13:02 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B00B8006D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 14:13:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-61c26f3cf6fso601451a12.1
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 05:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755864780; x=1756469580; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QUqcP/z8Mr0E2fxIiFIBIxYC6WZkKoVKKm++TRtnEu8=;
 b=hifmaVbwg/9CcxQF9ZUtfeu7kyK11jKpXmhE6dlXohO7Mb3/6Tu3TnURhj82xCpmqI
 zV5Uic2r6xjzdxCOXiYAXrNmOYG2H99/v64RnSr+o+Qh5J2GmmR28JbvcZTm6qycZVbx
 tPcf/VQomnBnLXWCh5K5mi+H9tg62Z8z75rs8itZ2sCoDMM+P9FGEHsb3LzkDIqc8oaY
 28VSUNzmvvbd++aONj+nd4i4FMCfakxH8MG6YTCKPx9ItEbrwtvhikrQLrUR71SnEWpu
 MjyaTG9EJNwUziUGJTyyeBpRajYwlYD5BpHFyJ+jiFlLCCS5cBra3GxSJ65uXqIxKhAx
 Gkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755864780; x=1756469580;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QUqcP/z8Mr0E2fxIiFIBIxYC6WZkKoVKKm++TRtnEu8=;
 b=iF/5gUqSacnpRRRmbmlkfpDYxVO4MJPcqsyG6cquhNbhGLhAMW8NNuet73TaXN87J7
 lM+YlS4jHUG/hq7QRHW2kcNCFVC+ZtBwoPs/fCsQMk3Aig4/QvO+zXP/BE1Ie4ASwEet
 iNSLoACNtBGA+fG0QH08XrWwQE9UurjPUMQmxaW/Wia82hKxTWN8kmf/RVP4ffch9oxG
 4l+yVMeySlmCKzmu8ZwvZ6MEWB1LKcj6pdFpiCGYWB48reN7OqgM39VCcShjPuZyJXJ5
 cRKxcRTc2JBnFqDDSuacZK+lEEiSsDT8/7zvKxFSwH5yyH0cjSplAf7Z0e6pbbpViZx+
 ghKg==
X-Gm-Message-State: AOJu0Yxxbz/1WlCpuEjYE/Yo7icqOT2gA7flcNBTRNXK9y5+TJzRvqO0
 FncPIlRtSk0Wx8nlwNGiyRA1pB2rpT8R/De5GuEeYtXjbkBmoLathNAMmVMtKbhV1yJWmCEstkM
 W2ExfV/OiBNl1gZEpivGTV3XzbqG5hF0=
X-Gm-Gg: ASbGncvHFgNNaTRVFmvnDmd9irCSpHlDFE5K4pIzLrim9G3O1EtTo7SxlJgrC388cXy
 GcPnWo7IvD7GplnM5o/l24S1UWMnRXqwTSYIzC4JnLZLjkWfCBzvR6LCSDl/cGyT/VKTrAVJg4F
 u3Umg7sKR4hbK04RwARHHLY6zDlLbom5Kf1UFbRsedyizXG1QvQr5tGucYddFKnLdSnp010rVrz
 U22w+CCgkdYiiK/OU/A96ZSzH0P28DxKf9fzfQyeOvCVc4suA==
X-Google-Smtp-Source: AGHT+IECOh6bjyvlLT8gXriPOwqnK614h30ROpQnTDVnYLvWxAwrKih7h0KJwjuGSXQw0yrN+u33v1J2JHQ1Qq9x1Ls=
X-Received: by 2002:a05:6402:2801:b0:615:c767:5b9e with SMTP id
 4fb4d7f45d1cf-61c1b6e4a43mr2248740a12.20.1755864779469; Fri, 22 Aug 2025
 05:12:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250810233742.51902-1-adrianocarvalho.pt@gmail.com>
 <20250810233742.51902-10-adrianocarvalho.pt@gmail.com>
 <e69d0df0-aadd-409f-82a7-b65a5b764a48@gmx.de>
In-Reply-To: <e69d0df0-aadd-409f-82a7-b65a5b764a48@gmx.de>
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Date: Fri, 22 Aug 2025 13:12:47 +0100
X-Gm-Features: Ac12FXyhqMZZOVM3CwvQj00OgwKVl1ouNcT2Uy7u37ivk1tGAHDh6Z47W2XVizc
Message-ID: <CACAHuLAncZVsUdYxPYDYjAOdHpzHYausUpsijM_1L3iJ_FDfsQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] doc: Use a long dash instead in
 tools/buildman/buildman.rst
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
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

On Wed, 20 Aug 2025 at 21:32, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11.08.25 01:37, Adriano Carvalho wrote:
> > Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
> > ---
> >   tools/buildman/buildman.rst | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/buildman/buildman.rst b/tools/buildman/buildman.rst
> > index 7944adcd867..3e41d6ec304 100644
> > --- a/tools/buildman/buildman.rst
> > +++ b/tools/buildman/buildman.rst
> > @@ -1360,7 +1360,7 @@ Using boards.cfg
> >   This file is no-longer needed by buildman but it is still generated in the
> >   working directory. This helps avoid a delay on every build, since scanning all
> >   the Kconfig files takes a few seconds. Use the ``-R <filename>`` flag to force
> > -regeneration of the file - in that case buildman exits after writing the file
> > +regeneration of the file -- in that case buildman exits after writing the file
>
> Please, use the Unicode character, that you want to display, e.g. U+2014
> (em dash), or U+2013 (en dash). This way readers of the raw rst file
> will not be irritated and the rendering in HTML will not depend on the
> smartquotes_action setting.
>
> But to be honest I don't see great value in this typography change.
>
> Best regards
>
> Heinrich
>
> >   with exit code 2 if there was an error in the maintainer files. To use the
> >   default filename, use a hyphen, i.e. `-R -`.
> >
>

In the build directory (+ tools/buildman/buildman.rst), this style of
writing is used only once (here). With a dash, it looks sloppy on the
browser.

What about replacing the dash with a period?

 This file is no-longer needed by Buildman but it is still generated in the
 working directory. This helps avoid a delay on every build, since scanning all
 the Kconfig files takes a few seconds. Use the ``-R <filename>`` flag to force
-regeneration of the file - in that case Buildman exits after writing the file
+regeneration of the file. In that case Buildman exits after writing the file
 with exit code 2 if there was an error in the maintainer files. To use the
 default filename, use a hyphen, i.e. `-R -`.

I understand this is probably worthless and I could just be wasting
everyone's time. Please let me know if I should just ignore these very
minor "typos".

Com os melhores cumprimentos. / Best regards.
Adriano Carvalho
