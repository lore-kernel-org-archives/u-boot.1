Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC02E95A8E
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 13:16:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B64F86B7E;
	Mon,  9 Oct 2023 15:15:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hFNzvzQD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B38E864A7; Mon,  9 Oct 2023 15:15:53 +0200 (CEST)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24932864A6
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 15:15:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c746bc3bceso10020265ad.1
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 06:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696857349; x=1697462149; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ykl7+QXYhv+gIqf+fZ0nzzp6jq5wmREVP6x41KuZG0g=;
 b=hFNzvzQD/xfVdpmRodYWpKOwhWAEzy9GdxmBoXqI0nNud+m4MTEPqLhihKySygIjoq
 WhGzsPcmjtyw+vN1lqo5rG6Suo5r4yNvDOBWTc+HM7OBe8R/deHFp/dCmU7HXG/UQXzs
 YmWuZOVy43do5wlT6LAHQ8LkcWsTFEodInbZtRQj3l9hvqZaCqIt4/jSFr68y08WHqDX
 vhGDvY3JMjprdKtw3+ZwJN7MtklcGhncCggdZ0nP1l7g9vBDLPO6WTbePKVI7ME0z6VL
 0B/P1gkVinBbALQ0ewK24yEzX1rQjp+UaaqrIBSt8SF71Pd6XdOwAO269pZgxEg7HK6K
 8tLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696857349; x=1697462149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ykl7+QXYhv+gIqf+fZ0nzzp6jq5wmREVP6x41KuZG0g=;
 b=lKZ0o5gwLEepV51LbNf/FAcdNDGVbMk2jUfsx28hgIc56dElTomEFJz/+lckthdtSB
 3PtdUP/nTV64RgFzXOcwgUJae0+s2H41iIt4sppABljP1Q777q5yGzEew8Djnr5H7bpB
 xzG7RCs55QML2owEOwaJDvsvqRFM1RFzK8Gp6iQVA+A0LMT3Sg+/IIW7bTibV//3wGRJ
 bGfG1nIZYHzCUpHwayDBjS1m017dSRnANrxulNTQBvvFxa61ojq0lTeL/XBOldgdvwFx
 4WvvHaMLrQ/PZETjAKA2mfr0bAFasnXdPy25y5CGuSRDJF0SURyiCFETw/9sKdrOh4bK
 Ah4g==
X-Gm-Message-State: AOJu0YwZ580x0KFtCa3RhibD8k0veJbGWppJhRRvoMyF71vt8wFW3G2C
 ZMZ0YAIlnzrH2eAd4l9J8rI=
X-Google-Smtp-Source: AGHT+IFHA6G8uadvJi6d7Wqr867UDgDUBOWPTnn91I79iugjnZBUDJuLrSkC1soS0oLDXcgpxQutew==
X-Received: by 2002:a17:902:da8d:b0:1c1:fbec:bc3f with SMTP id
 j13-20020a170902da8d00b001c1fbecbc3fmr17317098plx.5.1696857349354; 
 Mon, 09 Oct 2023 06:15:49 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:22d5:b586:66b8:6e03])
 by smtp.gmail.com with ESMTPSA id
 r10-20020a170902be0a00b001c8a0879805sm4743965pls.206.2023.10.09.06.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 06:15:48 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: marex@denx.de
Cc: sbabic@denx.de,
	u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH v3 3/3] mx28evk: Add USB Mass Storage support
Date: Mon,  9 Oct 2023 10:15:36 -0300
Message-Id: <20231009131536.3475878-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009131536.3475878-1-festevam@gmail.com>
References: <20231009131536.3475878-1-festevam@gmail.com>
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

Select the USB options to allow running "ums 0 mmc 0".

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v2:
- Removed further unrelated options. (Marek)
Changes since v1:
- Remove unrelated config options. (Marek)

 configs/mx28evk_defconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/configs/mx28evk_defconfig b/configs/mx28evk_defconfig
index df0cceaea719..4058d08f961a 100644
--- a/configs/mx28evk_defconfig
+++ b/configs/mx28evk_defconfig
@@ -32,6 +32,7 @@ CONFIG_CMD_DM=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND_TRIMFFS=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_DATE=y
 CONFIG_CMD_EXT4=y
@@ -65,3 +66,11 @@ CONFIG_RTC_MXS=y
 CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_MAX_CONTROLLER_COUNT=2
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="FSL"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
+CONFIG_CI_UDC=y
+CONFIG_USB_GADGET_DOWNLOAD=y
-- 
2.34.1

