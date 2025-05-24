Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0024AC54E71
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 05:05:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4014883327;
	Sat, 24 May 2025 07:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P4EZZZCs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FB7B83334; Sat, 24 May 2025 07:05:39 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7045D83303
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 07:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6000f2f217dso961489a12.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 22:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748063137; x=1748667937; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eh3/4Ijh13lRTDDyLaVjoCfaOnhyOTtIfOQdBAV/kXc=;
 b=P4EZZZCsMtTxwM/0SkcRWMt7PxbkOk+k/D7XGsIYrgMqU4K0cJimm0Poj0OEHLorCC
 kX3nWVKxKJb+fYcqtEmWqxB+/5iTkuKMuwZle92a3FpUJ53315VfU0wxS4bIX3IvuTG2
 +0AHotG38fly8j9PDd3EJrvsX5z0wO+b/214Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748063137; x=1748667937;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eh3/4Ijh13lRTDDyLaVjoCfaOnhyOTtIfOQdBAV/kXc=;
 b=dk7FMRrJjfPMxrPblD3y6G2q8/PzJ9o5WD8cTtf9qg5QTGjdF6QvDqsBZfTQlMTjfv
 dh436gPr6HawXNexJsufkCM9BtITgr2cPBI6tKaf9YzlhBLIWk0KICI7RIHsFb2l06+8
 XIatHOKfrIzxq/eJatVoFgNSJiT/JisAqZv0l78iOgi+PhUbGrtoYdK1vuGVa5+xpky7
 cr4x8jaVN9HISdj3ZnETKBk+PNOCsZdo3Gk9uqHPNFmof6pxZXWkUzwtPvZsNWMdUJoG
 Qm85aS6EJHzvyjSjZKqGURHirUxJw8/PD3H+KyGMGSb9JQ6NOgOe+vzU6aUM0jpU7SJK
 6zLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUOhFoTg7SYFSsQbz0vBVj5W1YtsRjgVf2yp3NErh5Mqfep+zs7Z/uDgWjFfrdrRi699Tnsfg=@lists.denx.de
X-Gm-Message-State: AOJu0YwrwM2CswlrnbhAPXEMGaRlKlbZJRDg2ftz459NTLdIhX/yE/yQ
 hNqGYjRcg8X9SxjHD2iu0inPbCFa4z/TBZl8tOuOk2erCgzY2sDEKRgaAxCENQzC0hCnlfXO7zp
 CL+2pBKy/819UtYpms9p98hqloU/4I0Mny1CkALwo
X-Gm-Gg: ASbGncvMGSI/dHbI1p0s7wLBYkVAmqCpcvwboqxT3qIAbApIxpqwTbmrPIviFYCl9mh
 BFBldhLjw859Af2gVGYgh4cwTz2QdYz3Xj0tbILqTvxUiB2EMViYLaVfCljJqjbaguQhb4zk3Pp
 CzWfC5r9JNaMMFsi4Y606NA5UX484YeeE=
X-Google-Smtp-Source: AGHT+IGqK3buNVq7BF3PfJNHvA5zxFeuz+d4ftLrA2sygW144IwwLn4AUlunfX6KEGKSM33zNHcbRy5r5oGSy81pJMc=
X-Received: by 2002:a17:907:eb03:b0:ad5:640c:a087 with SMTP id
 a640c23a62f3a-ad85b2c681bmr118232566b.47.1748063136787; Fri, 23 May 2025
 22:05:36 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:05:35 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 May 2025 00:05:35 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250510110535.1453745-26-sjg@chromium.org>
References: <20250510110535.1453745-26-sjg@chromium.org>
 <20250510110535.1453745-1-sjg@chromium.org>
Date: Sat, 24 May 2025 00:05:35 -0500
X-Google-Sender-Auth: YBVjJ5WCkPLguZ0Vm35gH3L1nU8
X-Gm-Features: AX0GCFuJ2xj_uUBGYjtPUefD92wAOGEyt5sLLiM4Yu0A9wc6g_yKuYIpZBk9bFs
Message-ID: <CAFLszTiqPz0QHo-e_gWcxY90VKNzpL=XtKGrAvG71XzS=w+xvQ@mail.gmail.com>
Subject: Re: [PATCH 25/25] patman: Add basic documentation for new features
To: Simon Glass <sjg@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Describe the new subcommands and how they should be used in a normal
workflow.

Note that the naming of branches is very rigid, or 'opinionated' in
marketing terms. Patman can track a single branch for each version of a
series and they must all be named the same, except for the
version-number suffix. Version 1 series have no suffix.

This description is fairly bare-bones but should be enough for some
initial testing and comments.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 doc/develop/pics/patman.jpg | Bin 0 -> 97131 bytes
 tools/patman/patman.rst     | 283 +++++++++++++++++++++++++++++++++++-
 2 files changed, 280 insertions(+), 3 deletions(-)
 create mode 100644 doc/develop/pics/patman.jpg

Applied to sjg/master, thanks!
