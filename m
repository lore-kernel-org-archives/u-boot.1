Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA9EC8303F
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 12:40:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8A7180E9A;
	Wed,  2 Jul 2025 14:40:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="TbYRGr/J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E798982B18; Wed,  2 Jul 2025 11:23:18 +0200 (CEST)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57AA680E9A
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 11:23:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DA79A432BD;
 Wed,  2 Jul 2025 09:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1751448194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8UwGZvSD2vMzAFqpBtuBHuSfDb1NeKhfhZdvhV0qCE8=;
 b=TbYRGr/Jo2adQHG044zd8SZF/Bk7Bz8wDm1FVgz1TxmOwK1AxW0Vv6003qhdCic1jz3hFs
 GLTBQh8QdU9voDM770Vcl5GZW9xAGXYb31iUjWNezLZJPPnccXABHVQdVdcyAIaMn4WLS3
 jzxcGpKLXbHQBH5a8z/NieeTVjSaNHx3xQLDzIGfOPlDI34p2x0mQpd4qeDPw8kHhVlah4
 rh73SgqevPw8dSm9X0XrgAierBdRsFq+JFMHQm3l97Ku5HCNnUOn5uqZwDKtB+ftwaf77k
 9OkAN4IA7Chr7OLb6VrSoS6J9FScyr6GXq8mi2GTuq+Bpbq8nD7/3Zs+Szm6eA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Tom Rini <trini@konsulko.com>
Cc: Steam Lin <stlin2@winbond.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, <u-boot@lists.denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH] mtd: spi-nor: winbond: Make sure w25q{01,
 02}jv behave correctly
Date: Wed,  2 Jul 2025 11:23:13 +0200
Message-ID: <20250702092313.970234-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeuieelleetgefghfefvefhiefhfeefvddtvdfgledvjeeljeevleeugeegveelheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehffidrrddpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeejpdhrtghpthhtohepjhgrghgrnhesrghmrghruhhlrghsohhluhhtihhonhhsrdgtohhmpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehsthhlihhnvdesfihinhgsohhnugdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhin
 hdrtghomhdprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdprhgtphhtthhopehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Wed, 02 Jul 2025 14:39:59 +0200
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

These chips are internally made of two/four dies with linear addressing
capabilities to make it transparent to the user that two/four dies were
used. There is one drawback however, the read status operation is racy
as the status bit only gives the active die status and not the status of
the other die. For commands affecting the two dies, it means if another
command is sent too fast after the first die has returned a valid
status (deviation can be up to 200us), the chip will get corrupted/in an
unstable state.

The solution adopted here is to iterate manually over all internal
dies (which takes about 30us per die) until all are ready. This approach
will always be faster than a blind delay which represents the maximum
deviation, while also being totally safe.

A flash-specific hook for the status register read had to be
implemented. Testing with the flash_speed benchmark in Linux shown no
difference with the existing performances (using the regular status read
core function).

As the presence of multiple dies is not filled in these chips SFDP
tables (the table containing the crucial information is optional), we
need to manually wire the hook.

This change is adapted from Linux.

Link: https://lore.kernel.org/all/20250110-winbond-6-12-rc1-nor-volatile-bit-v3-1-735363f8cc7d@bootlin.com/
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/spi/spi-nor-core.c | 101 +++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 6f352c5c0e2d..ab0baf4eb251 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -4215,6 +4215,90 @@ static struct spi_nor_fixups macronix_octal_fixups = {
 };
 #endif /* CONFIG_SPI_FLASH_MACRONIX */
 
+#if CONFIG_IS_ENABLED(SPI_FLASH_WINBOND)
+
+#define WINBOND_NOR_OP_SELDIE  0xc2    /* Select active die */
+
+struct winbond_nor_priv {
+	unsigned int n_dice;
+};
+
+/**
+ * winbond_nor_select_die() - Set active die.
+ * @nor:       pointer to 'struct spi_nor'.
+ * @die:       die to set active.
+ *
+ * Certain Winbond chips feature more than a single die. This is mostly hidden
+ * to the user, except that some chips may experience time deviation when
+ * modifying the status bits between dies, which in some corner cases may
+ * produce problematic races. Being able to explicitly select a die to check its
+ * state in this case may be useful.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int winbond_nor_select_die(struct spi_nor *nor, u8 die)
+{
+	struct spi_mem_op op =
+		SPI_MEM_OP(SPI_MEM_OP_CMD(WINBOND_NOR_OP_SELDIE, 1),
+			   SPI_MEM_OP_NO_ADDR,
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_DATA_OUT(1, &die, 0));
+
+	int ret;
+
+	spi_nor_setup_op(nor, &op, SNOR_PROTO_1_1_1);
+	ret = spi_mem_exec_op(nor->spi, &op);
+	if (ret)
+		debug("Error %d selecting die %d\n", ret, die);
+
+	return ret;
+}
+
+static int winbond_nor_multi_die_ready(struct spi_nor *nor)
+{
+	struct winbond_nor_priv *winbond_priv = nor->priv;
+	unsigned int n_dice = winbond_priv ? winbond_priv->n_dice : 1;
+	int ret, i;
+
+	for (i = 0; i < n_dice; i++) {
+		ret = winbond_nor_select_die(nor, i);
+		if (ret)
+			return ret;
+
+		ret = spi_nor_sr_ready(nor);
+		if (ret <= 0)
+			return ret;
+	}
+
+	return 1;
+}
+
+static void winbond_nor_multi_die_post_sfdp_fixups(struct spi_nor *nor,
+						   struct spi_nor_flash_parameter *param)
+{
+	struct winbond_nor_priv *winbond_priv;
+
+	winbond_priv = kmalloc(sizeof(*winbond_priv), GFP_KERNEL);
+	if (!winbond_priv)
+		return;
+
+	winbond_priv->n_dice = param->size / SZ_64M;
+
+	/*
+	 * SFDP supports dice numbers, but this information is only available in
+	 * optional additional tables which are not provided by these chips.
+	 * Dice number has an impact though, because these devices need extra
+	 * care when reading the busy bit.
+	 */
+	nor->priv = winbond_priv;
+	nor->ready = winbond_nor_multi_die_ready;
+}
+
+static struct spi_nor_fixups winbond_nor_multi_die_fixups = {
+	.post_sfdp = winbond_nor_multi_die_post_sfdp_fixups,
+};
+#endif /* CONFIG_SPI_FLASH_WINBOND */
+
 /** spi_nor_octal_dtr_enable() - enable Octal DTR I/O if needed
  * @nor:                 pointer to a 'struct spi_nor'
  *
@@ -4426,6 +4510,23 @@ void spi_nor_set_fixups(struct spi_nor *nor)
 	    nor->info->flags & SPI_NOR_OCTAL_DTR_READ)
 		nor->fixups = &macronix_octal_fixups;
 #endif /* SPI_FLASH_MACRONIX */
+
+#if CONFIG_IS_ENABLED(SPI_FLASH_WINBOND)
+	if (JEDEC_MFR(nor->info) == SNOR_MFR_WINBOND) {
+		u8 multi_die_models[][2] = {
+			{ 0x40, 0x21 }, /* W25Q01JV */
+			{ 0x70, 0x22 }, /* W25Q02JV */
+		};
+		int i;
+
+		for (i = 0; i < sizeof(multi_die_models) / 2; i++) {
+			if (!memcmp(nor->info->id + 1, multi_die_models[i], 2)) {
+				nor->fixups = &winbond_nor_multi_die_fixups;
+				break;
+			}
+		}
+	}
+#endif /* SPI_FLASH_WINBOND */
 }
 
 int spi_nor_scan(struct spi_nor *nor)
-- 
2.49.0

