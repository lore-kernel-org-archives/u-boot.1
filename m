Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7B6C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 22:27:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB16687126;
	Mon, 27 Nov 2023 23:27:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZTF5ZEy7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E65C78749C; Mon, 27 Nov 2023 23:27:44 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D406586DB1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 23:27:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5cca00db7f0so47928097b3.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701124061; x=1701728861; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6lf4YIPweYFOkkEla44xxvDXoj+U6iWl1aRPEseAS/A=;
 b=ZTF5ZEy7YfXw88uhb+5uOSX/wT4ikjFuUEVAm6TxdezIK9BEzJz7iWBoVL2DklIx3Y
 TAReZ2icEeT4eY6mb8krT/gYUnSQRrs5tUPJqyAL7A6AXIaOO4bGAwd0nEgd38nxzijL
 7Z6LHlN/CVSVGN88j36rZ4WTVAz8cFQl9X1VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701124061; x=1701728861;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6lf4YIPweYFOkkEla44xxvDXoj+U6iWl1aRPEseAS/A=;
 b=wpnZJlbtEUBNlonO3A60U3As5EDUZlYGcz0szyFygm1ZWMNkbWmffR7x2MRqdCjddZ
 l+WDnDVVb7ZPuvt69UzVpR+mlbB2kLi9oflIJQf9CkaFsX8MdhwSTdJHHZSrYy8HRD1Y
 F+ozx1R05qP1uMgoX0KeeYkHQ7x+VTIS2YlOA1q1DExnOCTv2bJa3BSzDLyks8LomcX9
 /97MByu9ofQ2os4ojf+9M1zULOSV5d5Mhf2AE8x51/lLDc2uyMjWRRjwCC/Opbwjw7Lq
 3vO/vOpZmOky9SXzqAHnyDy8047F+eDs9i8jffCybU/LCo3Y63y1vCBITipUMHipxJCE
 D/tA==
X-Gm-Message-State: AOJu0YwXmvs1Anje6vWjXNRQDNXujzIxW+8GPmFM+9Xihs6T0GQaWJSt
 Xhq7zL+OCG5vVEd0LOukOzhB0qj2aEkxuvMCMbZ77Q==
X-Google-Smtp-Source: AGHT+IHmxSdX71s9lwu9k0UOLB1X8+l1XMli0ERt7Dj4xxJPnHo2mVIyST2SDrn6oPYWxRif5bBVQA==
X-Received: by 2002:a81:9195:0:b0:5ca:275:a94d with SMTP id
 i143-20020a819195000000b005ca0275a94dmr8242713ywg.12.1701124061566; 
 Mon, 27 Nov 2023 14:27:41 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-6400-4f9d-49d7-ae37-6b11.res6.spectrum.com.
 [2603:6081:7b00:6400:4f9d:49d7:ae37:6b11])
 by smtp.gmail.com with ESMTPSA id
 v129-20020a818587000000b005777a2c356asm3516245ywf.65.2023.11.27.14.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 14:27:40 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Bin Meng <bmeng@tinylab.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
In-Reply-To: <20231011131552.14665-1-bmeng@tinylab.org>
References: <20231011131552.14665-1-bmeng@tinylab.org>
Subject: Re: [PATCH v2 0/9] ufs: Add a PCI UFS controller support
Message-Id: <170112406049.91617.8958765702666807923.b4-ty@konsulko.com>
Date: Mon, 27 Nov 2023 17:27:40 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Wed, 11 Oct 2023 21:15:43 +0800, Bin Meng wrote:

> This adds a PCI UFS controller support and enables the support on
> QEMU RISC-V for testing.
> 
> Requiring QEMU v8.2+.
> 
> This series is avaiable at u-boot-x86/ufs for testing.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


