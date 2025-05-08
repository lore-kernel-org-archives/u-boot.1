Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7596C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 21:25:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E228C8269F;
	Thu,  8 May 2025 23:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=krotti42.com header.i=@krotti42.com header.b="BvB2wQoU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48E0282AF4; Thu,  8 May 2025 23:24:49 +0200 (CEST)
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch
 [109.224.244.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56078829E4
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 23:24:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=krotti42.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=johannes@krotti42.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krotti42.com;
 s=protonmail; t=1746739486; x=1746998686;
 bh=pBJZ32yxyZEIhYOvmfNMElhw/l2wtBUUbZnx08cweN0=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=BvB2wQoUbFP1UdUETZKx/NHUCpCx19LsJdjOwchzWApyfT6JOFXJAx6j+CNOC61If
 mEHeBCyS5Nf2m9KrVf24AEOJoftuy/I0EQH04hqJFb9KyDP/rNXqq2TTsVOItK6kF+
 tStI6dZHb2eY/QWJnhYJw/I+DyqlUd+UCgV2yMGVjlQ2eM98/6EilefIgr4UUm9+r3
 2/wxlgZbJPySF7wCIqkLO+9TqGC7DpoitCAbVkHaI0nZn7sjsMtcspmkUIroFvbBXF
 0vA8erPvnr+q6jIQNR3cceBzd0ClVhNCAiuVrZIrrv3Nm4+HXo6cWOWqUQHyAxc6Ad
 RO0QqezStVpKQ==
Date: Thu, 08 May 2025 21:24:41 +0000
To: u-boot@lists.denx.de
From: Johannes Krottmayer <johannes@krotti42.com>
Cc: Johannes Krottmayer <johannes@krotti42.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH 10/10] dts: upstream: arm: st: stm32h7-pinctrl: change pins
 for USART1
Message-ID: <20250508212058.640483-11-johannes@krotti42.com>
In-Reply-To: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
References: <611b339e-a9fe-4cc1-b2fc-617d844a86ac@krotti42.com>
Feedback-ID: 88021767:user:proton
X-Pm-Message-ID: 24566338b79a14d63a0c515445071cec9b41f2d4
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

The pins for USART1 have must be changed to other values, to
support the STM32H747 discovery board.

Signed-off-by: Johannes Krottmayer <johannes@krotti42.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
---
 dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi b/dts/upstream/sr=
c/arm/st/stm32h7-pinctrl.dtsi
index 7f1d234e102..7d7c87aa2fe 100644
--- a/dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi
+++ b/dts/upstream/src/arm/st/stm32h7-pinctrl.dtsi
@@ -213,13 +213,13 @@
=20
 =09usart1_pins: usart1-0 {
 =09=09pins1 {
-=09=09=09pinmux =3D <STM32_PINMUX('B', 14, AF4)>; /* USART1_TX */
+=09=09=09pinmux =3D <STM32_PINMUX('A', 9, AF7)>; /* USART1_TX */
 =09=09=09bias-disable;
 =09=09=09drive-push-pull;
 =09=09=09slew-rate =3D <0>;
 =09=09};
 =09=09pins2 {
-=09=09=09pinmux =3D <STM32_PINMUX('B', 15, AF4)>; /* USART1_RX */
+=09=09=09pinmux =3D <STM32_PINMUX('A', 10, AF7)>; /* USART1_RX */
 =09=09=09bias-disable;
 =09=09};
 =09};
--=20
2.39.5


