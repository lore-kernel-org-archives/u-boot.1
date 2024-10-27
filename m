Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA39D13572
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 17:17:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77E2D88F71;
	Sun, 27 Oct 2024 18:16:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D5FaEGXU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9247B88FCE; Sun, 27 Oct 2024 18:16:54 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AC8988969
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 18:16:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a99f629a7aaso566892966b.1
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 10:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730049410; x=1730654210; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Dj+io7unaMRZsblRaE+g+IH1KIC8CzubB/LfAIqBPbk=;
 b=D5FaEGXU4xgB+HaVw6HKNQ+IMJZObUZvt8+Zzlu11zMId188Gb3PAoabHOJETfMkvo
 VIv3i1uB+LraL5ZYhlNh5bPD/pr14UXsLwdvIM/sI/7Uy5ozWYxB9B9sWnXeon4QpUqq
 MWvoZDjBNiPlYH1m++t8YQs18gDpP5xs9yd/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730049410; x=1730654210;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dj+io7unaMRZsblRaE+g+IH1KIC8CzubB/LfAIqBPbk=;
 b=dbQX8EiecKtDPRwKoj0sDc1kcSknax+cYt7l0mHup1f/UE1hHdFC/iXDBZLJQOEmew
 Fap+0gCynMxEKmRlFK8OZOFBLK4QYioYlyi/nzTVPj5Iyl5ycjDESiWpEXP5NOd/K9Dt
 EE2lh2sQ09gSKjST1HXIiPiK2awZ61Jjz67HDmKds2qNMAY4MubfJWuQZV+9HiZPlZtS
 EiGs0sNpyBpyaX0cGLXgCd4WKeQz9jKhO1YOtkf7UP1cGntOywvg8TSlg5pErXFBjoJh
 RyDi/qhaxV0UhDsDEzyK7TFySSZvy/bBNE3B0d26QvORUKVIYYgR3eG5e6B9rD4kepvp
 6NRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ358HpIhKIg5ih3PJNuNj/xTRmRELyRbzNw/9Cxb9goiiA23QnQaRlL0suCHNLAZ5qFmjEFo=@lists.denx.de
X-Gm-Message-State: AOJu0YzyvVoGiwsuiXxufQNk9SsGLcWIqqvJQXy9c9lbx2hlU/kjfXiv
 O6Fe2ubLJnjqHzPHzNN2D11aWHbSZ242SYAe9YhP8ksHuY5BV6ViK6u5/D3MtW0QMiI0TApMZVU
 MR9S7p19KDzZuvzmXOsYC8OOdrgEmnhDGMF6T
X-Google-Smtp-Source: AGHT+IHepKa7ajtnWNW4CwbsFDL/BOgOFxXopbphMuYttbwudRHNtGToMa/b+aQhNwrUo0IwShRii/lqHVqTmJ2Ml9M=
X-Received: by 2002:a17:906:54cf:b0:a9d:e1cf:b9d3 with SMTP id
 a640c23a62f3a-a9de1cfbd91mr447928066b.12.1730049409818; Sun, 27 Oct 2024
 10:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
 <20241026064048.370062-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241026064048.370062-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 27 Oct 2024 18:16:36 +0100
Message-ID: <CAFLszTgYZeYruseF9TptQQpQjDBdSXaF=c+v2YN+N7Gjy+VHAg@mail.gmail.com>
Subject: Re: [PATCH 1/5] fs: ext4: simplify ext4fs_iterate_dir()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Richard Weinberger <richard@nod.at>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sean Anderson <seanga2@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
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

On Sat, 26 Oct 2024 at 08:41, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Remove copying a pointer with a cast to the very same type.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  fs/ext4/ext4_common.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
