Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21380CAC5AC
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 23:48:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD8DD88E65;
	Wed, 18 Sep 2024 01:48:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KKR0qb/N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7298688E48; Wed, 18 Sep 2024 01:48:14 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CF5A88E15
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 01:48:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-4581e0ed0f2so2020741cf.1
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 16:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726616891; x=1727221691; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=arIRb7iDOaNOftQO72ngLyMtLAGXsb3zsrN/LW3pb8A=;
 b=KKR0qb/Nale3Egm3ZcAKs2OXMgcuMlyHsXIwdOnOhU/fXlRh402SqIWNDTWUEEe9oS
 0bVzMGx/vvmQstL/GNMR33XfYddkuxf9kgLe8PtsAYNcN32fonWLHT7wHu/PPccyQNMi
 /6zaBUWpT+CTvES3iZ8nVlb+oIcDSDyZhyKGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726616891; x=1727221691;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=arIRb7iDOaNOftQO72ngLyMtLAGXsb3zsrN/LW3pb8A=;
 b=IIonHa4hOKqw3LP4xdWQGDWQFXspNiIhSmcSJgP7vCYi0FU8bjpr9cV81niHDAaFJk
 zVjCagyx+7IxQzzP1P2QC2ajjytFXhi4b7mPBdSy8hBE1SXZYWdi5ScBMEMxmgyT7vkC
 3uozQ/Y7hsa1+LSdSFshMgGoLuB2uPkshaSYX2BYkjeaPZqc7YdOPZTeiQ/hgEox6PMU
 2VBtqCZD1GNb9+yTCH7rjCl9Qcbrh0fIViONigb2xg4HrFknbTux1xZ3d1D4HdglVOdP
 89KYZ2i4MBkH+LaOV2b4AqOMzSIMFprCghkzySVBPqsx3cj+BBw8JxdD7TkyTmqrxhMt
 te8g==
X-Gm-Message-State: AOJu0YzVPZ9KV8I2RulVw1MyJ4sa7vm2mLKzuj+pwfY/DklyUphtNN0l
 2SI96er3QtUHMg9EjqrYddezZnzFPA5eQmeAlLtc03lICmILik8Nw1DQ8Tb0Mpg=
X-Google-Smtp-Source: AGHT+IF7T4ueFaEJ2M4yHL09U0KbJu3eaUBc1iIA3tUa/yxgrnUSPXPL51pFodqufn9xuaoYjs4RKg==
X-Received: by 2002:ac8:7f06:0:b0:446:54f5:3181 with SMTP id
 d75a77b69052e-4583c7adb3amr477262141cf.24.1726616891307; 
 Tue, 17 Sep 2024 16:48:11 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-459aad2336esm43264901cf.90.2024.09.17.16.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 16:48:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20240902133721.18938-1-marek.vasut+renesas@mailbox.org>
References: <20240902133721.18938-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2] mmc: Hide mmc speed command under mmc command
Message-Id: <172661688937.2128296.7350859602396185770.b4-ty@konsulko.com>
Date: Tue, 17 Sep 2024 17:48:09 -0600
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

On Mon, 02 Sep 2024 15:37:09 +0200, Marek Vasut wrote:

> The mmc speed command configuration option keeps showing up in
> Kconfig directly in 'Command line interface'. Move MMC_SPEED_MODE_SET
> under CMD_MMC to make it show up alongside the MMC command.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


