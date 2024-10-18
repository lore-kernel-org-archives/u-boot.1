Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB77D3C541
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 01:58:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFF4B89171;
	Fri, 18 Oct 2024 03:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pL/0pRfg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB05989171; Fri, 18 Oct 2024 03:57:45 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7040F89143
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 03:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-6dfff346a83so15283327b3.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 18:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729216662; x=1729821462; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4/Pb+HvB4nLYwV+BZKJbH0iQ9Qpani6YU9vktDA1EcI=;
 b=pL/0pRfgP2ltlSgHeqCLMxquo9Ja7+oxLOK05KgM2hTQD/BkV67MC4KBlhZc3JsSGm
 LgoDgu+fT6x2ZV/aTGCLnniSaRumo6HxSuai8+lxz96SHHAceFjPtnv2D51ShE9OqT2n
 ksfsG1CEDMBinZIWBETSE8ZTf5pH4kLkbZI7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729216662; x=1729821462;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4/Pb+HvB4nLYwV+BZKJbH0iQ9Qpani6YU9vktDA1EcI=;
 b=cCJgZb9s568tI4E5pHW7MGvKAt8IGaJgcpmIeZdxLOlse0LUgnaetAMIkHtKztdxwR
 VfxddgbqyAwQpT7dgswFAb6HJaptHH+nLDIIcLVaY6ERfyJQua9fKTMdl//TBNRD9IeU
 Y69bge115tkbLYEEFHUzi6q4nGZjHbEVaYMZCLvXXKAnE5VUr6aGWVYe1L0StITF+Giy
 H5O+gvNS1nu4vlwOqwHXxaciBtCxgJKc1H/0+lKPQxId8lu09ApXvlF/2Iigr6xc+/Vi
 uBp+vsaxOitnZrER4+Qn58Ro2Kf+6MXuhGCeUdUmFooLA1Qj9R8PXjoy8ybf+E/h9RIH
 89Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5G45gSE1VToOQBTyddkcknzqLgm1zymifMaxcJNdmB+PTbDVVGRyc12EjA6eBu6PHKgrQd/Y=@lists.denx.de
X-Gm-Message-State: AOJu0YxENt1WmDiQ6auhUCL3lU4QMAAII6is7MleoXVpU4mRdPUZpRIw
 ZlHLBuGJsK4WhTgldsDZhaJWkhSGV3jSJHemA5eYdDtobYwAErxcUtQEGosNY4ZKTGyTw0vftwJ
 TpYk=
X-Google-Smtp-Source: AGHT+IH/UtxgCRjj/6oBMRSZkrCfy4gsy+++z5juKw0B321W8RGIxhPQzyR5YyxLLITzq8OGERkb+Q==
X-Received: by 2002:a05:690c:2510:b0:6e3:2be1:a2dc with SMTP id
 00721157ae682-6e5bf999800mr8842827b3.11.1729216662246; 
 Thu, 17 Oct 2024 18:57:42 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cde1366ac3sm2332156d6.113.2024.10.17.18.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 18:57:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Parth Pancholi <parth105105@gmail.com>
Cc: Parth Pancholi <parth.pancholi@toradex.com>, u-boot@lists.denx.de
In-Reply-To: <20241002074133.1749361-1-parth105105@gmail.com>
References: <20241002074133.1749361-1-parth105105@gmail.com>
Subject: Re: [PATCH] arm: mach-k3: am62: fixup thermal cooling device cpus
Message-Id: <172921666093.1016776.3567600108715535240.b4-ty@konsulko.com>
Date: Thu, 17 Oct 2024 19:57:40 -0600
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

On Wed, 02 Oct 2024 09:41:33 +0200, Parth Pancholi wrote:

> AM62x devices now support CPU throttling based on thermal alerts
> with a Linux commit 10e7bfd8114c ("arm64: dts: ti: k3-am62: Enable
> CPU freq throttling on thermal alert"). However, this functionality
> does not work correctly across all variants of the AM62x SoCs
> which have different numbers of Cortex-A CPU cores: AM62x1 (1 core),
> AM62x2 (2 cores), and AM62x4 (4 cores). On single-core and dual-core
> AM62x devices, the following error is observed in the Linux kernel:
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


