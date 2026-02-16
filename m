Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C528AE83837
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 21:23:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EA7383DDD;
	Mon, 16 Feb 2026 22:23:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAB328063E; Mon, 16 Feb 2026 22:22:19 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C38E083AA9
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 22:22:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1vs62c-000000002ex-1sVD; Mon, 16 Feb 2026 21:22:02 +0000
Date: Mon, 16 Feb 2026 21:21:58 +0000
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
Subject: [RFC PATCH 05/20] cmd: ubi: export ubi_find_volume()
Message-ID: <5511a9a0d434c3b69f1625f9f4bfd8e99151bc1a.1771275704.git.daniel@makrotopia.org>
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

Remove the static qualifier from ubi_find_volume() and add a
declaration to include/ubi_uboot.h so that other translation units
can look up a UBI volume by name.

The function now refers to ubi_devices[0] directly instead of the
file-local 'ubi' pointer, and takes a const char * for the volume
name.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 cmd/ubi.c           | 10 +++++++---
 include/ubi_uboot.h |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 93de6f3aea2..ca7d657aa07 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -247,13 +247,17 @@ static int ubi_create_vol(char *volume, int64_t size, int dynamic, int vol_id,
 	return ubi_create_volume(ubi, &req);
 }
 
-static struct ubi_volume *ubi_find_volume(char *volume)
+struct ubi_volume *ubi_find_volume(const char *volume)
 {
+	struct ubi_device *dev = ubi_devices[0];
 	struct ubi_volume *vol;
 	int i;
 
-	for (i = 0; i < ubi->vtbl_slots; i++) {
-		vol = ubi->volumes[i];
+	if (!dev)
+		return NULL;
+
+	for (i = 0; i < dev->vtbl_slots; i++) {
+		vol = dev->volumes[i];
 		if (vol && !strcmp(vol->name, volume))
 			return vol;
 	}
diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
index ea0db69c72a..92892704d0a 100644
--- a/include/ubi_uboot.h
+++ b/include/ubi_uboot.h
@@ -50,6 +50,7 @@ extern void ubi_exit(void);
 extern int ubi_part(char *part_name, const char *vid_header_offset);
 extern int ubi_volume_write(char *volume, void *buf, loff_t offset, size_t size);
 extern int ubi_volume_read(char *volume, char *buf, loff_t offset, size_t size);
+struct ubi_volume *ubi_find_volume(const char *volume);
 
 extern struct ubi_device *ubi_devices[];
 int cmd_ubifs_mount(char *vol_name);
-- 
2.53.0
