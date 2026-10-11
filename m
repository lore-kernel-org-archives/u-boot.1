Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6093CA9EC9
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 05:17:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F04D44073F;
	Sun, 11 Oct 2026 05:17:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1m83doA_jVyU; Sun, 11 Oct 2026 05:17:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 389F140721
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791695869;
	b=STTehtWeSaV6EdnXnBhPVUMxjlSRX6XxPLbfzw0V3Zu3uzieSG5ygAyUdP3mTWYRj0pe
	 o3FpRqV0UY3cqurMfmpZmR3MMw5nO6N3fPFGRtF35XX2dhOozGiThk/E3bdIQsixe9bXb
	 8hJGbsWfeBsjPdD7QRdstdOeeK5cr5g6hlFgo+jQOQb7TF3XetVG37ZaiVFqb3pW4QO5z
	 pM8pDh9+JVb0FkBYqe68c13IFTeXY7ySQfWSy+kNt5VZ36E3Z5cZGe68BMJKC4Mnz69aX
	 Q45ZcDcWzRtRyoTxBPb7W8deTRlyc72V4OSfHpUhUVOcFCnO3cFUDHjibcTRyGNP+xg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791695869;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:Errors-To;
	bh=QmOeRYuemFmEaL3C7Ra8stpShtneO+uGVDsuKhVBErM=;
	b=VoECmfCDA1luH+OnWdZnvC5N8NmqK5IthX8VLffgAt03WxYWvPH68KV5aAb/8Q9NBQc/
	 UzlPO7HUYYRs1Q/tbTr0m91Hp2QhECskDrc5kG8YjwCKYypW6F4Ch662gx+M2JpjdoVsX
	 2kse+ze54W63V3Js4PdXGlOMw5u5vf2+ihkpTtT5U+SbSj+QdVaPgncFsqJEGv+PLHPj9
	 hpSC1gFuw8gzIfVJRROkwpHa5cYgFx4A92BWSfLX79Tippl+LIl5+4EjUXFWigxnWiky+
	 R1mB4OnK9qppeeA1yqgfrPKHKgcjjQncnLasX/mE5eNi/D0TLELauqy9eFbbvVm/qyg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791695869;
	bh=QmOeRYuemFmEaL3C7Ra8stpShtneO+uGVDsuKhVBErM=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=TaQhCdpc6VHmet4jWVLMwV9goY7g0tT4NMIzH+XkTKLfL8Ifk+rxI12aTEDlrGyu6
	 oS1+FeU40Zcid5C8zsQhRBYHja/5g3RCrDpjke332wf89M9EsZhVp1525N2oYXATE/
	 GeMvsPiAydJtmqr80JfhG9o/GNqsSMkjjE+clEaXTZOblERbTiUpoa5dEOm6whOTcF
	 wgL7wDvtL+Ubvk+Xqf1vlreJeMUnsSrdEtxUH4hvG2HUuheqt6WN7AAaSUf3EYpzO5
	 AJalUA2xNzHENEgkJcWP0sB0u5NSfzcZo+CB6k10wE8WV7rW/5N6NYk1jNNPGBz7dx
	 bDtGadKpx+T4g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 389F140721;
	Sun, 11 Oct 2026 05:17:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 49868156
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 05:17:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 46DBE81066
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 05:17:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CO0ZG-r-PU5J for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 05:17:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7A6A881065
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791695867;
 b=WD3HmEF3zUo4E3pSjpG1ndNJPyhG3OHblmPGJlw+dACz4bJq+ggAjNbi9y0KLqnZ3WWY
 ZyGhIypF75bcRNY5kaougWGyOEePqbBTWb64qTbmr1F55fL2E3vWa50u0g03TXb10f12j
 5ERQZTGOR4QegajwVTjiGAJAZ6f6MlsvIqforiYQXrW/mtAd7SSTBAAc0T9nX22Gy2jdn
 NdbwUtxdC/orcrtaYPyL7RkE/qiSvK7fPSabnVIr7qE0eJx1b6yS5lUzhTED2uiDgGXU0
 bcpxukPZnUCGnvtc1677A7KxlHtdYThbIupGfRt3ijLzr2Drdt6h6KWDS31xKiLUDZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791695867;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
 bh=QmOeRYuemFmEaL3C7Ra8stpShtneO+uGVDsuKhVBErM=;
 b=j0wlSOEHZ1WIi18QiEm001q/vpipFmfn/Urw8ejQ8iibO6rR9/GpDYv3tCE5ujn88CWf
 yI8Az57mB0TaXlFDLoUmFzu4tKBa0d43sDgxcUgX8Q2awoJUTxoS3Zee2GETNrvr647J0
 /KK+1VJet4XpCp5v0rlyffv0BTVyzVqVg0NVN8ulQ+WE44lRTjAO5PhSfgCrzFs7o4k4D
 vjoFNI+BmtW5ZqGBkrpQEjFGxbOazPd3VlDBajpATMmDU1Ak4CRVqLjovHCGMDxrLS+RW
 aQTHLvXr2LyPA1RCMcNvm72Ld7COFfnLlgKQYMu/lVve5lT4IsdZM1pptwSTSvzCnew==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=kzbcjrdm; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=devnull+iav.iav.lv@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=kzbcjrdm
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A6A881065
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 05:17:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 53D6543FB7;
 Sun, 11 Oct 2026 05:17:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 335DCC2BCF5;
 Sun, 11 Oct 2026 05:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791695866;
 bh=hvmkSsiC+ddWOBbUvja87DKBLTYDfTDJMe6gh14Srwo=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=kzbcjrdmCy+fSblTzzxT3JKFak7a+NhwsiF0I58141LNtRvv+sDkkHGhVWZbuPbxp
 6vfHpbHXbHZEt/h/tveI5Rjz9KpdwNlu9TlCfVb3MaQ1U30WEYSNu8wdwop87DI2q5
 qJpI0OmZE7LrQCPesBKO1orOaZ1wpv5Q4raY5P5DkaOH9LXmNxnv4t+MsWrDCi8Ugx
 O0sOUyFzRb9KdyAB1HUYxrgoCJNo9JdTXKaXFlF4+82tcd9J5HIcNLrSyZ5aclKi4C
 r2aSeTKhuOnrE3VEtI+qqhfgezOYSKmxBJ8amVgsm0NsscLFkieqcoX7i6hA2XaIep
 MYZi90Np2q0cw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6BDCA9EC9;
 Sun, 11 Oct 2026 05:17:46 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Sun, 11 Oct 2026 05:17:43 +0000
Subject: [PATCH] arm: mvebu: helios4: derive MAC address from SPI NOR unique ID
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-helios4-flash-uid-mac-v1-1-203cd429f46c@iav.lv>
X-B4-Tracking: v=1; b=H4sIAPYby2oC/x3MSwqAMAwA0atI1gZMERWvIi5CTW3AHw2KIN7d4
 vItZh4wSSoGffFAkktN9y2DygJ85G0W1CkbXOUaqogwyqK71RgWtoinTriyRwqOW+o8+44gt0e
 SoPf/Hcb3/QASykgYZwAAAA==
To: Stefan Roese <stefan.roese@mailbox.org>, 
 Dennis Gilmore <dgilmore@redhat.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3621; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=2niEr8NMC8m66WbZMz5U4o5Kw4aoSUy4WocltDuWjeo=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFmnpX9wtHUfKj024ZDMwpYz3eu59u81cmqcXlLOa1lf3
 1nM2Pego5SFQYyLQVZMkWXCIY1bGUuu/vX3MH8AM4eVCWQIAxenAEyk2YHhr8DRGKuTOitcNXQ4
 yg/3lOjf3Dm7enYVB5epDMdaxr8hDxkZJpX+avt2dOYz/cm6udO/exkfzZ/7JyJhZ0vqtUcq+6v
 /sgIA
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
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
Reply-To: iav@iav.lv
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Igor Velkov <iav@iav.lv>

Helios4 has no factory MAC address, so without a saved eth1addr it
gets a random one on every boot. Derive a stable, locally administered
address from the SHA-256 of the 64-bit unique ID of the SPI NOR on the
SoM, the way rockchip_setup_macaddr() does with the CPU ID. A saved
eth1addr still takes precedence.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
Tested on Helios4: two power cycles give the same address and DHCP
uses it. With the same change on v2026.07, Linux gets the address
through the device tree and a saved eth1addr is left untouched.
---
 board/kobol/helios4/helios4.c | 58 +++++++++++++++++++++++++++++++++++++++++++
 configs/helios4_defconfig     |  3 +++
 2 files changed, 61 insertions(+)

diff --git a/board/kobol/helios4/helios4.c b/board/kobol/helios4/helios4.c
index 7714076edf1..342a3cb3c73 100644
--- a/board/kobol/helios4/helios4.c
+++ b/board/kobol/helios4/helios4.c
@@ -5,15 +5,21 @@
  */
 
 #include <config.h>
+#include <env.h>
 #include <i2c.h>
 #include <init.h>
 #include <miiphy.h>
 #include <net.h>
 #include <netdev.h>
+#include <spi-mem.h>
+#include <spi_flash.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
+#include <dm/device.h>
+#include <linux/string.h>
+#include <u-boot/sha256.h>
 
 #include "../drivers/ddr/marvell/a38x/ddr3_init.h"
 #include <../serdes/a38x/high_speed_env_spec.h>
@@ -133,3 +139,55 @@ int board_eth_init(struct bd_info *bis)
 	cpu_eth_init(bis); /* Built in controller(s) come first */
 	return pci_eth_init(bis);
 }
+
+#define SPINOR_OP_RDUID		0x4b
+#define SPINOR_UID_LEN		8
+
+static int helios4_read_flash_uid(u8 *uid)
+{
+	struct spi_mem_op op =
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDUID, 1),
+			   SPI_MEM_OP_NO_ADDR,
+			   SPI_MEM_OP_DUMMY(4, 1),
+			   SPI_MEM_OP_DATA_IN(SPINOR_UID_LEN, uid, 1));
+	struct spi_flash *flash;
+	struct udevice *dev;
+	int ret;
+
+	ret = spi_flash_probe_bus_cs(CONFIG_SF_DEFAULT_BUS,
+				     CONFIG_SF_DEFAULT_CS, &dev);
+	if (ret)
+		return ret;
+
+	flash = dev_get_uclass_priv(dev);
+	ret = spi_mem_exec_op(flash->spi, &op);
+	if (ret)
+		return ret;
+
+	if (!memchr_inv(uid, 0x00, SPINOR_UID_LEN) ||
+	    !memchr_inv(uid, 0xff, SPINOR_UID_LEN))
+		return -ENODATA;
+
+	return 0;
+}
+
+/*
+ * The board has no factory MAC address, so derive a stable one from the
+ * unique ID of the SPI NOR on the SoM.
+ */
+int misc_init_r(void)
+{
+	u8 uid[SPINOR_UID_LEN];
+	u8 mac[SHA256_SUM_LEN];
+
+	/* ethernet@70000 is aliased as ethernet1 */
+	if (env_get("eth1addr") || helios4_read_flash_uid(uid))
+		return 0;
+
+	sha256_csum_wd(uid, sizeof(uid), mac, CHUNKSZ_SHA256);
+	mac[0] &= 0xfe;	/* unicast */
+	mac[0] |= 0x02;	/* locally administered */
+	eth_env_set_enetaddr("eth1addr", mac);
+
+	return 0;
+}
diff --git a/configs/helios4_defconfig b/configs/helios4_defconfig
index c78a41058c8..328e9e92727 100644
--- a/configs/helios4_defconfig
+++ b/configs/helios4_defconfig
@@ -33,6 +33,7 @@ CONFIG_USE_PREBOOT=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_MISC_INIT_R=y
 CONFIG_SPL_MAX_SIZE=0x22fd0
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_I2C=y
@@ -80,3 +81,5 @@ CONFIG_SYS_NS16550=y
 CONFIG_KIRKWOOD_SPI=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
+CONFIG_SHA256=y
+# CONFIG_SPL_SHA256 is not set

---
base-commit: 5e3b01c8466dbe45cd6a06299f8f4c7e8c1c2363
change-id: 20261011-helios4-flash-uid-mac-1f2a718cac81

Best regards,
-- 
Igor Velkov <iav@iav.lv>


