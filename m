Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67658C47422
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 08:43:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3A6B87CD9;
	Mon, 29 Jan 2024 09:43:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="4BIGg6ew";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p2CXcIYk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 384FC879A0; Mon, 29 Jan 2024 09:43:25 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EF2387CBE
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
 bh=OtVrnwcXYgjFMLLWptyHNIr0OXeRBNlCDep0mkrEyCg=;
 b=4BIGg6ewPpn+RurWkqxp1dt8X3PWMJ4NzlqzLoRHgJ7+3Np0szRcpjb8tFYNO6hi4Lhcnv
 IUC+7Kl8gHn+3EaKCr83dGZ0/KH64r2SH0F5KwoBOrFJXIW41qMLeIpjNOZAy+Ewz6nJVj
 jmnK85aBg9IauklxMQ4GOT7zOApmNZoN2e5cp3YSag17+/XuNzMX/FSSfFDuiA2ZCeSL3A
 arh+9c0wDs6zztFaNNa0ai6vXUcaKcqXyVx1MAnnLxY7o8FHoXWG4ZwUaMalltOZl21KhS
 XYUgPBDHyO3pMXzOFrDeXeYOlurrXA8N2u3AL5OiLnvBSYw6x0o32KgasBRZEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1706517803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OtVrnwcXYgjFMLLWptyHNIr0OXeRBNlCDep0mkrEyCg=;
 b=p2CXcIYkUx8sXlhS+b+0ipAoSrE3YFLUZ98Ic6S3ZepNF6KR+2EY5/iTGRW6vFXOa/0Lab
 QkOTph1GhqjPkFDg==
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Minda Chen <minda.chen@starfivetech.com>, Torsten Duwe <duwe@suse.de>,
 Nam Cao <namcao@linutronix.de>, Xingyu Wu <xingyu.wu@starfivetech.com>,
 Mason Huo <mason.huo@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>,
 Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de
Subject: [PATCH v2 1/2] riscv: dts: jh7110: add power management unit
 controller node
Date: Mon, 29 Jan 2024 09:43:08 +0100
Message-Id: <05a8be865b0686a916d7ec7ba8fbc64ecb33ad14.1706517351.git.namcao@linutronix.de>
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

JH7110 has a power management unit controller node. Add this node.

This device is used by OpenSBI during board reset/shutdown.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 arch/riscv/dts/jh7110.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/dts/jh7110.dtsi b/arch/riscv/dts/jh7110.dtsi
index ec237a46ff..56e34fd560 100644
--- a/arch/riscv/dts/jh7110.dtsi
+++ b/arch/riscv/dts/jh7110.dtsi
@@ -473,6 +473,12 @@
 			status =3D "disabled";
 		};
=20
+		power-controller@17030000 {
+			compatible =3D "starfive,jh7110-pmu";
+			reg =3D <0x0 0x17030000 0x0 0x10000>;
+			interrupts =3D <111>;
+		};
+
 		qspi: spi@13010000 {
 			compatible =3D "cdns,qspi-nor";
 			reg =3D <0x0 0x13010000 0x0 0x10000
--=20
2.39.2

