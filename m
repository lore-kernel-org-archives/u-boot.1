Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3661D3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:15:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 760D688F23;
	Fri, 18 Oct 2024 01:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CNdYljtk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C90DF89068; Fri, 18 Oct 2024 01:12:01 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA24989128
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:11:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6c5acb785f2so8150726d6.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206717; x=1729811517; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FWKDOr0DeM9Ln0D6OsdVfUHFyV5S1usUD8inw977icc=;
 b=CNdYljtk/kzPhDtVVxNVIxCMLerUiuLfB9d4hGMs1mQMA2gSMh4bA+WKjAhWjKB17f
 hkejhj+HrcxjcP0BX8mgzT240qZ+GMnlFlXJRkEFtL5wDcGBrkF58bvGRvZuhACXQdxe
 QLtHlQn5Z7IXgxEtDxN2Yvn+uJJhJcYWf9DLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206717; x=1729811517;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FWKDOr0DeM9Ln0D6OsdVfUHFyV5S1usUD8inw977icc=;
 b=A5AZWqIPNWl9C0P7nMBNbxsewgH3GLYaWLDq6Ht2yo7dOtWa9m7E9GQbJtHawnVN0d
 QYdNNGYMUqn6UGFWCenv+LuEoxqChTByvK3HqJ0rixqFJNMrRAJgZpor7oWFu7Ssugge
 Zph0ChTfbnxgddA9m/vAIZ7hF5GrDINdaQoCEFpo9+muQItlSQ0w4LfLyS+P+V+6rwzK
 5RA3aS9CYz948iUGaZEwQ0M7WfHYhY7zSkupu9imP8LEyNS6BZyMVhI9BisXYEDmJ0tI
 r+YuMvKMvFxAAzEkI2QcItmtEcB+0pgd6ChzdPuQGOiDN+BSWM80WkKgqnV+OQZ2mh0H
 TrEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcRjYTVyOJD1THxjje+aQSH6K2LTNVt6b8wiTHRFMeFP72pi4or/zav8eRteuydxLOhKTdFfQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwdiW3P6Qqef25WpF3fbsdOtDtmKvImdEOfUIt/oM+CBf8z6pWt
 ptYu11VD222p2xVl9gZkcSYlroL8upWPfY5jRY37prfHsEVHOnFD6Olv6HMILzOCKtNEAu+pjbg
 dhFtKc3VUZg8xTqbe7yRNMrhjP2OlimSv55L3
X-Google-Smtp-Source: AGHT+IFiMv0thakwycFw6B/Sez/djjVi4turqE3Y4CD4kkvUG87UAGZ3Nc4lm+9zsQPUSAK7SORAFJORkuNb/iS2VCo=
X-Received: by 2002:a05:6214:3c86:b0:6cb:c487:24b5 with SMTP id
 6a1803df08f44-6cde15f1700mr7947586d6.32.1729206717714; Thu, 17 Oct 2024
 16:11:57 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:11:57 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240930185139.2185983-1-sjg@chromium.org>
References: <20240930185139.2185983-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:11:57 -0700
X-Google-Sender-Auth: 6CpL2eSq5-q1xb02jCKycmEm8nY
Message-ID: <CAFLszTjud93xNB5cbvDJVJBQyGEzrhpeTP6witQeCpL3y-QO9w@mail.gmail.com>
Subject: Re: [PATCH 1/3] u_boot_pylib: Support running coverage on selected
 functions
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Brian Ruley <brian.ruley@gehealthcare.com>, 
 Marek Vasut <marex@denx.de>, U-Boot Mailing List <u-boot@lists.denx.de>
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

At present run_test_coverage() assumes you want code coverage for the
entire code base. This is the normal situation, but sometimes it is
useful to see the coverage provided by just a single test. Add support
for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/u_boot_pylib/test_util.py | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

Applied to u-boot-dm, thanks!
