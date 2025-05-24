Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F44C54E71
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 05:08:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA1BC83655;
	Sat, 24 May 2025 07:06:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cF8DzFFY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CF1983303; Sat, 24 May 2025 07:06:31 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A23D83619
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ad56829fabdso60584766b.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748063189; x=1748667989; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RUY3Y+j25O2Oy3FbvJl5p3pJhD3SLIK0mH7uGQAXGbE=;
 b=cF8DzFFYKXFL/dY1kOQu1znQMDGs3PFALB0hAxGrGiTGreSLHXVBx91gGKPg7dLXXF
 HvcXyIfambjuuxEcDOxp4zohw2FrvXF5egWztOTS0e60x365rXdcX5hZH6o0YjGf5fur
 oxOfd7SVGDNmsPRa3qftqGtQlFahfo9R31cSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748063189; x=1748667989;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RUY3Y+j25O2Oy3FbvJl5p3pJhD3SLIK0mH7uGQAXGbE=;
 b=flwSJTkPgxAmOloTpL89dpXP4uZQYN319OqLsGPq235k+Zz4QXJtrWQhTZJGVVrH+g
 Jjz3MgV+z9aDc/8pf55f4gpPpRke9UqDMtlHTNPJGXPRn3ZaF6g3r1PtJBcfYYZTHe3w
 cnggLDU4saSrcnaAeVVZKs3owXx7zygTGkqjvVTWGAjdz56R4K87H8rbISU/81NyDDTP
 r8eXQGzV9JuO9poeoykq0c8r7K+a7Ixw0NnmvcGiCFUXavSLNLy6IWwFBpSysRKwO6fI
 cqV1atubtChHCItppCoXnrEb6FyW3zl9CLVuNgg3gQFzEA4WpT5LZGOcW/vHK3Z2SQAD
 Slhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL+TKmnxrL+GKFz81wIDSnCtcKDtXh0OhFpjRkA9xle2IlteATNRMyIEotrBX5O/JmD/KUZpU=@lists.denx.de
X-Gm-Message-State: AOJu0Yxp5anjiksMetYVAjzoMbzI8443So3LywyVm3F/rt0emeyMfG6R
 DrKO9cIuzkdZG4new+EpKMA8sZguKPTev6QqZBJ3Cdu8bO79qEv5V9n4+yTwvX4Trs50tmCU0IS
 KWq2Cmr9dlUV1gffHbqpHG7Iom3Kyy29Uslyxt/2T
X-Gm-Gg: ASbGncs9c6CKBzZSmwV/yZzIcOZkAopIoRrEESqdWRdXTppPsm+hQ6/dlVXTTLJ5S4d
 EqesXFnOgRaN6Say2geiTItIDKve5VH4HeBJQto5ZBNSphkyF7zrKnAbPhzhXL+16rjFAfHOJDA
 rflpdQQ0H8EOK/FWPMAiWWizLUtPfA17k=
X-Google-Smtp-Source: AGHT+IE/uCurocX1DxjcH8F+z56aGMAjr2LNQJ48HgYKrDlJc84iadUY8nlItoLNo8CM8aDOLlKK6nFO4F+zhxqByPQ=
X-Received: by 2002:a17:907:3faa:b0:ad4:f5ee:3c0 with SMTP id
 a640c23a62f3a-ad85b16dab8mr164159066b.16.1748063188872; Fri, 23 May 2025
 22:06:28 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:06:27 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:06:27 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250510110535.1453745-7-sjg@chromium.org>
References: <20250510110535.1453745-7-sjg@chromium.org>
 <20250510110535.1453745-1-sjg@chromium.org>
Date: Sat, 24 May 2025 00:06:27 -0500
X-Google-Sender-Auth: jGylQ7srV9FcVFLRe7jLZdI425E
X-Gm-Features: AX0GCFszOWVQ5dZ1ofPGuMiCAbHbabIIv2Z5iUTO36ZGyE1p1TePS81F84JVPdw
Message-ID: <CAFLszTh_SzV3O75k1U2v3H_2rE4R63B7L=mNSt-PZpCv2dL5VA@mail.gmail.com>
Subject: Re: [PATCH 06/25] patman: Move common test code into a new module
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

The func_test file is quite large. In order to allow new tests to be
added to a separate file, move the common test code into a separate
class, to be inherited by other classes.

Drop unnecessary imports in func_test

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/__init__.py    |   2 +-
 tools/patman/control.py     |   3 -
 tools/patman/func_test.py   | 213 ++++------------------------------
 tools/patman/test_common.py | 222 ++++++++++++++++++++++++++++++++++++
 4 files changed, 248 insertions(+), 192 deletions(-)
 create mode 100644 tools/patman/test_common.py

Applied to sjg/master, thanks!
