Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C06FC6165
	for <u-boot@archiver.kernel.org>; Sat,  3 Jan 2026 00:23:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E982A842C2;
	Sat,  3 Jan 2026 01:23:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EtuI3vIs";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UKL1+EPc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11ECB83A64; Sat,  3 Jan 2026 01:23:28 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DFCD83A64
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 01:23:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4djh9m6V7Jz9s7H;
 Sat,  3 Jan 2026 01:23:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767399804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TjHtE1yUnHRpF3apaqOW06S8GW64PTT+iPtPEXqCoMs=;
 b=EtuI3vIscIXIQABBaZfHZvlqjLF2BjvsetmN9MUHEEYr1/xuB5xLi6ic8NOWaJZRz7f8B+
 C4EOqZ19e7enwXCLpreh+AN7l70t0GBN6Q+gxqE9FyrRiUpzJKnHVRks9tLTNvvsopnRZ1
 Zw2wB2FwXE4GbH3kYV2v0T/+fpROeQOtVGR96aFz4tEFqak7G0u4Kv7kP/EiFSyudw0G6G
 epUjdoBjIHgMXoqcv657Hn1mlsrRcX056qjqcxyBjDIoaBbZLIGGvKmUlWO0wy04CBg6Kx
 G5+44RMuNpI6WzoRKAU1xdBA0Yu8mW5LIF0cTaTzt/hd8fAKxbfXFj63agwjHQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767399802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=TjHtE1yUnHRpF3apaqOW06S8GW64PTT+iPtPEXqCoMs=;
 b=UKL1+EPc3RazSwEpZsQV2PWRIPes8VJnfpxQymq2DPXWWbYaRim1khrXi2qDA0ngxowP1v
 fQORMbPdlqOrqhoFdgg9PrmM4p2wM1IUOZAkIlyligyyDLmvMdSiGpwm3Przm3AS5mTIRt
 1H9UMYXbGKqhM+NIv37lBgBbqLbkaoEq/8p0gzGBwjg6Gkh/EhNjQ8pZzO/HYeOUWZHzmq
 T+pL3X/om7trpMHkLKUymBoT8w0olYL4cC6RGZFdVCgXldWotRP98+Rxad8TTKjAIAxTdp
 B1fIAOo4zvYTA5/bJ4kcBSeuxlK2CCc3lAW5LSMK5qd2OgugvWzJpTnRHzUubg==
To: u-boot@lists.denx.de
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/5] scsi: ufs: renesas: Replace init data by init code
Date: Sat,  3 Jan 2026 01:22:27 +0100
Message-ID: <20260103002254.183357-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: a5c1mcwchgzfr1gyfa5rcs9wfd8bxx48
X-MBO-RS-ID: 688ced4f12b4ee3c927
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

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Since initialization of the UFS controller on R-Car S4-8 ES1.0 requires
only static values, the driver uses initialization data stored in the const
ufs_param[] array.  However, other UFS controller variants (R-Car S4-8
ES1.2) require dynamic values, like those obtained from E-FUSE.  Refactor
the initialization code to prepare for this.

This also reduces kernel size by almost 30 KiB.

Ported from Linux kernel commit
c4e83573c3d0 ("scsi: ufs: renesas: Replace init data by init code")

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/3520e27ac7ff512de6508f630eee3c1689a7c73d.1741179611.git.geert+renesas@glider.be
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: u-boot@lists.denx.de
---
 drivers/ufs/ufs-renesas.c | 511 +++++++++++++++++++++-----------------
 1 file changed, 286 insertions(+), 225 deletions(-)

diff --git a/drivers/ufs/ufs-renesas.c b/drivers/ufs/ufs-renesas.c
index 0b74b39dc2a..b89205d0f11 100644
--- a/drivers/ufs/ufs-renesas.c
+++ b/drivers/ufs/ufs-renesas.c
@@ -39,98 +39,6 @@ enum ufs_renesas_init_param_mode {
 	MODE_WRITE,
 };
 
-#define PARAM_RESTORE(_reg, _index) \
-		{ .mode = MODE_RESTORE, .reg = _reg, .index = _index }
-#define PARAM_SET(_index, _set) \
-		{ .mode = MODE_SET, .index = _index, .u.set = _set }
-#define PARAM_SAVE(_reg, _mask, _index) \
-		{ .mode = MODE_SAVE, .reg = _reg, .mask = (u32)(_mask), \
-		  .index = _index }
-#define PARAM_POLL(_reg, _expected, _mask) \
-		{ .mode = MODE_POLL, .reg = _reg, .u.expected = _expected, \
-		  .mask = (u32)(_mask) }
-#define PARAM_WAIT(_delay_us) \
-		{ .mode = MODE_WAIT, .u.delay_us = _delay_us }
-
-#define PARAM_WRITE(_reg, _val) \
-		{ .mode = MODE_WRITE, .reg = _reg, .u.val = _val }
-
-#define PARAM_WRITE_D0_D4(_d0, _d4) \
-		PARAM_WRITE(0xd0, _d0),	PARAM_WRITE(0xd4, _d4)
-
-#define PARAM_WRITE_800_80C_POLL(_addr, _data_800)		\
-		PARAM_WRITE_D0_D4(0x0000080c, 0x00000100),	\
-		PARAM_WRITE_D0_D4(0x00000800, ((_data_800) << 16) | BIT(8) | (_addr)), \
-		PARAM_WRITE(0xd0, 0x0000080c),			\
-		PARAM_POLL(0xd4, BIT(8), BIT(8))
-
-#define PARAM_RESTORE_800_80C_POLL(_index)			\
-		PARAM_WRITE_D0_D4(0x0000080c, 0x00000100),	\
-		PARAM_WRITE(0xd0, 0x00000800),			\
-		PARAM_RESTORE(0xd4, (_index)),			\
-		PARAM_WRITE(0xd0, 0x0000080c),			\
-		PARAM_POLL(0xd4, BIT(8), BIT(8))
-
-#define PARAM_WRITE_804_80C_POLL(_addr, _data_804)		\
-		PARAM_WRITE_D0_D4(0x0000080c, 0x00000100),	\
-		PARAM_WRITE_D0_D4(0x00000804, ((_data_804) << 16) | BIT(8) | (_addr)), \
-		PARAM_WRITE(0xd0, 0x0000080c),			\
-		PARAM_POLL(0xd4, BIT(8), BIT(8))
-
-#define PARAM_WRITE_828_82C_POLL(_data_828)			\
-		PARAM_WRITE_D0_D4(0x0000082c, 0x0f000000),	\
-		PARAM_WRITE_D0_D4(0x00000828, _data_828),	\
-		PARAM_WRITE(0xd0, 0x0000082c),			\
-		PARAM_POLL(0xd4, _data_828, _data_828)
-
-#define PARAM_WRITE_PHY(_addr16, _data16)			\
-		PARAM_WRITE(0xf0, 1),				\
-		PARAM_WRITE_800_80C_POLL(0x16, (_addr16) & 0xff), \
-		PARAM_WRITE_800_80C_POLL(0x17, ((_addr16) >> 8) & 0xff), \
-		PARAM_WRITE_800_80C_POLL(0x18, (_data16) & 0xff), \
-		PARAM_WRITE_800_80C_POLL(0x19, ((_data16) >> 8) & 0xff), \
-		PARAM_WRITE_800_80C_POLL(0x1c, 0x01),		\
-		PARAM_WRITE_828_82C_POLL(0x0f000000),		\
-		PARAM_WRITE(0xf0, 0)
-
-#define PARAM_SET_PHY(_addr16, _data16)				\
-		PARAM_WRITE(0xf0, 1),				\
-		PARAM_WRITE_800_80C_POLL(0x16, (_addr16) & 0xff), \
-		PARAM_WRITE_800_80C_POLL(0x17, ((_addr16) >> 8) & 0xff), \
-		PARAM_WRITE_800_80C_POLL(0x1c, 0x01),		\
-		PARAM_WRITE_828_82C_POLL(0x0f000000),		\
-		PARAM_WRITE_804_80C_POLL(0x1a, 0),		\
-		PARAM_WRITE(0xd0, 0x00000808),			\
-		PARAM_SAVE(0xd4, 0xff, SET_PHY_INDEX_LO),	\
-		PARAM_WRITE_804_80C_POLL(0x1b, 0),		\
-		PARAM_WRITE(0xd0, 0x00000808),			\
-		PARAM_SAVE(0xd4, 0xff, SET_PHY_INDEX_HI),	\
-		PARAM_WRITE_828_82C_POLL(0x0f000000),		\
-		PARAM_WRITE(0xf0, 0),				\
-		PARAM_WRITE(0xf0, 1),				\
-		PARAM_WRITE_800_80C_POLL(0x16, (_addr16) & 0xff), \
-		PARAM_WRITE_800_80C_POLL(0x17, ((_addr16) >> 8) & 0xff), \
-		PARAM_SET(SET_PHY_INDEX_LO, (((_data16) & 0xff) << 16) | BIT(8) | 0x18), \
-		PARAM_RESTORE_800_80C_POLL(SET_PHY_INDEX_LO),	\
-		PARAM_SET(SET_PHY_INDEX_HI, ((((_data16) >> 8) & 0xff) << 16) | BIT(8) | 0x19), \
-		PARAM_RESTORE_800_80C_POLL(SET_PHY_INDEX_HI),	\
-		PARAM_WRITE_800_80C_POLL(0x1c, 0x01),		\
-		PARAM_WRITE_828_82C_POLL(0x0f000000),		\
-		PARAM_WRITE(0xf0, 0)
-
-#define PARAM_INDIRECT_WRITE(_gpio, _addr, _data_800)		\
-		PARAM_WRITE(0xf0, _gpio),			\
-		PARAM_WRITE_800_80C_POLL((_addr), _data_800),	\
-		PARAM_WRITE_828_82C_POLL(0x0f000000),		\
-		PARAM_WRITE(0xf0, 0)
-
-#define PARAM_INDIRECT_POLL(_gpio, _addr, _expected, _mask)	\
-		PARAM_WRITE(0xf0, _gpio),			\
-		PARAM_WRITE_800_80C_POLL((_addr), 0),		\
-		PARAM_WRITE(0xd0, 0x00000808),			\
-		PARAM_POLL(0xd4, (_expected), (_mask)),		\
-		PARAM_WRITE(0xf0, 0)
-
 struct ufs_renesas_init_param {
 	enum ufs_renesas_init_param_mode mode;
 	u32 reg;
@@ -144,135 +52,6 @@ struct ufs_renesas_init_param {
 	u32 index;
 };
 
-/* This setting is for SERIES B */
-static const struct ufs_renesas_init_param ufs_param[] = {
-	PARAM_WRITE(0xc0, 0x49425308),
-	PARAM_WRITE_D0_D4(0x00000104, 0x00000002),
-	PARAM_WAIT(1),
-	PARAM_WRITE_D0_D4(0x00000828, 0x00000200),
-	PARAM_WAIT(1),
-	PARAM_WRITE_D0_D4(0x00000828, 0x00000000),
-	PARAM_WRITE_D0_D4(0x00000104, 0x00000001),
-	PARAM_WRITE_D0_D4(0x00000940, 0x00000001),
-	PARAM_WAIT(1),
-	PARAM_WRITE_D0_D4(0x00000940, 0x00000000),
-
-	PARAM_WRITE(0xc0, 0x49425308),
-	PARAM_WRITE(0xc0, 0x41584901),
-
-	PARAM_WRITE_D0_D4(0x0000080c, 0x00000100),
-	PARAM_WRITE_D0_D4(0x00000804, 0x00000000),
-	PARAM_WRITE(0xd0, 0x0000080c),
-	PARAM_POLL(0xd4, BIT(8), BIT(8)),
-
-	PARAM_WRITE(REG_CONTROLLER_ENABLE, 0x00000001),
-
-	PARAM_WRITE(0xd0, 0x00000804),
-	PARAM_POLL(0xd4, BIT(8) | BIT(6) | BIT(0), BIT(8) | BIT(6) | BIT(0)),
-
-	PARAM_WRITE(0xd0, 0x00000d00),
-	PARAM_SAVE(0xd4, 0x0000ffff, TIMER_INDEX),
-	PARAM_WRITE(0xd4, 0x00000000),
-	PARAM_WRITE_D0_D4(0x0000082c, 0x0f000000),
-	PARAM_WRITE_D0_D4(0x00000828, 0x08000000),
-	PARAM_WRITE(0xd0, 0x0000082c),
-	PARAM_POLL(0xd4, BIT(27), BIT(27)),
-	PARAM_WRITE(0xd0, 0x00000d2c),
-	PARAM_POLL(0xd4, BIT(0), BIT(0)),
-
-	/* phy setup */
-	PARAM_INDIRECT_WRITE(1, 0x01, 0x001f),
-	PARAM_INDIRECT_WRITE(7, 0x5d, 0x0014),
-	PARAM_INDIRECT_WRITE(7, 0x5e, 0x0014),
-	PARAM_INDIRECT_WRITE(7, 0x0d, 0x0003),
-	PARAM_INDIRECT_WRITE(7, 0x0e, 0x0007),
-	PARAM_INDIRECT_WRITE(7, 0x5f, 0x0003),
-	PARAM_INDIRECT_WRITE(7, 0x60, 0x0003),
-	PARAM_INDIRECT_WRITE(7, 0x5b, 0x00a6),
-	PARAM_INDIRECT_WRITE(7, 0x5c, 0x0003),
-
-	PARAM_INDIRECT_POLL(7, 0x3c, 0, BIT(7)),
-	PARAM_INDIRECT_POLL(7, 0x4c, 0, BIT(4)),
-
-	PARAM_INDIRECT_WRITE(1, 0x32, 0x0080),
-	PARAM_INDIRECT_WRITE(1, 0x1f, 0x0001),
-	PARAM_INDIRECT_WRITE(0, 0x2c, 0x0001),
-	PARAM_INDIRECT_WRITE(0, 0x32, 0x0087),
-
-	PARAM_INDIRECT_WRITE(1, 0x4d, 0x0061),
-	PARAM_INDIRECT_WRITE(4, 0x9b, 0x0009),
-	PARAM_INDIRECT_WRITE(4, 0xa6, 0x0005),
-	PARAM_INDIRECT_WRITE(4, 0xa5, 0x0058),
-	PARAM_INDIRECT_WRITE(1, 0x39, 0x0027),
-	PARAM_INDIRECT_WRITE(1, 0x47, 0x004c),
-
-	PARAM_INDIRECT_WRITE(7, 0x0d, 0x0002),
-	PARAM_INDIRECT_WRITE(7, 0x0e, 0x0007),
-
-	PARAM_WRITE_PHY(0x0028, 0x0061),
-	PARAM_WRITE_PHY(0x4014, 0x0061),
-	PARAM_SET_PHY(0x401c, BIT(2)),
-	PARAM_WRITE_PHY(0x4000, 0x0000),
-	PARAM_WRITE_PHY(0x4001, 0x0000),
-
-	PARAM_WRITE_PHY(0x10ae, 0x0001),
-	PARAM_WRITE_PHY(0x10ad, 0x0000),
-	PARAM_WRITE_PHY(0x10af, 0x0001),
-	PARAM_WRITE_PHY(0x10b6, 0x0001),
-	PARAM_WRITE_PHY(0x10ae, 0x0000),
-
-	PARAM_WRITE_PHY(0x10ae, 0x0001),
-	PARAM_WRITE_PHY(0x10ad, 0x0000),
-	PARAM_WRITE_PHY(0x10af, 0x0002),
-	PARAM_WRITE_PHY(0x10b6, 0x0001),
-	PARAM_WRITE_PHY(0x10ae, 0x0000),
-
-	PARAM_WRITE_PHY(0x10ae, 0x0001),
-	PARAM_WRITE_PHY(0x10ad, 0x0080),
-	PARAM_WRITE_PHY(0x10af, 0x0000),
-	PARAM_WRITE_PHY(0x10b6, 0x0001),
-	PARAM_WRITE_PHY(0x10ae, 0x0000),
-
-	PARAM_WRITE_PHY(0x10ae, 0x0001),
-	PARAM_WRITE_PHY(0x10ad, 0x0080),
-	PARAM_WRITE_PHY(0x10af, 0x001a),
-	PARAM_WRITE_PHY(0x10b6, 0x0001),
-	PARAM_WRITE_PHY(0x10ae, 0x0000),
-
-	PARAM_INDIRECT_WRITE(7, 0x70, 0x0016),
-	PARAM_INDIRECT_WRITE(7, 0x71, 0x0016),
-	PARAM_INDIRECT_WRITE(7, 0x72, 0x0014),
-	PARAM_INDIRECT_WRITE(7, 0x73, 0x0014),
-	PARAM_INDIRECT_WRITE(7, 0x74, 0x0000),
-	PARAM_INDIRECT_WRITE(7, 0x75, 0x0000),
-	PARAM_INDIRECT_WRITE(7, 0x76, 0x0010),
-	PARAM_INDIRECT_WRITE(7, 0x77, 0x0010),
-	PARAM_INDIRECT_WRITE(7, 0x78, 0x00ff),
-	PARAM_INDIRECT_WRITE(7, 0x79, 0x0000),
-
-	PARAM_INDIRECT_WRITE(7, 0x19, 0x0007),
-
-	PARAM_INDIRECT_WRITE(7, 0x1a, 0x0007),
-
-	PARAM_INDIRECT_WRITE(7, 0x24, 0x000c),
-
-	PARAM_INDIRECT_WRITE(7, 0x25, 0x000c),
-
-	PARAM_INDIRECT_WRITE(7, 0x62, 0x0000),
-	PARAM_INDIRECT_WRITE(7, 0x63, 0x0000),
-	PARAM_INDIRECT_WRITE(7, 0x5d, 0x0014),
-	PARAM_INDIRECT_WRITE(7, 0x5e, 0x0017),
-	PARAM_INDIRECT_WRITE(7, 0x5d, 0x0004),
-	PARAM_INDIRECT_WRITE(7, 0x5e, 0x0017),
-	PARAM_INDIRECT_POLL(7, 0x55, 0, BIT(6)),
-	PARAM_INDIRECT_POLL(7, 0x41, 0, BIT(7)),
-	/* end of phy setup */
-
-	PARAM_WRITE(0xf0, 0),
-	PARAM_WRITE(0xd0, 0x00000d00),
-	PARAM_RESTORE(0xd4, TIMER_INDEX),
-};
-
 static void ufs_renesas_reg_control(struct ufs_hba *hba,
 				    const struct ufs_renesas_init_param *p)
 {
@@ -314,13 +93,295 @@ static void ufs_renesas_reg_control(struct ufs_hba *hba,
 	}
 }
 
+static void ufs_renesas_poll(struct ufs_hba *hba, u32 reg, u32 expected, u32 mask)
+{
+	struct ufs_renesas_init_param param = {
+		.mode = MODE_POLL,
+		.reg = reg,
+		.u.expected = expected,
+		.mask = mask,
+	};
+
+	ufs_renesas_reg_control(hba, &param);
+}
+
+static void ufs_renesas_restore(struct ufs_hba *hba, u32 reg, u32 index)
+{
+	struct ufs_renesas_init_param param = {
+		.mode = MODE_RESTORE,
+		.reg = reg,
+		.index = index,
+	};
+
+	ufs_renesas_reg_control(hba, &param);
+}
+
+static void ufs_renesas_save(struct ufs_hba *hba, u32 reg, u32 mask, u32 index)
+{
+	struct ufs_renesas_init_param param = {
+		.mode = MODE_SAVE,
+		.reg = reg,
+		.mask = mask,
+		.index = index,
+	};
+
+	ufs_renesas_reg_control(hba, &param);
+}
+
+static void ufs_renesas_set(struct ufs_hba *hba, u32 index, u32 set)
+{
+	struct ufs_renesas_init_param param = {
+		.mode = MODE_SAVE,
+		.index = index,
+		.u.set = set,
+	};
+
+	ufs_renesas_reg_control(hba, &param);
+}
+
+static void ufs_renesas_wait(struct ufs_hba *hba, u32 delay_us)
+{
+	struct ufs_renesas_init_param param = {
+		.mode = MODE_WAIT,
+		.u.delay_us = delay_us,
+	};
+
+	ufs_renesas_reg_control(hba, &param);
+}
+
+static void ufs_renesas_write(struct ufs_hba *hba, u32 reg, u32 value)
+{
+	struct ufs_renesas_init_param param = {
+		.mode = MODE_WRITE,
+		.reg = reg,
+		.u.val = value,
+	};
+
+	ufs_renesas_reg_control(hba, &param);
+}
+
+static void ufs_renesas_write_d0_d4(struct ufs_hba *hba, u32 data_d0, u32 data_d4)
+{
+	ufs_renesas_write(hba, 0xd0, data_d0);
+	ufs_renesas_write(hba, 0xd4, data_d4);
+}
+
+static void ufs_renesas_write_800_80c_poll(struct ufs_hba *hba, u32 addr,
+					   u32 data_800)
+{
+	ufs_renesas_write_d0_d4(hba, 0x0000080c, 0x00000100);
+	ufs_renesas_write_d0_d4(hba, 0x00000800, (data_800 << 16) | BIT(8) | addr);
+	ufs_renesas_write(hba, 0xd0, 0x0000080c);
+	ufs_renesas_poll(hba, 0xd4, BIT(8), BIT(8));
+}
+
+static void ufs_renesas_restore_800_80c_poll(struct ufs_hba *hba, u32 index)
+{
+	ufs_renesas_write_d0_d4(hba, 0x0000080c, 0x00000100);
+	ufs_renesas_write(hba, 0xd0, 0x00000800);
+	ufs_renesas_restore(hba, 0xd4, index);
+	ufs_renesas_write(hba, 0xd0, 0x0000080c);
+	ufs_renesas_poll(hba, 0xd4, BIT(8), BIT(8));
+}
+
+static void ufs_renesas_write_804_80c_poll(struct ufs_hba *hba, u32 addr, u32 data_804)
+{
+	ufs_renesas_write_d0_d4(hba, 0x0000080c, 0x00000100);
+	ufs_renesas_write_d0_d4(hba, 0x00000804, (data_804 << 16) | BIT(8) | addr);
+	ufs_renesas_write(hba, 0xd0, 0x0000080c);
+	ufs_renesas_poll(hba, 0xd4, BIT(8), BIT(8));
+}
+
+static void ufs_renesas_write_828_82c_poll(struct ufs_hba *hba, u32 data_828)
+{
+	ufs_renesas_write_d0_d4(hba, 0x0000082c, 0x0f000000);
+	ufs_renesas_write_d0_d4(hba, 0x00000828, data_828);
+	ufs_renesas_write(hba, 0xd0, 0x0000082c);
+	ufs_renesas_poll(hba, 0xd4, data_828, data_828);
+}
+
+static void ufs_renesas_write_phy(struct ufs_hba *hba, u32 addr16, u32 data16)
+{
+	ufs_renesas_write(hba, 0xf0, 1);
+	ufs_renesas_write_800_80c_poll(hba, 0x16, addr16 & 0xff);
+	ufs_renesas_write_800_80c_poll(hba, 0x17, (addr16 >> 8) & 0xff);
+	ufs_renesas_write_800_80c_poll(hba, 0x18, data16 & 0xff);
+	ufs_renesas_write_800_80c_poll(hba, 0x19, (data16 >> 8) & 0xff);
+	ufs_renesas_write_800_80c_poll(hba, 0x1c, 0x01);
+	ufs_renesas_write_828_82c_poll(hba, 0x0f000000);
+	ufs_renesas_write(hba, 0xf0, 0);
+}
+
+static void ufs_renesas_set_phy(struct ufs_hba *hba, u32 addr16, u32 data16)
+{
+	ufs_renesas_write(hba, 0xf0, 1);
+	ufs_renesas_write_800_80c_poll(hba, 0x16, addr16 & 0xff);
+	ufs_renesas_write_800_80c_poll(hba, 0x17, (addr16 >> 8) & 0xff);
+	ufs_renesas_write_800_80c_poll(hba, 0x1c, 0x01);
+	ufs_renesas_write_828_82c_poll(hba, 0x0f000000);
+	ufs_renesas_write_804_80c_poll(hba, 0x1a, 0);
+	ufs_renesas_write(hba, 0xd0, 0x00000808);
+	ufs_renesas_save(hba, 0xd4, 0xff, SET_PHY_INDEX_LO);
+	ufs_renesas_write_804_80c_poll(hba, 0x1b, 0);
+	ufs_renesas_write(hba, 0xd0, 0x00000808);
+	ufs_renesas_save(hba, 0xd4, 0xff, SET_PHY_INDEX_HI);
+	ufs_renesas_write_828_82c_poll(hba, 0x0f000000);
+	ufs_renesas_write(hba, 0xf0, 0);
+	ufs_renesas_write(hba, 0xf0, 1);
+	ufs_renesas_write_800_80c_poll(hba, 0x16, addr16 & 0xff);
+	ufs_renesas_write_800_80c_poll(hba, 0x17, (addr16 >> 8) & 0xff);
+	ufs_renesas_set(hba, SET_PHY_INDEX_LO, ((data16 & 0xff) << 16) | BIT(8) | 0x18);
+	ufs_renesas_restore_800_80c_poll(hba, SET_PHY_INDEX_LO);
+	ufs_renesas_set(hba, SET_PHY_INDEX_HI, (((data16 >> 8) & 0xff) << 16) | BIT(8) | 0x19);
+	ufs_renesas_restore_800_80c_poll(hba, SET_PHY_INDEX_HI);
+	ufs_renesas_write_800_80c_poll(hba, 0x1c, 0x01);
+	ufs_renesas_write_828_82c_poll(hba, 0x0f000000);
+	ufs_renesas_write(hba, 0xf0, 0);
+}
+
+static void ufs_renesas_indirect_write(struct ufs_hba *hba, u32 gpio, u32 addr,
+				       u32 data_800)
+{
+	ufs_renesas_write(hba, 0xf0, gpio);
+	ufs_renesas_write_800_80c_poll(hba, addr, data_800);
+	ufs_renesas_write_828_82c_poll(hba, 0x0f000000);
+	ufs_renesas_write(hba, 0xf0, 0);
+}
+
+static void ufs_renesas_indirect_poll(struct ufs_hba *hba, u32 gpio, u32 addr,
+				      u32 expected, u32 mask)
+{
+	ufs_renesas_write(hba, 0xf0, gpio);
+	ufs_renesas_write_800_80c_poll(hba, addr, 0);
+	ufs_renesas_write(hba, 0xd0, 0x00000808);
+	ufs_renesas_poll(hba, 0xd4, expected, mask);
+	ufs_renesas_write(hba, 0xf0, 0);
+}
+
 static void ufs_renesas_pre_init(struct ufs_hba *hba)
 {
-	const struct ufs_renesas_init_param *p = ufs_param;
-	unsigned int i;
+	/* This setting is for SERIES B */
+	ufs_renesas_write(hba, 0xc0, 0x49425308);
+	ufs_renesas_write_d0_d4(hba, 0x00000104, 0x00000002);
+	ufs_renesas_wait(hba, 1);
+	ufs_renesas_write_d0_d4(hba, 0x00000828, 0x00000200);
+	ufs_renesas_wait(hba, 1);
+	ufs_renesas_write_d0_d4(hba, 0x00000828, 0x00000000);
+	ufs_renesas_write_d0_d4(hba, 0x00000104, 0x00000001);
+	ufs_renesas_write_d0_d4(hba, 0x00000940, 0x00000001);
+	ufs_renesas_wait(hba, 1);
+	ufs_renesas_write_d0_d4(hba, 0x00000940, 0x00000000);
+
+	ufs_renesas_write(hba, 0xc0, 0x49425308);
+	ufs_renesas_write(hba, 0xc0, 0x41584901);
+
+	ufs_renesas_write_d0_d4(hba, 0x0000080c, 0x00000100);
+	ufs_renesas_write_d0_d4(hba, 0x00000804, 0x00000000);
+	ufs_renesas_write(hba, 0xd0, 0x0000080c);
+	ufs_renesas_poll(hba, 0xd4, BIT(8), BIT(8));
+
+	ufs_renesas_write(hba, REG_CONTROLLER_ENABLE, 0x00000001);
+
+	ufs_renesas_write(hba, 0xd0, 0x00000804);
+	ufs_renesas_poll(hba, 0xd4, BIT(8) | BIT(6) | BIT(0), BIT(8) | BIT(6) | BIT(0));
+
+	ufs_renesas_write(hba, 0xd0, 0x00000d00);
+	ufs_renesas_save(hba, 0xd4, 0x0000ffff, TIMER_INDEX);
+	ufs_renesas_write(hba, 0xd4, 0x00000000);
+	ufs_renesas_write_d0_d4(hba, 0x0000082c, 0x0f000000);
+	ufs_renesas_write_d0_d4(hba, 0x00000828, 0x08000000);
+	ufs_renesas_write(hba, 0xd0, 0x0000082c);
+	ufs_renesas_poll(hba, 0xd4, BIT(27), BIT(27));
+	ufs_renesas_write(hba, 0xd0, 0x00000d2c);
+	ufs_renesas_poll(hba, 0xd4, BIT(0), BIT(0));
+
+	/* phy setup */
+	ufs_renesas_indirect_write(hba, 1, 0x01, 0x001f);
+	ufs_renesas_indirect_write(hba, 7, 0x5d, 0x0014);
+	ufs_renesas_indirect_write(hba, 7, 0x5e, 0x0014);
+	ufs_renesas_indirect_write(hba, 7, 0x0d, 0x0003);
+	ufs_renesas_indirect_write(hba, 7, 0x0e, 0x0007);
+	ufs_renesas_indirect_write(hba, 7, 0x5f, 0x0003);
+	ufs_renesas_indirect_write(hba, 7, 0x60, 0x0003);
+	ufs_renesas_indirect_write(hba, 7, 0x5b, 0x00a6);
+	ufs_renesas_indirect_write(hba, 7, 0x5c, 0x0003);
+
+	ufs_renesas_indirect_poll(hba, 7, 0x3c, 0, BIT(7));
+	ufs_renesas_indirect_poll(hba, 7, 0x4c, 0, BIT(4));
+
+	ufs_renesas_indirect_write(hba, 1, 0x32, 0x0080);
+	ufs_renesas_indirect_write(hba, 1, 0x1f, 0x0001);
+	ufs_renesas_indirect_write(hba, 0, 0x2c, 0x0001);
+	ufs_renesas_indirect_write(hba, 0, 0x32, 0x0087);
+
+	ufs_renesas_indirect_write(hba, 1, 0x4d, 0x0061);
+	ufs_renesas_indirect_write(hba, 4, 0x9b, 0x0009);
+	ufs_renesas_indirect_write(hba, 4, 0xa6, 0x0005);
+	ufs_renesas_indirect_write(hba, 4, 0xa5, 0x0058);
+	ufs_renesas_indirect_write(hba, 1, 0x39, 0x0027);
+	ufs_renesas_indirect_write(hba, 1, 0x47, 0x004c);
+
+	ufs_renesas_indirect_write(hba, 7, 0x0d, 0x0002);
+	ufs_renesas_indirect_write(hba, 7, 0x0e, 0x0007);
+
+	ufs_renesas_write_phy(hba, 0x0028, 0x0061);
+	ufs_renesas_write_phy(hba, 0x4014, 0x0061);
+	ufs_renesas_set_phy(hba, 0x401c, BIT(2));
+	ufs_renesas_write_phy(hba, 0x4000, 0x0000);
+	ufs_renesas_write_phy(hba, 0x4001, 0x0000);
+
+	ufs_renesas_write_phy(hba, 0x10ae, 0x0001);
+	ufs_renesas_write_phy(hba, 0x10ad, 0x0000);
+	ufs_renesas_write_phy(hba, 0x10af, 0x0001);
+	ufs_renesas_write_phy(hba, 0x10b6, 0x0001);
+	ufs_renesas_write_phy(hba, 0x10ae, 0x0000);
+
+	ufs_renesas_write_phy(hba, 0x10ae, 0x0001);
+	ufs_renesas_write_phy(hba, 0x10ad, 0x0000);
+	ufs_renesas_write_phy(hba, 0x10af, 0x0002);
+	ufs_renesas_write_phy(hba, 0x10b6, 0x0001);
+	ufs_renesas_write_phy(hba, 0x10ae, 0x0000);
+
+	ufs_renesas_write_phy(hba, 0x10ae, 0x0001);
+	ufs_renesas_write_phy(hba, 0x10ad, 0x0080);
+	ufs_renesas_write_phy(hba, 0x10af, 0x0000);
+	ufs_renesas_write_phy(hba, 0x10b6, 0x0001);
+	ufs_renesas_write_phy(hba, 0x10ae, 0x0000);
+
+	ufs_renesas_write_phy(hba, 0x10ae, 0x0001);
+	ufs_renesas_write_phy(hba, 0x10ad, 0x0080);
+	ufs_renesas_write_phy(hba, 0x10af, 0x001a);
+	ufs_renesas_write_phy(hba, 0x10b6, 0x0001);
+	ufs_renesas_write_phy(hba, 0x10ae, 0x0000);
+
+	ufs_renesas_indirect_write(hba, 7, 0x70, 0x0016);
+	ufs_renesas_indirect_write(hba, 7, 0x71, 0x0016);
+	ufs_renesas_indirect_write(hba, 7, 0x72, 0x0014);
+	ufs_renesas_indirect_write(hba, 7, 0x73, 0x0014);
+	ufs_renesas_indirect_write(hba, 7, 0x74, 0x0000);
+	ufs_renesas_indirect_write(hba, 7, 0x75, 0x0000);
+	ufs_renesas_indirect_write(hba, 7, 0x76, 0x0010);
+	ufs_renesas_indirect_write(hba, 7, 0x77, 0x0010);
+	ufs_renesas_indirect_write(hba, 7, 0x78, 0x00ff);
+	ufs_renesas_indirect_write(hba, 7, 0x79, 0x0000);
+
+	ufs_renesas_indirect_write(hba, 7, 0x19, 0x0007);
+	ufs_renesas_indirect_write(hba, 7, 0x1a, 0x0007);
+	ufs_renesas_indirect_write(hba, 7, 0x24, 0x000c);
+	ufs_renesas_indirect_write(hba, 7, 0x25, 0x000c);
+	ufs_renesas_indirect_write(hba, 7, 0x62, 0x0000);
+	ufs_renesas_indirect_write(hba, 7, 0x63, 0x0000);
+	ufs_renesas_indirect_write(hba, 7, 0x5d, 0x0014);
+	ufs_renesas_indirect_write(hba, 7, 0x5e, 0x0017);
+	ufs_renesas_indirect_write(hba, 7, 0x5d, 0x0004);
+	ufs_renesas_indirect_write(hba, 7, 0x5e, 0x0017);
+	ufs_renesas_indirect_poll(hba, 7, 0x55, 0, BIT(6));
+	ufs_renesas_indirect_poll(hba, 7, 0x41, 0, BIT(7));
+	/* end of phy setup */
 
-	for (i = 0; i < ARRAY_SIZE(ufs_param); i++)
-		ufs_renesas_reg_control(hba, &p[i]);
+	ufs_renesas_write(hba, 0xf0, 0);
+	ufs_renesas_write(hba, 0xd0, 0x00000d00);
+	ufs_renesas_restore(hba, 0xd4, TIMER_INDEX);
 }
 
 static int ufs_renesas_hce_enable_notify(struct ufs_hba *hba,
-- 
2.51.0

