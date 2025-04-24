Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D04C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 21:32:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CA6D81B4B;
	Thu, 24 Apr 2025 23:32:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AKXbetZ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE979809D4; Thu, 24 Apr 2025 23:32:40 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D3B380F9C
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 23:32:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2c769da02b0so1285829fac.3
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 14:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745530357; x=1746135157; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EIewe6jtt9x59NsItlBLVgTZ234rAkVbTQvxmf8WLyM=;
 b=AKXbetZ37wa5XZiuRBzsmrcSIOdypjTig1K0nfDhUgch+Oca6rKe2sP2A7gyWkd7Im
 KKQNqU75px+LQvb+LhALcxJXXONU5byklouFREkrKfGDDuYPE4ABNI2XaJxT5RB0Y3et
 ob55dW2N0MuUKNaDcz7Fwm2KNo39LoVpi38pE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745530357; x=1746135157;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EIewe6jtt9x59NsItlBLVgTZ234rAkVbTQvxmf8WLyM=;
 b=EBJkMz8zoOnjsMHwEzmb4iwAFH3VH5RrceNEbGXcY4XnwK8qf88E+GrN7cbKiLs4eO
 euLutiPgmk6D5cXb8NW0k/p0ciIhXTPyklrUfPNMp3a1PWKrkxz39cWGyNQnM8Bf1gPR
 9p3QwUjp2C+om3QQEQm27SjTUO4JpAdL3wOyeL744xFLMQ+ztcfxZaFlNBpKQcvq/0pa
 me2w7N2mqeC5ERmgRrce4L5W0Wdspgeo7XNaRQdRa+SXVW4mh3tWPhGJTtPgBY/tYIn6
 0LK56o86gighhtRYE7qGME0W1kK+mj8zKdg5YlcqFwbCe5JjmPAjqK/VLe+J9D4brbUi
 e5pw==
X-Gm-Message-State: AOJu0Yx4gppl0NDvQzol9OGUy7wUoRkVcym1ykYjANU8bied+zPswSdX
 9KaM9Nv7fYuu2wbN1TbGeYMXmJu8rm5bIJrfiik67HgvN0wU+SGNspdBFwzOTkI=
X-Gm-Gg: ASbGncvUK4hYsrf3dSMDMDzPl65Ewxka21z5nXhNuhjAmb5IOjnLBfzihCIvZe4JNmm
 nRt1Aau7YWGaCdI2KC0l5VaJLRQ3pFEavIkFC4HtYGjRv0vrNt5wZd1m00xR27J54s0Sc5mcg99
 i44u8/nIuI2gAAsXUTf+DAcllhkZ0Avv/R+ljlkShwJyvmZENTM1ovYtTyvY4deo21/stM74Sfj
 82kKOJ8uhQ+vcR0FTs6GgBNZY1LFd1ZAespJ97pze8/DyZYfxEkWouNZ2dw8Gwwfr9DFadObGJD
 Mqk+VZSAH6aQVkytgMUj6X8VHpxTWuPFJwWgRE8IK7DHqhK8OzrjRS95zwCpFc9UoWdJ4JvAYty
 D
X-Google-Smtp-Source: AGHT+IEzjMFZ5TQPZFn+xB9i4OlVsiRlqx29xGC0cNqh5QoqQIu3KiukOSn0ZFMTG9+EOxlNTl2WLA==
X-Received: by 2002:a05:6870:a691:b0:2c2:5a63:9cd4 with SMTP id
 586e51a60fabf-2d99d863e08mr59364fac.19.1745530357367; 
 Thu, 24 Apr 2025 14:32:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d97364d9b6sm489419fac.8.2025.04.24.14.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 14:32:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
In-Reply-To: <87jz79enw0.fsf@kernel.org>
References: <87jz79enw0.fsf@kernel.org>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20250424 into master
Message-Id: <174553035647.4093791.3193750966326833293.b4-ty@konsulko.com>
Date: Thu, 24 Apr 2025 15:32:36 -0600
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

On Thu, 24 Apr 2025 14:37:35 +0200, Mattijs Korpershoek wrote:

> Please find the following fixes/developments for master:
> 
> Usb gadget:
> - Fix ACM gadget release
> - Allow ACM gadget restart after releasing it
> - Add 'enabled' flag to usb_ep structure
> 
> DFU:
> - Fix alt buffer clearing for DeveloperBox board
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


