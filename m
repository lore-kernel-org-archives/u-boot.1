Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE5ECAC592
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 18:27:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C6F38323A;
	Tue, 16 Sep 2025 20:27:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WpDKyrvA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDE54803CC; Tue, 16 Sep 2025 20:27:05 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7FC883071
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 20:27:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7459fa1ef2aso5738781a34.1
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 11:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758047221; x=1758652021; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ArUtvoQgKEAISDesPfv4CGgFOqCk+F5W/HvDfzKHez8=;
 b=WpDKyrvAa3h/JCzmPGFYSI6OADvh3KUWf3xnbtZk0Ksoo+FGTP/uKJ6zdLwaqzwTOS
 eHfOMfAu1Lmqc29jQCU3yqV53c58tSqOKs9c5M+iR3JClVSn/2QzzSJoXGjuf9qHqD2C
 v9UZPdFmtAfZE9mckMHiUhgdtUIoy0L1Zlssk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758047221; x=1758652021;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ArUtvoQgKEAISDesPfv4CGgFOqCk+F5W/HvDfzKHez8=;
 b=oGz+N0n81WeNQLqFEwo0Nqt+p7p0R9yxDrhZDHEFc7hPSVGLvlBwRvvFDFgzgDb4yy
 1LB3+TPSF9ieLt+d/gwqPC502Gc5quN4tXqC9uckP3niyMnh5dpVQtISNe6cE8j1Fvsy
 myYSodvRxWnkyFoFKB++d05zTiDdPlNwWXNbRv1iUJsqvGeZHv1DJXmcvG3fnomahjxE
 pgImTPZvtPKPYTl4I6pXPdpnqNRrx1tp4uIh9yvKspzGzEFHubhpDjtPIZ2FDotluyOU
 ovGErOx0oivIvU9Lbx+XiSG2kH5+KYuuBo7V9dRLXBQz92Q0B7y07jTx/Q/JLE3UvVGa
 gIww==
X-Gm-Message-State: AOJu0YzmJsJaJeoTKAOWHeIc9eH7oN0ZOeWkHRGZVMOShFW0ztq86Ry2
 Lw06E5MUc4Zs09PTlmkFtHLKi/WKCswcMDCuvgXvzsCEmY4JJhj+uJz9qHf7QXNVOmmpBD1/IPV
 c400U274=
X-Gm-Gg: ASbGncsBkwMcSA5qDdr3tz3xs6G9AIvRLPFiNdKTxCIVi+efQ1ryNmtzcU7xIDpktO0
 8bMEa6haswFcw+X5izbd3AL6wOWU+52bWYusEHvRPwDonki1mj1qrVq1Z2Tevea/SpEFbSlgljk
 yeoR1ZBzrZh2uYyWjkUXXf39puYvKOJ51r2vSsM5JQ5XBOaFC3iybAYQZuBC+0tJJArCirJxSpY
 DdGra6mLVGpj/qr+cwR2VLPH0BbVm8GhpQVl7LpmjzCp/jWXciYgUsbUkQe5S2gEwKHy1f8ugn8
 TndgKtTjCBOmK8GNlJFL8B9DC/FPgB2HOU+8smh85NQ92R3QKnYxY79pf2Ngb8XG7UoBvI3r8Tx
 Kr7An+CkRlx1I0PJWP5olLRO/+Fze0P+etMnPIL8+i9aEctws44Y6ARbu95MhP4fhfg==
X-Google-Smtp-Source: AGHT+IE1jAqgS7CtkNBH/6UTv0zr6oij6L7GbulgJbk1xIvojUh2g2IoZkhWdq3raTrK1yFp8CzsOQ==
X-Received: by 2002:a05:6808:f07:b0:438:237f:dab7 with SMTP id
 5614622812f47-43b8d86ef56mr8457531b6e.6.1758047221671; 
 Tue, 16 Sep 2025 11:27:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-43b82abd2d5sm3392308b6e.26.2025.09.16.11.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:27:00 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: vigneshr@ti.com
In-Reply-To: <20250903111704.530700-1-anshuld@ti.com>
References: <20250903111704.530700-1-anshuld@ti.com>
Subject: Re: [PATCH v1] mach-k3: fix reading size and addr from fdt on R5
Message-Id: <175804722041.614326.10024295791263118169.b4-ty@konsulko.com>
Date: Tue, 16 Sep 2025 12:27:00 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Wed, 03 Sep 2025 16:47:02 +0530, Anshul Dalal wrote:

> fdtdec_get_addr_size uses architecture dependent datatypes which causes
> the 32-bit R5 to fail when reading the 64-bit size and addr fields of
> reg nodes from the fdt.
> 
> Therefore change it to a common api for both 64 and 32 bit platforms to
> allow for fdt fixups from R5.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] mach-k3: fix reading size and addr from fdt on R5
      commit: 7aa5271def6ba16ff4426aa164b7bb743673b3c3
-- 
Tom


