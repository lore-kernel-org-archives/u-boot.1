Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFACC531DC
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 18:29:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF81788C08;
	Fri, 16 Aug 2024 20:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jcqTMIHm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFD7288C01; Fri, 16 Aug 2024 20:29:03 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5D6C88BB2
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 20:29:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5becc379f3fso1121951a12.3
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 11:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723832937; x=1724437737; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PlR+AAQ5kK21Zl2eoQikZvhxCBZlg3q/Dirq5c3doO4=;
 b=jcqTMIHmSFCXGXDzLG7gm5Vzpfiia0FkOtD/cIUZfd4QWfJ14oLi4nYgNca67h9D3Q
 +sXKiokZuDVbC6DanA/sLG7pEUk/V59XPsOS8d+dtIxggpxzew1FzRqz+fD0SXW4tuLV
 146ugXax+qhNpqpkaIv8Ol8+3vKUZarlnpNWOi5YK9uU46HNdHed/yVCpLNPMHOmReSx
 1hEg3G2xZF5PEBfgicMr5EKg78FBtNgFpziTukKYClF7s5xkFAaKYL6QsFj+SCJh7Lbp
 kRzD/cRYVTyz7KyWpBpAoBgOSg5nUpFmQNvx4H/BNNFHzjAXCkawynzbsZxOOjCTCpvb
 kZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723832937; x=1724437737;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PlR+AAQ5kK21Zl2eoQikZvhxCBZlg3q/Dirq5c3doO4=;
 b=mdtBr4pozg5KAoEmWcTAEjm0qPPmF7MMqALTR+0/inABTItbUd18bM/PBX5PleaWfU
 /hrPhDhh6sc3nB5NE69byX3DFcgnOkRBG4WSBabJUk3UtfkydJ7rD7V6nLH//e/3W9EM
 TwIn00Zl10UJihlp5CMTPGWF3u8TSuQ3711xuvHP+KzQDyxhJzA46D1JrDLLFhtlRLiF
 PMmX5FmxbMS+tgA5TSV0ejvlRB5Kw/unsThQx3sRC9KmcSwvrrsNXI6Q6NjLRjFc2A4z
 252a3vQiyl5E9ZrzUR1tR2Dv6WnTEytrXoWLu6w8IqZhp/8zCk21IL9kQgddCM0A51Ta
 A8Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkpHs3hYne0NV9UliDZtllBoL3jc4yS9S0kTvwZxmtk6OXfPclO9NOBwoMdEPOYKUgKAIZDEt6oq/6sBe9zN5MnMV71A==
X-Gm-Message-State: AOJu0YyZEtLMFR7q7RT+hI9DcYGrcDDZxWN9HorXmpISywqoXYJ1tkLZ
 1s5eDWYOl3GLVHOvj2UKNYpO5qgd7MBdqxEyyns+oJTHAsrjjJfhpZ9lftWhV4WAiY+7XabXpD8
 kudvlxbO3TxhyTKsF4bxQScu/1FLphePcAy188A==
X-Google-Smtp-Source: AGHT+IEIn2E6pt58JT+ixfSTLMYpN9zczf9j/BCqMaApbeYIa0un92v1ZGY0zOKkBP9OFA4b5KSuHxuboT9l27AsT0c=
X-Received: by 2002:a05:6402:280f:b0:5a1:7570:8914 with SMTP id
 4fb4d7f45d1cf-5beca52b0d2mr2913962a12.11.1723832937366; Fri, 16 Aug 2024
 11:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-28-sughosh.ganu@linaro.org>
 <CAFLszTh-5c4_OdZs8F_e=giR+ZFjNB1oX8L8cV8hXi9Je6e+5w@mail.gmail.com>
 <20240816180618.GB1626301@bill-the-cat>
In-Reply-To: <20240816180618.GB1626301@bill-the-cat>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 16 Aug 2024 23:58:46 +0530
Message-ID: <CADg8p958YrP9AEALEWe5qUxLkTGguMLcf8jvTw3dDvRwZn7wzA@mail.gmail.com>
Subject: Re: [PATCH v2 27/32] test: cedit: use allocated address for reading
 file
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Fri, 16 Aug 2024 at 11:36 PM, Tom Rini <trini@konsulko.com> wrote:

> On Thu, Aug 15, 2024 at 09:32:29PM +0100, Simon Glass wrote:
> > Hi Sughosh,
> >
> > On Wed, 14 Aug 2024 at 05:02, Sughosh Ganu <sughosh.ganu@linaro.org>
> wrote:
> > >
> > > Instead of a randomly selected address, use an LMB allocated one for
> > > reading the file into memory. With the LMB map now being persistent
> > > and global, the address used for reading the file might be already
> > > allocated as non-overwritable, resulting in a failure. Get a valid
> > > address from LMB and then read the file to that address.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since V1:
> > > * Don't use the API version with flags parameter.
> > >
> > >  test/boot/cedit.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> >
> > No, this address needs to work fine without using lmb. Same with any
> > other tests. Tests make use of the sandbox memory space memory
> > addresses and it makes things easier to code and debug.
>
> Can't we just request/free that address from LMB then?


Very good point. Because that is precisely what this patch does :)

-sughosh


>
> --
> Tom
>
