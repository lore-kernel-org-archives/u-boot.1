Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD35C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 20:36:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2635C817C4;
	Tue,  1 Apr 2025 22:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DlG5V5Wo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4367D81E5B; Tue,  1 Apr 2025 22:36:29 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 121D981703
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 22:36:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7272f9b4132so4329954a34.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 13:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743539786; x=1744144586; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D/WATEofXMgi9AHgkcQJO9yYaMom2kTmvXlIwumPmhY=;
 b=DlG5V5WoxwmCpOVxPOwJfh1xhxMt0cZIs4h9gk0HlTO7ftGBQEbFd8cFei+gmLsm4b
 teDbyG8MwFWJjR2z8qvci30pfiPiOvUsfGoMqetmudbLaHHFKyhvaf6kSGIm8LpymtPJ
 85N3hPSVRGCywJF5ayNiF5KCfPqViz0KnTyjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743539786; x=1744144586;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D/WATEofXMgi9AHgkcQJO9yYaMom2kTmvXlIwumPmhY=;
 b=Fc3ezkkd7juSJJ1SiNgEdpfYbhgolc6co5784xwb2soeQPEsM3+CygZx/Rf4jNiG9c
 G+S4XkfG0+7oDNONHf6QXzEFJUe+iDqdBsjJJ1wImuiiSjEekr9NEYovRdYORh30xr87
 Q2+Ht7V88tQG6pjQbrKn914pkyPaVlZ0o0R83OnCkDNEgQZPbG7/jNV5YqdEIR5pkysy
 6VAkN/Ftlr9d5dQBW8OWQri2NPmZwTC/Q8lIvU55Jsy5gNm0SrZB+Uh5OESgV642mmlF
 2QWWIiY1bjtlKMf4pu3r65OHTBxPf12CMxoNLYFOq8mz2OeZ8w4zATRsC0YnWyEj8bpi
 mWcw==
X-Gm-Message-State: AOJu0YyRHLWv+StP1kWx1s42s9tDiNZO+J+QXTvz8jGRfywe3N0S42tW
 soE4fTg9Xgel/TTnbS4o/2Jy6GAsf83B5frqGvpT8Rec5gJGtkAOi007BKrsp0VcSNN1ec6iaNk
 u
X-Gm-Gg: ASbGncv+smtk1tXa8aJTClOV3i8NvYc+mBxlAFqVW/0MgiP83vwFH9FQ8Q+9bNCpOsC
 Si0ih7NjKcE1K6Ld4fuCOBAovMTKXhCp66nyvA+f1Zg5OhOfNpDG4cyIrqx/1GbdVgDQb5cmc0N
 iM/ikjSzQrXnSo7kCejLLgWP+0V1/EEbYHNu9c0SiGWzXk+zkXOBnUs7W7uBsD/HuHaGdEn03lA
 tiIF0ryZm2fS45VJzCADx5zEuyIBQ0WY0X43d9PgQuEocGEfZ1bzn3ot2zvazqmKsxfnq5bURsA
 IXHMB2STQjbfQgvDVlJyMegfp5guxsqwObDPv8ldg1s28MK9s8VsRbK+nfrXb2KHCeYJhTx9CnB
 3Ex/t
X-Google-Smtp-Source: AGHT+IHhfwExWCxc4RU8vnpWlXZxhPhiIH9ptRe6BgVPqVsP6Rj5tgAc0lXJ79e+UGOv7TJkHn3bAA==
X-Received: by 2002:a05:6830:d08:b0:72b:992b:e50 with SMTP id
 46e09a7af769-72c6382ce02mr11644278a34.21.1743539785827; 
 Tue, 01 Apr 2025 13:36:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c58266eb4sm1956027a34.51.2025.04.01.13.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 13:36:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250315012933.399487-1-trini@konsulko.com>
References: <20250315012933.399487-1-trini@konsulko.com>
Subject: Re: [PATCH] Kconfig: Fix "warning: style: quotes recommended" warnings
Message-Id: <174353978509.1112159.17087584064194996372.b4-ty@konsulko.com>
Date: Tue, 01 Apr 2025 14:36:25 -0600
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

On Fri, 14 Mar 2025 19:29:33 -0600, Tom Rini wrote:

> We have three warnings about needing to use quotes around some strings
> in Kconfig files today. In two of these cases we can just add the
> missing strings. In the case of INTEL_PINCTRL_PADCFG_PADTOL the symbol
> is never referenced and should be dropped.
> 
> 

Applied to u-boot/next, thanks!

[1/1] Kconfig: Fix "warning: style: quotes recommended" warnings
      commit: 9b4b86f90c3a0484d4ecdcdb9977c385363ce5f8
-- 
Tom


