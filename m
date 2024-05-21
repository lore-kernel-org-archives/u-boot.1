Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7EBC25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 07:15:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B3B988708;
	Tue, 21 May 2024 09:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P5SMslKM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1963D886FF; Tue, 21 May 2024 09:14:05 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D014688730
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 09:14:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 1C269CE0E6C;
 Tue, 21 May 2024 07:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A37C4AF08;
 Tue, 21 May 2024 07:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716275639;
 bh=84VKJBZAAuBfcfYDVLAvI4efBCusskLSv/iJvfdOIpA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P5SMslKMSS/0ziI+TlbaiL1nCIcZQOdQn1tZ4K26HWgVBUD4AFE45fQfrkmiY81YS
 UOhT7ny0OeJj/UwdXMyoJMs/euV6xPF5LEOmv2aqnQPiYCE2us/Om6m0XKZm7xFRPx
 Tqc1ZXNf0ESIeyref7DZS/XJHpjAxn8r0x+YA4tSgMmvH4q/BP7cBPV+yRbcYSZ1qT
 0It0w0Tc/JlBGDKewiGtZVxS/q7Xrhlzt6Ge+FbcjS1MLLBkHfUWeb6UFqyDxhj8RX
 ISw3d32C1i3sfA4AQb/UL8viGwk3bTkiXHzUBasnBGEEWoLHdjVHeovYXGqsAbSnQK
 j/1MRymaUli8Q==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Stefan Roese <sr@denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nikita Kiryanov <nikita@compulab.co.il>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 10/11] cmd: eeprom: Don't read/write whole EEPROM if not
 necessary
Date: Tue, 21 May 2024 09:13:34 +0200
Message-ID: <20240521071335.4193-11-kabel@kernel.org>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240521071335.4193-1-kabel@kernel.org>
References: <20240521071335.4193-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Don't read/write whole EEPROM if not necessary when printing / updating
EEPROM layout fields. Only read/write layout.data_size bytes.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 cmd/eeprom.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/cmd/eeprom.c b/cmd/eeprom.c
index c76cf43157..9c4af88738 100644
--- a/cmd/eeprom.c
+++ b/cmd/eeprom.c
@@ -311,16 +311,10 @@ static int do_eeprom_rw(struct eeprom_dev_spec *dev, bool read,
 static int do_eeprom_layout(struct eeprom_dev_spec *dev, int layout_ver,
 			    struct eeprom_layout *layout)
 {
-	int ret;
-
-	ret = eeprom_read(dev->i2c_addr, 0, eeprom_buf, CONFIG_SYS_EEPROM_SIZE);
-	if (ret)
-		return ret;
-
 	eeprom_layout_setup(layout, eeprom_buf, CONFIG_SYS_EEPROM_SIZE,
 			    layout_ver);
 
-	return 0;
+	return eeprom_read(dev->i2c_addr, 0, eeprom_buf, layout->data_size);
 }
 
 static int do_eeprom_print(struct eeprom_dev_spec *dev, int layout_ver)
@@ -351,8 +345,7 @@ static int do_eeprom_update(struct eeprom_dev_spec *dev, int layout_ver,
 	if (ret)
 		return CMD_RET_FAILURE;
 
-	return eeprom_write(dev->i2c_addr, 0, layout.data,
-			    CONFIG_SYS_EEPROM_SIZE);
+	return eeprom_write(dev->i2c_addr, 0, layout.data, layout.data_size);
 }
 
 #endif
-- 
2.44.1

