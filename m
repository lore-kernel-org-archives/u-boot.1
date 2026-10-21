Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9FD606A322
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 22:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=HWf0Ay9P;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzTFrbIy
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B859160EAD;
	Wed, 21 Oct 2026 22:19:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0tuoiw5TzE67; Wed, 21 Oct 2026 22:19:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C3C3760BDD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792621172;
	b=ojQIaOYFm821A4jIQyxThjFPSIEsP4f7qjz9HBLPrQ4JpVrbViA/1kRmfM6OEZMw/KUY
	 nCWLgcyeEQsQBr5lmDSGJ+vQFoJ0smvM8g8LCF+KIUrzFF8EIp4RNPsPkSiz7LEywOg17
	 xeET7kxNrjvdXCv/b/OuQHMraCb3aUW3mBb06xgV1ULcdjsDjCQZVycP5q7JcpkDpsT3y
	 svBRCVnOwHpDS/IQk49dcNTW0XZNoqA6cWkZMRNn5ENpZWLsW5Dk7nGjhvdsTJ7XEO6XX
	 3unkR38FCJQnAaeYZUbi3Oy7mkKRp4CpZ/1lmOLiJPW9IAXU4ANCowYiuIEP8zzFUPA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792621172;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=rm9n3ncyeTU6nzIeMrfzTq3oWd0CNYcq+IAoRugMnZ0=;
	b=UoLMxBkrq7dRuC88Xz5gO4oopUMMhZvZRskIRtAMzsDpEJzAsmA4bRWFLJExDjlb0a2P
	 cHejceGbKDI8LTTMvpMKVkV/3NMl4F+N/Zvd7GWmBXr4vijvKmefXgQqrcCL+SsBgJH67
	 Mzv2hI62j4Qwj3gccE4by7Cn/SMfoBr7GWijyigHVVXQgyf37ipalM1LSmdV02222eLjO
	 E8fdcFQhYvwA8Ta9kJrMu9g+1hc797rX4t3o5J9cy/ewuTkezbSmRCuhGAiFBhA/a+3u8
	 WWDEkdQu+MaxHa96DqiqvDouVOwQAZgQ1eDDuquDfb4cNVdMO+vYgPmW5xxxOizj3OA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzTFrbIy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792621172;
	bh=rm9n3ncyeTU6nzIeMrfzTq3oWd0CNYcq+IAoRugMnZ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=HWf0Ay9PsKMGOLB/A3U/lJKhBTddyVGnjIUL9l9iT6NAUUrSA0/KTM4sRMRgCHENG
	 a+wOdFimk+8Eo4QmGE/GGViwG4boXhPQjvV8EHy/R0tNBjjK0uzzMSnVUwFenZJiAS
	 vNls8hwMywm7vyDY7d/z9vXqaV0TeNST84A4yHctOTdcOUge1FU8+GVV4VQjJNx7iL
	 /+k5YfXRrrxlvHPCa7P4ZnUWixq4aeyqQZSWIyi8CFoA8cTT3PdeZQw++9ismnmCTq
	 C0vIB+MKh45E1vJqt0Zv0Cg4Oq9I6IRFVP1u1DIyZTUmu/cEa6lBysQ769EKk0Vy8t
	 w0eOhGVdZPLYg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3C3760BDD;
	Wed, 21 Oct 2026 22:19:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2282A235
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 21:17:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 145136131C
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 21:17:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hWE0Vaph8iTu for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 21:17:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 58A94613D6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=172.234.252.31
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792617425;
 b=gUXP321XKN2ML8YZVSio6bicrd2TdEAIipmAW8CalD/ja7haFIM3icPl872ETMdLrXjV
 ObKiRimCkqfy2zgUYRHSjCNBbmrdMm5+FE5yhe+jtv0oXri/mGxduMUj9WXBSBODuTnLa
 BM1DpHesvXSGkctSCKWl71HPpe0GoGSvsUd0Mg5LjjufrqcnF72GDqYt/dwUJF7/iTtTa
 xB9RPJceDyiXDXF4bbQy1J93UpslbHnI8NYG6Kgwy3IqYRCEcH/xfVDK1KyoipLYcPia/
 FX6DJSqGR8wVZEPsFj4TmmQs9vfvGA017hwTexQUxttD6PJM1bzcozt07ie0dGJzPSQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792617425;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=rm9n3ncyeTU6nzIeMrfzTq3oWd0CNYcq+IAoRugMnZ0=;
 b=PrJxoD3Q1cOJVS/9EBm0O3WGtHlO/7K0UIzZUBMbL0pvqz0XNX6Jn7PwstDcbACVHhh1
 Y7dg8iIXXzfjKEObtGzLQsJjJ+ljeb61+2AosyJnP30xyLnYRnJ3yRPWrpTcAdRpWemw3
 qxM6DME5OX05RRb22M1JUTZnSrxEjDXPJJQbJfOF+RgnEbyH3yjw0/qGjieBCgWLlHTAt
 Jr8dNHd81KMBKuY/lB/gEABXc+PncG+vofpVMFRh+xouu57eInmHgStuQd+eivTjiw5i9
 tnqUTo+dDHUtYOpy1afzl1ZTY1hesPu6nCeZSui/DhsNbmCFO/NP/DzQXSxzkjQqpPw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hzTFrbIy; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+filipescu.cristian.gmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=hzTFrbIy
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 58A94613D6
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 21:17:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5507743FE4;
 Wed, 21 Oct 2026 21:17:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792617424;
 b=ePmfy2JsPl9xkjLtxiCEpsr3iwKVexoKsA4HnQEnWSsMBm/bRcmriTfmd6IMEMfjPVvb
 7xrOCSLTGe9uO6fBmDb+GvH7q/PhcL1J17P6f4kcNVCJTvf3QtWxyb1bkXiZQmoBAhhz4
 45Oo933fjkvHgATtn16LXwAzFxJoUtmeisxZ8Fx40VW3sDC6Xiky3BfwUYAL1+T6nZFUR
 +GYku05Xp3Im19kh1mV0XU7Dr0xGrQ9FNoZzNJ34Z3BrUieCKySb9xnFfYfeaoNBsQqRF
 0oWI6GrvfU6wYYICwsBbuXMOXrJjFn6Xy+f0stfzSN36OyARm9Z1uDbXKFgtiXLcVUA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792617424;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=rm9n3ncyeTU6nzIeMrfzTq3oWd0CNYcq+IAoRugMnZ0=;
 b=JOfEbOKdwobB+QbTn9Ayt9hPLsxg7dtP2b2z9PJQzLEoHF5AiGumofwVq9EsS94MQCSN
 Wrzap5/Q03NCsn14hau4YgcJzy+T0UQA3K2q2p74tSSQEDrZxU831jaQGmbiThHaeuOan
 N7jI46rHRr5aJ5k5uOoB4VgcBnjV2FbsZ7Sg5yl+PwjjGou0HUebcaxWgGl6Q7vu+nRJQ
 AHX1yApahclLfZih6tuZMYgdiqCjoYRcpbTXl/2w/31j6I2rjECW9VKN45RGL1pvX3xod
 c+SgnE7cdUenKDNcb5j7US1Mrjk/u6CbcVq1t++GiRIKUQQo8bzxEBgDhQQAT0jdpoQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id A8B441F000C9;
 Wed, 21 Oct 2026 21:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792617424;
 bh=rm9n3ncyeTU6nzIeMrfzTq3oWd0CNYcq+IAoRugMnZ0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=hzTFrbIyFPYPlu/F0JFmv6rGX9On1EWeIm4pYNvfypJWkcON1UTwmkg+NQgVqxUZ/
 fsGhgC2GjjF/Z9TFW8g47jb3zYN19E6ylufU7jsfsSmldpsd2BRFuwAolvU/XzV3P4
 KhbcBwOq5aQDU13tuebCHHfTBzhJY14Pa75rxHDX2G6dHtR6lV+fL/qgyzeLBdkUQT
 pXu/eJSk9OLWvqI6N+w2TaG4n8lfXKqyY0aVb46WuT5hBkc3EH8QlQUXp4AKvUp1qt
 XbVQQE3jqlVD3khuMQx9F0oNRt7JSelBSekpEpTBDdyqnYjL9LFyUCs2O8DpRKu/R5
 k2I0nZyfGuJKw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 3CE7743460;
 Wed, 21 Oct 2026 21:17:02 +0000 (UTC)
From: Cristian Filipescu via B4 Relay
 <devnull+filipescu.cristian.gmail.com@kernel.org>
Date: Wed, 21 Oct 2026 21:13:02 +0000
Subject: [PATCH 1/2] arm: dts: sunxi: Add Orange Pi 3 LTS device tree
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261021-sunxi-orangepi-3-lts-v1-1-19a3df928d8e@gmail.com>
References: <20261021-sunxi-orangepi-3-lts-v1-0-19a3df928d8e@gmail.com>
In-Reply-To: <20261021-sunxi-orangepi-3-lts-v1-0-19a3df928d8e@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Cristian Filipescu <filipescu.cristian@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792617188; l=10381;
 i=filipescu.cristian@gmail.com; s=uboot-20261021;
 h=from:subject:message-id;
 bh=ScQ+KfSTXG4R6apix8kGLccbnEUa1yCsSNbXqeZVjd8=;
 b=cpDlclI0D1RFo5COV0UcEySPG5O/kwf5zWnZILD8/9vRE/a8yIPD0nriOWHHYctXhPZh0oSew
 sUbRXuNbRPlDn63e5BbDJxbkIdtyguhBu7pyA95LAkAf+uLk1IbjCtS
X-Developer-Key: i=filipescu.cristian@gmail.com; a=ed25519;
 pk=o7Ui0tU3x+X/6Pq6PZHmd2KFtOdPWttoPuNFOvdD8t0=
X-Endpoint-Received: by B4 Relay for
 filipescu.cristian@gmail.com/uboot-20261021 with auth_id=1255
X-Original-From: Cristian Filipescu <filipescu.cristian@gmail.com>
X-Mailman-Approved-At: Wed, 21 Oct 2026 22:19:28 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: filipescu.cristian@gmail.com
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jernej Skrabec <jernej.skrabec@gmail.com>

The Orange Pi 3 LTS is an Allwinner H6 board with 2 GiB LPDDR3,
8 GiB eMMC and a Motorcomm YT8531C Gigabit Ethernet PHY. Its Ethernet
power, reset and wireless module wiring differ from the Orange Pi 3.

Import the device tree submitted for Linux in the linked patch. Keep it
in the local U-Boot DTS directory until the board is available through
dts/upstream, and include the current upstream H6 SoC and OPP descriptions.

Incorporate the clock naming, supply chaining and BLDO3 always-on fixes
requested during Linux review. Describe the PM bank supply and the
DCDCA/DCDCB polyphase arrangement. Program both RGMII delays in the PHY
with the MAC delays disabled, as proposed during the Ethernet review.

Use the green PL7 LED as the power indicator and the red PL4 LED as
the status indicator.

Link: https://lore.kernel.org/linux-sunxi/20250413134318.66681-3-jernej.skrabec@gmail.com/

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Cristian Filipescu <filipescu.cristian@gmail.com>
---
 arch/arm/dts/Makefile                     |   1 +
 arch/arm/dts/sun50i-h6-orangepi-3-lts.dts | 361 ++++++++++++++++++++++++++++++
 board/sunxi/MAINTAINERS                   |   5 +
 3 files changed, 367 insertions(+)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 099e3f08..248b4faf 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -634,6 +634,7 @@ dtb-$(CONFIG_MACH_SUN50I_H5) += \
 dtb-$(CONFIG_MACH_SUN50I_H6) += \
 	sun50i-h6-beelink-gs1.dtb \
 	sun50i-h6-orangepi-3.dtb \
+	sun50i-h6-orangepi-3-lts.dtb \
 	sun50i-h6-orangepi-lite2.dtb \
 	sun50i-h6-orangepi-one-plus.dtb \
 	sun50i-h6-pine-h64.dtb \
diff --git a/arch/arm/dts/sun50i-h6-orangepi-3-lts.dts b/arch/arm/dts/sun50i-h6-orangepi-3-lts.dts
new file mode 100644
index 00000000..44ee57c6
--- /dev/null
+++ b/arch/arm/dts/sun50i-h6-orangepi-3-lts.dts
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (C) 2025 Jernej Skrabec <jernej.skrabec@gmail.com>
+// Based on sun50i-h6-orangepi-3.dts, which is:
+// Copyright (C) 2019 Ondřej Jirman <megous@megous.com>
+
+/dts-v1/;
+
+#include <arm64/allwinner/sun50i-h6.dtsi>
+#include <arm64/allwinner/sun50i-h6-cpu-opp.dtsi>
+#include <arm64/allwinner/sun50i-h6-gpu-opp.dtsi>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "OrangePi 3 LTS";
+	compatible = "xunlong,orangepi-3-lts", "allwinner,sun50i-h6";
+
+	aliases {
+		ethernet0 = &emac;
+		ethernet1 = &aw859a;
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	connector {
+		compatible = "hdmi-connector";
+		ddc-en-gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>; /* PH2 */
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
+	ext_osc32k: ext-osc32k-clk {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		clock-output-names = "ext-osc32k";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0 {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
+		};
+
+		led-1 {
+			function = LED_FUNCTION_POWER;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&r_pio 0 7 GPIO_ACTIVE_HIGH>; /* PL7 */
+			default-state = "on";
+		};
+	};
+
+	reg_gmac_3v3: gmac-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "gmac-3v3";
+		vin-supply = <&reg_vcc5v>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <150000>;
+		enable-active-high;
+		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
+	};
+
+	reg_vcc5v: vcc5v {
+		/* board wide 5V supply directly from the DC jack */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
+	reg_wifi_3v3: wifi-3v3 {
+		/* 3.3V regulator for WiFi and BT */
+		compatible = "regulator-fixed";
+		regulator-name = "wifi-3v3";
+		vin-supply = <&reg_vcc5v>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpio = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&rtc CLK_OSC32K_FANOUT>;
+		clock-names = "ext_clock";
+		reset-gpios = <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* PM3 */
+		post-power-on-delay-ms = <200>;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_dcdca>;
+};
+
+&de {
+	status = "okay";
+};
+
+&dwc3 {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci3 {
+	status = "okay";
+};
+
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ext_rgmii_pins>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ext_rgmii_phy>;
+	phy-supply = <&reg_gmac_3v3>;
+	allwinner,rx-delay-ps = <0>;
+	allwinner,tx-delay-ps = <0>;
+	status = "okay";
+};
+
+&gpu {
+	mali-supply = <&reg_dcdcc>;
+	status = "okay";
+};
+
+&hdmi {
+	hvcc-supply = <&reg_bldo2>;
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
+&mdio {
+	ext_rgmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+
+		motorcomm,clk-out-frequency-hz = <125000000>;
+		rx-internal-delay-ps = <1950>;
+		tx-internal-delay-ps = <1950>;
+
+		reset-gpios = <&pio 3 14 GPIO_ACTIVE_LOW>; /* PD14 */
+		reset-assert-us = <15000>;
+		reset-deassert-us = <100000>;
+	};
+};
+
+&mmc0 {
+	vmmc-supply = <&reg_cldo1>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
+	disable-wp;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&mmc1 {
+	vmmc-supply = <&reg_wifi_3v3>;
+	vqmmc-supply = <&reg_bldo3>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	aw859a: wifi@1 {
+		reg = <1>;
+	};
+};
+
+&mmc2 {
+	vmmc-supply = <&reg_cldo1>;
+	vqmmc-supply = <&reg_bldo2>;
+	cap-mmc-hw-reset;
+	non-removable;
+	bus-width = <8>;
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci3 {
+	status = "okay";
+};
+
+&pio {
+	vcc-pc-supply = <&reg_bldo2>;
+	vcc-pd-supply = <&reg_cldo1>;
+	vcc-pg-supply = <&reg_bldo3>;
+};
+
+&r_ir {
+	status = "okay";
+};
+
+&r_pio {
+	vcc-pm-supply = <&reg_bldo3>;
+};
+
+&r_i2c {
+	status = "okay";
+
+	axp805: pmic@36 {
+		compatible = "x-powers,axp805", "x-powers,axp806";
+		reg = <0x36>;
+		interrupt-parent = <&r_intc>;
+		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		x-powers,self-working-mode;
+		vina-supply = <&reg_vcc5v>;
+		vinb-supply = <&reg_vcc5v>;
+		vinc-supply = <&reg_vcc5v>;
+		vind-supply = <&reg_vcc5v>;
+		vine-supply = <&reg_vcc5v>;
+		aldoin-supply = <&reg_vcc5v>;
+		bldoin-supply = <&reg_vcc5v>;
+		cldoin-supply = <&reg_vcc5v>;
+
+		regulators {
+			reg_aldo1: aldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-pl-led-ir";
+			};
+
+			reg_aldo2: aldo2 {
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc33-audio-tv-ephy-mac";
+			};
+
+			/* ALDO3 is shorted to CLDO1 */
+			reg_aldo3: aldo3 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc33-io-pd-emmc-sd-usb-uart-1";
+			};
+
+			reg_bldo1: bldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc18-dram-bias-pll";
+			};
+
+			reg_bldo2: bldo2 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-efuse-pcie-hdmi-pc";
+			};
+
+			reg_bldo3: bldo3 {
+				regulator-always-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-pm-pg-dcxoio-wifi";
+			};
+
+			bldo4 {
+				/* unused */
+			};
+
+			reg_cldo1: cldo1 {
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc33-io-pd-emmc-sd-usb-uart-2";
+			};
+
+			cldo2 {
+				/* unused */
+			};
+
+			cldo3 {
+				/* unused */
+			};
+
+			/* DCDCB is polyphased with DCDCA. */
+			reg_dcdca: dcdca {
+				regulator-always-on;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1160000>;
+				regulator-ramp-delay = <2500>;
+				regulator-name = "vdd-cpu";
+			};
+
+			reg_dcdcc: dcdcc {
+				regulator-enable-ramp-delay = <32000>;
+				regulator-min-microvolt = <810000>;
+				regulator-max-microvolt = <1080000>;
+				regulator-ramp-delay = <2500>;
+				regulator-name = "vdd-gpu";
+			};
+
+			reg_dcdcd: dcdcd {
+				regulator-always-on;
+				regulator-min-microvolt = <960000>;
+				regulator-max-microvolt = <960000>;
+				regulator-name = "vdd-sys";
+			};
+
+			reg_dcdce: dcdce {
+				regulator-always-on;
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-name = "vcc-dram";
+			};
+
+			sw {
+				/* unused */
+			};
+		};
+	};
+};
+
+&rtc {
+	clocks = <&ext_osc32k>;
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_ph_pins>;
+	status = "okay";
+};
+
+&usb2otg {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usb2phy {
+	usb0_id_det-gpios = <&pio 2 15 GPIO_ACTIVE_HIGH>; /* PC15 */
+	usb0_vbus-supply = <&reg_vcc5v>;
+	usb3_vbus-supply = <&reg_vcc5v>;
+	status = "okay";
+};
+
+&usb3phy {
+	status = "okay";
+};
diff --git a/board/sunxi/MAINTAINERS b/board/sunxi/MAINTAINERS
index df745f14..a7c17fb4 100644
--- a/board/sunxi/MAINTAINERS
+++ b/board/sunxi/MAINTAINERS
@@ -438,6 +438,11 @@ M:	Andre Heider <a.heider@gmail.com>
 S:	Maintained
 F:	configs/orangepi_3_defconfig
 
+ORANGEPI 3 LTS BOARD
+M:	Cristian Filipescu <filipescu.cristian@gmail.com>
+S:	Maintained
+F:	arch/arm/dts/sun50i-h6-orangepi-3-lts.dts
+
 ORANGEPI 4A BOARD
 M:	Chen-Yu Tsai <wens@kernel.org>
 S:	Maintained

-- 
2.47.3


