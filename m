Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54675C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:32:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30A68888BE;
	Mon, 15 Jul 2024 15:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="obwhmLn0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02B9D8885C; Mon, 15 Jul 2024 15:31:28 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE14488856
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6b553b1a159so26869956d6.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721050286; x=1721655086; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QB8xHiAzAA1sIc9mDXcqAMgl35HD3Rnfup6f82n61mA=;
 b=obwhmLn0hbNXaYVou+sCHcHr5OKfiE3sJVF+T2pvJJ4vmbW+4FcyObNhF6HAk0PE0j
 McJgaMI8u5AQilfS97/urmghAQmyEGIgVZYCpAuUh9R7RtACZVi3jtlyU3fYcNCWkonk
 9b3Hbzk0JsKHLgl2Tvh+ysJU1c4xDzEhI2BPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050286; x=1721655086;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QB8xHiAzAA1sIc9mDXcqAMgl35HD3Rnfup6f82n61mA=;
 b=XcT2cMKh4584mGbQ4eJuEjUzA6dz5bVIMaDVI8+L0UsCTa0+9pEPhU7K7cq6YpWIWM
 bv8ydTLbWZJQGPNOgBWJ5UCT4qNJjWUP5It1LOA+ZTBKkuuooPYHcD6a9POBqLlgp0jW
 Zilbw6kVCH0yRgOlnUI6N7COXYan4rkgjmjY5mLvQxWvgKh7ocdthDNOOTS0QKlxcDo0
 L7ty/7iF9dT9lZy/a5KYcGPJlD3MpDiVvu9oBfK48vSqM7NUCVt7JPdGeJai1Dv+ohVK
 zh40J1jR0NBn/Gi9tPZcOYa2ZktHxv3zkMyb/m+qODIy5C6568nupoJELDWpV6KEA7ck
 rtFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAyslqIqBbBjVsR+bOCxutLDs/DePWxkMSPBTP9sIcd79glgAl3wEobX8Pl2TCphhY3nP9zr5TigvY1GCk2anPkvMPFw==
X-Gm-Message-State: AOJu0YzSNVQD6Ifbw9jvHVRvGl+Hg0bPOX/06i17GnuwFju522uQ1ti1
 F/OMnPIH74Gn7xTiD5igsREsFVWQPwGiOCJMa/eSTbn0yy2V+s586wuQarvymloX6wSNdarErST
 XsMVu2Qg1ZUhxatEnZq2zEiNniAcagyfjN2zO
X-Google-Smtp-Source: AGHT+IGClrgWrFds1V6F3bBFDiXr8HJiHwe2A22NiQXCIyE6U5jSnRj1MNFhRqflSwyjgluDS/5KI64FP0f+aI6Cj24=
X-Received: by 2002:a05:6214:4018:b0:6b5:e2da:8be1 with SMTP id
 6a1803df08f44-6b61c1da297mr247326506d6.55.1721050285791; Mon, 15 Jul 2024
 06:31:25 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 06:31:25 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240623175515.1466908-15-sjg@chromium.org>
References: <20240623175515.1466908-15-sjg@chromium.org>
 <20240623175515.1466908-1-sjg@chromium.org>
Date: Mon, 15 Jul 2024 06:31:25 -0700
X-Google-Sender-Auth: iRMtQffwqB_wc-50aGG01BDI5ws
Message-ID: <CAFLszThyw1nJz_sW_cUcWZPde4LDVVAvWpL8wZA6F9nwic1b4Q@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] buildman: Add a way to limit the number of
 buildmans
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
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

Buildman uses all available CPUs by default, so running more than one or
two concurrent processes is not normally useful.

However in some CI cases we want to be able to run several jobs at once
to save time. For example, in a lab situation we may want to run a test
on 20 boards at a time, since only the build step actually takes much
CPU.

Add an option which allows such a limit. When buildman starts up, it
waits until the number of running processes goes below the limit, then
claims a spot in the list. The list is maintained with a temporary file.

Note that the temp file is user-specific, since it is hard to create a
locked temporary file which can be accessed by any user. In most cases,
only one user is running jobs on a machine, so this should not matter.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Move the binman assume-size feature into this series

 tools/buildman/buildman.rst    |   5 ++
 tools/buildman/cmdline.py      |   2 +
 tools/buildman/control.py      | 140 ++++++++++++++++++++++++++++++++-
 tools/buildman/pyproject.toml  |   6 +-
 tools/buildman/test.py         | 121 ++++++++++++++++++++++++++++
 tools/u_boot_pylib/terminal.py |   7 +-
 6 files changed, 277 insertions(+), 4 deletions(-)

Applied to u-boot-dm, thanks!
