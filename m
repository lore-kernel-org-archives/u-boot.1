Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF94C47074
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 13:54:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FD1386F64;
	Wed,  3 Jan 2024 14:54:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nKu9QbF3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73EA486FD8; Wed,  3 Jan 2024 14:54:53 +0100 (CET)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48A3586EEC
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 14:54:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-466eb1aeb6eso1090183137.2
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 05:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704290090; x=1704894890; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WxK4BOUgZxEZhWhWjwSeR3RfDEWFxTANmoIKTuV+KUs=;
 b=nKu9QbF3ynD2CUm/AnePM55qRSfwEbAjCfaAMykx9f86gTu+1l8b9Tik6SLM/Qweio
 MFczncCDBoKb7Xlt2XWAhO7VKNNg5T4kihhieylbMfYj8rqcB9YaD81Uc1LfA/zPXWJy
 LhrCEHOTT1uvyo7tCcgRcu6DDPqW2pdLmttYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704290090; x=1704894890;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WxK4BOUgZxEZhWhWjwSeR3RfDEWFxTANmoIKTuV+KUs=;
 b=G/nRx+09Svhu5WNL+N6pHI2ndDUcwOLzHmRy4l9FuxF9BCdsCtRSjePElxYSWpKutK
 F8cH1xco7/CUXehEzNhLfBc6gwpt5e1Cuoyl/IZaUUgOsj7tAR0C9eifh2gBpxhFtZAc
 5Tm4u97vC6bna9aiKI8m0CG458IwWDXZS8z7IEHKmuTMlatCOpDMqtj57YwjwRSfvb10
 juQlRESxgx6KtRP4+38t7ru1XGSHRdNP2AZgSHplJINeUF9YpRLldye5KYS6oQQoe4x/
 ccwMuU3dWY/UXF1ygkskOBMEAyXfup9k/bm4IktDyS3Wy3GHQtUFn0JrTOytlaza5sMt
 7y7Q==
X-Gm-Message-State: AOJu0YxqbTfL+2UL9wEAODOzJizvmFjcMpD4B16f2wqHQNefQAjeeBub
 JqgILABP1yoLzUOfh8JD99WfOTJgKfskvA==
X-Google-Smtp-Source: AGHT+IHqVitkNaZ/+sN+A1NsfSDFj1WgfRkTHxJWLqS4wblfoZU7TKRd9XLo1sIcA2rgGnShUnv/gA==
X-Received: by 2002:a05:6102:3f89:b0:466:60a0:ca74 with SMTP id
 o9-20020a0561023f8900b0046660a0ca74mr9593512vsv.10.1704290089993; 
 Wed, 03 Jan 2024 05:54:49 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 v5-20020a05622a188500b004282be7470csm1980532qtc.29.2024.01.03.05.54.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 05:54:49 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: UBoot Mailing List <u-boot@lists.denx.de>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>, 
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Simon Glass <sjg@chromium.org>, Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231229174656.634065-28-bb@ti.com>
References: <20231229174656.634065-28-bb@ti.com>
Subject: Re: [PATCH v2 00/26] sync am65x device tree with Linux v6.7-rc1
Message-Id: <170429008876.3028391.16031976633999318948.b4-ty@konsulko.com>
Date: Wed, 03 Jan 2024 08:54:48 -0500
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

On Fri, 29 Dec 2023 11:46:57 -0600, Bryan Brattlof wrote:

> This series gets the am65x booting again along with syncing the device
> tree files with v6.7-rc1 Linux.
> 
> The bulk of these patches unify the WKUP SPL board file with the arm64
> files to make future syncs from Linux much easier. In the end the DTBs
> should look a lot like what the DTBs look like for the am64x which
> is fairly similar to the am65x.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


