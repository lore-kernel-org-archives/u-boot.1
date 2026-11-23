Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F590606A321
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=v09juz7p;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=aYEfcPQL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C2522406AB;
	Mon, 23 Nov 2026 14:22:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V56vnZPEYzUO; Mon, 23 Nov 2026 14:22:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0DB4640635
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795443778;
	b=otta1LOxKNUBTd71OlwFC+iuA16styQutPMC/Ii9MVy91J5+R2aQhRTVf/NgXl/3T4Pn
	 QV0lebElq5hbDLB3UAwJfXhaXEup30p1aHANvd1hiXS8lZ8gQdb7nxhxJ90rpNdJsdAcE
	 Itau9uVRuWSmaY0Iij6r3ZQB11uGAXi8xr5mcjVGq7SQb4zmPhUrEwpOtXU/0ICohB31Z
	 vlbk7YT+AMNetFi1sVlNsEkZ9M+a2iqJJv8ciM/3zlqj9Cay3FDJKaNwDymOauOAM0/f+
	 3WPbaTKONpXWI8d5oN8TSURXqC6BaGVwolvcbL4yJ7GqG5Az925yqD1iFIMHmYggpCw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795443778;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EpzA9/TYyRMGWw45j16V2o7n4dy6NQ/IvA9UHkmcDb8=;
	b=K1sH4aW7dCjdWCSf2wZauqL9L+6pXeM2vzDA0V+LfWigCFWqeaLOqt6y5luZyTqy7zNt
	 djWco9iIQHvQI/ptbxeQ/KSzvZ+ztz7DRln5zKr23cAhoDpFImfdqAp6u02ZJAirxbWZ9
	 8D8k2Kpmn87faby8nTn5lMWJtmP8DmlLc3GMl4gDp0ALQW8q6vrQqvGDY6QGMhHFZtWiN
	 HX7Y+IW/Nw7e/O8yc/PNUSVZtL0/2oLw9ulByXcMiEIS5r3PxDnJnEAhl6inqGriEBLtL
	 kgvtg7t4ofux29KNWz8j1HjxOllvXBDSfWkQrcg9bobasjmcIVBKl2E2gx2jBq7xTwA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795443778;
	bh=EpzA9/TYyRMGWw45j16V2o7n4dy6NQ/IvA9UHkmcDb8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v09juz7p9I2qJTYCRst0UjJKXiweU/ZXaoWRI6x5JGxBD4KRpnxKG/8Z0wU0w3Kek
	 wiKXaxiGPn8IE4Von+WXOEXMQ73WQZ7/UUEFOEpHw1e1byvJuTvZg2X8bmqDoKCjoI
	 ftvCfAceEnJpIwHs3sxgRkSxOjtTwJwmzrF5W+NAfNz5ZEJxqTfDwm9nASWXdj1j3t
	 f3o7VyQ9e0Wt87PeFjm0gOkY+LEkEg0eem+T4iHBfmFP7iUVYi6KLT0T7tQh+Sh6Ch
	 2dTl/8KpCzAj3hmg3aP/hHQzbcvXS0jLF4k5uYETkpZOYCYx/0BNGBoKQHM4sdIIY0
	 0cLnXGq2yv1Ag==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0DB4640635;
	Mon, 23 Nov 2026 14:22:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 430A4371
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:22:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2585B60780
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:22:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rJDNfPxJILFI for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 14:22:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E2ADE6077B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=185.246.84.56
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.84.56;
 helo=smtpout-02.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=aYEfcPQL
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E2ADE6077B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 14:22:52 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id A2CCE1A179B;
 Mon, 23 Nov 2026 14:22:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 767C8601E1;
 Mon, 23 Nov 2026 14:22:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 99D5B11E6A51C; Mon, 23 Nov 2026 15:22:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795443764; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=EpzA9/TYyRMGWw45j16V2o7n4dy6NQ/IvA9UHkmcDb8=;
 b=aYEfcPQLZvJw4HzfDPLg365fZ6EEXhoyJ2mqtkJ/0xuvBQ5s/j9z7as6vFnuEgMSTstPFW
 xM02YtqQzJiOxTwHXqBkOdHUL3dYYCXVGk655UVcfoIvISdFyTSFSTefCMYWDNB8BWfx0F
 4u1ny1qwIOs3LifBHmGjvu+JKCXnyoiiqJ3HVa4gCvD2yHAiYxNAIB/VMzOFojyB/Qr7VC
 R2boGaJ0DeRZJP7Jx4mYc12EG8rv05/KLlg/HZpX0x+GKfhoHWHcjSXwme71RhtcnxJoTP
 wHxFRAvpe4oXgfffW5g/7Vw1vXYepy45w6TRScxjuYms+EY6LVbKbSNEBmoouQ==
From: "Richard Genoud (Synaptics)" <richard.genoud@bootlin.com>
Date: Mon, 23 Nov 2026 15:22:01 +0100
Subject: [PATCH v2 2/8] arm: dts: sl2619: Introduce sl2619-rdk-u-boot.dtsi
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-sl2619_base-v2-2-9e3b28c77cda@bootlin.com>
References: <20261123-sl2619_base-v2-0-9e3b28c77cda@bootlin.com>
In-Reply-To: <20261123-sl2619_base-v2-0-9e3b28c77cda@bootlin.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Terry Zhou <terryzhou05@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Johan Jonker <jbx6244@gmail.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Michal Simek <michal.simek@amd.com>, Linus Walleij <linusw@kernel.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, 
 Chris Packham <judge.packham@gmail.com>, Adam Ford <aford173@gmail.com>, 
 Marek Vasut <marex@nabladev.com>, Lukasz Majewski <lukma@nabladev.com>, 
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Peng Fan <peng.fan@nxp.com>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>, 
 Guodong Xu <guodong@riscstar.com>, Yixun Lan <dlan@kernel.org>, 
 Jisheng Zhang <jszhang@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.16.1-dev-53874
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Setup console before relocation

In order to setup the console before relocation, bootph-all is needed on
sm_uart0 and on its clock provider sm_clk

Signed-off-by: Richard Genoud (Synaptics) <richard.genoud@bootlin.com>
---
 MAINTAINERS                         | 1 +
 arch/arm/dts/sl2619-rdk-u-boot.dtsi | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f66db5d4608..279193e8239e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -712,6 +712,7 @@ M:	Richard Genoud <richard.genoud@bootlin.com>
 M:	Terry Zhou <terryzhou05@gmail.com>
 S:	Maintained
 N:	synaptics
+N:	sl261[x0-9]
 
 ARM TEGRA
 M:	Thierry Reding <treding@nvidia.com>
diff --git a/arch/arm/dts/sl2619-rdk-u-boot.dtsi b/arch/arm/dts/sl2619-rdk-u-boot.dtsi
new file mode 100644
index 000000000000..72e2adebde3e
--- /dev/null
+++ b/arch/arm/dts/sl2619-rdk-u-boot.dtsi
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+&sm_uart0 {
+	bootph-all;
+};
+
+&sm_clk {
+	bootph-all;
+};

-- 
2.55.0

