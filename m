Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C49C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:31:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3664E88874;
	Mon, 15 Jul 2024 15:31:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hAbUZtH+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 692AA88835; Mon, 15 Jul 2024 15:31:24 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41D9B88835
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:31:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e03a6196223so4224940276.3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721050281; x=1721655081; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6w5RRmcXlvjpITmYhPz/UqGCdmHkoiSqAoL9x5UrG4Q=;
 b=hAbUZtH+ggh5Dn4qQCAhv9E9gaUi3/DYd3Jso6wTtLrZ2/yq7I8jDMPDwgvlVHLxsG
 J6Wm+JBqQ+DTLDpsalRSpOKyqGaxMDv2IMFGMfAa9VtBeLIiR7kJbULUj90trdNanekg
 gxuy8LYfSvKdAz6K7uS0uET6Sh/uchU7XFX9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050281; x=1721655081;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6w5RRmcXlvjpITmYhPz/UqGCdmHkoiSqAoL9x5UrG4Q=;
 b=Bh/9YvTc1alEyqevHRFczUINlK/ptCHeGFEYu+/i+3bTWi0s2tDtAGtwV7ZA15desk
 Z9qi+ME6kth8G2Hznk1ImLYL2oLpNTVxs8INKuhcgrAzlmoL3LQK/Vtoo5L+5hsyYXbz
 Chg1uo0eJJ9Ztbtwvwc1b4TZD8OU7G4qt5nOuiGruc5IzlTbMJ41VO+tXKwkQNqUqTWa
 HgOqe6fUMe4VEZUqRzzG7H6m/7qN5gXdZwXKiwaN6GKzVdOdaJpFAX3oszv8ZJXh6RBf
 4fK5ClCwyA9NU0HyDw7pc/DCZfHZgyhiGLUYBsspol1RSoxxXuy2wnbHYcg0OuP0AGv1
 XOhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGYx97slW7da1X/llX1rOww4/ELKmXfoGIMPlnQkVfpFWnsUKuCwzf7ysE+fcX5VZ8ki80StfXveg0q3+SLY+3RvNk4g==
X-Gm-Message-State: AOJu0YxWQ1B14oskAosGJBbu3W4j8qeK911PqgDWZDSQLBAJqzTgEvZk
 HjZ9JeVS63iMPJFA2cpkE+m/ULVovpDknCLWb+uoAtwT8apW8hzy1N+Wxr3O7JQJZJui4GPIn91
 /vG5IJWfTiat8pxUwFQAtnQoFa3swaMIQMurw
X-Google-Smtp-Source: AGHT+IG+vhdpQ0xssSmOyIjalyqgsZ74iH/o1SGbUiS9hXbpv9C4kIOtguOe1iT4w2oobr8zEI7ANjq6cTJcaHjpuQc=
X-Received: by 2002:a25:8391:0:b0:e02:74aa:fa with SMTP id
 3f1490d57ef6-e041b173223mr19473532276.54.1721050280987; 
 Mon, 15 Jul 2024 06:31:20 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 06:31:20 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240623175622.1468600-6-sjg@chromium.org>
References: <20240623175622.1468600-6-sjg@chromium.org>
 <20240623175622.1468600-1-sjg@chromium.org>
Date: Mon, 15 Jul 2024 06:31:20 -0700
X-Google-Sender-Auth: TZS62WOqDmXndaiveqbUjZsLfY4
Message-ID: <CAFLszTh_3C8XYSdLnaije8iy0pgKPPLjAEQqqL05zQ+hUmwOHw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] u_boot_pylib: Use correct coverage tool within venv
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

When running within a Python venv we must use the 'coverage' tool (which
is within the venv) so that the venv packages are used in preference to
system packages. Otherwise the coverage tests run in a different
environment from the normal tests and may fail due to missing packages.

Handle this by detecting the venv and changing the tool name.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/u_boot_pylib/test_util.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

Applied to u-boot-dm, thanks!
