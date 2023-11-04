Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B19C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 06:51:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9801F87114;
	Sat,  4 Nov 2023 07:51:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Xro7QWBN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 092FE87115; Sat,  4 Nov 2023 07:51:25 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8256C870FC
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 07:51:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (unknown [159.148.28.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 774393FB4A; 
 Sat,  4 Nov 2023 06:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1699080679;
 bh=NnqC9z4JD+PPaI3CHjM6m/YQUpj+eH00eR2fPKCm7NU=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=Xro7QWBNQ5tTRnrx2hpnSSwSNbaZtrTHtIPndB8VJbHoQ3qzTyVfNy9A0NWjtyHDX
 N5bu9m79hwfVrJzJr7H52pNKybEmvqFvrUPkM9NakdJB4r1rylD8Il5hPSUEECgbx+
 AUnT+MS/I58ER+BbVhPbBYT0Dz5q1BwAGuwbZMosjG9BWZh3ArgwMjiKf1PIlmGv5E
 SHWr25vfhzIJB/IQTGedVZ9U+E3a9BjEimq7184am+HKKz/9HdGXghq/KxsF76CSve
 LEBbbNvRVExS5+kh+KVFK7FsL8U7K3GDeuhVIVUbptecMohuYKh9CcZdc9QwwmZ055
 ynbNAkDvIa7Ug==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>,
	Leo Yu-Chi Liang <ycliang@andestech.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Xiang W <merlew4n6@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] rng: detect RISC-V Zkr RNG device in bind method
Date: Sat,  4 Nov 2023 08:51:07 +0200
Message-Id: <20231104065107.23623-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

The existence of devices should be checked in the bind method and not in
the probe method. Adjust the RISC-V Zkr RNG driver accordingly.

Use ENOENT (and not ENODEV) to signal that the device is not available.

Fixes: ceec977ba1a9 ("rng: Provide a RNG based on the RISC-V Zkr ISA extension")
Reported-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 drivers/rng/riscv_zkr_rng.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/rng/riscv_zkr_rng.c b/drivers/rng/riscv_zkr_rng.c
index 8c9e111e2e..48a5251988 100644
--- a/drivers/rng/riscv_zkr_rng.c
+++ b/drivers/rng/riscv_zkr_rng.c
@@ -55,7 +55,7 @@ static int riscv_zkr_read(struct udevice *dev, void *data, size_t len)
 			}
 			break;
 		case DEAD:
-			return -ENODEV;
+			return -ENOENT;
 		}
 	}
 
@@ -63,16 +63,16 @@ static int riscv_zkr_read(struct udevice *dev, void *data, size_t len)
 }
 
 /**
- * riscv_zkr_probe() - check if the seed register is available
+ * riscv_zkr_bind() - check if the seed register is available
  *
- * If the SBI software has not set mseccfg.sseed=1 or the Zkr
- * extension is not available this probe function will result
- * in an exception. Currently we cannot recover from this.
+ * If the SBI software has not set mseccfg.sseed=1 or the Zkr extension is not
+ * available, reading the seed register will result in an exception from which
+ * this function safely resumes.
  *
  * @dev:	RNG device
  * Return:	0 if successfully probed
  */
-static int riscv_zkr_probe(struct udevice *dev)
+static int riscv_zkr_bind(struct udevice *dev)
 {
 	struct resume_data resume;
 	int ret;
@@ -87,7 +87,24 @@ static int riscv_zkr_probe(struct udevice *dev)
 		val = read_seed();
 	set_resume(NULL);
 	if (ret)
-		return -ENODEV;
+		return -ENOENT;
+
+	return 0;
+}
+
+/**
+ * riscv_zkr_probe() - check if entropy is available
+ *
+ * The bind method already checked that the seed register can be read without
+ * excpetiong. Here we wait for the self test to finish and entropy becoming
+ * available.
+ *
+ * @dev:	RNG device
+ * Return:	0 if successfully probed
+ */
+static int riscv_zkr_probe(struct udevice *dev)
+{
+	u32 val;
 
 	do {
 		val = read_seed();
@@ -95,7 +112,7 @@ static int riscv_zkr_probe(struct udevice *dev)
 	} while (val == BIST || val == WAIT);
 
 	if (val == DEAD)
-		return -ENODEV;
+		return -ENOENT;
 
 	return 0;
 }
@@ -108,6 +125,7 @@ U_BOOT_DRIVER(riscv_zkr) = {
 	.name = DRIVER_NAME,
 	.id = UCLASS_RNG,
 	.ops = &riscv_zkr_ops,
+	.bind = riscv_zkr_bind,
 	.probe = riscv_zkr_probe,
 };
 
-- 
2.40.1

