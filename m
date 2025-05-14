Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C997EC3ABD8
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 19:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AC5682ACF;
	Wed, 14 May 2025 21:45:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kpxWoZnw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D672082AE9; Wed, 14 May 2025 21:45:05 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0CDA82ACF
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 21:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5fbeadf2275so356334a12.2
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 12:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1747251903; x=1747856703; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dKsfIkxPLfiBZWlOeofGoRBOJ8zlS+Hr7BC1sQU58og=;
 b=kpxWoZnwxVIxkZcPYS8Aa6m4D6K1K/d6Ne2osxugIsUPCDdsAgTKEYWDChrp5fZUk9
 yluImcM4Y0VaH7wmpj5vfivvy9mM0WekGZR7g+QwRYXgH9KeMT1Kh/pD0d14AWY+6erk
 OyxjUtM8tNI6aFOPpxqemQYowMZlcVoGi3Mbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747251903; x=1747856703;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dKsfIkxPLfiBZWlOeofGoRBOJ8zlS+Hr7BC1sQU58og=;
 b=kR/vcvYf52O593PTMbmatNWqquuwNH1GYPIGe6aePolTyfFNvC5lcu6lKh4zxSbiRj
 hdejWVgb1GIrmIdmmo254wZYcVYOHc/N+m/PiRaXqBCTMR7GuU5TI5Ug/0QFrRyabP3p
 rI4pvXRVZs/jDjdPeigbeCpAQvhQl6SBL/HY9ZihujOF/YCdOBzpqTovKPYPASfsAyh0
 bzYgMTvcnEvgkP3jYb6qGnrQAsGj+gjskXpb14CH5NY/L14f++n0RuMEHVemgrglALXG
 3iF/C4Ki6DVfK1Dx7zBTBQvmNNwD6DexBeYvChFgy7tFzgpSHVgpFk+nJMHJvI0HDW/z
 52IQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8wk06Qgutjiw2pas5jESjLLLPLTHbcfZhZ6iPr/rjMlbcp7iUE6Y5CIgG5Mh36XwllcIurkk=@lists.denx.de
X-Gm-Message-State: AOJu0YzyZwstW3hQtAduy0RvEw/PT71auey7LSVUajKLnLXbIcyMoKIq
 DGUm0A76kS7CpInIP0YJxblJ1AdbXL0iSANN0ys1aZfYmU5uWfdFS+fu2kcgdaYYf94/bI30KQS
 hmOL/CMBALxY7vAcMOEN7R09bSz0QjIX2n6KV
X-Gm-Gg: ASbGncvdmoWEQS/IDGY1xUEUA86KcZnPzCPLnlenUobIOG8kvjJk/fmuCVj8rMZwahj
 DvnB1MZwjsEEkd6yY5/2arMr1ldck17GZGnBOWa88uJzMu80QKVwlTuXee5kJWw1vJG4iSsXevb
 zHqSFQTZe5MM3WtrF2d1MHHTVueycVrnQtaQ==
X-Google-Smtp-Source: AGHT+IEA3mzvHGtfS1hs53WlMjx/0FQSHP4BJDxtdUZ13wX5cbWOVqyVk1Y89jNZWkhoEolvInzm7+s3rqCD1bv5eCg=
X-Received: by 2002:a05:6402:40cc:b0:5fb:afca:dd6c with SMTP id
 4fb4d7f45d1cf-5ff988bff22mr3843378a12.5.1747251903389; Wed, 14 May 2025
 12:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250505100852.9364-1-aristo.chen@canonical.com>
 <0cb64c56-8f11-4cff-b1a6-a1b6a4194c86@cherry.de>
In-Reply-To: <0cb64c56-8f11-4cff-b1a6-a1b6a4194c86@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 14 May 2025 21:44:51 +0200
X-Gm-Features: AX0GCFusOSn2qiP7GotpTftyuCAEwe9TRf0WcFxiGP-mYjbo4AKf1TU1kAR7esw
Message-ID: <CAFLszTg-4HKF0ZD9h0h2LVSGsSv0adX_=6B84EX6wuGP=oQxzg@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools: mkimage: validate image references in FIT
 configurations
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Aristo Chen <jj251510319013@gmail.com>, u-boot@lists.denx.de,
 trini@konsulko.com, carlos.lopezr4096@gmail.com, aristo.chen@canonical.com
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

Hi,

On Tue, 13 May 2025 at 17:28, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Aristo,
>
> On 5/5/25 12:08 PM, Aristo Chen wrote:
> > When parsing a FIT image source (ITS), mkimage does not currently check
> > whether the image names referenced in the /configurations section (e.g.
> > "kernel", "fdt", "ramdisk", "loadables") actually exist in the /images
> > node.
> >
> > This patch introduces a validation step during FIT import that iterates
> > over each configuration and verifies that all referenced image names are
> > defined under /images. If a missing image is detected, an appropriate
> > error is reported and mkimage exits with FDT_ERR_NOTFOUND.
> >

One option (for boards which use Binman) would be to put these sorts
of checks in there, since it might be easier to code? But having it in
mkimage as well seems reasonable to me.

Regards,
Simon
