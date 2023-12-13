Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11632C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:45:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD34C8790F;
	Wed, 13 Dec 2023 21:39:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K1E7rZiM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12F10878F1; Wed, 13 Dec 2023 21:39:42 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E05287906
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9fa2714e828so961440866b.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499979; x=1703104779; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0CWblDbLIPqOespTSgkr49l+X5qvOZZI1QFBoG94xuU=;
 b=K1E7rZiMtdoSOdvKPQpKce7wDHkNeLkt6CdgqbGzsk4YIXmH5zGjNgnHNKS6mONcfZ
 uUUvWCudCma2AGZpXKQY5WOLHrYdZhhj+MAt6fF4rp5XRjVyeRk77W/Cn5PGSiVc87CS
 1NosRBxLEI/i876FS+k1TQI9cyCfIsbc9frIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499979; x=1703104779;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0CWblDbLIPqOespTSgkr49l+X5qvOZZI1QFBoG94xuU=;
 b=wTXJE2C47cUOk7EbMHoYi1BBYxl7EM1gn5P/SnQbK/F1dIlNLSreaZtg2lfJ2wUULw
 7FV73mId6nFfbNtOWrAhoxAAkXE9yE4bCYypMxZysq34RVJkVZlsasqtvkfhOpkSd1Ie
 X6cRq6ACiQiesI4eNEGdOyjc1FbV9Qot7bVFkurEnRLX1f/EjYVmTWULP8pm/Nd6nKpu
 7tYDKoL9vAr35VfKrvyFzIB0oBjKiYULnKHlO6SSbhCnMCUs24aFWWUezrsw5DdEPDkT
 jntgBrTEuKXEbemlW1Q7zZHV8AohWNsGEcvBWhuTXxDsPy9QvuoAO00YxzH+yL3tiOoo
 zLUg==
X-Gm-Message-State: AOJu0YxAh4EHY6fjtcwJ0JQD+8/HbSb4pkSqNQR6y18nWSn9atIrfJPL
 FbulGp8y+AZpx4PMdfDWZ6I/x6rzXVurUIFjIEiws4HQ8cNlDj0xWO8=
X-Google-Smtp-Source: AGHT+IF+EhcQdceqwgq+hNzqas7E0XjxSI8x3qMNxxke40masLYtRv/pbV4IY1V/fxfhoggDb2aMHCKuZ8T5HseKpUo=
X-Received: by 2002:a17:907:9870:b0:a04:1f99:3b48 with SMTP id
 ko16-20020a170907987000b00a041f993b48mr4012012ejc.74.1702499978990; Wed, 13
 Dec 2023 12:39:38 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:37 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231002011553.463514-8-sjg@chromium.org>
References: <20231002011553.463514-8-sjg@chromium.org>
 <20231002011553.463514-1-sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:39:37 -0800
X-Google-Sender-Auth: STmQ6hrhM2VAL2ajGcxwZ34Nem0
Message-ID: <CAPnjgZ3BFETyuBBdDbwHK8R9SOoGzx1C-Kw0U4RGjTbh0=P5Kw@mail.gmail.com>
Subject: Re: [PATCH 07/34] test: bdinfo: Add missing asserts
To: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Anatolij Gustschin <agust@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Nikhil M Jain <n-jain1@ti.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Calling into sub-test functions should be done using ut_assertok() so
that the test exits immediately on failure. Add those which are
missing.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/cmd/bdinfo.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

Applied to u-boot-dm/next, thanks!
