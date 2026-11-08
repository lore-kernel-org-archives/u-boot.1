Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37697606A320
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 23:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BcnjfaR5;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0D3A3tKM
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96CE560718;
	Sun,  8 Nov 2026 23:34:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fl3PBFX-rB90; Sun,  8 Nov 2026 23:34:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E9955606E2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794180857;
	b=KCZAv51ZJnar5j/JV/0ARCWNERHH5N3GZjmHG9QzvdmckLWUtIN8tmCEkbiwGs2Lmn9n
	 /wnMg7Q2iq7BGHVJWz3ExVbbSWH0BBlsG5RUvyqD24SmOZ2Wyo1RcmR3+RsAnt20fqWzz
	 MEdpgosLyfeZV5Nz1b4XZGRdCV+LmhpzGrJG5JDVwpCllplfTyGYHaAouks3NKezY4aFk
	 bF5ShUJu5swzEzuOp+2ahPUW7ibGjJ+Arf4kpp3Ur/bq0Hv2P/4/oDs8WGvfH/mwxKM9F
	 U8JwmgJp4bdu82rJpF2Sponl6bBfYC/kq81M8kCe5s0ieZjG9ezQK8Z0gc/62LE5S2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794180857;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6JM62SRc2/W5ocbN7z0al6qXn/mdOE2nhj9cIQzBEWs=;
	b=FEoMBq4ZFBSF8CtITERV2zMg+o8yzQiWV8wdsB7OEAvqzhVZw3fVViEJ9BOY0yZcIiI2
	 pOhualbgsib2YX1O25OYMgDJTsqKo5L8Mjr16OdxqlyISAGi0kiWfyFdQzxEVrdRTgdrA
	 RXKqek0HHAeXaEe6HvT/hX0MCOfXblbmRSKC4NwRYBz2SEJiXe29Bj1o50qoauiUeuzxB
	 rK+7DqK68vJSLV4rTtZhJdAs67x9+/+Hqg6MZY1CXBlLPM3SAKY8IsIeQIQg9wBqDoMPt
	 vXr4IH07rsPIeveJB0p1ttraaPpaP97+Fk1Kdy7BVTICbC5p/ZJyFPPhklVnJqKWKSg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794180857;
	bh=6JM62SRc2/W5ocbN7z0al6qXn/mdOE2nhj9cIQzBEWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BcnjfaR5rS6lThcxcklT+NYUlvQbn7ReDV5lL7oDfqM1QcTKyzpb7kQdXi38Fu4E3
	 U38TJJndc41UTNse0UxSoiNPUdKI4xZeR1gNWvtX2MrRmY7M3iDN4LAdOh5XqdKtWP
	 miGhATdxh/HDhmt6P65oMJmeHHAmIup72rNScBq442zhIpp3IHmD5PGv2JzBJNBqs6
	 k1rSODe5jnC+HCxxJaWnVTIndDpqWRjD/nVuGv2aaZCbLlP/XbOgtSiWn7K9h+3NXg
	 aQ2GtJfSHzlL/7emJYKpKT95N0sfBrlrCTNvE2veS66pcd1C5CgoMiOp8UXtnfLGis
	 qCCGM7HzsL/DQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9955606E2;
	Sun,  8 Nov 2026 23:34:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D345317
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 23:34:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 230644064C
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 23:34:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ErJAAJnu7ZZT for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 23:34:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 21DDF4064B
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1230"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1230; helo=mail-dl1-x1230.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=0D3A3tKM
Received: from mail-dl1-x1230.google.com (mail-dl1-x1230.google.com
 [IPv6:2607:f8b0:4864:20::1230])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 21DDF4064B
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 23:34:13 +0000 (UTC)
Received: by mail-dl1-x1230.google.com with SMTP id
 a92af1059eb24-1b3a05f8b5bso526736c88.1
 for <u-boot@lists.u-boot-project.org>; Sun, 08 Nov 2026 15:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794180853; x=1794785653;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6JM62SRc2/W5ocbN7z0al6qXn/mdOE2nhj9cIQzBEWs=;
 b=0D3A3tKMMYDy1ZgHnrTtm7Fsp56Id6xFRZ06Rhzc71bfda6oPKU7oLOY9pjH+DewCJ
 2TpyVvAt5j2LoL6mYloDkTTfSbQytRoFTO6YTfUTHIBAz25E0m0h85Wb2+wvEl2uRfgf
 kSJIkgbhoFH+zRfKJkS+do7fxJjAGK4bnmf2kHX6CBnp9JQhgrxnFkeGTx71FLfVezqU
 xnQ970OsqdvEuE6nZ7c2pPjqg+sJa81UOtTOXJfH2XltYk4uuhpP1Ep0LgXyGUuR1DX4
 RBx2SwiLo9mUpZtbVn+FdiY/OhD0yAzF5YykJMqM03fAeilTIcHU2duYFhQIS6r5TR5g
 gnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794180853; x=1794785653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6JM62SRc2/W5ocbN7z0al6qXn/mdOE2nhj9cIQzBEWs=;
 b=TGC77r/spmQJv5yUpLIigFF8k5ywunrJDu+ui0dy7oEyOpDjBAbpFPSQ2/bb9UhyAN
 da8wiqZjyyOJNsfZBhonG4pbtdiU/Nttj1gLGPOLiDaQeiVJwM7kwMgNLFzME8g88JNE
 OJYhTB+PjODp3KkswS86wELfR/KSm3puM6bh7PhLIEapSCAJHsvrKb7Kb8HFT6vV3D6j
 4XDBqqF26EQVu0I+i27Ulw3Tbw/O8nRmTDiQ1K4MgBS4DwE4lyLvnUegSdTMQbK4QbrU
 SpYd00VfqQDNkwhjug+YkO3qbtz6LQ3yJE35RkrkH95uINW0tjwGMELAfcSVlxu5jyZD
 /Xig==
X-Gm-Message-State: APuU4Z8xNffOVuVa5c9gJbmzsWs9Ol6bfu4dlDWGsUebOb/H+XgHrysL
 BMreUgSlAwH4PkmrkOG/k95K/B3KcEyD3oDwJVHnEqR0NARpKhxlzWh7sUicPE5b
X-Gm-Gg: AYBFou1bIbaXhkqNZicIDaIwRskEdl8B4kFDx1THOx0kkVQcv890YmAjxW3Upm2oGdH
 XdeHjeuuHVW1dmx4xjUcrbtqyctbXIi7gDRhOTUvhhXgE48oKjwz1H3ooLu4qGDjhVIH8LRcFhS
 mh+XqG4TtkGxBab3mRCdDHUKnp89do8w9t6Es8kc1PgDJFa+iiUMuc6BSJDmqmmoOfZKHoQ8MBR
 A6P7m1rLA2IQdkidvsRYDKBvaqMQDTV4KUPlztEyEETqfq7EwVFq32PJg3+R6LVCC/uqpeeoo93
 6R7k8KSSLlD5MnvDVRSJOS9zYU2HIBLm/0ElJIwryjGIJhb9LprS3inhL57oaINP+MQSVsiM55R
 7OH8Wns3o0jsTHpNnU07MnHYdcjvG847IjKYVLPr0Z5cthylH+kRiOdWxNRQSNpwgqXUp9E1eJc
 h4rAzsA5LQc7zRywhZkaLT0dKSj3uuT6SqYT1E1GYHTbvOkOYUYlYjSeG/EjOrN73QvZaRpZWfd
 wj5DM1oog/moj871BoVgdvS1bLjQNv+jJuSy78U7H/soh+HYrA5VF5hkb75WKsCkbwkjQzLzLfQ
 qvwS81oVCPvktMO2K/15IYFULcBFS3bI3YzaiPPKpvAKudJ0sgrK048IBJmzgt9nfwvTiSS5g/O
 OFMB48UrUclOFp//bw0J+eKhpu2NbLHEkbIaTQP/ir80wQeRcX/cWlkHd+OTVJQc4oVEIMd98d1
 PVSXTgZ5b6
X-Received: by 2002:a05:7022:3a0c:b0:19a:20d3:a3d6 with SMTP id
 a92af1059eb24-1b39fe2a735mr4660179c88.1.1794180852707; 
 Sun, 08 Nov 2026 15:34:12 -0800 (PST)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3771eccb9sm7221006c88.19.2026.11.08.15.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 15:34:12 -0800 (PST)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, bin.meng@processmission.com, trini@konsulko.com,
 visitorckw@gmail.com, sjg@chromium.org, xypron.glpk@gmx.de
Subject: [PATCH v7 1/6] virtio: rtc: Add virtio RTC driver
Date: Mon,  9 Nov 2026 07:34:01 +0800
Message-ID: <20261108233410.1556875-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793836645.git.alan.tseng.cs@gmail.com>
References: <cover.1793836645.git.alan.tseng.cs@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QEMU provides a virtio RTC device (virtio-rtc-pci, virtio-rtc-device)
since v11.1.0, but U-Boot has no driver for it.

The virtqueue must not be used before the virtio uclass sets DRIVER_OK,
which happens after probe(), so the clock is looked up on the first read.

Like Linux, the driver prefers a VIRTIO_RTC_CLOCK_UTC_SMEARED clock, as
it never steps on leap seconds. QEMU master reports such a clock since
"virtio-rtc: Report smeared UTC clock type", but v11.1 reports
VIRTIO_RTC_CLOCK_UTC, so the driver falls back to another UTC clock
rather than leave U-Boot without an RTC there.

The set of clocks never changes, so if none of them is UTC, the driver
remembers it and fails later reads at once.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/virtio/Kconfig         |  11 ++
 drivers/virtio/Makefile        |   1 +
 drivers/virtio/virtio-uclass.c |   1 +
 drivers/virtio/virtio_rtc.c    | 244 +++++++++++++++++++++++++++++++++
 include/virtio.h               |   4 +-
 5 files changed, 260 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virtio/virtio_rtc.c

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 55b444280..48ab669f3 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -84,4 +84,15 @@ config VIRTIO_9P
 	help
 	  This enables the 9P transport driver over virtio.
 	  It can be used with QEMU based targets.
+
+config VIRTIO_RTC
+	bool "virtio RTC driver"
+	depends on DM_RTC
+	depends on VIRTIO
+	default y
+	help
+	  This enables the virtio RTC driver, which reads the UTC clock
+	  exposed by a virtio RTC device. QEMU v11.1.0 or later provides
+	  it as virtio-rtc-pci and virtio-rtc-device. The clocks are
+	  read-only, so the time cannot be set.
 endmenu
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index 6e7bcfc8e..ddb5ce4eb 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
 obj-$(CONFIG_VIRTIO_BLK) += virtio_blk.o
 obj-$(CONFIG_VIRTIO_RNG) += virtio_rng.o
 obj-$(CONFIG_VIRTIO_9P) += virtio_9p.o
+obj-$(CONFIG_VIRTIO_RTC) += virtio_rtc.o
diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclass.c
index 978ef0d1c..75c234a89 100644
--- a/drivers/virtio/virtio-uclass.c
+++ b/drivers/virtio/virtio-uclass.c
@@ -32,6 +32,7 @@ static const char *const virtio_drv_name[VIRTIO_ID_MAX_NUM] = {
 	[VIRTIO_ID_BLOCK]	= VIRTIO_BLK_DRV_NAME,
 	[VIRTIO_ID_RNG]		= VIRTIO_RNG_DRV_NAME,
 	[VIRTIO_ID_9P]		= VIRTIO_9P_DRV_NAME,
+	[VIRTIO_ID_CLOCK]	= VIRTIO_RTC_DRV_NAME,
 };
 
 int virtio_get_config(struct udevice *vdev, unsigned int offset,
diff --git a/drivers/virtio/virtio_rtc.c b/drivers/virtio/virtio_rtc.c
new file mode 100644
index 000000000..f164c75e0
--- /dev/null
+++ b/drivers/virtio/virtio_rtc.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026, Hung-Chun Tseng <alan.tseng.cs@gmail.com>
+ *
+ * Driver for the virtio RTC device (virtio device ID 17). The device
+ * exposes one or more read-only clocks through a request virtqueue; this
+ * driver reads a UTC clock, preferring one which smears leap seconds, and
+ * reports it through the RTC uclass.
+ */
+
+#include <div64.h>
+#include <dm.h>
+#include <log.h>
+#include <rtc.h>
+#include <time.h>
+#include <virtio_types.h>
+#include <virtio.h>
+#include <virtio_ring.h>
+#include <linux/types.h>
+
+#define VIRTIO_RTC_TIMEOUT_MS		1000
+
+#define VIRTIO_RTC_REQ_READ		0x0001
+#define VIRTIO_RTC_REQ_CFG		0x1000
+#define VIRTIO_RTC_REQ_CLOCK_CAP	0x1001
+
+#define VIRTIO_RTC_S_OK			0
+
+#define VIRTIO_RTC_CLOCK_UTC			0
+#define VIRTIO_RTC_CLOCK_UTC_SMEARED		3
+#define VIRTIO_RTC_CLOCK_UTC_MAYBE_SMEARED	4
+
+struct virtio_rtc_req_head {
+	__le16 msg_type;
+	u8 reserved[6];
+};
+
+struct virtio_rtc_resp_head {
+	u8 status;
+	u8 reserved[7];
+};
+
+/* Request for VIRTIO_RTC_REQ_READ and VIRTIO_RTC_REQ_CLOCK_CAP */
+struct virtio_rtc_req_clock {
+	struct virtio_rtc_req_head head;
+	__le16 clock_id;
+	u8 reserved[6];
+};
+
+struct virtio_rtc_resp_read {
+	struct virtio_rtc_resp_head head;
+	__le64 clock_reading;
+};
+
+struct virtio_rtc_resp_cfg {
+	struct virtio_rtc_resp_head head;
+	__le16 num_clocks;
+	u8 reserved[6];
+};
+
+struct virtio_rtc_resp_clock_cap {
+	struct virtio_rtc_resp_head head;
+	u8 type;
+	u8 leap_second_smearing;
+	u8 flags;
+	u8 reserved[5];
+};
+
+struct virtio_rtc_priv {
+	struct virtqueue *vq;
+	u16 clock_id;
+	bool clock_found;
+	bool no_utc_clock;
+};
+
+static int virtio_rtc_xfer(struct udevice *dev, void *req, size_t req_len,
+			   void *resp, size_t resp_len)
+{
+	struct virtio_rtc_priv *priv = dev_get_priv(dev);
+	struct virtio_rtc_resp_head *head = resp;
+	struct virtio_sg req_sg = { req, req_len };
+	struct virtio_sg resp_sg = { resp, resp_len };
+	struct virtio_sg *sgs[] = { &req_sg, &resp_sg };
+	unsigned int len;
+	ulong start;
+	int ret;
+
+	ret = virtqueue_add(priv->vq, sgs, 1, 1);
+	if (ret)
+		return ret;
+
+	virtqueue_kick(priv->vq);
+
+	start = get_timer(0);
+	while (!virtqueue_get_buf(priv->vq, &len)) {
+		if (get_timer(start) > VIRTIO_RTC_TIMEOUT_MS)
+			return -ETIMEDOUT;
+	}
+
+	if (len < sizeof(*head) || head->status != VIRTIO_RTC_S_OK)
+		return -EIO;
+
+	if (len < resp_len)
+		return -EPROTO;
+
+	return 0;
+}
+
+static bool virtio_rtc_is_utc(u8 type)
+{
+	return type == VIRTIO_RTC_CLOCK_UTC ||
+	       type == VIRTIO_RTC_CLOCK_UTC_SMEARED ||
+	       type == VIRTIO_RTC_CLOCK_UTC_MAYBE_SMEARED;
+}
+
+static int virtio_rtc_find_utc_clock(struct udevice *dev)
+{
+	struct virtio_rtc_priv *priv = dev_get_priv(dev);
+	struct virtio_rtc_req_head cfg_req = {
+		.msg_type = cpu_to_le16(VIRTIO_RTC_REQ_CFG),
+	};
+	struct virtio_rtc_resp_cfg cfg = {};
+	u16 num_clocks, id, utc_id = 0;
+	bool utc_found = false;
+	int ret;
+
+	ret = virtio_rtc_xfer(dev, &cfg_req, sizeof(cfg_req), &cfg, sizeof(cfg));
+	if (ret)
+		return ret;
+
+	num_clocks = le16_to_cpu(cfg.num_clocks);
+	for (id = 0; id < num_clocks; id++) {
+		struct virtio_rtc_req_clock req = {
+			.head.msg_type = cpu_to_le16(VIRTIO_RTC_REQ_CLOCK_CAP),
+			.clock_id = cpu_to_le16(id),
+		};
+		struct virtio_rtc_resp_clock_cap cap = {};
+
+		ret = virtio_rtc_xfer(dev, &req, sizeof(req), &cap, sizeof(cap));
+		if (ret)
+			return ret;
+
+		/*
+		 * Like Linux, prefer a clock which smears leap seconds, but fall
+		 * back to another UTC clock, which is all that QEMU v11.1 has.
+		 */
+		if (cap.type == VIRTIO_RTC_CLOCK_UTC_SMEARED) {
+			utc_id = id;
+			utc_found = true;
+			break;
+		}
+
+		if (!utc_found && virtio_rtc_is_utc(cap.type)) {
+			utc_id = id;
+			utc_found = true;
+		}
+	}
+
+	/* The set of clocks is fixed, so remember that none of them is UTC */
+	if (!utc_found) {
+		priv->no_utc_clock = true;
+		return -ENODEV;
+	}
+
+	priv->clock_id = utc_id;
+	priv->clock_found = true;
+
+	return 0;
+}
+
+static int virtio_rtc_get(struct udevice *dev, struct rtc_time *time)
+{
+	struct virtio_rtc_priv *priv = dev_get_priv(dev);
+	struct virtio_rtc_req_clock req = {
+		.head.msg_type = cpu_to_le16(VIRTIO_RTC_REQ_READ),
+	};
+	struct virtio_rtc_resp_read resp = {};
+	u64 now;
+	int ret;
+
+	/*
+	 * The virtqueue must not be used before DRIVER_OK, which the virtio
+	 * uclass sets only after probe(), so look for the clock on first use.
+	 */
+	if (priv->no_utc_clock)
+		return -ENODEV;
+
+	if (!priv->clock_found) {
+		ret = virtio_rtc_find_utc_clock(dev);
+		if (ret)
+			return ret;
+	}
+
+	req.clock_id = cpu_to_le16(priv->clock_id);
+
+	ret = virtio_rtc_xfer(dev, &req, sizeof(req), &resp, sizeof(resp));
+	if (ret)
+		return ret;
+
+	now = le64_to_cpu(resp.clock_reading);
+	do_div(now, 1000000000U);
+	rtc_to_tm(now, time);
+
+	return 0;
+}
+
+static int virtio_rtc_bind(struct udevice *dev)
+{
+	struct virtio_dev_priv *uc_priv = dev_get_uclass_priv(dev->parent);
+
+	/* The alarm feature is not supported */
+	virtio_driver_features_init(uc_priv, NULL, 0, NULL, 0);
+
+	return 0;
+}
+
+static int virtio_rtc_probe(struct udevice *dev)
+{
+	struct virtio_rtc_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = virtio_find_vqs(dev, 1, &priv->vq);
+	if (ret < 0) {
+		debug("%s: virtio_find_vqs failed\n", __func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct rtc_ops virtio_rtc_ops = {
+	.get	= virtio_rtc_get,
+};
+
+U_BOOT_DRIVER(virtio_rtc) = {
+	.name	= VIRTIO_RTC_DRV_NAME,
+	.id	= UCLASS_RTC,
+	.bind	= virtio_rtc_bind,
+	.probe	= virtio_rtc_probe,
+	.remove	= virtio_reset,
+	.ops	= &virtio_rtc_ops,
+	.priv_auto	= sizeof(struct virtio_rtc_priv),
+	.flags	= DM_FLAG_ACTIVE_DMA,
+};
diff --git a/include/virtio.h b/include/virtio.h
index 30e5005e9..fb8b396d8 100644
--- a/include/virtio.h
+++ b/include/virtio.h
@@ -32,12 +32,14 @@
 #define VIRTIO_ID_BLOCK		2 /* virtio block */
 #define VIRTIO_ID_RNG		4 /* virtio rng */
 #define VIRTIO_ID_9P		9 /* virtio 9p */
-#define VIRTIO_ID_MAX_NUM	10
+#define VIRTIO_ID_CLOCK		17 /* virtio clock/timer (rtc) */
+#define VIRTIO_ID_MAX_NUM	18
 
 #define VIRTIO_NET_DRV_NAME	"virtio-net"
 #define VIRTIO_BLK_DRV_NAME	"virtio-blk"
 #define VIRTIO_RNG_DRV_NAME	"virtio-rng"
 #define VIRTIO_9P_DRV_NAME	"virtio-9p"
+#define VIRTIO_RTC_DRV_NAME	"virtio-rtc"
 
 /* Feature bits for virtio 9P */
 #define VIRTIO_9P_MOUNT_TAG	0
-- 
2.43.0

