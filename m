Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDC9E7C4E2
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 18:00:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DA9E87616;
	Wed,  4 Oct 2023 19:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IS3gX724";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 392EF875E0; Wed,  4 Oct 2023 19:58:32 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFA72875D1
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:58:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-99357737980so18268866b.2
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 10:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442308; x=1697047108; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RPt1OGLaZYcnEgGgF+l/ADGTC626BKo+wrC0uEnA+rs=;
 b=IS3gX724Uen5d9sEwkoV1LSUFZ2sm1vZTPczGQ7F4/Vcez5Y8rbqxPcyg800PcKGWI
 raRfVZd0wRAP96Rv5EQDjkSCaQIUYCDc51LkYW8L9FbPeO8aQhb450m56FG1lsULsplf
 ddFaXdHvcS4MvvtUw28F21/Ae4nmsWbnq/d4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442308; x=1697047108;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RPt1OGLaZYcnEgGgF+l/ADGTC626BKo+wrC0uEnA+rs=;
 b=PVX9YH74kHWq/J1ed9nSQ7ERswJIfBnncE9CHSml7gSC4n824/+P5LeAJOSuHznx98
 1bYBf+Or4+6NkqOHAi4RvwmBIa+C59KRyCUlWjJe5tkGVM0jR03bnWwT9EGlP7soPFxS
 8ckx/XTTy6HHMe3GWqwIxayTBW8rsegmi8QClhRsU5CFH6Ls9H99MdyPjCheVnANqMyj
 P2QhluWYzRQ4UKbR/WxGD70kW+Tro02wrxTk0kDg/cRt6zUXXRh5hHczE2s7JkILci24
 jQhyf/fnt4jKqYIJ6bz0hKhMvea1bUVitNOffa5s/XFTbkblxZYe6VmT34n4pHTXnZlA
 Nn0g==
X-Gm-Message-State: AOJu0YwvdhhRuw81E2d8vyTBu2MSycablCB+ABkBfD73FuJ1KAI3GPBS
 cJJFbCBt8VxGBECwcrLtkpG+Smo7biZrTaceounKDy5XtxLG34ALp0M=
X-Google-Smtp-Source: AGHT+IGq4M26n0H7XhYyjskb19IbvH/TuDX7ZGwCmNvhnxQgIkoEzWUnLqB/Mg56uGvpxzAiGuWGlsNfmQWGPaT+9w8=
X-Received: by 2002:a17:906:73d7:b0:9b9:2b66:30c5 with SMTP id
 n23-20020a17090673d700b009b92b6630c5mr1668447ejl.26.1696442308183; Wed, 04
 Oct 2023 10:58:28 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 10:58:25 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230923194424.1739224-22-sjg@chromium.org>
References: <20230923194424.1739224-22-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:58:25 -0700
X-Google-Sender-Auth: RaVzmEf-vQirjaZQy-uyMPg7Trk
Message-ID: <CAPnjgZ2fO-2yeotg2NDwnFfbyuynBtQOoC5Q+CzfwLA----79g@mail.gmail.com>
Subject: Re: [PATCH v3 21/27] moveconfig: Show failures in progress
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

Show the number of accumulated failures when processing. Use a shorter
format with colour.

An unwanted space appears before the defconfig name on every item except
the last. Fix that while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

Applied to u-boot-dm, thanks!
