Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9A7E95A6A
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:45:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22C9086EDF;
	Sat,  7 Oct 2023 22:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jHpKCihq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1E4686ACA; Sat,  7 Oct 2023 22:38:24 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D80D286DFE
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:38:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d868d8363e6so3813656276.2
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696711099; x=1697315899; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+aMAqu5d1bbrQFwsi5luuZMjo96WuTj7nB8PAey2TC8=;
 b=jHpKCihq91ISo3SXMIGJKf8vtxS8jOgpxPMkhiEO6w0L3zGQ2o+pRA0w8d5l+F18ug
 a+5IlH9RdjX2rsG3wFBTq8NRpmLUKlwOHyA0eFgNFdqhI+g3VtxbjzvgFyzBTcG1w6j2
 oObQzJ6HBMxDUeyOJffAqWSHAOnsnVA+Abug8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696711099; x=1697315899;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+aMAqu5d1bbrQFwsi5luuZMjo96WuTj7nB8PAey2TC8=;
 b=Cs8I2u0YvA7rdbyBZlXJfwgECKCifKJ9te7/0nUFjxKT252ZJOXn9qmwihtBEu0nNJ
 qJBFGCNZ+PRkBHW4hgmQ9Jbp+2yF/m5izPOT0lSitOAR6s4nqDdhj9fFY/CHlHAHCD68
 MwjAOHcLUjkWweVj3C++o8EqaEm+2RWxv1pP8qPzrDuwHNJTBiFZSqj7BOURCoNUQJbY
 O8lr1xwKldtiwal/9qmdtqp0mSPJ2nZ8cdfPa+G3P8kyqC4Ojd3SiG1oWfE6vqWbrpgB
 sKITKD7bt/06WwmP62MN+LV7Nmaa2WxpxZ/C3iAEQVHy9Fb4XtA1XWk7mdAgwHMpUaYL
 wn2w==
X-Gm-Message-State: AOJu0YyzYaOrdhdx/NlFOq0ju23k43iRN5tR684JQ9jJiqEUzUqrVa/K
 UsdmCqnnRe1+CAe072YHfUtJdG60h/HLcKxICIxbCJfmpaCIAvSEut8=
X-Google-Smtp-Source: AGHT+IFLDKEiwaX2qTXHws1YdXg0zh64H0K8GuihBXjKFrTElL7TySDHZ2hPSKPuilhlAywJWpB0F62qDGj4nuovZc4=
X-Received: by 2002:a0d:c787:0:b0:59f:7fb9:621a with SMTP id
 j129-20020a0dc787000000b0059f7fb9621amr11892566ywd.22.1696711099335; Sat, 07
 Oct 2023 13:38:19 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 7 Oct 2023 15:38:10 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ0gWJw=Xdj5Tp6+OH=23cxWnD8vBfUFMkOz9SQJT6YMow@mail.gmail.com>
References: <CAPnjgZ0gWJw=Xdj5Tp6+OH=23cxWnD8vBfUFMkOz9SQJT6YMow@mail.gmail.com>
 <20230923194424.1739224-3-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Sat, 7 Oct 2023 15:38:10 -0500
X-Google-Sender-Auth: yS7_7teIocY_a_y4qg-0ppboR2s
Message-ID: <CAPnjgZ23fd3Q_R3eRXSh+YK8zFXQvrK+qVgY5NoEN2fmwY_OXw@mail.gmail.com>
Subject: Re: [PATCH v3 02/27] moveconfig: Avoid deprecation warning for
 setDaemon
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

Use the recommended new way of setting a thread to be a daemon.

This avoids a warning:

   DeprecationWarning: setDaemon() is deprecated, set the daemon attribute
      instead

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Applied to u-boot-dm, thanks!
Applied to u-boot-dm, thanks!
