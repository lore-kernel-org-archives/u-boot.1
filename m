Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21C4D64072
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 18:53:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EFC98900E;
	Fri,  8 Nov 2024 19:53:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731092003;
	bh=wzFOJ8DSvRjv6IjfqPFmh9+bMS2rlXa3O9boEO0zdho=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uS9lTp9l9WfSRQFPKfIhI5KcBylu6L2Mk/fosrbPVFYh9EQA+4Y3OmTpPwlFCg3oU
	 JdzkTcsTO27c9RrCVgVmguiHGDfw6B/xt+2n37xktAgWIuM72JNgd7pBIeQoW9fQ+N
	 4bm+rppcR5SWZn5uJiRpi2q3+Hp38heQsegO6Dm52mBbsDmAPGRXXz304CU+akXN+i
	 TDcWWT1yQYI/Z+uFlayHkewA3A7iYw5TFhSMw/d4SBt0l+KyUinmEUxyHReVHFFPNP
	 IKtvxEq4/IQieM0QHzXrdK3rkVF1yVVyVRrru5stdGlflqYoUmOkeT0tocyjR949SM
	 FUx0PH9lBooig==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 8216A88E26;
 Fri,  8 Nov 2024 19:53:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731092001;
 bh=wzFOJ8DSvRjv6IjfqPFmh9+bMS2rlXa3O9boEO0zdho=;
 h=From:To:Cc:Subject:Date:From;
 b=BBae4w53w0SuP4bh+pC0YhNncd6ORFHhWTsF4mdKf250xjJDgIPSQxBQFvdqS9iSg
 D8Uou78ypmHKOi1B3IRYtmqszKJXu5ihFELbsN+KNfsGuDr61vgJY77Rtmlp3HRmsT
 nRtjJ7gaXXGJ1/wFF40JLJQrOoHRixkEG1iew0tzGY0vd6pb+sAX2+xPjXKsuyrCtp
 4w0KF/osX3nV9KatMGHjZ+2KwOr6cZR/QNbmehHEOCavcjZf5WhAoInVaLHYNaIR69
 iUgSRp077ymu/VE3lV1kRNhiGDCtAKfqDb7zhCVp8Pvck30plWrzMp7dlmiyZSjXM9
 3WrtF6mWzQitg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
Subject: [PATCH] eeprom: at24: add ST M24256E Additional Write lockable page
 support
Date: Fri,  8 Nov 2024 19:52:26 +0100
Message-ID: <20241108185302.139487-1-marex@denx.de>
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

The ST M24256E behaves as a regular M24C256, except for the E variant
which uses up another I2C address for Additional Write lockable page.
This page is 64 Bytes long and can contain additional data. Add entry
for it, so users can describe that page in DT. Note that users still
have to describe the main M24C256 area separately as that is on separate
I2C address from this page.

Unlike M24C32-D and M24C64-D, this part is specifically ST and does not
have any comparable M24* counterparts from other vendors, hence the st,
vendor prefix. Furthermore, the part name is M24256E without C between
the 24 and 256, this is not a typo. Finally, there is M24C256-D part,
which does contain 32 Bytes long Additional Write lockable page, which
is a different part and not supported by this patch.

Datasheet: https://www.st.com/resource/en/datasheet/m24256e-f.pdf

From Linux kernel commit:
339cb28b9ee6 ("eeprom: at24: add ST M24256E Additional Write lockable page support")

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 drivers/misc/i2c_eeprom.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/misc/i2c_eeprom.c b/drivers/misc/i2c_eeprom.c
index 10f0173d805..3cb38aa28ad 100644
--- a/drivers/misc/i2c_eeprom.c
+++ b/drivers/misc/i2c_eeprom.c
@@ -264,6 +264,13 @@ static const struct i2c_eeprom_drv_data atmel24c256_data = {
 	.offset_len = 2,
 };
 
+static const struct i2c_eeprom_drv_data st24256e_wlp_data = {
+	.size = 64,
+	.pagesize = 64,
+	.addr_offset_mask = 0,
+	.offset_len = 2,
+};
+
 static const struct i2c_eeprom_drv_data atmel24c512_data = {
 	.size = 65536,
 	.pagesize = 64,
@@ -287,6 +294,7 @@ static const struct udevice_id i2c_eeprom_std_ids[] = {
 	{ .compatible = "atmel,24c128", (ulong)&atmel24c128_data },
 	{ .compatible = "atmel,24c256", (ulong)&atmel24c256_data },
 	{ .compatible = "atmel,24c512", (ulong)&atmel24c512_data },
+	{ .compatible = "st,24256e-wl", (ulong)&st24256e_wlp_data },
 	{ }
 };
 
-- 
2.45.2

