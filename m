Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE6DE95A6A
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:39:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6878086DC3;
	Sat,  7 Oct 2023 22:38:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YKAR8FAx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 686BE86E08; Sat,  7 Oct 2023 22:37:56 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98B1F86DD8
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:37:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-522bd411679so5406902a12.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696711067; x=1697315867; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HCku2wrxx7BWLJkCm0a4PX2QPOtD/SBxykY4cKqhiZU=;
 b=YKAR8FAxIFCSkAeBCKJ2Yu9DBvImiYvapeTQfb5zZyPnGBxrAE3D6r11/jfu9kP0hW
 rpVnN4AZw4p3yJl5gHjoW8/vMfmnbqeKO10y8TqGc5GagMFfrqNooph16g9kYzy3KvKn
 Xu0wFesKpRb0EB8KVHIkt1qfTlgdWBRYq6s8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696711067; x=1697315867;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HCku2wrxx7BWLJkCm0a4PX2QPOtD/SBxykY4cKqhiZU=;
 b=aHyq9xvtKLJin/2j1HfBi6RxGKbQmJXX6LnonguT0d0RpYgko7goY9WkDeHhP1gZuJ
 WzKO8NX1339sp8TvesgNQeJRPxHiZ5s+6byLYHXbPvi14OGI3Drglw9xv9LcZ/xX9Dqn
 3Xz6niIMBGWrxnolOSwtWQ01zvfa8/67wEYUqchsah+IXbBrZCZBJ4feua3/L+ViF/m+
 mIXt8o6hY3mZl6FF4UgkwYA7NpeytlRSA2lMHQfGivyDH6lJcyuuuDAzKgAxKdMWRdFx
 sIbWpLKU7AUAbEA7XSE5j4Ob8WNwvOcxSH51gl3FYTxzDBZhIG23koa0yZeUEPYgSVnk
 LtdQ==
X-Gm-Message-State: AOJu0YxByYYsmqbpiq1ZboTjclQRL2YthjxSP8YytWZ/ZRfIBLGxh6cq
 dfAohbMPB0yXXSHM0CNGGeXgMeUfVGCNz3N+1GnO5A==
X-Google-Smtp-Source: AGHT+IFxMevU6e1gWJrCwSclgSInfWIU0P0etW7Gv3Z1ctnZ9eEtbGGKAFtfVlyEL8ojwgCxuXwjpwo2cdf2SFyN44M=
X-Received: by 2002:aa7:c549:0:b0:531:1241:3e98 with SMTP id
 s9-20020aa7c549000000b0053112413e98mr9927701edr.9.1696711067329; Sat, 07 Oct
 2023 13:37:47 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 7 Oct 2023 13:37:46 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ06X95fLOa6xqc1STTVB18QH2hzZn-wbiruCjp9h4z1NA@mail.gmail.com>
References: <CAPnjgZ06X95fLOa6xqc1STTVB18QH2hzZn-wbiruCjp9h4z1NA@mail.gmail.com>
 <20230923194424.1739224-20-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Sat, 7 Oct 2023 13:37:46 -0700
X-Google-Sender-Auth: q8B0PYHiMfsr_ztt0qx9cn9u-_4
Message-ID: <CAPnjgZ3=KL-d2f4-_j+PzU0YhGChYNn_7dzufKxnqph9zOCSAA@mail.gmail.com>
Subject: Re: [PATCH v3 19/27] moveconfig: Avoid showing progress at the end
To: Simon Glass <sjg@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
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

When the process is finished, moveconfig leaves a line saying that all
boards were processed (for better or worse). Drop this, since it is
unncessary.

Future work will provide a summary at the end instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Applied to u-boot-dm, thanks!
Applied to u-boot-dm, thanks!
