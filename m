Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CC5EE7FF4
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 14:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE9DE86D34;
	Mon, 11 Sep 2023 16:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y/uCrTzS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CCD886DA1; Mon, 11 Sep 2023 16:13:26 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1051F86D05
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 16:13:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-502153ae36cso7141323e87.3
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 07:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694441602; x=1695046402; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yQMnnxjYav3sNeM4PWmJbEV0v/9QqZy9J6YxzNaRHc4=;
 b=y/uCrTzSB/IFiRgwZG9rPGpZXsPFcQgGGmSmyXcZBXIrd2GVjIFLoE4595EBjgGwp4
 EwYlUflJYQUmyXVtzJNlyU9L2BeyRN8QEOnNQ4uszUBJFPsDVbgfYv8Y5A3hFmsm5eSp
 nsr8RCJgFtpBUMalCJ+LpxF/qMpj5olupQIJ6jA4Rkf84qAy3lzLr1TVFM/SrI+mqoxU
 xedJUyQtF4wtHwuKBRn0XUgD7dsxMvZjdBAWg2xcKO86GSYfJb+/xU3nfj5x++61zE/+
 +zizI4nyH19Py1iJxPTGgyhLGuIGTDIhGpAbH0+WYAc3z4KMiK93pt7YY16OmxVo2aYB
 eLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694441602; x=1695046402;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yQMnnxjYav3sNeM4PWmJbEV0v/9QqZy9J6YxzNaRHc4=;
 b=wnfh3zIqDwdjr9Ddrpmaj8jrUfLlUCUov3w7wDaUBw+MPcDCgJhK9jIoWxhlzYpZ7d
 BmkaZQUnaFJ7mBLjalsasWmYtWdR0rGulTNobAwX/meC0XvpAX897xjHF8FsAmeHPDLs
 uh94wGyazyqt+Vzt0EMCGjKK7Zw0gaLAfn6tzYr75EVkDic6Xp+EZ5mL/64drAfxvinX
 JlHER13rzPIqrcnA5fZKohaY4zFCR6s+BEOOm7qb20kstZ5QK+UTrEDHvcT8MpbnSQbh
 kNetpatKaURuPUwLwjr1aCobiw2TQI9YqhTISNOiC+s+ns2zIVNveTbGsRl3HBa5CCME
 R1nA==
X-Gm-Message-State: AOJu0Yxb+HKLM3/hY9MMbHh6YZ1O1Jb43N/ehfO+yUKn4gRQfufwBEUB
 PX2VS5cgGWQ8523BuuwKY+drljcg9GBQlqK5FMxvJx9taNPO0X8GbSo=
X-Google-Smtp-Source: AGHT+IFZciPzTo+kaydTOgrFEo72uSnjQTDfoxEPgzx0foc0M3Hwd6cQti4LGEnfhnEV2j2oCVIm/BjEFIrdNOj45Qk=
X-Received: by 2002:ac2:5fc3:0:b0:500:80af:e199 with SMTP id
 q3-20020ac25fc3000000b0050080afe199mr6518339lfg.55.1694441602067; Mon, 11 Sep
 2023 07:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230908120002.29851-1-sughosh.ganu@linaro.org>
 <20230908120002.29851-4-sughosh.ganu@linaro.org>
 <CAPnjgZ3Zi3hmQg7d5+0461hRK+5O_V89PY=QxMwQarhhqUW6VQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ3Zi3hmQg7d5+0461hRK+5O_V89PY=QxMwQarhhqUW6VQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 11 Sep 2023 19:43:11 +0530
Message-ID: <CADg8p97cQJYogd_MZT_hCH71XjqkO85VEay2fb7hZx1YwX+OPA@mail.gmail.com>
Subject: Re: [PATCH 3/8] binman: capsule: Generate capsules through config file
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Tom Rini <trini@konsulko.com>,
 Malte Schmidt <malte.schmidt-oss@weidmueller.com>
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

hi Simon,

On Mon, 11 Sept 2023 at 00:44, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Fri, 8 Sept 2023 at 06:00, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > Add support in binman for generating capsules by reading the capsule
> > parameters through a config file. Also add a test case in binman for
> > this mode of capsule generation.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >
> >  tools/binman/entries.rst                   | 35 ++++++++++++
> >  tools/binman/etype/efi_capsule_cfg_file.py | 66 ++++++++++++++++++++++
> >  tools/binman/ftest.py                      | 29 ++++++++++
> >  tools/binman/test/319_capsule_cfg.dts      | 15 +++++
> >  4 files changed, 145 insertions(+)
> >  create mode 100644 tools/binman/etype/efi_capsule_cfg_file.py
> >  create mode 100644 tools/binman/test/319_capsule_cfg.dts
>
> I think we discussed this some time ago. The problem I have with this
> is that it adds another way of specifying the image description,
> separate from the binman definition. This introduces all sorts of
> problems:
>
> - the question of where the filenames are located, something which
> binman tries to handle cohesively
> - binman has no knowledge of what is being put in the capsules
> - the resulting fdtmap lacks any information about what is in the capsules
> - it seems to create two ways of doing the same thing
>
> Binman can presumably already create multiple capsule files, just by
> adding to the description.
>
> What need does this feature meet?

We already had this discussion earlier about the need for generating
capsules through the config file, where I had explained the need for
this [1]. This is functionality which is supported by the
specification, and we have folks who are interested in having the
capsules generated through config file, and also in generation of a
single capsule file consisting of multiple input payloads.

I understand that this model does not fit with the usual way in binman
of generating an output image by specifying it's inputs as DT nodes.
But just because this does not fit or align with the design of the
tool does not mean that we do not add support for the functionality.
Why can't we support this in binman as long as it is properly
documented as to what is being done. Moreover, my initial versions of
this patchset were attempting to achieve this by adding a make target,
but you had shot it down [2]. So it either has to be done through
binman, or through a make target.

-sughosh

[1] - https://lists.denx.de/pipermail/u-boot/2023-July/524849.html
[2] - https://lists.denx.de/pipermail/u-boot/2023-June/521103.html
