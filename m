Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BC4CDE03D
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:07:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A8E588F28;
	Fri, 27 Sep 2024 00:07:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m/JgVK3D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7FA788F31; Fri, 27 Sep 2024 00:07:21 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A941588E04
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:07:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2e075ceebdaso1141821a91.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727388438; x=1727993238; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d8R6giqP5FJjVQGiNXGO5XjgnWtxRbfAbZH7hxWOW78=;
 b=m/JgVK3D6dSrtl1g8Azx0BGhtT8vIqbHJHGGyD6Zyf/Sdlox+zu044bxLa9IQtz2F1
 ztB1jm1n84O6ggpwBtDWn+ZR6DjTGpyKYhc+blYOdYqYKIYHamtr+cxsYpU84H7CuFSj
 27sDqMi+HJdZg4Vr/2hsCi68qTTtLZ9F1og+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388438; x=1727993238;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d8R6giqP5FJjVQGiNXGO5XjgnWtxRbfAbZH7hxWOW78=;
 b=bmMrQrBmRvVLtMBxFr7jhcrtKSpnfX/0DP+vGFvE2y8/sD9pqMfh3MHJApVaKIPVig
 gUg4ku6uRDOTCpC9haS/qtjaLZqLjWEj/6QlZp6uvPOtMUHUXZtXlWjBIY0pOwOmYJn5
 Fi2pAu9DadaT+2ubY0C9NOLoUWxE1wIb+LbZMKnE6ujMPe45hoHjngA5OlpmsMt0hnED
 BRWrqBWV1RAWqnabb1MQL9P66s1P1D/Qzzo+JgfaMwHfJwHv0NPIkIcN0xjWeB8GPl1P
 No8hJ6LPNQioIy2j56OVVi2iTWPafVtezyV3dWmVxihtKKjPvcJ6eiEuVpmNNnwyPrTs
 YcTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoj4cX02vmW62RA6T3+5v6ZqKclCvHomqMWj2gd/h2vcupH2dNd+6D3DN0n6Oiu3LSDm+/8wA=@lists.denx.de
X-Gm-Message-State: AOJu0YwZk3qUmzKZcJgTIBETiMT6+hW+9CXQdYgKRuzY1kClQjMXPOzu
 cJ4+tSBNNGLPnH+umN5KwxaG8ce994FmGF/qlh5sZb/jDdlQqTHLIC5fmQ+5CNGCkW7m868Jsdi
 tMhod504Lwosb5NhcUnilH/hxWm3nqCSWkE5X
X-Google-Smtp-Source: AGHT+IF4ApjTtiYpB+iypHVD5u020LNnZeYv6c6LXfEsc1O7hqZOWO13ovPXbX49PlKiPUg7UIuSuOk4FIU/vY06psg=
X-Received: by 2002:a17:90a:43e3:b0:2d8:e3f3:fd66 with SMTP id
 98e67ed59e1d1-2e0b8ed3b30mr1205304a91.34.1727388438244; Thu, 26 Sep 2024
 15:07:18 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Sep 2024 15:07:16 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240826191143.426387-14-sjg@chromium.org>
References: <20240826191143.426387-14-sjg@chromium.org>
 <20240826191143.426387-1-sjg@chromium.org>
Date: Thu, 26 Sep 2024 15:07:16 -0700
X-Google-Sender-Auth: k7sCGsaktYsO2nZjuNXPQ0KxXEE
Message-ID: <CAFLszTgD0-CTchi23RwBWx9g54q_C0YphvDSo3yV4-e6P=1qgA@mail.gmail.com>
Subject: Re: [PATCH 13/15] binman: Unwind the end-at-4gb special-case a little
To: Simon Glass <sjg@chromium.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Rong Tao <rongtao@cestc.cn>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Move the check for this further out, so that base_addr is computed in
Entry.WriteSymbols() rather than at lower levels.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/entry.py         | 11 +++++++++--
 tools/binman/etype/section.py | 15 +++++----------
 tools/binman/image.py         | 10 ++++------
 3 files changed, 18 insertions(+), 18 deletions(-)

Applied to u-boot-dm/next, thanks!
