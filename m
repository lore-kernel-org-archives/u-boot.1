Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F6FC54E71
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 04:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDD21834A3;
	Sat, 24 May 2025 06:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mtu6HH1s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E24783466; Sat, 24 May 2025 06:25:25 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1240834A3
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-acbb85ce788so88284466b.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 21:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748060723; x=1748665523; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uYinZNnTlMt0TnopNVT58I2hROKlzhqwtKm7bhzNqKc=;
 b=mtu6HH1sxizSd8Gnku3KrWo8kxCnp3+iVuc6HlTJ2NoeHBhGdMO5iJMG1CD+ndVq/K
 ZQeRhC3TE/h0GpMytVo4+4YBimTLHRDZw4x3YLHV8+8iuvVIopD8gFVsd5957iAntX3r
 R6kTHI0NI2KxiOzw8U3e6msMTU34UMEJwXk6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748060723; x=1748665523;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uYinZNnTlMt0TnopNVT58I2hROKlzhqwtKm7bhzNqKc=;
 b=CWtiHMPQg1Pxzg2STWX6wKcjK78oL6Gbre2oCGEEa+0ecyS5chK6QL2NWL84H5dwdj
 3T/x3SY3ezBss25osq4Han5Qc6SVuhVc+zi5gv7IhAmPg2TnTh5wqDgQ/KqW5fhuLZiC
 XVErGklZhNvCKfoiGCtJAQ+vpamvp6+wtp+7l8JUBhg7Mtx56omG57wwdFPBW93Wozo3
 NDy0vv53Grg+knBiUoX4L+gf5k0FM3hDHGiDSWYUmaq92Nq4riIuhrpE/0SnTF80V5//
 ZNi5s62Fka+13HeTxAarkNMpaheJEsScvtyt3fqS/WubPs8k8CqK+vcMkt5g3UTN7rsi
 +XnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFvRo3i26dFFImDfd8Tj45fSfxcx/RunYoUqflI2147mOWbSjz/k4RXjrPzZL/7hQJ2XHXJI4=@lists.denx.de
X-Gm-Message-State: AOJu0YwnEcOZtYFaguvOrpy9N4HUDaOH7aMCE1SrXun/M9A6Y+Ls5LFf
 B8OLUyf7FflbZsXEKfYkZ8ZxIVduNXcIxaaRoEb366h+LU8BeDn5wI4s8HD5BbbCH/HpFEZc//M
 /M2Re5xnr5Cy4CyHGR3t/BJii42xhCnORGbwuCxv+
X-Gm-Gg: ASbGncvgaBQZrHBGtKwuyavKgF/6bLsqa0y7BpHvwmtmPT7Q/EVgtCzuRjNyyczvbA1
 CnjnX1D+JCze4fK96Vf9hASffsJRKUZczlFAx+2KhUA6zLkgJffVBk9Tzx53wE2ax5Q8xzMmTvB
 JQixHHvaHPJ1fgTEAZaUqTUiX5bLI0/njFXY2obIi5kA==
X-Google-Smtp-Source: AGHT+IHZu+Iq7MBEbGinGwmEQKBaav2cei0/6+F3fJq1I1cc2Aw8aKiX7XW2WOWJa0izDdz6xHGkygqjebKcV4rM3Ag=
X-Received: by 2002:a17:907:6091:b0:acb:b1be:4873 with SMTP id
 a640c23a62f3a-ad85b0518cfmr143666966b.2.1748060723219; Fri, 23 May 2025
 21:25:23 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 23:25:22 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 23:25:22 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250508072907.207175-14-sjg@chromium.org>
References: <20250508072907.207175-14-sjg@chromium.org>
 <20250508072907.207175-1-sjg@chromium.org>
Date: Fri, 23 May 2025 23:25:22 -0500
X-Google-Sender-Auth: OXs4V11sKDqjfVFxmyRofBaHk0s
X-Gm-Features: AX0GCFusyxIC1FgrYYiJQ_BZfdGrpxb7udjVGT9V8pH6t400cs_uZEDLIHwQAYA
Message-ID: <CAFLszTi5dh1Ye6Qo6i50Vy91-vvc832bfdNk5bkC10CTfKCxGg@mail.gmail.com>
Subject: Re: [PATCH 13/20] patman: Correct some pylint and asyncio issues
To: Simon Glass <sjg@chromium.org>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>, 
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

Correct some pylint warnings in this file. Make use of the existing
asyncio event loop, instead of creating a new one, since this also
destroys it afterwards, making it unavailable for tests which want to
share an event loop. Use tools.write_file() to avoid a warning about
encoding.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/func_test.py | 51 ++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

Applied to sjg/master, thanks!
