Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F339ECE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 19:49:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1267D86BEC;
	Sat, 23 Sep 2023 21:47:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E1VAq5xR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69FCD86BD6; Sat, 23 Sep 2023 21:47:43 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1340686BD6
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 21:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-533edb5ac54so269618a12.0
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 12:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695498460; x=1696103260; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KhCDu3JXpB2/PJrAoDJ9blw91ZWWbsnUS5F2aJarXWA=;
 b=E1VAq5xR6pAuCBQgff3e4Yy7f3uxmhFyFhEs9vJksNBV/hs3GjUmittkgP5KURyNmp
 rXX6w7ZJ1yjjqFCS60Huq9/gJNZKzNrRhqwKU6cpIZgSsCsngY9L+NPJ9efDewYF5jtd
 joTmMIOS5dQhidFo7h6H0weNnN/HW7dabzgig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695498460; x=1696103260;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KhCDu3JXpB2/PJrAoDJ9blw91ZWWbsnUS5F2aJarXWA=;
 b=OQI51g/Fob7dnLjDrF+DeR1C+jDoR3pZHoQgUyaW55FPEaoAdvoJEJIHdOBVVwsUC/
 kbm/fb2tBz0eqMKJa5OlKzVBZQEYeYLbwfSqJEeH10A74tksQXDUFD25bgI0qvgcATFG
 8Ty6O+meMaI3jhOo7rItN9TnrDakncNnuPMApLtqNj1X08as915Ufkoz9PRCgigmWE/d
 J4L6IsseHkUskaZyVhUDlb65o2erE8sfNbD/cu9xh/nwXWT05nds/OjLIxrIWK4TIf8v
 jnN+5qa40jufBWj1LvM5v6Qfd57qsQSDNQ+pImmde9PutGahZF0bXDCsYOViki/d5tx5
 PNrw==
X-Gm-Message-State: AOJu0YwFboLl6Ssm513zNtUFx5bXBZouWM9gtYTgU6kePUZu/FeR9ZFx
 5rY5x09Gc0TLiDd5/WwcMezmS5VMycQtmX5iydEYnw==
X-Google-Smtp-Source: AGHT+IFCEwhvKJsi6xGvJQgX68Xp30JRGu0KFt5WwQu3+2oZGzCIRPHVzz/ErQZ2741lQHsrh9EAvz1p/sVssWsIXfg=
X-Received: by 2002:aa7:c406:0:b0:52f:a162:f4c4 with SMTP id
 j6-20020aa7c406000000b0052fa162f4c4mr2503154edq.18.1695498460502; Sat, 23 Sep
 2023 12:47:40 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 23 Sep 2023 12:47:39 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230907160023.49339-4-sjg@chromium.org>
References: <20230907160023.49339-4-sjg@chromium.org>
 <20230907160023.49339-1-sjg@chromium.org>
Date: Sat, 23 Sep 2023 12:47:39 -0700
X-Google-Sender-Auth: R6MU9suNR0WF4BF6JNNWOFC0uFA
Message-ID: <CAPnjgZ26bZ8t4-v46Ho-A9bYAvrZieSK+e0pj-nhieJZFP4kbQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] buildman: Start the clock when the build starts
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

The Kconfig and maintainer processing can take a while, sometimes 5
seconds or more. This skews the timing printed by buildmand when the build
completes. Start the clock when the threads start to avoid this problem.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 tools/buildman/builder.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Applied to u-boot-dm/next, thanks!
