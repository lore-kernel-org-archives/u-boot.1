Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA439C4167B
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 14:08:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3DBD86F40;
	Sun,  5 Nov 2023 15:07:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ksLLjMeJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D555C86F39; Sun,  5 Nov 2023 15:07:07 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBA0986F40
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 15:06:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-53de0d1dc46so6095279a12.3
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 06:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699193208; x=1699798008; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tGmzFwEuUeYXcK8bW14FxhbjNtvTcmWfy3a+EJ1h9XY=;
 b=ksLLjMeJ9qnRFxsQVr7Gng+EgREEsqalXmyWKl/MkVr0Zcauk3u1+so1vNMSuP8q3K
 n9H6t7SQS6s0ECsIeB1PDHSbhM+tZ7L+bB55189j4mP1DLqOtlQxRewt4HF7VHcC3/mh
 hh3gS8IqSvhDh/paV7VIqnavbqpLJNRhZF4abLECqcL/XDDDjvuXBWF3lwmB68gV7zcR
 3ch9cCnkRJgPU0/MMScWq3EZ1FxZAtQDPkse5uZdma9Xgs6wqeqCMf7tzwo+Pyabt7Ru
 puoVN3O/yJnsR4OsVy4bShZbFjyeDM9pLiNY6/Q08MdzPxAllbSSm8xmmGj2ghwvsjU3
 GeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699193208; x=1699798008;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tGmzFwEuUeYXcK8bW14FxhbjNtvTcmWfy3a+EJ1h9XY=;
 b=sbRykGyTSLE6FYKCFsaTVVWxycFvM0hlijU54PTdJYIRBBfjtqGf1Pvhi4P0wmpLUd
 gQGHW7WGoZGB5Wh3SdoyI13Iifc2gaMhUqpRWxZ8ymQYRTpvwZAkGPdsr4fRWSbm2SPV
 lCcMo0HTT/GnvXPhV6WnKLXmE5fw+WXaMeFrIGQgattEuOx/vX0M1JW7SHb84TEPE7LJ
 8DGvJ/sjidIdr0mEY2jJAiT5orJuZ6gCqTaiqQlQt6mEfya2/Fe/SSTWIo65P6uk0a6b
 lwAaM4p4iVVAUPRRhOQvhGYU1tOqni6IiD8YSsQ+fznSGiqVQwYozdfZWcpESS8kA5hb
 u0bQ==
X-Gm-Message-State: AOJu0YzhhGPFcKnSRqGbzPlMomWVuFJ9aMQV9p3VqUMJfhxf5qygFS2G
 8z3w6A3mtr/0Y4GJA9vrzgqVYr9IPtIiwZj7Ycw=
X-Google-Smtp-Source: AGHT+IF9wasjViNrfu6BBlRJpV3C0ecPKgaD3qUVBWwjvPNLiC2MRlTLZ/Kl6xXzXlVY338vr3ydI8MXWFZqLNDkqLc=
X-Received: by 2002:aa7:d392:0:b0:53e:6013:7fe8 with SMTP id
 x18-20020aa7d392000000b0053e60137fe8mr22172651edq.22.1699193208495; Sun, 05
 Nov 2023 06:06:48 -0800 (PST)
MIME-Version: 1.0
References: <20231002011450.462468-1-sjg@chromium.org>
 <20231001191444.v3.6.I0229a119165879ecce6bafc8568708326bf5ba78@changeid>
In-Reply-To: <20231001191444.v3.6.I0229a119165879ecce6bafc8568708326bf5ba78@changeid>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 5 Nov 2023 22:06:37 +0800
Message-ID: <CAEUhbmVv69eLfbpre6YuM4otZHmTBpYGeMahtkKqzQ-DdQ1c_w@mail.gmail.com>
Subject: Re: [PATCH v3 06/12] expo: Correct background colour
To: Simon Glass <sjg@chromium.org>
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

On Mon, Oct 2, 2023 at 9:30=E2=80=AFAM Simon Glass <sjg@chromium.org> wrote=
:
>
> Use the correct background colour when using white-on-black.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  boot/expo.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
