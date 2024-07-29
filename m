Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85466C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 16:19:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AEAD8881F;
	Mon, 29 Jul 2024 18:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EV22KWGy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F150D8881D; Mon, 29 Jul 2024 18:19:21 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E43C188846
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 18:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6b795574f9dso18941416d6.0
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722269959; x=1722874759; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cIl9U9ff23OrNSJro8hISrwDVbxMqC2pvmshVnq16w0=;
 b=EV22KWGy3rQ/SlD9DIuWq3SOrlugZWa7RYH6xPgdIhxXp01RwoljXNbLTBsdkYEzdx
 acyStg0++SWhq8Ah1CMseSEXyNF7IxbRB/LKxqF+1iIXwi8SeykfmrRIA/BGX1S0aRmY
 CBiUhvaXxpDKnWvYM2nQK3YjNquqKlEzfPftY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722269959; x=1722874759;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cIl9U9ff23OrNSJro8hISrwDVbxMqC2pvmshVnq16w0=;
 b=CM3ZRHtYJdviWRKKG0DzLo8odLgtcNshxDf0iu4D4MP/KNttnx76gasONNGT0ZIp1b
 IFOFx/J7bfMXkMwA+8KCIeuLwOINiRCXcCp76KBkL+DPb8HxNf+XyZVEvX+OYycqL32y
 6olwuWTsuh0Ab4QKpHqG55YH27DkjW3999E3xYx5ZayCrqEOmdF7I7OiOcxsh0mGlYUc
 Iy6B8Efz/fIwaP8jfd4xTCt4IfupS7SUzqfPQ8zyb1tllCY92E5AnnkAFoMaTPXoZDzY
 W2tKrvgfLYGhQ3MG5g7rs80op1XH/R9hqHI/HCWu3/DTBO7LouSkaDlMlXVn8iQMumiZ
 s23g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEtdeEbImiB3mpCyTFMyRGKdTz72ausUqTisp6PyIZTTtMg0fz7svEwTetg7BrXLjtwCAvmEYRQb5z7tyUhV8A0tTBlw==
X-Gm-Message-State: AOJu0YygrBkovkPi0Hg120PmemHxbaLWRk4VnigTWPOs2yIOKEAtZgho
 3/k7PTAuxxYusZ8LgBIBSubPMPpHsNud0zMnQPz06qku+bYY7cwvoeF5Jj3sVNOxCem9nQnRbNp
 yqtSGYPQvl7y5uXAO3d0u50aw7Bx0G/XVs7zG
X-Google-Smtp-Source: AGHT+IHTxvrkZrjhgah4XOvD33z/M+CKQHLUONm8lWBXbbsdt2Fk6F50FcLDkO60QClgavwERhUWtccHyn9z4xN0d1k=
X-Received: by 2002:a05:6214:19c3:b0:6b5:da50:ac18 with SMTP id
 6a1803df08f44-6bb55ab92e9mr103554256d6.41.1722269958811; Mon, 29 Jul 2024
 09:19:18 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jul 2024 09:19:18 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240720104950.2730773-21-sjg@chromium.org>
References: <20240720104950.2730773-21-sjg@chromium.org>
 <20240720104950.2730773-1-sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:19:18 -0700
X-Google-Sender-Auth: NLs5-2w0q_v47mWClhjddCe0IoQ
Message-ID: <CAFLszTizpWA_CU1RRbwy9ZonH0+hQfjcwHmbu81UPvxFdTA8bA@mail.gmail.com>
Subject: Re: [PATCH 20/20] Makefile: Pass OF_SPL_REMOVE_PROPS to binman
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>, 
 Masahiro Yamada <masahiroy@kernel.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
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

Pass CONFIG_OF_SPL_REMOVE_PROPS to binman so that it can remove
properties correctly when producing FITs for SPL phases.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 Makefile                  | 1 +
 tools/binman/etype/fit.py | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

Applied to u-boot-dm, thanks!
