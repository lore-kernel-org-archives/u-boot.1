Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFEBC9830B
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 21:30:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E9F241308;
	Wed, 23 Sep 2026 21:30:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W5GgwrbAa65D; Wed, 23 Sep 2026 21:30:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E111241341
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790199055;
	b=SvryWQa4OtkMPuynl5pZR7JTWaQt1RsQDH4c/CZwa4c7ZVvT9oSiDpvU4A8g2hNhqSpG
	 PkgOQLXCPIl33nbPj6B2W48UoTPNojXLHKi96Ta8+H1fuiYhl29xnDnn+VMx0wNpz06MB
	 JXqxn2kvUuf0hzgcgztWopCdFKBZWf1/aNAzs2ZFzmNspx6GbOl0NUE+ojDMa2pXGvX8m
	 TJottC8BIqoKkTw9eRTVgJnDP/8pj5iNKO7gDjIFHMPBmQFGch+8ToKH2p+duoWDBMSMy
	 y/cH84PCGkXjupT2+Q3tEZlmMndowMpm0ztQ2LoO30YHE2W2e00x3AUcymry1tUpr9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790199055;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+UOBYZD1/5TRyxFdYxEF6/FHXpy3xMo7ZoFSjetPXqo=;
	b=HSKzV7GQie75W1u/XA8GJup2FguWkXeC7M1KqD4+872Zk2asLapHc0nQIpvddCKh3Gjh
	 jigX4JwkrxDBDPlmDPqscMAcjrFLBYWZdl6X8pI1H1UN7WeBK/CAs8UdbLayHsO7ZgakV
	 j0FCUWmPbSJQAyjzuJPVFj16uRPWBttFEKRVhjYiBmuZUzmjPN/M1nCxHwyH61wuSIOWb
	 6DR+R2IcYvYrmGUJltSZHObbJSBtIt4cR4lUlKRhmyIiNA5c5hoFhjlDmmeUZYawnK3/Q
	 VD7V0Qc7BR3JJQNIe4+yTwcgVYPJlz55FI3wBdj9wasCnTp/K717KES34YCwWC4yRzw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790199055;
	bh=+UOBYZD1/5TRyxFdYxEF6/FHXpy3xMo7ZoFSjetPXqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vnWk+O1kM1vDDwmFZkOMvHzA4r8Bf50rKe0+7BMsvFCMAqsEWeXLyTza8JCgQnRIz
	 gskt0C5fNGX9TTTwheLcQ1TyvGHZK8FuooZQdYG/41RgCcX0c7qu253raMqo9TEZCn
	 NDZoA8pHpZjUXQfv6YCsOkRGYtA1WSrs429WtqbWMGwTKFOlTM2F2fmtcC9hzFgZzB
	 +oPD652HDhMzIkYOEIYh38XUoC/rSBxDnz39eqbjxJSfZMVy4Xk2SeoTGWNjh0i8nb
	 yrD+JfqcccRB5Rv9bCfvHoW3b9KwuQonJ1U0KY8gppy0yC4DxZWsOXBvdHjV2/eT88
	 s0KwlcWXMeEEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E111241341;
	Wed, 23 Sep 2026 21:30:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 18B6F3B7
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:30:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 096F481176
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:30:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JOpcTuvC4_Gj for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 21:30:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3BD588113C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790199053;
 b=cwN/FqbPhmF3LDurTvnjiImZCrU2U/sVj3UStbGcwiI/5oaWG6Qfp5/FRfLMvAJohrZE
 3cX9drwBrv1DKDuoRWT+aD5W1tUNEamftYMumLXKc7z1vZUVBID7TudNMQjJ79MuHpmZu
 7C2AaFu/F+Qj5F1ldnW0b6BXnQkfGWTKtGEL1VokmRECcVJeX1Cn3XyXmaqcXkRGWVw+M
 3+3JjUIYqBXGAzL5ZWSNJCCWQhYjzh8Q28bBR7yh7CX7kijMfg7eiwuj2QZh3ztkFxUAs
 dHBlIITQ/P+vfsc0/HDAemlxWAg02vXU1s+6zw5VUzcpRbVRtSzurCg00h/syoeuulw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790199053;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=+UOBYZD1/5TRyxFdYxEF6/FHXpy3xMo7ZoFSjetPXqo=;
 b=HWFkLWlPOHsC7qxUs1+JGXzpP+e2rlizN0c+WmXLJRToKQfaxHfGbiLRJr+R2aNcJ9wm
 KWuPZ4C24/f3kqr+1jJyt2LLpZm4IsJQ5AIpECW+N5RbopPVphzmnck82ZpJmHvmbejJ4
 qf2Vxr/fJehVGz6Upj4sVj07qfcntk0OedzTpYk3BGjNDWVmU07eVfXHamRiEbE8pSxUu
 i8CoF+AkQC6CeF18FTp8dRYq2BhCFywtKHB8Lyz0LMDIA94/I6NxTkpbhMdA0J8y15pG0
 rtUjBaAS+hAHIhfWenRcgJn5UZWtHDhc5N7/NA4g5tlFxlA0v3jTv8AT0ar35qTP2NA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=r9KlPeo0; 
 arc=none smtp.remote-ip="2607:f8b0:4864:3b::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:3b::10; helo=mail-pz2-x10.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=r9KlPeo0
Received: from mail-pz2-x10.google.com (mail-pz2-x10.google.com
 [IPv6:2607:f8b0:4864:3b::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3BD588113C
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 21:30:52 +0000 (UTC)
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea34ef4so1129180a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 14:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790199052; x=1790803852;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+UOBYZD1/5TRyxFdYxEF6/FHXpy3xMo7ZoFSjetPXqo=;
 b=r9KlPeo0CPA5WFimme5/tmCjh6bPLO2Y0MKKg0l+xY+FusfJjucG7WUM7LSZ1S1pBN
 2PpCD/mNcdPyLBskO7SzE4v5CLZ2jmAgoAKMeE/0k0cXl7VIPEBi7PzOKhsO69Ahpaig
 eq2x2+cx0LRrvBVVTML4Inmg5W08/WMVhXtrqmUirerQtGSv4/qk65p+5MsVQS9UegbZ
 0HGrAo20rBNIDcQQcVU0bq7iInG7yuVdL3hYYfeS/ZByUk7tNnm7ROyFgStAABuldrRM
 s7SU51XCjAiMskPNPnivTYWBPU/JUBRpNMOQ/oJZ7aBR/jovWb6akJ5FxDXKHCPmyxwv
 0nVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790199052; x=1790803852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+UOBYZD1/5TRyxFdYxEF6/FHXpy3xMo7ZoFSjetPXqo=;
 b=zAc2lEHQg0jlwcSJJzrooj3i7vEuByQnQT1muKexJmgWyzCq1bZ4f+Mwo3TQkTbrMl
 TQgPB95S21qcwHtrsTnxpeDFuiNilGG+GMErKTzOlg7g70qHiUEwEqD2zQWdAMNbm7z2
 AihTKbKCUQizVpiDRRCO1zB6VAbYCgHFZrj77t7N+i9Y9zMM7bAsXBD7Ao/ceYJF4R3k
 vc1I2cZZWB25LHlPaC8RhhHdaZ+Z1SpBRjaxh3feiObAIXEF1kxV1HdsSsX47ZPXhU0T
 yjxL9phJVni6vZsRJOV+CNQ62bnRgiYlFqTHEMCiLAWGpZdSQuV0b44DTAAZZ+Dx9vw0
 6Rqw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwr7ZdmuFITmgqaPaeRmBpTZL4OWF9zuF2CfMkWYeYxEoiPtvTl2RNUjgF+cFrduDY9xBMXVD0=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nYAIOx7xSxO18kCXn+EZwjNg6Qus7YzWzshJQzIYIsnsPccLGJ
 5dCAEgdIaubLS5jecHZGj7OJ3fWomNwH640ttzj9dH8pfRBqjqegrmpR
X-Gm-Gg: AYBFou0/Rjlu42rptgcFgNBsKX7248he6FfA2f2Z9UZ2NNV+HzqFZbulgupEL8xgaRA
 Pxp6oZIuT4v2KhwsTzT9MaJcgItkfmUWKFZMUUY3kfmov40K9Mt9tLXpzdUbXKdAbkMtqlK4/Mg
 YYSkixAIY/xloaM4ABRPOYuvo10NLTM2l/VhENx5bMLmW9zqWxix/qybgW2r9T1PJtgFYgrhbZX
 UNXShDLQ4iTh3wjOpXSEEShXWBcjCsqa0+MZ59L9dg2NzVRbtKhrCtebT7kPydONSB/Pmz4+vRP
 uAWODeAEEUsAMzH66Ye38Fxkf1M03RpY5C5B16qxKTxZ60uuYklEPEWKCpzsglHB5bPlk94IzyQ
 +DVHzCzWCSeUui5zoYXWWkETPMMn13wRXsBXpZT+515ItWwhF3Tm8zHBP/Vn6cwH96QK31Jt86Y
 OyvBFS2/qgLH3086uUGhaL99OXqP8X8dIkdjpNOyzNjZNviLj8rjNtdKBTHhLDp05Ngg4U8XCrY
 nKu+iPG3WA18H97IoaNljD4Crq7OYUZ2Fgf9jJbSGX9tE/iwAvVutJHRR2R2bKT49xkTQ34CIqS
X-Received: by 2002:a17:90b:164c:b0:39e:6d82:dca with SMTP id
 98e67ed59e1d1-3a098df465emr300985a91.30.1790199052168; 
 Wed, 23 Sep 2026 14:30:52 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (202.176.229.35.bc.googleusercontent.com. [35.229.176.202])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0973c4fb4sm909513a91.17.2026.09.23.14.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 14:30:51 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com, tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com,
 sjg@chromium.org, jerome.forissier@arm.com
Cc: jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 u-boot@lists.u-boot-project.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v3 3/6] virtio: 9p: Add 9P transport driver
Date: Wed, 23 Sep 2026 21:29:59 +0000
Message-ID: <20260923213002.1070404-4-visitorckw@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260923213002.1070404-1-visitorckw@gmail.com>
References: <20260923213002.1070404-1-visitorckw@gmail.com>
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

Add virtio transport driver for the 9P filesystem.

This driver binds to the virtio-9p device exposed by the hypervisor and
registers as a DM UCLASS_9P device. It implements the transmit and
receive routines.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v3:
- Return received length from virtio_9p_request().
- Call virtio_del_vqs() before virtio_reset() in virtio_9p_remove().
---
 drivers/virtio/Kconfig         |   7 ++
 drivers/virtio/Makefile        |   1 +
 drivers/virtio/virtio-uclass.c |   1 +
 drivers/virtio/virtio_9p.c     | 120 +++++++++++++++++++++++++++++++++
 include/virtio.h               |  12 +++-
 5 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virtio/virtio_9p.c

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 512ac376f18..55b44428026 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -77,4 +77,11 @@ config VIRTIO_RNG
 	help
 	  This is the virtual random number generator driver. It can be used
 	  with QEMU based targets.
+
+config VIRTIO_9P
+	bool "virtio 9P transport driver"
+	depends on VIRTIO && NET_9P
+	help
+	  This enables the 9P transport driver over virtio.
+	  It can be used with QEMU based targets.
 endmenu
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index 4c63a6c6904..6e7bcfc8eaa 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_VIRTIO_SANDBOX) += virtio_sandbox.o
 obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
 obj-$(CONFIG_VIRTIO_BLK) += virtio_blk.o
 obj-$(CONFIG_VIRTIO_RNG) += virtio_rng.o
+obj-$(CONFIG_VIRTIO_9P) += virtio_9p.o
diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclass.c
index a871a1439d4..c163b2fd7d5 100644
--- a/drivers/virtio/virtio-uclass.c
+++ b/drivers/virtio/virtio-uclass.c
@@ -30,6 +30,7 @@ static const char *const virtio_drv_name[VIRTIO_ID_MAX_NUM] = {
 	[VIRTIO_ID_NET]		= VIRTIO_NET_DRV_NAME,
 	[VIRTIO_ID_BLOCK]	= VIRTIO_BLK_DRV_NAME,
 	[VIRTIO_ID_RNG]		= VIRTIO_RNG_DRV_NAME,
+	[VIRTIO_ID_9P]		= VIRTIO_9P_DRV_NAME,
 };
 
 int virtio_get_config(struct udevice *vdev, unsigned int offset,
diff --git a/drivers/virtio/virtio_9p.c b/drivers/virtio/virtio_9p.c
new file mode 100644
index 00000000000..fb2eb0c7223
--- /dev/null
+++ b/drivers/virtio/virtio_9p.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026, Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#define LOG_CATEGORY UCLASS_VIRTIO
+
+#include <9p.h>
+#include <dm.h>
+#include <time.h>
+#include <virtio.h>
+#include <virtio_ring.h>
+#include <virtio_types.h>
+#include <linux/errno.h>
+
+#define VIRTIO_9P_TIMEOUT_MS 5000
+
+struct virtio_9p_priv {
+	struct virtqueue *vq;
+	char mount_tag[32];
+};
+
+static const u32 feature[] = {
+	VIRTIO_9P_MOUNT_TAG,
+};
+
+static int virtio_9p_request(struct udevice *dev, void *tx, int tx_len, void *rx, int rx_len)
+{
+	struct virtio_9p_priv *priv = dev_get_priv(dev);
+	struct virtio_sg sg[2];
+	struct virtio_sg *sgs[2];
+	int len, ret;
+	ulong start;
+
+	sg[0].addr = tx;
+	sg[0].length = tx_len;
+	sgs[0] = &sg[0];
+
+	sg[1].addr = rx;
+	sg[1].length = rx_len;
+	sgs[1] = &sg[1];
+
+	ret = virtqueue_add(priv->vq, sgs, 1, 1);
+	if (ret)
+		return ret;
+
+	virtqueue_kick(priv->vq);
+
+	start = get_timer(0);
+	while (!virtqueue_get_buf(priv->vq, &len)) {
+		if (get_timer(start) > VIRTIO_9P_TIMEOUT_MS)
+			return -ETIMEDOUT;
+	}
+
+	if (len < (int)sizeof(struct p9_header))
+		return -EIO;
+
+	return len;
+}
+
+static const char *virtio_9p_get_mount_tag(struct udevice *dev)
+{
+	struct virtio_9p_priv *priv = dev_get_priv(dev);
+
+	return priv->mount_tag;
+}
+
+static const struct dm_p9_ops virtio_9p_ops = {
+	.request = virtio_9p_request,
+	.get_mount_tag = virtio_9p_get_mount_tag,
+};
+
+static int virtio_9p_bind(struct udevice *dev)
+{
+	struct virtio_dev_priv *uc_priv = dev_get_uclass_priv(dev->parent);
+
+	virtio_driver_features_init(uc_priv, feature, ARRAY_SIZE(feature), NULL, 0);
+	return 0;
+}
+
+static int virtio_9p_probe(struct udevice *dev)
+{
+	struct virtio_9p_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = virtio_find_vqs(dev, 1, &priv->vq);
+	if (ret)
+		return ret;
+
+	if (virtio_has_feature(dev, VIRTIO_9P_MOUNT_TAG)) {
+		u16 tag_len;
+
+		virtio_cread(dev, struct virtio_9p_config, tag_len, &tag_len);
+		if (tag_len > 0 && tag_len < sizeof(priv->mount_tag)) {
+			virtio_cread_bytes(dev, offsetof(struct virtio_9p_config, tag),
+					   priv->mount_tag, tag_len);
+			priv->mount_tag[tag_len] = '\0';
+			log_debug("virtio-9p: mount_tag=%s\n", priv->mount_tag);
+		}
+	}
+
+	return 0;
+}
+
+static int virtio_9p_remove(struct udevice *dev)
+{
+	virtio_del_vqs(dev);
+	return virtio_reset(dev);
+}
+
+U_BOOT_DRIVER(virtio_9p) = {
+	.name       = VIRTIO_9P_DRV_NAME,
+	.id         = UCLASS_9P,
+	.ops        = &virtio_9p_ops,
+	.bind       = virtio_9p_bind,
+	.probe      = virtio_9p_probe,
+	.remove     = virtio_9p_remove,
+	.priv_auto  = sizeof(struct virtio_9p_priv),
+	.flags      = DM_FLAG_ACTIVE_DMA,
+};
diff --git a/include/virtio.h b/include/virtio.h
index 3edf023463d..b981eead5d7 100644
--- a/include/virtio.h
+++ b/include/virtio.h
@@ -31,11 +31,21 @@
 #define VIRTIO_ID_NET		1 /* virtio net */
 #define VIRTIO_ID_BLOCK		2 /* virtio block */
 #define VIRTIO_ID_RNG		4 /* virtio rng */
-#define VIRTIO_ID_MAX_NUM	5
+#define VIRTIO_ID_9P		9 /* virtio 9p */
+#define VIRTIO_ID_MAX_NUM	10
 
 #define VIRTIO_NET_DRV_NAME	"virtio-net"
 #define VIRTIO_BLK_DRV_NAME	"virtio-blk"
 #define VIRTIO_RNG_DRV_NAME	"virtio-rng"
+#define VIRTIO_9P_DRV_NAME	"virtio-9p"
+
+/* Feature bits for virtio 9P */
+#define VIRTIO_9P_MOUNT_TAG	0
+
+struct virtio_9p_config {
+	__virtio16 tag_len;
+	u8 tag[];
+} __packed;
 
 /* Status byte for guest to report progress, and synchronize features */
 
-- 
2.56.0.rc1.310.g51773c2048-goog

