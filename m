Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 249F8C2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 15:36:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EED08842A;
	Tue, 18 Jun 2024 17:35:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I4VRTBrL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B5328844C; Tue, 18 Jun 2024 17:35:00 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53D62883BA
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 17:34:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 360A76199A;
 Tue, 18 Jun 2024 15:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC56C3277B;
 Tue, 18 Jun 2024 15:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718724896;
 bh=Ep4flZGOVvlZlPR7Qu7CVKMrmFCnhW8WSDnXBckZ5Ss=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=I4VRTBrLbj/5Q3JiowItbRRAlB0VGRnK4RX3Nl3/+mNbJGpFWQ+5/MIL7uCjumD3b
 Dz02x1iIbM777GsM10TIyuaZIJnDnnYD4jeKxvSFu7YjT+nMKOgIcqM5uy2WTUZK7Y
 O/tRfYZ25B977IXPUWYgxO14WFFBbiH23BptMIwhbdG89V10rMZADR/9ijNf7UI+bq
 +vSRGYM/MMog0zWf7AF19DeU0ZpJG+AxCBiogsSWK5THi5H3fDaA4qtuobJr4ujjLP
 hYQcS7AoXHSBsw9ExhEmDDD9bsExM2e4crymTI6XYW6E8O/KPhpNtMr74057EkvP+j
 US3kV9o5fPWew==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-marvell 10/16] arm: mvebu: turris_omnia: Extend EEPROM
 info structure
Date: Tue, 18 Jun 2024 17:34:33 +0200
Message-ID: <20240618153439.9518-11-kabel@kernel.org>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240618153439.9518-1-kabel@kernel.org>
References: <20240618153439.9518-1-kabel@kernel.org>
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

Extend the Omnia EEPROM information structure in preparation for more
variables to be stored there.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 board/CZ.NIC/turris_omnia/eeprom.c       | 11 ++++++-
 board/CZ.NIC/turris_omnia/turris_omnia.c | 42 ++++++++++++++++++++----
 2 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/board/CZ.NIC/turris_omnia/eeprom.c b/board/CZ.NIC/turris_omnia/eeprom.c
index a4f1dab469..ea13e95b37 100644
--- a/board/CZ.NIC/turris_omnia/eeprom.c
+++ b/board/CZ.NIC/turris_omnia/eeprom.c
@@ -60,9 +60,13 @@ static struct eeprom_field omnia_layout[] = {
 	_DEF_FIELD("RAM size in GB", 4, ramsz),
 	_DEF_FIELD("Wi-Fi Region", 4, region),
 	_DEF_FIELD("CRC32 checksum", 4, bin),
+	_DEF_FIELD("Extended reserved fields", 44, reserved),
+	_DEF_FIELD("Extended CRC32 checksum", 4, bin),
 };
 
 static struct eeprom_field *crc_field = &omnia_layout[3];
+static struct eeprom_field *ext_crc_field =
+	&omnia_layout[ARRAY_SIZE(omnia_layout) - 1];
 
 static int omnia_update_field(struct eeprom_layout *layout, char *field_name,
 			      char *new_data)
@@ -91,6 +95,11 @@ static int omnia_update_field(struct eeprom_layout *layout, char *field_name,
 		put_unaligned_le32(crc, crc_field->buf);
 	}
 
+	if (field < ext_crc_field) {
+		u32 crc = crc32(0, layout->data, 44);
+		put_unaligned_le32(crc, ext_crc_field->buf);
+	}
+
 	return 0;
 }
 
@@ -99,7 +108,7 @@ void eeprom_layout_assign(struct eeprom_layout *layout, int)
 	layout->fields = omnia_layout;
 	layout->num_of_fields = ARRAY_SIZE(omnia_layout);
 	layout->update = omnia_update_field;
-	layout->data_size = 16;
+	layout->data_size = 64;
 }
 
 int eeprom_layout_detect(unsigned char *)
diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
index 100a991406..c2f91b762f 100644
--- a/board/CZ.NIC/turris_omnia/turris_omnia.c
+++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
@@ -429,12 +429,40 @@ struct omnia_eeprom {
 	u32 ramsize;
 	char region[4];
 	u32 crc;
+
+	/* second part (only considered if crc2 is not all-ones) */
+	u8 reserved[44];
+	u32 crc2;
 };
 
+static bool is_omnia_eeprom_second_part_valid(const struct omnia_eeprom *oep)
+{
+	return oep->crc2 != 0xffffffff;
+}
+
+static void make_omnia_eeprom_second_part_invalid(struct omnia_eeprom *oep)
+{
+	oep->crc2 = 0xffffffff;
+}
+
+static bool check_eeprom_crc(const void *buf, size_t size, u32 expected,
+			     const char *name)
+{
+	u32 crc;
+
+	crc = crc32(0, buf, size);
+	if (crc != expected) {
+		printf("bad %s EEPROM CRC (stored %08x, computed %08x)\n",
+		       name, expected, crc);
+		return false;
+	}
+
+	return true;
+}
+
 static bool omnia_read_eeprom(struct omnia_eeprom *oep)
 {
 	struct udevice *chip;
-	u32 crc;
 	int ret;
 
 	chip = omnia_get_i2c_chip("EEPROM", OMNIA_I2C_EEPROM_CHIP_ADDR,
@@ -455,12 +483,14 @@ static bool omnia_read_eeprom(struct omnia_eeprom *oep)
 		return false;
 	}
 
-	crc = crc32(0, (void *)oep, sizeof(*oep) - 4);
-	if (crc != oep->crc) {
-		printf("bad EEPROM CRC (stored %08x, computed %08x)\n",
-		       oep->crc, crc);
+	if (!check_eeprom_crc(oep, offsetof(struct omnia_eeprom, crc), oep->crc,
+			      "first"))
 		return false;
-	}
+
+	if (is_omnia_eeprom_second_part_valid(oep) &&
+	    !check_eeprom_crc(oep, offsetof(struct omnia_eeprom, crc2),
+			      oep->crc2, "second"))
+		make_omnia_eeprom_second_part_invalid(oep);
 
 	return true;
 }
-- 
2.44.2

