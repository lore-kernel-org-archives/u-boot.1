Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D163C54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 17:18:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A77160693;
	Fri, 31 Jul 2026 17:18:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 52xEB9kEXuwK; Fri, 31 Jul 2026 17:18:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 25435607B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785518334;
	bh=onBVZqa6AwLMXMQ0KuTQdtul9jTiMnnbUxwrNfIbQEo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eDtNeRr2YZhQdDqd6zCiYAdgbItuCkwyp5A3DW3jE9dYB1YW6oWxH8uugi3MMLMu2
	 VMlq9M4NUvca+KAQ9aiBvBLOastnuLrOd7nisD4rI4xolGH/RKvSbq3a0eOHGZrrwg
	 +5ZUal59rA89xK8lgQHTswvHBgN73muU1QS2Vp/JCntES/4bVjBu8IEBIkRlHLZogy
	 xjU1bI3CxyXuOQgCx2CSlkNgSPLsBU+fH7gCaSzR+wHOmTtqetxAJ/I+avrbiZx2vL
	 p9cxw3OZi9AC9ypgk8YSc39U6hntUr9YDULs19/zSSG7nSiYkiuxKjTrmE1szYzlRR
	 YlQ3KfMi7aLlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25435607B1;
	Fri, 31 Jul 2026 17:18:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 737B927B
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:11:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5961280EA3
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:11:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W-C5dkns2reU for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 17:11:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6D0BD80F2D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6D0BD80F2D
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6D0BD80F2D
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 17:11:25 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so776432f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 10:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785517883; x=1786122683;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=onBVZqa6AwLMXMQ0KuTQdtul9jTiMnnbUxwrNfIbQEo=;
 b=TR0lpTxdRdRRdAhMlrfWNow2eCYZR5Xn/TTVdGurox9jytH/jeGSSmJgrYibkrc3+Y
 JtrMyB+/1JqnHU8wKWWuSV9Q5khVWvXBWOjwvT85eFQMRWwRFLkU8JAKDiioVhLRBcWY
 +505XFUG26Ir5RUOLNnphHk7xrijuvC9s7GsmAQEg8+kfDjBQtbkMIuZt/Izr0c5uIb2
 Xk/1K9hLcxzAq6xRxLqvv8AdyAuMLVtsW8vI6FbhnqCNeA3lvWbHy30ECKR7WN3wQMok
 GJfZZ7ACqH0maNViCOxBojoHHTzvtfWId6/TJJcNDYhkse5YUOkvVmbiXqv8KuYUgxQh
 KPWg==
X-Gm-Message-State: AOJu0YxcihCt3+hfWkeezqqscl6o45x+i0VDWlOLHx5y+Yf1yHkj65yq
 0aBKxoHs37D2sUWATc2HBIwTnqMtO3uOxKP5z5UC0+nVsOie4x5sesiT7pFHBMFyqZY=
X-Gm-Gg: AR+sD133itMePHwBHhoP6uJZm8orfYaUL7sXtL8UcZ2Gjnh9vQwWSLnHptMRSGVJeim
 4tUe8DJ6m+sMg42I7gjGTyIdyYvTM6e4TJYUDBFdVLVOU2r5Bn0VTZBt320BBCBaE9xSR1irPpE
 57bxhetEeDFBc2fkm3Fis2pr02MZzrJRn/NkAIk7EKkXl4VsZzTMy4azzf4tN3hm9q2coi8CcC8
 woxdUo2P2PnVfmHYF19RgFph7rR7ehYi4J8fx6O8Pq9HGThQVanmIg+cOIDl8vv6VBf1klKlUw8
 ChRjmJH8xGoERu9UPEkBNw8RGLHmk4+THvpCo9Imi2jOFZRykVVQBU5iC0DPssKQBL0EXVtL2/Q
 A4TpDX3DqWy9WLTkENh49+x0GquL29CpTh7wf7NgucAUGznzXTPdpRVtaJIHXfyzCuAEOFzVtj1
 +TH3flMv4V64WSCzllk9U03VwylBIY64IW3klPDBlas05q0RtXixCzTX2n7GU5GplcLy8PCMc/b
 6645mos225u7ewBXfSQXBHBENuL7JFuvBPJhUGhEQ==
X-Received: by 2002:a05:6000:2504:b0:47f:d072:87cb with SMTP id
 ffacd0b85a97d-47fd731c80fmr894405f8f.47.1785517883125; 
 Fri, 31 Jul 2026 10:11:23 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-92-99-174-41.alshamil.net.ae.
 [92.99.174.41]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41d1a58sm7541484f8f.7.2026.07.31.10.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 10:11:22 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 31 Jul 2026 21:10:47 +0400
Subject: [PATCH v2 03/10] spl: ufs: add Falcon mode load path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-atf-falcon-v2-3-acb97c172993@flipper.net>
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
In-Reply-To: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>, Ronald Wahl <ronald.wahl@legrand.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>, 
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Quentin Schulz <u-boot@0leil.net>, 
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5012; i=alchark@flipper.net;
 h=from:subject:message-id; bh=5eQWJp9v2J5dfchut0ezJVhOSHR1/dpdjdOynBYVUCk=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTlXFfK2/dJ7pXNfE3n2/UMMbpaxjzhttV24g+uaOddY
 Dr19OGLjoksDGJcDJZiiixzvy2xnWrEN2uXh8dXmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHWMeIgYtTAKb6izfDX1FZ4fSyxQ4Cn9f8rSs/y7bGPyjPd/WGZcdFZrfkCHM5RjMyfHY89PC
 kYktluq2lL9/drUUJJ7esOPxXecF95qQTb3YvZgQA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Fri, 31 Jul 2026 17:18:49 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1785517883; x=1786122683;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=onBVZqa6AwLMXMQ0KuTQdtul9jTiMnnbUxwrNfIbQEo=;
 b=ENPgfJHWrRpoyUbb+n363gMsxdZ0L/tIwM1C5JNnPYRfCPJYiiBbQv/kwu/Wv/COss
 pdVUdKX6DJx25k3V3lLGccn4GcY2g41reEwEBxxR1i1aRA+n5jxzEqVd+gMvuHK6UvUC
 nxko0P7QQvBPI+dv27lBojOlPx0l3YL8cUM/z8/sj/9ktA9dfFkM+qMTFzuohGuGyKVf
 OwtjcoLkfQqrD1dHdFGwlIupCVol8qA8SFUByhUFm+70wQ1WHcuwlMIrmrQzIFs3sAjC
 na3KN6r3uNJFXd0gvHuO2zUkeUNIdFjj+ht0iuImIOdlbk9abKCjO64JFeiMltU4Gzyz
 b9tw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=ENPgfJHW
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

In Falcon mode, the SPL loads a FIT image containing a Linux kernel
instead of U-boot proper, and it may need to fall back to loading U-boot
if Linux is unavailable.

Add support for images containing a Linux kernel, optionally on a
different UFS LUN and/or offset vs. U-boot proper to enable fallback.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 common/spl/Kconfig   | 23 +++++++++++++++++++++
 common/spl/spl_ufs.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 7c639ed8f763..0e0c60eb9793 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1653,6 +1653,16 @@ config SPL_UFS_RAW_U_BOOT_DEVNUM
 	  SCSI device number, which might differ from the UFS LUN if you have
 	  multiple SCSI devices attached and recognized by the SPL.
 
+config SPL_UFS_RAW_OS_DEVNUM
+	int "Falcon mode: SCSI device number of the UFS device to load OS from"
+	depends on SPL_UFS_SUPPORT && SPL_OS_BOOT
+	default SPL_UFS_RAW_U_BOOT_DEVNUM
+	help
+	  UFS devices are usually configured with multiple LUNs, which present
+	  themselves as sequentially numbered SCSI devices. This option controls
+	  which of them SPL will attempt to load a Falcon OS payload from.
+	  It allows putting Linux FITs on a different UFS LU than U-Boot.
+
 config SPL_UFS_RAW_U_BOOT_SECTOR
 	hex "Address on the UFS to load U-Boot from"
 	depends on SPL_UFS_SUPPORT
@@ -1661,6 +1671,19 @@ config SPL_UFS_RAW_U_BOOT_SECTOR
 	  Address on the block device to load U-Boot from.
 	  Units: UFS sectors (1 sector = 4096 bytes).
 
+config SPL_UFS_RAW_OS_SECTOR
+	hex "Falcon mode: address on the UFS to load OS image from"
+	depends on SPL_UFS_SUPPORT && SPL_OS_BOOT
+	default SPL_UFS_RAW_U_BOOT_SECTOR
+	help
+	  Address on the block device to load a Falcon OS FIT/image from.
+	  Units: UFS sectors (1 sector = 4096 bytes).
+
+	  The default shares the region with U-Boot, which suits Falcon-only
+	  boot: the OS image is written where U-Boot would have gone, so only
+	  one region has to be reserved and there is no fallback. Point this
+	  at a separate location to keep a working U-Boot to fall back to.
+
 config SPL_WATCHDOG
 	bool "Support watchdog drivers"
 	imply SPL_WDT if !HW_WATCHDOG
diff --git a/common/spl/spl_ufs.c b/common/spl/spl_ufs.c
index cef1843f40f3..d35b5e7ad33a 100644
--- a/common/spl/spl_ufs.c
+++ b/common/spl/spl_ufs.c
@@ -20,13 +20,38 @@ static ulong spl_ufs_load_read(struct spl_load_info *load, ulong off, ulong size
 	return blk_dread(bd, sector, count, buf) << bd->log2blksz;
 }
 
+static int spl_ufs_load_image_raw_os(struct spl_image_info *spl_image,
+				     struct spl_boot_device *bootdev,
+				     struct spl_load_info *load,
+				     struct blk_desc *bd)
+{
+	ulong sector = config_opt_enabled(CONFIG_SPL_OS_BOOT,
+					  CONFIG_SPL_UFS_RAW_OS_SECTOR,
+					  CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR);
+	int err;
+
+	err = spl_load(spl_image, bootdev, load, 0,
+		       sector << bd->log2blksz);
+	if (err)
+		return err;
+
+	if (spl_image->os != IH_OS_LINUX && spl_image->os != IH_OS_TEE &&
+	    spl_image->os != IH_OS_ARM_TRUSTED_FIRMWARE) {
+		puts("Expected OS image is not found\n");
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
 static int spl_ufs_load_image(struct spl_image_info *spl_image,
 			      struct spl_boot_device *bootdev)
 {
 	unsigned long sector = CONFIG_SPL_UFS_RAW_U_BOOT_SECTOR;
+	struct spl_load_info load, os_load;
+	struct blk_desc *bd, *os_bd;
 	int devnum = CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM;
-	struct spl_load_info load;
-	struct blk_desc *bd;
+	int os_devnum;
 	int err;
 
 	/* try to recognize storage devices immediately */
@@ -36,6 +61,35 @@ static int spl_ufs_load_image(struct spl_image_info *spl_image,
 		return -ENODEV;
 
 	spl_load_init(&load, spl_ufs_load_read, bd, bd->blksz);
+	if (CONFIG_IS_ENABLED(OS_BOOT) && spl_falcon_boot()) {
+		os_devnum = config_opt_enabled(CONFIG_SPL_OS_BOOT,
+					       CONFIG_SPL_UFS_RAW_OS_DEVNUM,
+					       CONFIG_SPL_UFS_RAW_U_BOOT_DEVNUM);
+		if (os_devnum == devnum) {
+			os_bd = bd;
+			os_load = load;
+		} else {
+			os_bd = blk_get_devnum_by_uclass_id(UCLASS_SCSI, os_devnum);
+			if (!os_bd) {
+				puts("spl_ufs_load_image: UFS OS device not found\n");
+				if (CONFIG_IS_ENABLED(OS_BOOT_SECURE))
+					return -ENODEV;
+				goto load_uboot;
+			}
+			spl_load_init(&os_load, spl_ufs_load_read, os_bd, os_bd->blksz);
+		}
+
+		err = spl_ufs_load_image_raw_os(spl_image, bootdev, &os_load, os_bd);
+		if (!err)
+			return 0;
+
+		puts("spl_ufs_load_image: Failed to load falcon payload\n");
+		log_debug("(error=%d)\n", err);
+		if (CONFIG_IS_ENABLED(OS_BOOT_SECURE))
+			return err;
+	}
+
+load_uboot:
 	err = spl_load(spl_image, bootdev, &load, 0, sector << bd->log2blksz);
 	if (err) {
 		puts("spl_ufs_load_image: ufs block read error\n");

-- 
2.54.0

