Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4276E95A6A
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C73C86EC8;
	Sat,  7 Oct 2023 22:38:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bDwgomMO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 620C586DFC; Sat,  7 Oct 2023 22:37:58 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D016386DF4
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:37:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-53b8f8c6b1fso782751a12.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696711073; x=1697315873; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zTRXZ5KrSHgNhcLhHKZQUqi4+/8Cp10m7D1FsDzMqS0=;
 b=bDwgomMOvj2TW22DmB4XB9oa0wt2PSSlXwUlpGLyKfTzV11BcItP7Xdsjuk/U95FMg
 DIocI6LmTUwWcdLNRdy6bHhzpHB9w2IfUBlQv6pD44SX9Y4tdjklV0frjSnPTo0hmXxr
 M5p6oIBe7MVtWp6TYWTN5EbZYkaLyVq0DRi4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696711073; x=1697315873;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zTRXZ5KrSHgNhcLhHKZQUqi4+/8Cp10m7D1FsDzMqS0=;
 b=k7S3r2/a+MC/OZ0+j1m1Fc60r7eWZam5X852tWxeSoDZu2oKwThAuj8U4voRPmAlld
 3fyGJ4jCB+PXhwfZ1UcO48smpwsyUkBdf0xexMyYYlxUFl5e+lnht5Hn43cHOkV9rXH8
 XhY9l3fr8O59I2PmiFN5G3/puEhgwc0Q1k9GtGvSqJqLPJg1m9Bij/xnGxHE9nEnGGu5
 uTVSHGY3H1+oakOHo1tQ6G+joSCQn0Y0H1TfWjW4PLdqQX833zco5r7G/bAz/CXt0DOi
 oJXp0s2siH7NlLJ1lGsslOWHs+Dwa/7cGt/TOP9q3AzCQH4QOhw4zY1ANc5GCmAWelb0
 wNOw==
X-Gm-Message-State: AOJu0YxOhhjBLlkUp+IR3qwhFRPmZCIkA8iC2aZlSOxhq4aGWbaG3P0w
 soSVbBXupKOB/wMIqOUsBAhA/V9mZrOElr2YBuGndA==
X-Google-Smtp-Source: AGHT+IGhp0kRs5d8AKfdTgEsxSNaNm7/evQ4X8rpprGBPmpup/8AXByJR1VuIGf4R/GXoCpc5i1vpAvQ4oqf7DiOLJY=
X-Received: by 2002:a05:6402:748:b0:532:ac24:5c00 with SMTP id
 p8-20020a056402074800b00532ac245c00mr8979750edy.40.1696711073482; Sat, 07 Oct
 2023 13:37:53 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 7 Oct 2023 13:37:52 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ1d-FyAVcXWzBtJBsovp-X+ZPUDMeCGJkowWREcRUm+5Q@mail.gmail.com>
References: <CAPnjgZ1d-FyAVcXWzBtJBsovp-X+ZPUDMeCGJkowWREcRUm+5Q@mail.gmail.com>
 <20230923194424.1739224-15-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Sat, 7 Oct 2023 13:37:52 -0700
X-Google-Sender-Auth: VBi17WnyaKhs23LfWDgvXOt7UD8
Message-ID: <CAPnjgZ0gMoWToZk4qk-0RcR3n7EvU+7Kp68h69BJLoAFQ324XQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/27] moveconfig: Correct list-comprehension warnings
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

Correct some pylint warnings about needing to use list comprehension.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Applied to u-boot-dm, thanks!
Applied to u-boot-dm, thanks!
