Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E34C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:19:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E5DB88823;
	Sat, 13 Jul 2024 17:16:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cO2NE6c6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E87548890D; Sat, 13 Jul 2024 17:15:58 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9965388913
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:15:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70af8062039so2256927b3a.0
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883755; x=1721488555; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NXlSWawybZFxxkLk5/Mo70KnxCeFgFnVtwawo67yiwk=;
 b=cO2NE6c6VUnJ6tYXvPER5s0/2p5MrFrCdKJXnAnW8yf5v1lD6UTRmx2LpDws1XhW8v
 PAJg5Zw1v4zDSQs4DHsDy6ZI9M4dmkSGZKUuFuMEn+Tst45aTS0rD7GHscd4YSN1ttl9
 cy7WQsk9KwH4rAaxMZ8tL1J+K0Q7HZiy0gf3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883755; x=1721488555;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NXlSWawybZFxxkLk5/Mo70KnxCeFgFnVtwawo67yiwk=;
 b=QBD4NjnEK2oFh20bQtFG5CN4P4DE2pkKgT0AR9ekKKgpCoI+rMhDjOW8v9wzsgQXec
 UPXFjz479Z3RbboVtYSVgeoUOzVcOGoPLVh9jxzOX2LnclSVs2rbThc1MPqMesY4Fm3V
 NPEEG+JrUV+hJp7xcUL3C2pUpJwNw6gXU9HT7koIbvMyMF229doVIRS78xTj4zS7OPgR
 b/VMl24p2LLN80w0mG3pO7kL9uzPEn2NJ/trFcDHzVVzbS4+1+HdGQBo4s6JqaEjbN7r
 r4aKAWXmqITZmBEp7U4cVH+9gEF/+zQTMdzMPJNeDBNngOSbYebfigDTtTfq2sIE67/F
 6wLQ==
X-Gm-Message-State: AOJu0YxQsyi9hvFVQ/L/pHlVhBJ9S8OUVlYIERZLNWI7x4lkR8rn1EJH
 dIelWzjAHKOS7R/2HmEnOLg4OhYG1/90UYos4UnRkkxCZ2xx0IB000oN+BTAlFWFcBZ4Kh/qtoB
 Vig6cEAMSVRVoSCwGp0QhwXXxJnRBspV/2PiB
X-Google-Smtp-Source: AGHT+IGFgMzKpTxu/WABl8qV9OUcS9wpW1QgRt3ccJaPeJaZba1SBDQO2UHounyyWhX+7jLVntoU24yWX0vfpMZcrvc=
X-Received: by 2002:a05:6a21:328a:b0:1bd:deac:c052 with SMTP id
 adf61e73a8af0-1c2981fbe76mr16624737637.1.1720883755225; Sat, 13 Jul 2024
 08:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-16-sughosh.ganu@linaro.org>
In-Reply-To: <20240704073544.670249-16-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:15:31 +0100
Message-ID: <CAFLszTgYbMgckX94VAR+=N2nPBMC-_shwOBe-pc+wof1fTi_5A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 15/48] test: lmb: remove the test for max regions
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
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

On Thu, 4 Jul 2024 at 08:36, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> The LMB memory map is now persistent and global, and the
> CONFIG_LMB_USE_MAX_REGIONS config symbol has now been removed. Remove
> the corresponding lmb test case.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1: New patch
>
>  test/lib/lmb.c | 67 --------------------------------------------------
>  1 file changed, 67 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
