Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFA6C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 05:06:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BA5283443;
	Sat, 24 May 2025 07:05:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LCYM3r3i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65FD2834A3; Sat, 24 May 2025 07:05:49 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37218833FA
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:05:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5efe8d9ebdfso977169a12.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748063143; x=1748667943; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QVA2AN83bNrZ3m3NwqdJKf0+EDdack3lBG99n0LephU=;
 b=LCYM3r3iKTSFsuFUg20pTjSvuY1p2ka2r5BfZAkzXG89SIMKByTZkWdyRzRgE/v9r4
 QVxv4Y/7gLCJTvlBZRH9Jq47FxAe1XGrkNl+w5JdDCStenQj46pbfXV8DlvLt78QEi15
 eSs+fZQqCVzy1SbyoOLZi1/CEY0GTkexNMm/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748063143; x=1748667943;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QVA2AN83bNrZ3m3NwqdJKf0+EDdack3lBG99n0LephU=;
 b=bpV2k/2Fg4sJDzWEHqmov1q0dlvSiEecDZqDa/14R0OKRB8MaD3RKgUvogMRpPCNqb
 x/+5sTupF1Z1gYadvGzupbrPYZR0MjtRCVMrF661biAZqhn37AdwXSqZJQAoi+XlyudQ
 PI7W8PAT9dWozQaK6ckpo6gc4KSJSyU/5P0sZ5Y+mFZ17bhRBZBUQcuscRq6r1mzKZJS
 plU0+KcHUYm8VhhB5cHJ7+NAzqsGvRvd4FCLqHIHgcffdFyel999ScynZJY5usoIwuYS
 hShJsdNCBz7LbOVJhIwgyqTQhLfPMIEFCCurj/Drgm4xmycpNz+7Bp8u6nHZqoZPLJG8
 LJkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBBCIEG6qXACDPbFQjg/fqmRWR6Fj8/Q7aq1pTa2ljN2vxYRLd8rRRGtIHktQ7HL3lfreTE1U=@lists.denx.de
X-Gm-Message-State: AOJu0Yyu5Hkd9T2UT8IiTTIzv/fqjgurMYt8fm6ajagYUM8hue8p2tU7
 3isgsnHcVrLN2lmAypwJyGCT8F7+5Z5UGzk1FuU6jE898Qt64NEkvuxqBE19rbheDvQNgipjC4n
 o/DSxuEaJYRlg0zPJvdM0nPfVezA170qVmC/B6uqu
X-Gm-Gg: ASbGnctSXQyg6NKr/pDzX+wEE9CZXt9kaMZH/JOdcZojKOXLSCv1emw8/t211sDvq/r
 CLU1er8Ra4+W54K1lKfIH73zlzSGV2ibajrnvuzsVI+U1Nw8yK2CMr6nc8fGpu0MLBN0jEFYra5
 s4esBQwnt+1WKz62rJo0OIL6p6GWzDajg=
X-Google-Smtp-Source: AGHT+IG5gYtR7VUV8T16VawxgXK1TqEyzAI/2tLhUVoh4R9y/tnock1ZNjtuootBDK4tYgDHS4yfQqOd9Uy5ph+BVRI=
X-Received: by 2002:a17:907:da7:b0:ad2:1a66:a1ad with SMTP id
 a640c23a62f3a-ad85b050296mr129439966b.6.1748063142698; Fri, 23 May 2025
 22:05:42 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:05:40 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:05:40 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250510110535.1453745-24-sjg@chromium.org>
References: <20250510110535.1453745-24-sjg@chromium.org>
 <20250510110535.1453745-1-sjg@chromium.org>
Date: Sat, 24 May 2025 00:05:40 -0500
X-Google-Sender-Auth: PrYj_E5ey8msCWq3PX4oUp4fYtw
X-Gm-Features: AX0GCFu-LfOUaX2aU7bpl4fZ9KC4YLPIDzMFer2_nkir42PyR0XWBkbIDb_PRPM
Message-ID: <CAFLszTgOskNz6WkE4NywEfxcc1wm8w-fzJq_sFUz-chZXb7nbQ@mail.gmail.com>
Subject: Re: [PATCH 23/25] patman: Implement the upstream subcommand
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

Add a command to allow managing the upstream tree. This is very basic
so far, only allowing setting the name and URL. Further work may allow
checking whether series apply cleaning on the upstream tree, etc.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/cmdline.py | 38 ++++++++++++++++++++++++++++++++++++++
 tools/patman/control.py | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

Applied to sjg/master, thanks!
