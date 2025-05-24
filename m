Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95FB5C54E71
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 05:06:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A62DE83477;
	Sat, 24 May 2025 07:06:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZveU0Qxc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BA0283483; Sat, 24 May 2025 07:05:59 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CE05835A2
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:05:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-601968db16bso1044241a12.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748063156; x=1748667956; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IzMdCTkShDvnHBmGfbo+pEkZH9uiRaveAdojJAocBY4=;
 b=ZveU0Qxch5LYQmK+X/LfitAQTOSCl0L1GIqJtvbjt0vLL+c/IjvK5I3zUMue6/12NV
 wa55spmQEPpw6lNaX2VrsOVkH5n6KncF3ISZpX0muFvikHb6H6zLywdWIvfqB6085Z/1
 wHQGnM+rOcz9bjL+jP+VcTbVKNhxtEyUF+t+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748063156; x=1748667956;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IzMdCTkShDvnHBmGfbo+pEkZH9uiRaveAdojJAocBY4=;
 b=XbwfPF6QfkAY6aqHn/CEJkRPVyN1Q2cno7fOcMPANbMdafVgruQG90Sf+Y9sFyBW6e
 Pr+pTHuwAIvEdDK7zMmklWpWAqffkHEvAoCV4w8JZTCjyoKBt31bBvERa3p407tUuEeG
 WGvT6KMoitIzNd536NA4J6cU4wSpV9KgKss6iu5i0MA6aDX5RGkBugmqGkzUHWZk6itX
 ruo2tWz1T6HZVgGCZV7VGSj5qU5yA5vfL27aJ1DS4YKVjjkNGwsDvYDCETi+Dejt+6Td
 ftRHSN+nKUVNOBWgt2k6O7vRabWjRFHrZqv7CNfRdKOaC9bVS9nbwJGWStEezE9KHbkf
 aqHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLZTKTkUtguRO1y/pVi0hHOsn7SunC3cYxBpCkOc9JA2tQRMZdUzFn0EM8vWR3fSx+9SF9NK8=@lists.denx.de
X-Gm-Message-State: AOJu0YxBU5ZeaQO19DhTiLofvydmf2Nw0ggQNfxja/Nx+dykG/dukHWz
 WHukWYEuEekMKHQQr8udNQSjzvPvjmZmxM1e8EKjAgfpzelkYb5un/8s1hjsdPnoshw5UUqRQoL
 e+inRoEyb82Sj5BuaU87O4kQeLHa23RmBZZcyV8Qa
X-Gm-Gg: ASbGncu6wnwB6XBG2lrj+/icSvA8jet95a1nZ125PsGgy2MQXbphJUeGyZMlD1+79Tw
 Ct6Jg4kgYkKoy12YsnAF9wPH7KABeYJwS7Epri/IP1AMPQe4/g/+iG8I2zcFoyOhYIoLnNFfmbg
 kPKHayIcx3aL03RoaDPRG13uOnJgcTJGLV2u19tW9W5w==
X-Google-Smtp-Source: AGHT+IFAsi3ho0JOg6+GIoQZzMYn764en+M6ov3+4sf7HHK2GnpAJUr6P/8FBVEFw+xexzzSPpjZKlzIwRTJiy26YlI=
X-Received: by 2002:a17:907:96a8:b0:ad5:ef0:5724 with SMTP id
 a640c23a62f3a-ad85b19f6d6mr122155666b.34.1748063156635; Fri, 23 May 2025
 22:05:56 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:05:54 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:05:54 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250510110535.1453745-19-sjg@chromium.org>
References: <20250510110535.1453745-19-sjg@chromium.org>
 <20250510110535.1453745-1-sjg@chromium.org>
Date: Sat, 24 May 2025 00:05:54 -0500
X-Google-Sender-Auth: 6CKPinRNTZwlYSiW8iMvlO4ss0w
X-Gm-Features: AX0GCFsnVeklu0DNSRFCyaatKOa9GmQuPE4uJGTup18rAEMpPQ7vHXFx0TCr4MQ
Message-ID: <CAFLszTh_E65b1+rBv-x4M-n5REqde5LYjwikeVZASfHh51UUYw@mail.gmail.com>
Subject: Re: [PATCH 18/25] patman: Improve Series support for patchwork links
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

Update Series with a way to better manage the Series-links lines in
patches. Use this in the 'status' subcommand instead of the existing
primitive method of expecting a link without a version prefix.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/control.py | 25 ++++++++++++-------
 tools/patman/series.py  | 55 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 9 deletions(-)

Applied to sjg/master, thanks!
