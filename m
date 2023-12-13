Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAB2C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76FE58783E;
	Wed, 13 Dec 2023 21:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JwsUfNzm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87AC087833; Wed, 13 Dec 2023 21:51:14 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 590FA8783E
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:51:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a1e7971db2aso860228666b.3
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702500672; x=1703105472; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PNpUgfdnWzeFHnzoKuI3o9ocU7ASbx8RXhRitJdEHU4=;
 b=JwsUfNzm7Rl/jgM/Aw/JNzaiU87EV0S7gK1gbzCcOzgk1yIvhOHiObi2mIx/5KUn4T
 isLfpl2ayVPQ1nykl562vZMpvFl/vBtveFjkuYbR7n6vEKRtccaHPdySftYNWxaJYuwl
 IuTxx4o7ZZ3COx5ag26MkTU7qn/RAYZuN4yNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702500672; x=1703105472;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PNpUgfdnWzeFHnzoKuI3o9ocU7ASbx8RXhRitJdEHU4=;
 b=Ik2wDIGvo5H4z8Gw2oiJPA4HuX+JkorgPHouE9+LRrd2jBRxbGs2xgR4FU8aPEVlXt
 Cb9Znl1m5Artpe8Pp6mHYamS7P3sIYMJu2Sn+iAj6nC2pgfYTgWbLLY9J32e42lxDjqz
 k18a5PiWc2TfYnfD1R4WsSpvnYgHBTiftlg8HennRTFbPC0PA5BZRWP0JAyJTz/x5nxf
 ZfpaakN1JNyokiVDNMBi8OlO6BtFbRknSqu92a1EyxXASsESXgNm+3Zlu2NwKJlggbn9
 V3bWnMKkoTN2asdeX52ULBSo9sHtZ6XMljaweYtc63VgySJJzNTJSOgcSu/hVI6RFdOM
 n6Pg==
X-Gm-Message-State: AOJu0Yw+7H7/yqagoMgAzouylOgOWWHWX9DTvgs/hYP2+bsM3MrOgZYe
 a2CZRzqVX8CV3zkHS8FxPL3pWAYDOvMYA5F1654ntQ==
X-Google-Smtp-Source: AGHT+IElNf9x2hV6USiEN9i8Z/a8EfqD1lYB/rMaHT8fEyrXD1nwnf94Fmf5fiaCw28ft3SgpZ5cAy3mbCK3K/geBC8=
X-Received: by 2002:a17:906:1316:b0:a19:a37:ab80 with SMTP id
 w22-20020a170906131600b00a190a37ab80mr4711359ejb.47.1702500671533; Wed, 13
 Dec 2023 12:51:11 -0800 (PST)
MIME-Version: 1.0
References: <20231202153400.537050-1-sjg@chromium.org>
 <20231202153400.537050-2-sjg@chromium.org>
 <20231209154839.GG2513409@bill-the-cat>
 <CAPnjgZ0TxjEf-CvN_jC-c_7yVMb473YAjy-GH=Zrj6wwb4fqFA@mail.gmail.com>
 <20231213204250.GJ2513409@bill-the-cat>
In-Reply-To: <20231213204250.GJ2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Dec 2023 13:51:00 -0700
Message-ID: <CAPnjgZ0qK5J=Q3xPK6K5BhXi2jpSYBchSR8n7mHEi15ekLn1Hg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] cyclic: Add a symbol for SPL
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Anatolij Gustschin <agust@denx.de>, Bin Meng <bmeng@tinylab.org>,
 Devarsh Thakkar <devarsht@ti.com>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Harald Seiler <hws@denx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Nikhil M Jain <n-jain1@ti.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Anderson <sean.anderson@seco.com>, 
 Stefan Roese <sr@denx.de>, Troy Kisky <troykiskyboundary@gmail.com>
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

On Wed, 13 Dec 2023 at 13:42, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Dec 13, 2023 at 12:50:02PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Sat, 9 Dec 2023 at 08:48, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Dec 02, 2023 at 08:33:48AM -0700, Simon Glass wrote:
> > >
> > > > The cyclic subsystem is currently enabled either in all build phases
> > > > or none. For tools this should not be enabled, but since lib/shc256.c
> > > > and other files include watchdog.h in the host build, we must make
> > > > sure that it is not enabled there.
> > >
> > > This part is what I see as the Wrong Direction. There's some code we
> > > really need to share with our user space tools, in order to not
> > > copy/paste the same code. In turn, this code must be as user-space
> > > friendly as possible. Maybe even we re-factor things a little more, if
> > > needed, so that we _just_ have the library functions in common files,
> > > and u-boot or user space only files have the make use of logic. I don't
> > > feel bad about tools/ needing:
> > > void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
> > >                 unsigned char *output, unsigned int chunk_sz)
> > > {
> > >         sha256_context ctx;
> > >         sha256_starts(&ctx);
> > >         sha256_update(&ctx, input, ilen);
> > >         sha256_finish(&ctx, output);
> > > }
> > >
> > > (and so on for other algos) as a duplicate bit of code. Much less so
> > > than I do about adding <linux/kconfig.h> to a direct include list (since
> > > we should never be doing that) so that later on we can if
> > > (IS_ENABLED(..)) the existing code.
> >
> > Bear in mind that we have the CONFIG_TOOLS_... options entirely to
> > deal with the need for tools to enable features in common code. This
> > SHA thing is a very small part of the code, compared to common code in
> > boot/ for example.
> >
> > So is this really a win?
>
> I don't follow you here, sorry.

I mean that we share a lot of code already, code which contains CONFIG
options. So does it matter avoiding adding one more?

> We share lib/sha*.c with host tools for
> generic mkimage functionality. I'm fine with continuing to use
> USE_HOSTCC as the guard for U-Boot / userspace here. And I don't think
> switching these files from:
> #if defined(CONFIG_HW_WATCHDOG) || defined(CONFIG_WATCHDOG)
> to:
>         if (IS_ENABLED(CONFIG_HW_WATCHDOG) || IS_ENABLED(CONFIG_WATCHDOG)) {
> improves readability of the code.

Perhaps I am being too hard on the #ifdefs.

BTW we have a tools_build() function now.

Regards,
Simon
