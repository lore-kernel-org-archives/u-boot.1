Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FBEE77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:09:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2D6180582;
	Fri, 20 Dec 2024 05:06:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FNNtTS0U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 772678056A; Fri, 20 Dec 2024 05:06:17 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 814818036F
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:06:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aa69107179cso248441566b.0
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667575; x=1735272375; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jVlSnA5XgAFiAenCb4Wa4RuqSVvRA38sGtUl8OhCaco=;
 b=FNNtTS0UtbRWd013fNmwS3m8sLWilc06c3EQNdiCK7mjPNqIEcZq7FQFYw+zXa4bkF
 2BQnRYaSpsU38Sebf0xjxHyg0JVdbc/MNga3rfQ3sXKDYZZeGz8Pmp6ik+G+GxIvRWbK
 l3fCj3WGzTkwRAlFnk8TxRLe0Lbws8o6zxFOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667575; x=1735272375;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jVlSnA5XgAFiAenCb4Wa4RuqSVvRA38sGtUl8OhCaco=;
 b=S1GXKAlkyNn7v2VSEpofyWteYucTBw03NH9vrsi8gQ+nWMDeR/HzapG+0fcu9tBY5b
 zEx7edMm8+9O2vTyZR46xh16yBFD1oE+po5OFzQ/SFc84i0cCY9thqh+oj6Y0Y6MbPSg
 GdBri5VP5Il6sLVlS/TSlMXPKrJ5KL5dts11epdgm7p9urJwvyY402MGAhcromWsO8y1
 09SaMGHoMHjQQ05Ol9gP7yWVATwIinRQYxx2DfL1Iz3J+ujHEBpehGNlXV6wcEY91I8I
 OEqjisBDzsJKd8TZEQIG7+Dj00l8XipMp1T2TBI+Aa72D6YMML4vSNVOZmdnIloPlG+U
 Z1/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWJo+8YHaQrsRvSa+9SUpvTWPfHi+WzMQ1Wf15HW36q88JG6H+JgBU678S3+AW9zJqtZh/fEc=@lists.denx.de
X-Gm-Message-State: AOJu0YzBWMw39VY3xpXhro84swqeu43C3GutyFVNyADjg9KeZ0Wp51zq
 bDX3uqUMLiq4QtjBRqdzWopJ1JaxWnKIAlvBDGKrqzY5zIRcACCbYwpq0oyDLX0GIZjREg702yV
 pAwNCYD16PQS42io+kZVLUaL4a3wBWfRo6zG7
X-Gm-Gg: ASbGncvWxwsBdgRLqyFW3onQw1yI0bqNed1xqHTOchys06oNS2alUU8ZX/yXPNPZUVA
 +mjJjjzR+4e8W6PmNj4KfD12PGp8z1vqcbbD9tZc=
X-Google-Smtp-Source: AGHT+IESOTNeWndAVr/OwD71A93WZKW6YDwPNAvU3S6e7RHcifE5XJ20xVTjpCzO3SMtuePUPMYInxPmWE1mSp2M05w=
X-Received: by 2002:a17:907:96a0:b0:aa6:7feb:193f with SMTP id
 a640c23a62f3a-aac2ad81a25mr101217466b.20.1734667575007; Thu, 19 Dec 2024
 20:06:15 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 20:06:13 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-19-sjg@chromium.org>
References: <20241206023626.2456858-19-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 20:06:13 -0800
X-Google-Sender-Auth: EKe9rYlQxhtzQ0XtFFxYP1YvGRY
Message-ID: <CAFLszTh1zHKqo2cNo7A=oTmJ+zx-1h4smTTio9A+OdkOYdBD+Q@mail.gmail.com>
Subject: Re: [PATCH v3 18/46] boot: pxe: Use bootm_...() functions where
 possible
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Rather than building a command line for each operation, use the
functions provided by the bootm API.

Make sure that the bootm functions are available if pxe_utils is used.

Since SYS_BOOTM_LEN is not present for the tools-only build, adjust the
code to handle that.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v1)

 boot/Makefile    |  2 +-
 boot/pxe_utils.c | 43 ++++++++++++++++++++-----------------------
 2 files changed, 21 insertions(+), 24 deletions(-)

Applied to sjg/master, thanks!
