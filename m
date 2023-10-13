Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFBBCDB47E
	for <u-boot@archiver.kernel.org>; Sat, 14 Oct 2023 02:10:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C81886F26;
	Sat, 14 Oct 2023 03:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KRcn3Q1N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0A6186F28; Sat, 14 Oct 2023 00:07:03 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14C7D86F28
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 00:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53df747cfe5so4713521a12.2
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 15:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697234440; x=1697839240; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xzC3gqISvG0H62dr0ERTzrsCx7rcC7CUoUAeGiL65vA=;
 b=KRcn3Q1N4funNlYBtlaunnKUU/AMcEt7TdrdsKAw0W8yz9aOH4PG9zYdGf6I1uoVqY
 nYW9uQsNnq6zBbm2apihEBTvi7c1viOOLNNJlf+BDj9lQG9Zolb/YmBBvZxqIRLR5LZr
 WuB4BCiCQ/x6kBLkQQyZlUbDKpPHWJcO1rdMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697234440; x=1697839240;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xzC3gqISvG0H62dr0ERTzrsCx7rcC7CUoUAeGiL65vA=;
 b=t29QSdQAswGZCjqLuBumRKxgy0WO2/Y0TUVgptw92FRT4g9RTppnSOBO+USZU0FUI1
 SAzAp7afMRTwYW8/FZJGgMiazbqTUdEhu+eboN3ylMDW5zswHNH/rqIjZyON8PST7MHu
 iBnFZc7ppf8Ev17UQ8nTLLhg0jD4TaP2t1JXevNR5PZzf+FM0gvDz7Jylsx9mI2pa8Sq
 IvgB6+mNm2/w08dIRY8otB/dtcdIYN2qe5KZIx/TMlQxNBllZIcobzXHhpHrKoopNrOb
 s/mSjhecvbYOuVADRCroM2BTGdgC/WpKhn26k3SaZSg0fvdrA5y8kRkTIiqiNsSvbWqi
 V8xg==
X-Gm-Message-State: AOJu0YwTkuc7rJGLSjFqMN41rqO3RfXSq1WYtrb2zB6u1hHAIfZSdH5V
 5W/1OAaSpgbx4vx6ijE1hVtSKhupqfgxMDviHTErFA==
X-Google-Smtp-Source: AGHT+IFW+d6eGNYBQ4zTElGP9A6HZ/AE2GpIfA7ooCvWwVYHN5LM6JIeZRag/mqHl3dP9wo5Ud8NYJOMcmynRGcnUxQ=
X-Received: by 2002:a50:c058:0:b0:53e:455c:6273 with SMTP id
 u24-20020a50c058000000b0053e455c6273mr2453924edd.2.1697234440259; Fri, 13 Oct
 2023 15:00:40 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Oct 2023 15:00:38 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231010091059.375036-2-sughosh.ganu@linaro.org>
References: <20231010091059.375036-2-sughosh.ganu@linaro.org>
 <20231010091059.375036-1-sughosh.ganu@linaro.org>
Date: Fri, 13 Oct 2023 15:00:38 -0700
X-Google-Sender-Auth: JHplku3io6o09vFoMMAtQKGQ-ak
Message-ID: <CAPnjgZ2H3+t9zdoYq7gqbczRGwxQ4Nii50ZyiNNcaaNWaPgvxQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] tools: mkeficapsule: Add support to print capsule
 headers
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
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

Add support to dump the contents of capsule headers. This is useful as
a debug feature for checking the contents of the capsule headers, and
can also be used in capsule verification.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes since V1:
* Get rid of the superfluous hdr_size variable in the
  dump_fmp_payload_header() function

 tools/eficapsule.h   |   2 +
 tools/mkeficapsule.c | 227 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 228 insertions(+), 1 deletion(-)

Applied to u-boot-dm, thanks!
