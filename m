Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AC4CF34AD
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 20:37:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5409B88E3F;
	Thu,  3 Oct 2024 22:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727987866;
	bh=rxa+N7g0nSmn5Q8LQ9wAcbFT7ZkruIr7pbh8Gajz8O8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uEqQM0JYNjLs3HBBgdHh3//0UOhao6Vqj+674p7FtAkIX7eHknVY0xSxIRiI0EOnm
	 VH6gKmXT2irBRyXmOFXlQML1rD1Kc6XO72PAExnrl8+/DgGmgY30eqJR96/X/SdXoZ
	 3PD0xsEEpSBAM5aKYBKf4rOhdntX1oh/e4Xjf8FMXF0lF808heNev/9tBtC0H1aqRc
	 n+gFYSXrrItjQu+1DxEIuOJjtuUtMV6C+TJ++NyW2pBC7Ru14ALYkiTrG83ssW5iCY
	 wktfpuJXh4kDtVBL2CPyUKPnF2ZiEpl2YJki2ATX7YdudIZRDuKzcP/ykQ0xyf1WkM
	 F9ivRNDiUSjnQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CB64988B5F;
 Thu,  3 Oct 2024 22:37:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727987865;
 bh=rxa+N7g0nSmn5Q8LQ9wAcbFT7ZkruIr7pbh8Gajz8O8=;
 h=From:To:Cc:Subject:Date:From;
 b=m55qD3FZo6lECzCkmIkPjs48/mZEIdTSuhwxy/KyOYbaP73g7Am2blM+3HVYditnQ
 t6aFj4tGA3UcaM0n87+7+bF+laPbt5lMRizwMMQ1cIXqFnOVJhvsYmZMfJJnWPd0yu
 kzKA9Nsimf7jNPw4hdBpMF/mP6nx9h2jz0tvyTEO+sR4yCOWR6kU+pS4DaCBtYsI9O
 oIiZua7/9peKpccR6sFV+YXz/FXcfHlVq4N/PsktQ3jO8RrhlZhOfRvUh6ZEZhErtq
 zEHCPuS4yU7xgArbTI00K5KvchqY90nkqHiP3lGVNFemVCxE97rNPQNwEfTM9Z7I5Q
 OmgEHg3SkaFZg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] sandbox: i2c: Make sure phandle dependency is probed
Date: Thu,  3 Oct 2024 22:37:18 +0200
Message-ID: <20241003203736.298649-1-marex@denx.de>
X-Mailer: git-send-email 2.45.2
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

This driver depends on i2c emulator via DT phandle. Make sure the
dependency is probed before this driver is probed, not when it is
first used during transfer. This fixes the following i2c_emul_find()
error:

"
$ ./u-boot -Dc ""
...
       i2c_emul_find() No emulators for device 'sandbox_pmic'
  sandbox_pmic_write() write error to device: 0000000018c568d0 register: 0x0!
       out_set_value() PMIC write failed: -5
       i2c_emul_find() No emulators for device 'sandbox_pmic'
  sandbox_pmic_write() write error to device: 0000000018c568d0 register: 0x0!
       out_set_value() PMIC write failed: -5
...
"

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Heiko Schocher <hs@denx.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/i2c/sandbox_i2c.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/i2c/sandbox_i2c.c b/drivers/i2c/sandbox_i2c.c
index 74bb5e93397..9a39ac14fb4 100644
--- a/drivers/i2c/sandbox_i2c.c
+++ b/drivers/i2c/sandbox_i2c.c
@@ -80,6 +80,14 @@ static int sandbox_i2c_xfer(struct udevice *bus, struct i2c_msg *msg,
 	return ops->xfer(emul, msg, nmsgs);
 }
 
+static int sandbox_i2c_probe(struct udevice *dev)
+{
+	struct udevice *emul;
+
+	return uclass_get_device_by_phandle(UCLASS_I2C_EMUL, dev,
+					    "sandbox,emul", &emul);
+}
+
 static const struct dm_i2c_ops sandbox_i2c_ops = {
 	.xfer		= sandbox_i2c_xfer,
 };
@@ -95,4 +103,5 @@ U_BOOT_DRIVER(sandbox_i2c) = {
 	.of_match = sandbox_i2c_ids,
 	.ops	= &sandbox_i2c_ops,
 	.priv_auto	= sizeof(struct sandbox_i2c_priv),
+	.probe	= sandbox_i2c_probe,
 };
-- 
2.45.2

