Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C06CC6B2A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 14:07:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 733E780E11;
	Wed, 14 Oct 2026 14:07:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e3C72wJmLs9K; Wed, 14 Oct 2026 14:07:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 179E080E12
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791986848;
	b=DbFgl+1zg5UNtmoJsFt5YI0QjWAvkdzVOZXxVep11lYG9pmOEAo614a8NLtBbOISRFux
	 UKN+Au+Pv3EW+zZMJEwz9cXbsPstEncQHR0Oil0RMh/MU2Cu8f4SYmR3LaVLVtgRbBH1s
	 llIe/DXBleiJ/zJ3DatSHM4be9xGQdK0t+CMeuFzskAHbFiLsHlKj9Zpfw8TZwS0T0zBW
	 3nEZZX/AEqrhw8m4wYJTvJ7lU5FO88RF7eBoy8C++h84MfyRbenyrJ/i+5STZ0OC9pA4R
	 2mSlnXiAnwzW90bhitGGu3VqguFdt4/72a2JI7owAnZ48XnatAMnnzeTlvfZU8L+Fqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791986848;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cc78q/7jbRPLwRMkffDCyB3sjvSpMgFo53TyQmckLkM=;
	b=M5g5zUtS792DcK6hG6TjtFcdkZ5WhPflLEXdUoG10SvUXz734YriNz8YNjHLxBlzekYc
	 cvMNCDosGS2TZLESEqWLIQL7Ze2Z7fuDcxo1TbPP3XwlK8he1AJqSOvmXHRnFvq9V3pbs
	 6uJXfq7oyXgob7I9aeLiOexj5qpNvKOptX1sKJLF7fKcPlh8dgmDPPaUSCYZWZMdMlENf
	 iFCEXsqbwfCXFuUpw8cZvVzVLEwVv//xC+R0XCqKcKSdNZJUw4P1QIxGN98S5wzLjox41
	 DDYU/qYGvDQec4F0K4FKO3k49E/r/iE8aScg7l+edjEOw1hxFvdjhoaIhMgdqjlNjag==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791986848;
	bh=cc78q/7jbRPLwRMkffDCyB3sjvSpMgFo53TyQmckLkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vyhg7pQ9vzvREdGu4ka+CYGQl8Uw1CCWWFsN+kYNQikSWBVrGveQEXVtnSFnhpECu
	 wW9FmwzsOd0fNFO9b4ZIbj020RGy58SMRrRPb8SC8PofIlMzSxUaNUZ5uhYTtKMOjC
	 GTqyyZ385MKEOSCuG2uj3KQbpy4PVYS7Kd81TNAqzOfoaZelSpnDT3sutuNrMZs66Z
	 kY4T/KvWmkKoa9OYGepjv0d9xxE0UPnuW0ITF3vN4KYNi3M8n71cCZ81SrCudDI9Fi
	 BkbyQOns6gyNA1SzQSZ8QxVLIYqktxEZv5mj7l5p9fvkIUrpNaHSnMmh44dz0DzbBJ
	 zwaGpYAGHC/zA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 179E080E12;
	Wed, 14 Oct 2026 14:07:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4108D2E0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:07:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 328D0400F9
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:07:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VKZLq_R9Z4vT for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 14:07:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5D2CC400B4
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791986845;
 b=IYsTBnvIzxt7LRvsCY4VSc6BAiv7yn2TU3Tf+XCdlZ8Dit6nLceNrbuCytQlxX30279V
 G6dXgtsj2pDKsaeGTe3QBaJzNqsWgmDhzG0OyRuooeknXFqrwIn15WJrzg/5j5/VwqUyY
 /Sc7uRYMp/HyIo1S/Qg4DjdJQX/v71wtwR+9VkWIFEpmsR74T9iefFfpHhjWb5bHTa9Oh
 3SKqUbw0dpDDHleBV3eg0qTVwSJL+eVYqu5BRvmPS1hoflmh6JDjBusIf754PTgM6k4jT
 +eu3jJpmdgBh4aPzx3oPML0gu/FWe30WLgEtMk5WzYfVa00s61vpea64Pn4U/NPZnlg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791986845;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=cc78q/7jbRPLwRMkffDCyB3sjvSpMgFo53TyQmckLkM=;
 b=ePDVqFW3Rd3HPPv4tnn0ZM5vco0ap11QwOPEEIozkG3Z1S7U9DKbn7HTPMbdJ547Itk2
 OJRIqIQ+FfUNg+xZlpT4lmFaCGm5kQyjTQFn+geONqqeXeydVI9x3FEIK+rHV2Tn+KY0w
 YXFexZQlXGpJbc2Cuc5SNkPocWGyQHmxgHbgGR1HV7aaZV+C/fsxqDo7+qjqrSuBBnn4O
 x1wfQI5HXmXtNHC4QWpTZdEep0V14/WPdzP6B3D604K6cP5uUxznHm3Rpc5zhAoZ0tyrx
 /LCmAKZTeCyhiKoiMRQLXPHHOYxVOMmSQUTZVgzI3DWt5aMLJFrvYGT7MRDEnjhvPzQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=eRutV6mj; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=eRutV6mj
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5D2CC400B4
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 14:07:23 +0000 (UTC)
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2e942864693so2496555ad.1
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 07:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791986843; x=1792591643;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cc78q/7jbRPLwRMkffDCyB3sjvSpMgFo53TyQmckLkM=;
 b=eRutV6mjNMsneoEGotmTlaQdwwhQeNCic8AEemk3f7HrKD7W83czGT6l38sP2p6zva
 11gN1/Jq8M3Bc+jeV5yM2t/cTCCn3jexlp4oj1gdSMRaMoZTflxbKAodZe1FU6y0j5d/
 C7iNR8Pz3Me+0FsOJ1tFXGcAEFl063AvxuLihE+14xmgk9f59igVCZ74m3FKv0iPpIq8
 Rt6HqPV0Q0plE0r/jiC4PZIHaI+BmGuLUtip1waW8HqEr2H2JRum6DANSJ9zM5RrsqID
 qkyJ9pccj2TZ8cjt+6yxP1t4BaUYGn3ehYg2QKkl1C4CDnicAk7xwU9FqkHC9hpKOnab
 SsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791986843; x=1792591643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cc78q/7jbRPLwRMkffDCyB3sjvSpMgFo53TyQmckLkM=;
 b=F/ZuZ/whS8AG3BYpk+MwS0ZJYsT6DLGZ4inn4gC5KoNUCc32OGJe7UCtKudOalz8Oh
 ZnEfYyHRlYHNGeR7j1xC5+kFyvNVM5Coh3hkTHO5+ctG/HT0OHAUlPJCH7FC+4S4x7id
 SK4dPrTdZa25DTGLsAW9e9cuaEIJ3KS/oAhNkpIx3Z5yWdTqJhbTNZjbyoZa1PwVkhJG
 X50V0xZFlRKeU3/AXJeqXshgV3D3884CTvEE2XYQaDA0BkGqlQIEqT2eJgUidAsD5y57
 vs7Kny/tgk2jgR7jzjyJZxCkFTzc+XkIRkf/hP7YRnapummKAfRc3Sxofhw9o4VWmLre
 UNVA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/vYiu3K3oprwN+3uIKeCIMEIE5pZARoF0fH91AfkPcMGIHMpU+08JSLF7CaBDX5QoXrDQn+E=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKxWJA9rrKjpl81kiQnOosSvu0Ap4rO8pZ5czDouhkBX34t8jIc
 d1tNgLurL98ncQDViaeNa57/TXcBqdjlOCuFGh87p1Qmc/vXswn/K0YX
X-Gm-Gg: AYBFou0ykg748YgnYzw4ALWQku7lAPP8L8/f1WKBw8HNPrM1hIvN+zDWtCTW/ewjK07
 V+VPB8D4xR2V96+5dG+KoQP28E4TR9zs3SV3VIZCnS0FJ1g1HtV/6p/99rk24sqR8NkJ1Mgahlk
 +XrUIldldTFYBEh23aDm3Lfa+rAYsM4dL/AH984B2IGpwvk/2Ms0UUilR2oreV+g7hZoabUmkN5
 YjIJyZsJaG4FoUWiuaUvn2u73qhjztpjdCWkqgdeJDXgcCeVAZlrV7zGg0wYTp3BVoNapg1M1i+
 Puua84TBpMRvF3y12Cnj54mgcQoJ5TwSEh5iKon5JndaezgJV77gOql6+dx8Fnuxpw8rhyNXmY4
 9y9JqACUHGr9qKSyz0kpgHp0uIIbbt/h57NVYB893n30N2JZ0AM3XMmyRB29Fv8yrZ+cQbVU9We
 ELzzCY/4Wfy6IkcsIgVqbPguq2w+JfKc6YPFQUrBb13AfeKovlYbBhX7vqwoBeFHLyn50bew2i2
 4yoQfP/lVMdTapGn2zyqdnV2LN5/KhXvG8MLQutJTAPn6DCDFTi6mpkKAhFdFZ51H3UiC0y+/fv
 twhOXAo/HcvnHMLD4UsYaw73hrnlg5X4bSpPtot26UrHT8aFK0IS17byr94lcf7zVg==
X-Received: by 2002:a17:902:ef45:b0:2e5:d33a:88ef with SMTP id
 d9443c01a7336-2e842cd4191mr136825805ad.12.1791986843069; 
 Wed, 14 Oct 2026 07:07:23 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422b8202sm66885495ad.51.2026.10.14.07.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 07:07:22 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: [PATCH 1/3] virtio: rtc: Add virtio RTC driver
Date: Wed, 14 Oct 2026 22:07:14 +0800
Message-ID: <20261014140716.1181882-2-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014140716.1181882-1-alan.tseng.cs@gmail.com>
References: <20261014140716.1181882-1-alan.tseng.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add a driver for the virtio RTC device (virtio device ID 17), which
QEMU provides as virtio-rtc-pci and virtio-rtc-device since v11.1.0.

The device exposes its clocks through a request virtqueue. At probe
time the driver asks for the number of clocks with VIRTIO_RTC_REQ_CFG
and picks the first one whose VIRTIO_RTC_REQ_CLOCK_CAP type is UTC,
smeared UTC or maybe-smeared UTC. Reading the time sends a
VIRTIO_RTC_REQ_READ for that clock and converts the nanoseconds since
the epoch with rtc_to_tm(). The clocks are read-only, so there is no
set operation, and the optional alarm feature is not negotiated.

VIRTIO_RTC defaults to y when VIRTIO and DM_RTC are enabled, like
VIRTIO_RNG does for DM_RNG.

Signed-off-by: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
---
 drivers/virtio/Kconfig         |   9 ++
 drivers/virtio/Makefile        |   1 +
 drivers/virtio/virtio-uclass.c |   1 +
 drivers/virtio/virtio_rtc.c    | 206 +++++++++++++++++++++++++++++++++
 include/virtio.h               |   4 +-
 5 files changed, 220 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virtio/virtio_rtc.c

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 55b444280..c19138ef2 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -84,4 +84,13 @@ config VIRTIO_9P
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
+	  This is the virtual RTC driver. It reads the UTC clock of a
+	  virtio RTC device. It can be used with QEMU based targets.
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
index c163b2fd7..c6cf55922 100644
--- a/drivers/virtio/virtio-uclass.c
+++ b/drivers/virtio/virtio-uclass.c
@@ -31,6 +31,7 @@ static const char *const virtio_drv_name[VIRTIO_ID_MAX_NUM] = {
 	[VIRTIO_ID_BLOCK]	= VIRTIO_BLK_DRV_NAME,
 	[VIRTIO_ID_RNG]		= VIRTIO_RNG_DRV_NAME,
 	[VIRTIO_ID_9P]		= VIRTIO_9P_DRV_NAME,
+	[VIRTIO_ID_CLOCK]	= VIRTIO_RTC_DRV_NAME,
 };
 
 int virtio_get_config(struct udevice *vdev, unsigned int offset,
diff --git a/drivers/virtio/virtio_rtc.c b/drivers/virtio/virtio_rtc.c
new file mode 100644
index 000000000..7d0dc9c7f
--- /dev/null
+++ b/drivers/virtio/virtio_rtc.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026, Hung-Chun Tseng <alan.tseng.cs@gmail.com>
+ *
+ * Driver for the virtio RTC device (virtio device ID 17). The device
+ * exposes one or more read-only clocks through a request virtqueue; this
+ * driver reads the first UTC clock and reports it through the RTC uclass.
+ */
+
+#include <div64.h>
+#include <dm.h>
+#include <log.h>
+#include <rtc.h>
+#include <virtio_types.h>
+#include <virtio.h>
+#include <virtio_ring.h>
+#include <linux/types.h>
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
+} __packed;
+
+struct virtio_rtc_resp_head {
+	u8 status;
+	u8 reserved[7];
+} __packed;
+
+/* Request for VIRTIO_RTC_REQ_READ and VIRTIO_RTC_REQ_CLOCK_CAP */
+struct virtio_rtc_req_clock {
+	struct virtio_rtc_req_head head;
+	__le16 clock_id;
+	u8 reserved[6];
+} __packed;
+
+struct virtio_rtc_resp_read {
+	struct virtio_rtc_resp_head head;
+	__le64 clock_reading;
+} __packed;
+
+struct virtio_rtc_resp_cfg {
+	struct virtio_rtc_resp_head head;
+	__le16 num_clocks;
+	u8 reserved[6];
+} __packed;
+
+struct virtio_rtc_resp_clock_cap {
+	struct virtio_rtc_resp_head head;
+	u8 type;
+	u8 leap_second_smearing;
+	u8 flags;
+	u8 reserved[5];
+} __packed;
+
+struct virtio_rtc_priv {
+	struct virtqueue *vq;
+	u16 clock_id;
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
+	int ret;
+
+	ret = virtqueue_add(priv->vq, sgs, 1, 1);
+	if (ret)
+		return ret;
+
+	virtqueue_kick(priv->vq);
+
+	while (!virtqueue_get_buf(priv->vq, &len))
+		;
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
+static int virtio_rtc_get(struct udevice *dev, struct rtc_time *time)
+{
+	struct virtio_rtc_priv *priv = dev_get_priv(dev);
+	struct virtio_rtc_req_clock req = {
+		.head.msg_type = cpu_to_le16(VIRTIO_RTC_REQ_READ),
+		.clock_id = cpu_to_le16(priv->clock_id),
+	};
+	struct virtio_rtc_resp_read resp = {};
+	u64 now;
+	int ret;
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
+	u16 num_clocks, id;
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
+			continue;
+
+		if (virtio_rtc_is_utc(cap.type)) {
+			priv->clock_id = id;
+			return 0;
+		}
+	}
+
+	return -ENODEV;
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
+	ret = virtio_rtc_find_utc_clock(dev);
+	if (ret) {
+		debug("%s: no UTC clock found\n", __func__);
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
index b981eead5..95069a2de 100644
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

