Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA85DCAC590
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 23:48:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43BE388DF5;
	Wed, 18 Sep 2024 01:48:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SYSqQRiG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60CF888E98; Wed, 18 Sep 2024 01:48:16 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 576F888E44
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 01:48:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-45830ff5b70so53720041cf.1
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 16:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726616893; x=1727221693; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dyFlbZAJ/phO9nEq3B5K2oH0lcU3ArW608ZZGrBEuIE=;
 b=SYSqQRiG6INDzYA7lMAO9Dge2/bpgaWD1ipK28R13O9VspAHYIGIbSYXTgJf0oonvO
 Kg1RUC4QPtxnWLqzDAZxzy2Zq1ocGqAROVeA0x4bpp8MraAsQlMgOdRYUNiFKika9/EU
 MTxGVkP+FOQpObUh3VKwbV647NaT2OhR1VLNE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726616893; x=1727221693;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dyFlbZAJ/phO9nEq3B5K2oH0lcU3ArW608ZZGrBEuIE=;
 b=FEAkAC2gZ7RK477nUnFxyMlBVsdLaRmlkoS3PqAOgqt7793EeJTIk30228L02pNFt7
 q/qEGovTNIuMl5CMwMVRTMRx7ga9ndYHZot7D9tK1jNYJoAdZcnuUa00Y8BmwDeVRv1T
 fEZ0FI33XtQ3Q5oYWbMp/AHNGkwcFBhvcQer7UEnmwSb/8sIMHh2uJ/jDjpyATBy2+ml
 /mSwPhWjNLTFfasri3Sr/anOhgyo0/uSB/yOcDDYv1D4tcESvSP+nmnds/GrSK7mqQAJ
 DI69oREWN5cggPH0IwRn5j/SS3OP0ju3bBul5RpsV/MwReGUYEJ5B4a7Wn32QegxJLAT
 D2QA==
X-Gm-Message-State: AOJu0YyVzLmvmhQ2fRd7BAeCRzc05RCICbPKCxX8ake1vKsc1YpQXNLj
 otM48GFhtzb0pHEobhpO/U2b2aEkOBk169O0nlK+koHyo7RPh0Yjg4nL8HqNePw=
X-Google-Smtp-Source: AGHT+IGl6itq4SmdYptVmBJbeEnPvdEc69p3df8gxGGJ4jUqIcfcVpCcPbAwudcBizghLrF16ervpw==
X-Received: by 2002:a05:622a:292:b0:458:35f7:3950 with SMTP id
 d75a77b69052e-458602df804mr338600021cf.17.1726616893226; 
 Tue, 17 Sep 2024 16:48:13 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-459aad2336esm43264901cf.90.2024.09.17.16.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 16:48:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240906171235.91502-1-marek.vasut+renesas@mailbox.org>
References: <20240906171235.91502-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] cmd: osd: Depend on OSD
Message-Id: <172661689143.2128296.17882068739712982700.b4-ty@konsulko.com>
Date: Tue, 17 Sep 2024 17:48:11 -0600
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

On Fri, 06 Sep 2024 19:12:23 +0200, Marek Vasut wrote:

> The OSD command calls functions from video_osd-uclass.o ,
> which is built only when CONFIG_OSD is enabled. Add the
> missing dependency into Kconfig.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


