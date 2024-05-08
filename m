Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5395C19F4F
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 14:55:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D255A887D4;
	Wed,  8 May 2024 16:55:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DIDPjvpy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8CFF884E5; Wed,  8 May 2024 16:52:24 +0200 (CEST)
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com
 [IPv6:2607:f8b0:4864:20::a32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FFD688798
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 16:52:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-4df3d4f0bf7so1184482e0c.0
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 07:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715179939; x=1715784739; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BFkvImjWERLIqoDpiY5NabxpICi8El7mOC8Adlakk6c=;
 b=DIDPjvpyehwx+Jh9g+EStFTksHRgpL6WuoJPnVi346oKKaUBk6Ng1HealNACXnCwSa
 FZw2okaFRWZX2pnTcvtPksdWLkS8l5+j53Im9SrarivUbkFOEmTDFIy7Hb54hnVA4ayP
 W3jD4A62J6VQBRSniJuEK65hlG9Rmd0zbyzqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715179939; x=1715784739;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BFkvImjWERLIqoDpiY5NabxpICi8El7mOC8Adlakk6c=;
 b=jLyoLWpDBPj5l5laxK1HuZaAX46D3FxCNjbpnjDqN2gY6Iii5VsiM+svSKb0z1fF5d
 7hamx78vQ159BOl8IGCHPs3WbfedjRfH50syYkHh51ZySd2Lz464sKLJC3Ype1Ym8gCU
 9cVbm4YJd6iMby/pfZ57UccQ4vUWleN+MgoKA0D9y1hsWMrAfUYM0/fPjNJ/sOxvBOvi
 wH2nqj/N5W4uHlyyhINDA0c55vWMeNbOTPTnIuUrjUzX9l7DDFNF1EEtwlnTMc4FIkXO
 JtL0vX80BVvD5PzQ3Ve3lFbMJqskv3ETb57+pHLOPqBZtoqNyCybYm3hLcWr7JtXkhOi
 L7HQ==
X-Gm-Message-State: AOJu0Yz7CiVSsUlikf45lIfMMI7xqRX1PGYu4nllJPpPWriEfIWZXWjQ
 dLyJFTDela07mG+Hmc3TnSJwKFPdjbkyYmndOOlXocxp8bRL7Sy+mAa21qomQQc=
X-Google-Smtp-Source: AGHT+IEsysydAejhF6Uo5+mxOTKrSWbptecAxfHnyn+tAOSuwOpvT1PdfhQgYXiltbagMr8rm3FX+w==
X-Received: by 2002:a05:6122:208d:b0:4da:9aa1:dd5e with SMTP id
 71dfb90a1353d-4df693608e1mr3155963e0c.10.1715179939401; 
 Wed, 08 May 2024 07:52:19 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 en15-20020a05622a540f00b004377f87147bsm7713764qtb.69.2024.05.08.07.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 07:52:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Greg Malysa <greg.malysa@timesys.com>
Cc: Matthew McClintock <Matthew.Mcclintock@analog.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Alexey Brodkin <alexey.brodkin@synopsys.com>, 
 Alison Wang <alison.wang@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Andy Fleming <afleming@gmail.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Bin Meng <bmeng@tinylab.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 =?utf-8?q?Cs=C3=B3k=C3=A1s_Bence?= <csokas.bence@prolan.hu>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Kuan Lim Lee <kuanlim.lee@starfivetech.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Mario Six <mario.six@gdsys.cc>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Priyanka Jain <priyanka.jain@nxp.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Rick Chen <rick@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Stefan Roese <sr@denx.de>, 
 Sumit Garg <sumit.garg@linaro.org>, Thomas Chou <thomas@wytron.com.tw>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Wolfgang Denk <wd@denx.de>, Yang Xiwen <forbidden405@outlook.com>, 
 Yu Chien Peter Lin <peterlin@andestech.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Michal Simek <michal.simek@amd.com>
In-Reply-To: <20240425000515.21896-1-greg.malysa@timesys.com>
References: <20240425000515.21896-1-greg.malysa@timesys.com>
Subject: Re: [PATCH v2 0/4] arm: Add Analog Devices SC5xx Machine Type
Message-Id: <171517993519.3110847.7832938517546565543.b4-ty@konsulko.com>
Date: Wed, 08 May 2024 08:52:15 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Mailman-Approved-At: Wed, 08 May 2024 16:55:31 +0200
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

On Wed, 24 Apr 2024 20:03:59 -0400, Greg Malysa wrote:

> This series adds support for the ADI SC5xx machine type and includes two
> core drivers that are required for being able to boot any board--a UART
> driver, the gptimer driver which is used as a clock reference (CNTVCNT
> is not supported on the armv7 sc5xx SoCs) and the clock tree driver. Our
> corresponding Linux support relies on u-boot configuring the clocks
> correctly before booting, so it is not possible to boot any board
> without the CGU/CDU configuration happening here. There are also no
> board files, device trees, or defconfigs included here, but some common
> definitions that will be used to build board files currently are. The
> sc5xx SoCs themselves include many armv7 families (sc57x, sc58x, and
> sc594) all using an ARM Cortex-A5, and one armv8 family (sc598) indended
> to be a drop-in replacement for the SC594 in terms of peripherals, with
> a Cortex-A55 instead.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


