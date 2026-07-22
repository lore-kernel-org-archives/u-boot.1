Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B835C4452D
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 01:37:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF44D80ECB;
	Wed, 22 Jul 2026 01:37:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AKkLBuq-GELb; Wed, 22 Jul 2026 01:37:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E05E180EA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784684235;
	bh=9fSgqnD4yNe/OPSXxWGaLrDIHWejbh0BzlC8MJnVDlU=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=y1d+sKuFc5HQ7R3DeCc1xMN/omIfikiprffKZLcfj1LCA3CRHMaah76AxxKHGxZ/l
	 /GBBAOm7+o5shqdpCnB/odLJ9a14EgUv6Sdi6GjR/rIP9qEVMJf76WVEyGJyHHq0ol
	 x3dI4lgabdL6nfzOHH0KJWJ1K4tSiyC0PN/CMKTGAKZydigWalAc7Dm/8O8I6bANhy
	 owL/p98Ji4gXtmF/QGjnuUap6MHPjA+AgeIeLASMpf76dzC8V8q0DH/PBco5TjANqv
	 Tki8WVN6k5VZcGfJ2yN3KvxfYSrnWLWWJyM1aswFq8LNf0pZuFbcQUpHvIIXb/nP+8
	 0tInV//92FdgQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E05E180EA1;
	Wed, 22 Jul 2026 01:37:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DE08313
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 01:37:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 04A684071D
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 01:37:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C3ugBRlA8NyM for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 01:37:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112b; helo=mail-yw1-x112b.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E1DFE40719
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E1DFE40719
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E1DFE40719
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 01:37:11 +0000 (UTC)
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-81062fdeaf5so51074607b3.0
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 18:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784684230; x=1785289030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9fSgqnD4yNe/OPSXxWGaLrDIHWejbh0BzlC8MJnVDlU=;
 b=pLXIn/YX2JLH6NRVY5n09yPMFlFcslrWrk9L6Xd+xjaQq9gldUvcmlOXhhCDE/GNtn
 LT+yI5n9UW08C29eY2J/zUjsxMNgyVAmYbOG6KG9Z1uOvFfgz+u6Wun4fOVaPnitUmLD
 XNoLu/E++znEv6vc9menWFn2g7KBIeDHOherslTVR52vdsSh7abIMhXOJaiWaWmvAyuA
 aLIMXIqirbaytP9fQCeOk4nd3PcRDhzFxLs8rOry8m4o5rWGMQ7I+m4ZV7kLU+o0Vs+t
 q4OO/qgwi4tNAcAv3e4XFdESeulEl36V7qYg+Ou14SApk73r/Llkv1MaZ/K3SwlsUwdM
 G8Gw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUsfJvbi1hKoRQwa6ZMf9Fy6nL5tTimAiEQSL2kT7mq/2K3oNooBS1fMbo1zHHPUThWEy3cKU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzR63cKGsGvAdocfnLVWrM9UkKmQZ/loi1kjd84xkx2aYcLkief
 jmnteP7fiYL6QQPQRdT9vU0arBc1D+V1ekLVnKbHirHQY9CdKvSeeA5+s8BjiQ==
X-Gm-Gg: AR+sD12Rb8UH+6Kt8O9MZx/l4OcCFsLu5aQIWkvpxzsjpmhzeyIBtAeIv4ikewF3+oL
 qRtvEMzzhJELu6Spn0F+PoGXGLfJikBzhlYCjHYUTL+99y0y98n4V3semlo4T/+jpFojq4pH0Ra
 9c/g5kXg6IF2pie7MM/RzfaA9hXpO+dYAp1YULTMvSLh2y90Xo1GliASuWZpsXEW1A0z7pqGGUH
 9H85/F6r8qMUBAb55I2rEkT5ozxYH9eHb/EJqDwRdtHVoUAdwTPrevhgtY9hAKS1zTBKR2GP7i7
 24+C8YNPUy/9lpK80Zhb4f19Qe2kF8EfZil3K0PVdjtWEfZi+IMlnBh0Aj1IMzmOctwpZN3ahvN
 TOlmFzfryx3whBYi5JateXEU6Z9Hqtn1l54PdBmg0Tk0kjmaMYTWetOMJYz6PuqYAQVK6Jp2cxY
 X2sLhkj6YDfhGW3M4rOWJf6+K502KdIU/McMQ/E22YeQCVE4Y=
X-Received: by 2002:a05:690c:c513:b0:81e:c38e:4bf3 with SMTP id
 00721157ae682-81f33d34513mr5731567b3.26.1784684230570; 
 Tue, 21 Jul 2026 18:37:10 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:1b3:a801:a24:1ad1:7a2c:313f:6408])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81f33ee52a0sm6372937b3.36.2026.07.21.18.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 18:37:10 -0700 (PDT)
To: u-boot@0leil.net
Cc: djw@t-chip.com.cn, sjg@chromium.org, kever.yang@rock-chips.com,
 u-boot@lists.u-boot-project.org, trini@konsulko.com,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH v2 4/5] rockchip: rk3399: Enable UMS on ROC-PC-PLUS
Date: Tue, 21 Jul 2026 22:36:41 -0300
Message-ID: <20260722013642.1011666-4-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722013642.1011666-1-festevam@gmail.com>
References: <20260722013642.1011666-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784684230; x=1785289030;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9fSgqnD4yNe/OPSXxWGaLrDIHWejbh0BzlC8MJnVDlU=;
 b=OtOqSCFlLs+cvk+qNdz9pS8FJwdjILNtR/NTd1osCmjv3WBrvCdbfjw/zTxFjoICM1
 hbefLiu22VdnuVZG1fupo0vOP65NBr69DIJkaZc8pncvYqaWUWDW/L8NAfYSnqp6CllE
 BFUTx55aJBkpQuRnmsWur5qlbxVcwBgG0cWWtrgzt8duBy2OSF3zrCiT/PssyXiEzBrT
 /gRBFV6Gs0qz98JyBfkP/ZKeNE5oANYGxpA3Cu/N1WEdhvsaYDspZEGrYfuXS+9J12FX
 TxzEKXaO/TM+YC9JluwnPSOgkZiyQ7pkbMnk6AUvJtddJSFqoZo4ICDoIsJ2KUbrsZzm
 Y6lg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=OtOqSCFl
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Fabio Estevam via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Fabio Estevam <festevam@gmail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Fabio Estevam <festevam@nabladev.com>

Describe the USB3 OTG controller as a USB role switch and make
peripheral mode the default when no external role provider has selected
host mode. This retains OTG operation and both PHYs inherited from the
SoC devicetree.

Enable the ums command so the onboard eMMC can be exposed as USB mass
storage to a host.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
Changes since v1:
- Add the same OTG description as submitted upstream:
https://lore.kernel.org/linux-arm-kernel/20260721030043.84691-1-festevam@gmail.com/

 arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi | 6 ++++++
 configs/roc-pc-rk3399_defconfig             | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
index c80529a62b97..73027335446e 100644
--- a/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
@@ -1,3 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0+
 
 #include "rk3399-roc-pc-u-boot.dtsi"
+
+&usbdrd_dwc3_0 {
+	dr_mode = "otg";
+	role-switch-default-mode = "peripheral";
+	usb-role-switch;
+};
diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defconfig
index 6ef447e0e715..127b71e97917 100644
--- a/configs/roc-pc-rk3399_defconfig
+++ b/configs/roc-pc-rk3399_defconfig
@@ -36,6 +36,7 @@ CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
 CONFIG_SPL_OF_CONTROL=y
-- 
2.43.0

