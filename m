Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C89DEDE9A8
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 11:43:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99C8C86A1C;
	Thu, 14 Sep 2023 13:43:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d3l+Z9rr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEC4786EEB; Thu, 14 Sep 2023 13:43:31 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 151A486A09
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 13:43:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-52bcd4db4c0so2015780a12.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 04:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694691809; x=1695296609; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=17ok3oLfEcdojX6V8Tj9P1I5OF6NRML0iSnBZwFbcj8=;
 b=d3l+Z9rrtTp6tyI1KhjkpanvzOqH+sWeCbCBfeWdasw34SCAW1/ht1RCtc5hXVDaYY
 IH8yTXR00/zfUbrjZ48zd3NJo7gPCXMwbbjidO/UOYpHJ93op0Mam7hb3b82jig9aQaq
 q76SFRxCtmWRuitKrjNDhCWVW4UAPGMzzgqy4Nmz2j8+eoXHR4FXC0T9/IhzfnlMzGue
 QgxbmwzITv+ZyFU8FDID1QBO0ii/STb7Yuw3sDLAPyAphF9k1qHSMD35Tk8sHZ/J3L0P
 WcUYfZYQipHBG/qrvh7C6SURhF8Qu7wJIFJAQTiyoYDGhabofi9GNq8rPAocPkq+gR9F
 Df4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694691809; x=1695296609;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=17ok3oLfEcdojX6V8Tj9P1I5OF6NRML0iSnBZwFbcj8=;
 b=BS9aRbfFSB3n5Ip+dBfkS7ReBEGaxuFNem3ahbNZziKW0ammux/ACnd4uQhsluO+Ye
 rkWvErLHega/0PDN6JOg23usPObYko+LtW8eDP6mmNhTBGEybUFTfhEhKcGQJDgVhF/q
 epQNtD3Fo+m76KuYFeX2x80dyRncEEIYMnDx9oUoTLOmtPEJN5rkNI7HmzM4ZJvsfiBg
 kQuADP4ylegUBEmKXOXZfLuQ1g8AMeGi8g6R17Jy9SlX+aN4vaUCK9ZgpRrQW4iMhRc+
 +JklJ2IyAi//0jp5/rPHo+1D3Qjv4dEWzuq2nrFIHFRN52E+xUIB1SlXH2gWz7HtFGqY
 p9tA==
X-Gm-Message-State: AOJu0Yxb14K9Oh0siMCc3ywBPwEM4r5E8TxaqcYqBLye/lEvmhFmpeEJ
 tSr5nr0U3pLWLvGXlzkiaZNnXsL1paJGQSFGnEGjFA==
X-Google-Smtp-Source: AGHT+IHG9LUuDoXkDSrmFCK6VfDewNTUgw4A+BBlrwPJOs5QkzkZ4afyeOXhHw+yaXLJkttjQaujkR+TKMlOzKFDiEk=
X-Received: by 2002:a50:ed8f:0:b0:525:6abd:2755 with SMTP id
 h15-20020a50ed8f000000b005256abd2755mr2149281edr.16.1694691809597; Thu, 14
 Sep 2023 04:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230908120002.29851-1-sughosh.ganu@linaro.org>
 <20230908120002.29851-2-sughosh.ganu@linaro.org>
 <20230913192428.GQ305624@bill-the-cat>
In-Reply-To: <20230913192428.GQ305624@bill-the-cat>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 14 Sep 2023 17:13:18 +0530
Message-ID: <CADg8p94BKtY1dj0E5XfLKwUKqJOkvVTQm4jWU=FCf8Sb6RDkag@mail.gmail.com>
Subject: Re: [PATCH 1/8] tools: mkeficapsule: Add support for parsing capsule
 params from config file
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
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

hi Tom.

On Thu, 14 Sept 2023 at 00:54, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Sep 08, 2023 at 05:29:55PM +0530, Sughosh Ganu wrote:
>
> > Add support for specifying the parameters needed for capsule
> > generation through a config file, instead of passing them through
> > command-line. Parameters for more than a single capsule file can be
> > specified, resulting in generation of multiple capsules through a
> > single invocation of the command.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
>
> Is this config file format used in any other project / form?

Yes, I have kept the format on the same lines as the one used in the
EDKII capsule generation tool.

>
> [snip]
> > +config EFI_CAPSULE_CFG_FILE
> > +     string "Path to the EFI Capsule Config File"
> > +     default ""
>
> No empty defaults.

Okay

-sughosh
