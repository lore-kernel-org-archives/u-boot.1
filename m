Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBC1CF042D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:56:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 997C9890C9;
	Wed,  9 Oct 2024 03:55:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jad8hDpS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 703AE890A9; Wed,  9 Oct 2024 03:55:55 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F878890F4
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:55:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71e1a715c72so640895b3a.1
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438951; x=1729043751; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GYF2xGRS0sBsGJt+Sp96Ctkpk59whpdDrMVamaNcbEg=;
 b=jad8hDpSROOd5c7nenHdSUHCZADCMv6+QB9d0KKQY5VDv07gXxbIYoZwtHE1Q1Pu+v
 NbXsyTf8CvBg4YE4Tb3P11tvoLMzX8tXDOOc/rxgOaoxuhLSabY8U8FtzZvQPfa56Q/h
 yBufWTDDvp180SB7ImmI88SFWH7lIBdtE4gRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438951; x=1729043751;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GYF2xGRS0sBsGJt+Sp96Ctkpk59whpdDrMVamaNcbEg=;
 b=B2pEGphjcJBi0HlFytKdRWXhtfLTui7ByFzak4Nudtndk1hnEyy1iRuQAW6OSX4VhL
 LCAmuW+ijfH2Fl7PRtafY5/uRio5PlMWyhpyQ1yAcvAcAV8PsfhcdJJ4W6IZ5o1zFBrH
 O496g/BYm/aBCjGvnPFCikZ7Uuw6oab6g3W+2ak/7ywzSsmdP5Glx6seOh56x8BiXLi9
 QMfRLuFv/26yR/0Clm0NjAGlG1iC/39hbQa4yCc2AtT8LPqgYX034R2ucKSEkaERT4bh
 trP4ooW1kW/7EkTbITsxZ6EAPkcqQbQVjNfic4hxLrAYAr+FjaXfz5oywCVPbYHBgjss
 sB2Q==
X-Gm-Message-State: AOJu0YxZYGbF9ix3jO6PepKxwqjQiRRli45nkXrE/w5ynbc/hvKwW+kk
 loStB4sKexH03VLylh+qPsKPoykt1gJLpNyfhrWvywNH3tyJReiSzmR0LzlvDDiAgN0y1VbKQrR
 X1RM2AcuagSklPKOUyuphZMphvtNrKJr1VbpF
X-Google-Smtp-Source: AGHT+IFig1myFhQYQzXWkk2b6Otbb+TR7wv1BPCZhFzLoiwKeXVf0yzs42cCSUcGa1Zc2UHPDnjN06NWgkrDqOaVzmY=
X-Received: by 2002:a05:6a00:4b50:b0:71e:135a:ae5f with SMTP id
 d2e1a72fcca58-71e1db77064mr1498144b3a.11.1728438951177; Tue, 08 Oct 2024
 18:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <fbed0251437b61a2f7a85596d7403b5b9c8237c1.1728306322.git.michal.simek@amd.com>
In-Reply-To: <fbed0251437b61a2f7a85596d7403b5b9c8237c1.1728306322.git.michal.simek@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:55:31 -0600
Message-ID: <CAFLszTiBHjqc-xeqsC51hFUed8bigv8+WsC9hUnv_tEC2RahcQ@mail.gmail.com>
Subject: Re: [PATCH] binman: Add option for pointing to external description
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sean Anderson <sean.anderson@seco.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
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

Hi Michal,

On Mon, 7 Oct 2024 at 07:05, Michal Simek <michal.simek@amd.com> wrote:
>
> Adding binman node with target images description can be unwanted feature
> but as of today there is no way to disable it.
> Also on size constrained systems it is not useful to add binman description
> to DTB.
> Introduce BINMAN_EXTERNAL_DTB Kconfig symbol which allows separate DTB for
> target from DTB for binman itself.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  Makefile    |  2 +-
>  lib/Kconfig | 10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>

Doesn't this defeat one of the purposes of Binman, i.e. to document
images? We do want the .dts to include the image description. What
sort of problem is this causing?

Regards,
Simon
