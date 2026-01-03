Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2F4FC6166
	for <u-boot@archiver.kernel.org>; Sat,  3 Jan 2026 00:23:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E16583CF2;
	Sat,  3 Jan 2026 01:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Sbf0N83B";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BsTDRzKj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 402D483A64; Sat,  3 Jan 2026 01:23:29 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4902842B6
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 01:23:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4djh9p2FYXz9tYW;
 Sat,  3 Jan 2026 01:23:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767399806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0sMZiZxcTmCaxgfZGnlE9ngZ9BOc06X0JMokwaOKtI=;
 b=Sbf0N83BgkTZ1ducMn6wBVInMEHqbzf4FRYOGJPXn6fGetpUXIWz5SpDUYafO1s7kWqG9u
 rCA9eRodWGvgB4DcN7qBgAD41kbV9Ur2ISNi11Ea68pxE7OSIeCK6W+1g7bV/ClghhOcxV
 6Oa3TocvCu62UF+phrCvj2SwVj8yca7b6NKxWzMtkod8rnQoB415VpuFNMn4WOHNKzrkYY
 faAFvx8NZx+xs8Dv4Wplm6/Ft2sjXu1hJYlGr5VS1Cu8KJgcwx4E8qVOYMwFEPKIw7yr/N
 2r3jd2WmCv1hwsKSFqupqDrJjtjzn5bhgD1jayw1I+OQL+QKFyJfZJNgIyssrA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=BsTDRzKj;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767399804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0sMZiZxcTmCaxgfZGnlE9ngZ9BOc06X0JMokwaOKtI=;
 b=BsTDRzKjbvw5Hs+YSQzmA4xlUrwrPXI1iqycH5+qsdJduiux0YR1OY6LZCnAAf7WTuxHtE
 9aFk/9P1dbshDR1rX3pBzyWJgNa2opCGJGRG3C7jeDI3iDESTxgjfBEnLyVGnyTxlWIEpy
 h+EB5uWDB8/bCrDHGPPXLT/DDukYcPmPFtmDoQD8HBln/iP9PzKtNVdk/duhj4poSOqJNs
 zJmoLwJf2dTJJdJvTFRy42Dt1oV3mbP4NLuh0h3xWFY/jQj9UdCkte8Y/GxMhqI+eC/bjo
 Bk9UfeE8D3yGkxHxGyS4TBZBzpom0BEEKRNpZTofXhLOEgMgdfZDYNVwm1f8kQ==
To: u-boot@lists.denx.de
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/5] scsi: ufs: renesas: Add register read to remove
 save/set/restore
Date: Sat,  3 Jan 2026 01:22:28 +0100
Message-ID: <20260103002254.183357-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260103002254.183357-1-marek.vasut+renesas@mailbox.org>
References: <20260103002254.183357-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 30d99febc7f536e89dc
X-MBO-RS-META: 6g1q68tbt69fhi7pfm8uirwz55nkkdq1
X-Rspamd-Queue-Id: 4djh9p2FYXz9tYW
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

Add support for returning read register values from
ufs_renesas_reg_control(), so ufs_renesas_set_phy() can use the existing
ufs_renesas_write_phy() helper.  Remove the now unused code to save to,
set, and restore from a static array inside ufs_renesas_reg_control().

Ported from Linux kernel commit
5129aa627599 ("scsi: ufs: renesas: Add register read to remove save/set/restore")

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/9fa240a9dc0308d6675138f8434eccb77f051650.1741179611.git.geert+renesas@glider.be
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
 drivers/ufs/ufs-renesas.c | 99 +++++++++------------------------------
 1 file changed, 23 insertions(+), 76 deletions(-)

diff --git a/drivers/ufs/ufs-renesas.c b/drivers/ufs/ufs-renesas.c
index b89205d0f11..8c9a9ec7695 100644
--- a/drivers/ufs/ufs-renesas.c
+++ b/drivers/ufs/ufs-renesas.c
@@ -23,18 +23,9 @@ struct ufs_renesas_priv {
 	bool initialized;	/* The hardware needs initialization once */
 };
 
-enum {
-	SET_PHY_INDEX_LO = 0,
-	SET_PHY_INDEX_HI,
-	TIMER_INDEX,
-	MAX_INDEX
-};
-
 enum ufs_renesas_init_param_mode {
-	MODE_RESTORE,
-	MODE_SET,
-	MODE_SAVE,
 	MODE_POLL,
+	MODE_READ,
 	MODE_WAIT,
 	MODE_WRITE,
 };
@@ -45,32 +36,19 @@ struct ufs_renesas_init_param {
 	union {
 		u32 expected;
 		u32 delay_us;
-		u32 set;
 		u32 val;
 	} u;
 	u32 mask;
 	u32 index;
 };
 
-static void ufs_renesas_reg_control(struct ufs_hba *hba,
-				    const struct ufs_renesas_init_param *p)
+static u32 ufs_renesas_reg_control(struct ufs_hba *hba,
+				   const struct ufs_renesas_init_param *p)
 {
-	static u32 save[MAX_INDEX];
+	u32 val = 0;
 	int ret;
-	u32 val;
-
-	WARN_ON(p->index >= MAX_INDEX);
 
 	switch (p->mode) {
-	case MODE_RESTORE:
-		ufshcd_writel(hba, save[p->index], p->reg);
-		break;
-	case MODE_SET:
-		save[p->index] |= p->u.set;
-		break;
-	case MODE_SAVE:
-		save[p->index] = ufshcd_readl(hba, p->reg) & p->mask;
-		break;
 	case MODE_POLL:
 		ret = readl_poll_timeout(hba->mmio_base + p->reg, val,
 					 (val & p->mask) == p->u.expected,
@@ -79,6 +57,9 @@ static void ufs_renesas_reg_control(struct ufs_hba *hba,
 			dev_err(hba->dev, "%s: poll failed %d (%08x, %08x, %08x)\n",
 				__func__, ret, val, p->mask, p->u.expected);
 		break;
+	case MODE_READ:
+		val = ufshcd_readl(hba, p->reg);
+		break;
 	case MODE_WAIT:
 		if (p->u.delay_us > 1000)
 			mdelay(DIV_ROUND_UP(p->u.delay_us, 1000));
@@ -91,6 +72,8 @@ static void ufs_renesas_reg_control(struct ufs_hba *hba,
 	default:
 		break;
 	}
+
+	return val;
 }
 
 static void ufs_renesas_poll(struct ufs_hba *hba, u32 reg, u32 expected, u32 mask)
@@ -105,38 +88,14 @@ static void ufs_renesas_poll(struct ufs_hba *hba, u32 reg, u32 expected, u32 mas
 	ufs_renesas_reg_control(hba, &param);
 }
 
-static void ufs_renesas_restore(struct ufs_hba *hba, u32 reg, u32 index)
-{
-	struct ufs_renesas_init_param param = {
-		.mode = MODE_RESTORE,
-		.reg = reg,
-		.index = index,
-	};
-
-	ufs_renesas_reg_control(hba, &param);
-}
-
-static void ufs_renesas_save(struct ufs_hba *hba, u32 reg, u32 mask, u32 index)
+static u32 ufs_renesas_read(struct ufs_hba *hba, u32 reg)
 {
 	struct ufs_renesas_init_param param = {
-		.mode = MODE_SAVE,
+		.mode = MODE_READ,
 		.reg = reg,
-		.mask = mask,
-		.index = index,
-	};
-
-	ufs_renesas_reg_control(hba, &param);
-}
-
-static void ufs_renesas_set(struct ufs_hba *hba, u32 index, u32 set)
-{
-	struct ufs_renesas_init_param param = {
-		.mode = MODE_SAVE,
-		.index = index,
-		.u.set = set,
 	};
 
-	ufs_renesas_reg_control(hba, &param);
+	return ufs_renesas_reg_control(hba, &param);
 }
 
 static void ufs_renesas_wait(struct ufs_hba *hba, u32 delay_us)
@@ -175,15 +134,6 @@ static void ufs_renesas_write_800_80c_poll(struct ufs_hba *hba, u32 addr,
 	ufs_renesas_poll(hba, 0xd4, BIT(8), BIT(8));
 }
 
-static void ufs_renesas_restore_800_80c_poll(struct ufs_hba *hba, u32 index)
-{
-	ufs_renesas_write_d0_d4(hba, 0x0000080c, 0x00000100);
-	ufs_renesas_write(hba, 0xd0, 0x00000800);
-	ufs_renesas_restore(hba, 0xd4, index);
-	ufs_renesas_write(hba, 0xd0, 0x0000080c);
-	ufs_renesas_poll(hba, 0xd4, BIT(8), BIT(8));
-}
-
 static void ufs_renesas_write_804_80c_poll(struct ufs_hba *hba, u32 addr, u32 data_804)
 {
 	ufs_renesas_write_d0_d4(hba, 0x0000080c, 0x00000100);
@@ -214,6 +164,8 @@ static void ufs_renesas_write_phy(struct ufs_hba *hba, u32 addr16, u32 data16)
 
 static void ufs_renesas_set_phy(struct ufs_hba *hba, u32 addr16, u32 data16)
 {
+	u32 low, high;
+
 	ufs_renesas_write(hba, 0xf0, 1);
 	ufs_renesas_write_800_80c_poll(hba, 0x16, addr16 & 0xff);
 	ufs_renesas_write_800_80c_poll(hba, 0x17, (addr16 >> 8) & 0xff);
@@ -221,22 +173,15 @@ static void ufs_renesas_set_phy(struct ufs_hba *hba, u32 addr16, u32 data16)
 	ufs_renesas_write_828_82c_poll(hba, 0x0f000000);
 	ufs_renesas_write_804_80c_poll(hba, 0x1a, 0);
 	ufs_renesas_write(hba, 0xd0, 0x00000808);
-	ufs_renesas_save(hba, 0xd4, 0xff, SET_PHY_INDEX_LO);
+	low = ufs_renesas_read(hba, 0xd4) & 0xff;
 	ufs_renesas_write_804_80c_poll(hba, 0x1b, 0);
 	ufs_renesas_write(hba, 0xd0, 0x00000808);
-	ufs_renesas_save(hba, 0xd4, 0xff, SET_PHY_INDEX_HI);
-	ufs_renesas_write_828_82c_poll(hba, 0x0f000000);
-	ufs_renesas_write(hba, 0xf0, 0);
-	ufs_renesas_write(hba, 0xf0, 1);
-	ufs_renesas_write_800_80c_poll(hba, 0x16, addr16 & 0xff);
-	ufs_renesas_write_800_80c_poll(hba, 0x17, (addr16 >> 8) & 0xff);
-	ufs_renesas_set(hba, SET_PHY_INDEX_LO, ((data16 & 0xff) << 16) | BIT(8) | 0x18);
-	ufs_renesas_restore_800_80c_poll(hba, SET_PHY_INDEX_LO);
-	ufs_renesas_set(hba, SET_PHY_INDEX_HI, (((data16 >> 8) & 0xff) << 16) | BIT(8) | 0x19);
-	ufs_renesas_restore_800_80c_poll(hba, SET_PHY_INDEX_HI);
-	ufs_renesas_write_800_80c_poll(hba, 0x1c, 0x01);
+	high = ufs_renesas_read(hba, 0xd4) & 0xff;
 	ufs_renesas_write_828_82c_poll(hba, 0x0f000000);
 	ufs_renesas_write(hba, 0xf0, 0);
+
+	data16 |= (high << 8) | low;
+	ufs_renesas_write_phy(hba, addr16, data16);
 }
 
 static void ufs_renesas_indirect_write(struct ufs_hba *hba, u32 gpio, u32 addr,
@@ -260,6 +205,8 @@ static void ufs_renesas_indirect_poll(struct ufs_hba *hba, u32 gpio, u32 addr,
 
 static void ufs_renesas_pre_init(struct ufs_hba *hba)
 {
+	u32 timer_val;
+
 	/* This setting is for SERIES B */
 	ufs_renesas_write(hba, 0xc0, 0x49425308);
 	ufs_renesas_write_d0_d4(hba, 0x00000104, 0x00000002);
@@ -286,7 +233,7 @@ static void ufs_renesas_pre_init(struct ufs_hba *hba)
 	ufs_renesas_poll(hba, 0xd4, BIT(8) | BIT(6) | BIT(0), BIT(8) | BIT(6) | BIT(0));
 
 	ufs_renesas_write(hba, 0xd0, 0x00000d00);
-	ufs_renesas_save(hba, 0xd4, 0x0000ffff, TIMER_INDEX);
+	timer_val = ufs_renesas_read(hba, 0xd4) & 0x0000ffff;
 	ufs_renesas_write(hba, 0xd4, 0x00000000);
 	ufs_renesas_write_d0_d4(hba, 0x0000082c, 0x0f000000);
 	ufs_renesas_write_d0_d4(hba, 0x00000828, 0x08000000);
@@ -381,7 +328,7 @@ static void ufs_renesas_pre_init(struct ufs_hba *hba)
 
 	ufs_renesas_write(hba, 0xf0, 0);
 	ufs_renesas_write(hba, 0xd0, 0x00000d00);
-	ufs_renesas_restore(hba, 0xd4, TIMER_INDEX);
+	ufs_renesas_write(hba, 0xd4, timer_val);
 }
 
 static int ufs_renesas_hce_enable_notify(struct ufs_hba *hba,
-- 
2.51.0

