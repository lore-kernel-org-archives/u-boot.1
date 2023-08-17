Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891F6C2FC29
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 13:43:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B490586B69;
	Thu, 17 Aug 2023 15:42:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bYpKAMMC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6355E86B78; Thu, 17 Aug 2023 15:42:55 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3097E86B66
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 15:42:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-d71c3a32e1aso1496323276.3
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 06:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692279769; x=1692884569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3mO049DtbiMC5qZx8aGBpm7hQnBzog9k9wd5/HLVKgI=;
 b=bYpKAMMCfzUz1HYZjx1nhPLKLiBc4LBBTRPfrOerTjYzR1S2Uc0oT6YBKHJxMFtFyV
 7Y7ypW4M8oLKJJ7mBOUzBFgz+s3fw5N9p1N/MTic7NvTgAvYy44W4RE7566DATsnh80u
 b9b3xrc/UGqEkxkHCF4QGiHMIJbNucBh/O9xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692279769; x=1692884569;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3mO049DtbiMC5qZx8aGBpm7hQnBzog9k9wd5/HLVKgI=;
 b=CpOx0kkXauYruBtK+CPcE9j2/+rLH8tduAvMeb+y3oM0qbJcFF/d5/L5vJTE/768wD
 jtuGbEy+6AwYpHZ1KEl1i1VXaApJTTGKpIkCDwredcBaqgJIM93mYLaobog7PJWsigv6
 OKH9Uwzq4XWY7cdxuB+zZ/8xrbtA0/0IybTe2pHs9XWZQhxCl/R1Lff+O8bH4Bwq1mz9
 J/T0of2EHFwew5iIlnublQP9/PJVFQyDnhe6ryf4DHwdQ6z7KNaC7BdwJfu/VxFsmfCM
 xGmKHfqKah9+REM8I/QcoRrxGbV1jhubwhOU8rtQgusKkQjf6+71STB/OVMDp0evK0A5
 Fb+A==
X-Gm-Message-State: AOJu0YxvFzU8vsenyVyYL0IvFfhIOBAZILOrFOlypg5d/OnZ22KsIDss
 M8+57gYkMjq/cAGB+HyyxUu5U1IiPyDTSaRdwItzSw==
X-Google-Smtp-Source: AGHT+IEBdZa7ZMavomx2+Idgvsj4OTRWWM60GAaiwHvjeKmjuW+gQQy+/2xm7xLpfR17xIvaBMU/jdRTmFtiadvsDdQ=
X-Received: by 2002:a25:9388:0:b0:d58:6c03:1af0 with SMTP id
 a8-20020a259388000000b00d586c031af0mr4937206ybm.0.1692279768683; Thu, 17 Aug
 2023 06:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230812002823.82576-1-seanedmond@linux.microsoft.com>
 <20230812002823.82576-6-seanedmond@linux.microsoft.com>
In-Reply-To: <20230812002823.82576-6-seanedmond@linux.microsoft.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Aug 2023 07:41:48 -0600
Message-ID: <CAPnjgZ0gNYx3vKhjD9ct5LnhMFRoWP805=s=sYGbf_An1Lsydw@mail.gmail.com>
Subject: Re: [PATCH 5/5] dm: test: Add a test for security driver
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, stcarlso@linux.microsoft.com, 
 ilias.apalodimas@linaro.org, abdellatif.elkhlifi@arm.com
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

Hi Sean,

On Fri, 11 Aug 2023 at 18:28, <seanedmond@linux.microsoft.com> wrote:
>
> From: Sean Edmond <seanedmond@microsoft.com>
>
> Adds a test for a sandbox and TPM backed security driver.
>
> Allows for testing of anti-rollback version number get/set API using the
> security driver.
>
> Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
> ---
>  arch/sandbox/dts/test.dts |  8 ++++
>  configs/sandbox_defconfig |  3 ++
>  test/dm/Makefile          |  1 +
>  test/dm/security.c        | 78 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 90 insertions(+)
>  create mode 100644 test/dm/security.c

Again please drop the dm_ prefixes.

Regards,
Simon
