Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51706C47DB3
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 12:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B3D787BDA;
	Wed, 31 Jan 2024 13:49:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="Br4NP7t2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DE1C87BFD; Wed, 31 Jan 2024 13:49:35 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B64787BC4
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 13:49:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40faf6788d1so4942105e9.0
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 04:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1706705372; x=1707310172; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4wW3SyTaw8jdBLrMQYVF5f2gYEg5VAJpl07mBsLOeCg=;
 b=Br4NP7t2sG7QYg06Uq6SO2mTrsVBV3yQ7ofFWM1T6yOIXkGxWz5lGYNQz72WZ+pEnu
 IJ4XRr+uKrxLRvmCZyp4f78KyJfDBYyPOaYhDhWC/XvT0gZKtr6YrjBqpGq7u/Qlr3HF
 KPa3f5DIoG+35hadSuNsE3i7WBoPJwLn/kGtFVwHCKEAkPi8uAwiQftVDNzhupKCB3qh
 rPnWfiKE6/xqud+Fe/ktLOk/XQKBdmP0r4aQk75EdWiKn6lHUQ6Ry+qAfiHBDjlHQamS
 PvfW7HT4PWYmADWceI2Un/AsV8d0LnHqwEOA/g7wix0Mry8sQ5B40Dimgw5smlEJyXPc
 3RXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706705372; x=1707310172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4wW3SyTaw8jdBLrMQYVF5f2gYEg5VAJpl07mBsLOeCg=;
 b=ayfhRqpmTDRkVnPiWX1C1T6u499yiubvLEifaL6/CU8eOCgwUh6ATi8jlFQBNiTCWz
 t7OQqH/1F32RdZLrNwTk4O92RSHMYLans0s/HKH7qvuWce8EcY7POTLUMtr6BYnyGg0U
 eua+OsR8vfGcbh70Y2LTRNK/SLLNZxprF6lCssg+cVqw15Fy93TliRZFOeheoaSz4zCE
 bbaH3F+wEqv9OdhMrPGU497mSmm+6irlqnl/StpcSt3upoXhXRuja98ZvdCGekrelBgn
 qmKDSqiHHIfFHyxeqqbc4LKCRa1vm/YDK+rgke0xnyP3jlYjJuhbQknzhobAH/zk4Ymr
 6HsA==
X-Gm-Message-State: AOJu0YzQQ346uS6r4jOrHLrfOg3BGIAtZWMp0HrV1VmNBtDH2F/iAk9h
 zeIXRseYQZhcyepTBXAk1lphj7WfIWF4UeobgKy5exTjyqjAqwHZ7uA+RQacUpdf1T+YRG9cE/B
 G+Pk=
X-Google-Smtp-Source: AGHT+IEp+qK8+Pyy1HDX14cw9VRaWfqR9jk+upzzU4UiDphBzxLN8QRChmFYv5ZQhogLzHb2f/Lwjw==
X-Received: by 2002:a05:600c:1f96:b0:40f:b24f:de51 with SMTP id
 je22-20020a05600c1f9600b0040fb24fde51mr2043491wmb.18.1706705372243; 
 Wed, 31 Jan 2024 04:49:32 -0800 (PST)
Received: from localhost ([109.108.76.111]) by smtp.gmail.com with ESMTPSA id
 z23-20020a1c4c17000000b0040efa7e0ef6sm1795930wmf.1.2024.01.31.04.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 04:49:31 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@foundries.io>
To: u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Igor Opaniuk <igor.opaniuk@foundries.io>, Bin Meng <bmeng.cn@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH v1 2/2] imx: imx8: print reset cause
Date: Wed, 31 Jan 2024 13:49:26 +0100
Message-Id: <20240131124926.222556-2-igor.opaniuk@foundries.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131124926.222556-1-igor.opaniuk@foundries.io>
References: <20240131124926.222556-1-igor.opaniuk@foundries.io>
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

Add support for printing reset cause during boot.

Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
---

 arch/arm/mach-imx/imx8/cpu.c | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/mach-imx/imx8/cpu.c b/arch/arm/mach-imx/imx8/cpu.c
index 39ac0bc4140..0b91e448a5d 100644
--- a/arch/arm/mach-imx/imx8/cpu.c
+++ b/arch/arm/mach-imx/imx8/cpu.c
@@ -45,6 +45,45 @@ struct pass_over_info_t *get_pass_over_info(void)
 	return p;
 }
 
+static char *get_reset_cause(void)
+{
+	sc_pm_reset_reason_t reason;
+
+	if (sc_pm_reset_reason(-1, &reason) != SC_ERR_NONE)
+		return "Unknown reset";
+
+	switch (reason) {
+	case SC_PM_RESET_REASON_POR:
+		return "POR";
+	case SC_PM_RESET_REASON_JTAG:
+		return "JTAG reset ";
+	case SC_PM_RESET_REASON_SW:
+		return "Software reset";
+	case SC_PM_RESET_REASON_WDOG:
+		return "Watchdog reset";
+	case SC_PM_RESET_REASON_LOCKUP:
+		return "SCU lockup reset";
+	case SC_PM_RESET_REASON_SNVS:
+		return "SNVS reset";
+	case SC_PM_RESET_REASON_TEMP:
+		return "Temp panic reset";
+	case SC_PM_RESET_REASON_MSI:
+		return "MSI reset";
+	case SC_PM_RESET_REASON_UECC:
+		return "ECC reset";
+	case SC_PM_RESET_REASON_SCFW_WDOG:
+		return "SCFW watchdog reset";
+	case SC_PM_RESET_REASON_ROM_WDOG:
+		return "SCU ROM watchdog reset";
+	case SC_PM_RESET_REASON_SECO:
+		return "SECO reset";
+	case SC_PM_RESET_REASON_SCFW_FAULT:
+		return "SCFW fault reset";
+	default:
+		return "Unknown reset";
+	}
+}
+
 int arch_cpu_init(void)
 {
 #if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_RECOVER_DATA_SECTION)
@@ -322,6 +361,8 @@ int print_bootinfo(void)
 		break;
 	}
 
+	printf("Reset cause: %s\n", get_reset_cause());
+
 	return 0;
 }
 
-- 
2.34.1

