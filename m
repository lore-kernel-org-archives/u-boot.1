Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA12C83F3A
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 19:03:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0459F86751;
	Thu, 31 Aug 2023 21:03:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oQ7QEm+n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E9B786722; Thu, 31 Aug 2023 21:03:05 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8CB386784
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 21:03:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-d7cbcfdf137so894309276.2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 12:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693508581; x=1694113381; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hgiedffID2MyQT0GCvds6t+94Q+4FxSnljjBDZxOBBg=;
 b=oQ7QEm+nbOAxgzx7xBVXIqVn1Wyb3dBcaSW7q1f946Nb6v1m5oHVReOSqOS6on1CPk
 ylgmgs6mZ20WGuDdzFUDrgtyGJC/V9C7LRsachdE38nwxpUkftUquj49kTJ5GyBlJPpZ
 lzRqDXInIe6BTT7yi8fpcz4pnOR/RSEISDiCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693508581; x=1694113381;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hgiedffID2MyQT0GCvds6t+94Q+4FxSnljjBDZxOBBg=;
 b=PUIWUYPWbYR/HouT1ToBlg8Jc6o7rR+lwR3f2+QPk1rd1cWyW3wcrFWuoq4baNlzBn
 /PrTwV/yCA0ZhjkbBhcKLE5jdUBYhlq23j+TtvYcmuhATMGKK+XWhOrVzMv9N8Yv9k5M
 IQd44SQQ1rdPxcAsOw+kYmDTjcPdQ5q4XHIp0jRZlvvq2ymP/xnvbdstTo8Gcjw+8MvW
 SCcY6sdTC80+d+lR5nalPZeFaYQTmxMrW4zKIqn019pBX5iyy+EkPLKD04D4BsG6Fj/s
 pmj0SWCbolq+i7dOW1LtdIMqVeNCKSNiOmEa7Vtckg8sJlJ+g9oFkCFU3cgTuLZ+vJu0
 5Yng==
X-Gm-Message-State: AOJu0YwG+l5UkAkw0j2cLkPGiY9j1G5+PMsxH5vevaLt+pGTQULutn80
 Lnu5o2+8RphGgX+t9h6OOwhEt7V9URuknYB0OaWM2jZJj2OjTCcKN6g=
X-Google-Smtp-Source: AGHT+IF53Nipoavbogf37kBHUyiRbhdgCHzTTlEvNc9JRpbD1ZLvhYYhwbSzFqvkne6u2PlqiPmGukyTdjpDLKiDztM=
X-Received: by 2002:a25:d303:0:b0:d77:cd42:a125 with SMTP id
 e3-20020a25d303000000b00d77cd42a125mr654193ybf.0.1693508581403; Thu, 31 Aug
 2023 12:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230831112051.1.I3fe7ac62de70902fd1be093bcda7c53acd43daf8@changeid>
 <20230831174805.GM3101304@bill-the-cat>
In-Reply-To: <20230831174805.GM3101304@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 31 Aug 2023 13:02:06 -0600
Message-ID: <CAPnjgZ2q=EjqnguGakVjtr-5d=tQEgrk8UXF+9kc-h6cLJbKiw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Allow Python packages to be dropped
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mike Frysinger <vapier@chromium.org>, Kever Yang <kever.yang@rock-chips.com>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
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

On Thu, 31 Aug 2023 at 11:48, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Aug 31, 2023 at 11:20:52AM -0600, Simon Glass wrote:
>
> > When building in a portage chroot, we do not have the environment needed
> > to build pylibfdt. It is instead build as a separate package.
> >
> > Provide a build option to tell U-Boot to skip this part of the build. We
> > still need it to use binman, etc. but don't need it to build its
> > dependencies.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Mike Frysinger <vapier@chromium.org>
> > ---
> >
> >  Makefile             | 8 ++++++++
>
> Can we do this via Kconfig instead? It looks like we don't need to do
> this part of the build for coreboot, yes?  And so if we can drop it from
> other builds as well that might help speed up CI.

Yes it could. But I really don't like changing the board config on the
fly - we have things like 'select BINMAN' now and it just gets messy.
In the normal course of events we want to build the python things and
the build won't work without it (e.g. binman will fail). But where the
build environment has installed binman separate, it knows better.

So I don't think this is a board config thing,

>
> [snip]
> > +The tools-only build bytes pylibfdt by default. To disable this, use the
>
> "build bytes" should probably be "builds" I suspect.

Yes, thanks.

Regards,
Simon
