Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F378CE7B0C
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 16:34:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5C2388CE8;
	Fri,  6 Sep 2024 18:34:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="msqnNrA6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09C1A88D1A; Fri,  6 Sep 2024 18:34:18 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 044A188CE5
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 18:34:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6c34c02ff1cso13141936d6.2
 for <u-boot@lists.denx.de>; Fri, 06 Sep 2024 09:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725640455; x=1726245255; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nk7A7QSqYrw0A493FL3X+3msWh+89qgK8+Hh7+Zl9KU=;
 b=msqnNrA6YOHqSw9wRJ00oaIyFpJi31tf9V8JpL/WO5jfrY9SbQu2wE+UQA0WBeMQjN
 jmCcegQWpkfroUEspIBbU64Hc8ZqTUsDWXgzaxLBRH9THG3qsDq6ZeZWVMULpJvIrm9y
 29mpZYJj8JejKI7M/PyfLdQVQ8lmUdLQnofVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725640455; x=1726245255;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nk7A7QSqYrw0A493FL3X+3msWh+89qgK8+Hh7+Zl9KU=;
 b=cqI7Vjm63rngMJx1OJQZMNnSPEglFZbj+QuIRM7AJoEehCf4+adw9xj/L57uDckk70
 YA/HatJGxk2Q+aueM4+H8//3Xs5AJAbZPKRVNHxxgZSm2J9rumWereIe/pigEK5QZJlp
 aHO3/f1/fOYTaJlOIOIe0i5mUEEZPQhjiIYaZ98Fk3Q0nTMb3L2NOUkEeYGLJqA5Ni/e
 5xDaC2ohtAZfIRLqUuystLCDkm8mJja83F9KKIa59F4s32/5UwmIEedrx7cCq7XBDzcG
 AuPhmKYMwchwHdpTS3i7Yr7hfKaV8Qsh0rdPfODM6jmTVH5t+Xgv/JZwZIhotLWnaguO
 CbPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6udI0VdOcqgrJm1eJ2m+6QKQpvBVsuLVaa3At/VrYH5H1GseH4wx5bmBj/6G5vYF5SqY73Wc=@lists.denx.de
X-Gm-Message-State: AOJu0YxLtS4yfjipEd4Wr5oTQYoHxkfDEeZR7qzBdI+1mFP8IYaBnXsz
 GwrcR5yexi/1u0BiTBYBjtgr0y4Tu3eJpnkm6eNTw3FSvoXh7GMsFzyT6WRZYJE=
X-Google-Smtp-Source: AGHT+IEWOkSIAUBikLkccGAAtjkf3HFzGMcY+eaB+YgW9K7om9d784W8ZFPWdbhq75LJ2kZ7EXauow==
X-Received: by 2002:ad4:44a1:0:b0:6c5:caa:dd83 with SMTP id
 6a1803df08f44-6c52850bb7fmr33300996d6.41.1725640454685; 
 Fri, 06 Sep 2024 09:34:14 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5204181b7sm17851046d6.112.2024.09.06.09.34.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 09:34:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, 
 John Keeping <jkeeping@inmusicbrands.com>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Philippe Schenker <philippe.schenker@toradex.com>, u-boot@lists.denx.de
In-Reply-To: <20240709092454.949260-1-jkeeping@inmusicbrands.com>
References: <20240709092454.949260-1-jkeeping@inmusicbrands.com>
Subject: Re: [PATCH] regulator: fixed: fix regulator-fixed-clock
Message-Id: <172564045340.3888706.1735240359607313425.b4-ty@konsulko.com>
Date: Fri, 06 Sep 2024 10:34:13 -0600
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

On Tue, 09 Jul 2024 10:24:54 +0100, John Keeping wrote:

> For regulator-fixed-clock, the device's private data is never set so in
> fixed_clock_regulator_set_enable() is null and the function cannot
> complete successfully.
> 
> Rename the _plat structure to _priv to better represent its role and set
> this as the private data.  As shown by the set_enable() function and by
> using the same .of_to_plat hook as regulator-fixed, the platform data is
> regulator_common_plat so also set .plat_auto correctly.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


