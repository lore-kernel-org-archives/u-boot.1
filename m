Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6EFC02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 23:11:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA46180756;
	Sat, 15 Feb 2025 00:11:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fC7qOEfH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49EF880756; Sat, 15 Feb 2025 00:11:16 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98B09806FE
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 00:11:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e5dcc411189so4105276.0
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 15:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739574671; x=1740179471; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I9L+HIN9Bzsg/c33YT+VrgzqFXmATsCYRcseQ68Y3lg=;
 b=fC7qOEfHSGtQ7CU5+VccKdh+gpbe744wpaW0tZ9BfNGLVEvlWCS0Jv1RLg4MIfmLs9
 2X7KEQKQn6u+zTyodPs5etGObZ2rxcVXg2eAlkivjFBxAEob7Oq7SbHpO6ae+UzzcnGh
 tcGydRwy6VmE/mRb0vpupVeo6nwdbG2E1lyCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739574671; x=1740179471;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I9L+HIN9Bzsg/c33YT+VrgzqFXmATsCYRcseQ68Y3lg=;
 b=LKTrsatm1IPchMfl61ly26t/FY8FHbVSyyW62I9FJzmMi9AQjeKkjxJBYeOg74x3KD
 wALa03CAA3LVe1b6+aVcMzoJHMp32rOjrLUSCn37r71fsKQNSIIib4qFG9jpvroM3zXK
 A73unCVzKTeO9UsQA96rO7xhkK0Oga13ZMO4ZYAdsvgZ11mR7u8itWtzyE1GaP3d24d5
 Xjlo6g15CLaRriU0MZXeOR1HzxRKddno8vEKfF/722IwUsY6fXVMnqIvEIzaN+YZ9xDg
 sg4qlnzvWyPfvx+PABX1m7bNFEgN0jd2EbHy88Jeolt4LUKs3aehMjV05mkfhahmE2ei
 vtaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3qpG87ycqJPu6+mImcMy7mq0thVkCgD8fuWHgm+nLoLyx09rrJqA6oF/4ZfH9TaGnDW1/nc8=@lists.denx.de
X-Gm-Message-State: AOJu0YwQxeRqRiDznrdmBdeounr0iJ7Up4Twl+NbtHJ8kEO60AfRHbiW
 m158ZtvWFpCDRSbCQNbKPQzKM9oRw9pledwrN33ZzK60cS8s5P3D2ceq34pBjm8=
X-Gm-Gg: ASbGnctuyEDe751DaSs8Fl50Pjyvq6woIJqqVA22k6iw4t97JF6DeqZetSE9FzyzXl9
 jlchUTEnlhYZciCyC3S30x7+wyActdOrwxEqfil4CTlPlyn0zQhE07LDQQxBn6kgBa5XZx2poMQ
 l0SW1iD4z9Oy4a0EUQJYhiIBMZdI/I/quPwJSkeh5yUflrHPMiKQjXqxl4KswgZhYqsq2XEHlMC
 cj3K/be+4/Zqy4ZkabRlKD4G3H9e/IqBSGSuDuVmGNNrNYrwOEqjW4HAu2oxqMiP/7CbMos0tuH
 jsbt9tDk7FxHog==
X-Google-Smtp-Source: AGHT+IEkwbWlGKacMDadZgwRtVMT5CGexzVYJf9J5Nt1ujQ+Kc8lEN+wkxqOV4HuOibc31uVOzy2NA==
X-Received: by 2002:a05:6902:1614:b0:e57:6644:ea3f with SMTP id
 3f1490d57ef6-e5dc9049485mr1140870276.15.1739574671194; 
 Fri, 14 Feb 2025 15:11:11 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e5dadeb1994sm1282976276.24.2025.02.14.15.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 15:11:10 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Judith Mendez <jm@ti.com>
Cc: Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Beleswar Padhi <b-padhi@ti.com>, Hari Nagalla <hnagalla@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, u-boot@lists.denx.de
In-Reply-To: <20250210202944.1071931-1-jm@ti.com>
References: <20250210202944.1071931-1-jm@ti.com>
Subject: Re: [PATCH v5 00/10] Introduce K3 remoteproc driver for M4 subsystem
Message-Id: <173957466995.3193.16946906389721578800.b4-ty@konsulko.com>
Date: Fri, 14 Feb 2025 17:11:09 -0600
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

On Mon, 10 Feb 2025 14:29:34 -0600, Judith Mendez wrote:

> Some K3 devices like am62x and am64x have a M4 processor in the MCU
> voltage domain. This patch series introduces remoteproc M4 driver which
> will be used to load firmware into and start the M4 remote core.
> 
> This series also adds support for R5F cores on am64x SoCs in patch 2 and
> sets up environment to load FW in remote cores in patch 3,4,5.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


