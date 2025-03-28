Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C976CC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 23:38:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04A4680F0E;
	Sat, 29 Mar 2025 00:38:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T2Z07nP8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0023E805C8; Sat, 29 Mar 2025 00:38:44 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CF6B81D3B
 for <u-boot@lists.denx.de>; Sat, 29 Mar 2025 00:38:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ac2af2f15d1so352616366b.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 16:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743205122; x=1743809922; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yr0gzf7WphpLPMXIP+09RLAFSNa9hLLbqlN9iXMcIO8=;
 b=T2Z07nP8EY5gwaVGfWeKpGP+b94qi2islDi6ViwDVmnhN5u9Q19MMBBQvVDWG52jpk
 hpJg/7s3xRzz168CU5hlYygqG56FdRv8lmDMgpTZei6PiCbfsEXFInl99Ler39TuKCj1
 a99iRvsYOXIkrX5rQe/r48f7YMBp9wEscbTNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743205122; x=1743809922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yr0gzf7WphpLPMXIP+09RLAFSNa9hLLbqlN9iXMcIO8=;
 b=LxcgOismgfLa/yjzUP+pc9fdOD7UeeWUa19faPCsnPejz95p7w8viKJ+m++IJly84+
 vSFw91EYOSuKPTWVxLEGwa0XUj7qn9qzJb5z+Jhzdm50M0ikxeH7ZMkdJ4L+vVWsEYZA
 Wvxj7rn90wlaYZibU/FJHPAc6O4O6H8ZqX6w7dgRMs15L9OiQnIzAu4pYw0eK0j9CL96
 lfkDFf0r2ANFLPaujYzHwRmuZCp66NwAgRl/L7beAMy0hDPEPX6OuVl1B/mjyOkNBZmN
 EHla4+HTGTzJC7XKHGdMrhUIbfCJ0zCS/hFvWEVW/+Ptlh36hip3kBi8AF1Qq+zJQckq
 gqRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwUd+ZQOVZdgp7Y0gIYtxSeQDrDQZVsSZLrFbg9XzR7Kf/n6KhA7qVqITkSWW3BrlefteiFVs=@lists.denx.de
X-Gm-Message-State: AOJu0YzgOKvd0gKwqEzes/5T3wCf83q2HB8RmlkzezAHjchgi20ylq51
 M+4ag8UKpzXLwZBWw8SkvPnKdFuCw6T90F/kfelseuMrkR461D80yCbWalVn9Vot8aThnPcFt9F
 BT8dz5eWQeHrk49PAKh72jsfL7zne56gKmLEP
X-Gm-Gg: ASbGnctnMI5PvCspMqSAVq5bCVSh4odiBNqdCfLOiq0YqZZZnPcskJQB/uqTBSGJp9B
 3NIi3KwcXjWz2rVwLRasHiafnuQg++CLiKKBXXNLvjkaeDyjFE1hAVIkiz3+3ghFKeEs3VNu61C
 rr/tpnOUmJDcZd85rf9BJ+Ze5P3io=
X-Google-Smtp-Source: AGHT+IG797JgUo/w28C26e9gYpE4l8LTelbSqQRXPmQarq5ApVDXoNDOEriEsqQote4E/pgwd05InJtuT6wZyizP20I=
X-Received: by 2002:a17:906:7955:b0:ac3:3f84:4055 with SMTP id
 a640c23a62f3a-ac738975ff9mr110394166b.4.1743205121985; Fri, 28 Mar 2025
 16:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250328153522.3555472-1-sjg@chromium.org>
 <20250328153522.3555472-30-sjg@chromium.org>
 <CAEfUkUKa-_=zOry+0-EnS=e8tEq7=nooDDt6Yr_M5vx31w+JUA@mail.gmail.com>
 <20250328161322.GA93000@bill-the-cat>
In-Reply-To: <20250328161322.GA93000@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 28 Mar 2025 23:38:26 +0000
X-Gm-Features: AQ5f1Jq3vA6tfr_4ep-wpiIjhBhfXDm7Gou-wT0uQc7PaDw4e5QzWykf4bYlSd0
Message-ID: <CAFLszTh79kX40mb=UGUbxRsFhK+r2smmM3sOL33d1EAS0mL3xg@mail.gmail.com>
Subject: Re: [PATCH v3 29/31] RFC: Revert "bloblist: Load the bloblist from
 the previous loader"
To: Tom Rini <trini@konsulko.com>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Levi Yun <yeoreum.yun@arm.com>, Patrick Rudolph <patrick.rudolph@9elements.com>
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

Hi Tom, Raymond,

On Fri, 28 Mar 2025 at 10:13, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Mar 28, 2025 at 11:50:14AM -0400, Raymond Mao wrote:
> > Hi Simon,
> >
> >
> > On Fri, 28 Mar 2025 at 11:36, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > The logic of this has become too confusing.
> > >
> > > The primary issue with the patch is that U-Boot needs to set up a
> > > bloblist in the first phase where BLOBLIST is enabled. Subsequent
> > > phases can then use that bloblist.
> > >
> > > But the first phase of U-Boot cannot assume that one exists.
> > >
> > > Reverting this commit seems like a better starting point for getting
> > > things working for all use-cases.
> > >
> > > Note: The work to tidy this up is apparently underway. For this series,
> > > a revert is the easiest path.
> > >
> > > This reverts commit 66131310d8ff1ba228f989b41bd8812f43be41c3.
> > >
> > > https://lore.kernel.org/u-boot/CAPnjgZ3hMHtiH=f5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com/
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> >
> > Is this same as something we discussed in the thread below?
> > https://lore.kernel.org/u-boot/20250205015606.2686149-29-sjg@chromium.org/
> >
> > I am a bit confused since I think we had agreed that it should not be reverted.
>
> Yes, it is extremely frustrating to have posted both this:
> https://patchwork.ozlabs.org/project/uboot/list/?series=450425&state=*
> as the first pass at doing what was agreed on the path forward while
> also posting this thread which cannot be against either next nor next
> with the above applied and so isn't worth anyone elses time. I suspect
> this thread also includes various rockchip patches that were requested
> to be broken out and posted by themselves instead.

Please check the cover letter where I have covered that. If the
bloblist series I sent lands, then yes, I can drop these final
patches.

Let's not talk about frustration where bloblist is concerned, given
that my boards were broken for a *year* because of all this.

Regards,
Simon
