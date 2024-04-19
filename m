Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C63C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 01:59:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2C06886B9;
	Fri, 19 Apr 2024 03:58:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tn2PyWat";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A579886A5; Fri, 19 Apr 2024 03:58:07 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3335B886AE
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 03:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-69b44071a07so12407066d6.3
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 18:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713491883; x=1714096683; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nWW7p3Yqk/yibcrIMoDtH0xQP4l/AQTA2RxXgouQiz4=;
 b=tn2PyWattOX5waK4FGkasO1U9I2w4I6eIRi+aXIziaILz4cHCaB2obL8ibNZy48I5l
 xj1XlzmTowrdOWYLgQ4bHUt5tv3qWd/aWlRUbOx7q7WQ+9BSBwask209ctVACE1sMBE2
 z6sIaqRj7ym4EN+46y4T4VIPE9IMBtdmXkaLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713491883; x=1714096683;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nWW7p3Yqk/yibcrIMoDtH0xQP4l/AQTA2RxXgouQiz4=;
 b=lBLUS1jUNtyeWeDfoZCxxq8p/EKnxuHEQPoUMkYlJFIAkjzQrCahyB0vIvjdxkIJWA
 6fOOrW88zTCC5tpDJYpwrOmUNuLAhck0uuYrmsucHdyLnqLOUiYXs48wWpawPioQ+lx8
 Z+ZttAkReXXYpR2BsPeXBVOzn+HghBRH6zOgEz5YgxOdYu1XI2eh3cDWzE9QAH8z3vqy
 bWMG29MLRlHpvyLC/ba8HVjTNaBVdLSX1xnMDdDrWzjJBFapKu/wl50V7jN5T/u/+zoS
 g+rDtcRwyd58qXjq9F6VHZP3+8+0BTACXqvcHHzM1DHsAiPe7PiKxxrhWjB6yxShyPdH
 PWtQ==
X-Gm-Message-State: AOJu0Yy5ehSb5MtgT+g9h62JMthdFMrgwYykO9hjpfONzcyaA/2r+5LB
 X+nzwHbkC+WeiJPPfYobM7bg1o3QSgwmccbZdq1Q4JLnpvhqkdBy+aBoQCb3pp/pK4BNEreIZmc
 Jug6saw==
X-Google-Smtp-Source: AGHT+IF1TNTp8ZKkhWeTxNQxb7K11N21FWexAf0HRxWKfvi2wk/OMgVklfcODn+lmFPlrCw76mtWYw==
X-Received: by 2002:a0c:e808:0:b0:69b:683b:8686 with SMTP id
 y8-20020a0ce808000000b0069b683b8686mr851885qvn.3.1713491883724; 
 Thu, 18 Apr 2024 18:58:03 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 b4-20020a0cf044000000b0069b1e2f3074sm1167777qvl.98.2024.04.18.18.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 18:58:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240415-mmc-loadenv-dev-v1-1-4dd649e0c298@theobroma-systems.com>
References: <20240415-mmc-loadenv-dev-v1-1-4dd649e0c298@theobroma-systems.com>
Subject: Re: [PATCH] env: mmc: print MMC device being read
Message-Id: <171349188279.1524174.15025499771064795854.b4-ty@konsulko.com>
Date: Thu, 18 Apr 2024 19:58:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Mon, 15 Apr 2024 14:43:57 +0200, Quentin Schulz wrote:

> This prints the MMC device being read similar to how we print the MMC
> device we write to when e.g. calling saveenv.
> 
> One of the side effects is that the boot log now shows from which MMC
> device the env was loaded:
> 
> Loading Environment from MMC... Reading from MMC(1)... OK
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


