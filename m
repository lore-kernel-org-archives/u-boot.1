Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E506E7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:10:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99EFB803CC;
	Fri, 20 Dec 2024 05:06:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SctfZRqm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66E798036F; Fri, 20 Dec 2024 05:06:40 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DE59805F4
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:06:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-aa6aee68a57so243045466b.3
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667598; x=1735272398; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9Jzyd4FdCz3IR3aN/J8NoHEWnUXv+j2rnAJB4cMmZak=;
 b=SctfZRqmQ7sDFH2a/34KovclB36ZhC63HaqX9jc072Nkyskhc295ahrauWJvgLdDw0
 yRmntb0u7Y8BF1MYFB2NKt5+GUk8z92C8sCHBLn5nDg4KhK5P3PeT6cP/1mTzcInWJFX
 nxqqZytpEYE73NV3eKPJ0HscE9kWViJdS6XQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667598; x=1735272398;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Jzyd4FdCz3IR3aN/J8NoHEWnUXv+j2rnAJB4cMmZak=;
 b=fNwCSq/qzqTZUK3nKr051bvkDohMMdx1K1fr+DLEWAICjDWsxndG7s6WOeUIRIvnUz
 RzmdW104v+3egmQor6sg0Z/KiriNp+8zCLljsKGZzw2T9m2X98KQub7mvKwMljVjkk50
 Hue/Tu1lKdOH+SVZ9usmUgNZNwpSGY4GJYZsC8ZMNQ1K5nPej+oGuVluiPTQnnekiFKz
 qdt4nSRoUFg0ISep9yPt8kreG2hYtWR2fIICoR2svyyrkYoOc6x0N+mxhINKh3SiS02F
 pSVjKpGA9Mfd3mWIlTWK9jA5/GvLuZAczjqzL1SpqD7K4Rg4F68/BhglC4eKDmuM3RQl
 kf6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFNmCRtYV/5eDr8nTdsAIdpcqxztDQ7P6JQgd1xJpuQ4H0yq928GMyaEKm+GiXc0KWm8EtBPY=@lists.denx.de
X-Gm-Message-State: AOJu0YyKiQB+IIHi98c2T2HtaicueHW689nMQE8xU9mA4nhNXERFP+yT
 RY3rZ/FR0Kxxg0ZA0R7zBNhQSeo88M1zRUEyHixr634TRym8gyw3+Npxb4eCZxEUQXbVE4LJSZN
 daV7ooMQMjP8ACEvIo6vLDFZO8QCceMErajg9
X-Gm-Gg: ASbGnctBSePydHuzD7uISeM9ogXu217yO4jF0r1UlPJ1CKKmCcwDZKHfLO5PVcJ3whv
 firpSTvt/HihhpvxV6rzIBl3lCG4q5nJhA2Wzu1w=
X-Google-Smtp-Source: AGHT+IHY3p0RaSkoJ7swxczppIwUtAmbMADE0SX995jZBG9Tj7CcR2y8FSqgkK750Qzuj1ZCk+LvuHGHLj+w9u1AR4I=
X-Received: by 2002:a17:907:c2a:b0:aa6:79fa:b480 with SMTP id
 a640c23a62f3a-aac2713135bmr101737166b.10.1734667597897; Thu, 19 Dec 2024
 20:06:37 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Dec 2024 04:06:35 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-11-sjg@chromium.org>
References: <20241206023626.2456858-11-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Fri, 20 Dec 2024 04:06:35 +0000
X-Google-Sender-Auth: JUhgNOzY3nmT33rD8nbP_v4i0MM
Message-ID: <CAFLszTgeZfZg+ssW0gE1FuqkFhMXT_u1zswcGoY9Hdg-1OqypA@mail.gmail.com>
Subject: Re: [PATCH v3 10/46] boot: Split pxe label_boot() into two parts
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
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

This function is far too long. Split out the part which builds and runs
the bootm/i/z commands into its own function.

Add a function comment for the new label_run_boot() function.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---

(no changes since v2)

Changes in v2:
- Move strlcpy() change into an earlier patch
- Fix 'initaddr' typo'

 boot/pxe_utils.c | 284 ++++++++++++++++++++++++++---------------------
 1 file changed, 156 insertions(+), 128 deletions(-)

Applied to sjg/master, thanks!
