Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7483CC83F1A
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 12:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FC63830EE;
	Mon, 21 Jul 2025 14:45:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="key not found in DNS" (0-bit key; unprotected) header.d=mobileye.com header.i=@mobileye.com header.b="jORtAiV2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8DFC82F6F; Mon, 21 Jul 2025 14:35:44 +0200 (CEST)
Received: from esa4.hc555-34.eu.iphmx.com (esa4.hc555-34.eu.iphmx.com
 [207.54.77.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B03EC82CA4
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 14:35:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=mobileye.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jimmy.wesolowski@mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
 t=1753101341; x=1784637341;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=EBmDuWQVrrNLC3IzftIhZphow5fo0To3htINRHlbWlc=;
 b=jORtAiV2AXvTC++v/oVqOHTZTN/BxThJkPNsE26GiWENQ7DpuAUSEDu4
 HswqmyipXHUwC8Jw/+RovZLWPNhghUeQf9TV7Lz+gRpx5UERN/5oyJAKw
 U7C2VKtWFEo88xM986z/TEIn0NGUMVNS2nEQT8mhifTlpe4Lleasw/zq2
 t/inYEu+1CoJ/HJzlmHS/LO1EN0apWrBnGtQwhDgcC7Kf19gIe9Okl9CD
 +BIydHsX+bt14aOiWhqmLROdlTs0y5ywkJDazwNyNf4vdc6BvFruCbQKV
 gsYe36W1nlYDU64sBFo8KcI+6l3PiM1mXAdgstZmD7DnFf+p1wC2PQxu+ Q==;
X-CSE-ConnectionGUID: x9cGZMB5SjSz/FOq1N0R2g==
X-CSE-MsgGUID: 8mNfSOZNS8WkVeamh0QIRw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
 by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2025 15:35:41 +0300
X-CSE-ConnectionGUID: 07FO8OFxSc6DMkDA3dXAWw==
X-CSE-MsgGUID: f7jbBpGvTn6emcubj/M0QQ==
Received: from unknown (HELO epgd074.me-corp.lan) ([10.154.54.6])
 by ces04_data.me-crop.lan with SMTP; 21 Jul 2025 15:35:38 +0300
Received: by epgd074.me-corp.lan (sSMTP sendmail emulation);
 Mon, 21 Jul 2025 15:35:39 +0300
From: Jimmy Durand Wesolowski <jimmy.wesolowski@mobileye.com>
To: u-boot@lists.denx.de
Cc: Iulian Banaga <iulianeugen.banaga@mobileye.com>,
 Jimmy Durand Wesolowski <jimmy.wesolowski@mobileye.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] Fix emmc error state after mmc write timeout
Date: Mon, 21 Jul 2025 15:35:00 +0300
Message-ID: <20250721123513.1105662-1-jimmy.wesolowski@mobileye.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Jul 2025 14:45:09 +0200
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

From: Iulian Banaga <iulianeugen.banaga@mobileye.com>

This is a fix for the sporadic mmc write failure:
  mmc write failed
  0 blocks written: ERROR

After this happens the emmc will remain in an error state
where subsequent read/writes fail with a timeout.

The mmc driver sends CMD25 - WRITE_MULTIPLE_BLOCK which
can sporadically timeout. When this happens, the mmc driver
aborts the transfer and returns the above error messages.

But the emmc still remains in data transfer mode, since
the timeout was decided by uboot, not by the emmc.

Fix this by sending the STOP_TRANSMISSION command (CMD12)
and waiting for the emmc to be in ready state again (CMD13).

Transferring data blocks after a CMD25 can take anywhere
between 5 and +15s on Samsung EMMCs and the current timeout
is not enough. Increase the timeout by 2x to accommodate the
long transfer times observed.

Signed-off-by: Iulian Banaga <iulianeugen.banaga@mobileye.com>
Acked-by: Jimmy Durand Wesolowski <jimmy.wesolowski@mobileye.com>
---

 drivers/mmc/mmc_write.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/mmc_write.c b/drivers/mmc/mmc_write.c
index 90fcf2679bb..37a42887cab 100644
--- a/drivers/mmc/mmc_write.c
+++ b/drivers/mmc/mmc_write.c
@@ -155,6 +155,7 @@ static ulong mmc_write_blocks(struct mmc *mmc, lbaint_t start,
 	struct mmc_cmd cmd;
 	struct mmc_data data;
 	int timeout_ms = 1000;
+	int err;
 
 	if ((start + blkcnt) > mmc_get_blk_desc(mmc)->lba) {
 		printf("MMC: block number 0x" LBAF " exceeds max(0x" LBAF ")\n",
@@ -181,9 +182,11 @@ static ulong mmc_write_blocks(struct mmc *mmc, lbaint_t start,
 	data.blocksize = mmc->write_bl_len;
 	data.flags = MMC_DATA_WRITE;
 
-	if (mmc_send_cmd(mmc, &cmd, &data)) {
+	err = mmc_send_cmd(mmc, &cmd, &data);
+	if (err) {
 		printf("mmc write failed\n");
-		return 0;
+		// do not return 0 here since the emmc will still be in data
+		// transfer mode continue to send the STOP_TRANSMISSION command
 	}
 
 	/* SPI multiblock writes terminate using a special
@@ -203,6 +206,9 @@ static ulong mmc_write_blocks(struct mmc *mmc, lbaint_t start,
 	if (mmc_poll_for_busy(mmc, timeout_ms))
 		return 0;
 
+	if (err)
+		return 0;
+
 	return blkcnt;
 }
 
-- 
2.47.0

base-commit: 3b4604a40b9fd61b87e9d059fc56f04d36f1a380
branch: master
