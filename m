Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D7BC3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 12:59:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DD65885FA;
	Fri, 26 Jul 2024 14:59:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I/QXF5UL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18BF98859B; Fri, 26 Jul 2024 14:58:59 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11F0987B77
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:58:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-663dd13c0bbso20757867b3.1
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721998736; x=1722603536; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rpVsqWyFthxo13dntag9F/XpOLhZhD6eksiBYv26N50=;
 b=I/QXF5ULNF+JFQqg5KSr9qKwl1JOtsu7BwGnbR3r3WYM930Gr6Szk903F7rk/tSq+i
 3oiNZBA2zXn3S/ZqNhqVrflTDgRyoscbEOy+blo7gVjAOV6qmQkpJBNdq2zJd1eCMm7r
 pqwvPqeL8EuKuFXft/kXUxc7Ty4ClhSy5bfhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721998736; x=1722603536;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rpVsqWyFthxo13dntag9F/XpOLhZhD6eksiBYv26N50=;
 b=QNKYuN//Si0yHNnCWMRusN0Ai3OxRV2ScgHw1mGFY9LNq3Bs4HDFdLko1oVftBgn2B
 Dm7Yl6511hT5KAkSBwdS2w09eaaSnQiixbO8ZdIcAcdqvFarz/e+TVNYjjFeik1Gd7SS
 6KEcmUhHwqYrcmEtjEdzb2jBuoEUoIwpJIjoEDV2c+rxKeXuOIXqkuQQ+XYDugOB9RHn
 kX2Mdbv+2GL8txK0CNcipbiIKpZbf8R7rOSawdmdt+J4IBMHJy8doeFRxIQwC9Oacs9r
 bavkhdEBPwcCwsnwKPIdfzEnwBeAyQb5i52UZuohI7xF3HRrB0M9xPOkh8Ge3KDG/FKq
 l4gQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMPJ4RGeBTVBXb1k6Mg0KCY7kUA5toAsnTEJBvQGfjZMUYUM8t9i1Vc/yTE1pYE9qHMtaZEb2iykKPOQFhPVMJtm5EXA==
X-Gm-Message-State: AOJu0YxWcVWDi0eNhd2U4w+3ZaEYaahdETmAnR+T8qCb6cNuPbH+wv/B
 LRxKYl6GuvIMmG/WsMQ0lFHWJrpPYuGbUj/JBCDBGrYNhLB0HT+/Oec7JkI9BVQ0mo44n8ni0vv
 CrleGpm4oCHStDrz2l1d+00GVXMC5gB3t/b2Z
X-Google-Smtp-Source: AGHT+IFpktp0ctEiVLxvchjIfXNA1KbZkfdHbs40nW/f4OAZkne/PUXnPH8qs3xpkmz4iPEgU79LdJag/yFecJqgJGo=
X-Received: by 2002:a0d:c9c3:0:b0:648:857c:1530 with SMTP id
 00721157ae682-67514c3c24dmr64486667b3.34.1721998735826; Fri, 26 Jul 2024
 05:58:55 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 26 Jul 2024 05:58:53 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240717155712.2913651-21-sjg@chromium.org>
References: <20240717155712.2913651-21-sjg@chromium.org>
 <20240717155712.2913651-1-sjg@chromium.org>
Date: Fri, 26 Jul 2024 05:58:53 -0700
X-Google-Sender-Auth: oqLI-flmmcPaSU-TYfw-lYzlK_I
Message-ID: <CAFLszTi4Fa8mYuci6cJrjVNXeN97do467euf1F9+3ES9dAEZUQ@mail.gmail.com>
Subject: Re: [PATCH 20/24] qconfig: Move the last two operations into their
 own functions
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

Put the summary and database-writing code into separate functions to
reduce the size of main().

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/qconfig.py | 66 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 19 deletions(-)

Applied to u-boot-dm, thanks!
