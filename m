Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8409AC55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 07:58:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 147EB40761;
	Thu,  6 Aug 2026 07:58:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dFEKLdHFJWOo; Thu,  6 Aug 2026 07:58:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 66E54405C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786003110;
	bh=YtgYB9eg0W91dn45vPlyzw09lKgT2lMbd/bdR6W1L4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hFDWl/98uK8ncTxinDqksL3i/fhLE3Aj8TbidmOaskiKCIx/q0J6+gu1lwGls0vKw
	 X+gnbnT6OeXEYcMwM1hKGkq38nCf7EeLr005KMELWodNIpLkS/B9JWVNK4RwQ447Xc
	 2DW0zKdWps4z82LfMo6QNW+sivXpT+hiUtCbvwZmGslrzVv/btMm8XxFIdHjJD37FE
	 3wqS5D+nxL2+bTc5g5XKwEDqXMB7iOkYxAdxoMwXIXfUxT232T7z1xB+ztZ7bwQcds
	 TP3Cr28y8QboAw+FuN+SoCIw6JAI9zqZhUi1tizGwbm23PUBf9RAl1dEWYu26Dj/ww
	 1brZv6XD5nQBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66E54405C0;
	Thu,  6 Aug 2026 07:58:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 873202B6
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 07:58:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D9E240132
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 07:58:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id udOzl5MVa48t for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 07:58:27 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=79.135.106.110;
 helo=mail-106110.protonmail.ch; envelope-from=sean@geanix.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 56AB04007E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 56AB04007E
Received: from mail-106110.protonmail.ch (mail-106110.protonmail.ch
 [79.135.106.110])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 56AB04007E
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 07:58:27 +0000 (UTC)
X-Pm-Submission-Id: 4hFzvn1zYwz2Sd3Q
From: Sean Nyekjaer <sean@geanix.com>
To: u-boot@lists.u-boot-project.org
Cc: Sean Nyekjaer <sean@geanix.com>
Subject: [RFC PATCH 2/2] tcan4x5x: set nwkrq voltage
Date: Thu,  6 Aug 2026 09:48:59 +0200
Message-ID: <20260806074917.418220-2-sean@geanix.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806074917.418220-1-sean@geanix.com>
References: <20260806074917.418220-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=geanix.com; 
 s=protonmail3; t=1786002598; x=1786261798;
 bh=YtgYB9eg0W91dn45vPlyzw09lKgT2lMbd/bdR6W1L4Y=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Rz9xEs9A/kYUEnAL/snd3NCVfvACmH+zoy1OrqO+OifRRr+EpYXcchMO3xoMxmpOU
 H2vBZGe+KRNg3gFbJxascwip0vqdzURX1IRruxSDNCbLpNJ2VD0cAh4eHgB9O09Pm+
 C4HwTmr9Elr42MA+qN+v1jxpqNRs0NHegyxXy90LJkD0Jk7AoBYIASGTn7jqL4d1Fm
 ORtBichlcROm5qU4K6Qq0bfKS0xWL6oxgdpA7DyN1zyLl5Qa94aXqgG/UOG8XnuGZD
 zCRaK1RuncNBzh/kel9LitvIL0/bJkMj1mUzGeQueO+dYET903KC7v1M/8BS5vpHYG
 QCtNrjVb8cHpA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=geanix.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=geanix.com header.i=@geanix.com header.a=rsa-sha256
 header.s=protonmail3 header.b=Rz9xEs9A
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

nwkrq can be driven from vio or vsup voltage, read from devicetree to
determine which rail should drive nwkrq.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/misc/tcan4x5x.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/misc/tcan4x5x.c b/drivers/misc/tcan4x5x.c
index a304f3db9df..e9e63f06e13 100644
--- a/drivers/misc/tcan4x5x.c
+++ b/drivers/misc/tcan4x5x.c
@@ -10,6 +10,7 @@
 
 #define TCAN4X5X_CONFIG 0x800
 #define TCAN4X5X_MODE_BITS (BIT(7) | BIT(6))
+#define TCAN4X5X_NWKRQ_VOLTAGE_VIO BIT(19)
 
 struct tcan4x5x_transfer {
 	u8 cmd;
@@ -87,6 +88,28 @@ static int tcan4x5x_enable_sleep(struct udevice *dev)
 	return ret;
 }
 
+static int tcan4x5x_nwkrq_vio(struct udevice *dev)
+{
+	u32 val;
+	int ret;
+
+	ret = tcan4x5x_read_reg(dev, TCAN4X5X_CONFIG, &val);
+	if (ret) {
+		log_err("failed to read from tcan4x5x\n");
+		return ret;
+	}
+
+	log_debug("read %x\n", val);
+	val |= TCAN4X5X_NWKRQ_VOLTAGE_VIO;
+	log_debug("write %x\n", val);
+
+	ret = tcan4x5x_write_reg(dev, TCAN4X5X_CONFIG, val);
+	if (ret)
+		log_err("reg write failed (%d)\n", ret);
+
+	return ret;
+}
+
 static int tcan4x5x_probe(struct udevice *dev)
 {
 	struct gpio_desc rst;
@@ -119,6 +142,13 @@ static int tcan4x5x_probe(struct udevice *dev)
 	 */
 	udelay(1000);
 
+	if (dev_read_bool(dev, "ti,nwkrq-voltage-vio")) {
+		log_debug("set nwkrq voltage to vio\n");
+		ret = tcan4x5x_nwkrq_vio(dev);
+		if (ret)
+			return ret;
+	}
+
 	return tcan4x5x_enable_sleep(dev);
 }
 
-- 
2.55.0

