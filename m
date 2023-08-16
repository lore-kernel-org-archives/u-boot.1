Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E588C27C41
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 22:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5208E86A18;
	Thu, 17 Aug 2023 00:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xu65jfW6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A910D86A19; Thu, 17 Aug 2023 00:02:05 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62B268697B
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 00:02:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5257f2c0773so2077170a12.2
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 15:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692223322; x=1692828122;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4olqj36vBA8BrUD0OOVA5JDxZsxm+tjtvH6czw3ubcQ=;
 b=Xu65jfW6lw5VtIy9uu0lhvspNWjCMErppZ7pg4ayx4DEj6AIksEEErMsy/itwfr3ny
 qb4oLVP+SZDDAmTeDfC+2w16jKp6CRu3meRukpHjwV+jzV1+7GBtYZMyS8wpePIF0LcW
 qnuDjcQ7Pa7TNdHWhInvj3eJmY319jeSNVxm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692223322; x=1692828122;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4olqj36vBA8BrUD0OOVA5JDxZsxm+tjtvH6czw3ubcQ=;
 b=Cw1KY0U9gCV2dAeUyeB9uo9a7efC3NtSfZCyTChUdEOYekWvk8n0Orov6lveUVaoRd
 Jzuwxq73/LNiEwXnYzgxyPcQnRIutQytxcrInKI+s54fa2r7UToULPZ13GFJ/qsU7wcM
 Kx/TcjSg1QsLtZV81oqbRml+yOzL8N1z0cbhvGu9itfIuzi9ma3oy8x7+OcvkTAl0o4u
 gkRqh0M0rdlOkPZh6214d5RbxUna6RVQ6PElzZR0XGmvwRvEYPlweEVqEEN7UzGSTKUI
 KqS2Hg1bbvx1hOK+8XiLCR7lGjtj6NKo6bin61DuzGDxZku8wAtBPUSIDUO94xoTT4nx
 a22g==
X-Gm-Message-State: AOJu0YzXKn0mzdbOqkyMMpHK4oPlk3IBwjfG9XdUH/UNDGJOxOYkgh6H
 4NEI7brnh9mUBe6wA7QtlisJLrFvdLvJC1x8/kqNRA==
X-Google-Smtp-Source: AGHT+IG7jsZ2zy99fRkUvmKwCXLLFjtRe7JNFQCaA2ETMDPZJPw32VvFkKjy7K/ELrTrGLG4E5PkIcLAjs1M9lr/mhQ=
X-Received: by 2002:a05:6402:8d4:b0:525:45dc:40b7 with SMTP id
 d20-20020a05640208d400b0052545dc40b7mr2376750edz.17.1692223321613; Wed, 16
 Aug 2023 15:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAC928HaEQhH2q57T36XtoetfLVSC84-DMBv2msu2PdbkazUBOQ@mail.gmail.com>
In-Reply-To: <CAC928HaEQhH2q57T36XtoetfLVSC84-DMBv2msu2PdbkazUBOQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 16 Aug 2023 16:01:50 -0600
Message-ID: <CAPnjgZ3gdftt3-2FnP5ZTOg5dDDjT2d7qFPpTLQgzc38QhEbXQ@mail.gmail.com>
Subject: Re: U-Boot logging
To: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, u-boot@lists.denx.de
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

Hi Massimo,

On Tue, 15 Aug 2023 at 13:01, Massimo Pegorer
<massimo.pegorer+oss@gmail.com> wrote:
>
> Hi
>
> I had a trip into U-Boot logging and I am quite confused. I read the
> documentation at doc/develop/logging.rst and had a look at source code
> in log.h log.c printk.h Kconfig and other files, but the picture is
> still quite foggy and, let's say, 'complicated'.
>
> The documentation does not mention at all CONFIG_LOGLEVEL, but pr_xxx
> macros rely on its value (and then on log_xxx macros). While log_xxx
> definitions, instead, depends on CONFIG_LOG and other CONFIG_LOG_XXX
> values.
>
> It is not clear when/if pr_xxx and/or log/log_xxx should be used. Is
> any preferred and why? Is there a specific reason to keep both?
>
> Neither the constrains and relations between Kconfig variables are
> clear. CONFIG_LOGLEVEL and CONFIG_LOG are in different section
> of menuconfig: Console and Logging. The semantic is also a little
> bit different: for LOGLEVEL, values smaller than the console loglevel
> will be compiled in; for LOG_MAX_LEVEL, instead, any value higher
> than this will be ignored.
>
> The doc states that 'If CONFIG_LOG is not set, then no logging will
> be available'. But a few lines below 'If logging is disabled, the
> default behaviour is to output any message at level LOGL_INFO and
> below'. This sounds inconsistent to me.
>
> I see a lot of To Do tasks listed in logging.rst, like converting
> some other logging statements like debug() and error(). I wonder if
> something can be improved, and in case how: I could commit some of
> my spare time.

Yes, you are right and this is a good analysis. The todo you found [1]
is a good starting point, but anything you are able to contribute
would be valuable.

One point I'll mention is that we do what to support the kernel-style
logging so that code is easy to bring over. But those macros could be
converted to use U-Boot logging. Then the log-level problem you
mention could be resolved.

Regards,
Simon

[1] https://u-boot.readthedocs.io/en/latest/develop/logging.html#to-do
