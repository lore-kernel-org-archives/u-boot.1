Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFAEC44507
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 23:33:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E6C684A73;
	Wed, 15 Jul 2026 01:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e91lT5fM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3911984A7B; Wed, 15 Jul 2026 01:33:13 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1862B84A63
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 01:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-451d8064238so2677117fac.3
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 16:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784071990; x=1784676790; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sYeFRkw8BRVs7JX4z3/zgG0ZgUNREHzRSSPlV8k0aUM=;
 b=e91lT5fMV5kTHelVUeyPmuIkt2Q/j/qxV7VYZMkinkskkYbGfXR7pPHiBtRqkDmObV
 7ime584nS7YtZOje3rWcXNxCuVNYaU1336v/yDDDW7HIinVoYopj9XetmHLvOhklHf7J
 gjYtJy1Za12l+s47F3yjj2QTEOOsyZ+sr6sKT5xb2e4G/a6UhW3FgifmrXAPSTXjXl9s
 Adf3YmJKcL3TbvSGKUlswgf8WOdMgEK6AzgAQWmMSFzgF1dqfWsRKROOjmtGX1Zguheo
 P+vK0HLhDPuEaZGE4hwHzfKops5A4XwBssW/ydFRIRzZ0VaUfeFiyieWp1/BRmJZ835N
 2N1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784071990; x=1784676790;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sYeFRkw8BRVs7JX4z3/zgG0ZgUNREHzRSSPlV8k0aUM=;
 b=Nr46H/wTU3MBMM+cAUEybH57zRhJ8JDVBQuYGcEBJ6fvaHAkzoYqUnQY3rtx9KUGdi
 y2qEcYjfmxJIsBBOO+ZAXAp99a+ivQsSqV6LsEHVHZjjkBd5FTCvzKHZGh5WAkPPU93A
 OLlAAlQBJP16wuH0TMD09U6WYKBQenqhdOum91XV5jKI8T0zrmDaNeapuzmIBaFnYuI3
 25OExxuqy+IUOVxhaSzvBhmIJdTaDDYO7vKmAYAcw7sc3KQVT/7PvjATw8uaUfeEu6RS
 pA3xBqqvu5qPqQoQ1TbUFgcSfdPEyrJ0bDf7aakWjMZLsdxm4l0OSSAOfb7/RdRUBc4H
 gFcw==
X-Gm-Message-State: AOJu0Yy8zTfKHXPrGjzHBuIrhBbqShXjiINVwCXX1LQyV2+vNbWoy4e7
 oNChHeMMALWDNfazmE7LlwyIyIMdcZ4V9L2rNw0dAMFqQP+rL2r+udrN5StG0LsbNms=
X-Gm-Gg: AfdE7cn6O2WFUvybBA9X4VPuQIgINSfUhtxV+Xf1OMtq81pgsTsJOT+rKFJGylibzki
 F1rGRgevLUTOiuI69oc3Z5QMXQyoag4YoyqJJEfb6bloyVY+9O2Z7lz0SLlAk0hlIHfLDucS2Ud
 pJryAUjzwd/SzTW0UeWHgAxjEMlTBCvzlR/bx2uMIKIpmqbilYgz96N5BAXb1OB3xuSO1z/mPmk
 m56OGMo2eIDBAs3rfS73tviX7cR3K21JoSCV/CnVjV7IiRADwAZvqnUXMPDTLbuEcbh/Hg078ZL
 rtce7rscyDMELoRhxwM6Mz2iMQ4fltNCshvjfEYeFCQ9bcd238yvDOksX+BtMWC0BLfGE9a9TQ0
 AarSKJ9liVTf9ieGUljUFFr1UPm32v204TNX08JdNNdJE2FrWkLFCqE13i3lQ31scuNIeMSTrN8
 UM+74omxzZ/jtdhTWswVqvFM/y+njC3LVUfkdqXhCcM1z0DC379CQDbeOrYVcWdI1dbi0coII6s
 mE/z+Mh3GHdf1D8YBFfWuXlIArsa80x22B/+HwQjUr05NcZLIR1u54XBAL4jXZ9vUf3VfE/Nj/G
 MixKOY4XFA==
X-Received: by 2002:a05:6870:940b:b0:451:ffac:5643 with SMTP id
 586e51a60fabf-455f7cded5cmr3543763fac.10.1784071989701; 
 Tue, 14 Jul 2026 16:33:09 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (174-29-11-8.hlrn.qwest.net.
 [174.29.11.8]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-451916ce98dsm17609316fac.13.2026.07.14.16.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 16:33:09 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Richard Genoud <richard.genoud@bootlin.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Hans de Goede <hdegoede@redhat.com>,
 Boris Brezillon <bbrezillon@kernel.org>
Subject: [PATCH] mtd: rawnand: sunxi: fix ECC count register indexing
Date: Tue, 14 Jul 2026 17:32:55 -0600
Message-ID: <20260714233259.508396-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Each ECC error-count register contains four 8-bit correction counts.
The register-offset helper already selects the register using the ECC
block index divided by four, but field extraction shifts by the full
block index. This produces shifts of 32 bits or more for each register
after the first.

Use the block index modulo four when extracting the correction count.

Fixes: 4ccae81cdadc ("mtd: nand: Add the sunxi NAND controller driver")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/sunxi_nand.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.h b/drivers/mtd/nand/raw/sunxi_nand.h
index 1b2c514852d..96b65c52685 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.h
+++ b/drivers/mtd/nand/raw/sunxi_nand.h
@@ -167,7 +167,7 @@
 #define NFC_ECC_PAT_FOUND(x)	BIT(x)
 #define NFC_ECC_PAT_FOUND_MSK(nfc) ((nfc)->caps->pat_found_mask)
 
-#define NFC_ECC_ERR_CNT(b, x)	(((x) >> ((b) * 8)) & 0xff)
+#define NFC_ECC_ERR_CNT(b, x)	(((x) >> (((b) % 4) * 8)) & 0xff)
 
 #define NFC_USER_DATA_LEN_MSK(step) \
 	(0xf << (((step) % NFC_REG_USER_DATA_LEN_CAPACITY) * 4))
-- 
2.53.0

