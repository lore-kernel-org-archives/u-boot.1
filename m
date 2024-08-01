Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D57C3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 14:42:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 800BA88B37;
	Thu,  1 Aug 2024 16:42:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Sa4VVmjl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C98C488B2B; Thu,  1 Aug 2024 16:42:27 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A72E3889FC
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 16:42:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7094468d392so2982928a34.0
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 07:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722523344; x=1723128144; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bXC5jcxbgap0yoLi+qk/mY9RSbTOYbhp8rzxhyZ7zn4=;
 b=Sa4VVmjlKvxL3ZE/GK+AhfoFUnhTkDSVPk3Sazbt9iOmmqJaOSSStIM7jS9zaAcFhf
 wL3/oI1eqsLJcyJuhco0/eiMAFA3fHGBZumPti+0OmMK6XWSKc2IvYfgXnFNFDQYQfVF
 lZZlKoXFESr29AculS+Y7BdZ3LOH6ZgtUPEAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722523344; x=1723128144;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bXC5jcxbgap0yoLi+qk/mY9RSbTOYbhp8rzxhyZ7zn4=;
 b=OnTPfPoakL+3ndhDzsSMg+W5To+k6yQCgBqBRKjrknxYYX5Ose3UGkhz0spaiMyjBL
 47lPRU5FnUaiPom14/o90GEBzehRYyWtC6o2nj8bWCA3dlDgYBM2J1FFnNEH/le84p3i
 +AhWyKPUy5dXmOq/wODHuKLAk8i6jPDapOGMvbI2TYl6FaGAG8dfJpSCOcdZntafyBOg
 xxb//b5rl8njHWbF21WNn9RIl5oi89oymLgyPvfAIk8Z9JlHtcvWN6V19bXSelygJolu
 d3ZFk4CZzWOmYrays86fGwranpwq/d9zjFj5MdzW1yEmM2R/+HK9OXMIfd/IlJQuEhbc
 nb6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY7b3s/YgHPzln0f0DhotAaK8CWkXQ6OY+Y8ppWurv7lDfV39QFxmGaCURiEsVT+wY3vdqeCUy9dKIEw6w8UsuMWLvbg==
X-Gm-Message-State: AOJu0YyoKLLmptcSGDe0KPsNQMy5D+SG9UeMv/ZqxR+pk/44uhvXePYs
 L6m1b2s56T7X5xGE1gPv03ZsqsWTRtBRVhnKfjAGgHcDjE8quOkiXdDYswETYeiPdabGNrN90nx
 Uc3dLrrDUDeLohbJqocyW4zqnMnwh24+s5zk0
X-Google-Smtp-Source: AGHT+IF87O/jbuzSkPd7w+7SRfzQtAbg8vqW8RkBYdIpCNd+CwV2asWLxxkMe17km7RveKZMDfCNLL2ZOrKjAae7VI4=
X-Received: by 2002:a05:6358:e4a9:b0:1aa:c71e:2b5d with SMTP id
 e5c5f4694b2df-1af3baa3ed0mr25134655d.23.1722523344316; Thu, 01 Aug 2024
 07:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240729213657.2550935-1-mwalle@kernel.org>
 <875xsnqn3q.fsf@baylibre.com>
 <CAFLszTip3uwZLy=jL+-BKwD74Wk8j6So_N9TW_P16gpBvLKQRQ@mail.gmail.com>
 <D33U0UZY7230.18W0UEVD0508X@kernel.org>
In-Reply-To: <D33U0UZY7230.18W0UEVD0508X@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Aug 2024 08:42:13 -0600
Message-ID: <CAFLszTiELmY_Svts6NK730TbEWDidFUL3xnuof3fuSOW0avT2g@mail.gmail.com>
Subject: Re: [PATCH v2] boot: android: fix booting without a ramdisk
To: Michael Walle <mwalle@kernel.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi Michael,

On Wed, 31 Jul 2024 at 09:33, Michael Walle <mwalle@kernel.org> wrote:
>
> Hi,
>
> > > > -                     if (ret)
> > > > +                     if (ret == -ENOENT)
> > > > +                             return -ENOPKG;
> >
> > We normally use -ENOENT for this sort of thing.
>
> That's the way select_ramdisk() is documented. It was actually
> introduced by yourself in commit e4c928792e93 ("image: Split up
> boot_get_ramdisk()") :)

Hmm, OK. Perhaps I was worried about conflicting with a file-not-found
error in bootstd. Anyway, let's stick with ENOPKG.

Regards,
Simon
