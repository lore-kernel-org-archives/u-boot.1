Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EBCC369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 17:39:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 223D582958;
	Fri, 25 Apr 2025 19:39:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S70MNXBU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BFA6829C7; Fri, 25 Apr 2025 19:39:15 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A24B48291D
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 19:39:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ff6cf448b8so3517137a91.3
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 10:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745602751; x=1746207551; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YioYxKr/GyFEWMK8mddwd4trF5iaYox7PauIMSpN2Hk=;
 b=S70MNXBULgh/e8HQuCLkhMSPgG/AhZQSDW2kJcC1aYKavhP9kWd9Cedd4JNMJeKTRI
 nmV0UL6+IHPsLMIpM5JHLBCP48Mg+BoDiMaaYKgoiRMgf7nJOYvBoIFpy3wu30fPu6nn
 IYjwwgoRmYRP1ySTmSAFa/oA+7rbjL+642dyoinfK934j6XxUMkMN7uCPzsjzC7g4Sml
 LT1TxQKp+J1XE6dXmPCgxmrmK77+FKRBrly5+vFqYdxfA2wWKGjPko0/BuMFnSALvIoP
 SSnToOJbvOZ69Ae0pAPAqd0jWNCVjXdKjs8VnRN/c//lrJ0DbZgl8Q+FC6WltD3nKCC0
 VAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745602751; x=1746207551;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YioYxKr/GyFEWMK8mddwd4trF5iaYox7PauIMSpN2Hk=;
 b=Rna8lalqDuXW0b928OaloVVnukYdl+/mkCnAYZPixDlJ+S57ukn6O30BdEOBQzGVvN
 MMiqceOTEGLZjLYT2Q/HUm+NaJltVu9o+lFJqTVnR9rqkb3pdQGWmNt070gvpfRbv8nh
 u9As6plkijR8wZ9YV7qDUUbq88HH+HGpl6SPV+AI5mzYGjIHqwqf5+eDTuyYTkk5ssJL
 TfKZlLyER02HI2I46FLI0CmdZ5/C87i7iQcjUL4twGupio5s/3FSCOssL05r2VAd3OV6
 yo0HCaDa2QVdUHtlmy/Lbk9DNmJh0F4fxVukb8KomlvcUyIi3JCrtsD0GYdmly8ozmzw
 cxmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGoRepo3C/yoACwU2pbz3UofRMRZPVg8MEl+JELujn7kP198j8B/IrDQ/LFGSe2C6ecINKigc=@lists.denx.de
X-Gm-Message-State: AOJu0YztYy+E4TL6GY0tGgKM/dSOJzTocpUmUpzOeE7UnTOXPs2R+k98
 gdrdRCMzr8h2OL6H0oGtq+UQyhackcbm3T2GQFJ6bBsXHag3T1t7MFZ+6g==
X-Gm-Gg: ASbGncs/GLYBpfC2jjVoe7JD3vCfTC+T6THOqpRzPshgp9JC2cOGz6Rs5garfkEV1I5
 o6S80ncp2j4SgdCqpwcdmrYPn3es/qE7J0vYVxM7I1ddMVHfOvndDaUwtqsd5G5oMDnjwbADthW
 Z4x11j3lTHKvqtFM1aRuQhNklavTtpMbsKC5kvD8BKC7AA2vZHS4paHbmbkEiazs1d2fqvqQfcr
 kRfwq4LSh1GEQGby3awDUeSPFTsskfR0GoJz3XoapO45zCTnLUeRBVZpanaBJu4XwxfDHJrdD8R
 1zwv/BPohm3gbcsgYs0tjm8IwX6Sbvi3pheY6BmzDfTFKSc+Tz7mHBZ1z3ewDKzc9g==
X-Google-Smtp-Source: AGHT+IGhrhM2mrdgrNz1Y05Z0sGB8TpQhDy8/+F71s759tgBW0QUEY04mVrJEJGciXRQ/xd4X/CAyQ==
X-Received: by 2002:a17:90b:57c8:b0:2fe:8c22:48b0 with SMTP id
 98e67ed59e1d1-309f7dfddc6mr4967626a91.15.1745602751055; 
 Fri, 25 Apr 2025 10:39:11 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:6fb9:f343:690b:2e7d])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5100c70sm35308465ad.166.2025.04.25.10.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 10:39:10 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: marex@denx.de
Cc: trini@konsulko.com, aford173@gmail.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH] arm64: dts: imx8mm: Make osc_32k available in SPL
Date: Fri, 25 Apr 2025 14:39:01 -0300
Message-Id: <20250425173901.1965597-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

Since commit b4734c9c333b ("clk: imx: Convert clock-osc-* back to osc_*")
SPL takes a long time to load U-Boot proper on an imx8mm-evk board.

The reason for the long delay is because the osc_32k clock is not available
in the SPL phase.

Fix this problem by passing the 'bootph-all' and 'bootph-pre-ram'
properties to make the osc_32k clock available in SPL.

This also aligns with imx8mn and imx8mp-u-boot.dtsi files.

Fixes: b4734c9c333b ("clk: imx: Convert clock-osc-* back to osc_*")
Suggested-by: Marek Vasut <marex@denx.de>
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v1:
- Sent a standalone patch that makes osc_32k available in SPL. (Marek)

 arch/arm/dts/imx8mm-u-boot.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot.dtsi
index abb3aa5b6354..59453dc36d31 100644
--- a/arch/arm/dts/imx8mm-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-u-boot.dtsi
@@ -240,6 +240,11 @@
 	bootph-pre-ram;
 };
 
+&osc_32k {
+	bootph-all;
+	bootph-pre-ram;
+};
+
 #ifdef CONFIG_FSL_CAAM
 &sec_jr0 {
 	bootph-pre-ram;
-- 
2.34.1

