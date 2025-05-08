Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1869EC3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 21:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F51682A0A;
	Thu,  8 May 2025 23:24:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=krotti42.com header.i=@krotti42.com header.b="U6+807wq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7348D82A1C; Thu,  8 May 2025 23:24:08 +0200 (CEST)
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 847AA82952
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 23:24:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johannes@krotti42.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krotti42.com;
 s=protonmail; t=1746739446; x=1746998646;
 bh=q9odrafELMaJliFWu6kLTy0AQEmG8+uVTz7nrM5j+W8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=U6+807wq7znghh5jPvuQvtMoAzo74aypH0ZZ3DJfBi4x9Fa07qAt5C/dVnGRvbnVH
 MYZKqUixWf1i0Z0xP3xrWweYlbJyD4ZEZedYC6RCEIjOeTipcknVCbD54Dea2qkKeT
 okZumysXGPof2MUOh0TcE/FcuE6dTdpC2i5SYu5+Nc/rJr/+m8keKbtXA29FOAOFWS
 yzirZKSme1mxdCjRY4RakEI8al4Xlp7hxSGVXK7wUKFDvZQjbuU7xl7UzxIU3uhhDX
 oOumB9OJuoDHNF7LqY3og/Sp+ogK4QFrW5ZVHAtvIR3kUy7RLdciWt3sTHhkybngcj
 UJSQsrqleBx/Q==
Date: Thu, 08 May 2025 21:23:59 +0000
To: u-boot@lists.denx.de
From: Johannes Krottmayer <johannes@krotti42.com>
Cc: Johannes Krottmayer <johannes@krotti42.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 03/10] arm: mach-stm32: stm32h7: add STM32H747-DISCO board
Message-ID: <20250508212058.640483-4-johannes@krotti42.com>
In-Reply-To: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
References: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
Feedback-ID: 88021767:user:proton
X-Pm-Message-ID: bbc894852aad77c99879ee2cbd5fccccf0f8e5aa
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

Add initial support for the STM32H747-DISCO board in Kconfig.

Signed-off-by: Johannes Krottmayer <johannes@krotti42.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/mach-stm32/stm32h7/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-stm32/stm32h7/Kconfig b/arch/arm/mach-stm32/stm3=
2h7/Kconfig
index 70233a4b23c..281906d8595 100644
--- a/arch/arm/mach-stm32/stm32h7/Kconfig
+++ b/arch/arm/mach-stm32/stm32h7/Kconfig
@@ -9,8 +9,13 @@ config TARGET_STM32H743_EVAL
 config TARGET_STM32H750_ART_PI
 =09bool "STM32H750 ART Pi board"
=20
+config TARGET_STM32H747_DISCO
+=09bool "STM32H747 Discovery board"
+=09select ARCH_VERY_EARLY_INIT
+
 source "board/st/stm32h743-eval/Kconfig"
 source "board/st/stm32h743-disco/Kconfig"
 source "board/st/stm32h750-art-pi/Kconfig"
+source "board/st/stm32h747-disco/Kconfig"
=20
 endif
--=20
2.39.5


