Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99F6CA5FCE
	for <u-boot@archiver.kernel.org>; Sun,  4 Oct 2026 04:07:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C77480F65;
	Sun,  4 Oct 2026 04:07:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ua3J5WJ1EVQB; Sun,  4 Oct 2026 04:07:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8322C80F3F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791086844;
	b=Z8OAm7iHdfBcz96HeZ4hVB/bWu1YcO4/GHH9t7zpDLkE4UrGuoyWaa3VzDYZm2OZJeYQ
	 EZMq+gLKbn0+VvNeANmMkrZYQ7007sIDEzn/15aXliUB2TGq8wDt6j/+8N1ZsPeQDTqQv
	 sLRw3bajivosKL8oGwZ/FqENrySnA1G26Phts5/5uOFZgHkmcHoFQMqZki/j1MRsVp2SZ
	 ULMVQ9hgFz0x9NI8/nVBSmUGN5VgvUKIQy1KHkt/LfY0UbYkS8m2bSH/7RUdlEMJ0NxpV
	 LN6hO3QBDHxQGfyVknSyvXA4KgsYWnYYOleNd8Hlylc5Ptuen4NsazNAdd9z9AXrhtw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791086844;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8/FovMhhWp2Bk4GdiBIty25+A+6IlNUwug6A9AGtslo=;
	b=ZGmSyrPAhb5pawnvHeOdPwgxqD2xDVk+N31d3CXcKQ98rmlZPdS+IZRhjW4OPvuEx7aG
	 B0PGYXCTW6Kabc/0EbXwTVHjSyTvJn2AiMLNPMfebMFqa+wTunaXg6R1Q5tW08zbCLSL9
	 nkKgMmVyEEp+6rS9anqbhHhyo5htVv2u3wF7Tb+a5XZTX9itOO5q991Clh6aokr4SAKVU
	 TyJ7hIc37SdGz7Qgql8DODSnKkvfrhZJlsYKtWkwSr+zf3QeX0DfWZKjwa645zF2P1Jdw
	 xxbK9vQRN8cpfaKob/U1KDpsBIyXmArd+OqDZe7HywE7qLFEzwzhynxrc0G1XyMg/6g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=nabladev.com;
	dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b="GEgeeVi/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791086844;
	bh=8/FovMhhWp2Bk4GdiBIty25+A+6IlNUwug6A9AGtslo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BlCnu+duW9TAw6aodCZENr1Zjpy0Mj9RJcH+mCUGG0mHCSchPMmx9n9W7kvgKvwyk
	 wx1kT1O1FU65zSmHs2f3SxYYzHKnYhGijwNohcPMU9l+aQlDp3pW01caAyqYakSQMX
	 yUxntxghDPzS8uZFsuOGKpp40ZfzRCGlCDRUYrYQ14DpmrQrNejnge8u+zOLJIie54
	 1SPFXIHKEgiVU2h4mefW11AGaUtl+6Ihe5/l39MBwQfwtjrpsJ8wYg+qRGLXo+CzwT
	 PZLPmnppsg9Lg9LAHwoxt3BluXH+oYJ68BF/2ks/9lsLGd4Nn34j4OaGerINUp+XgY
	 9M3rWVOry0mxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8322C80F3F;
	Sun,  4 Oct 2026 04:07:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 339161D2
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 04:07:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 24FEA80F06
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 04:07:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZDgaRwmdEOnT for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 04:07:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F07E480934
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791086836;
 b=C+Ve3jgkN473BtQhlEvxWM73mZinaFeBUERax7met6vhDyuzQ8Bun0Q4G9Vl/vKloqmF
 LngavHVcqeLxZZSZ/Xf3CedkW1wcqrCcP5eyvE7lLovMp9vq48Hu+asjb2d90bG04yJwY
 2HTtyglvDEN96+eu0G2db0cFW3B0jOzA8ZnSb3WIIB5i4OxV38GHmQE3XsgoDB1jjg9Z8
 f72kcMK2XTkXfbASW38q1WJbDtLuqyR+6gPIG29sLRJ0X+vvps3KGM67fp+jjA9Wi1tYn
 gCxlPuylPvzWTGZ0aQYtDUl+nk0+BoYlMwG/9aFLxXzbRoEphHtAzR/3US7erwIN6Gg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791086836;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=8/FovMhhWp2Bk4GdiBIty25+A+6IlNUwug6A9AGtslo=;
 b=Ew0caMcIcO/x04A44i8pPD0+9egJ8IpK5gc6OUjL8VTRla9cIVjkfYzP34nMXWKjwrkh
 jk4xYndQGgaY2cS8PlXsfE9RZj0h9mn6vjf7Gyu+Zzsuh1oxnTybqG2LmW7n17DOehc9R
 QIbwzBtETQpmfRPI86e0JTivftV8Yw2DFno2phk0J/8Z28FK5XYRKUup799+XCXKLKLH7
 f7iDR+5k9q4uTtrymaDZ5ygmmd2NgkDpPWOGLwS1/VwhFAjjvuGbJj41+8zOtGL5eihdT
 tLp38phreBRGFae+oBevrEGvYW8evB+arQeyf3SDWkubYaaUqREId00ReflP0D1mH9w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=nabladev.com; 
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b="GEgeeVi/"; 
 arc=none smtp.remote-ip=178.251.229.89
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=178.251.229.89;
 helo=mx.nabladev.com; envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com
 header.a=rsa-sha256 header.s=dkim header.b=GEgeeVi/
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F07E480934
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 04:07:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 24659107A29; Sun, 04 Oct 2026 06:07:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1791086832; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=8/FovMhhWp2Bk4GdiBIty25+A+6IlNUwug6A9AGtslo=;
 b=GEgeeVi/WnLWl8keYQw7lpHztc2ueYlVf/UCfgUnGO50ShVUyoMAkUqZJXJ3J7ZrvgMUln
 CFTGOtuBNZnUrAuHEhVDMz+38dOHmvd5A+zZFTRrvUIN7YvPDDYyATA/DW3rNilxsDELiw
 IGefIOlF/fjRwAgafzm7hkgJrmfbqBoIsr7BrY/TyNxXCPzKlMP5ZUal5G/lkwLh6uCm1J
 5DeVe+UfIu0SdJiUJdddfk2uwuOdeQQlHjwgU4MV8uCcXanOrmtxffBhDAp9+LNVKrurA7
 Kdm24tG9AToXqHPDv+5++1BMqN+sPHTeDWV1KOqjWo3hxP2yU7gvBTZgGH3JIQ==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Vignesh R <vigneshr@ti.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Heiko Schocher <hs@nabladev.com>, Cole Munz <Munzzyy1@proton.me>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 4/5] sandbox: spi: let a slave point at the emulation it
 needs
Date: Sun,  4 Oct 2026 06:06:48 +0200
Message-ID: <20261004040657.3156402-5-hs@nabladev.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004040657.3156402-1-hs@nabladev.com>
References: <20261004040657.3156402-1-hs@nabladev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

sandbox_sf_bind_emul() binds the SPI NOR flash emulator for every slave
on the sandbox SPI bus, whatever that slave is, so a device of another
kind cannot be emulated and cannot be tested.

As with I2C and PCI, a slave can point to an emulation node via a
sandbox,emul phandle. Its compatible selects the driver. Without the
property, the flash emulator remains bound to the slave node as before.

Rename sandbox_sf_unbind_emul() to sandbox_spi_unbind_emul() while
here. It is no longer specific to SPI NOR, and the old name would
mislead every new caller.

Signed-off-by: Heiko Schocher <hs@nabladev.com>
---
checkpatch warns "strlcpy is preferred over strncpy" on
drivers/mtd/spi/sandbox.c:562. That line is not new, it is there since
since commit b6c2956defb4 ("dm: sf: sandbox: Convert SPI flash driver
to driver model"). So ignoring this warning.

Changes in v2:
Added comments from Simon:
- sandbox,emul is a phandle to an emulation node whose compatible
  selects the driver, instead of a string naming a U-Boot driver. That
  property is already a phandle for I2C and PCI, and dtoc treats it as
  one, so v1 would have given the same name two meanings.
- Renamed sandbox_sf_unbind_emul() to sandbox_spi_unbind_emul(), it is
  no longer specific to SPI NOR.
- The error paths name the driver or the node that could not be bound.

 drivers/mtd/spi/sandbox.c | 65 +++++++++++++++++++++++++++++++--------
 include/spi_flash.h       |  2 +-
 test/dm/sf.c              |  4 +--
 test/dm/spi.c             | 10 +++---
 4 files changed, 61 insertions(+), 20 deletions(-)

diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
index e5ebc3479fb..66c72ed02e1 100644
--- a/drivers/mtd/spi/sandbox.c
+++ b/drivers/mtd/spi/sandbox.c
@@ -26,6 +26,8 @@
 #include <dm/lists.h>
 #include <dm/uclass-internal.h>
 
+#define SANDBOX_SF_EMUL		"sandbox_sf_emul"
+
 /*
  * The different states that our SPI flash transitions between.
  * We need to keep track of this across multiple xfer calls since
@@ -518,39 +520,78 @@ static const struct dm_spi_emul_ops sandbox_sf_emul_ops = {
 };
 
 #ifdef CONFIG_SPI_FLASH
-int sandbox_sf_bind_emul(struct sandbox_state *state, int busnum, int cs,
-			 struct udevice *bus, ofnode node, const char *spec)
+/**
+ * sandbox_spi_emul_lookup() - bind the emulator standing in for a slave
+ *
+ * A slave points at its emulation with a "sandbox,emul" phandle, the way
+ * the I2C and PCI emulations do, and the compatible of that node selects
+ * the driver. Without the property the SPI NOR flash emulator is bound on
+ * the slave's own node, which is what every existing node relies on.
+ *
+ * @bus:	SPI bus the emulator becomes a child of
+ * @node:	device tree node of the slave
+ * @spec:	name of the slave, used to name the flash emulator
+ * @emulp:	returns the bound emulator
+ * Return: 0 on success, negative on error
+ */
+static int sandbox_spi_emul_lookup(struct udevice *bus, ofnode node,
+				   const char *spec, struct udevice **emulp)
 {
-	struct udevice *emul;
+	struct ofnode_phandle_args args;
 	char name[20], *str;
 	struct driver *drv;
 	int ret;
 
-	/* now the emulator */
-	strncpy(name, spec, sizeof(name) - 6);
-	name[sizeof(name) - 6] = '\0';
-	strcat(name, "-emul");
-	drv = lists_driver_lookup_name("sandbox_sf_emul");
+	if (!ofnode_parse_phandle_with_args(node, "sandbox,emul", NULL, 0, 0,
+					    &args)) {
+		ret = lists_bind_fdt(bus, args.node, emulp, NULL, false);
+		if (ret)
+			printf("Cannot bind emulator from node '%s' (err=%d)\n",
+			       ofnode_get_name(args.node), ret);
+
+		return ret;
+	}
+
+	drv = lists_driver_lookup_name(SANDBOX_SF_EMUL);
 	if (!drv) {
-		puts("Cannot find sandbox_sf_emul driver\n");
+		printf("Cannot find SPI emulation driver '%s'\n",
+		       SANDBOX_SF_EMUL);
 		return -ENOENT;
 	}
+
+	strncpy(name, spec, sizeof(name) - 6);
+	name[sizeof(name) - 6] = '\0';
+	strcat(name, "-emul");
 	str = strdup(name);
 	if (!str)
 		return -ENOMEM;
-	ret = device_bind(bus, drv, str, NULL, node, &emul);
+
+	ret = device_bind(bus, drv, str, NULL, node, emulp);
 	if (ret) {
 		free(str);
 		printf("Cannot create emul device for spec '%s' (err=%d)\n",
 		       spec, ret);
-		return ret;
 	}
+
+	return ret;
+}
+
+int sandbox_sf_bind_emul(struct sandbox_state *state, int busnum, int cs,
+			 struct udevice *bus, ofnode node, const char *spec)
+{
+	struct udevice *emul;
+	int ret;
+
+	ret = sandbox_spi_emul_lookup(bus, node, spec, &emul);
+	if (ret)
+		return ret;
+
 	state->spi[busnum][cs].emul = emul;
 
 	return 0;
 }
 
-void sandbox_sf_unbind_emul(struct sandbox_state *state, int busnum, int cs)
+void sandbox_spi_unbind_emul(struct sandbox_state *state, int busnum, int cs)
 {
 	struct udevice *dev;
 
diff --git a/include/spi_flash.h b/include/spi_flash.h
index 2e703e85250..d5a20ea815c 100644
--- a/include/spi_flash.h
+++ b/include/spi_flash.h
@@ -136,7 +136,7 @@ struct sandbox_state;
 int sandbox_sf_bind_emul(struct sandbox_state *state, int busnum, int cs,
 			 struct udevice *bus, ofnode node, const char *spec);
 
-void sandbox_sf_unbind_emul(struct sandbox_state *state, int busnum, int cs);
+void sandbox_spi_unbind_emul(struct sandbox_state *state, int busnum, int cs);
 
 #else
 /* Compatibility functions for when DM_SPI_FLASH is disabled */
diff --git a/test/dm/sf.c b/test/dm/sf.c
index 3684d021709..5959ebb349d 100644
--- a/test/dm/sf.c
+++ b/test/dm/sf.c
@@ -68,7 +68,7 @@ static int dm_test_spi_flash(struct unit_test_state *uts)
 	 * Since we are about to destroy all devices, we must tell sandbox
 	 * to forget the emulation device
 	 */
-	sandbox_sf_unbind_emul(state_get_current(), 0, 0);
+	sandbox_spi_unbind_emul(state_get_current(), 0, 0);
 
 	return 0;
 }
@@ -96,7 +96,7 @@ static int dm_test_spi_flash_func(struct unit_test_state *uts)
 	 * Since we are about to destroy all devices, we must tell sandbox
 	 * to forget the emulation device
 	 */
-	sandbox_sf_unbind_emul(state_get_current(), 0, 0);
+	sandbox_spi_unbind_emul(state_get_current(), 0, 0);
 
 	return 0;
 }
diff --git a/test/dm/spi.c b/test/dm/spi.c
index a0da12ab6bc..1f70ce1a467 100644
--- a/test/dm/spi.c
+++ b/test/dm/spi.c
@@ -57,7 +57,7 @@ static int dm_test_spi_find(struct unit_test_state *uts)
 	ut_asserteq(-ENOENT, _spi_get_bus_and_cs(busnum, cs, speed, mode,
 						 "jedec_spi_nor", "name", &bus,
 						 &slave));
-	sandbox_sf_unbind_emul(state_get_current(), busnum, cs);
+	sandbox_spi_unbind_emul(state_get_current(), busnum, cs);
 	ut_assertok(spi_cs_info(bus, cs, &info));
 	ut_asserteq_ptr(NULL, info.dev);
 
@@ -84,8 +84,8 @@ static int dm_test_spi_find(struct unit_test_state *uts)
 	 * Since we are about to destroy all devices, we must tell sandbox
 	 * to forget the emulation device
 	 */
-	sandbox_sf_unbind_emul(state_get_current(), busnum, cs);
-	sandbox_sf_unbind_emul(state_get_current(), busnum, cs_b);
+	sandbox_spi_unbind_emul(state_get_current(), busnum, cs);
+	sandbox_spi_unbind_emul(state_get_current(), busnum, cs_b);
 
 	return 0;
 }
@@ -210,7 +210,7 @@ static int dm_test_spi_xfer(struct unit_test_state *uts)
 	 * to forget the emulation device
 	 */
 #if CONFIG_IS_ENABLED(DM_SPI_FLASH)
-	sandbox_sf_unbind_emul(state_get_current(), busnum, cs);
+	sandbox_spi_unbind_emul(state_get_current(), busnum, cs);
 #endif
 
 	return 0;
@@ -249,7 +249,7 @@ static int dm_test_spi_xfer_no_rx_tx(struct unit_test_state *uts)
 	 * to forget the emulation device
 	 */
 #if CONFIG_IS_ENABLED(DM_SPI_FLASH)
-	sandbox_sf_unbind_emul(state_get_current(), busnum, cs);
+	sandbox_spi_unbind_emul(state_get_current(), busnum, cs);
 #endif
 
 	return 0;
-- 
2.55.0

