Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6839C19F32
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 17:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 559228144F;
	Fri,  7 Mar 2025 18:13:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="g9zNvQrw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 844CE814B6; Fri,  7 Mar 2025 18:13:27 +0100 (CET)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A68880F6B
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 18:13:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 6657125C5C;
 Fri,  7 Mar 2025 18:13:25 +0100 (CET)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 33KPdGXXyLYm; Fri,  7 Mar 2025 18:13:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1741367563; bh=8ofrqoq9Msda3UwwL2aBYaMtVzaP3Lu53f0tc8J17Po=;
 h=From:To:Cc:Subject:Date;
 b=g9zNvQrwApRz5WoXmp5l2ckRuG+PJyUk1ZM9mUeP2DwAUmb/082TU/4aQWerDyT4x
 rQ8Qk9nhw3VjWkrWapWHjWHR5ybO2MasSWupdE1AcQ8MCQ1Ce9JMUC4iFaO99HF5jR
 eBoMjVFgwwWxLUfO3/NB+IgZee7fsGgX+GzNW113DjhugZvsWMlS/1c0hhVwp1rd9z
 iyKm18uZLUebtkkDUze4Q1dVNmUmp+YI9+jD9qtcpM55TzfCg0K6h4aWao1NG1KUdk
 jQ4hmKQoZAXL4CsW8fBsFtsCKdtkZ4SePns0+HBbzDtigCEloGPjp5jQbLt9j9kYwf
 f5DKTL7O6LHdw==
From: Yao Zi <ziyao@disroot.org>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, Yao Zi <ziyao@disroot.org>,
 Yuguo Pei <purofle@gmail.com>
Subject: [PATCH] clk: sophgo: Fix return values of register updating helpers
Date: Fri,  7 Mar 2025 17:11:45 +0000
Message-ID: <20250307171143.31626-3-ziyao@disroot.org>
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

These helpers wrongly return the updated register value. As a non-zero
value indicates failure, this causes various clock operations are
considered failed.

Correct the return value to constant zero, since these simple MMIO
operations won't fail. This fixes clock enabling failures during booting
process,

	In:    serial@4140000
	Out:   serial@4140000
	Err:   serial@4140000
	Net:   Enable clock-controller@3002000 failed
	failed to enable clock 0
	No ethernet found.

which leads to misoperation of various peripherals.

Fixes: 5f364e072e7 ("clk: sophgo: cv1800b: Add clock controller driver for cv1800b SoC")
Tested-by: Yuguo Pei <purofle@gmail.com>
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/clk/sophgo/clk-common.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sophgo/clk-common.h b/drivers/clk/sophgo/clk-common.h
index 95b82e968d0..a9e83d0d689 100644
--- a/drivers/clk/sophgo/clk-common.h
+++ b/drivers/clk/sophgo/clk-common.h
@@ -45,12 +45,14 @@ static inline u32 cv1800b_clk_getbit(void *base, struct cv1800b_clk_regbit *bit)
 
 static inline u32 cv1800b_clk_setbit(void *base, struct cv1800b_clk_regbit *bit)
 {
-	return setbits_le32(base + bit->offset, BIT(bit->shift));
+	setbits_le32(base + bit->offset, BIT(bit->shift));
+	return 0;
 }
 
 static inline u32 cv1800b_clk_clrbit(void *base, struct cv1800b_clk_regbit *bit)
 {
-	return clrbits_le32(base + bit->offset, BIT(bit->shift));
+	clrbits_le32(base + bit->offset, BIT(bit->shift));
+	return 0;
 }
 
 static inline u32 cv1800b_clk_getfield(void *base,
-- 
2.48.1

