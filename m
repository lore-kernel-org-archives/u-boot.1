Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E37D2F02F
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 13:56:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D807D84101;
	Tue, 27 Jan 2026 14:54:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SbAxU+hv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D89C883F50; Tue, 27 Jan 2026 11:14:46 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C0DC83FD9
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 11:14:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ernestvanhoecke@gmail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-430f2ee2f00so3208923f8f.3
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 02:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769508884; x=1770113684; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AZaHmWSQdHGWt5rVvj2gdqHBQlEE+o0lhVcQRs4hAxY=;
 b=SbAxU+hvEIsgCHS4f8JRE7JvHfpPSmPit9foCDzn+lEeIotJUsk9XykXUouX+h54Xc
 cHgs4WSHzcQlw+GNsxrbQqZHAFYi3tm1yg5I+ktsVuDD+jthwVGGiWCiQNXMmM+wDP2D
 ZJlTnAf7SuoonOIRiSg6qa5t5GxMHML+K0xF/Zp6aeeEQU2JVnFQn9m7J5dcR04NddZc
 3zKJlocI1zDfXrkmTr55b4TwoAJdyHb8W7e7MnnaKoSfYLr4MQVz0KSDWMrRA2kJrjTa
 oKh/Cbs6ZLTa7+8WPDIlPp0CaQ6LBoOkZats1TsfvE+fZqRu20gfNykyupmLZQtucVgO
 uqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769508884; x=1770113684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AZaHmWSQdHGWt5rVvj2gdqHBQlEE+o0lhVcQRs4hAxY=;
 b=gTv7AoPIO8luZfG/0RRZV/oqbakzIgql/5sqDF06TLYKePJd6UWgDWIXnMu7Klb3F0
 SkH/H5E5y+3wxqO1gTQkyJe6VdeLtyYUUtoxjp+ojWAxtL6DvIulnpp5k0k+fGufU+er
 htu2utHry1f9Nr5nPRA6aORwszd0rKdvkdOpf8UlJPvXDFma4ZrnD+5ne/RoYSsIe5/Z
 rAkDKleuuq34PeBP8+LDUnEoafSGyefThZWStqfN5GJPrMHBpCZgtZTgHjuQKIa/FPg9
 ec3baysKbuS9pyowhk6MTJVSf2bITPu0SRn7RBZ3O9ckX8VYEv/G+6Eg3ToCVPyKgS+s
 ZPXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOoSOBSWh0xb+nholaieZJ9d2jHxbxchEZP/haBpSlfAtsUPM6s04RI5jQsZV9rgESlUDVsNo=@lists.denx.de
X-Gm-Message-State: AOJu0YyOUjTa0QW5vMBfBmLEfijvv0FTmLk3WBnDahB5GOasy0HxW8K+
 Hrknk7lLROX2vtyG5MAoMsRMZiiTQU2xIw9WTu6Nm887M1ZrfAbM+Xil
X-Gm-Gg: AZuq6aJ1776Llm1qjEWakLun8Jbjo3dmCEihM+793eWmAryhcNUkRiyKtj2y/pcP7cB
 MsO6C+7HHEfwDqZX9zjTW8q6eMm5sEms736TXmXcPhdiMwTv3HFcKLsJCNz6JxYQiz+SttSAt/g
 Bd6MGxXQMRDrxorhGNL05md9Q0qeMZZDSGUIF7Uu5+0ITqZYjfggsF0F52JwDuTViOqNcIpx8sR
 L1kMz3O+AoTOBIPobYn1vRaKG1LeBkmz+aPnaH89HsdrGx2Q17L5cb79zKsBRkeIvOFW9641bHg
 WUl2EIrrdLjcRwsxhySBnOmAynYa1rD5+36Fuv7EdFtFzv0cEdjCuipI+AoA2H5NOGyvuZoLHoy
 bivj6xfAlD8667uB4n2/bTzDA+n54Q1WiAEmF0pZ5NKrihiT0iBYIQFjjTkYfamq4BOqI4HNFrz
 4mzX4+6XJUoABqdhkqIgdNuQlXwrvNsJpXB+lwUTr+pQSccevrNLlm2V5wZ/YguJghx7blJCa2b
 Z4N8nBwb1NYpQSBHOHcQ+w=
X-Received: by 2002:a05:6000:1865:b0:431:3a5:d9ae with SMTP id
 ffacd0b85a97d-435dd02ddabmr1781077f8f.4.1769508883633; 
 Tue, 27 Jan 2026 02:14:43 -0800 (PST)
Received: from ernest.corp.toradex.com
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c0179bsm36744525f8f.1.2026.01.27.02.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 02:14:43 -0800 (PST)
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Franz Schnyder <franz.schnyder@toradex.com>, u-boot@lists.denx.de
Subject: [PATCH v1 2/2] board: toradex: aquila-am69: Remove ETH_1 MCU_CLKOUT0
Date: Tue, 27 Jan 2026 11:14:12 +0100
Message-ID: <20260127101413.2812815-3-ernestvanhoecke@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127101413.2812815-1-ernestvanhoecke@gmail.com>
References: <20260127101413.2812815-1-ernestvanhoecke@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Jan 2026 14:54:50 +0100
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

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

On the Toradex Aquila AM69 V1.1, the on-module ETH_1 relies on an
external 25 MHz crystal oscillator. On the V1.0, we needed to enable
MCU_CLKOUT0, but support for this was already dropped from the device
tree before being sent to U-Boot.

Remove this obsolete enabling of MCU_CLKOUT0.

Fixes: 3f0528882c0d ("board: toradex: add aquila am69 support")
Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
---
 board/toradex/aquila-am69/aquila-am69.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/board/toradex/aquila-am69/aquila-am69.c b/board/toradex/aquila-am69/aquila-am69.c
index 98b9bfc5aa4b..e0975d5bc6fe 100644
--- a/board/toradex/aquila-am69/aquila-am69.c
+++ b/board/toradex/aquila-am69/aquila-am69.c
@@ -22,8 +22,6 @@
 #include "ddrs_patch.h"
 
 #define CTRL_MMR_CFG0_MCU_ADC1_CTRL	0x40F040B4
-#define CTRL_MMR_CFG0_MCU_CLKOUT0_CTRL	0x40F08010
-#define MCU_CLKOUT0_CTRL_CLK_EN		BIT(4)
 
 #define HW_CFG_MEM_SZ_32GB		0x00
 #define HW_CFG_MEM_SZ_16GB		0x01
@@ -200,9 +198,4 @@ void spl_board_init(void)
 		if (ret)
 			printf("ESM PMIC init failed: %d\n", ret);
 	}
-
-	if (IS_ENABLED(CONFIG_TARGET_AQUILA_AM69_R5))
-		writel(readl(CTRL_MMR_CFG0_MCU_CLKOUT0_CTRL) |
-		       MCU_CLKOUT0_CTRL_CLK_EN,
-		       CTRL_MMR_CFG0_MCU_CLKOUT0_CTRL);
 }
-- 
2.43.0

