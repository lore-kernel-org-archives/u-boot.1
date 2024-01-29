Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852DAC47DA9
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 08:43:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5985187CE0;
	Mon, 29 Jan 2024 09:43:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="RIh2oFt5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LuKnacni";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E681787CE1; Mon, 29 Jan 2024 09:43:26 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3AE587CCE
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 09:43:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=namcao@linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1706517803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R8d99MbAAb9e6Z792/MKRWK97zPxviiA6xBfQdB4Azw=;
 b=RIh2oFt5SPTGa4YE9UOt1nA7wbnqKb6lQETWhZHRq4ys7//Hon4HIAtmtMf1ZrZ05M0eaY
 3+eFIE7lbqgsuOrYROC+5I5JXL1Aaa8f5dINPq6lcMqyU50y/YS+s9Hsbygw2oxV7XX65D
 A47dt5xcDSDpoHwiDIMf7K1GVFHeRV+m4RvuP3EWO4R85zBOiWh/vxcr8GRYgeB+nPYM/4
 FlRXdEa+ApnTEqm6rV8UwNUFFoBfwdqla7LlnfBqTPDaID+Gv+66+zT8YQ2BfwRJJmwdhp
 wyNJ3D1EK5Jw970wVYYT1l5Zjp/P95g9guz3GMl4zpRrbCHlh2VHx5NRZs3k7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1706517803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R8d99MbAAb9e6Z792/MKRWK97zPxviiA6xBfQdB4Azw=;
 b=LuKnacnikurnTD1e2QRVvHB+ad4++vOI9jN23owIDFN6z4UUzEFSQRS5a4E4gZMOZDwf5h
 YVW5Qpez/IJoxyAQ==
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>, Torsten Duwe <duwe@suse.de>,
 Nam Cao <namcao@linutronix.de>, Xingyu Wu <xingyu.wu@starfivetech.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de
Subject: [PATCH v2 2/2] riscv: dts: starfive: add regulator device
Date: Mon, 29 Jan 2024 09:43:09 +0100
Message-Id: <47fd2b2225f52a2d5c3a91494ef7b9036e944199.1706517351.git.namcao@linutronix.de>
In-Reply-To: <cover.1706517351.git.namcao@linutronix.de>
References: <cover.1706517351.git.namcao@linutronix.de>
MIME-Version: 1.0
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

Add the axp15060 regulator device. OpenSBI uses this device to perform
board reset and shutdown.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
v2: "stf,axp15060-regulator" -> "x-powers,axp15060" to match Linux.

 arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/=
dts/jh7110-starfive-visionfive-2.dtsi
index e40f57a150..fe4b3e71ae 100644
--- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
@@ -122,6 +122,11 @@
 	pinctrl-0 =3D <&i2c5_pins>;
 	status =3D "okay";
=20
+	pmic@36 {
+		compatible =3D "x-powers,axp15060";
+		reg =3D <0x36>;
+	};
+
 	eeprom@50 {
 		compatible =3D "atmel,24c04";
 		reg =3D <0x50>;
--=20
2.39.2

