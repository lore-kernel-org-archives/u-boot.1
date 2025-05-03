Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A476CC369C2
	for <u-boot@archiver.kernel.org>; Sat,  3 May 2025 16:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5832682162;
	Sat,  3 May 2025 18:31:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R4Usvhom";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0456382724; Sat,  3 May 2025 18:31:34 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D212881FAB
 for <u-boot@lists.denx.de>; Sat,  3 May 2025 18:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-605f7d3215cso1493236eaf.0
 for <u-boot@lists.denx.de>; Sat, 03 May 2025 09:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746289890; x=1746894690; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IaZjErI0Iahz1jQ2rQ0M7axZikxpAbD6AWI8ecdTB2E=;
 b=R4UsvhomAUicnUNkImPFjv3Zq+a3YVUSsoGBwwPbf9aSmmEIVeFfsUT8dLQpnN+O15
 fLX/5T2xnKjBY0ZOUxEGcvzLzpIQq3Mr31rcb1f7v5bZASeiCSHvJo6sr07LhIS8E2ZX
 47hMZPl6Yy0YsLjrKnHBfBQh/OAEVIjiKMbTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746289890; x=1746894690;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IaZjErI0Iahz1jQ2rQ0M7axZikxpAbD6AWI8ecdTB2E=;
 b=r2aK+usfZiBXFITQfhViU33jy/qmeza8c73sYrORjZHAF1442e2Q7Dnw6909vFbQCP
 kYLauaim4jFbXDTbmJvIOrpUfj/SxCdbnL0UPGJ1F+9QhwL2qHGc8hx1zxb+WUixq8Iv
 884B3W748r5OGenVZRjvur2QiPISXWtPrcV973hze91hhmSfleaX1DidQ8+bP4/dUxyC
 aC2z37oqlusjH3Oxapq0HjZqR1JyhPuteCEbl9Wv0/EHzXa6zRs82Qww9Mqk1n7Nd7Vv
 1n0x7AD5Qdkg638Ab/4UMpONoZvScb2D0jQaZnjKz/8qjLgH2tYecD0MklOSV/dycUEE
 LM+g==
X-Gm-Message-State: AOJu0YwWZN46M6Bz+CJ6mrny60CDyDL+Prb9aF/I2XabTccoVjANjsTQ
 iTNZwno/AnPuesST5AMknHCZMBnacGozPbwmpbNr9pu0o/3LofnKcWruUQ7koN8=
X-Gm-Gg: ASbGnctC9zGui/SUdlFVyRGoiV1ne4qI2ZNY4wdhspdgUfN7Uif7B8r866EPPs8hTUp
 IRpifXyEDI9LBXdLyNMc9geg21WY5UqDlk8duip9mWButcIf7S/iu2psNi5E+ZEQeUJBPebp+Xp
 zlaOM36SoUHqcCX9laAxs+JJwd+sIxTKhL1cO0KTLXGoo/JKjujQrtBeja5dhgdXXb3zzAz+1wo
 9hROVAgmiwXE8HrAdnE/Mm782lmb8j4oxdKXeLP26BUhBuchqeDkkhGlAXkPJzsPEAe3zOTjjm7
 BKQEnuaNzGkpaZeVzQXV3l9OhEpesZe5oTu67YreEKaCaWfaF6aBhVs2I2VWCS39MKy7MtFIdH6
 d
X-Google-Smtp-Source: AGHT+IFGXD59xnecnYHMiQ2UpL7NVbpCaavNbBcfdkfvmdsP0ik9Fkm/j6mODlnIovgwb+KJCh1xOg==
X-Received: by 2002:a05:6820:2786:b0:606:42b7:2b02 with SMTP id
 006d021491bc7-607faa10a28mr1897051eaf.3.1746289890560; 
 Sat, 03 May 2025 09:31:30 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7db25f5sm970991eaf.17.2025.05.03.09.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 09:31:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Kory Maincent <kory.maincent@bootlin.com>
Cc: Robert Nelson <robertcnelson@gmail.com>, 
 Bajjuri Praneeth <praneeth@ti.com>, thomas.petazzoni@bootlin.com, 
 "Andrew F. Davis" <afd@ti.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Fabio Estevam <festevam@denx.de>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Prasad Kummari <prasad.kummari@amd.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Paul Kocialkowski <contact@paulk.fr>, 
 Parvathi Pudi <parvathi@couthit.com>, 
 Basharath Hussain Khaja <basharath@couthit.com>
In-Reply-To: <20250425155927.798941-1-kory.maincent@bootlin.com>
References: <20250425155927.798941-1-kory.maincent@bootlin.com>
Subject: Re: [PATCH] board: ti: am33xx: Add support for BeagleBoard Green Eco
Message-Id: <174628988832.1571566.6337404545054393894.b4-ty@konsulko.com>
Date: Sat, 03 May 2025 10:31:28 -0600
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

On Fri, 25 Apr 2025 17:59:25 +0200, Kory Maincent wrote:

> SeeedStudio BeagleBone Green Eco (BBGE) is a clone of the BeagleBone Green
> (BBG). It has minor differences from the BBG, such as a different PMIC,
> a different Ethernet PHY, and a larger eMMC.
> 
> The PMIC is not yet supported in mainline, but the work is ongoing.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] board: ti: am33xx: Add support for BeagleBoard Green Eco
      commit: 510f2502475b9e695ae7e62272c8f90c2fdf0eda
-- 
Tom


