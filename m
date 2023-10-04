Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4570CE7C4E7
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 17:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D7A687606;
	Wed,  4 Oct 2023 19:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UGY0GM1J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B46D875D5; Wed,  4 Oct 2023 19:58:31 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 728B7875DF
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9b64b98656bso24697166b.0
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 10:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442305; x=1697047105; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DlqI6LJI0CtKas+PpxQVE5Ptnn3hDVaoqFylKmqQ1Ys=;
 b=UGY0GM1JRpzoa+cqqXlOuilX8RMn4y09Czo0ht//TreCMVvVy/WnfPKKS/fVggY1ak
 HeZHLItZiLS3yvVQinDB0mCWYkwbnNQGeJS+T+u9MENd4KilBTXoC5oHIPNtDew27hDK
 l4mNCyqr5FkIVvzZxcbmTuKUcwOcghFfNkR90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442305; x=1697047105;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DlqI6LJI0CtKas+PpxQVE5Ptnn3hDVaoqFylKmqQ1Ys=;
 b=PRNw3bjPL+V/jKdmaa/UT84/3IdNqaSThysA8vD7IWddFlKm0Lt1uPP2jHkBm0COSO
 xyVlqNq3YUU0MS458lAl7hniQ0A+hRSxyC8j0e95BIwZ8yMSLlfPlRolPNn0jfb8GmKX
 q8IVuU+WbIFDpFyDNfx0ypQK1UL9I+q3CclJJRIXWjPy+Ilz36JeNyG4fH7KJYCAjHUZ
 XtgDDsqrbKPQ5H0tBA4Z0jUYGPp0UGYxFuOQ8uNJGvbpyuOhpz3zOmLP8IRh/qSHhJGr
 pgHs9nchG8e2BFbGo/RbNu6O8U2G1SuVykHEzpSMShCawChIiouSx8GZeRAx4WoSEVQT
 P7cw==
X-Gm-Message-State: AOJu0YyZL8ODcJt2WhUSENwkfJ0dHl5tosEdjF6lgmiSTKhJM9/uYTzi
 dTHucj1enpik5UD472NHHwkFP07OGbPwfUDbanyAKw==
X-Google-Smtp-Source: AGHT+IFe/xcoylWm8Wuir6ppvXX2XfhIKC1DyUgLPzACwY+mbenYg7XFi/oqCZ9WNjhsLkWTx27Z1P75CTFhpSTos20=
X-Received: by 2002:a17:906:1017:b0:99b:627b:e96d with SMTP id
 23-20020a170906101700b0099b627be96dmr2731833ejm.44.1696442305377; Wed, 04 Oct
 2023 10:58:25 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 10:58:24 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230923194424.1739224-23-sjg@chromium.org>
References: <20230923194424.1739224-23-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:58:24 -0700
X-Google-Sender-Auth: S4tmvtNJduplKs6tqVGvy2vxHz8
Message-ID: <CAPnjgZ2Q7jDyqkR63=1ws+g4LR6LGOAuYUkbuFWULad05diEXA@mail.gmail.com>
Subject: Re: [PATCH v3 22/27] moveconfig: Show a summary at the end
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

Rather than printing all the failed boards, which are now easily visible
on the terminal, just show a summary. Sort it by defconfig and drop the
'_defconfig' suffix.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

Applied to u-boot-dm, thanks!
