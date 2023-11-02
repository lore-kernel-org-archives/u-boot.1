Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A963FC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 22:51:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C096D87725;
	Thu,  2 Nov 2023 23:49:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VfwfxlA/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A8B187743; Thu,  2 Nov 2023 23:49:40 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC5B0876DF
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 23:49:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a7fb84f6ceso18305557b3.1
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 15:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698965373; x=1699570173; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5E/ttJxXm9dtITfiYgq3EcNlE5zdy/8vwOC0E9PlJs0=;
 b=VfwfxlA/zH6L3Oif+iwFzQPnXonEIxj4sNBHRMIboVkyCmAfeSNJdCkE+TjJ2NhzFw
 5x9Hd5CmKVGfmj+wF/GSyx3STa3gSTmK2QZrZRtf42iX2HYMliTrpuQrIlIZjWuPcKKM
 9JKw1eb+tg1NnXt6LXlMkXam0m3Pa1cu6NDyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698965373; x=1699570173;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5E/ttJxXm9dtITfiYgq3EcNlE5zdy/8vwOC0E9PlJs0=;
 b=w+nRY1ubdCuuVAsxB8AluS0otXgByVRKqdo5gLm2lwoC/sWOktrXRS2A5TP8IA1JCM
 OaBR83KM4BUTMB/SxCpCWu7q1D8A9NQYjRyjxytU1fG8Jzyv/lUeIChHfKhx57ABudRL
 uzc39fI19OEFdnL8j1HJmlhLXko8wOruSW6Cf1rVeSz5VUYoducc2DhJgVABF7HWEoj9
 kzkHMfHSXT+l6vn1tAvgypxS3q14LCGAZlKjjr88sUDrjFRz4laf11B3r3rBtCezNCIe
 zcZowGrLc5tN0ozfLmms0BQH+A/9BKItMk8Az0QFglYVQVUQx5karr2Gb0gr5cipmW26
 gonw==
X-Gm-Message-State: AOJu0Yz/QtqqGo8O1rjlifHeuahF3qaKJtsunYYIoXA5HkXOJUMIeUuC
 cjBnrUu85m8wgbZheJoVDtM5SnqQBGnZ/mgn3609tU8oJaU5KZAG+E0=
X-Google-Smtp-Source: AGHT+IFvfUyzkhWrjwm9CX4cQexAZrl8ejtOjj+lo+5hDNrACLsDkQYnKV8nzBW+oDn0ydL6mMq8HoXUqrsOXpwOzDU=
X-Received: by 2002:a0d:d94b:0:b0:5a7:ad67:2b67 with SMTP id
 b72-20020a0dd94b000000b005a7ad672b67mr1151499ywe.5.1698965373327; Thu, 02 Nov
 2023 15:49:33 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Nov 2023 17:49:28 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ1U-EYeSbhQ_HEM0do8RhPBW_XgLUewXUTtWxnkOCjcAg@mail.gmail.com>
References: <CAPnjgZ1U-EYeSbhQ_HEM0do8RhPBW_XgLUewXUTtWxnkOCjcAg@mail.gmail.com>
 <20231013011924.23877-1-maxim.cournoyer@gmail.com>
 <20231013030633.7191-1-maxim.cournoyer@gmail.com>
Date: Thu, 2 Nov 2023 17:49:28 -0500
X-Google-Sender-Auth: LWUEaWzah97R4mJgpE9-kJnno5U
Message-ID: <CAPnjgZ2V0QejBkqyCB98rt4v7AZbuOp-cDHFy5oA0GBsXjvk4w@mail.gmail.com>
Subject: Re: [PATCH v2] patman: Add a 'keep_change_id' setting
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Maxim Cournoyer <maxim.cournoyer@gmail.com>
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

On Thu, 12 Oct 2023 at 20:06, Maxim Cournoyer <maxim.cournoyer@gmail.com> wrote:
>
> A Change-Id can be useful for traceability purposes, and some projects
> may wish to have them preserved.  This change makes it configurable
> via a new 'keep_change_id' setting.
>
> Signed-off-by: Maxim Cournoyer <maxim.cournoyer@gmail.com>
> ---
>
> Changes in v2:
> - Add missing argument to send parser
> - Correctly propagate args.keep_change_id
>
>  tools/patman/__main__.py        |  2 ++
>  tools/patman/control.py         | 12 +++++++++---
>  tools/patman/patchstream.py     | 17 ++++++++++++-----
>  tools/patman/patman.rst         | 11 ++++++-----
>  tools/patman/test_checkpatch.py | 16 ++++++++++++++++
>  5 files changed, 45 insertions(+), 13 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!
