Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F327AC3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:33:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C54A388886;
	Mon, 15 Jul 2024 15:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lQiUVpaj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B89688835; Mon, 15 Jul 2024 15:31:35 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 401CF888A3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:31:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6b73f7b855bso26598896d6.3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721050292; x=1721655092; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bSxzHevdu2jAu8lHeI2s2W8bJ5NY8uKTeUvw+2/IDWk=;
 b=lQiUVpaj8CTK7wbQQ4U4EwuKGRyIZXZvZhJPnwBHRj13Ua0mnHp9+REQrfU3nf9ovM
 qlcAiH676XwGyC69IGpbP3x1W81A3E9/tSKrPvu8B1T7UuCMZEtwdVnQUDAb2MW4RHxq
 xg/T6fEZ/sv1V8pwU6Nt9D0W8By3AEmlarIE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050292; x=1721655092;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bSxzHevdu2jAu8lHeI2s2W8bJ5NY8uKTeUvw+2/IDWk=;
 b=QXdZcd/08AY6dh0BTcEKfY8M4pC18OHky3+FkAMD9uBNH8cFvOGEa025ckpv1zCD/A
 XJSLgT/yco/U62CR4tGEkiguSQtRxOVHuD1DOK1T05fn9YteBtSEAWjITiNC2thkKHIS
 tmEZuO0g5A1Nl8rWKLZraZ1dLFoYh7CEsZgskyyj9I0R91Nm57ZKQyoCDS5co5/wiSVs
 K+lttKbB0tq31ASWlDTNiNHN06FnJK5P8j3liN9a3Id3uNMlZ5++7CebuGc2C9BjCqu6
 3KcQNkzXpeyoVFrShTjXp5D8Jf2GF5QvTXVRC1Oi8Ap9uwxdr5qP1Oivb8Wx+5vcAQ4K
 kqBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgUJn063ZaBRZoXT/nkBu7GxJ2bnbMMxIC0EjMOxkTjiOMR6LUkM+fvqoU5fqJARrUjs1UZ/5d95acY56FR11qLIflGw==
X-Gm-Message-State: AOJu0YzKPz2qOQ9QZftvqgnFwuVJO4Cvostro7y2hArCfVSi2l2ox1mI
 tzneyM3w0sRyqQBHytciISfoNDE5NiwtzwtQwSSSgI+9wHR2hNfhfY+TdHSrny1ft3onBRS4GTq
 Avyv5Abn7+/JVSo+CSiMSIuk8YP8q8IQpz1CRSXL8EHaZD9M=
X-Google-Smtp-Source: AGHT+IE7QZw/KqQDThxzUnT+vaQiPUXQCjyA529ydhJHsSBm7ZxdT4q6ob5Z/cMKgz7AK4yE2ELKNOYFYaKv/kN4NRA=
X-Received: by 2002:a05:6214:1cc2:b0:6b0:48fb:138e with SMTP id
 6a1803df08f44-6b61bca1962mr258482736d6.14.1721050292194; Mon, 15 Jul 2024
 06:31:32 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 09:31:31 -0400
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240623175515.1466908-10-sjg@chromium.org>
References: <20240623175515.1466908-10-sjg@chromium.org>
 <20240623175515.1466908-1-sjg@chromium.org>
Date: Mon, 15 Jul 2024 09:31:31 -0400
X-Google-Sender-Auth: Urc3Fv-YI1NCmIuNZAobIuABSXI
Message-ID: <CAFLszTjzA-wV4Pn7HorrXtA5uq15n2uaGFw5pyVjaLtzEt71pQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/14] buildman: Make mrproper an argument to
 _config_and_build()
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

Pass this in so the caller can change it independently of the member
variable.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/buildman/builderthread.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

Applied to u-boot-dm, thanks!
