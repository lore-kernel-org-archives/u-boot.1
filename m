Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C9AC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 14:59:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0801B88580;
	Fri, 21 Jun 2024 16:58:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hn0op8EX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DA8588550; Fri, 21 Jun 2024 16:58:10 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5486B88549
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 16:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6b4fdf56903so7784086d6.1
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 07:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718981887; x=1719586687; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BZlqQVghskc/wIbu2xOaqQFWbI3BOVSRSE9MEY3ctEo=;
 b=Hn0op8EXWFgC1TWSCQu6yKaVv0JV79y//3g555g4xnYomI0Fq1UwKNJPt2bion+kZi
 YAjKXXPCWX7WeK6scEUcEBVDb+GBWI1MMNwODbTugkrlnqVWJLbFDt57/DB/sJk1wV/k
 Y60JJvWaY8dSXA4cenE5p2Q4KKgGFFAmvK4Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718981887; x=1719586687;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BZlqQVghskc/wIbu2xOaqQFWbI3BOVSRSE9MEY3ctEo=;
 b=XquLiGFMIkVvqe5be2RqCAR2v8Nt3G0h7ruSgxXgr3TF7mJ36dlbH+lHoL8DTLgX/J
 lKOrT4BbbiDP4SdKTRcoDQVPYS+9zhAI/y53ZSSHN9tzCovAyGYZB8Zp5OGXJWd7qy2s
 cNArSqfu2vVC1fOdl9GTOX6cFhWyl6vZ2HnDqv8NS7dkJVAgAk9T0/3EqaMvJNHkyKPC
 OVyfh8ZVfne4vlZrdA+teCJasN6HYWMECKd1SemYkvXi21bqGImbR91nw0aGpOxgSr6C
 xEcy2npGu7k1jGBiR1z9zFXge4fOVTAOwYhdLRObW8ctnegfvSFUqC457mKCRagp0UOl
 0F2w==
X-Gm-Message-State: AOJu0Yzr5j9qL0PD3o5/FSF5+soyYA0z/FY5LRwYw1YNU4EyeJLDQZpi
 72gn1ROz9vju+9EeeCAzIsolXc8kq/mN9h5aMr7mPHWSA7OqhBxNO137NoPj49lZDS522CGpDI9
 cRg+2UaCUfwxQ/LrEIf9hIXr3MI2HpW+iWZCzVQ//4C4uvZU=
X-Google-Smtp-Source: AGHT+IERb8eYbSPfbUnoYo4SPVWjNsnr1IsY8PipfSbtn0jU0LzSfwi5ReTsj6sWCXDRyW9k08Z1MPovktBi9DwVjUs=
X-Received: by 2002:a0c:e610:0:b0:6b5:6a1:f894 with SMTP id
 6a1803df08f44-6b506a1fce4mr76462146d6.3.1718981887215; Fri, 21 Jun 2024
 07:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240620230625.1797397-1-sjg@chromium.org>
 <20240620230625.1797397-8-sjg@chromium.org>
 <CADg8p96c=xd6=6d1fijNFBwzXMszRnvo7J-qm-7co1panamP2w@mail.gmail.com>
In-Reply-To: <CADg8p96c=xd6=6d1fijNFBwzXMszRnvo7J-qm-7co1panamP2w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Jun 2024 08:57:56 -0600
Message-ID: <CAFLszTi_3T9O6r1K9QPBKBE+3jtw04JMfKr-tk=E_zb8Yzx4vA@mail.gmail.com>
Subject: Re: [PATCH v3 07/18] binman: Keep the efi_capsule input file
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
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

Hi Sughosh,

On Fri, 21 Jun 2024 at 00:14, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Fri, 21 Jun 2024 at 04:36, Simon Glass <sjg@chromium.org> wrote:
> >
> > There is no need to remove input files. It makes it harder to diagnose
> > failures. Keep the payload file.
> >
> > There is no test for this condition, but one could be added.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Fixes: b617611b27a ("binman: capsule: Add support for generating...")
> > ---
>
> Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>
> Although I don't think this warrants a Fixes tag. It is not fixing any
> issue as such.

I'm OK to drop it if you like. Binman is designed to keep its
intermittent files in the output dir. We have talked about having a
separate dir for 'intermediate' files to avoid cluttering the output
dir, but have not done this yet.

Regards,
Simon


>
> -sughosh
>
> >
> > (no changes since v1)
> >
> >  tools/binman/etype/efi_capsule.py | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
> > index 47da5da324b..03e55cbc4d9 100644
> > --- a/tools/binman/etype/efi_capsule.py
> > +++ b/tools/binman/etype/efi_capsule.py
> > @@ -148,7 +148,6 @@ class Entry_efi_capsule(Entry_section):
> >                                                   self.fw_version,
> >                                                   self.oem_flags)
> >          if ret is not None:
> > -            os.remove(payload)
> >              return tools.read_file(capsule_fname)
> >          else:
> >              # Bintool is missing; just use the input data as the output
> > --
> > 2.34.1
> >
