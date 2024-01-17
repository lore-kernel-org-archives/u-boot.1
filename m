Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E126C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 12:28:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 361EE87B79;
	Wed, 17 Jan 2024 13:27:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="jElrlqcF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SPV+B2YA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F7FA878A5; Wed, 17 Jan 2024 12:15:42 +0100 (CET)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2974887B5D
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 12:15:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=namcao@linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1705490139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MhHto95saDD9Q3pIUPw2kD7KQpBB+qqOiQI9ZmKelqw=;
 b=jElrlqcF8rWZ1Ikpmwcn0dU07qTwxPtl7FiVaCCbsDs2xuqvvOwdQ4B3udGeLjxQA/6Va8
 h1dDbLmW/Bx8lkRcTHlh8NUDx6GLtVieESNK2muRZ9quP5hHIYDyqWEhpKhQAMqMo6zzK9
 /yYdsi+9+Gk6ueii1zG2KCJAX3O0DgjCpW2NfPucwBg1vDrNrAj2z9D0yJ0uD3lAHaosp3
 zhn2PmS7TVF5JOXbBCki7/N5mG2ridHp5745O7GIpZezC+jTZSiZY2If08tc5XdXuDXE9I
 kfEER1+zq5fYPyHux91vZXtkthelNR688rX/KZcaO50EVGx8OX02PLteDL8N8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1705490139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MhHto95saDD9Q3pIUPw2kD7KQpBB+qqOiQI9ZmKelqw=;
 b=SPV+B2YAVGlubQQxYtLM8iCHyK/Kq/xbd31bf0QkCD5wKVOM3YK4ATndyGwSgpCgDJ7dan
 Pkbd/t7HLsj8ynAg==
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 u-boot@lists.denx.de
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 2/2] riscv: dts: jh7110: add power management unit controller
 node
Date: Wed, 17 Jan 2024 12:15:26 +0100
Message-Id: <3a9cd87553130b5e359910dcc931037a7c171714.1705489598.git.namcao@linutronix.de>
In-Reply-To: <811391b298858a02cbaae0dfafb92073b701e7d1.1705489598.git.namcao@linutronix.de>
References: <811391b298858a02cbaae0dfafb92073b701e7d1.1705489598.git.namcao@linutronix.de>
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

JH7110 has a power management unit controller node. Add this node.

This device is used by OpenSBI during board reset and shutdown.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 arch/riscv/dts/jh7110.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/dts/jh7110.dtsi b/arch/riscv/dts/jh7110.dtsi
index 6d2675d6ce..2cdc683d49 100644
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

