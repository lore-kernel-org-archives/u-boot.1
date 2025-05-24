Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B07C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 04:28:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1F1A835CD;
	Sat, 24 May 2025 06:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K9N8S3Jf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74DE783303; Sat, 24 May 2025 06:25:59 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CB11835AA
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:25:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-602c3f113bbso1014075a12.0
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 21:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748060757; x=1748665557; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z3heYWlO+kWWK1AxO+MT006PTiMTWSh7zAlzX4hh/uQ=;
 b=K9N8S3JfL/P0finWZTdPjg6diIS+WkSAc8/7hfISVNuPj0ZNWKiZwXIsrXpPS9RMn7
 +7wekYzyXSkz/Pf995DycR79nFzxIiuCnQkxdZwBykeDaJZi7Sii8vHYfKDiIrCEguds
 Y+L+Zn5HuYszYdSjNQ8Bg0VgFJZdYNtPoL9m0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748060757; x=1748665557;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z3heYWlO+kWWK1AxO+MT006PTiMTWSh7zAlzX4hh/uQ=;
 b=IRgKxLo2m+ecc5UGjyIL1+NCOHrL974W0GGny1B3NjZWZptFtqWY5gLO8ef7W2i/J7
 T0WEpA+HMBc0yl6wxE7fUtfyVTjvx/Tla2RL7+eQvXutqL5ol1OK+8+MT1NYXN3GmXqh
 vcO/HKsbUmnWUXupUOY6vUvH29D2h4iSwWi5aTGgAnR2V6/CsXS0lDp+idk1g3Xy4XWl
 68MMDUvnFL1q8Dx5SHFVKztaYJlyL+d1izr+LLUiHmKupxzqnyQ4fFN5m+EN76NCJ7Hw
 nEMVNSzeOr8uj6Kj6oYqjFStOKnD808DWYoF7M9SHu9svUTV8cB9+TlPw3z3kqt5hhk9
 9OsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgyrC867VZMUafq//F/4n6wRgBNgiGQcii/HxUG5H4yo8PTnRzhaIPISVxyk4DM9BJUAd+vG4=@lists.denx.de
X-Gm-Message-State: AOJu0YzRQpcEsvmswwZ8+CwAqaIvPUX/lL2Al80x2f0f768PVAEKBOBO
 hlUZVu/5JwUBEGz3i2XVOEwDxTmjpilqBkWS3z4YSfCbELOuNGNg6SVvL6Zr1R5kJsw+omGKIvW
 ZoZta9LKAyUV/FngXXrYEg/38QoaQ3GJFLa5ICYZ/
X-Gm-Gg: ASbGnctm0gjVurQuRfX2t1wMD//tEvrFNl18xYggl4iD/baj7R3tALFD9aCz4dIJDa6
 zf2qzDmsJKiF8BVeijJUh0LhLCJ+XErZKk5ukAgbHSqpTaDkhglYJtu+wxSdfv/a0CDefo3TC71
 ouV6oiM8JkKdCkYzW7oA4E5Nenxp1q0OY=
X-Google-Smtp-Source: AGHT+IH2NWJ/5jlcLuhtyMsTtmj0CUpLuyuI4Pfxv6i2wKg+GOwvPUyEoDgIx58vuh4aqWpSa9mjFKWCJ9aB7Rd7wL0=
X-Received: by 2002:a17:907:c26:b0:ad2:3f1f:7971 with SMTP id
 a640c23a62f3a-ad85b120179mr128482966b.8.1748060757080; Fri, 23 May 2025
 21:25:57 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 21:25:55 -0700
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 21:25:55 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250508072907.207175-2-sjg@chromium.org>
References: <20250508072907.207175-2-sjg@chromium.org>
 <20250508072907.207175-1-sjg@chromium.org>
Date: Fri, 23 May 2025 21:25:55 -0700
X-Google-Sender-Auth: JNHoXx4u5Rrk8maWpMzmgWX3pjY
X-Gm-Features: AX0GCFuOs8CkJtBWUcAflNuADY2rcwZ1J672UQj8xwvIcecbzJBHVjdzv9f8yBc
Message-ID: <CAFLszTiy=qKGeXsYcFkN+zVOEbnk-9OvS_ABjVTvFpuM6B1b6g@mail.gmail.com>
Subject: Re: [PATCH 01/20] u_boot_pylib: Tidy up quoting of cc and to
To: Simon Glass <sjg@chromium.org>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>, 
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

The current approach to calling 'git send-email' puts double quotes
around each email address to ensure that it will pass the shell
correctly. This is a bit cumbersome and requires using a shell to sort
it all out.

Drop the quotes and use command.run() instead, to simplify things. This
will also make it possible to (later) set the current directory.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/func_test.py     |  2 +-
 tools/u_boot_pylib/gitutil.py | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

Applied to sjg/master, thanks!
