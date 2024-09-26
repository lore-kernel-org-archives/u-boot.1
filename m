Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61892CDE03C
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:08:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3514D88F44;
	Fri, 27 Sep 2024 00:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bnm/laAY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BDAA88F46; Fri, 27 Sep 2024 00:07:25 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B9A288E51
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:07:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2e0a74ce880so844230a91.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727388441; x=1727993241; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GfpCLcRcVodDIOpvDfroCKlx8aWWJ3N4xMz54cSweKM=;
 b=bnm/laAYg+5j8ycvwjodqoB1eaym44ZGlnivZaFZKIV6P5Qa1jOZh/+OYQg4JMO269
 vCYHonIwrIQqm7iLLTWUTUXrxwqv8Gv85/XSnSzLCalyeWocg/LR1ZjBxnQryaE2yDzD
 PA9m3bJJADOrlG1CXVntB2cZVUKb7ii00W57s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388441; x=1727993241;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GfpCLcRcVodDIOpvDfroCKlx8aWWJ3N4xMz54cSweKM=;
 b=WcCYJDJK/6moTrXZGWriGlqT8vyKagQ7uKlimfzD6yghvhJmY8WihguzL7QpQtMx5C
 kwqtIY6B+ibp4NPYeUYI+raqWOKP62TdUHweI+2TudmcqZcs/ezV7TuK/6ZyRz9Z9Ntq
 DEEjyrOmWEW6x2ZfFIABVZl7wYbE8BxgEn+3HVU0aAv8bMpeqsXIWlb911HdcbhDYK6x
 RHgggPHeIvSpd87IwHAMkMv8cxmCj3RanxX1GYNF3MgsEYhTOELlm/iNIyTHwyg4+/E+
 i86aAWEa6ooTO7oviHzrV+7yZsk3e9gDXF2NUcDDekctiQEjFm4kTvT5BzHiBmhFsXza
 vkWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuQ8tcmxvRz4whXnxEOPkhxa6ApL96oMpKwll7gWsWBbVkM9uTL4zEo3XDnJuV/HKbep+ZvYY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/EyzWX6988lQcb5RFdw1HGQH/QGj0X/y/GzTuPK0GShOxx8M5
 o21+24KRjG7AcZwAV6ciydBpAsqUxIwmTtZGvXgA4wVdUkniHQ2Jn6ybtp6bPCDrd/SmISbQzsE
 78GMhh0iEf9as/t+Ew0gMCgYw/xqNPExgb6vA
X-Google-Smtp-Source: AGHT+IGkuIsTcwoWGS3t8R0YRPnq3LKMu77akM2x+ofkouS0vjtl+X9PfU5VY2bijQAKt98FSv8ERCaZbqhHTbT7QjI=
X-Received: by 2002:a17:90a:ec0d:b0:2d8:7edb:fd2 with SMTP id
 98e67ed59e1d1-2e0b8b49913mr1375735a91.22.1727388441695; Thu, 26 Sep 2024
 15:07:21 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Sep 2024 18:07:20 -0400
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240826191143.426387-12-sjg@chromium.org>
References: <20240826191143.426387-12-sjg@chromium.org>
 <20240826191143.426387-1-sjg@chromium.org>
Date: Thu, 26 Sep 2024 18:07:20 -0400
X-Google-Sender-Auth: 7dJEw1ujyfUwiZyKeMnMwxXsfTo
Message-ID: <CAFLszTj196sH82Dt0YP-7TexNQxxg0en7Aogwp1=MU2dxGC=yA@mail.gmail.com>
Subject: Re: [PATCH 11/15] binman: Add minor improvements to symbol-writing
To: Simon Glass <sjg@chromium.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Brandon Maier <brandon.maier@collins.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
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

Add a clarification to the documentation and add a missing comment. Also
update the test so that when it fails it is easier to see what is going
on, rather than having to decode hex strings.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/binman.rst |  4 +++-
 tools/binman/elf.py     |  3 ++-
 tools/binman/ftest.py   | 36 +++++++++++++++++++++++++++++-------
 3 files changed, 34 insertions(+), 9 deletions(-)

Applied to u-boot-dm/next, thanks!
