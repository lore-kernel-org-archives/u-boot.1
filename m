Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81CDC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 16:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 253268867B;
	Thu, 18 Jul 2024 18:55:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lD3y731+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4902D88AD2; Thu, 18 Jul 2024 18:55:08 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28222885F5
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 18:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70b04fd6d2cso5826b3a.2
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 09:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721321704; x=1721926504; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PSAb1jnBZLwlRxNCGO8kaAdmrOdqPYGu5qqyDBUKx2A=;
 b=lD3y731+6BSFRVRVZ1IsmWW+ntxZ9PQRElLRrKM/DdrHI0qnLR0iy9dKwqvFqyTqiM
 cBCGdlUKrdz5E+Bd7mIkoKyk2npi1GX9t3rJHc9xprjLv0pFXt6Ha3fWEINqGI/izli3
 mMwK9W+wH+rFFo2wRy7AJsKER1ULRU55Hmvc7qI1PqmoittLBiOojAoQwSL8cF9+iiHL
 28DtiQafrC5sYXsCOppcbO6mlDRwJf0eHV/6dJ9t0MyAAAa+9TOcGoRxefnpUY02G8nE
 H4VTZhzUWFZGtz1uAE4wbCajDrCTnh2qc5T+PZ2mJ98OqdWDmk5PHtdDY9SflceWUhwY
 uFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721321704; x=1721926504;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PSAb1jnBZLwlRxNCGO8kaAdmrOdqPYGu5qqyDBUKx2A=;
 b=ckBZ7w3xVYcg3WO8KQFH65eRXlxjEbKTPtp8Cn0ZPbmm9mI2PXjols1PtXcruJbO/5
 7p/nuF2UD39qqqFwBrkj/W2OH/xaXlaqSlZLrDqD4YKFZDHlefGRqFHAVF7v4ezJlWMl
 GJ5hB8MZGKCuVFQnR8/LtoE1oPpUAxB48dSahCdEI/i1G8Db/evMtSjSm8feTJrfTZHq
 v1jjhbiplm1jqgF7ER6XP5RtTaP+9BBcE1D7hfLPR6GujzY2eHdCa5j8sSSGTxG/Ziav
 bfq7KP3P+x+oVjDdIOnbyqorWpLXe0acgr2QJwnPF7Bc+K2ZuAYZAHpfRm1IbNOMHlHX
 rVzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB18lzMSA4MTggqtOM04n+jIhywmcjxFQu4eFkcEpcFkZKmnavI7LYZZE/+vYIjYL+pK5RYvaMbPgEfs+yTRUTCpeNEA==
X-Gm-Message-State: AOJu0Yxv/mgsf7/ExDYcTIldLAYLnwgGvHxpFLotePdW3EvORHb2Ecbo
 gTHxVfL7Eb3iZXwhrw7K2zOqBO+P8FwIy15D9aqxcTe50zKZIU7/
X-Google-Smtp-Source: AGHT+IE00qDa/t6cp6NCGnSpuQfVl3w45VyVmSYDk9SNoXh4hR1AS3dS3LN+nOAksvH9C8RAW9T5uQ==
X-Received: by 2002:a05:6a20:cf8d:b0:1c0:f5c1:8071 with SMTP id
 adf61e73a8af0-1c3fdc86ff3mr3734704637.3.1721321704564; 
 Thu, 18 Jul 2024 09:55:04 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:bc92:63f4:6f0e:1985])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70cfc6dfe6csm48791b3a.4.2024.07.18.09.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 09:55:03 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: peng.fan@nxp.com
Cc: uboot-imx@nxp.com, m.othacehe@gmail.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] imx93-u-boot: Describe the CPU clocks in the devicetree
Date: Thu, 18 Jul 2024 13:54:54 -0300
Message-Id: <20240718165454.904763-1-festevam@gmail.com>
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

Currently, there is an error when the i.MX93 CPU frequency is
read:

Could not read CPU frequency: -2
CPU:   NXP i.MX93(52) Rev1.1 A55 at 0 MHz

Fix it by describing the A55 clock nodes in the devicetree, like done
on other i.MX SoCs.

With this change, the CPU frequency error is gone and it can be correctly
retrieved:

CPU:   NXP i.MX93(52) Rev1.1 A55 at 1700 MHz
CPU:   Industrial temperature grade  (-40C to 105C) at 35C

As the upstream imx93.dtsi does not describe the CPU clocks,
keep the clock node in imx93-u-boot.dtsi for now.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/dts/imx93-u-boot.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/dts/imx93-u-boot.dtsi b/arch/arm/dts/imx93-u-boot.dtsi
index 289aba175843..b2b3d57318fc 100644
--- a/arch/arm/dts/imx93-u-boot.dtsi
+++ b/arch/arm/dts/imx93-u-boot.dtsi
@@ -9,6 +9,14 @@
 	};
 };
 
+&A55_0 {
+	clocks = <&clk IMX93_CLK_ARM_PLL>;
+};
+
+&A55_1 {
+	clocks = <&clk IMX93_CLK_ARM_PLL>;
+};
+
 &binman {
 	u-boot-spl-ddr {
 		align = <4>;
-- 
2.34.1

