Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BDFFA3751
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 23:24:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8B0B83C02;
	Sat,  3 Jan 2026 00:23:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d1Un4qmE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3B4D83B8A; Sat,  3 Jan 2026 00:23:46 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C45F683B49
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 00:23:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-65cff0b394aso7752978eaf.0
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 15:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767396223; x=1768001023; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NKa29lKvNELo195+v5je604yYslDFER4Hm/A8PS6VEg=;
 b=d1Un4qmENEHY0v6KP88U3mXNcmZWFhySnO/2tmenlhcGWdLr/UCLh3nPEBYHLrt9ky
 ibrmG7EhpGCqDJ14zH9MvHvc0X4I8C9M4/fxI7lIpIOa8Rmlo5pr75fSXos+bfSAeUlx
 xy8OIujoO81H4X/6gtXF7XsZctSTOVBfihctI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767396223; x=1768001023;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NKa29lKvNELo195+v5je604yYslDFER4Hm/A8PS6VEg=;
 b=QLIk9wcKRRr1qdTjxfNaJ+CBfLtCQDx6qSheNtYHqD+wiUnzZTqnGWZkTPYKijtzRX
 KhesS7b0xgaycVtmYuF4kGFeH9SplPcm/dvxgHDOPCgMCkmtZO7KNbt1/oSSQCv2jS5L
 8jDFt0rf5atzKT7hQw2T3yU6fnrMrop8a7Q/s03JcYl1NRPzJkIMrThF8iRooOMY7+66
 84klOwY5BBz4pqucxfZSRKUrDsP0XBMrhE3+iOhvk0Q2aqA+ctRBioqxcBTz+PfX/CxH
 cetqn0DEuezeUyLGDl+3ZcCHNj71DX0TDARd13erDHgsX4Gg3BHZPfQGeN1UZ+DQJ/G9
 yueQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzjCfPRLqD6/VtCqjfjDIKqtwzYbFk2WEasAf1AaMuhd/SlD6F/j9YVRVBqumqmBaRrBZy5VE=@lists.denx.de
X-Gm-Message-State: AOJu0YxA8UgnFr5k3wjyks97EfJMTLWB3KLBxrQcNwwkLy7tL6mkYIp0
 IR5+bulaSX9zpfZnkguUpqsVUXK2+CuRMRXZ8D0i+1gD1nYx+ooXfQGtF3ta36Vfb20=
X-Gm-Gg: AY/fxX4J8812t8Pa2JlfvrgS3z+Nsne0OXSVqi42QMK1uHqKap8ovdIgl8Kg/eKJ2jn
 kuWy75R/vbcTOIJSiVfbQnQx/gyxkEF5uYKrgW4jSa1rH3IFQQs03CLt26qit8s0Y+xS+drYguE
 vx5BjjMale4kdcc37AnnmenTsgxl/cVQ3DFH51HkmKdK5pSk5dgJl6SqVs6Cji0ra2rW75gy9Op
 SxBAxwgyqI1ODM89F6SxxN3NSnKasxNH7BGJ+snTRdxxYOViBz2DrLzXVEc0S7mKsZCToBBeKk/
 DRLBg3n7E1Q3jA/+MIpzHN+jIlRyR5EdwC2y2rS7jVx1YOOjxPu3Wq0JVitSRXhIrKbTDzCcQXT
 1hVLBdBI1DCBZRNOYqyQEDG0zszbFcdmTxtEJUfyrXOv9QUNMYMPRYHZHbiA0pFavJ3r0gNyeXV
 tQV/MLcjdo19qSwEz49iiIFpNsf1XecEGp6N+A6xg7TamjKxBjfgGKQK0k7aRs3oWGTA89cCGIH
 Ji9SdbElFWC6hJYp5fm11AABizDNvVQ3y47TQ==
X-Google-Smtp-Source: AGHT+IF0YRMxSr+dTzINxooRm60KLrTke21mChEtCUiq7zWqY+NY50KzB8v2sJIo/8jCX4CSaJ1s/w==
X-Received: by 2002:a05:6820:228b:b0:65b:3797:6536 with SMTP id
 006d021491bc7-65d0e932cc1mr19838213eaf.3.1767396223554; 
 Fri, 02 Jan 2026 15:23:43 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa4e0d18sm24711983fac.0.2026.01.02.15.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 15:23:43 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20251209235905.431884-1-heinrich.schuchardt@canonical.com>
References: <20251209235905.431884-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] configs: qemu_arm64: disable SEMIHOSTING
Message-Id: <176739622238.296893.14237206079711296751.b4-ty@konsulko.com>
Date: Fri, 02 Jan 2026 17:23:42 -0600
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

On Wed, 10 Dec 2025 00:59:05 +0100, Heinrich Schuchardt wrote:

> Semihosting allows a virtual machine to write to the host file system.
> Such dangerous settings should not be in a defconfig.
> 
> Move it to a CI configuration override.
> 
> 

Applied to u-boot/next, thanks!

[1/1] configs: qemu_arm64: disable SEMIHOSTING
      commit: f2f69886ac181e74fa378cf49bdee33e6e9a4188
-- 
Tom


