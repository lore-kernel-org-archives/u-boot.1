Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287AEE7C4E2
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 17:58:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35B95875D4;
	Wed,  4 Oct 2023 19:58:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KBbFZknW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 915A6875C5; Wed,  4 Oct 2023 19:58:29 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22FF1875CF
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:58:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9b281a2aa94so17392066b.2
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 10:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442304; x=1697047104; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z6SMY2mo9uq6IIR8f7TkplA6hKgNxSWVS9fWFYi0iaA=;
 b=KBbFZknWHsPNfYnsTsfCkYxC2q/+uLJ5PvOCtAPEFLVQY6I6EAtKSm6m0ri5H8eISf
 Et0oquagR+kHLfLYWrHo8JWj9WoU7ddzsy5NvmichVScvTk+MOYx2b3iswMa4Uq9okS2
 Qcb1MA+xMn/OzpqPh0QCjRJk/HLd8eG32H4Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442304; x=1697047104;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z6SMY2mo9uq6IIR8f7TkplA6hKgNxSWVS9fWFYi0iaA=;
 b=L/XV/rzD20FBAmv8iXrei9NoDrHHfGeE8cxmFzO1OqigTqOV4PFZJDMXbGeIpCgMNp
 2agbjC4R1Ba+OgRK5ZyFF5Q/Eu7s6GUksmCvq1g5Cf5NzTh2XaTCmzsC0Pj65XNSiXMJ
 qnhgU+8WRI5BBvLXDd4iTGngmziHRBcoZH4LWUTiD4TQSAArv+Svf3+npLOsNRpZMCVJ
 /Ge0XN4TziP/9Sh7ft7xRzUuVLGY7/5xwSWSsyBHqvRWLgXDwIfcNpmBJhkr0tV91nWE
 dXznS7IvqHQKoy/+WZYCH4oNcgcTpf7w8zq733XRo/P6j1fvzc2GqPfZytIclP0cNVBx
 cdeA==
X-Gm-Message-State: AOJu0YynNJ5n/bUVamgeOpWQ+AIjmIAd+wIf1Nlz++o87Zv1Ge8UoBbI
 8luZ5d+Ht8IjUGNc/aHMpj1SWzVZT3uvH1kgubROVIyQw3fzO6w2LYU=
X-Google-Smtp-Source: AGHT+IE/Sz7O6VgLDFFG8gJUd5DlUBytxZJT9dMu9aKkh79yr58dE32emKlYB7IFaguinXM9JMwpfS4j9MOe4fCBdWM=
X-Received: by 2002:a17:907:7850:b0:9a2:474:4aa0 with SMTP id
 lb16-20020a170907785000b009a204744aa0mr3013241ejc.48.1696442304482; Wed, 04
 Oct 2023 10:58:24 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 10:58:18 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230923194424.1739224-26-sjg@chromium.org>
References: <20230923194424.1739224-26-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:58:18 -0700
X-Google-Sender-Auth: lT4viBYJXGv_lnOblIJxqszFSz8
Message-ID: <CAPnjgZ3pMwp2_CmJ1dZmskgs2M-7M-uWQSJzfVp3a8qPJLJZ6A@mail.gmail.com>
Subject: Re: [PATCH v3 25/27] moveconfig: Rename the tool to qconfig
To: Simon Glass <sjg@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
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

This does not move configs anymore, but queries them, based on a database
it can build. Rename the tool to better reflect its purpose.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/{moveconfig.py => qconfig.py} | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
 rename tools/{moveconfig.py => qconfig.py} (99%)

Applied to u-boot-dm, thanks!
