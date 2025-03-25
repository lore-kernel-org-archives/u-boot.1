Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C811AC36002
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 02:55:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 484B081B42;
	Tue, 25 Mar 2025 03:55:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dI9YITKy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68C2081B42; Tue, 25 Mar 2025 03:55:12 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37920819B1
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 03:55:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-476b89782c3so57300871cf.1
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 19:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742871309; x=1743476109; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vA4GPWA2BIg20TrBYfvZG8H59E6aHn5tThtJ5Xz77ow=;
 b=dI9YITKyo+5FuRoMSTNQSUwavEnv3JBSkNeoxsOCXf2sApK74lxHojlgmFuGKrVzgH
 5fyJGZk4DJIjXylbAa2wwYD3zGTLOd1ECpcIgAhUniKEAbzTRxMIOK3rEsPCZ+u/byrS
 iBz/eS49MiRB8s7rGnmuUtabxfo3ke8X88S6ghNNHuVm5H2yx4/jU/YELfwrftvPa5Jv
 HzDXrLrwY/0wHvr2deJDzJRjjrofLK8boMHjlyy76V74CyOHDWJSn6/BjLUYZdrBoKTs
 yvdxSE2acSbPHwnSkRCXDqbnoHCAFlSST+kkmyN184r9z/Ct2wGL39a4HNmrmx58bG2/
 kQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742871309; x=1743476109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vA4GPWA2BIg20TrBYfvZG8H59E6aHn5tThtJ5Xz77ow=;
 b=EqZt0pA72cr/T26dFNCQHPC+iAP/U2/rAla2XfTgY2g2+srndJObhPOFCpKwwAWap2
 dbj0ReiumLG2ojGeze6bAEgLJ+OVxzhW0Jx1gwLsT0ymD5g1sOZiuJCkcSiSScyLkqJe
 XF57aFdBx15YCoxyE/HIMizDkvU+zItJzB7X3Cpa4x5Fk1UskDWzvZZsy8XbflwHw1vK
 5CYFZ0nvUMZHMmuoZwM4Xf5fS1G1QslTJz2aBJiIFBftJba7MClMpm3y+BEvuYI2fv5f
 hMsONLcE6tE/db7c9LeGm1ytDszDnCv+VpKpB3uoHHc/syRyCDg+4LhSa0/yJDZzHnHL
 s9TQ==
X-Gm-Message-State: AOJu0Yw5NrJleWBujvl3DOMqE6DK4C2g7PS/haVCyyRg1dTPe3YshDIF
 ZdFHZMFv4Oaz5gNywxkwEZwNB9LylUJ5QmN8loWkms/qXrjNpJ7fvbpNng==
X-Gm-Gg: ASbGncu8Mm1HFQmXvORsxquxB+76yx0XNYk9RkSMIrkIJKY3vrFpDpJIICMe1cjsLRN
 zZMr4YpRueLHEBQ2nFkBeqv1lfdt51zeNayI36O9QKP3r7+nW8JesksLeGH3GyR8ZI9wPOe5baD
 jDAjix7rA84GRhjYhjZlNt/OmTSlGeuI3NL7hEhx9MzBHzyEcCCj7qNAuqpLTq05kCAB6/R5mbD
 xy1QAvAJbfYxncub5Az5Epe3v4OWkuzJEGOayxpGZR048WcB/9u99DqkLH0Sws/JjIGMGLWL4qv
 9a0N+Hf/5j+T23BAFOAhRuBLpF0zD1X/XPIps2IwT53koxrLe3BuEDaYDJ5x+Zrx09LLnev4wxR
 PUn5wtR+5ttcjDocujzM=
X-Google-Smtp-Source: AGHT+IEWCyzi0xd0pb85oDC7pQXUSCwVnkV5wsrnlqDrFYK42T048mjFcZrLy28uuJkHv+mSAIgnOw==
X-Received: by 2002:a05:622a:260b:b0:477:c89:3813 with SMTP id
 d75a77b69052e-4771dd62403mr195035681cf.9.1742871308673; 
 Mon, 24 Mar 2025 19:55:08 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4771d176113sm54712021cf.17.2025.03.24.19.55.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 19:55:07 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, festevam@gmail.com, marek.vasut@mailbox.org,
 Adam Ford <aford173@gmail.com>, Stefano Babic <sbabic@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>, Enrico Leto <enrico.leto@siemens.com>,
 Peng Fan <peng.fan@nxp.com>, Yannic Moog <y.moog@phytec.de>,
 Teresa Remmet <t.remmet@phytec.de>, Gilles Talis <gilles.talis@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ye Li <ye.li@nxp.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Wadim Egorov <w.egorov@phytec.de>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH V4 2/7] cpu: imx8_cpu: Expand get_imx_type_str list of
 supported CPUs
Date: Mon, 24 Mar 2025 21:54:43 -0500
Message-ID: <20250325025452.950303-3-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250325025452.950303-1-aford173@gmail.com>
References: <20250325025452.950303-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The imx8_cpu is capable of running on IMX8, IMX8M, and IMX9
families, but the CPU list is limited on the 8M variants.  Expand
this list to show more variants and their respective names.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/cpu/imx8_cpu.c | 44 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 53d31b3c0bf..39b3c194131 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -35,11 +35,49 @@ static const char *get_imx_type_str(u32 imxtype)
 {
 	switch (imxtype) {
 	case MXC_CPU_IMX8MM:
-		return "8MM";
+		return "8MMQ";	/* Quad-core version of the imx8mm */
+	case MXC_CPU_IMX8MML:
+		return "8MMQL";	/* Quad-core Lite version of the imx8mm */
+	case MXC_CPU_IMX8MMD:
+		return "8MMD";	/* Dual-core version of the imx8mm */
+	case MXC_CPU_IMX8MMDL:
+		return "8MMDL";	/* Dual-core Lite version of the imx8mm */
+	case MXC_CPU_IMX8MMS:
+		return "8MMS";	/* Single-core version of the imx8mm */
+	case MXC_CPU_IMX8MMSL:
+		return "8MMSL";	/* Single-core Lite version of the imx8mm */
 	case MXC_CPU_IMX8MN:
-		return "8MN";
+		return "8MNano Quad"; /* Quad-core version */
+	case MXC_CPU_IMX8MND:
+		return "8MNano Dual"; /* Dual-core version */
+	case MXC_CPU_IMX8MNS:
+		return "8MNano Solo"; /* Single-core version */
+	case MXC_CPU_IMX8MNL:
+		return "8MNano QuadLite"; /* Quad-core Lite version */
+	case MXC_CPU_IMX8MNDL:
+		return "8MNano DualLite"; /* Dual-core Lite version */
+	case MXC_CPU_IMX8MNSL:
+		return "8MNano SoloLite";/* Single-core Lite version of the imx8mn */
+	case MXC_CPU_IMX8MNUQ:
+		return "8MNano UltraLite Quad";/* Quad-core UltraLite version of the imx8mn */
+	case MXC_CPU_IMX8MNUD:
+		return "8MNano UltraLite Dual";/* Dual-core UltraLite version of the imx8mn */
+	case MXC_CPU_IMX8MNUS:
+		return "8MNano UltraLite Solo";/* Single-core UltraLite version of the imx8mn */
 	case MXC_CPU_IMX8MP:
-		return "8MP";
+		return "8MP[8]";	/* Quad-core version of the imx8mp */
+	case MXC_CPU_IMX8MPD:
+		return "8MP Dual[3]";	/* Dual-core version of the imx8mp */
+	case MXC_CPU_IMX8MPL:
+		return "8MP Lite[4]";	/* Quad-core Lite version of the imx8mp */
+	case MXC_CPU_IMX8MP6:
+		return "8MP[6]";	/* Quad-core version of the imx8mp, NPU fused */
+	case MXC_CPU_IMX8MQ:
+		return "8MQ";	/* Quad-core version of the imx8mq */
+	case MXC_CPU_IMX8MQL:
+		return "8MQLite";	/* Quad-core Lite version of the imx8mq */
+	case MXC_CPU_IMX8MD:
+		return "8MD";	/* Dual-core version of the imx8mq */
 	case MXC_CPU_IMX8QXP:
 	case MXC_CPU_IMX8QXP_A0:
 		return "8QXP";
-- 
2.45.2

