Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD0CFC6166
	for <u-boot@archiver.kernel.org>; Sat,  3 Jan 2026 00:23:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82B76842DF;
	Sat,  3 Jan 2026 01:23:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nLLjMQZ/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VQkrgWJt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76C96842D2; Sat,  3 Jan 2026 01:23:30 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D95F3842C3
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 01:23:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4djh9q4fY4z9tB5;
 Sat,  3 Jan 2026 01:23:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767399807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gVVlN/8kufRLX70/mx80/ERafoiuCxUcH9xQU4UxHag=;
 b=nLLjMQZ/SNl3MBtTv539b8d0tPFGzUxgQrgNR1J+62xZLw8iaDxb3NMoV0r7p5wLuKVrbN
 jO+sQ8c6e7xfWGlpcibmmMf70fAhr9ih39J3mJkpBSHh5XXXcittZxik7CWSN9k+braSSm
 gkPv2NYqyO+61uA3Blvv1KT7U6HWesBgcI3ePUAKDsvUkTUNAiS6iIL/LYZVZyGVKi7YuU
 lvjkkQcH95lYdkva9hqmArEkHylQ7ee+eLgmejg1G2JPEKanwKfWoB503gfBF6hOYmC9lF
 zcHZs8wqT+cVW0f21zBjPwHkNSF+s/rGzIpoxQINgBDagrUw5S84pCWXwHI2fQ==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=VQkrgWJt;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767399805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gVVlN/8kufRLX70/mx80/ERafoiuCxUcH9xQU4UxHag=;
 b=VQkrgWJtlnH06rIcCojmlzYLZKe4ZqRI4hJc94Fj2xv4Gzftp5ECL+vHZ2vzLXgmdUWm+s
 odK+U9NYDDxP+ZwWjwqx4X0bYDjy4+r2Ljt2tFJPNL9SbZy6oRW7eXKtZWyiIKV5/B1Hxd
 6X7fIQyulpQ5mbPsWtmkPnvalayzi/JMFClvJOmFYMgtCNIfQkwkMjLEiCJSLMkrkLBGmM
 0UUsVjVj/bSvRYbLo22VadDusQdh1sK1Bo68LRVrRfnYUcV5ZzTBBLgXVjINVBG7DuPjMr
 kAGk9RgmeYHV30PpVrgLtQO3qEManJNtEeqv8zQa/IiXrwP2E0r3+bp7A13bqg==
To: u-boot@lists.denx.de
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/5] scsi: ufs: renesas: Remove register control helper
 function
Date: Sat,  3 Jan 2026 01:22:29 +0100
Message-ID: <20260103002254.183357-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260103002254.183357-1-marek.vasut+renesas@mailbox.org>
References: <20260103002254.183357-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: mcf4a383y56ezqi45bk5zr6qwaxrou1g
X-MBO-RS-ID: 4e5662649964befa331
X-Rspamd-Queue-Id: 4djh9q4fY4z9tB5
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

After refactoring the code, ufs_renesas_reg_control() is no longer needed,
because all operations are simple and can be called directly.  Remove the
ufs_renesas_reg_control() helper function, and call udelay() directly.

Ported from Linux kernel commit
855bde8ce5bc ("scsi: ufs: renesas: Remove register control helper function")
with replaced readl_poll_timeout_atomic() with readl_poll_sleep_timeout().

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/69500e4c18be1ca1de360f9e797e282ffef04004.1741179611.git.geert+renesas@glider.be
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
 drivers/ufs/ufs-renesas.c | 101 ++++++--------------------------------
 1 file changed, 14 insertions(+), 87 deletions(-)

diff --git a/drivers/ufs/ufs-renesas.c b/drivers/ufs/ufs-renesas.c
index 8c9a9ec7695..c8fbe61901b 100644
--- a/drivers/ufs/ufs-renesas.c
+++ b/drivers/ufs/ufs-renesas.c
@@ -23,100 +23,27 @@ struct ufs_renesas_priv {
 	bool initialized;	/* The hardware needs initialization once */
 };
 
-enum ufs_renesas_init_param_mode {
-	MODE_POLL,
-	MODE_READ,
-	MODE_WAIT,
-	MODE_WRITE,
-};
-
-struct ufs_renesas_init_param {
-	enum ufs_renesas_init_param_mode mode;
-	u32 reg;
-	union {
-		u32 expected;
-		u32 delay_us;
-		u32 val;
-	} u;
-	u32 mask;
-	u32 index;
-};
-
-static u32 ufs_renesas_reg_control(struct ufs_hba *hba,
-				   const struct ufs_renesas_init_param *p)
-{
-	u32 val = 0;
-	int ret;
-
-	switch (p->mode) {
-	case MODE_POLL:
-		ret = readl_poll_timeout(hba->mmio_base + p->reg, val,
-					 (val & p->mask) == p->u.expected,
-					 10000);
-		if (ret)
-			dev_err(hba->dev, "%s: poll failed %d (%08x, %08x, %08x)\n",
-				__func__, ret, val, p->mask, p->u.expected);
-		break;
-	case MODE_READ:
-		val = ufshcd_readl(hba, p->reg);
-		break;
-	case MODE_WAIT:
-		if (p->u.delay_us > 1000)
-			mdelay(DIV_ROUND_UP(p->u.delay_us, 1000));
-		else
-			udelay(p->u.delay_us);
-		break;
-	case MODE_WRITE:
-		ufshcd_writel(hba, p->u.val, p->reg);
-		break;
-	default:
-		break;
-	}
-
-	return val;
-}
-
 static void ufs_renesas_poll(struct ufs_hba *hba, u32 reg, u32 expected, u32 mask)
 {
-	struct ufs_renesas_init_param param = {
-		.mode = MODE_POLL,
-		.reg = reg,
-		.u.expected = expected,
-		.mask = mask,
-	};
-
-	ufs_renesas_reg_control(hba, &param);
+	int ret;
+	u32 val;
+
+	ret = readl_poll_sleep_timeout(hba->mmio_base + reg,
+				       val, (val & mask) == expected,
+				       10, 1000);
+	if (ret)
+		dev_err(hba->dev, "%s: poll failed %d (%08x, %08x, %08x)\n",
+			__func__, ret, val, mask, expected);
 }
 
 static u32 ufs_renesas_read(struct ufs_hba *hba, u32 reg)
 {
-	struct ufs_renesas_init_param param = {
-		.mode = MODE_READ,
-		.reg = reg,
-	};
-
-	return ufs_renesas_reg_control(hba, &param);
-}
-
-static void ufs_renesas_wait(struct ufs_hba *hba, u32 delay_us)
-{
-	struct ufs_renesas_init_param param = {
-		.mode = MODE_WAIT,
-		.u.delay_us = delay_us,
-	};
-
-	ufs_renesas_reg_control(hba, &param);
+	return ufshcd_readl(hba, reg);
 }
 
 static void ufs_renesas_write(struct ufs_hba *hba, u32 reg, u32 value)
 {
-	struct ufs_renesas_init_param param = {
-		.mode = MODE_WRITE,
-		.reg = reg,
-		.u.val = value,
-	};
-
-	ufs_renesas_reg_control(hba, &param);
+	ufshcd_writel(hba, value, reg);
 }
 
 static void ufs_renesas_write_d0_d4(struct ufs_hba *hba, u32 data_d0, u32 data_d4)
@@ -210,13 +137,13 @@ static void ufs_renesas_pre_init(struct ufs_hba *hba)
 	/* This setting is for SERIES B */
 	ufs_renesas_write(hba, 0xc0, 0x49425308);
 	ufs_renesas_write_d0_d4(hba, 0x00000104, 0x00000002);
-	ufs_renesas_wait(hba, 1);
+	udelay(1);
 	ufs_renesas_write_d0_d4(hba, 0x00000828, 0x00000200);
-	ufs_renesas_wait(hba, 1);
+	udelay(1);
 	ufs_renesas_write_d0_d4(hba, 0x00000828, 0x00000000);
 	ufs_renesas_write_d0_d4(hba, 0x00000104, 0x00000001);
 	ufs_renesas_write_d0_d4(hba, 0x00000940, 0x00000001);
-	ufs_renesas_wait(hba, 1);
+	udelay(1);
 	ufs_renesas_write_d0_d4(hba, 0x00000940, 0x00000000);
 
 	ufs_renesas_write(hba, 0xc0, 0x49425308);
-- 
2.51.0

