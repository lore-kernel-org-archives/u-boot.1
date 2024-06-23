Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF917C27C4F
	for <u-boot@archiver.kernel.org>; Sun, 23 Jun 2024 07:41:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82F0988168;
	Sun, 23 Jun 2024 09:41:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OuAq9tDJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE20788283; Sun, 23 Jun 2024 09:41:32 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAF6287D10
 for <u-boot@lists.denx.de>; Sun, 23 Jun 2024 09:41:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id B96D46059A;
 Sun, 23 Jun 2024 07:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181F6C2BD10;
 Sun, 23 Jun 2024 07:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1719128487;
 bh=PDg0D8VXaFUZ/Vx3ka9r8MA8qxThXjbFZ9kgtkz9Q9s=;
 h=From:Date:Subject:To:Cc:From;
 b=OuAq9tDJGg1DRXB2pJyerrxCUP449Ra613WLCBbrjVT/Vm1v6u8rflfPlCaytxYxS
 9bc8u2XHYpZRk4HykQT4nttXeg1rMNDT+2Q0+NNVrWEXE1EmTvjjHHDbHxgj7VVzd5
 Y4mbRsgSWv8HgWDNzLyfYNVRyIv/50ocV562PGYB/ABKmbGwN3Sx9ryoM8HvuF0JJs
 XHMaMZmwqLPA3sZF9hZQJgRz2dHviQrulK/WihFDxtrjqGi9abUYuKNFItB34iutIu
 sZ1j5UcftPbiMODOT2IBrWFB9HNXkV81k6tah4J+z5MypIslj4TtqXz+tyakdwFp1/
 twwCxrX1fCVdg==
From: Roger Quadros <rogerq@kernel.org>
Date: Sun, 23 Jun 2024 10:41:19 +0300
Subject: [PATCH] configs: am64x_evm_a53_defconfig: Enable I2C GPIO drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240623-for-2023-10-am64-nand-v1-1-018c591daedd@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJ7Rd2YC/x3MQQqAIBBA0avIrBsYNSK6SrQQnWoWaShEIN49a
 fkW/1conIULLKpC5keKpNihBwX+dPFglNANhsxIk7G4p4wdFjWhu6YRo4sBfWA/E1nvZoLe3pl
 3ef/vurX2Aes5buJnAAAA
To: Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>
Cc: srk@ti.com, praneeth@ti.com, u-boot@lists.denx.de, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=983; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=PDg0D8VXaFUZ/Vx3ka9r8MA8qxThXjbFZ9kgtkz9Q9s=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBmd9Gl/rzssd4SQoxXE7lNEp2EXb+7pMmcYPN9f
 3xMICDDSV6JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZnfRpQAKCRDSWmvTvnYw
 k4mFD/9slT999Kz9iPStUW+tDnANeEHcRhtWz/d4+wKf1+FEgW2Dt2H44g0YMJLrkcaJd0/iqcW
 ctwVyFc56Sjhiy1eHZxhCgb7J9r9GPAFnbsb7EjBBqtmy2oR00l7MwxBaRMiDnXuRdXZKjzSxGP
 71xHaddmxgQu37WZSjqEIv2J1Aw/7vsk3VxRPYRk5EuAMi6qq+WjncbX7fyFsBWKWBZQV+aE2Do
 c+hGMvDCtZlS6fFXWI2VDE8pDqepkt4Po6fUFDtqtVIcl2z7I3gscFVbTJRothpp/T8xyJc975o
 Yvi5eSJSywRa6U6yvi5cz9C3ItVVI0PfWLDDnCaWX7+/3YQs1oNnqljJQZ4Aa9Dn2Gvr/rDiMCq
 TYMcqedd8imNGi/6hfWTtfVJnqCry74jlCOtn2vJ7NU6qGOvFagH4crgbyO/mdS49Calz6eS5d4
 llRpboPQHOA3pT3Rf1dRYvo6u3yKN94A+s7PU3c63Y7AEYjul9WUKfnJjdPIXwU1REtChks8CaQ
 ND1XNyAgmkQbXKlSl7K22uG26BFWDcsWOvSQcMtBcq22m+6KuhMKpfx1pbBWhGe6TPOdYlXMwP0
 ZAcWFx6ZB9ckAhEl9nDiOMfpWIUst/1mq0YWCwqA8vaInmsos3TAODAHiunhZmoIrdTRESW2ytw
 HDK/VIVr79BIk5Q==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093
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

The board has the TCA9554 I2C GPIO expander chip for expansion
board presence detection logic.

Enable the relevant I2C GPIO drivers.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 configs/am64x_evm_a53_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
index e000549d6d0..8411a29a2ae 100644
--- a/configs/am64x_evm_a53_defconfig
+++ b/configs/am64x_evm_a53_defconfig
@@ -103,7 +103,11 @@ CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
 CONFIG_DMA_CHANNELS=y
 CONFIG_TI_K3_NAVSS_UDMA=y
 CONFIG_TI_SCI_PROTOCOL=y
+CONFIG_DM_PCA953X=y
+CONFIG_SPL_DM_PCA953X=y
 CONFIG_DM_I2C=y
+CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
+CONFIG_DM_I2C_GPIO=y
 CONFIG_SYS_I2C_OMAP24XX=y
 CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y

---
base-commit: fe2ce09a0753634543c32cafe85eb87a625f76ca
change-id: 20240623-for-2023-10-am64-nand-cdec8003ca80

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>

