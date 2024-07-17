Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA55C3DA60
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 01:53:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75BCE88AEC;
	Thu, 18 Jul 2024 03:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ncfx/rbx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAF4388AA8; Wed, 17 Jul 2024 20:24:35 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB0788879C
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 20:24:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=nyandarknessgirl@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-367990aaef3so11416f8f.0
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 11:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721240673; x=1721845473; darn=lists.denx.de;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xsut1+cCc6fjj8lpl/P684L1aQ5VGExTDpUJki7ocX0=;
 b=Ncfx/rbxDKd9n9Y4axN6xqeKuUGPuvzAcH963LKcA/Rl+Dbz+19iKmGe6poGsOXLdC
 g8GJK8drnjCGQrpmjoC8tlbd7X9lPmxKJsV/CiEK1J1JEBNJJx5L58+zOelGrSRWs01w
 EIMIVRd7IdVtfhLec+h1bMcmEQ0b0b8ATa7OOum/IZuGtYzpyRR/kDAIv03k7veIxxD3
 Hw2C3/Gwu19RLMbMIMG1SKyYMjuh4sKM6viKiwRSXgdTi4uNA5r/FBJm2/ukbHeLF2QR
 GxoELNsEVYJpAbar+HXZE8DlQWu2nIVqDACyvyZWa4l71fZ7zHcuLsGnxgygteGE/0VV
 mHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721240673; x=1721845473;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xsut1+cCc6fjj8lpl/P684L1aQ5VGExTDpUJki7ocX0=;
 b=uCDOZGn4ZXRb7bREQ9ee6ilolWEL5GjRQfaNb2UjGWrjNh/MPv2/Pth6xxGqB+rro4
 9EpCSNm78dX0aErlBBTRPye+rQO5hJqBTRk8PE0Go7yFsGSNdjEmk+BdhSuJxkcWeMag
 7UW+j9b5ksNLQAv59GJYg3XKoq0pWHCIOxJlIuuIx+7jWrna5MIqzeYhlrjczigwI890
 ZBwYcnlEXqpJBlxbrnz9gJs0AQJxyeYyMKTZ9xPjGISeervygaEanMlm1Uf8zGijsUYL
 wHa8F7279EKC+OiniS2aAEx6hgdqyg97ndZ5Ww5mGJcF5hUjHEgTLtxFgp6Z0qkpqXF4
 BUXA==
X-Gm-Message-State: AOJu0YybkcO604+RcR9CbY9Qt/5E4a525BHCb2bsW5PekLtMbaA09UiK
 wH5xU/kY/73udtxudIpul3n0rOI6VTucipiGvaAm6PTHoH+B6v6X5+Ok+d90/jC2XDwD0cZ0kAJ
 x4dbVlMaaVSIrr3lSy6lpCqvq3ui4eS4kffbkWBAl
X-Google-Smtp-Source: AGHT+IFnGlwGZSeoWudv5k3WAIcj+qmyR+3xxTdN19zzIoyHqTG91fqpasrsAsP3+4kws9M9nO1EUDigzWjl5alMObY=
X-Received: by 2002:a05:6000:71d:b0:368:255e:ab13 with SMTP id
 ffacd0b85a97d-36831722ed8mr2276110f8f.50.1721240672915; Wed, 17 Jul 2024
 11:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <CA+eeCSMKifhHwf+oYm-vamSyimoAycEN_U5RZj3bCX3Q5qsdwQ@mail.gmail.com>
In-Reply-To: <CA+eeCSMKifhHwf+oYm-vamSyimoAycEN_U5RZj3bCX3Q5qsdwQ@mail.gmail.com>
From: Eva Kurchatova <nyandarknessgirl@gmail.com>
Date: Wed, 17 Jul 2024 21:24:21 +0300
Message-ID: <CA+eeCSNo9RpZ_86wwYuKBiMHyZFAuEdiXL-6Sf=_9WfR_=ptFQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] riscv: qemu: Enable booting from NVMe
To: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 18 Jul 2024 03:52:34 +0200
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

From e6087bb6d1f25e8a5fddd4255fc07a957312b406 Mon Sep 17 00:00:00 2001
From: LekKit <50500857+LekKit@users.noreply.github.com>
Date: Wed, 17 Jul 2024 20:41:41 +0300
Subject: [PATCH 3/3] riscv: qemu: Explicitly advertise RVVM support

This patch series enables full RVVM virtual machine support which was
earlier inconveniently provided as out-of-tree patchset.

This should be cleaner than a separate board config, since both
emulators provide similar feature set.
---
 arch/riscv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index fa3b016c..7c52e666 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -21,7 +21,7 @@ config TARGET_OPENPITON_RISCV64
  bool "Support RISC-V cores on OpenPiton SoC"

 config TARGET_QEMU_VIRT
- bool "Support QEMU Virt Board"
+ bool "Support QEMU Virt & RVVM Boards"
  select BOARD_LATE_INIT

 config TARGET_SIFIVE_UNLEASHED
-- 
2.45.2
