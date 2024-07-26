Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF848C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 12:58:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 208BE884CC;
	Fri, 26 Jul 2024 14:58:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NftP5hNv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27E208853E; Fri, 26 Jul 2024 14:58:56 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B836287B77
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:58:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-663dd13c0bbso20757217b3.1
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721998732; x=1722603532; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=idla1vmget6dNiVfyIiff++DTT/woA+/U9wmQXRJ24c=;
 b=NftP5hNvHQv5ZNUmftOxvx/qgb0JVUw+v9ztIN3d+RT93x4aJ3LZDPVMWZ7KvSpPXG
 WgeBNsLkTxKzDKQ9dcEH+5QBi9izTJfRlGNygz3ZgIVS4d3y29lN0caNLtzSJa7XdeXn
 YL9qd1wWcsLJyTCTc5fI7QEGhGK32WLBHqvwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998732; x=1722603532;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=idla1vmget6dNiVfyIiff++DTT/woA+/U9wmQXRJ24c=;
 b=BzO4BvKpwWCXBBRv/1P1QyLj3phhGWIThCmcPhOA67BbfSwku7o8q8EEc6YeoK4e90
 o9K6kSQbRgDj+oiGi6HPH4nhrjLPiDY9BGFSmsIEVhpnGHZxbqkbD81GCqGYeqdTbowv
 jC4wOAcgnvQQH+zRc9oP9K/mKBTzSOpgR/M+YKkNjFWXioKlC43J3xa8a0Jmj0PTQ0zl
 bOOgytZ8FDvj0FsBzMMYUCtvTEQ7JLD6pggozoZiRADdX2TW9scWGkyIXH9CQBhpTtCS
 AM/fQe1CtlYwit+B6k9W0p7BQrr2kSX9MYe8grGnQ2P3C4eJzhmoQubFOoPHrwF8GjFY
 vZYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeJ/P3ND6vKa5XtBlXHAGpOSvPJCivXbuYgIRPmeJ0eQ/VdOBt9QKyoA795puUVGCV0FUyngsm3EIfWz2BKEN4lgHpqg==
X-Gm-Message-State: AOJu0YyHS8WUcQoGpEaH+ixUHakgylFIzJdPHC3fliFoQlezSBwsvOC4
 13fQiu9Hv/KJ7CUWr5J8VMohAN9sgL8q6jZoqW90RHClbF8q4Ed3Pl310sa7podVkvfhNaunJT/
 pfpcfYDy8gBgvEaYTnI8dZHsliVi0WpB5Dl+A3e0HRFlSf34=
X-Google-Smtp-Source: AGHT+IFFHbM/doNsXwuwvMZW7MykZbUIiwBD5sdzh8PvaFltJ7dpiJiU0mAqQGan8ybGXs/m6ywP4oZ9KCp2HtzKOQU=
X-Received: by 2002:a0d:da82:0:b0:64b:2665:f92c with SMTP id
 00721157ae682-67510920816mr62678267b3.8.1721998732564; Fri, 26 Jul 2024
 05:58:52 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 05:58:51 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240717155712.2913651-24-sjg@chromium.org>
References: <20240717155712.2913651-24-sjg@chromium.org>
 <20240717155712.2913651-1-sjg@chromium.org>
Date: Fri, 26 Jul 2024 05:58:51 -0700
X-Google-Sender-Auth: XPoKdA6SeEwrA281Ym__cghhkLo
Message-ID: <CAFLszTgki6cVhP23hb33GvJz8tBi=BbLgO20wDKcXo+drb8x4Q@mail.gmail.com>
Subject: Re: [PATCH 23/24] qconfig: Move operation check into parse_args()
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Put the check for an operation being provided into the parse_args()
function, to reduce the size of main().

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

Applied to u-boot-dm, thanks!
