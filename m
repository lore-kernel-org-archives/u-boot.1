Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9450BC47073
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 16:50:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E22BB8789A;
	Mon,  1 Jan 2024 17:49:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nB2zSpQK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C3AC87084; Mon,  1 Jan 2024 17:49:34 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23E1F8772E
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 17:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7815aad83acso324945785a.0
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 08:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704127771; x=1704732571; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bqwPyoSYZRvH/EcHaH7A9frby2UFcbjXLveH/FFJjhg=;
 b=nB2zSpQKyk5q2SN0L3BtZhbYQA5Cbzeu10XkXj6IxDjQp32Nl2IugxMTkXvTMR5EUE
 INI04mOH9agffhw4QkcAaIbO8MHjd+TwkglfJGwAhdfrZurIX8Ny4MD7xmio4I7fisa6
 VuylX3HND6c/jIkgrdD4bCidMDainNh/iZXUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704127771; x=1704732571;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bqwPyoSYZRvH/EcHaH7A9frby2UFcbjXLveH/FFJjhg=;
 b=FJtJ5P3JnLo2WQmKJEoMdLkJzNcXvPzowhD0BOLDG52Wek84CSYFO/Lyp54cFei/GP
 FmSGDpxdu9v1FuNzgEXHY6GXVFmKGG/yuYsQtLXzMe7orq9Cze5yDtOyL7+mhFlfcyIy
 TwUFv7Eq4Dgs4+/JpgoTqiqhsxXgesonwZ88q55zPeevv0U4BvHPHFzdNSgzSx00SnFS
 0nQ89JEwxSJJuhxOlcb13rg+aQ4vEw0/GRSvsX5WsncjLgEWrGDxvR8v06b5qkJnhCJB
 Fy+Wkp0QZmwjWPLFxsH7NessC4ptBkz9qByuj6ZnwPjUPm5LJPqHXvFrLr9tOE7hgld2
 s7EQ==
X-Gm-Message-State: AOJu0YyG4+IWD4C2kYQ3EUANZ/CqTNd2qVOlhtQgXQDTZrmGl258EKRO
 FqhJRCy8gFd6TRTUDJ2OlbSk7DhUv4ADTe2peFZqBOfSOADt
X-Google-Smtp-Source: AGHT+IHyfWUmZ92c9YV4jgAI6hm9QKH4yv2IVKvug+1fsheB+2+GhQE6lIRzCoQ27zfQ8AXzWu2sz3DumGrgQmaef6o=
X-Received: by 2002:a05:6214:c44:b0:67f:2f0e:af53 with SMTP id
 r4-20020a0562140c4400b0067f2f0eaf53mr24197392qvj.50.1704127771000; Mon, 01
 Jan 2024 08:49:31 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jan 2024 11:49:30 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231217163627.2339802-3-sjg@chromium.org>
References: <20231217163627.2339802-3-sjg@chromium.org>
 <20231217163627.2339802-1-sjg@chromium.org>
Date: Mon, 1 Jan 2024 11:49:30 -0500
X-Google-Sender-Auth: bdGfWBa9qF51EK-qTBWlUz_9ILY
Message-ID: <CAFLszThR3Qd24zAvH6i+SMSoYDeFc=PHHatYogGfnWX++cKO_A@mail.gmail.com>
Subject: Re: [PATCH 02/10] fdtgrep: Tidy up a few type warnings and comments
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

Align the code with the upstream version at fdt-tools which had a few
tweaks before being applied.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/fdtgrep.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

Applied to u-boot-dm/next, thanks!
