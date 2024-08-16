Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A5AC3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 23:54:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3C1588C13;
	Sat, 17 Aug 2024 01:54:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OEjKeGtx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A72E889FD; Sat, 17 Aug 2024 01:54:16 +0200 (CEST)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com
 [IPv6:2607:f8b0:4864:20::930])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA52488C19
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 01:54:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-842fe71877cso694371241.3
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 16:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723852447; x=1724457247; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hJSAZvhrw2dyY3ZQ1GLIDci/8uELxLTS31S8JHKNt10=;
 b=OEjKeGtxJfLsS1z5zWB//Ktv6dmIKNMBS4hYkP5vUibVTRMB+57baxX3fZDyLzijTP
 CUmc6c2Ogl6xMkaCyYUY7nlqReOMej/ryPW5xU9cHFQ04MXXNzXnhKzxvRH9oA1QDQu3
 qFDOEKWQjlV4DGkauMFgPHlN+IRxM/SyDqchs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723852447; x=1724457247;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hJSAZvhrw2dyY3ZQ1GLIDci/8uELxLTS31S8JHKNt10=;
 b=erWg/9lOiKczfzuOebvrMZtIJdlkGWpkbebswWPRbEFFrZE0TGe9ykZxgu02OHOWFF
 zPCKVrw7VNgk04T7V0lsAYU9gC8oMDyMZHmRq4JhBvOcfDBN4LfJDFpi0yL7qLFOOYGQ
 p4vkDqzMh9qCrK1WsUtA4N/e55wORLs9yit5Z7wgJ9u4z6DttMJabnHmf9vw8pBYYf8W
 MeaTc1oukIZL1oPyIohl6ZMi5sMJL5Pul0lcTFc7wFao3NUa58GqKjuwDVq/hDbjazvA
 rKn7oVf50mO7EXgtREdJ9p5VRmpVsafW8D4A3V1JDiAGKeNZ7ahugUyayFmWiy3Sin9R
 WObg==
X-Gm-Message-State: AOJu0YxKYXqpS/TbcEfav8tfDsIZh6wcuojOfpD4cYvZh/x08ynbtrJo
 /fx3hM/2rQi5/3wXL7Fd1t73wI46m0o1tZK6pqKa4UyswpqB8a58Z0rxjTTyxK5fgWuLjWvcZqu
 z2rzLjGQvqMT7UNLLvruTbqoblxxSqwAzDzep
X-Google-Smtp-Source: AGHT+IFI7m8N3VPOjRWtyB6tT/0XUb5uN6qddQZY7/SYAH/LnDfNauquMM7wEHMN7rS5M7ehqEzuZk2uL2EYdI1Qwag=
X-Received: by 2002:a05:6102:41ac:b0:48f:eb5f:84d8 with SMTP id
 ada2fe7eead31-497799a0cf5mr5768506137.27.1723852447627; Fri, 16 Aug 2024
 16:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240815195746.749042-1-sjg@chromium.org>
 <20240815195746.749042-3-sjg@chromium.org>
 <20240816172237.GA1626301@bill-the-cat>
In-Reply-To: <20240816172237.GA1626301@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 16 Aug 2024 17:53:57 -0600
Message-ID: <CAFLszTh1Nig-hs+Gtxzg8f-=vE1z4BvNSfEyUGtatZohj0pnuQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] buildman: Allow skipping the dtc build
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Fri, 16 Aug 2024 at 11:22, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 15, 2024 at 01:57:45PM -0600, Simon Glass wrote:
>
> > For most boards, the device-tree compiler is built in-tree, ignoring the
> > system version. Add a special option to skip this build. This can be
> > useful when the system dtc is up-to-date, as it speeds up the build.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  tools/buildman/builder.py       | 27 ++++++++++++++++++++++++++-
> >  tools/buildman/builderthread.py |  4 ++--
> >  tools/buildman/buildman.rst     |  3 +++
> >  tools/buildman/cmdline.py       |  2 ++
> >  tools/buildman/control.py       |  3 ++-
> >  tools/buildman/test.py          | 31 +++++++++++++++++++++++++++++++
> >  6 files changed, 66 insertions(+), 4 deletions(-)
>
> We should probably do this more generically, outside of buildman. We
> have scripts/dtc-version.sh and if the system version isn't new enough
> (and we just need to define whatever the minimum version is), then we
> build our (not currently that new anymore) dtc instead.

Yes I think I did a patch for that ages ago [1], but it was rejected.

I'd be very happy for it to be applied as I think it is a better
solution than this one.

I see that some poor sod tried to do this in Linux this morning.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20200427002929.239379-2-sjg@chromium.org/
