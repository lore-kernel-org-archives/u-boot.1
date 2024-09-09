Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0992ECE588
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 19:30:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7BAB88D08;
	Mon,  9 Sep 2024 21:30:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XbmnbQPj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD9FE88E13; Mon,  9 Sep 2024 21:30:15 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A310D889C9
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 21:30:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7ae3d7222d4so3944466a12.3
 for <u-boot@lists.denx.de>; Mon, 09 Sep 2024 12:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725910212; x=1726515012; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vfsel9a3yBCySK/wqYJDE9QCIVci9yyD86Xf0x9DJvE=;
 b=XbmnbQPj9Yusqp1LmQHhmODbUlVzCpwwBUZyWOeJ/AFRBjFxjA1JPX2S5OrI60S5Go
 NH5cluvWbcWDJLwNHFmKwFg3oN/u0mkwR4KYS1WO/PNUfnFmE1OKbCCXsyKbU5VTGbKD
 Qejl03l8asvqPNUl3K+P8QiojdnBGvmGaY8YWmB5H6qQCgjc1HF8mrB6gViQPDpSDaCV
 qIQjkofE/geuvWd17QOoRvMQ9FXWBOCGk+LoenF7pjAsjeZDB3qRgm83iPOnKfVybqES
 8sUEcSm+N8MIdSjYJ0G/SagNbamkArnWi3GmtMEKLMQE0YK6CBOvQe7su8SgK5oMHkpp
 39RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725910212; x=1726515012;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vfsel9a3yBCySK/wqYJDE9QCIVci9yyD86Xf0x9DJvE=;
 b=e8hO9RKzAC5KFsUMUgBdjhqTrYASuTCBZBdsFr4m++ngQSWyrHqtxKB/8TYsN+8Sdt
 lufpxefbXVqv/owrXKpaY4Hv8DgFVnX7egXaJSmLJN+c86iz1t0YufTMe56v2KxxlQ9E
 AcIlAgAqZo+WMQIN4XOofG6zc2iFkMJ7tplQY8x5S9HgZ3JksfiCzYXLqqHEGu9WnKB1
 krVRjPgYl0lWrlTURVKuT9rn01PtoJJRDe4PBTpt+fU2aGiIfwGBCnpVob9uSQv7MS3/
 vtnzoGZPleI5Nk58pr2AEGMKtuKT3VhmDHPA7tOToQjYgWRP3ibdEv6AtcfYZecLsWwR
 N/oQ==
X-Gm-Message-State: AOJu0YyM0ETqpJp9wcaghKxGtQuOzf9fcbSMJKS1mKonzOKDn7UhjAQN
 wjVXyJh4iJ6UP021hnrPczF+KUk2W4f6RbCF8uLgzMK9Hw2LbdHkjY6wjw==
X-Google-Smtp-Source: AGHT+IF+l4UpefT92tQy8y7LgSWguo7yITdEZ43nr/P48KiQBXgnKAQdXoueppDBRIGZmGJgEOF2yQ==
X-Received: by 2002:a05:6a21:478b:b0:1cf:2d44:1f2d with SMTP id
 adf61e73a8af0-1cf2d441f4bmr10052008637.38.1725910212007; 
 Mon, 09 Sep 2024 12:30:12 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:953d:9fc6:a5e:5881])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d823cf3a6asm4347075a12.26.2024.09.09.12.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 12:30:11 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: marex@denx.de
Cc: u-boot@lists.denx.de, uboot-imx@nxp.com, otavio@ossystems.com.br,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] imx8mq-u-boot: Pass FIT offset to fix boot regression
Date: Mon,  9 Sep 2024 16:30:03 -0300
Message-Id: <20240909193003.707732-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Since commit 37e50627efac ("ARM: dts: imx: Convert i.MX8M flash.bin
image generation to binman") the imx8mq-evk fails to boot:

U-Boot SPL 2024.10-rc4 (Sep 09 2024 - 16:08:22 -0300)
PMIC:  PFUZE100 ID=0x10
SEC0:  RNG instantiated
Normal Boot
Trying to boot from MMC2

Fix it by passing the offset property for the FIT image, just like
it is done on i.MX8MM.

Fixes: 37e50627efac ("ARM: dts: imx: Convert i.MX8M flash.bin image generation to binman")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/dts/imx8mq-u-boot.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/dts/imx8mq-u-boot.dtsi b/arch/arm/dts/imx8mq-u-boot.dtsi
index e1cd6f8996dc..9b895a63857a 100644
--- a/arch/arm/dts/imx8mq-u-boot.dtsi
+++ b/arch/arm/dts/imx8mq-u-boot.dtsi
@@ -111,6 +111,8 @@
 #endif
 				#address-cells = <1>;
 
+				offset = <0x57c00>;
+
 				images {
 					uboot {
 						arch = "arm64";
-- 
2.34.1

