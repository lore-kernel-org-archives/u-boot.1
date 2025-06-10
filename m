Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9716C61DB2
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 19:08:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DC8682B97;
	Tue, 10 Jun 2025 21:08:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PnpnZAkP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4B3582B95; Tue, 10 Jun 2025 21:08:29 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBCD182B20
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 21:08:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christianshewitt@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a50fc819f2so4739930f8f.2
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 12:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749582507; x=1750187307; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+iBOKjfTUQuya0QwBEgYdxDD527hzXrWQ8AITjyMkaI=;
 b=PnpnZAkPezfNP9s1cWa/37taZKidDY6Wk7nnpjHLiw4g/TQVqDi3q6o1S5JT/tkeTA
 3Erp//ioECx6rC0fS2XpyqS784B7Fs4DSYCWoKBZyoDCgGbYVKv+4V1iAEoIoiH/gteb
 YC//jWOb5rnLGCtyK64Db2rHMd//1E/1VeHqtgqAU9PQsAa4gFGZtlDrbJwpgKvSE+lc
 vagiVo+GdiDhp3jwN0NpGt66mNQ3BYbcVS1TC5LcUd0gjKdFKJFqFTWxPPR9186+nf8u
 tzOoJVA5JR1ZCBE6c02lqPnrMtA063OyFxtmH1hYi7BLKKZ1RKLaA6lkP0x6bVW/VeFN
 j48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749582507; x=1750187307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+iBOKjfTUQuya0QwBEgYdxDD527hzXrWQ8AITjyMkaI=;
 b=FTrgxqHI8HEXsFylQ6qc5z03VZ0skI4HlmXh/gN8ePorKb1YII/Ph3DkTB8zmx+++2
 nrEzFHi4nQ0CMJjSeo9S3HRXgpslAbhHQOiIFIRZo7XmpWaVdHdJtY+dSyKPZEWSHLC0
 +unHGbBGCVAV5PCO2gM6RxQhy7cBl7tCgUx8Ty7bppe1ruLncLsN+98/1tCpjwl7mze2
 2ue31io2XQy9FGbh5m9/jQPsfGcKOtNfKnisjb1CH4xUtAFhWiY7br5EFKVP6UWHtmu6
 PC1OVJh1ZllR+FHnQHGcxId60TeXPB5ELcAYkG04zguN5VC3xKa8SN4507UAfG6EOuuF
 rtHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCSpTNSv/X44rv+LYLd8l1qaKX3zbF8pQcgh3Vi26tjHBAipZveNF1vO/hNQQQHmQqcFLGiO8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6VQZLIAHgSw1rTnHbsU4dTQlk3u1ZPpqfWqYQ1wKfcdEyzj5A
 R/spZlfAEjFrlIC8Axoil7TSN5R7yee3KxOy1jm/lZgMCf0NlubKW+Nr
X-Gm-Gg: ASbGncs8TiTAv6rgP4cEZYRSR+G2M+tp7I+7xO0kwmGY7ILNBWkjCQWdULhLNzYm4DI
 5ozyNas2iF+LaEK8BMtjE2veA7x3Imd1twVkVqHyAZEWBn/ip+3Awp8e6xJD4VooN8Nl53KRkVm
 9ta9nSVvpyBw6jsSic4zBfCTC7K3UIfEM9KgN45ol+FubgLAE/CRHrw+oRnS8Ar/uz+DoKokX8N
 uKcA6jpRKcSSmLtutPrl5nGOtRW+5slOiDFUunwFVDx/DW6Zjlo61dy8ZDDrioQ9RSxmFw08x/b
 CPNF+cOpkv4P48uMIWf4LIyq0epMjRYt4K8e51Ow1tc=
X-Google-Smtp-Source: AGHT+IGALr2+HhDe+PQLj1QcHtXUoQfien3VSQP41NY9es+fIiuE4tQZWJ+Ow+qfGzFCDXH7LR6NPQ==
X-Received: by 2002:a05:6000:40df:b0:3a1:fe77:9e1d with SMTP id
 ffacd0b85a97d-3a5586f33d7mr184567f8f.16.1749582506989; 
 Tue, 10 Jun 2025 12:08:26 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5323c0819sm12821487f8f.45.2025.06.10.12.08.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Jun 2025 12:08:26 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
X-Google-Original-From: Christian Hewitt <christianshewitt@gmail.com
To: Loic Devulder <ldevulder@suse.com>, Chen-Yu Tsai <wens@csie.org>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Da Xue <da@libre.computer>, u-boot@lists.denx.de
Cc: Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/2] ram: rk3328: add ddr4-1600 sdram timing
Date: Tue, 10 Jun 2025 19:08:19 +0000
Message-Id: <20250610190820.1462097-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610190820.1462097-1-christianshewitt@gmail.com>
References: <20250610190820.1462097-1-christianshewitt@gmail.com>
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

From: Da Xue <da@libre.computer>

Add DDR4 1600MHz SDRAM timing data from LibreComputer u-boot sources
for the ROC-3328-CC board.

Signed-off-by: Da Xue <da@libre.computer>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm/dts/rk3328-sdram-ddr4-1600.dtsi | 226 +++++++++++++++++++++++
 1 file changed, 226 insertions(+)
 create mode 100644 arch/arm/dts/rk3328-sdram-ddr4-1600.dtsi

diff --git a/arch/arm/dts/rk3328-sdram-ddr4-1600.dtsi b/arch/arm/dts/rk3328-sdram-ddr4-1600.dtsi
new file mode 100644
index 00000000000..9594bb42839
--- /dev/null
+++ b/arch/arm/dts/rk3328-sdram-ddr4-1600.dtsi
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (c) 2018 Fuzhou Rockchip Electronics Co., Ltd.
+
+&dmc {
+	rockchip,sdram-params = <
+		0x1
+		0xA
+		0x2
+		0x1
+		0x0
+		0x0
+		0x11
+		0x0
+		0x11
+		0x0
+		0
+
+		0x94496354
+		0x00000000
+		0x0000002a
+		0x000004e2
+		0x00000015
+		0x0000034a
+		0x000000ff
+
+		800
+		0
+		1
+		0
+		0
+
+		0x00000000
+		0x43041010
+		0x00000064
+		0x0061008c
+		0x000000d0
+		0x000200c5
+		0x000000d4
+		0x00500000
+		0x000000d8
+		0x00000100
+		0x000000dc
+		0x03140401
+		0x000000e0
+		0x00000000
+		0x000000e4
+		0x00110000
+		0x000000e8
+		0x00000420
+		0x000000ec
+		0x00000400
+		0x000000f4
+		0x000f011f
+		0x00000100
+		0x0c0e1b0e
+		0x00000104
+		0x00030314
+		0x00000108
+		0x0506050b
+		0x0000010c
+		0x0040400c
+		0x00000110
+		0x06030307
+		0x00000114
+		0x04040302
+		0x00000120
+		0x06060b06
+		0x00000124
+		0x00020308
+		0x00000180
+		0x01000040
+		0x00000184
+		0x00000000
+		0x00000190
+		0x07040003
+		0x00000198
+		0x05001100
+		0x000001a0
+		0xc0400003
+		0x00000240
+		0x0600060c
+		0x00000244
+		0x00000201
+		0x00000250
+		0x00000f00
+		0x00000490
+		0x00000001
+		0xffffffff
+		0xffffffff
+		0xffffffff
+		0xffffffff
+		0xffffffff
+		0xffffffff
+		0xffffffff
+		0xffffffff
+		0xffffffff
+		0xffffffff
+		0xffffffff
+		0xffffffff
+		0xffffffff
+		0xffffffff
+
+		0x00000004
+		0x0000000c
+		0x00000028
+		0x0000000c
+		0x0000002c
+		0x00000000
+		0x00000030
+		0x00000009
+		0xffffffff
+		0xffffffff
+
+		0x77
+		0x88
+		0x79
+		0x79
+		0x87
+		0x97
+		0x87
+		0x78
+		0x77
+		0x78
+		0x87
+		0x88
+		0x87
+		0x87
+		0x77
+
+		0x78
+		0x78
+		0x78
+		0x78
+		0x78
+		0x78
+		0x78
+		0x78
+		0x78
+		0x69
+		0x9
+
+		0x77
+		0x78
+		0x77
+		0x78
+		0x77
+		0x78
+		0x77
+		0x78
+		0x77
+		0x79
+		0x9
+
+		0x78
+		0x78
+		0x78
+		0x78
+		0x78
+		0x78
+		0x78
+		0x78
+		0x78
+		0x69
+		0x9
+
+		0x77
+		0x78
+		0x77
+		0x77
+		0x77
+		0x77
+		0x77
+		0x77
+		0x77
+		0x79
+		0x9
+
+		0x78
+		0x78
+		0x78
+		0x78
+		0x78
+		0x78
+		0x78
+		0x78
+		0x78
+		0x69
+		0x9
+
+		0x77
+		0x78
+		0x77
+		0x78
+		0x77
+		0x78
+		0x77
+		0x78
+		0x77
+		0x79
+		0x9
+
+		0x78
+		0x78
+		0x78
+		0x78
+		0x78
+		0x78
+		0x78
+		0x78
+		0x78
+		0x69
+		0x9
+
+		0x77
+		0x78
+		0x77
+		0x77
+		0x77
+		0x77
+		0x77
+		0x77
+		0x77
+		0x79
+		0x9
+	>;
+};
-- 
2.34.1

