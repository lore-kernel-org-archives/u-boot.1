Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680EAE7716A
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 00:26:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7C9680216;
	Mon, 16 Dec 2024 01:25:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Bt0FAIzl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D988C801BF; Mon, 16 Dec 2024 01:25:55 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1156801BD
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 01:25:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9f1d76dab1so737537766b.0
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 16:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734308753; x=1734913553; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oLAGbpeK3Gxd5RPu4KyQ9bjJcuGSZTRQRNyXtx7rQYY=;
 b=Bt0FAIzlo5tTHRugVzFZQXIJm/fpXoN/SX6H9fYbXVGg2QH3dx2ZZ2thy5oUzjAZ4B
 tJZgor623i8dqMaK2RBTLfdf7u1vKTHZ+VOEZhSEpC/xfZt59KRz/RxfI74DWVhc8B01
 rCfWw95UQGXfPFa7Ztx55CGwXqqIOkTmIuQZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734308753; x=1734913553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oLAGbpeK3Gxd5RPu4KyQ9bjJcuGSZTRQRNyXtx7rQYY=;
 b=V43pifCI6+mQiZZSCTm6na/p439OLbu78G0dnLhBNTJcUdZYF9/Es4InMI/VRv/8Z3
 C7V9rVUNPWWgPkqWGGokb+8m5p0AWZXtnH0t8Qe6sYT+EzzZ7eenbM0pIijo32VVnBsK
 1//Om/ihYIq9CFzrkNw6tsyt0C4CH+cGfDHCCB86PdDeIS2nTdrbTjZTB8c7vc0xFk+q
 jfpNk2kf0YKGPLUQiPuUl3rLkunTO3lybWIfNtLkSk5YHxiWfBWYMhfdNy4Eo1jIviJZ
 nxI6YDoGTwkWBoR2NrvkK4P7iyB+v0RBKtUG20LrqaHwdIk365n4+eC3BbTrJeFCW4bh
 yIsw==
X-Gm-Message-State: AOJu0YwhElzDScdVP/cHqv6dmsHiu/vpx9634inHZqALxN2O4+raaRvs
 Z5HTwH8SrMtgO24k5B0urP6OMf3dSDuTo2Jo5WA+75yxt6GgvxE7FRXYF83gVnpy+ag04haKSEq
 oum2GoRL1YA9qf76/CdtIILBnR0n0zJl4ZE9j
X-Gm-Gg: ASbGncvL+zGzY9EBtF1SxH3gxgaW4ABXKit7ULXY6SQknAojD8/og/jvLkbOzWu7t+9
 Ms9HigxeLX31VxaordJDjuoFGi54QzRNtBqzuMWjAn9CS2WvwoJlPR2dPcdzdJGQLie3v1AI=
X-Google-Smtp-Source: AGHT+IHZ1uwHLBHmEBvUmHzmFQe5PoOVyVlRsrwTxMrTURkQt+KIkPA/77655J6qFiyGPBZoN52A8j7nWiFPDhGgY3E=
X-Received: by 2002:a17:907:8691:b0:aa6:2b21:ab53 with SMTP id
 a640c23a62f3a-aab7797eb59mr1138323566b.24.1734308753390; Sun, 15 Dec 2024
 16:25:53 -0800 (PST)
MIME-Version: 1.0
References: <20241214182024.1954974-1-sjg@chromium.org>
 <20241214182024.1954974-6-sjg@chromium.org>
 <637DFD63-164A-4FFC-9D62-EC0F8C33CB25@gmx.de>
In-Reply-To: <637DFD63-164A-4FFC-9D62-EC0F8C33CB25@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 15 Dec 2024 17:25:41 -0700
Message-ID: <CAFLszThihaEMNkDOkyPRgc80C933y8k2nE6YYZ-NWEgdw3gQNw@mail.gmail.com>
Subject: Re: [PATCH 5/5] gitlab: Add a StarFive VisionFive2 to the sjg lab
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
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

Hi Heinrich,

On Sat, 14 Dec 2024 at 14:15, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> Am 14. Dezember 2024 19:20:24 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >I have one of these boards loaded with Ubuntu 24.10 (64-bit). Add an
> >entry for it so that it can be used for testing.
> >
> >Signed-off-by: Simon Glass <sjg@chromium.org>
> >---
> >
> > .gitlab-ci.yml | 5 +++++
> > 1 file changed, 5 insertions(+)
> >
> >diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> >index f379c11a1ba..33ec4b2e417 100644
> >--- a/.gitlab-ci.yml
> >+++ b/.gitlab-ci.yml
> >@@ -691,3 +691,8 @@ nyan-big:
> >   variables:
> >     ROLE: nyan-big
> >   <<: *lab_dfn
> >+
> >+vision5:
>
> vf2: would better allude to what it is. But it is your lab.

OK

>
> >+  variables:
> >+    ROLE: vision5
> >+  <<: *lab_dfn
>
> Could you, please, add a comment line describing the entry.

Yes I can do that. I am also wondering if we could show some board
details when gitlab uses the board, obtained from Labgrid.

Regards,
Simon
