Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81D7D3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:13:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E4358913C;
	Fri, 18 Oct 2024 01:11:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KkaKNCaX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82DC189059; Fri, 18 Oct 2024 01:11:50 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FAB2890C1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:11:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7180d9d0dcbso695787a34.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206707; x=1729811507; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q2d4s3I7r0xYKVrwNO8Kxb4rhST3TzPIdXLx+ZyAxbU=;
 b=KkaKNCaX3MZtvnfXFCY4M4nzZsC+ASPforvpH38mFfBmzk5sMetpX08p1hIpQyFWmK
 1Lpy35jsNqbhXUOzhk2qq1YROrAxERqQQUul6hdWi5AdZI8/25ZcWN0Re72NEXSeryyv
 m82NgPvUt/uOnRlZmjnUdUGB2MB52uoieRMds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206707; x=1729811507;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q2d4s3I7r0xYKVrwNO8Kxb4rhST3TzPIdXLx+ZyAxbU=;
 b=eFjj7qQ9+P3zHa9VXPbHBdioQQeHvjBUNcC8HogdT0HXB82ADFub/fckZm/YTv72xb
 KpQ/SVUtPWlTTcdK8qQcYrUVZMdO74qSfAiDI3pdqZtx/8faljqM7tqdADZaedcYLy3i
 3b6fpHYQ5gThkah4giwd5UGTd0g/EUQKec7cZlC/UKuiwo2y2gIKGRmVhjHQE0OP0IU4
 u7IoZMSMvN/xnzRsyQojJJli56wJTjvKIU9b4E3YaQH9D9f/7N9XY3kI5l3TaBfvCf+0
 vPLE+4PU7ZQlXYPKcxNPBtsX/FYnWDnik0wNiTsO3giKjBDuxZ/UONpJaymfdTbNIt0v
 9VXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3k+4wcax7gmSishWPxWnQ/eKFJ4qympx5ObtkUOlu7OAFIAjg6VsB5EIPJdJtfb9OAkceqvw=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1tvZJXA7sDVuzj2VFU/VwgFbVb9b5xZnNSdYVGSYLxVo+FNa0
 Jjk7Up0T6/f7azZuHqDg+3pcwbTa+bZQvoofu89yescf8zkDmyjAv+CwIUFyixCH1jVbStneN1X
 orR1VuVo61WKF511LWtWcbN7QD/ZnatU0mmjD
X-Google-Smtp-Source: AGHT+IHrt7R3OgqccGEE3YQE75O5jgdr0ZAdVVuFAMJ6e+j7p1uhpVU5bNz6maUt34bW6QJgP+PKJWA/qxBS+3pZBMo=
X-Received: by 2002:a05:6830:f96:b0:715:4e38:a1ab with SMTP id
 46e09a7af769-7181a89affemr281057a34.22.1729206707147; Thu, 17 Oct 2024
 16:11:47 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:11:46 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241014223212.2212442-3-sjg@chromium.org>
References: <20241014223212.2212442-3-sjg@chromium.org>
 <20241014223212.2212442-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:11:46 -0700
X-Google-Sender-Auth: p_kqkVoPDsLvR9gMaBj1-UOUDvs
Message-ID: <CAFLszTh5+3BKk-y26A_o7JbYE-qgwP83DYkPyiQY9U=35anBvw@mail.gmail.com>
Subject: Re: [PATCH v3 02/20] video: Avoid starting a new line to close to the
 bottom
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, 
 Janne Grunau <j@jannau.net>, Peter Robinson <pbrobinson@gmail.com>, 
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

When starting a new text line, an assumption is made that the current
vertical position is a multiple of the character height. When this is
not true, characters can be written after the end of the framebuffer.

This can causes crashes and strange errors from QEMU.

Adjust the scrolling check when processing a newline character, to
avoid any problems.

Add some comments to make things a little clearer.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/video/vidconsole-uclass.c | 4 +++-
 include/video.h                   | 3 ++-
 include/video_console.h           | 8 ++++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

Applied to u-boot-dm, thanks!
