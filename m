Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A6AC3DA7E
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 16:23:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10478888EA;
	Mon, 29 Jul 2024 18:20:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gGxDeCMa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A1CC88906; Mon, 29 Jul 2024 18:19:50 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09736888C9
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 18:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6b79c27dd01so20086926d6.3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722269986; x=1722874786; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2kGp/hanPxgEcVc17aVzs+xLAIczk0ie3xkLmY0x1fc=;
 b=gGxDeCMaKePQFsTAalW1ucxJy9oNxDuS9fYOaZ2a53xh+7loG+sxRzOALTWTZNDRlG
 PeaFHEIhN0MpHBkt8pzntZ1CbHB4dtt5Zi0mK4eD5MdN2mHaMNjam91D0BSLd79/Sfk5
 G8dhsNakLH+NLuWTwG0nd8/OeTJ+mVJej/5N8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722269986; x=1722874786;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2kGp/hanPxgEcVc17aVzs+xLAIczk0ie3xkLmY0x1fc=;
 b=e4RJFxe6382kHWVmB5bqTr4e8cfNBriREcZhNpO4rl4gQOkqTimGEf8ogt65S43lli
 FXPnblc6Fwomnd8bPS1OtN5DQov0UYv6iZXwb+H8GJgB0RbJHACJnEib8VRWddHL07Qj
 cVS2SqwgPS+hLqh2eo56YfJ0RBNglNoH7uhYgChuY949+w8dno5g5J2K4sEs0qisWHRY
 f1lITRXmPg0Z7WLYOW1rbzfpeb/03oB4XnwNu7k5FJPEuichDzvC/0LftnCg4QG9g+dZ
 kA594JdhbGzoPVmIS1D0wn8GPjP1MAsrImrwBbqCEXQB6CJhYGn8pcS/5keAlolO+A3o
 bhkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVOqLuhDkmAe2eRaGj1d8EYx4rL1MFyf4Y1xiV83HEkixOa0RJ8Oo/l12qm4lYrthQEeR8+VMbm5BzQwG4eyeoqi3/xw==
X-Gm-Message-State: AOJu0YxKhdtMCXNRq9Fq8QXtnawQndJ/hJ8EIGYRxAHBekUDE3QdGB7g
 aer35O/BsdMUeaRiBjEhiAlcUz0bMVKnwagJ5V1Jl3Uzs5rEnoD+Do4bP0Y8/yGT2SXn0quvaUm
 BGT/PZ0hk0Nu9WKG8rEu536bmxPawONMdSxn4H01qhbIwxxU=
X-Google-Smtp-Source: AGHT+IEV5wqleoY9zAmVAfzhyOAN2YOcwYwLRHayxQxnBAJTNqAFsNS7yiWz21xa8y/d5vdX1RcordYhVxv8oxekz7c=
X-Received: by 2002:a05:6214:1943:b0:6b7:9401:bb7d with SMTP id
 6a1803df08f44-6bb55ab9ea9mr132768806d6.37.1722269986001; Mon, 29 Jul 2024
 09:19:46 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jul 2024 09:19:45 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240718091125.3788990-25-sjg@chromium.org>
References: <20240718091125.3788990-25-sjg@chromium.org>
 <20240718091125.3788990-1-sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:19:45 -0700
X-Google-Sender-Auth: jn1fQZ_XdtVNzCsXC9jgWqaozG0
Message-ID: <CAFLszTi4L4DW1j3iaEX=KDgAQF=VxN0ttBw5wpY1dc9ZNPmk0Q@mail.gmail.com>
Subject: Re: [PATCH v2 24/26] qconfig: Allow searching for CONFIG values
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

Add basic support for searching for matching of non-matching values.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/20

---

Changes in v2:
- Drop debugging

 doc/develop/qconfig.rst | 14 ++++++++++++++
 tools/qconfig.py        | 15 +++++++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

Applied to u-boot-dm, thanks!
