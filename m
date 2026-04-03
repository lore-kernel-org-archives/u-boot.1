Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF9CE85389
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 19:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D924184214;
	Fri,  3 Apr 2026 21:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sOTz5F+a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E9F0841D6; Fri,  3 Apr 2026 21:47:28 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CC3F840B0
 for <u-boot@lists.denx.de>; Fri,  3 Apr 2026 21:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-4704fb0d5b8so135929b6e.0
 for <u-boot@lists.denx.de>; Fri, 03 Apr 2026 12:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775245645; x=1775850445; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jO3UXVzZWZYkcixOOSIYx0j1Y0DP+vhG1pLxhgVHXTg=;
 b=sOTz5F+arZ0MgXaX51Bal4MbftPsYCOUdRz3j9HVDSU5uwGiQEMA0gVjz10Ns1SA69
 l7i4M8sBMnr88xtG+jYdRf7si2z0z0H71jsk5YVqpz8NENW7uUR2TgnmHVuM+XxpFMmf
 CcyKCGxXiz+GjOndgi5RUrGrChERGWis/FKvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775245645; x=1775850445;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jO3UXVzZWZYkcixOOSIYx0j1Y0DP+vhG1pLxhgVHXTg=;
 b=Zm8dx4nL9cm0tYDnHtrQO6mp9UPrdisqIlrpu9ObIn+COs+dTKThTLmc2NiXbjTXG9
 GJzMzrptn/XGmiNNLhqFHt4mLZ7/qyxy9F+5PneTGuPaCneeCTtGNMYTVasIFqO1E948
 UFaTVXLqHribAx/KG/E6U5MCj1fnoNFv4XJxFqp09UywlcuhZDkIMmHBWLo5weHcJF/+
 HeoXEJmF7lJIDow+etNIEwxeBK+kGsgB2JJynkRxcgsoZVfeY+1YebKLoPYuT8n3eAgD
 Ey/8vwYmhCQqUhRcZ0CM8RVtICkEArFnz0qkh5iXAXq1AUy3+W+EXCfqdOR0PPErL+N/
 V2lQ==
X-Gm-Message-State: AOJu0Yz9xcFsXsNEW55i9zaVVWo2m9rIkWBaMonGSmaj7njh+4w0ONja
 yJKiNpfAurqgcYhAVM1A2cLrmBWr2E7Z4nyKxf38SYjgHkEVknTUhky2xPUukymFB30=
X-Gm-Gg: ATEYQzzrUIH0ie9JyNy2n6wMKaUF9NBpsGjnlXE67oYbTYUTcay8BKf5IMiNPKiHOCd
 qMvp08ti9Nd8z7/4T3lEuPeCRkA5ZzT8ZQQhZvIdSkuL71sMevaga3KtomWK94HCDxVfcoGvcXm
 kCFvv6W7ESTUaBRhh7xJQizsy8NwHy2hEDsk28/6O7Vzy3fkRBVZi73Niwu59pnpMNZgkrIGiXn
 MnhlmotkRtsNtcqomLtksm/DKGNy0zSwXSzbO1yOEpwCWIxpqPnGZ/p+St2V+iViMPO7j8fxYSW
 8Fsca13gaA8DRCy0FIBb/lDFKDDImgfQcL9Z7cDhkxg/r6mjfSLJCbK4zUrgPdKyXwKcs4eHoZ/
 EppMpHr+7rYWkTImXWevFCNeCHv2bxjSOjLb0cBHtJyIChKceRE9X2xpk0yV3i/yGsTBjvlUqlt
 HLzMdHLj8D6r8ThJ9DPH0d/i/CcIhg67hHYoSKV+qv7vLTHdAiwmJKueHxo9ss8LVY4PVblKbHO
 2/Seie3SqW9dtsEbD3QAE+Vj6zw1yQvmGni3YemgenrPcg=
X-Received: by 2002:a05:6808:1b27:b0:464:5f3:2f60 with SMTP id
 5614622812f47-46de2aff32fmr3388035b6e.27.1775245645392; 
 Fri, 03 Apr 2026 12:47:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dbb5c96485sm2544954a34.22.2026.04.03.12.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 12:47:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260320205351.3789113-1-trini@konsulko.com>
References: <20260320205351.3789113-1-trini@konsulko.com>
Subject: Re: [PATCH] spi: Correct dependency on SPI_MEM for many drivers
Message-Id: <177524564489.2281750.18441462241250925774.b4-ty@konsulko.com>
Date: Fri, 03 Apr 2026 13:47:24 -0600
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

On Fri, 20 Mar 2026 14:53:51 -0600, Tom Rini wrote:

> A large number of drivers "depends on" SPI_MEM but this is library type
> functionality and so must be select'd instead in order to ensure that
> drivers will build. Correct this usage and hide the symbol normally.
> 
> 

Applied to u-boot/next, thanks!

[1/1] spi: Correct dependency on SPI_MEM for many drivers
      commit: 7b53fbb2740ac24064cbaf7d2b1c9bd2a25a7f8a
-- 
Tom


