Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645C6C71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 11:50:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B3A582C49;
	Thu, 12 Jun 2025 13:50:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Okrnvx8+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F25082C4D; Thu, 12 Jun 2025 13:50:33 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 113A482BD9
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 13:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=heiko.thiery@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-604f5691bceso2036029a12.0
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 04:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749729030; x=1750333830; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xnn/F4EmHY25MKaMFAODq3YRa+JVpBeXzetVL7xAt/w=;
 b=Okrnvx8+c1+6KqId1O0plDIM6WXVrn9+xil9RG1QMwRUCiT1el1kcrKrB42CUWiyO4
 FF+evij4sxnNOemc70a5/8JigWaoEizXzrCNhN2M79+JBTxaypj/HwTU8L7X9yOFHLnc
 xuETTEpGMDyVDbqPQifQGcSw80a5Cx9fQujXi5H1duqNCrzCIRYPaAGnnGhMUFV+tZmx
 nGfnYKyJ4IuzC5Xty+rNtuNQnWkPbzDxwcLezYFGD3TSb6ueqpSVYuEZalAstALfmUSi
 2Kej2x5w881taHLvmmLcd8LFArOh7f18PCwpepd1uBvKICtUcQTsBU8Mr3650+pjRlRu
 4Q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749729030; x=1750333830;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xnn/F4EmHY25MKaMFAODq3YRa+JVpBeXzetVL7xAt/w=;
 b=XLnNn+0/2kaKjznrLFhl06CFqhl1Dp/rOq3wTmoUNIwHCL5ZUv3G7qn9I7lWqkcxLe
 Y6bolQIYtQDUJf7XikHefCyPcJOMtq1qrrZrZGlAlZ+xoj0CgcFZW+WrIFsyMFgfaDoy
 ddrxpBTxkS2A8b7drHVRm4DMIkEy2SmLxd/eSkGlV0wIm0kQIJlr4p+93bRSDfdJE2LA
 tFYZ36+qapDLf4Py2JT1ZQEcxClPHG67uWZ3N0GVmJSjZc5z8GfRxoqaVMa1DOkfmbwQ
 36RaMJ/CQaL3edWio3cEixJEGTKYGFPa30BqHFPCB/tzNrCrs4aQJGlTn16q6Cq3YJ34
 Jvrg==
X-Gm-Message-State: AOJu0YyUuW5xm5lNK21d2pDrJXGBtPRSxNrdC9GKqhSdStPs0c2Gsa7o
 mVX6Oxo6VAncZWBL/YMfaFYShs9X3GL01Tc3YppeTybJtaUFNGOzDS4KoZ1+34nq
X-Gm-Gg: ASbGncvlNVsKKb1/szzPQZ0Wec0vWcXGyU/rGbQLcXbv194RZ+oDyPIaMENr+jOmPMk
 DWBGSxcgRkj0wk8yOYkv9i/zRPoYDOYDqChPR/o9Hq/gQ731Fm0wJoXd+XqL+Tqc5L7T7GEBz3c
 Z1r8klDcP6mGH75gmc36gF66QM67kpFmmG/YWapFTF6rmmASKBIPLDJ0l6U1NVCOy7vUJJJPm6R
 7Cz6SLW9TOkjH12HZJrS6ae7pLuZrf3+7Jz1WnjneIswrTQp48E90YtHSDxg+5ku/na9lvpbvQT
 KU+VdEsLk24xxfjQ8VNNK5A8l2d393CiZG2Y/l6V6SIQ/pNsJTu/8aEmo41q1tAGzehuzwqLipv
 zQBc=
X-Google-Smtp-Source: AGHT+IH1Jvl6T+NxWIFuHjKcFjWwGmQnmnkmPjZSF+aM2pyfnNreDVWIlXPFlxcx108UJTmc28Bapw==
X-Received: by 2002:a17:907:9447:b0:adb:33d9:67e5 with SMTP id
 a640c23a62f3a-ade89734f5cmr778671166b.38.1749729029614; 
 Thu, 12 Jun 2025 04:50:29 -0700 (PDT)
Received: from hthiery.kontron.local ([213.135.10.150])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adeadb8b74bsm119824166b.124.2025.06.12.04.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 04:50:28 -0700 (PDT)
From: Heiko Thiery <heiko.thiery@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Udit Kumar <u-kumar1@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Heiko Thiery <heiko.thiery@gmail.com>, Keerthy <j-keerthy@ti.com>,
 Bryan Brattlof <bb@ti.com>, Michael Walle <mwalle@kernel.org>,
 =?UTF-8?q?Thomas=20Sch=C3=A4fer?= <thomas.schaefer@kontron.com>
Subject: [PATCH] mach-k3: j722s: enable caches for the SPL stage
Date: Thu, 12 Jun 2025 13:50:15 +0200
Message-Id: <20250612115015.266601-1-heiko.thiery@gmail.com>
X-Mailer: git-send-email 2.39.5
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

This is same as done in 27cd65ca1bf1 ("mach-k3: am62ax: enable caches for the SPL stage").

This is resulting in ~2x speedup in the A53 SPL stage.

Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
---
 arch/arm/mach-k3/j722s/j722s_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s/j722s_init.c
index af211377e7c..591aa1d60d5 100644
--- a/arch/arm/mach-k3/j722s/j722s_init.c
+++ b/arch/arm/mach-k3/j722s/j722s_init.c
@@ -162,6 +162,8 @@ static void k3_mem_init(void)
 		if (ret)
 			panic("DRAM init failed: %d\n", ret);
 	}
+
+	spl_enable_cache();
 }
 
 static __maybe_unused void enable_mcu_esm_reset(void)
-- 
2.39.5

