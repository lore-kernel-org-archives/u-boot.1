Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43FFE95A62
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:44:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E59786C15;
	Sat,  7 Oct 2023 22:38:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IDIoV5+P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD01D86EE6; Sat,  7 Oct 2023 22:38:18 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B57C86DFA
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-59f4bc88f9fso38411327b3.2
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696711091; x=1697315891; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lHwgpZlOXLmAnsU2Ky8Yx8LQVKS4AI3gMnZCyIq1m3M=;
 b=IDIoV5+P///YVmScZAKQjXEU5feTK9m4AsKo9NfQwZCk3Y0abNj6zQ+lQMCaxs9fwJ
 CsdMpYCKUflt10UjXUHbEcLBh/lrPWw8tzWcJO+UHHe61npvh7Dj57XsGi6rXTd7BilI
 isbYtCiJGqzA0CUq7LBo84FfRO9YeXGG/fpm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696711091; x=1697315891;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lHwgpZlOXLmAnsU2Ky8Yx8LQVKS4AI3gMnZCyIq1m3M=;
 b=mRbb7zQWDf8sAKWs9CSRr9VGXQnXerl/PX7GJzzYFAv0EtthNi6H0n93uPQI5G5KeR
 KteLNcjn3ahxcmKVAn3p3eTpmzg8jMV9fiClK51dIIlcayD9aoJl+j1f3PpZ2tycgGDM
 SxrjtpVre5Um7NYHoFiYbTGaDQjLsVLcjS8/pBtKgCMsevuxtq2eR4KLSUOt0zQC9RCF
 t68iiEmEa8yZAEB9U4uYXDJL6QgUaJcPawx0XHiEfPyMj3CNlccv2iCK2pmY6KbbrNzQ
 qlcKm+pwdLWATNLfpBK4emMPoBtfgV9iTQSXLiIBDF2yviLGMoY1NZXmZOMo2BAhnXHk
 0FCg==
X-Gm-Message-State: AOJu0YxenS352ndJ8v0URwOPaKN1Jmy/H/GiDZhf9+RKCtbL9N5qgEAm
 lcPapcqyOypmpI/8fuZgQQ6JdEVw7nMAXgq0S2w0xg==
X-Google-Smtp-Source: AGHT+IEae7lkSn1WtE+9eDfm2mUkt+0JAJ6InXgMmirtcnVo+8Z+/ESEPxyHfoOtwTV/Ku6gW73cSXSyZxr/YYop52Y=
X-Received: by 2002:a81:4f0d:0:b0:5a1:e4f2:c16d with SMTP id
 d13-20020a814f0d000000b005a1e4f2c16dmr11052668ywb.15.1696711090972; Sat, 07
 Oct 2023 13:38:10 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 7 Oct 2023 15:38:00 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ0820VO7vOVLeu=215Q8N6FtE2iZ7VWZnYjQwU1S4YK=A@mail.gmail.com>
References: <CAPnjgZ0820VO7vOVLeu=215Q8N6FtE2iZ7VWZnYjQwU1S4YK=A@mail.gmail.com>
 <20230923194424.1739224-9-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Sat, 7 Oct 2023 15:38:00 -0500
X-Google-Sender-Auth: bYPnAS5Ws389h_Bv4mts5nEkj1M
Message-ID: <CAPnjgZ3X3gEOjHMq5xvAAfy5=_EC5a3eVY=PB78aGb20nsOZJQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/27] moveconfig: Correct some regular-expression
 strings
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

Use the 'r' prefix for these strings to avoid pylint warnings.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Applied to u-boot-dm, thanks!
Applied to u-boot-dm, thanks!
