Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBC1606A31C
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 23:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=DOGVDW5M;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WNFbreLc
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 134C280E9C;
	Sun,  8 Nov 2026 23:34:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R-LIAU9iHH6g; Sun,  8 Nov 2026 23:34:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E0DEF80E25
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794180867;
	b=bq4gyAVEvlh7wqd+ukPggDbEXJSBu+h0ocoYYpxAzlo9oi569yu4l4iKcjYLed/I9Gew
	 xZ3oVDV18sicrlnEq8FXDznLYZmMzS9hSSYF1kcfuD0Nke5Vwyu44PEgd6k5QkaIClnLh
	 j/iEJDmeQY8EX4cAO/lnsI/2tFIbe7oeRikCEc7R/YDKK+9a83eyDcLL8f8ovCOWT/rIe
	 klb7gj/nUUdTPwb+BDiZwLAtae7MmUWQ6/3/lAcEUKZVCW8A23CWCKBgHvFe+/Q3iDEIg
	 S3KO8EOvOMurYv1plY95Bf74QGVKW34DBZHTpHJY8YJ+/JYqh2uX1zDNrKkWH/Q8K1Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794180867;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MyTRYxtf2ap/5YrqD7l26Qfu1GI+QvBxEP61O+zJeVc=;
	b=RMAqG4PCdd4PB9d4jhkFAZVpUR7sKSJ8wsp0Srcr2alXsF44qRL/ZQFBFp9oDVKFuCF+
	 MMTIvmcWATu7PniAerkM+RlABPu1LVQuM7PqQsIojVmiBYUkeivyAPO5yv1L/nmRfqQOM
	 b7OdmSNFHIdExJRnDyjk311pRhdjzZBHz+WDB/3Mh09goRdN8H7Pqc8ghO10y8hDP/vDO
	 eTBkse21WzRBVJ+45HKNTYIkFI5kVsSa1vBI/11m0ndyhBHESrupm16yW6B3fcyTEzR/F
	 D6IaPH62DrTihvT0eeuc0d5guS/ItVFcVfsDY2lQ7uqKA8/JsvqrOrsmQEa/BPZPh6A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794180867;
	bh=MyTRYxtf2ap/5YrqD7l26Qfu1GI+QvBxEP61O+zJeVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DOGVDW5MKeLkaXt8oLI5CmR+tEqcm7y0LYKAKJLhh8lEGAdLV2bzudagCqrhvFxG7
	 AtTaPNPg5NUV78KKPKCZvGbx/eTEGM3Fv1RIT9h/tmKNEh0OeINsSq5PFlhdih+Plh
	 JOBZdJeAuDuLWYUb3BKrO9jczsHZlXr8a+tFVkYc5N5bobv0wV48Mz8JBcZLQDjOZE
	 Lf0jdfgUmENBbqlko1XLRNX1zlbSQIb/qKf4YeuqenR2IGyRspN32yHilbnKcFPD2J
	 oEhBTGQnd5681shBU+lVxUvOXORrNFqqtOUUYcA+YLJ2fQfa+CidnViG9WHi/XIUYe
	 HUW8ASwxr6/sQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0DEF80E25;
	Sun,  8 Nov 2026 23:34:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 46FF3317
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 23:34:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 25EEC60744
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 23:34:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lZi7-Z4P6y4C for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 23:34:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2829360737
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1232"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1232; helo=mail-dl1-x1232.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=WNFbreLc
Received: from mail-dl1-x1232.google.com (mail-dl1-x1232.google.com
 [IPv6:2607:f8b0:4864:20::1232])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2829360737
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 23:34:21 +0000 (UTC)
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-1ae18eb9b69so297517c88.0
 for <u-boot@lists.u-boot-project.org>; Sun, 08 Nov 2026 15:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794180861; x=1794785661;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MyTRYxtf2ap/5YrqD7l26Qfu1GI+QvBxEP61O+zJeVc=;
 b=WNFbreLcL0xaJFByRMRU93J1HCVOaUsJmJMdEd2Kr5hNoVcwzEZQrSONB8RePc7dhN
 rBo5wppQzuHsqFPL7vT3xo/6pmFlgpHlD4kKO6shn/Cf1cDy02Gm5Ks8GMGuC+gGUIMm
 OiXIWy0KO963npPv21bGfP9eF1Ah/EBcs7UNUj9y6prjTfvbH3zpAB3Kzg+mXRHTCVk7
 GtAG0FBqqDCkxKaz6XIs5mLYVprFVfd2tOvBMxb+FiwMn20HlLsZrhxS5gjN5i/0DfXD
 OcEi1VLTUK7L5zb7v6zBytvdwDvRA5Y5MqKEWXYG17QEJ0KZ/TYAriY1QxxMCmXIxjdJ
 9oXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794180861; x=1794785661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MyTRYxtf2ap/5YrqD7l26Qfu1GI+QvBxEP61O+zJeVc=;
 b=rrJprVh+y7EQz1uvHvFo9Wsmsr2LqfiqFiCJaH/BWbibR/chgK/0WIMtX+d/33+UWm
 b/kknkcs9zDjEd8tvSFgIIsM0lT189h+yallmvnDBvIwy6HPlgRXXKsexLBQBVC09+6Q
 o+EiKM+Td6wQQB0PxIngdDzws8/SlM/nXtoIqtBVdnQB78IyYF3FlGWNsoFLoYc8zs2j
 TX0ltxs8TsGnvcOMDCBOVMwtaGKi1S28wUiSObJQYz7S2xmA3sHtg/G3BdTZ/SUSA3zt
 v6TTTMqidoS2sEduhJfry2n0WO7778AbTSPgAuGriwEj+KWtfanP+RiHAMLGlAcS0kyu
 GvyA==
X-Gm-Message-State: APuU4Z+e1R9pFX/Q9ynAV1TXIwP03IFLOiSP7NSN6LLuKssfvo0nKVcv
 0lBXhcALvElACA4xgjPIMry/WeEzE3IGDhxbosGeLzKMa32wLQS01qcbJSHoQjuY
X-Gm-Gg: AYBFou0mzYw0pgkSXGi++4ARc3mvwjS/vpoKsUTNJC9AzylqBgxgO4KFfnmIzWVp9mS
 +P5uOiVJ2z0z0tuBKCGFqxPuX/VQjnmgCq/iD4B7JGTUivtYqBlPJgjv6xpmE8WJIbf/9a0pVpw
 j/v+ZVuo3AT3D63n9Tc4Vwca6MeFU4y+bcyJ8Y5DtE+1K/KEU8kjy0BaIvEmwpPgCHm4ScCAU1y
 GHaOV8v7HP3VGP/nKbVF1jYBa/LL8yoFlFP3idh+dirWV8kcU8HZPXh3vxow/fGqKNgm7S/cIvl
 sz94+eBc3M2cBoX6wzRxLcWUfg9NKB70ZvdrJR7wLDMcLuYXyUbAmqf9fC67Rl5fomqZS1Ex4jI
 k5tFzirALZXEuww7BM9iXUfeernxWwf8JnAdBth/ErFejuwly2sKRE5FLG0x/rqxCQ4jndBLWaN
 p7FnoamXh3jsSNqCmRyqEJTf5o95Pk1ZS5ZgFxfMkfkimIle93wmdzUMn1eL6+VlskQBFsNCGUo
 0PH0JIIhE179fpKUdmbfvae/KR6K7wHVGL9X3qDtjsm8STZ1ghzf8wI0THB6SWTHSp5UZj4gjZZ
 BBKy9Qubq8malTqkhhfl08wZf8ku+hj5HpDpuAw0nqo6xa8EoAsErq8PzY5lfW3PRrEy7J7kPQs
 18HNt6cnyLbJ7To9z4D7OSi39BdmFpcMRMNyQRykFk6njf7+cL3U5G8ksP6k4vnTaYCoulyFO7u
 jLjHyeNYEk
X-Received: by 2002:a05:701b:4302:b0:14b:cf58:ce15 with SMTP id
 a92af1059eb24-1b39ff0a63emr3823651c88.43.1794180860594; 
 Sun, 08 Nov 2026 15:34:20 -0800 (PST)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b3771eccb9sm7221006c88.19.2026.11.08.15.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 15:34:20 -0800 (PST)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, bin.meng@processmission.com, trini@konsulko.com,
 visitorckw@gmail.com, sjg@chromium.org, xypron.glpk@gmx.de
Subject: [PATCH v7 5/6] test: dm: Add tests for the virtio RTC driver
Date: Mon,  9 Nov 2026 07:34:05 +0800
Message-ID: <20261108233410.1556875-5-alan.tseng.cs@gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a virtio RTC device to the sandbox test device tree and emulate it
through the sandbox virtio transport. The emulated device answers the
VIRTIO_RTC_REQ_CFG, VIRTIO_RTC_REQ_CLOCK_CAP and VIRTIO_RTC_REQ_READ
requests from a configurable list of clocks.

The tests check that the driver:
- does not use the virtqueue in probe()
- reads the time from the first UTC clock and looks it up only once
- remembers that there is no UTC clock and does not ask again
- reports a failed request and looks for the clock again next time
- gives up with -ETIMEDOUT when the device does not answer

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 MAINTAINERS               |   1 +
 arch/sandbox/dts/test.dts |   5 +
 test/dm/Makefile          |   1 +
 test/dm/virtio_rtc.c      | 306 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 313 insertions(+)
 create mode 100644 test/dm/virtio_rtc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 106218f0a..08172cf7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1893,6 +1893,7 @@ VIRTIO RTC
 M:	Hung-Chun Tseng <alan.tseng.cs@gmail.com>
 S:	Maintained
 F:	drivers/virtio/virtio_rtc.c
+F:	test/dm/virtio_rtc.c
 
 WATCHDOG
 M:	Stefan Roese <stefan.roese@mailbox.org>
diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 02a9ca29b..405f6921e 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1996,6 +1996,11 @@
 		virtio-type = <2>;	/* block */
 	};
 
+	sandbox-virtio-rtc {
+		compatible = "sandbox,virtio1";
+		virtio-type = <17>;	/* clock */
+	};
+
 	sandbox_scmi {
 		compatible = "sandbox,scmi-devices";
 		power-domains = <&pwrdom_scmi 2>;
diff --git a/test/dm/Makefile b/test/dm/Makefile
index 1b3a20aa9..d4a112c32 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -155,6 +155,7 @@ ifeq ($(CONFIG_VIRTIO_SANDBOX),y)
 obj-y += virtio.o
 obj-$(CONFIG_VIRTIO_RNG) += virtio_device.o
 obj-$(CONFIG_VIRTIO_RNG) += virtio_rng.o
+obj-$(CONFIG_VIRTIO_RTC) += virtio_rtc.o
 endif
 ifeq ($(CONFIG_WDT_GPIO)$(CONFIG_WDT_SANDBOX),yy)
 obj-y += wdt.o
diff --git a/test/dm/virtio_rtc.c b/test/dm/virtio_rtc.c
new file mode 100644
index 000000000..23f7934dd
--- /dev/null
+++ b/test/dm/virtio_rtc.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026, Hung-Chun Tseng <alan.tseng.cs@gmail.com>
+ *
+ * Tests for the virtio RTC driver, with the device emulated through the
+ * sandbox virtio transport
+ */
+
+#include <dm.h>
+#include <rtc.h>
+#include <time.h>
+#include <virtio_types.h>
+#include <virtio.h>
+#include <virtio_ring.h>
+#include <asm/test.h>
+#include <dm/device-internal.h>
+#include <dm/test.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+/* Message types and clock types from the virtio specification */
+#define REQ_READ		0x0001
+#define REQ_CFG			0x1000
+#define REQ_CLOCK_CAP		0x1001
+
+#define S_OK			0
+#define S_EIO			4
+
+#define CLOCK_UTC		0
+#define CLOCK_TAI		1
+#define CLOCK_MONOTONIC		2
+#define CLOCK_UTC_SMEARED	3
+#define CLOCK_UTC_MAYBE_SMEARED	4
+
+/* Request: le16 msg_type, 6 reserved bytes, then le16 clock_id */
+struct emul_req {
+	__le16 msg_type;
+	u8 reserved[6];
+	__le16 clock_id;
+};
+
+/* Response: u8 status, 7 reserved bytes, then the message payload */
+struct emul_resp {
+	u8 status;
+	u8 reserved[7];
+	union {
+		__le16 num_clocks;
+		u8 type;
+		__le64 clock_reading;
+	};
+};
+
+/* 2023-11-14 22:13:20 UTC, plus some nanoseconds */
+#define EMUL_TIME_S		1700000000ULL
+#define EMUL_TIME_NS		(EMUL_TIME_S * 1000000000ULL + 123456789)
+
+#define EMUL_MAX_CLOCKS		4
+
+/**
+ * struct virtio_rtc_emul - State of the emulated device
+ *
+ * @num_clocks: number of clocks the device reports
+ * @types: type of each clock
+ * @cap_status: status to return for VIRTIO_RTC_REQ_CLOCK_CAP
+ * @no_reply: do not answer requests, but move time past the timeout
+ * @cfg_count: number of VIRTIO_RTC_REQ_CFG requests seen
+ * @cap_count: number of VIRTIO_RTC_REQ_CLOCK_CAP requests seen
+ * @read_count: number of VIRTIO_RTC_REQ_READ requests seen
+ * @read_clock: clock ID of the last VIRTIO_RTC_REQ_READ
+ * @last_avail: next available ring entry to process
+ */
+struct virtio_rtc_emul {
+	u16 num_clocks;
+	u8 types[EMUL_MAX_CLOCKS];
+	u8 cap_status;
+	bool no_reply;
+	int cfg_count;
+	int cap_count;
+	int read_count;
+	u16 read_clock;
+	u16 last_avail;
+};
+
+static struct virtio_rtc_emul emul;
+
+static u32 emul_handle(const struct emul_req *req, struct emul_resp *resp)
+{
+	u16 clock_id = le16_to_cpu(req->clock_id);
+
+	memset(resp, '\0', sizeof(*resp));
+	resp->status = S_OK;
+
+	switch (le16_to_cpu(req->msg_type)) {
+	case REQ_CFG:
+		emul.cfg_count++;
+		resp->num_clocks = cpu_to_le16(emul.num_clocks);
+		return 16;
+	case REQ_CLOCK_CAP:
+		emul.cap_count++;
+		resp->status = emul.cap_status;
+		if (clock_id >= emul.num_clocks)
+			resp->status = S_EIO;
+		else
+			resp->type = emul.types[clock_id];
+		return 16;
+	case REQ_READ:
+		emul.read_count++;
+		emul.read_clock = clock_id;
+		resp->clock_reading = cpu_to_le64(EMUL_TIME_NS);
+		return 16;
+	default:
+		resp->status = S_EIO;
+		return 8;
+	}
+}
+
+static int emul_notify(struct udevice *dev, struct virtqueue *vq)
+{
+	struct udevice *vdev = vq->vdev;
+	struct vring *vr = &vq->vring;
+
+	if (emul.no_reply) {
+		timer_test_add_offset(2000);
+		return 0;
+	}
+
+	while (emul.last_avail != virtio16_to_cpu(vdev, vr->avail->idx)) {
+		u16 head = virtio16_to_cpu(vdev, vr->avail->ring[emul.last_avail %
+								 vr->num]);
+		struct vring_desc *out = &vr->desc[head];
+		struct vring_desc *in = &vr->desc[virtio16_to_cpu(vdev,
+								   out->next)];
+		void *req = (void *)(uintptr_t)virtio64_to_cpu(vdev, out->addr);
+		void *resp = (void *)(uintptr_t)virtio64_to_cpu(vdev, in->addr);
+		u16 used = virtio16_to_cpu(vdev, vr->used->idx);
+		u32 len;
+
+		len = emul_handle(req, resp);
+		vr->used->ring[used % vr->num].id = cpu_to_virtio32(vdev, head);
+		vr->used->ring[used % vr->num].len = cpu_to_virtio32(vdev, len);
+		vr->used->idx = cpu_to_virtio16(vdev, used + 1);
+		emul.last_avail++;
+	}
+
+	return 0;
+}
+
+/* Set up the emulated device and return the virtio RTC device */
+static int setup(struct unit_test_state *uts, u16 num_clocks, const u8 *types,
+		 struct udevice **devp)
+{
+	struct udevice *bus;
+
+	memset(&emul, '\0', sizeof(emul));
+	emul.num_clocks = num_clocks;
+	memcpy(emul.types, types, num_clocks);
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_VIRTIO,
+					      "sandbox-virtio-rtc", &bus));
+	sandbox_virtio_set_notify(bus, emul_notify);
+	ut_assertok(device_find_first_child(bus, devp));
+	ut_asserteq_str(VIRTIO_RTC_DRV_NAME, (*devp)->driver->name);
+	ut_assertok(device_probe(*devp));
+
+	return 0;
+}
+
+/* Test reading the time from the only UTC clock */
+static int dm_test_virtio_rtc_get(struct unit_test_state *uts)
+{
+	static const u8 types[] = { CLOCK_MONOTONIC, CLOCK_UTC, CLOCK_TAI };
+	struct udevice *dev;
+	struct rtc_time tm;
+
+	ut_assertok(setup(uts, ARRAY_SIZE(types), types, &dev));
+
+	/* probe() must not use the virtqueue */
+	ut_asserteq(0, emul.cfg_count);
+
+	ut_assertok(dm_rtc_get(dev, &tm));
+	ut_asserteq(1, emul.cfg_count);
+	ut_asserteq(3, emul.cap_count);
+	ut_asserteq(1, emul.read_count);
+	ut_asserteq(1, emul.read_clock);
+
+	ut_asserteq(2023, tm.tm_year);
+	ut_asserteq(11, tm.tm_mon);
+	ut_asserteq(14, tm.tm_mday);
+	ut_asserteq(22, tm.tm_hour);
+	ut_asserteq(13, tm.tm_min);
+	ut_asserteq(20, tm.tm_sec);
+	ut_asserteq(2, tm.tm_wday);
+
+	/* The clock is looked up only once */
+	ut_assertok(dm_rtc_get(dev, &tm));
+	ut_asserteq(1, emul.cfg_count);
+	ut_asserteq(3, emul.cap_count);
+	ut_asserteq(2, emul.read_count);
+
+	/* The clocks are read-only */
+	ut_asserteq(-ENOSYS, dm_rtc_set(dev, &tm));
+
+	return 0;
+}
+DM_TEST(dm_test_virtio_rtc_get, UTF_SCAN_FDT);
+
+/* Test that a clock which smears leap seconds is preferred */
+static int dm_test_virtio_rtc_smeared(struct unit_test_state *uts)
+{
+	static const u8 types[] = { CLOCK_UTC, CLOCK_UTC_MAYBE_SMEARED,
+				    CLOCK_UTC_SMEARED, CLOCK_TAI };
+	struct udevice *dev;
+	struct rtc_time tm;
+
+	ut_assertok(setup(uts, ARRAY_SIZE(types), types, &dev));
+
+	/* The search stops at the smeared clock */
+	ut_assertok(dm_rtc_get(dev, &tm));
+	ut_asserteq(3, emul.cap_count);
+	ut_asserteq(2, emul.read_clock);
+
+	return 0;
+}
+DM_TEST(dm_test_virtio_rtc_smeared, UTF_SCAN_FDT);
+
+/* Test that the first UTC clock is used if none smears leap seconds */
+static int dm_test_virtio_rtc_fallback(struct unit_test_state *uts)
+{
+	static const u8 types[] = { CLOCK_TAI, CLOCK_UTC_MAYBE_SMEARED,
+				    CLOCK_UTC };
+	struct udevice *dev;
+	struct rtc_time tm;
+
+	ut_assertok(setup(uts, ARRAY_SIZE(types), types, &dev));
+
+	ut_assertok(dm_rtc_get(dev, &tm));
+	ut_asserteq(3, emul.cap_count);
+	ut_asserteq(1, emul.read_clock);
+
+	return 0;
+}
+DM_TEST(dm_test_virtio_rtc_fallback, UTF_SCAN_FDT);
+
+/* Test that a device without a UTC clock is only queried once */
+static int dm_test_virtio_rtc_no_utc(struct unit_test_state *uts)
+{
+	static const u8 types[] = { CLOCK_TAI, CLOCK_MONOTONIC };
+	struct udevice *dev;
+	struct rtc_time tm;
+
+	ut_assertok(setup(uts, ARRAY_SIZE(types), types, &dev));
+
+	ut_asserteq(-ENODEV, dm_rtc_get(dev, &tm));
+	ut_asserteq(1, emul.cfg_count);
+	ut_asserteq(2, emul.cap_count);
+
+	ut_asserteq(-ENODEV, dm_rtc_get(dev, &tm));
+	ut_asserteq(1, emul.cfg_count);
+	ut_asserteq(2, emul.cap_count);
+	ut_asserteq(0, emul.read_count);
+
+	return 0;
+}
+DM_TEST(dm_test_virtio_rtc_no_utc, UTF_SCAN_FDT);
+
+/* Test that a failed request stops the search and is not remembered */
+static int dm_test_virtio_rtc_error(struct unit_test_state *uts)
+{
+	static const u8 types[] = { CLOCK_TAI, CLOCK_UTC };
+	struct udevice *dev;
+	struct rtc_time tm;
+
+	ut_assertok(setup(uts, ARRAY_SIZE(types), types, &dev));
+
+	emul.cap_status = S_EIO;
+	ut_asserteq(-EIO, dm_rtc_get(dev, &tm));
+	ut_asserteq(1, emul.cap_count);
+
+	/* The next read looks for the clock again */
+	emul.cap_status = S_OK;
+	ut_assertok(dm_rtc_get(dev, &tm));
+	ut_asserteq(2, emul.cfg_count);
+	ut_asserteq(3, emul.cap_count);
+	ut_asserteq(1, emul.read_count);
+	ut_asserteq(1, emul.read_clock);
+
+	return 0;
+}
+DM_TEST(dm_test_virtio_rtc_error, UTF_SCAN_FDT);
+
+/* Test that the driver gives up if the device does not answer */
+static int dm_test_virtio_rtc_timeout(struct unit_test_state *uts)
+{
+	static const u8 types[] = { CLOCK_UTC };
+	struct udevice *dev;
+	struct rtc_time tm;
+
+	ut_assertok(setup(uts, ARRAY_SIZE(types), types, &dev));
+
+	emul.no_reply = true;
+	ut_asserteq(-ETIMEDOUT, dm_rtc_get(dev, &tm));
+	ut_asserteq(0, emul.cfg_count);
+
+	return 0;
+}
+DM_TEST(dm_test_virtio_rtc_timeout, UTF_SCAN_FDT);
-- 
2.43.0

