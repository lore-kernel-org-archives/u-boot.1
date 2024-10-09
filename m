Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFD7CED611
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 22:58:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D35488E15;
	Thu, 10 Oct 2024 00:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UOcPzSC5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EE6B88E14; Thu, 10 Oct 2024 00:58:20 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5758A88DD4
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 00:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6cb97afcec9so2749176d6.2
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 15:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728514697; x=1729119497; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QH9GA8wHaP72s8KRp2MvsE+N6dxNbMmhtiNUaNDtFWg=;
 b=UOcPzSC5beDbWW8HeHTTXwFPb1D/IOge04n5fxGJMfju5pDissVLcRWqQX2l6zlJss
 2DWwX2tDDOZMC6hYaz7+LQB8LlWQ6GwQezS05FvGLSZaX4N2nLiQBw9IHcs6V/+6Pvzw
 nbyfufbRhUI0EmRX5Dl6gwpsH20yID9rZY+G0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728514697; x=1729119497;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QH9GA8wHaP72s8KRp2MvsE+N6dxNbMmhtiNUaNDtFWg=;
 b=Dkqnf5vRZC5SN9rImIx/WaoKW+qlr0h2vs5Mf4pq4mBB+cXnwuExwTIGwLtTp1HA5A
 kEw4BJFlG2o04pot7Gvup1Of32NWIxnodK58jvVr6njPEW9vTHc/IxPixOO5AIzRepYk
 q8yc9dOSBWeUHknpWyjlNHwonLOi7oeKUfJTaXXOGdLdb0DEQK+C5tT8TCi0/xlLtKYe
 SUPMdk8hfnruX2pSfAmm+aDJv/LmOZdXtBrhb556A2A3No575RrTutSE0eh8zvnkN3Cd
 Dx8gqmsBqqDQtFv62UlO3AUfdQOVk6ldk46a51LnlvidJEkgLuUAhmM/RtkvMn//CXDZ
 ZmQw==
X-Gm-Message-State: AOJu0Yw2IAxv+jiODLQU6/xS7tIaK2jUIrPz5y7QHrjm2CjlNSgY6eXG
 jtwRXc5fdwSztXxfoD23s4XG/SxZNVLqlx8DgHAzu/9q+sU8H1D87Ifjd/CwypU=
X-Google-Smtp-Source: AGHT+IFQro09jn6HOFrh4ViCumObm52ebizYYkdeKcd0+Ui++A1vq1n3aFjiBmjI2qqb+G9NiaXs9g==
X-Received: by 2002:a05:6214:3bc4:b0:6cb:3da9:f3b3 with SMTP id
 6a1803df08f44-6cbc95ae6abmr71038506d6.38.1728514697263; 
 Wed, 09 Oct 2024 15:58:17 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbc459e16fsm18035126d6.83.2024.10.09.15.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 15:58:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Alex Nemirovsky <alex.nemirovsky@cortina-access.com>, 
 John Watts <contact@jookia.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240427-spikconfig-v1-0-8a54772522f4@jookia.org>
References: <20240427-spikconfig-v1-0-8a54772522f4@jookia.org>
Subject: Re: [PATCH 0/4] spi: Various Kconfig fixes
Message-Id: <172851469550.3580955.13258224579239542355.b4-ty@konsulko.com>
Date: Wed, 09 Oct 2024 16:58:15 -0600
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

On Sat, 27 Apr 2024 15:40:39 +1000, John Watts wrote:

> I'm doing some SPI work so I tried to compile all the drivers on my
> sunxi board to try and avoid some regressions. This failed, so here are
> some fixes for this.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


