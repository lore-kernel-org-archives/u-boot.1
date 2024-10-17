Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797D2D3C533
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A559D890FE;
	Fri, 18 Oct 2024 01:12:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FDcYgaL9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 680778913A; Fri, 18 Oct 2024 01:12:00 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5610E89121
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:11:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b147a2ff04so128644685a.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206717; x=1729811517; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7AHwDJz28tHMY+YSBVqd1ORbdBuhznVN8k+RiC5yvbs=;
 b=FDcYgaL92dOwTFTWSFHRGRbfltRLlgWDF7J8ZZZ77l2r8bgdokbefIJ4WF+2Krg0jJ
 IAiotjXCpNH47cVJ4c79FnZKwB9rf4CGQ4bRe0r7ZC2B293Mb2EXAojqxn4V/RiuReEq
 cQ208cibanR2bd95LbBGqkKcbDg2uqMYsVhAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206717; x=1729811517;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7AHwDJz28tHMY+YSBVqd1ORbdBuhznVN8k+RiC5yvbs=;
 b=L8aErwqspq3tUcj9Nsv+dEKcPLthCU+gG6zLOgRLYAfR1VVvdHSSLoZ+yv8KtKoRm6
 bJoIucCBx10B377JfmMR6elapBXZMibnIUIQNYJCePYh9u36ti6spZ9R+xYKtdsmOLO4
 T+6WJgq6ki+DSBLhFRj0PYb98w3qoQNZUYEgoAE1snZgSw7pcgKFCoyR4mJAGzvIJqrf
 c+faZRMLTJ7fYishF95EXh/GGGJllElLKkIi9QxGVJTF2zPvb6QKpcC2zewGkV3LpiG6
 aveDLinorB0x1CgH72CLoSlNhaoe5M0mSWmwyh0MBkbdNtcYiZ10s7Qraa9lX9Z1mwyT
 +LHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS/xiDiigyW8SWbIRuaPzsLg67KlvhMmVtawccg9Ygopt2yhSS2sraCfl4cqEBzm3V3DyW7SQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyQiXKC6Yt8mOV7HPEvtMta9IBCp5uyGb5GhychjIAAkUmTzpsJ
 /HizTEMgvfsEjUkdlhqAAiwMkXu8PNTZ+LyGTzTsWoxttcrUfblJCJpk6OhBxJLmhS1u4xvNU4V
 znbhwhncXIWStBQ84jc05kLSgKh93X0S2euQC
X-Google-Smtp-Source: AGHT+IGbCzXn2HybrPYuMJixNf/haCifWP7SmZ5n6mRTPwdwcIF3krripC0QZOM/R2LLsKLzvF8X+xGg5dx6WBg1urA=
X-Received: by 2002:a05:6214:3289:b0:6cb:cd05:cddd with SMTP id
 6a1803df08f44-6cde154de07mr7697406d6.26.1729206717324; Thu, 17 Oct 2024
 16:11:57 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 23:11:57 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240930185139.2185983-2-sjg@chromium.org>
References: <20240930185139.2185983-2-sjg@chromium.org>
 <20240930185139.2185983-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 23:11:56 +0000
X-Google-Sender-Auth: jzzxsnugacwdUE4bdLuMUTCcWuQ
Message-ID: <CAFLszTiNYHuVRZSkyfAu6OWPvuKbp3AJtGuDnmJ=SGf3bbjTrg@mail.gmail.com>
Subject: Re: [PATCH 2/3] binman: Support getting test-coverage on just one test
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Brian Ruley <brian.ruley@gehealthcare.com>, 
 Marek Vasut <marex@denx.de>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
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

Pass the arguments through to test_util so that a single test can be
used.

Update the docs and add some missing backquotes in the same section.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/binman.rst | 5 ++++-
 tools/binman/main.py    | 6 +++---
 2 files changed, 7 insertions(+), 4 deletions(-)

Applied to u-boot-dm, thanks!
