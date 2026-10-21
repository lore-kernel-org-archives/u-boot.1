Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9FA606A31F
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=g/D977xk;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MzpVko1h
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2A5D981164;
	Wed, 21 Oct 2026 11:07:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z9ULT4pfB-3O; Wed, 21 Oct 2026 11:07:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EA247810E6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792580847;
	b=CjOxYZQ1GLbzybaZ7mGishpQkUQDiHiIPINEZiKFEm1XelZ7zX823dRvzUCP4DBV20OR
	 2kvnWYnnvm+7z3uiIrnGWFJrdpPAfZz9yukk0iei5eEVgB89coWX8CG5JNElIOLx+HmMB
	 TMg3dcM/gzIa6IaVeay29vjUBSaDaylp2BYM3Jk0bfzqXFXcG3blOQyViI6Rs/lzTYp1Z
	 kz+JY3VCYUaWbbRshvtj5SoPA7bQ4Zjfk6ZXYwr+mD8g4b4UE5HxvGbW9ew07A9BNkPIr
	 V+XNoD539jluKHpxIzIs0pzH0Xht2Cq5krrg8qxMv63jH9zTKDvx2iBnOCyv6XPQUEA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792580847;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qfZ4biPZQGywVxciADaP22GQlGoW2anSW/mg1YJdvHQ=;
	b=r7teaHoXDAdWgd4D+B4WBzA4DFvzBdBCIkJCkqDyLWhtbNLh2jdyVoLwdiVxPBo77FAX
	 BQgyn3Z2pUN0jk447MZgNGkrOzskssCaV88ZOZaXjDIUZNVS03iEoeKpIa7hX6nXeWtGG
	 6MhBMYwa3xV5JBWOYYjcxBR8sTOxAj5UC0Odetn95nTZAeEd0NxCIJap8roPUuuDcVnop
	 Ywb8lk2zmPzzFSKdWoIdSfPLp/I083QK6hVu3Q5Mw85HyWYCjaqvPjoQsN661s+Tj5Ton
	 UNguYQNZKTTn81051IBCgqDZU8srL1vG5jTGCOiEPzAtrOAirCHApuiEZRaqpGZB1VQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792580847;
	bh=qfZ4biPZQGywVxciADaP22GQlGoW2anSW/mg1YJdvHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g/D977xkmJyFK7q1SleoIdk0t9t8jCFRbEF5TfNhUfShA3LA9BNdpwlUCsf5PQaTj
	 2EaDKGHMM3yB+l3PzLM8eRynS2SIBnxHWEPUXo+WIFFwLaBQXmv9iG9RTNsdjgFHck
	 85awTjQ8LerMMcycSeV7nwdb0Yl2TdJJMzZFwOLEC4VvhWby0+knBury+mKWpqmxoW
	 3Pe5u4PPdYuRjKPAzZNPJSqia3uUyLnaQ56RPn7BmzHY0dhAn221zS//hdT4X8a01M
	 DviwSlxzvtwHd3nTa+M4nf9ycn7yBvAUEJxZ9yiYtEi//+ulXQdi04twpp21v46P1c
	 zDlEN9r2rh8qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EA247810E6;
	Wed, 21 Oct 2026 11:07:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F150A3A4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:07:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E340740761
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:07:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N4SRki6qz6LU for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 11:07:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EA8244075F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792580842;
 b=TSEWyLEYNUKyETOk5qFi5GKABPeOhzg3AUfxXqUUGLA08wlz3lZeSacpI8I7aWD2HSZC
 aMxD8GuUX+XD6+bVEsqEEOK4DsIlTZQd+07MffOUZIpeIBBVHovb9AG1fqmOFoDq68Ywc
 /V70NiBF8sk67hu8Xx8A+fkE1EFn+z/jyCEA8pLxREx7bL/XPz/9T6ixErAqE1AfVEYQQ
 4kuuU2HyVXpPH4nW8TsQwznYQ4QXK5i739Qgu5tBdVPT3Vkj2meUyyCACI9mHgJCQBqSy
 oCTQZmjhXHlAboEhHrSIOIcdJt6wLJQu1jggmMoNix5IUWUuonIKFULwmtReTddzo+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792580842;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=qfZ4biPZQGywVxciADaP22GQlGoW2anSW/mg1YJdvHQ=;
 b=A08xDSB6ZnxykgLCZA5PZBLcc6gMbUi27/QvECXvYk3wNhjdoRz2a4UQa4sRNv0SuEdq
 h6UXEYarOhyJbmBAnMsf/ROzu8R4DNrfL2hEF11kAQmaVdSb7CMWgp8WZtVqjau84Jyx6
 J+O1JQIhsW0uSTfDFp6veX2WxghkzjB67DXlfY4D/ztwj6aUzrnUmTmxWpTsY0W47bl4L
 FrmS+3MYN8SKSpuB9sj3/vVolpl+24NAHckr2uas4z+N1t9CJAcituZRmDXSp75eJ7DWa
 nJ0Ach68rGghBZGdnBHjcX1vGO/6kuyOemMKsaa5Plxqsrzj/etU7N8L4ufzDo+GX1g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=MzpVko1h; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=MzpVko1h
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EA8244075F
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 11:07:21 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3ab868eb9cfso323670a91.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 04:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792580841; x=1793185641;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qfZ4biPZQGywVxciADaP22GQlGoW2anSW/mg1YJdvHQ=;
 b=MzpVko1hA84zEWaAipd9MfMoY881Q1r3aEa+HrCjlu19z417G9d0xtweZAFiV2WKvd
 kj+7T0TxVT7DcFbupa9cvEdTQoqag5+oRRk/aKiHxHc0OjKyXymxV/qMwJPLpabEM/gC
 Wcw3zqi9+yRrwbIf27LS9+65EKF/Gq9kccbpon3HAbQT4PmwjmxC6V9yfu9jpKJsQV0d
 3tW6MxjvK7ju323ULRfPUB7yjxxfjuh3Vq0EcsjmdbdqXsc0tUqoeFALstKtBnQ86pQy
 mfvMqZAR9EzkVTa4S+qBD0fxX7F7HQzfSjCKnt+nhOaOxCHCRhwO9lYfTyQ1mHieKhur
 KlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792580841; x=1793185641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qfZ4biPZQGywVxciADaP22GQlGoW2anSW/mg1YJdvHQ=;
 b=S+8efmV/4zmHSD/k/yYCWwLMzT54qebfFJYN0kSCnXk4ZxfMVBJ+wV5DL9L1ppyFAh
 oMTGvbQcXFy1DI6f1SGK0fSbPWZu0MrL9ie5xXK917CE67wO8taZFcYG6bTRhCAC2sUM
 xrl7vIe3E+m5XfmaRvSwfhRR5CUWFN5CmhT+deivpkze5yYhyiYefmZKAe2mEcpXi+mm
 1ItGFmyQkbcBFNkomZVQmdfnG7kM4QxhfUYsJgc1WcwkKdtYFFN34tDlotwFcSe6W2k8
 QWDevJTupmPsKvrLFYXvhj8ghuIdZQA+/ehfhS8pFywqfqPV/YOEcljXv1Cyf6Isegmv
 SikQ==
X-Gm-Message-State: AFq9FYJXZy1/mtyiJN8LL6Z5A6KPeDKTrCh3gBaZsxg/PM7Z6i+4ditR
 4G12iP256Dy+wIE7wMYbUhroF2hpJhSjwfvtaJghxgvqGD5Uwec4o6memwigg5eafAc=
X-Gm-Gg: AYBFou3ZZ6ihy+N3bOBpdx2PHEp9bQ8gwFeFaFUihlp6SX4pXpeQ2bO6KFEjPrL1A6v
 5mYLYDCchMfXJShJIU6XrgZ2/ErxKKcoOe9eCFKFeLy1t8IGkfFGIYH0AAjXViZrt1nzOwkuIb1
 Q1pke08dyNMdxkjz7nqFSaflntMN7OrbLhYEQMQzRgdEtZ/RAxyOHjoI4ZnfvlxzrAHtUxsztZK
 Lq6wzCi1aMcvZL4ToeJgcgLR1kTG+64LJ8QrDosD06EJIBxWV4jX8/4RWdbwsaKqnbX8C5TI8ZP
 IWt5DQ1dyveOyMH3E8Tnsy6fiYsGb+zf7HbCLfgS+Af/ereY9Zi7xFXUagZp4xOOpuG80+vMvhd
 vMmQgpYxBpkrqdkmubAiV64leA2jF2pbvjmXKPpasNz0Rry61QJUm347mJSokYC+9yJyUndaXB9
 7SEI+yPhqnntpmHNq+/FteSuWVhHMJFsfIiRX/qObJ/EIA3QhTV5xz8i6UZQWUYhzm0RSmg6dje
 TNiTjHZLdyd/zmRemsCJamAsn8vnfw7J9hdx0Sa/7NPnypfvBIow923twcsffDnUEg5ReSOQ3eK
 iwfoJn8LiAOq+rzz21r04highX2qaiTZ1jCSphI8FG1tx+t5vC5ooyUnRWROJIm8n/jEmQz+BJG
 tveJNmnuQOjdjgC+lI4flLmoF/f6zYRjv/A0=
X-Received: by 2002:a17:90b:2ccc:b0:3ad:5c64:c7a0 with SMTP id
 98e67ed59e1d1-3ad86ef45bemr1396094a91.38.1792580840739; 
 Wed, 21 Oct 2026 04:07:20 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad7ffbbba1sm4029380a91.1.2026.10.21.04.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 04:07:20 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, trini@konsulko.com, visitorckw@gmail.com,
 sjg@chromium.org, xypron.glpk@gmx.de
Subject: [PATCH v4 5/5] test: dm: Add tests for the virtio RTC driver
Date: Wed, 21 Oct 2026 19:07:06 +0800
Message-ID: <20261021110706.2947351-6-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021110706.2947351-1-alan.tseng.cs@gmail.com>
References: <20261021110706.2947351-1-alan.tseng.cs@gmail.com>
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
(no changes since v3)

Changes in v3:
- New patch (Simon)

 MAINTAINERS               |   1 +
 arch/sandbox/dts/test.dts |   5 +
 test/dm/Makefile          |   1 +
 test/dm/virtio_rtc.c      | 306 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 313 insertions(+)
 create mode 100644 test/dm/virtio_rtc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ce94d7f5..486bfea29 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1876,6 +1876,7 @@ VIRTIO RTC
 M:	Hung-Chun Tseng <alan.tseng.cs@gmail.com>
 S:	Maintained
 F:	drivers/virtio/virtio_rtc.c
+F:	test/dm/virtio_rtc.c
 
 WATCHDOG
 M:	Stefan Roese <stefan.roese@mailbox.org>
diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 25c99ef81..758b04a1b 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1974,6 +1974,11 @@
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
index 5dd6b57bb..975adce55 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -142,6 +142,7 @@ ifeq ($(CONFIG_VIRTIO_SANDBOX),y)
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

