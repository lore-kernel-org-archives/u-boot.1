Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA58C47DA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 12:27:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB2BF87B75;
	Wed, 17 Jan 2024 13:27:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="dCS3Dm6S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lWuhZGOP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E581C87B66; Wed, 17 Jan 2024 12:15:40 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2545F878A5
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 12:15:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=namcao@linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1705490137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dH8pyfqDOjtmU8IYi2xh3PD/0fARMgnExQ4LrQH6qDE=;
 b=dCS3Dm6SBNJTL+tS0cn/oFHRMAOVMooDGlIYaUbVebLgPoGcAgxr9cGsWr6NAHs7w4kRXg
 DDDR4N5UPx8bmXyrpKDCiINr9fgiLsQ5Urvgmdt3nmvYGCJV8BqtymYWIR3ISoeNJ1UEBA
 wEWdgwOQjiQk+Tlgrvb4JktJiZF/qb/o1fT3crUwsluArBNfq3YTWAOrfvG+5jJAgmihFE
 r9ePJkLNccaWXGrawMuYOXF/c589edfC4ysIauTaeFOKxk4t8/2Dj1w5tnXuXMzKV3jslE
 3rP+nsS5RRj2VUy97jIlBr/NjS9yFrQShYyqbC0hVshWRAv/WEN+Ji3JB6ncrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1705490137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dH8pyfqDOjtmU8IYi2xh3PD/0fARMgnExQ4LrQH6qDE=;
 b=lWuhZGOPr7viVlJwYWCwHlp33v/gGcBmDaF/bNBwdcVH27Xjot37ZDRCI8LxLmbPD6QXmW
 qEHgdfwI0mFZuoBQ==
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 u-boot@lists.denx.de
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 1/2] riscv: dts: starfive: add regulator device
Date: Wed, 17 Jan 2024 12:15:25 +0100
Message-Id: <811391b298858a02cbaae0dfafb92073b701e7d1.1705489598.git.namcao@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 17 Jan 2024 13:27:11 +0100
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

Add the axp15060 regulator device. OpenSBI uses this device to perform
board reset and shutdown.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/=
dts/jh7110-starfive-visionfive-2.dtsi
index e94f9fe826..388d29727f 100644
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
@@ -127,6 +127,11 @@
 	pinctrl-0 =3D <&i2c5_pins>;
 	status =3D "okay";
=20
+	pmic@36 {
+		compatible =3D "stf,axp15060-regulator";
+		reg =3D <0x36>;
+	};
+
 	eeprom@50 {
 		compatible =3D "atmel,24c04";
 		reg =3D <0x50>;
--=20
2.39.2

