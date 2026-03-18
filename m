Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D512B1077609
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 18:59:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A55F8063E;
	Wed, 18 Mar 2026 19:59:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q4YCur0P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E1C8839DF; Wed, 18 Mar 2026 19:59:46 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5009807C0
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 19:59:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d74aa6bcdbso123349a34.2
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 11:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773860382; x=1774465182; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gZarir8cXAt5WniLaeg1D/CBk8BUkrYO2Pf8HTsF6Jo=;
 b=Q4YCur0PemsrSoo/egzi62lQC56FHacYdPe91xYKU/Y06JqiQD710AfA4rcR/n7du0
 FQR/k8nr9Vd4Kc6x3zGcZUKjSqBKmYOHG3qXGb3K4Z0RvHn5WWPtAbPL91sQxjm6Jmp2
 oPxZId5P/UXCDBfvoCWtIwAt5hY08vqnvd4qI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773860382; x=1774465182;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gZarir8cXAt5WniLaeg1D/CBk8BUkrYO2Pf8HTsF6Jo=;
 b=koHZ4f4zvLXlnpDmcARDIIEJaGnVOK9tb5RyVfsuTa6ds9pm+Sdk63aEp1wjRBnsU/
 ncTYtjU3fFd/WodxZxtEY4mv+RDgTcJNOVTamrJaTHAp7ANrtrzuTYsIFmJL7fHXvlUD
 s8KrzRrFkp5e8GQ5v30KEzkB4o/zS7DH1VUmNcBSRWX7J9yS9v5FQ3cvVcCQkllz4XKq
 c8XioPm+TMYjPzPgsrOnet4H9Lh+cI8W8l909FkVsqc5GEngWRAT/bhpi74ozYivXTfb
 fhOA/TBTDUEz8EQCuzg/fM8rHgBOMxSxjDW7R4Q4T2CsXi9uPLmI3JpDvRDPPxvpIGlW
 6A1A==
X-Gm-Message-State: AOJu0Yyr8isq6C4jKAoT5XhmHK7ozqHFkD8boJf2nbuBGyVSm61wRRcF
 78a5H8BITqBDlXEFaoIevCdSESsd6vzGo4eX4gHDtveWLDd/WrqASgIsZycaui+LayU=
X-Gm-Gg: ATEYQzy7/jrGcHepWpqhILZ6aA7JMcejm6aUkczye+9T5MHG0WG0h+CMIRMfFrfHH7/
 nrMXS6e/PyxTuBFS2uABur3/z4skIvrno5mNPRYy8gCE0zmglz4IlJz4X8P0N2FuXv7Xi19X6nB
 AmjsQREzwgEPNpGZgRwaiNC/YfgKFLT82+nWxNJ3MxYWK6REbHtcE3vu7zSz0iSs4MZ3otDeIo6
 lmuOtB0M8K06CbNd2UtWyfxcpEK4KPi5njt5nxZ0BI/K9+w4EmbucfgAz66lFtEhfHTuuik/cCs
 +Jm6QHsCik4xshJMY4xrJzUqQ1A/W15e+xXGWuDxj2PGoIfpDWPJdv3qgWArezD3/Sc0fE8wFRq
 0gQwW8WqXl2Ur/s2MLiNrHHBXnouPsCcP0G0ZRJ4SLp64ahRZJlwvWLmvw7FQ6W5YzfNYPMmlv5
 GulLe1SnTyySHvGDN8aiJvliUUpKBeZMQUjMjXaMwhnJMyP44nDzXNVo3Kds81d+JwoSwzh0iU8
 zE9Z4q4hWm5WijWgjQ69HQsHqHWdaKMv+y9qPQoUug+Lx/+lSLaVpTPsQ==
X-Received: by 2002:a05:6830:6add:b0:7d7:d0bf:7045 with SMTP id
 46e09a7af769-7d7d0bf716bmr1624716a34.8.1773860382621; 
 Wed, 18 Mar 2026 11:59:42 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7c9985c1dsm2807715a34.11.2026.03.18.11.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 11:59:42 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Quentin Schulz <foss+uboot@0leil.net>
Cc: Greg Malysa <malysagreg@gmail.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Simon Glass <sjg@chromium.org>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260303-pwm-led-orphan-v1-0-54d14a430cb7@cherry.de>
References: <20260303-pwm-led-orphan-v1-0-54d14a430cb7@cherry.de>
Subject: Re: [PATCH 0/2] update MAINTAINERS for PWM LED
Message-Id: <177386038114.1227559.6501657983528937805.b4-ty@konsulko.com>
Date: Wed, 18 Mar 2026 12:59:41 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 03 Mar 2026 12:16:19 +0100, Quentin Schulz wrote:

> The entry is named LED while it only matches PWM LED binding and driver,
> so rename it to PWM LED.
> 
> Ivan's email is bouncing, so mark the PWM LED entry as orphaned.
> 
> 

Applied to u-boot/master, thanks!

[1/2] MAINTAINERS: rename LED into PWM LED
      commit: a5533e7417b7c7ab50bd7be8ff3f8224bb70461f
[2/2] MAINTAINERS: make PWM LED orphan
      commit: b28b77caacc7dbc4e8e27dfdb94471313bb9396e
-- 
Tom


