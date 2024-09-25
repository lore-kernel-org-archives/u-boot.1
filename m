Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29AB4C369DF
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 12:50:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C1ED88B13;
	Wed, 25 Sep 2024 14:50:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I6kS1Bzz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2396888B79; Wed, 25 Sep 2024 14:50:17 +0200 (CEST)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CBE188216
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-84b420fa8d4so1335391241.2
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727268609; x=1727873409; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GfJda2jPeEK8wY5Y2+SLvGlZQlLMzMR0L6VACpM//JI=;
 b=I6kS1BzztKB0Gabmk4NPZohbhtG+aJ1wMCpqw5GEdqu8xGW7hEYhGkV+oAzVQeZME2
 ntwtG0Vrz66s1yiuNsZPPs+kIHuNzVh3CHpP0LdpzoHFGtqEdd2/Ql2dmZZXwsSGinZu
 hOFpUCwIXKMfGNn+K02ON7pb/BRkSSq+l2VV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727268609; x=1727873409;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GfJda2jPeEK8wY5Y2+SLvGlZQlLMzMR0L6VACpM//JI=;
 b=xTZsa156OefylNIqPtxnlHMNSiZBy880SjoH+JDt+opZj6cxMA09hRd4FsGneSmhU2
 f1eC8SLeltDssve2QnfP/bQT4QnB4/hh5W0WvIqKAYFJkh5GqlJXdZOLCa3Qrl1KuVTh
 qFU899CkpX2Qy0kzE22MtM8IIQWIUlSkbsZwulBt7uvcgMg5eyB51hcv6sB1h2VPc3IW
 VF3vZqpp/3R1USLJJ+vlRnhE06tGegh1kjuJG9y1Hq0cvqFrPPagpplwNpNeqxgC7fkO
 B9y/sY+OCxD7Tz5+jYtWyvVaW8QCKC7yt4NJ1lU6lg0ltIwUqCOg1rxtJGzBwrVY2Jfa
 NL4w==
X-Gm-Message-State: AOJu0YzRm7kSAPF4Fji8U0rzkeKU2gn1u4pQMdhi8sldMpYpcdTw8mVq
 ovQ83d+h3lUDM72V40kaYX3zmMOlE1ONuyHEpxtQp5Q8aKkxQhEu5H/Xt7upciBQNhZrcYpclq5
 3zLQsHv+uhmFNV8EYcA/0Z1KFl33ONhHdmFtR
X-Google-Smtp-Source: AGHT+IHUGY5VlGSHErgpH61MsSjNDfSIszMk6N1tJBA4+ho3p4wxErbRKtpdG1aSAOhD8diXxCik9tsCxx7riGToYLY=
X-Received: by 2002:a05:6102:512c:b0:49e:92cf:87e3 with SMTP id
 ada2fe7eead31-4a15dc9347fmr2509574137.7.1727268608948; Wed, 25 Sep 2024
 05:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240920060158.106612-1-sjg@chromium.org>
 <20240920060158.106612-2-sjg@chromium.org>
 <20240923203512.GQ4252@bill-the-cat>
In-Reply-To: <20240923203512.GQ4252@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 25 Sep 2024 14:49:56 +0200
Message-ID: <CAFLszTjT3RZYChMhBxUDsf6YC-7cZfh1_YhuQrin3sRanSO=Xw@mail.gmail.com>
Subject: Re: [PATCH v6 01/19] test: Allow signaling that U-Boot is ready
To: Tom Rini <trini@konsulko.com>
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

Hi Tom,

On Mon, 23 Sept 2024 at 22:35, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Sep 20, 2024 at 08:01:36AM +0200, Simon Glass wrote:
>
>
> > When Labgrid is used, it can get U-Boot ready for running tests. It
> > prints a message when it has done so.
> >
> > Add logic to detect this message and accept it.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  test/py/u_boot_console_base.py | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
>
> What happens is that labgrid can also be told to look for and then
> interrupt autoboot, just like our pytests can do, and the system is at
> the prompt. But this is also what it's like for a system with autoboot
> disabled. Do we actually need this patch to achieve the functionality
> you want? Doesn't that already just happen?

The point of this patch is actually to remove code in pytest, by
allowing it to skip all the banner-detection stuff. It does not affect
things in Labgrid, since it still needs to watch for banners, etc.

Without this patch, we have to tell Labgrid's U-Boot driver to do
nothing, so that pytest does it. But that is not a good idea, since
Labgrid has a lot more info about the board than pytest has. For
example, look at all the SPL-banner-count stuff.

Basically, without this patch we cannot use '-s uboot' to tell the
Labgrid strategy to take us to a U-Boot prompt. We must just use a raw
console with no strategy, relying on pytest to do all the work.

I hope that helps explain the problem?

Regards,
Simon
