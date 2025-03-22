Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C5EC35FFC
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 18:39:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D82881A0E;
	Sat, 22 Mar 2025 19:38:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="huicjJ+E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67E9081D5D; Sat, 22 Mar 2025 19:38:49 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 488198197D
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 19:38:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7c5ba363f1aso292838385a.0
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 11:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742668725; x=1743273525; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dIVOSOLE6qnf5yjKl7tQp0EWbtAShue9l6N54KQkOWo=;
 b=huicjJ+E39OfGGAJ02aFxdNfHPVmjtvDR8dtRx9m8UHvhgeXpKwgcqOAUYCvNR2Qq2
 UEnGb5SABV5GNWT+tGAJR5agejEO3bIT0FmnEn5n8SAQegJ+sPnKlXUNMP/jWvZud7IW
 8c0u/P4pytnhpUA2AeCm9zDlpLd9Qh7hNMYAX7bo3PchibPsG086QInEx+NScd63PScL
 NN88afyu4KsKg+u1xsKzWVhljqYKvhdx0GL/T1Q8paBsR4erfBkb29nHqoAYDteQD7jV
 kO+dlbXxcBOuHUm3glJqLarkzeptmCmZiPaT3wIroJuTFFGvQCIOZt4kVLJO/XcBLxu1
 GfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742668725; x=1743273525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dIVOSOLE6qnf5yjKl7tQp0EWbtAShue9l6N54KQkOWo=;
 b=boV4SkT8t7HVQlANNDdZFdiqs7WsL+jH14QmK0/Zv3eHyWcRM0n2JOC4+DXKsV+Dct
 Y4IZWXNMMwSoklEFzrLgK/jB7VBFxbUFj5mqnRFSBLIcScUALiGhdH6db5Aulhk7xMmr
 BprdRqnoBSNs3pG+3anu82sUe1gONVhlOq8SnZmvoJmvAi0ZuYVq+lxAj2FJLTQsQSd0
 Aq0fWrvGC4VXxeyRAvkSnzUS/eUlFaIsjf2eJsXrYaTEQOGHrXsi7hjFfJI86DkXYRam
 +w9gxMSGSR99uoCvpvShoxb5iSH3J9rvZcyWhSBv5tmabm3Aw4axFz4PQuSWtsyBSuJq
 nrcA==
X-Gm-Message-State: AOJu0Yy0uKAn7CVN0Nrg88aMhSzPJv0wgtrdXdXgea/ilnL/l7GGC5JI
 LxvlyLRGT+sljmWtOseyKWzBhYx7BqOOYZgh+epivI2RTnn2OhEhBzpNnw==
X-Gm-Gg: ASbGncsbGKOhlAJRndtBjwKNN2kvdImKnw3gVquTcblWBnvHBQvziwdNqJpTZAiP/Er
 MFLv+zZwD44ATZhIAqHLwsBHS7wqx/71x1Y75Q4O6fDlf2c3KSYLB0rbaswAsZGGpKzdJrS/T2k
 gNj/Vb5e3TTr4E1/bwTRqMIN9eKcOBrF+idlK7xudEZBVS8D3DZvhHAGMuNvgzjZfFlK+xwTJxB
 W9a2VdjxoTHbtZUDnzCdZ1EIlZTmOf1OW3TWYyDQvqOtvEEq6vPngCaeOFcZs2ITzhxKs4WvCTg
 Q0Da+CfgK9vRROk0r0wKeXpkfY1h8XgXLbYm6oaiNXjf5ZvEfSH9h1Inhqpwa3XeFURzdtIM74P
 wc9bi4ri8knBrrh0r2Zk=
X-Google-Smtp-Source: AGHT+IGJoyNlxsINsfoCmB7VKUmQOlb+6XE7pXaHSRCKdwHRrOOFAEmZOjR8Xcswf7v28F4OCz12lg==
X-Received: by 2002:a05:620a:2405:b0:7c3:ca9d:210b with SMTP id
 af79cd13be357-7c5ba1337fcmr1123746885a.6.1742668725623; 
 Sat, 22 Mar 2025 11:38:45 -0700 (PDT)
Received: from aford-System-Version.. (c-75-72-162-184.hsd1.mn.comcast.net.
 [75.72.162.184]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5b92ec648sm278126185a.61.2025.03.22.11.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Mar 2025 11:38:45 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: u-boot@lists.denx.de
Cc: aford@beaconembedded.com, marek.vasut@mailbox.org, festevam@gmail.com,
 Adam Ford <aford173@gmail.com>, Stefano Babic <sbabic@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Peng Fan <peng.fan@nxp.com>, Yannic Moog <y.moog@phytec.de>,
 Sumit Garg <sumit.garg@kernel.org>, Gilles Talis <gilles.talis@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ye Li <ye.li@nxp.com>,
 Wadim Egorov <w.egorov@phytec.de>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH V3 6/6] imx: imx9: Imply CPU_IMX by default
Date: Sat, 22 Mar 2025 13:38:08 -0500
Message-ID: <20250322183812.784676-7-aford173@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250322183812.784676-1-aford173@gmail.com>
References: <20250322183812.784676-1-aford173@gmail.com>
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

The imx8_cpu driver is a CPU Driver that supports the i.MX9
family. When it is enabled, it acts as an alternative to
arch/arm/mach-imx/cpu.c, but the imx8_cpu supports the driver
model where cpu.c does not.  Imply this newer driver by default.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm/mach-imx/imx9/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index c3e758e103a..579432a47fa 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -11,6 +11,8 @@ config IMX9
 	select HAS_CAAM
 	select ROM_UNIFIED_SECTIONS
 	imply IMX_TMU
+	imply CPU
+	imply CPU_IMX
 
 config IMX93
 	bool
-- 
2.45.2

