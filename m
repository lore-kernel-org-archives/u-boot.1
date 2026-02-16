Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A3EE83837
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 21:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8BFA83E13;
	Mon, 16 Feb 2026 22:23:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 156F683B8A; Mon, 16 Feb 2026 22:22:48 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 373398063E
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 22:22:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vs633-000000002hU-0kO7; Mon, 16 Feb 2026 21:22:29 +0000
Date: Mon, 16 Feb 2026 21:22:25 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Daniel Golle <daniel@makrotopia.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de
Cc: John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
Subject: [RFC PATCH 07/20] cmd: ubi: add ubi_part_from_mtd()
Message-ID: <e1bc542281183104a3f462c4e6da7e060e3a4efe.1771275704.git.daniel@makrotopia.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771275704.git.daniel@makrotopia.org>
X-Mailman-Approved-At: Mon, 16 Feb 2026 22:22:55 +0100
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

Add ubi_part_from_mtd() which attaches UBI to a given struct mtd_info
directly, without going through the name-based lookup that ubi_part()
uses. This is useful for callers that already hold a reference to the
MTD device, e.g. after finding it via its device-tree node.

If the same MTD device is already attached, the function returns
immediately.

Declared in include/ubi_uboot.h alongside ubi_part().

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 cmd/ubi.c           | 23 +++++++++++++++++++++++
 include/ubi_uboot.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index ca7d657aa07..9f73c36aaa9 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -662,6 +662,29 @@ static int ubi_detach(void)
 	return 0;
 }
 
+int ubi_part_from_mtd(struct mtd_info *mtd)
+{
+	int err;
+
+	if (ubi && ubi->mtd == mtd) {
+		printf("UBI partition '%s' already selected\n", mtd->name);
+		return 0;
+	}
+
+	ubi_detach();
+
+	err = ubi_dev_scan(mtd, NULL);
+	if (err) {
+		printf("UBI init error %d\n", err);
+		printf("Please check, if the correct MTD partition is used (size big enough?)\n");
+		return err;
+	}
+
+	ubi = ubi_devices[0];
+
+	return 0;
+}
+
 int ubi_part(char *part_name, const char *vid_header_offset)
 {
 	struct mtd_info *mtd;
diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
index 92892704d0a..8f3fb007b0e 100644
--- a/include/ubi_uboot.h
+++ b/include/ubi_uboot.h
@@ -48,6 +48,7 @@ extern int ubi_mtd_param_parse(const char *val, struct kernel_param *kp);
 extern int ubi_init(void);
 extern void ubi_exit(void);
 extern int ubi_part(char *part_name, const char *vid_header_offset);
+int ubi_part_from_mtd(struct mtd_info *mtd);
 extern int ubi_volume_write(char *volume, void *buf, loff_t offset, size_t size);
 extern int ubi_volume_read(char *volume, char *buf, loff_t offset, size_t size);
 struct ubi_volume *ubi_find_volume(const char *volume);
-- 
2.53.0
