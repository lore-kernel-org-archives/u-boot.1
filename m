Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A6CC369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 17:06:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97EF382E37;
	Thu, 17 Apr 2025 19:06:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sXWeRLcm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC99982CDF; Thu, 17 Apr 2025 19:06:40 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86DC981E18
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 19:06:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3f8df49e75fso238525b6e.1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 10:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744909597; x=1745514397; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uLy+z2QXpk8q6TSg6KrnxsyhmKQzgx4KF2wVwlChSmM=;
 b=sXWeRLcmu0UOv/Qv2qvRUn5wOxpidLPG7TU8XZv/+SA5U9GU8ZfKeM7cL8Wn/9x9fz
 dBNgU3uTxURA+Eefq7umMwadOBQ7sPgtGfipjk6MdfzKfCei0eUqWkHB2S4MKxPF//wW
 cN8tb0FW8EndHlwfsMpJasGE2tcPQFQKmZD2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744909597; x=1745514397;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uLy+z2QXpk8q6TSg6KrnxsyhmKQzgx4KF2wVwlChSmM=;
 b=qf79H5okSk7SpQ08/6zm2Z6NI9ib1jOBS0uveHFgGQ+GXQospzMJR8cKNjlUusQ0j4
 G19Nfruu3eSc6JmHFZZTPOnKfBG4v6PYTL/0pGSRdyFDGpiANso4YbXcLmuhJsAbsWsv
 eLoVW1yP1TG6XYYgf5JlZvS8isiY55FxNi2AwnX7dUeJQhrmcaFPUsYipWXF7S+YOjJF
 +Vr+yZlK9geFo+WuDf8V2il6LYONX3vE5euJ9PdQvUCzJF1+jYyUlv9A+CdkYphx/IxD
 fAm/MR0rRXhNyGEmpkInwgeBcXiIm30l5iFrOoTqieLrbiPBleMJ/vVyrbf+A4qalJn6
 M5NQ==
X-Gm-Message-State: AOJu0YyS5LytYoqqm8gGpsKfIiywiqXXd9sgxgKH5sLELFkZ07yjSJRu
 VrTHsAWpNqqnwKShe6g7ghqv8T5BwAppq5ocMei+r+7DbZb05WRY+ryLplEwJRCOk1os+WNO1p4
 C
X-Gm-Gg: ASbGncvDxCBg9/LDDeeQuCAlgd0nqeNcXdzBv0vKo8nJmJv0kUBBySVhat0bYSHhg+W
 sOGLGyxWBrzPWjQwcaBwR/Z8mLlMFHxVfKygFUxQYYWMkGKnnBFs+SQzRJc7XQM/xZ10EFgkWMb
 7Vo995s6YP7VO1sPgM/BzKkVhtfycl6o8gA9pt0cV5XBuWjSw2nlJ1t9WDPgn2Z73DG8/RmpC0E
 YKWkZ0VKroUENgZQeZUwdbJ2STltsqG/fQWnvd44N5lzkeBqSlo6P/aXQiclyejCA9dr1z2VAdM
 yFNbMmU/InMweJFW37NQXF5giBS7POSoNQHuHtYXNoAitkq2KHfMMU5QIc+61lQAzhtMrUzV+0L
 C
X-Google-Smtp-Source: AGHT+IHJESLYcsy9yOaJuHgSQMpgSBonRyYEr99Hnw6vZWVj/AP8bZb0qO6WZP4on5DMulxgj2iDRw==
X-Received: by 2002:a05:6808:3ca:b0:3fb:2937:937c with SMTP id
 5614622812f47-400b01c2d43mr3384124b6e.6.1744909597056; 
 Thu, 17 Apr 2025 10:06:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-605ff6aacf5sm28411eaf.39.2025.04.17.10.06.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 10:06:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Stefan Roese <sr@denx.de>
In-Reply-To: <b42d26fc-263f-45c0-aede-783a401ec724@denx.de>
References: <b42d26fc-263f-45c0-aede-783a401ec724@denx.de>
Subject: Re: Please pull u-boot-marvell/master
Message-Id: <174490959627.2996754.15614300307813446702.b4-ty@konsulko.com>
Date: Thu, 17 Apr 2025 11:06:36 -0600
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

On Wed, 16 Apr 2025 15:35:25 +0200, Stefan Roese wrote:

> please pull this next batch of mostly Marvell related patches:
> 
> ----------------------------------------------------------------
> - mvebu_espressobin_ultra-88f3720_defconfig: disable SATA
> - helios4: enable ddr odt0 on write for both chip-select
> - clearfog,helios4: disable sdhci sdma
> - mvebu/bubt: Correct usage of IS_ENABLED() macro
> - mvebu: Correct SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR usage
> ----------------------------------------------------------------
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


