Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DEBE784BE
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 22:39:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B676983C29;
	Sun, 28 Dec 2025 23:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l57n2B8l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A654183B0B; Sun, 28 Dec 2025 23:39:07 +0100 (CET)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 537C283BE1
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 23:39:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7b9c17dd591so7349245b3a.3
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 14:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766961542; x=1767566342; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I5Zf6QQAy+7KC5yStpHj56kj42V9X8/93yJyh2yxTD0=;
 b=l57n2B8lvt3ttlmaaWF20IlePhfnt7xXrEA2PSz8IWnx5B8TDzBaKNkXgw1SXBhpFa
 IgyPnbLVL/IfRXzapYVwsWRYKap7N9H1l1WgssmsfUWQNpgdMX2e53X6aFlzgHAy/Dr2
 66FfUjQr5iWEX/G4hIAs4ll8wJyPoJgf8WCzH+gQXvziQUpQ+vOJxbdb2YQEqdE5bllb
 ypmHnK44KxnBE2tpvNYGtj5RH9of1I0Ea69hQIjC8d3xxw0fmyahr17QuCz0khCWy2jt
 /PwRQh5D2ZWrpRiG33vWgfTVVJpnHAt6xtwxrRxduN+JFNpJReLSCsQ0R9rjSQYpXjPX
 z5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766961542; x=1767566342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I5Zf6QQAy+7KC5yStpHj56kj42V9X8/93yJyh2yxTD0=;
 b=f7CYyVn7q3xddQHiruETC6r67kwmw5Xc2lNwE9hCiaRbPddZShvJngR5REt2H8/gD/
 Xh5fAMSNj7jlUgceSn5ltF4369rckq8FA1cx61lmWKacXqJVg/Q26nKE68R+KBa2nTmi
 mGkCeaAHTiYX+ZC3cUmgiDnk2wmYJhXr2QereUYCTmpw3ZkaTYDhKQMAkNHXf9FMKrfa
 q9jOM/z+JClWJ/bb2yh+zrtmFzKgFeCVcG3Zk51q5tqsCXD1Ks/buI0Kwl3GD6ab3/Us
 P0crZRQgORzAZgOaWhyz51TQsCvewAQNnxUvdL7+dbYRVn9gOuedrocDU4xKN5FuApTw
 9Bqw==
X-Gm-Message-State: AOJu0Yzo9okUhZhLaDkuRhBXJK4o9Co5ELZGhj/FPnx1+jylwD6643hq
 /m8b9XFnO8DK3A4+8D/DyOmlnQD/pGRaKI5Z/OZuipWiYoZGO+EephmSWabnNBqS
X-Gm-Gg: AY/fxX63D3wO3dRJT35ZUjD2+P4FtpvwiT08OmWHVfl8bA9aW536w3Jgf3E57Gmf8EW
 mVbHg9iAy+gORJ17FMy4hRAuXaoStMj4IfEItWGxloF20lkpKZmtLpyXYNRGlW0SSR/saPjf/ie
 IO0VmBjQ7GVnF7wcwork61TtC1zuGvnFim7vxOPYC+SXB12FQyf1TDqm08xC7gHLD9lmJvBsKxW
 4pu/kMLWA5ZLweyKw1Mgz3JCQtUfhsf8q9vaerexbDdOOZn76paVyBPtJ8CMdx8bVG8PJlwH44G
 CW8GMICLTFWUjFk0WzCrmvjbdt613OUIV5zWkm6wSsI4PzNqye/k2z7sHi/0Zyv1Lvk0LbxEjbp
 L3lzJ5ptL517f/mzD+kO35ZQXN4hC1v6dOkXqmztJajW/bAJVZvF4XGyDM6+a9Jmh0DIaJdeMsC
 WYwnQQQI7psaULxFveeKRrjjRPPgDByeFgcNahsLZ24G8M
X-Google-Smtp-Source: AGHT+IGOao1lSPGxaE8F+8BALeZAlW0fG57i7Z0TeDlzpL8J7WrvMi5zjqtm9PU9VZHwc0MA9HcEUw==
X-Received: by 2002:a05:6a21:3086:b0:36b:e81e:386 with SMTP id
 adf61e73a8af0-376aa6f13fbmr23223868637.80.1766961541646; 
 Sun, 28 Dec 2025 14:39:01 -0800 (PST)
Received: from intel-VirtualBox.. ([185.213.82.236])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1e7c7263a3sm23499331a12.32.2025.12.28.14.38.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 14:39:01 -0800 (PST)
From: Brian Sune <briansune@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>,
 Brian Sune <briansune@gmail.com>
Subject: [PATCH v1 3/3] Add CoreCourse socfpga Board
Date: Mon, 29 Dec 2025 06:38:21 +0800
Message-Id: <20251228223821.22260-4-briansune@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251228223821.22260-1-briansune@gmail.com>
References: <20251228223821.22260-1-briansune@gmail.com>
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

Enable CoreCourse Altera GEN5 Cyclone V
board build support to mach-socfpga

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 arch/arm/dts/Makefile         |  2 ++
 arch/arm/mach-socfpga/Kconfig | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index fcad6fb2fc7..40a69a13c4b 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -468,6 +468,8 @@ dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
 	socfpga_cyclone5_socrates.dtb			\
 	socfpga_cyclone5_sr1500.dtb			\
 	socfpga_cyclone5_vining_fpga.dtb		\
+	socfpga_cyclone5_ac501soc.dtb			\
+	socfpga_cyclone5_ac550soc.dtb			\
 	socfpga_n5x_socdk.dtb				\
 	socfpga_stratix10_socdk.dtb
 
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index f2e959b5662..69af0b48348 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -239,6 +239,14 @@ config TARGET_SOCFPGA_TERASIC_SOCKIT
 	bool "Terasic SoCkit (Cyclone V)"
 	select TARGET_SOCFPGA_CYCLONE5
 
+config TARGET_SOCFPGA_CORECOURSE_AC501SOC
+	bool "CoreCourse AC501SoC (Cyclone V)"
+	select TARGET_SOCFPGA_CYCLONE5
+
+config TARGET_SOCFPGA_CORECOURSE_AC550SOC
+	bool "CoreCourse AC550SoC (Cyclone V)"
+	select TARGET_SOCFPGA_CYCLONE5
+
 endchoice
 
 config SYS_BOARD
@@ -263,6 +271,8 @@ config SYS_BOARD
 	default "sr1500" if TARGET_SOCFPGA_SR1500
 	default "stratix10-socdk" if TARGET_SOCFPGA_STRATIX10_SOCDK
 	default "vining_fpga" if TARGET_SOCFPGA_SOFTING_VINING_FPGA
+	default "ac501soc" if TARGET_SOCFPGA_CORECOURSE_AC501SOC
+	default "ac550soc" if TARGET_SOCFPGA_CORECOURSE_AC550SOC
 
 config SYS_VENDOR
 	default "intel" if TARGET_SOCFPGA_AGILEX7M_SOCDK
@@ -284,6 +294,8 @@ config SYS_VENDOR
 	default "terasic" if TARGET_SOCFPGA_TERASIC_DE10_NANO
 	default "terasic" if TARGET_SOCFPGA_TERASIC_DE10_STANDARD
 	default "terasic" if TARGET_SOCFPGA_TERASIC_SOCKIT
+	default "corecourse" if TARGET_SOCFPGA_CORECOURSE_AC501SOC
+	default "corecourse" if TARGET_SOCFPGA_CORECOURSE_AC550SOC
 
 config SYS_SOC
 	default "socfpga"
@@ -310,5 +322,7 @@ config SYS_CONFIG_NAME
 	default "socfpga_sr1500" if TARGET_SOCFPGA_SR1500
 	default "socfpga_stratix10_socdk" if TARGET_SOCFPGA_STRATIX10_SOCDK
 	default "socfpga_vining_fpga" if TARGET_SOCFPGA_SOFTING_VINING_FPGA
+	default "socfpga_ac501soc" if TARGET_SOCFPGA_CORECOURSE_AC501SOC
+	default "socfpga_ac550soc" if TARGET_SOCFPGA_CORECOURSE_AC550SOC
 
 endif
-- 
2.34.1

