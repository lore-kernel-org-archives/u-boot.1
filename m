Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F84DCDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 03:31:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD83F86F22;
	Wed, 18 Oct 2023 05:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hLyeumrf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34CA386B05; Wed, 18 Oct 2023 05:31:30 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C61A86F27
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9be7e3fa1daso638764466b.3
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 20:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697599888; x=1698204688; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DFtvQ3X14QNC4T9wd/IxRahgmtc0F6hjvt1Jhs2Q5+s=;
 b=hLyeumrfgopejdpS3Jto7UktEkPlkqV7UlMzZxIDURooZFUN5mpEnkg57BMF/g88lr
 3YfA/ITml51VUfomu32o86lGd9jIV81+aItQcUrB02io2jhVPF0K07wkr8Ik4KbCbrmd
 RFYbeCz6inLCsl85fxxiMwwlyWkDcr1EojvjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697599888; x=1698204688;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DFtvQ3X14QNC4T9wd/IxRahgmtc0F6hjvt1Jhs2Q5+s=;
 b=axKArpaFIWMI59OI14FkaW4qqpsgxMHt5P6zoUCwFcS72c9geAC+RqDocQun77+vGN
 BnrBokBiGU4ALUKRbMVjQhMgz+yTK+sWZbysm1vE6t2b3xFnPvAiJYb7ekifxB5mI0Un
 rJ3Qh5FYLmJJnX0V2ER5T0rc1hnD5TToY09SdI0EJ5cYtl0iAH4G8XXFnO0M5kziCxnz
 rWfjB9SQcNn8m/MoDAgGmFeQZXeRNAV9ZiksZ0ff/sI3wbg2b7qhYAbMsWaN2iF5PTT8
 VOlCtzQTtLRlszZAh4lYSyV30Ia1aGr0XF/Ju648vBN1nfULUWqh2sEoJmESn+mhoxV2
 XuMw==
X-Gm-Message-State: AOJu0YzMgwvJz8NcVVeube1luNi7NLM0/+/rDl1XTcT57PqP9IH93qaL
 SrGqcQDEYRpVdLFnVODlV5bFERbenZhq5bUhTrLJBQ==
X-Google-Smtp-Source: AGHT+IFnh3X3hZLdfXYNXULChswWoBe7H3AmIIPo0J8AXHj0ZB9Jno2lSkx3ilHbu+AXqrd2x+6uMr6Q1zH+K9uqrvs=
X-Received: by 2002:a17:907:1b22:b0:9c4:bb5f:970f with SMTP id
 mp34-20020a1709071b2200b009c4bb5f970fmr2837843ejc.32.1697599887771; Tue, 17
 Oct 2023 20:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-17-sjg@chromium.org>
 <20231017140354.GX3119521@bill-the-cat>
In-Reply-To: <20231017140354.GX3119521@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Oct 2023 21:31:15 -0600
Message-ID: <CAPnjgZ2bvsGsOieQSCMuyF1ZDQuu0+udL5Q4UpxmLcP0qPKiQA@mail.gmail.com>
Subject: Re: [PATCH v3 16/32] net: Depend on CONFIG_CMDLINE
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>
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

On Tue, 17 Oct 2023 at 08:04, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Oct 16, 2023 at 04:28:07PM -0600, Simon Glass wrote:
>
> > At present it isn't possible to use networking without the command line
> > enabled. Add this as a condition.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Reviewed-by: Ramon Fried <rfried.dev@gmail.com>
> > ---
> >
> > (no changes since v1)
> >
> >  cmd/Kconfig | 1 +
> >  net/Kconfig | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > index 148414f011df..c6ea5c860e33 100644
> > --- a/cmd/Kconfig
> > +++ b/cmd/Kconfig
> > @@ -1694,6 +1694,7 @@ if NET
> >
> >  menuconfig CMD_NET
> >       bool "Network commands"
> > +     depends on CMDLINE
> >       default y
> >       imply NETDEVICES
> >
> > diff --git a/net/Kconfig b/net/Kconfig
> > index 4215889127c9..25d494e1db46 100644
> > --- a/net/Kconfig
> > +++ b/net/Kconfig
> > @@ -4,6 +4,7 @@
> >
> >  menuconfig NET
> >       bool "Networking support"
> > +     depends on CMDLINE
> >       default y
> >
> >  if NET
>
> Please unwind this in the other direction.  What in network is depending
> on cmdline in a non-trivial way?

I can look at this as a follow-on, but I need a starting point. See my
other comment.

Regards,
Simon
