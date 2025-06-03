Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701B1C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 08:51:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF74A8212B;
	Tue,  3 Jun 2025 10:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dhtza2Pn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 142AB81E72; Tue,  3 Jun 2025 10:51:45 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 219F181FFC
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 10:51:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-601dfef6a8dso8593048a12.1
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 01:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748940702; x=1749545502; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nVfoGVeQ6qCGbS7DSKuaCP6Umf2tK3Lq50KWIm8F4ho=;
 b=Dhtza2PnLOZPfsrpmJYJyG04e1H0H+fTJ/Jq3fkklvBy5L+AqA8fi2GCgiSaPKzlZ/
 /xwIXT9t4nwwa1hhg1FvU5Jwtbann83LAJ8I6Q6Lyboo97HauUEnWyyU4+zZip0S50HD
 k8zo0AWthfEe5eC6DTQQfPROeNKP8SU76Yu4uew9urtJaQg51FZFaPM3Fc9FmeLhVGGe
 ZIACPcr/eIuh00elSvr3ADo7mNjyNS+FhDMYRmOtc1r27tPzlgAmhTwuLpAMcgHp7T2q
 CVfp5JfsY0JTcEzt3NbX/gy1oUDwPMRgg+AGXBSrhe4narZqyDdY1Hwe5826yhs0GF2k
 edYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748940702; x=1749545502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nVfoGVeQ6qCGbS7DSKuaCP6Umf2tK3Lq50KWIm8F4ho=;
 b=cMF+Ks73f2PSq2uuFOV8q37yngOwAeP5geY384jk05nRchB2lVlVH80IXzT7X9tYNk
 F4gSwBR0nruT78Y9uA7DvM1bOqIU9B5hwaUbuh6eqhK6DtbkKYE7jguDxemPV7mphcOI
 JzxCPHP1MRReK+psvyZglAqt0BZDulnMjFWUXEM5VIzEOSdmWVErDwqzjoJYSxX7JiJE
 +BaLaU71UFRrwFbIHs/7rERmv69nZOxl/IDfmoNXOkyAyTs9FTxhNPDfdgCTKY8MObh9
 pMHen4vol0EgBROlul26ZHqNUhAjM6MAo0J8W3tsdAM4KuBPAc7d6LCqcQEp+utdfCDB
 GtJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjfdYKX4MKtdQofZ57Zzd0kipQ/7W7SiD3JednwlOCtKP/B6Ady6Q18/pePAropJynWpwdq5o=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2rF2d/t7btlzQL7Q6wp2alxyB9OJkxqV9tI+HNpbLPqcTGFyj
 bQNMmVAnyLyZmDUQFchYifTZECl4ngK5sa2tKrSvEcqhKl06RYziuX2EtNSq/Jv0l74=
X-Gm-Gg: ASbGncv/KU649iMthO4JAlYXI4HekBItrje/WwHhBbZjIJZTDyJkd9GEQSbSs+sX4rP
 igqjIDJn7FGl9dHpwMxaL6cJhsI82UHE5NETZ8FNmN4h62fzAy0ZjfbUuSY7nxNy54MetIYcNmD
 W/6MKDkcRiuEQWyTNoz99C1WfEl1d89EZGYgu2a27qaksRAi/R7IlHEXAXR2iRIkkJEqz7oCSdO
 XI9c5Wp3E+HFL/xSHpomz3Y4jcqtyc+h+3D3x0okHi21efRXaebEHcrg5KbvI9GVd958bxt0KTw
 Lmz9dKCfCijbFl8E5TSrVuocJUcP9zB4cX+dwIMCS9PGjVNl7BJfyv38nDm5e/hSOUEr
X-Google-Smtp-Source: AGHT+IGkaRGwba7QUWdJfh4ERoCq44HLF/akuWd3OckZ7qmMRBGX107ZMyr+nP5hOJNsZoAW3ETGgw==
X-Received: by 2002:a17:906:6a01:b0:ad8:96d2:f40 with SMTP id
 a640c23a62f3a-adb493d773cmr1021025166b.21.1748940702078; 
 Tue, 03 Jun 2025 01:51:42 -0700 (PDT)
Received: from Ansuel-XPS24.my-cloud.eu ([82.144.39.243])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ada5e2bf0b3sm918778866b.112.2025.06.03.01.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:51:41 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH 2/2] mtd: spinand: winbond: add Winbond W25N04KV flash support
Date: Tue,  3 Jun 2025 10:51:25 +0200
Message-ID: <20250603085132.12407-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250603085132.12407-1-ansuelsmth@gmail.com>
References: <20250603085132.12407-1-ansuelsmth@gmail.com>
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

Add Winbond W25N04KV flash support that use a different value to detect
ECC bitflip.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/mtd/nand/spi/winbond.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index dd4ed257a83..16abf89dbbf 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -11,6 +11,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #endif
+#include <linux/bitfield.h>
 #include <linux/bug.h>
 #include <linux/mtd/spinand.h>
 
@@ -18,6 +19,8 @@
 
 #define WINBOND_CFG_BUF_READ		BIT(3)
 
+#define W25N04KV_STATUS_ECC_5_8_BITFLIPS FIELD_PREP_CONST(STATUS_ECC_MASK, 0x3)
+
 static SPINAND_OP_VARIANTS(read_cache_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
@@ -121,6 +124,7 @@ static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
 		return -EBADMSG;
 
 	case STATUS_ECC_HAS_BITFLIPS:
+	case W25N04KV_STATUS_ECC_5_8_BITFLIPS:
 		/*
 		 * Let's try to retrieve the real maximum number of bitflips
 		 * in order to avoid forcing the wear-leveling layer to move
@@ -172,6 +176,15 @@ static const struct spinand_info winbond_spinand_table[] = {
 					      &update_cache_variants),
 		     0,
 		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
+	SPINAND_INFO("W25N04KV",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa, 0x23),
+		     NAND_MEMORG(1, 2048, 128, 64, 4096, 40, 2, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     0,
+		     SPINAND_ECCINFO(&w25n02kv_ooblayout, w25n02kv_ecc_get_status)),
 };
 
 static int winbond_spinand_init(struct spinand_device *spinand)
-- 
2.48.1

