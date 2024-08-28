Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AD9C636F0
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 18:27:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31E0A88913;
	Wed, 28 Aug 2024 20:27:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F1Lrvr+O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 816B488AB1; Wed, 28 Aug 2024 20:27:00 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F8DE886A7
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 20:26:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6c331543ef0so9984046d6.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 11:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724869617; x=1725474417; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ph/DDssSBczQEj4cmOzCgJJaFIuC2PEiU0Oro5MrRMM=;
 b=F1Lrvr+O+94+8vhFSHjWZ9Wcdyr2rOWtWs7eMliq2wXiVRS9cgc3sGnubVx7N9PI9M
 ifnOBV5hESvBL4VxjYZHVe278KnK+FVqBXN4QGeUf/xRGEFJd3TwKZTJUWB9lLFdKw7m
 xy65g+5CRiQtC7PnRuQCPDwwH5S4fAi25lEUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724869617; x=1725474417;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ph/DDssSBczQEj4cmOzCgJJaFIuC2PEiU0Oro5MrRMM=;
 b=ef2xsZqlScmVqMAqxMeGrcku+2qfwB/nK5dEGIm+WdPCLl92BCBY7RVIf8zEb+/ayJ
 qq+cq+Do404uHIT3Zt5DQGESWHhKpehnS27GwiBOjvc4sXECIGPBrV1jT/oUezdc4Utn
 M1qPtLRkZzo9CgdXBAxkQ+rBFlnLKLM/mFXJtJ5f1muDXY+uO+fNkKhggEMXQP1Uc/KE
 LlgGWSK3kPjr6RAbjETIhcqw1EQYU2fDRjDIv9wBdViIGT2Co/8vUkrV1UVrOV8awJkZ
 1Ig1+0Tb0IEK4ldgMGAXLTPmOiyRx3NutcBqVmYGbl2a2sYsBA/DHoMOoDyVgnxiaiza
 /Kyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAeIV0weVRmX/EJaT84OC7RvY57WCaXOgPoRk+GyQJ0QrzIT++R1IYyAioqiPjK8r9ZvMf+Hk=@lists.denx.de
X-Gm-Message-State: AOJu0YwEC6UIHdlXI68g6Gnnn7hRDrtTuJjAlu97b138BOw+WhQf923T
 XS62JjVer7Q92xx2NX5Y7350KZ4A+A+5RJSGXXcxoWuFb8f0XH4IMXs1AbDWhtM=
X-Google-Smtp-Source: AGHT+IE/haesti1obodlj8b3Ta5CpKs41ZjuLdx+WWaO1/q61oFbWwAmOSH63A1Ap9vuoUN3xttXFg==
X-Received: by 2002:a05:6214:3209:b0:6bf:8ccd:a38 with SMTP id
 6a1803df08f44-6c33e6b1bc6mr3343706d6.57.1724869617337; 
 Wed, 28 Aug 2024 11:26:57 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162dcddadsm67835536d6.121.2024.08.28.11.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 11:26:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: ryan_chen@aspeedtech.com, chiawei_wang@aspeedtech.com, 
 BMC-SW@aspeedtech.com, joel@jms.id.au, marek.vasut+renesas@mailbox.org, 
 paul.barker.ct@bp.renesas.com, michal.simek@amd.com, clamor95@gmail.com, 
 kabel@kernel.org, piotr.wojtaszczyk@timesys.com, andre.przywara@arm.com, 
 caleb.connolly@linaro.org, biju.das.jz@bp.renesas.com, sr@denx.de, 
 u-boot@lists.denx.de, Billy Tsai <billy_tsai@aspeedtech.com>
In-Reply-To: <20240820072736.1550010-1-billy_tsai@aspeedtech.com>
References: <20240820072736.1550010-1-billy_tsai@aspeedtech.com>
Subject: Re: [PATCH] gpio: Add G7 Aspeed gpio controller driver
Message-Id: <172486961487.3064792.8524603116933593399.b4-ty@konsulko.com>
Date: Wed, 28 Aug 2024 12:26:54 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Tue, 20 Aug 2024 15:27:36 +0800, Billy Tsai wrote:

> In the 7th generation of the SoC from Aspeed, the control logic of the
> GPIO controller has been updated to support per-pin control. Each pin now
> has its own 32-bit register, allowing for individual control of the pin’s
> value, direction, interrupt type, and other settings.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


