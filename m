Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D29CD37A7
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 20:01:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C20286501;
	Fri, 15 Sep 2023 22:01:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fi+s7/f6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9A3C86504; Fri, 15 Sep 2023 22:01:47 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12D0E864D7
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 22:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50300141a64so111487e87.0
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 13:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694808105; x=1695412905; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IFcuYGY0WI+mPAK3Rx7vGX0ZC0WhBZ2O0/q8QtDZLN4=;
 b=Fi+s7/f62GgTydlf4qGhgXMhY97SYbk1vJgjHtYIXGpVX4CRswBjTZAhPBu/H7XqFO
 S8jOtryya6VgwXLi7oI2zcKRlrZ+kGO6LKkuE3egKdzmTY4kv/yOWWFc7I5EorgNrJow
 hzSUFdWCRzX9uSdAfLTfkmK79N3zr8nIK7vi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694808105; x=1695412905;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IFcuYGY0WI+mPAK3Rx7vGX0ZC0WhBZ2O0/q8QtDZLN4=;
 b=k9HTqW/Dj1ewr9k2w0Ci5eM0vJb4khskkgkmLkPySf6DqT2gGUaISgNF3C5v1OPybl
 1TJ98Mm+ULJTYGIUG31hNXfGNaS/T3Z6s36ZsK4CZuyWgS3g8BUQMSvFhebRP6SOnx8l
 3UkwpbX03MMsTvgw8KbuWRPE//aLfqnvUktivLLpiPxFrkGJ/z4uLQTjD8TaCnUbG2FE
 0ekIXglzfBcpfyot4fK73r4Vb7sZ/Vt6ztSEIqWzVCoAQR/j3VZtJmZtM6DhCWxVyYig
 A720skhes3XmEPs2JurhkziHlOSvl1m+bFAvBqKqHmEjmjkIilKlyFVuAMhHYQVMpoSx
 P7Qg==
X-Gm-Message-State: AOJu0Yy9J0Gxmeq4Pm0Yev+evguZGvmElr9halGR+CREOYb/k3kolhV+
 55730h+o4WpWDjEIPJiPvEuEG/ZIgLSLvZy9hCoHFQ==
X-Google-Smtp-Source: AGHT+IEM/h4myzh9bSEB5FPETofESLJkw0Awg3a/DwLQet0ta6WxSSNdqoIyvuG+yxGDeg4qysbi5I4kpWV09X9T0kU=
X-Received: by 2002:a19:8c4d:0:b0:502:adbb:f9db with SMTP id
 i13-20020a198c4d000000b00502adbbf9dbmr2036714lfj.65.1694808105013; Fri, 15
 Sep 2023 13:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230915002147.797352-1-sjg@chromium.org>
 <20230915194832.GF305624@bill-the-cat>
In-Reply-To: <20230915194832.GF305624@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 Sep 2023 14:01:33 -0600
Message-ID: <CAPnjgZ2Xo2+wNkH+hrKL_FetmD7vpB8dHi7mtSRNPMWHkqQLcw@mail.gmail.com>
Subject: Re: [PATCH] common: Drop linux/printk.h from common header
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, 15 Sept 2023 at 13:48, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Sep 14, 2023 at 06:21:46PM -0600, Simon Glass wrote:
>
> > This old patch was marked as deferred. Bring it back to life, to contin=
ue
> > towards the removal of common.h
> >
> > Move this out of the common header and include it only where needed.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> [snip]
> >  317 files changed, 322 insertions(+), 3 deletions(-)
>
> So, going back to the original series here, how did you determine that
> the files changed here need <linux/printk.h> ? I can see how to get
> there with some grep'ing but I think my original complaint was that we
> added the new header too widely.

Basically I used ctags to get the symbols from the header file, then
grepped files for them. For that one, it is:

KERN_ALERT,KERN_CONT,KERN_CRIT,KERN_DEBUG,KERN_EMERG,KERN_ERR,KERN_INFO,KER=
N_NOTICE,KERN_WARNING,__KERNEL_PRINTK__,__printk,no_printk,pr_alert,pr_cont=
,pr_crit,pr_debug,pr_debug,pr_devel,pr_devel,pr_emerg,pr_err,pr_fmt,pr_info=
,pr_notice,pr_warn,pr_warning,printk,printk_once

I was a little miffed that a comment along these lines from Heinrich,
with no actual evidence, and no response to my follow-up questions,
caused the series to be dropped. It isn't easy to do these sorts of
clean-ups.

A lot of files include things like net.h and image.h which bring in
many headers...but we should clean up those header files up too
(particularly image.h). So I think the standard should be: "include
what you use".

Regards,
Simon
