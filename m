Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAA3C54F2E
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:22:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB3E7833DB;
	Fri, 23 May 2025 15:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RMQUnry+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BA9383249; Fri, 23 May 2025 15:19:19 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EE79830B4
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:19:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-601d10de7e1so9479599a12.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006357; x=1748611157; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y26BIO3odA0m3WTzNYMUNMDbKBA04jtphMQ9/S4/Oe8=;
 b=RMQUnry+us4l+I14trDBCzF/zK3M/QtPaQRXFK9SQuCf97x0sn3AIa9RRXNUbuuFSR
 rzPfbXjlO5ZADZi8y/1lgtr2rcrqU1l7e2aZVTf/4iifAfl39JNAZEEXRyadDEufLc7S
 vv0UljFZVkhkq5koUcjfG4x86HyxyLMzmldkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006357; x=1748611157;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y26BIO3odA0m3WTzNYMUNMDbKBA04jtphMQ9/S4/Oe8=;
 b=FfmNuTtTOwCsLccmxNkLYBWDjGLdv3NkLgeudBtzzhmxQG0Mq0scOkPHRJPn5KKyyz
 IXc4GxaVflSpq05jqtXsTiMlGFQDwHMHE0x+6dK9rO0Y8dWoLNH3BGCI6NKTwHaYBgQJ
 INSM9qyIhNuFgZNJmcvnl+QS+C2qEHtRCoB5T4pIbxJIfTlW6EXXJLbsHGFQ436sf4p3
 aRRjA0PluECmGjNiXxtDh6UbwZyLQ1ytQht/Un1nJQhH1vV7vKSQ2B5i9Wybn+DtUIkV
 Kg86kaH7FAKrFPq7uSiXiNVOu7344AQhIbDt+rsOX8JW2+jkVKHPBsoYf8WD6Ob4NBjq
 8wfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz6KaiSFEV2UuBPXx7uh6AB3uDoF5ccMcteW/CQr8dIbNcpys7Q5hDga+puzCbJt4J5nNO1aE=@lists.denx.de
X-Gm-Message-State: AOJu0YzkSf/uM3VVhRTFPMk7f38hqDsuhZ5lW/Oxriqkn08Alyu3JdpO
 eMq0fejzIf2nmKj2UtJlCabKZKn3FM6I90svYnlAIO6f9yxu7JfyGDiU27GeefTWoWMyJnBJuwd
 NGDtOZbjwSrcj5/pNnsHgoOlQGFqe4vqvid3MemJz
X-Gm-Gg: ASbGncsp3exY82hiwOVPK04NFQOcsdtGOMA+vfP1TJsD/viujJUcGP0jgkbo/dwNlmQ
 cabm/16tmVWIUg8wWOgvguONsjK0gM7g3YL/kT1CDt2dNdM45c+1d23FvPUkPRRDLvUFMEVjsyg
 Wp9kJ7gCNqVOot5BBBYDp4w/KsQdDnX+7qfQ==
X-Google-Smtp-Source: AGHT+IHLUj2DEHaVFJcAbAod91WImqVCb8weXHduf8pELTj3t55YsNKL9559ijqQ3oj1kJ6EUMDKjPSqKnFBkgyJsa8=
X-Received: by 2002:a17:907:c08:b0:ad5:a29c:efed with SMTP id
 a640c23a62f3a-ad5a29cf077mr1177448466b.33.1748006356930; Fri, 23 May 2025
 06:19:16 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:19:15 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:19:15 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-8-sjg@chromium.org>
References: <20250504132356.2317305-8-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 08:19:15 -0500
X-Google-Sender-Auth: DKUQrHbVaeb-8DbxtB8Be8whcOg
X-Gm-Features: AX0GCFtvWVdd3BmCdhkHjkdvAhT2oxgPCLTYE34qN1t2wkadxF2PUJKgHgAZRzE
Message-ID: <CAFLszThpVQjhubGjuSz9m9CexuLbDs+ZysdoHo4zp=F-w8G8pg@mail.gmail.com>
Subject: Re: [PATCH v2 07/30] u_boot_pylib: Avoid concurrent execution of only
 one test
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

There is no point in spinning up multiple processes if there is only one
test to execute. Add a check for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/u_boot_pylib/test_util.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Applied to sjg/master, thanks!
