Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17BA606A320
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eINFKa0O;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I9MaDnyY
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BB8480D2C;
	Wed, 28 Oct 2026 03:07:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PIDG6RqPpgAs; Wed, 28 Oct 2026 03:07:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7966780C81
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793156853;
	b=e7O1zLjwB1BWDfUTaDGBZDoMbg4IjDlsu5pojQbUEBeoUFUoORqc5moiJ35pW9NQfyNo
	 zr91WKvGlKs18lrG/dlObjEEkaiqqvfCcp8/odLbNEcFYxngYRVP++Hn5uoJfEDe3h0J9
	 yf/5kkcaH01Jk2kZfT0UNxIAdFCWt19nPcK5tSXwGsw3zqVFcID8nBEVXtM2o8QzZf9Wu
	 N7MYo6RE9fkGmOMOIkFNnPgU8JaOSvF3WXF84/FcOVsaW9bknPgmergoSr9g5qK7LasDk
	 93sZOPFJgz97O6LQVjOznIbSpFjffnHHSQQ3fVUJj5LrENTvx4xB5wCgz6xXjGtKeDg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793156853;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ST4ts/jXclKqkHuAgwnPFcvLS4nbF1O4GuP1Az5Uo7U=;
	b=nR8Ng2GDrl6kFneEkPsxWg+XSPVZC3s03ZSssu7jlEL3z5UmK2ASVTvRZ0nZAYG0kO+7
	 XI8fHUtDaC/97xg2Ol7TY5fVFWTS1JebbWaFkoD+qQheiEIc7mfnOZW2fRiSu0WP7wt/Y
	 3Z2Ltzt7vKuxVYKbtsy6Ayjd5/x6GMCy1alwhq8pWclugQCMpakbml/8O4P/QpJ+9cu0w
	 I1tQOCxj7dieEHQhaDje2pRBzCBRCsh085b9z3Bdpe5SdoY8PwVZf05wAPIEuyAGTaaGs
	 TBDBM2g2o7xKuNYzfkuLmo0+q/yMQPOby+lDSJ3B5cjvLFNR3UU0m1cbbLvDRMdANng==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793156853;
	bh=ST4ts/jXclKqkHuAgwnPFcvLS4nbF1O4GuP1Az5Uo7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eINFKa0O352PtkR9xkZLigHjpfq/UV6bN1dwcROyK7c5mB1JrtyquPvoo7GcyoqGR
	 BC3NP/cTQkADr2TQ+b5E0EdmMJ3E5wG8ORJiZOlgSoWZKfWYhpZnXIKb6x2f+kDL9Q
	 a27PGC323A7wT2cWmVX+keMCSy2p3T/rfXxqyKxEyW6SGaTRf0wFSbvYgTlFDqPyu1
	 g8/54OGM+UJFWzAH8zotNiWjXB4POPi3V6uIjCHbHeOHPPtLpSLkjLJ+4H/W605qz9
	 NjBHn582nBFER8hT5WR9FbxT9Sn0Xq1TyFff6JaA/0flAVQYXBWGsg51+IarLAxG9Y
	 wA2m8GMgLSlJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7966780C81;
	Wed, 28 Oct 2026 03:07:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3CD84529
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:07:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 22CCB400F5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:07:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7L7NtOkBdr7p for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 03:07:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2BE3B400AC
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793156849;
 b=qHBrJUDP7xYefsYigqPuKQxBuUr+2PkwbSO4pomDkjA1ay3aaY6vmLdW4bWdpGXaavf4
 LJvU+wneVShWXRonpLmdvsK9urBCPfoiX9SgLDRVgC9X2dMyZX87T5GqUNkIBdjR2QTSQ
 KqtnMO7q2ko+FFm+Vrp6pFeECiaVFSn6I7zXEK03fUKHULstFaP66xn5LNpIhnZp8S7u/
 bE+xdQy87T8kivbSM8uxmoyb8WNKCiJ+t+a0jGIiHva0sY1dBwM9Qh9bn+/AR27SXE0IK
 Adz4WSUBZgCGf/U0zGhekTR7dRKq0YC28QGasrSPjB6imMIqq1s2o9iFBIDOaYAOeww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793156849;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=ST4ts/jXclKqkHuAgwnPFcvLS4nbF1O4GuP1Az5Uo7U=;
 b=nFJst1uR3MfQymUj/FJQD1tpk0D6aYd1HDaZeBoVcANq5QbSlfOrfq/AZE83CtROhomz
 ZvyA+y7khiYMr0rj/m1fsSq9/KrZz6xs5YICsOIUYo1GqV347I+69z8kLCXaIcWPrCmeT
 zO5XrdTYuo/iJabTubOG4Ys5tNIDB4zzOJVuXwodP/rF/J7jpGXfyBfJSWeh4ATxFL3RA
 Rs5fJCZ8zRgZalGrc7EGCvpURU1ifK7cFuqXN7e8X/VnMWQLRi0FLk4PTucNrRsr4TniP
 QuYcjxb6Sks5NiZIJ8SCh66xTYYinGpLseGcM0bUAeqsPM7qMfn9Ps7Od9T4MImB+gA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=I9MaDnyY; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52d; helo=mail-pg1-x52d.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=I9MaDnyY
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2BE3B400AC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 03:07:28 +0000 (UTC)
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-cd6a7e1f4e4so207173a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 20:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793156848; x=1793761648;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ST4ts/jXclKqkHuAgwnPFcvLS4nbF1O4GuP1Az5Uo7U=;
 b=I9MaDnyYr8s4OEbkrmbAy5lDQKCVZa31Uc3xry0+ZJircrUTkfqgGfzexd7/m0zNNc
 EswGRA1X3V/VbDmC1C1sVR70OJSGjDde0vUmBCiVhI2ab0inADdc9HXvc3anJfXL6wNM
 /vhufUxBll0gPMITGIyi2j6F9Qvv0WLph+/SsVMDORgVTw+SnlxCCwq5SvydEb2cLbM1
 FosP0zCjNF72XGqRDlm+NIr/dUF6W84XntJ1+21gM5k7RzTzJGeDV2zcXBrvTST9hZwQ
 3/No+ivQFM0EVoarSkyzCkLa6aanZ8SSTRl0xhT1FbjDUwNxfg3JG3ymf+WIGh/TXAkU
 kGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793156848; x=1793761648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ST4ts/jXclKqkHuAgwnPFcvLS4nbF1O4GuP1Az5Uo7U=;
 b=HgnvZrmimboXcR8PhpXIyiqnicU5TlLbTdlRui75mnHr6fNYukAZ0cfr4zqaJUXHSK
 nYPmN10CKW+tBeUlH2JNxJ2mbaSpyjEDOh0g58o8eavDz70e8xgxs6PToL7KSAF+qKFv
 zyuO6FxmzlyO0kADd8u0PYTWaI/GnYH1v7PizpldjE/9Ymu0Awvlj1b9fVF1t26PSbkk
 HbVapcv1TpUwEcNLTjcwkwXOl0usYdWctlMUb/pr0T66v+1jJvhz7J5TGC3IWH1xUKh3
 a/x1aqr4WBYrMYMaBdQiLwvOh1x6uHWeGb7UUxR2SCB+7OX9M50edvuSvOuq1yRKQXo1
 12Jg==
X-Gm-Message-State: AFq9FYLv0OZZRGAJse0HqIKGUaic9m4VH/r6wW0eVk0KnFV6B9f6oApP
 pJ/CeuveHo04ijL1xcDo89N/CSs9IIOclgnEhydvgeEr3Kr6LbuNit1qhxlrKOGq
X-Gm-Gg: AYBFou3P90prFOFb1MQlqROb1/Laf3X/y/KPbnczbCEAqsn627Su5u43c8OekRQbGRJ
 UTFQu13JKFYi4tCnuJ8lnrl4fhQWqh0/y1LIxyphpq1tsxjTvZh0SqS+biuE0cdHbjnoTd9fksD
 68AzMowEaOHd8w94voTEe6QJpy3ccOIcbwxpVemm//omWahdL63nQsz5kiVpu9eceSqhty23oZ8
 jKWEuPXoGUZysPDN0NwOnmgw0NRxw8kDHreaoThcYhDlH+WZs6Vrvk1W1V2GVk+jUZGP5cv0TNT
 V8GbLV+Dy90DybU1deo1o1FbHM75KWVnc2UN+zacSko5zu769HeX4pkMRKje+ahoqMROroiPkBO
 5vLJwTjSL3ElIhYCdodNj97LVNMPxj3oJxNyOR7i/raCfzk8m7HYnm/0iox2WZjHHc8xdzOkJiz
 Zi4lV/83DmpB5Fc0Modx2TrXV1y+ppPBaYttrS8etteHUtcgvgceyLoavW19EELa2t+TKgEU3p1
 nerPm6VbOdl9MeBGBIX4PFdhpDNioySVfLrQ9T/9jYUFdmgPeb8q0Bem4e385wk8o3cidFCIuxQ
 mXrz6TNvIVQhSq4xLvXSp2xgL2S/MXmkGYYh9QcP7nddIhbx9zgqUDG6xkEaQ3OWq7mqwVqiRZT
 WgDazhAVBbml4i96Bnx7No2B4q12SneHP8KAGnSNosAWP6ybNQNvLb6NNOsPWzJQDSR6irU0n1s
 HMv3PF2w+qpA==
X-Received: by 2002:a17:90b:4ccc:b0:3a8:699f:959d with SMTP id
 98e67ed59e1d1-3ae5813fc9dmr794238a91.31.1793156848003; 
 Tue, 27 Oct 2026 20:07:28 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae5a48c2c5sm828615a91.4.2026.10.27.20.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 20:07:27 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, trini@konsulko.com, visitorckw@gmail.com,
 sjg@chromium.org, xypron.glpk@gmx.de
Subject: [PATCH v5 5/5] test: dm: Add tests for the virtio RTC driver
Date: Wed, 28 Oct 2026 11:07:14 +0800
Message-ID: <20261028030714.1608977-6-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028030714.1608977-1-alan.tseng.cs@gmail.com>
References: <20261028030714.1608977-1-alan.tseng.cs@gmail.com>
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
index 23a232689..f45bcc353 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1889,6 +1889,7 @@ VIRTIO RTC
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

