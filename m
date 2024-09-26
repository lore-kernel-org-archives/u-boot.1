Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A490CDE03C
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:09:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 969BA88F4D;
	Fri, 27 Sep 2024 00:07:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A4G6nkow";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C579488F24; Fri, 27 Sep 2024 00:07:41 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 289BD88F4D
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:07:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-718816be6cbso1327125b3a.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727388456; x=1727993256; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nMUoZhI9hwI437buJDA9ZQhEUetPOgnm1GRt9aVfHHw=;
 b=A4G6nkowSfOO4waU4j+T/mtjBo6ySNa28H+h6vqFjtrfzCxeylaiWf4chUeKAN9bgm
 wNV7MZ85hyZLJlXqJIIzrX8O1JLebUv4V3VN9iNv70BHwnsgemucDZuMBkcJv0PkIDAL
 dvmzSk8ZMnBeaicSKz6Ig8nA/abhWrihT+vt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388456; x=1727993256;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nMUoZhI9hwI437buJDA9ZQhEUetPOgnm1GRt9aVfHHw=;
 b=JXudjf6LTjHUqZoHehHmQ/UV3dTgC4RFxuEicJmiJRfvu3Gch1pBJwwsW8p/JLgFEV
 l/bkK2yQQhvZ65dkj63vPi6mea1hYz4Rv161aIdSy+UCjSLyDDS4/ipNALHjlCeAWdS7
 lEBaW6e7NuyUlHsk1iX78uv3zd+YZF7crJn5Td9MRxciaDv9rLj/V+sO5WOmRRc59aha
 Ma9VZpOWP3SLqkZz6bNNyR/WdXftOffLuzWCVluTqHWD/cTmAMRnZBRw49Ab9W7ZssvG
 hRRKdld7VSY9h09z1TcCnO2cTAgZ5Tl7R9q9dYfI4GHFtqq/RNQity6+qCSeHZK6rLea
 oOTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyoJbdDRrtkLi//bdPKQQeeCK0ZLnC9hDKkLgsxpSpRC+WN4nZW1TKDMc6sn2Rz4zacwOmFAg=@lists.denx.de
X-Gm-Message-State: AOJu0YxS3JLYMaJLBgHz+NU3TLXyy9XTPwZPu1mnuD3L7aYBuGdYjBJL
 mS78AFFMf+48y5X9XNqPPT60SRzYIWKQIiswlajeQHfsrW8FIuoAXciV7Xv0//jeHHwPtiek3+C
 sKk6c9B6Y2TVDPL2Ja+FMyK2ICyM2+Lp6gJyM
X-Google-Smtp-Source: AGHT+IE1zQ1zgaglfkeH8KOwA51m8Y5tyJ9QPQ9VjQb9889wLeC7ny/qrqCaDESWtzd/d1QtzQMFSvS1Y+CTUXW1UbU=
X-Received: by 2002:a05:6a20:e347:b0:1c6:fa64:e5bc with SMTP id
 adf61e73a8af0-1d4fa78fd17mr1457532637.34.1727388455799; Thu, 26 Sep 2024
 15:07:35 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Sep 2024 15:07:34 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240826191143.426387-4-sjg@chromium.org>
References: <20240826191143.426387-4-sjg@chromium.org>
 <20240826191143.426387-1-sjg@chromium.org>
Date: Thu, 26 Sep 2024 15:07:34 -0700
X-Google-Sender-Auth: tQuK4u05BtGioagedUjNWSqmhSg
Message-ID: <CAFLszTg5W5d34Ox_sMadxZzcR_vx1CEjFapgMSOBY0dEK7eX8A@mail.gmail.com>
Subject: Re: [PATCH 03/15] binman: Tidy up comments for
 Entry.GetEntryArgsOrProps()
To: Simon Glass <sjg@chromium.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Improve the comments for this function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/entry.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

Applied to u-boot-dm/next, thanks!
