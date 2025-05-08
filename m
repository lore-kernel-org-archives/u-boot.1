Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40699C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 21:24:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B85D082A56;
	Thu,  8 May 2025 23:24:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=krotti42.com header.i=@krotti42.com header.b="DMdm1N0p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D021582952; Thu,  8 May 2025 23:24:12 +0200 (CEST)
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch
 [109.224.244.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB2C382A39
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 23:24:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johannes@krotti42.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krotti42.com;
 s=protonmail; t=1746739450; x=1746998650;
 bh=Yqqzy/fjyhejbub1GyGYzJwu1zkvXU2UupH5l7s425c=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=DMdm1N0pJV6jkJGB/Djs9r9oVFcxVfkZzSyoowEy1gZmj8xU6Y9TxBvHYVu8Yc3QU
 V9ITnKCeHAOnTMlunzhtkEqjNKcjwZkZvwITZ7tSp779QftgNXo0a2KiZKLqmLKNkt
 FJPpZM9gDaRqtN48qynRxmxugViGK9Bta7AcOodEAwXfhbfrYSe4n/fy0x3PUS9JXs
 7ImMD5vBK9O1T4qkBh7yGczqf6e5uMGnSoJsLPz4PubaUmZ4kynCUM2L8xenhT4bGo
 0T0bU42C8XmnG2cqAgDfEwzfd0sBQzNZXq5adldpUYjr8yRQSgbUx429th5lLBh+MU
 y3goclWr2MXMQ==
Date: Thu, 08 May 2025 21:24:05 +0000
To: u-boot@lists.denx.de
From: Johannes Krottmayer <johannes@krotti42.com>
Cc: Johannes Krottmayer <johannes@krotti42.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 04/10] arm: mach-stm32: add stm32h7 subdirectory
Message-ID: <20250508212058.640483-5-johannes@krotti42.com>
In-Reply-To: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
References: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
Feedback-ID: 88021767:user:proton
X-Pm-Message-ID: bce419268e4fc2f0040a79d433daf8daa469b5bb
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Add 'stm32h7' subdirectory to main Makefile.

Signed-off-by: Johannes Krottmayer <johannes@krotti42.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/mach-stm32/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-stm32/Makefile b/arch/arm/mach-stm32/Makefile
index 03d535d8148..8af4943e542 100644
--- a/arch/arm/mach-stm32/Makefile
+++ b/arch/arm/mach-stm32/Makefile
@@ -3,3 +3,5 @@
 # (C) Copyright 2000-2006
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 obj-y +=3D soc.o
+
+obj-$(CONFIG_STM32H7) +=3D stm32h7/
--=20
2.39.5


