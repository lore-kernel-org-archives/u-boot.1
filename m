Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F54FF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 14:57:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3735783FDB;
	Thu, 30 Apr 2026 16:57:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OUjL9osh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48BA580086; Thu, 30 Apr 2026 16:57:09 +0200 (CEST)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28B7280086
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 16:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x241.google.com with SMTP id
 5614622812f47-479e4835e08so651501b6e.1
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 07:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777561026; x=1778165826; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2v12D8DMdEHkDsSY28SPjb5NmnxBe+qIR6eHUWDVIes=;
 b=OUjL9oshNJ6+ifzmehNRwY2k97F8M/wq6cNvZp8AuHjOVUdiDYw9Fo5HzNTKDhPUsF
 WvRQbHJpcRTvBIulw64wu1OnFlcydH0FMLpsqsSmgPWGAajq3UtZwnM9XUSeC1VKuy11
 TE3AHBN1Q0852Yt/w76C3anR7oyOCjy+CwyEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777561026; x=1778165826;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2v12D8DMdEHkDsSY28SPjb5NmnxBe+qIR6eHUWDVIes=;
 b=FLr2UQWzldf+UCNQW5zybUHtxupOmWtIxpKw0+AsQ6o6BqwmDt/YxaP6JhiV21jfnM
 +vjI3SZdfSczS2dyWlyJm+ayY0DCEXjL339AAKAYIc1sPGjosW5dad78EsC1tSBZOKl0
 5maqngC1rplvVfQxHxp2R9F8m0aK5VI8em2mI6Y0YnUQcFp4bQ8drFLED/f8oR18EHN1
 f0uEiIZX60ryIWROwULZD6Za/2AYCwhy5C1f+cyOou8kgVdJ4KUR66+74FfKG6lnAHi0
 goMS4d/zxT2qn+FuOj5Q0Y9JAcCGsTOe4OiiUO01F9vjYjk0Sz5bjWEHdF5qRyT3VUhE
 9H4A==
X-Gm-Message-State: AOJu0YwHYjWffTQKeyBMFKm2OkaaZ2WmMBEjAnjlemzzNLgHpPg+wWII
 SOTOyKiTMIjvt4zQGUFAlNmgiRJqPMEb/PFhx88ahijZ7F5kmb+2mUldVDQmXpPJUK4=
X-Gm-Gg: AeBDiev4txjscSqzUTqwfGPxgzr1ZJxHemiXXvShWt69qK+Nu92tfLtFPrd1I0DPyY8
 mQePsQlXZfDl7CfBRmrpW+L1axTsaZPpsxk+Th59XHkEWR6On21rJOxmF+5pAJSw3Bv9hUdUCqr
 3sbALpVdHX4XR8m8/2gAhTUlDevy+xkqs467/g7X8dM/MpJ6DUuWlQ+bvRb7+L4ngBAECBBKzlc
 TUSAk4Pk4bRXrkYGiFLHZkqd0TVHq/br6qTMbIKciPD+kHLs7QXNosqdWn33ebq2+rgzPi6RYZY
 1NcSFVWq8wWhXI/zD2HzZ6wOcmbyeVBEGaE+5yWpx0Ker1DQsV+Xga7hMkofS/iNu5Kojnr+7k2
 mqXaRynFVjyAYKMFiiMF6oUA2FGntFFmV5buwcq3rPjnwWoQBCGGwGhOz18JJemex6qQjNph/e+
 4E6qPBVjBEg2eEPJkDkSb2csNJ0kS7v0s2qi9Ix7RRe2tEPC/+jPkoTqMZx9rmTeavpaAxbCxSw
 bg44ZFV6c06Me1wwCHQEIVR5ekHChtGEqWVLd6gY6Ecg0AlsOCQsVbMEJP3JJVMlLokR80=
X-Received: by 2002:a05:6808:4f4f:b0:479:fb8d:dfb8 with SMTP id
 5614622812f47-47c5fd83281mr1699867b6e.41.1777561025673; 
 Thu, 30 Apr 2026 07:57:05 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c43ee0400sm2998426b6e.7.2026.04.30.07.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 07:57:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260429122818.392911-1-marek.vasut+usb@mailbox.org>
References: <20260429122818.392911-1-marek.vasut+usb@mailbox.org>
Subject: Re: [PULL] u-boot-usb/master
Message-Id: <177756102497.1633235.6741928117569317421.b4-ty@konsulko.com>
Date: Thu, 30 Apr 2026 08:57:04 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 29 Apr 2026 14:27:49 +0200, Marek Vasut wrote:

> The following changes since commit d0d1d11119282b76551d45e531235238da51d7bc:
> 
>   usb: gadget: rcar: Add support for RZ/G2L (R9A07G044) (2026-04-26 17:52:36 +0200)
> 
> are available in the Git repository at:
> 
>   git://source.denx.de/u-boot-usb.git master
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


