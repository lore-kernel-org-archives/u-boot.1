Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA3AC54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 10:49:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D41582CD2;
	Sun, 25 May 2025 12:48:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CI4svvG7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25CDD82CCE; Sun, 25 May 2025 12:48:20 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35DBF82AA7
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a36e090102so725103f8f.2
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 03:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748170097; x=1748774897; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oON4pywBZdOmgUX2Iizav92fFiDNVjPgfGcWipvW4d4=;
 b=CI4svvG7rsbEWAoaI/Y4x1jprvB9vGVETYm6TSbO9WCYlz1t6fXP5UcIAIP5ra2xNb
 Slj7ulKG9UhpPYVelw54Aa0LWkgaiJ6DcLcNmoozkY7epV4mj/5R3S9CSLgj1143q5+S
 Z6axaKgpQIr+47J3Vo2Y7vQUQcB3kRbtqjamc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748170097; x=1748774897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oON4pywBZdOmgUX2Iizav92fFiDNVjPgfGcWipvW4d4=;
 b=Ke8EvOvD1alfqJFLkEtbQ2uQCnCLZUZEfniFcA1/AjDw2KsvTyhQT+v/s/PSPOb9/+
 ooaVaQClHrY5YiKDpZVY+0n31wosa1OwEs+LmUzsPs4f7h078WRRmYflGqGyZY86ZyXs
 6SLIVBnJ17TiAb8QTUfOGX4UfB6ovfZAeeZoOfMig4iYSqIfER93tmKTGcGy8yaCwp4w
 BC1V+CXhDyxBkhZtoxhWidOQMQ1LSo/DwYS3IMdUcO1SmOzl7re5j8Yb7Iv6uYTrxuqE
 VonaVMRWN34Ah5/bpqA/xHChtS//NYgXb8pId0ibU/RrKD9fHNqbPhie3i4N80oLtatF
 mPHQ==
X-Gm-Message-State: AOJu0YyhvBkVS10d9xJK2BMdRf7VOd2wPmLkPBBXZ2s687hMq3pUzsqi
 2AgUxrbavkbY+a5lDlr/c+0g8UgfYv2UCKOiHWOAedRUMSo9I4ff4qHfNHr+/q2hrEgqo/iMshT
 lGy9PdgIv
X-Gm-Gg: ASbGncvXpMPXIEPu6cl6wPyS2DUcY/tjQvrCjLn1f2GJ8isBeb35EUIG0iyCF4mTOUe
 5u4y8FMxkP9J3HcaEFsrZKEjcZTL/7BTNZIiUYJQBELTxMVksUV9hMEaNhv+YHGbNt0+62px2Q1
 Ia+Lp6vYUC3vDUP+4t1qey1smf5NLXXlhJmowfd0GTb2MMSh7npC/hzl8NILSdAJrw5PJ/OxyTV
 7jN6YTqwGupyeJORHXCljBJDyCqftbnkEUBir0VuXo6hfb9RRR7MUQL4yzQ4q8JAqljZe46pG/i
 LXqsx+unaOUC+fujmmbKfWeu7t5WvCJ2X7n506fx/Dtey76vc9ytl716KVt/0oa7iWllrMQ=
X-Google-Smtp-Source: AGHT+IEE3uhUm5f9UUh0IVlnYuE4LAk6RaPs6Pb3S29Pcu/K2OgMuTYFoflnLmHV+F8sd4OjDCBYTg==
X-Received: by 2002:a05:6000:2dc7:b0:3a4:741d:35c1 with SMTP id
 ffacd0b85a97d-3a4cb48430fmr3654327f8f.36.1748170097155; 
 Sun, 25 May 2025 03:48:17 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cb450867sm5045047f8f.57.2025.05.25.03.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 03:48:15 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jeffy Chen <jeffy.chen@rock-chips.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v4 06/25] rockchip: dts: Specify the phase in the image
Date: Sun, 25 May 2025 11:47:42 +0100
Message-Id: <20250525104801.1440260-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250525104801.1440260-1-sjg@chromium.org>
References: <20250525104801.1440260-1-sjg@chromium.org>
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

Add 'u-boot' as the phase for the images intended for use with U-Boot
proper.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/dts/rockchip-u-boot.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 8a37a9d8e7f..4c882c4a450 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -64,6 +64,7 @@
 				compression = FIT_UBOOT_COMP;
 				load = <CONFIG_TEXT_BASE>;
 				entry = <CONFIG_TEXT_BASE>;
+				phase = "u-boot";
 				u-boot-nodtb {
 					compress = FIT_UBOOT_COMP;
 				};
@@ -82,6 +83,7 @@
 				arch = FIT_ARCH;
 				os = "arm-trusted-firmware";
 				compression = "none";
+				phase = "u-boot";
 				fit,load;
 				fit,entry;
 				fit,data;
@@ -101,6 +103,7 @@
 				arch = FIT_ARCH;
 				os = "tee";
 				compression = "none";
+				phase = "u-boot";
 				fit,load;
 				fit,entry;
 				fit,data;
@@ -123,6 +126,7 @@
 				compression = "none";
 				load = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
 				entry = <(CFG_SYS_SDRAM_BASE + 0x8400000)>;
+				phase = "u-boot";
 
 				tee-os {
 				};
-- 
2.34.1

