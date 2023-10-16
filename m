Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469E7CDB47E
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 00:05:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DABB867F6;
	Mon, 16 Oct 2023 02:05:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697414701;
	bh=/Ku0ClLR/U+MIAIDlcO1FiRvmL3vNEnD8RlFAcS0lD0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jI7CmwaGgxwQmH1p/na73QVWl4f268XDxPRqWPm8es9dnA2RZ4sifLoDo3Hgj7of7
	 g6jrtz228W5zMHOGyku92pZkPqDQaBCKi9TuNqNes/B7XG3SWqx39f6BT2BIq2SiQj
	 ULWA3QHBpkedn7tnAGWXhW4TQuRsYBnbfVUjpLVJkHrpmjTQeDVeP+U9owBVBzdvCG
	 V4aBoE2HGBwkQrN5TKre/Sdz4CeQU5CMr5e/JkUydw/DugkFcT4Yg2j3TYYC7vzujr
	 LXxWSei6vlsQCbe++i3Oec58NZFzC/7bTJr+hHr1ob/R9rq5ou2CNX/sNqGrKF6Qo7
	 0Z4R8fHHYdrsw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1C08886529;
 Mon, 16 Oct 2023 02:05:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697414700;
 bh=/Ku0ClLR/U+MIAIDlcO1FiRvmL3vNEnD8RlFAcS0lD0=;
 h=From:To:Cc:Subject:Date:From;
 b=RFL9QfywKbgtUrzwruIpgGDa/jiY/tZVTT3vP7KGJ7ECkNlSaEKNp1W4pfMJhYVn6
 ETXyrq071/Tb7MiPYt1Ywho0TiNCghdcg1t5/PcdGT4wBDVEcZWRECDLgmSiDlWDf8
 hYMes+HwP0Qkar2mR0SCWprN+Uc+IWRbMOnpcyQ5/ysiXQvtU9NIgg7Ir7wC6dndPC
 ptYc4ZF4AeTwSlKoCf9iu9ef157Stc4JgIa0k3EQ6igq8W93QY7E1sxBDcF36WmZxI
 qEuGm8y7D4h4zMKxT+yWOpMRpuH+IBZAOaC2dQJLLnotx7E4/TB6HzjwJiVeoGCpAK
 KgM6Fm9j8raLw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 u-boot@dh-electronics.com
Subject: [PATCH] eeprom: at24: add ST M24C32-D Additional Write lockable page
 support
Date: Mon, 16 Oct 2023 02:04:33 +0200
Message-ID: <20231016000445.478557-1-marex@denx.de>
X-Mailer: git-send-email 2.42.0
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

The ST M24C32-D behaves as a regular M24C32, except for the -D variant
which uses up another I2C address for Additional Write lockable page.
This page is 32 Bytes long and can contain additional data. Add entry
for it, so users can describe that page in DT. Note that users still
have to describe the main M24C32 area separately as that is on separate
I2C address from this page.

From Linux kernel commit:
4791146e9055 ("eeprom: at24: add ST M24C32-D Additional Write lockable page support")

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: u-boot@dh-electronics.com
---
 drivers/misc/i2c_eeprom.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/misc/i2c_eeprom.c b/drivers/misc/i2c_eeprom.c
index bdd7e018cc6..e1d0b8f918a 100644
--- a/drivers/misc/i2c_eeprom.c
+++ b/drivers/misc/i2c_eeprom.c
@@ -227,6 +227,13 @@ static const struct i2c_eeprom_drv_data atmel24c32_data = {
 	.offset_len = 2,
 };
 
+static const struct i2c_eeprom_drv_data atmel24c32d_wlp_data = {
+	.size = 32,
+	.pagesize = 32,
+	.addr_offset_mask = 0,
+	.offset_len = 2,
+};
+
 static const struct i2c_eeprom_drv_data atmel24c64_data = {
 	.size = 8192,
 	.pagesize = 32,
@@ -266,6 +273,7 @@ static const struct udevice_id i2c_eeprom_std_ids[] = {
 	{ .compatible = "atmel,24c16a", (ulong)&atmel24c16a_data },
 	{ .compatible = "atmel,24mac402", (ulong)&atmel24mac402_data },
 	{ .compatible = "atmel,24c32", (ulong)&atmel24c32_data },
+	{ .compatible = "atmel,24c32d-wl", (ulong)&atmel24c32d_wlp_data },
 	{ .compatible = "atmel,24c64", (ulong)&atmel24c64_data },
 	{ .compatible = "atmel,24c128", (ulong)&atmel24c128_data },
 	{ .compatible = "atmel,24c256", (ulong)&atmel24c256_data },
-- 
2.42.0

