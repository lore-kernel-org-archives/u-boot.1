Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A3BC83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:23:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C55B83118;
	Mon, 14 Jul 2025 15:22:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="dmuOnaBa";
	dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.b="lDq+2asM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 998628304D; Mon, 14 Jul 2025 15:22:39 +0200 (CEST)
Received: from out-ip0052.fra.mailhop.org (out-ip0052.fra.mailhop.org
 [18.158.144.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15E718304D
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 15:22:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=holger.brunck@hitachienergy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hitachienergy.com; s=duo-1630306886989-947ac67a;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:cfbl-address:cfbl-feedback-id:from;
 bh=+ZvJzyVEXdfkjMKzZgxCpp6Fm7gTOXZ2F2ym6PHEh68=;
 b=dmuOnaBai5oyRj5k/VKoa48DIp/6Y4yfhbwy++GfoPPq9aO0u43XhXNxppN7+GBccjvc223jMFjzp
 pUsr3q99MgDgR9gLNb8OFjOtC2k4S6Pt8+3Xwm7gmQ+EHw33DKaeGh4bgV3Os/N19jDfvnmHWv3gcE
 iyruA82ITGv1QiuE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
 subject:cc:to:from:cfbl-address:cfbl-feedback-id:from;
 bh=+ZvJzyVEXdfkjMKzZgxCpp6Fm7gTOXZ2F2ym6PHEh68=;
 b=lDq+2asM9VVD0X0AvHRU8m9rt8ShpxfrwfwKqGPLR39FHBMj5t0KJAN+LXNZjlnacNADPiXGYCjwE
 Vn7FwKvYUok450QoqA2T4RraMXlkSX9U5Qniq42OD7A0poRfQBLuFCbfHy+Ho1T+odK4g5uLUWHJMR
 alSa6/4vv763BvjqeOMKdeBQ/O184jwxPFtqiSN2XSASaBXXzZcbz5Rt2Eso8FedtR6+FxCKRe1gAX
 dPbTAbGs5Rde0IMzN3pQa0uA8POIfTdgIsyYZokwtY6croqCnmtV7+M3/z7/7qIzimoqFt+q8VAyO7
 nZqVNgbnbxk/6ya0AHTrpB5FejYkexQ==
X-Originating-IP: 20.62.140.138
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: 998a4aeb-60b5-11f0-be1c-eb1d40c36193
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: 998a4aeb-60b5-11f0-be1c-eb1d40c36193:7
CFBL-Address: prvs=02909799d7=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000534.corp.hitachi-powergrids.com (unknown
 [20.62.140.138]) by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 998a4aeb-60b5-11f0-be1c-eb1d40c36193;
 Mon, 14 Jul 2025 13:22:34 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
 by HPG0000000534.corp.hitachi-powergrids.com (Postfix) with SMTP id
 2EAAD40252E; Mon, 14 Jul 2025 13:22:32 +0000 (UTC)
Received: from chbrn3-p-dev015.keymile.net (chbrn3-p-dev015.keymile.net
 [172.31.41.201])
 by gitsiv.hitachienergy.com (Postfix) with ESMTP id A8D8E637F981;
 Mon, 14 Jul 2025 15:22:31 +0200 (CEST)
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
 Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH 3/6] arm: ls1021a-pg-wcom: add i2c mux node and eeprom
Date: Mon, 14 Jul 2025 15:22:18 +0200
Message-ID: <20250714132221.2471558-3-holger.brunck@hitachienergy.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250714132221.2471558-1-holger.brunck@hitachienergy.com>
References: <20250714132221.2471558-1-holger.brunck@hitachienergy.com>
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

We are now using the DM code for the i2c mux and to read out the
inventory eeprom. Therefore we need to add the nodes to the specific DTS
files.

Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
---
 arch/arm/dts/ls1021a-pg-wcom-expu1.dts | 20 ++++++++++++++++++++
 arch/arm/dts/ls1021a-pg-wcom-seli8.dts | 20 ++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm/dts/ls1021a-pg-wcom-expu1.dts b/arch/arm/dts/ls1021=
a-pg-wcom-expu1.dts
index ec8e7dee271..1068f1a288a 100644
--- a/arch/arm/dts/ls1021a-pg-wcom-expu1.dts
+++ b/arch/arm/dts/ls1021a-pg-wcom-expu1.dts
@@ -51,6 +51,26 @@
=20
 &i2c0 {
 	status =3D "okay";
+
+	pca9547@70 {
+		compatible =3D "nxp,pca9547";
+		reg =3D <0x70>;
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c@1 {
+			reg =3D <1>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+
+			ivm@50 {
+				compatible =3D "atmel,24c02";
+				reg =3D <0x50>;
+				label =3D "MAIN_CTRL";
+			};
+		};
+	};
 };
=20
 &dspi1 {
diff --git a/arch/arm/dts/ls1021a-pg-wcom-seli8.dts b/arch/arm/dts/ls1021=
a-pg-wcom-seli8.dts
index 03ce3ab4e47..3e8c54d83c9 100644
--- a/arch/arm/dts/ls1021a-pg-wcom-seli8.dts
+++ b/arch/arm/dts/ls1021a-pg-wcom-seli8.dts
@@ -44,6 +44,26 @@
=20
 &i2c0 {
 	status =3D "okay";
+
+	pca9547@70 {
+		compatible =3D "nxp,pca9547";
+		reg =3D <0x70>;
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+		i2c-mux-idle-disconnect;
+
+		i2c@1 {
+			reg =3D <1>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+
+			ivm@50 {
+				compatible =3D "atmel,24c02";
+				reg =3D <0x50>;
+				label =3D "MAIN_CTRL";
+			};
+		};
+	};
 };
=20
 &ifc {
--=20
2.49.0

