Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB22CDE03D
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:08:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEFCF88F60;
	Fri, 27 Sep 2024 00:07:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P9HeZYFt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A67FC88F60; Fri, 27 Sep 2024 00:07:28 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 848DA88EEC
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:07:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7db4c1a54easo908782a12.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727388445; x=1727993245; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aRkm3RC8v40Cqwm2s5uHqaSIyzRzx/umJcGCLawPJ7c=;
 b=P9HeZYFtBhDcW9Ivl7pZpzjk1drT8f9+x6ldkb9AJI70GbJ6GIUWWXgUjMVPigErgD
 Cp+Ja0G7UXFmCyL+jFlxjioPqcLmHjqXBJcPVwWyDBSv4bVo8FBrmEGWfA1AP9zTa9lQ
 lDbOrWfO112GCwriN/XFAwmvY1IIR3pO0nIz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388445; x=1727993245;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aRkm3RC8v40Cqwm2s5uHqaSIyzRzx/umJcGCLawPJ7c=;
 b=U5t+iumT9L1IIyXgMCvENcF3FGc4IjpgF0J2G9TaEVURfZ8nrvqGDoI73xsSR4hkNg
 w0CjKAOMnMAn+XdagSJHCUoLOvy5lJS9JqbZXBCqDWgxiJFPbztG2Y7CrnzhmftJrIE/
 Xsi5CZSqmwAMKlkOTrzObv+Jj3oxZVhYvuIlezGmYY1fTSP9/L6or/149LAawkNLKYbp
 4i2yC2HwnJJfJvXnKSuxf/tahRtAOUkNfvI7P7HTCXt9808W1IxrtKF67dBcHC8ML577
 Nil+fAktPouW/qvhYtlURttuPBCdgFfeWmb54E/U6wV9yRpqzbCKeWX1D68NicAg0LE+
 8FhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYgaoO7/h3SfEAT7r5OyfIqj0vVa0WICwMrdpHcd5uMuLjEYKO8uXq/yojtfYzARYmtUbKBAA=@lists.denx.de
X-Gm-Message-State: AOJu0YxhFjBztvlG1bR0uFlTtp175aitCvwgX6djau9RYS8XMlU51peR
 GRKTi5nueQwvsbap4F5sdHkoS5SfSsfqJDH1Z1AySVT5LHmYqxF2AnyENJCwEhl0VyvACymO26v
 bVjY9MA3mavuuNUrFIYzp+qufNNRdTiQnlHgs
X-Google-Smtp-Source: AGHT+IFISUHSqb66JtRj3o6hMngOV4q6sjef2Rb8nsQa0kvIHmBw2vjJjm9TFFxfZ20Uh7nkj+hRg+Lm+FqMhDPFBhs=
X-Received: by 2002:a17:90a:f30a:b0:2d8:e7db:9996 with SMTP id
 98e67ed59e1d1-2e0b89e6007mr1385661a91.13.1727388445109; Thu, 26 Sep 2024
 15:07:25 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Sep 2024 15:07:23 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240826191143.426387-10-sjg@chromium.org>
References: <20240826191143.426387-10-sjg@chromium.org>
 <20240826191143.426387-1-sjg@chromium.org>
Date: Thu, 26 Sep 2024 15:07:23 -0700
X-Google-Sender-Auth: q3hI-Eu5jWvLuaQuIF6AJgSnNPI
Message-ID: <CAFLszTjyTWS9vuEpH8rYoMMgWE1WSPjA=tDSLh-9wprJTDNHdA@mail.gmail.com>
Subject: Re: [PATCH 09/15] binman: fit: Refine handling of devicetrees for
 OF_UPSTREAM
To: Simon Glass <sjg@chromium.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Brandon Maier <brandon.maier@collins.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

With OF_UPSTREAM the dts files are in an SoC-specific subdirectory,
meaning that the resulting dtb files all end up in a similar
subdirectory.

We don't want the subdirectory name to appear as a node name in the FIT,
so handle this as a special case.

Also the default devicetree may have a directory-name prefix, so handle
that when searching through the available devicetree files.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/etype/fit.py | 19 ++++++++++++-------
 tools/binman/ftest.py     | 15 ++++++++++++++-
 2 files changed, 26 insertions(+), 8 deletions(-)

Applied to u-boot-dm/next, thanks!
