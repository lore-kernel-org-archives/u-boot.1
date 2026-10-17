Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64496CCF2C4
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 18:46:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1800E4090D;
	Sat, 17 Oct 2026 18:46:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W4GDNZ0OP4_I; Sat, 17 Oct 2026 18:46:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B66DA40913
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792262803;
	b=BIdKaTdp+q3rltg2SPVWtQlJfJCnTc3frDv0Fvge8Gx7aCRVpe/gDDNdjPpPH+ZVTlGN
	 9U3vLsi7uyqsxpxPMk+S6sP48BoCwaUVAnPG0rJR7zcdI73NOIQCzRwyAp50jpqsKQH9H
	 BYEqkblEbWNS6hZGx0AmSHaSLOnDwoExy9ABjluaU/xr9RciDtOllgSP6Zcpf34Jh86D3
	 7MMYAQhViMO9Y9X17BMBxJnkt8/QAuZQrTwUA0h59YUr7JfgarPzaXCmEsc2ltSQ2NK0n
	 KtDbgfrbcDjq8u2pc4hLP7cN5/E7AXGz6PgXFo9GCkVLNQ1qwxdWk7jicrww/ddi+sQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792262803;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rmPw5AvAxAbbk211mHK9YPuCjJWwOu/r/Ks3V4GmUps=;
	b=IleVHviyARW2wBc3LB8m5QRvb7hDu9UJMGXLanYZi4sDL83wzabQYuudXa2p+YkAGleX
	 Hzdf789d+i3Gv4/jxzAmBh90l2IgvTOQSRNnR6skAnselus+WhI9n6p+3NCQX6fy1zVs8
	 Vr1MYYONUZ60u6FXQ218qWHUiBym7Gt/0KAhMWNbJlNEceR2evP9lRKBWEN5jTZPDsMsL
	 WD/rP7GEsDFlYI/rSF+YymmtLXvV2NfGVB6wFMu+4MK3Cn+1R7ifuai28KUZzPHKOlbCP
	 pFqtWKB+NB73uZRvc3pIW60lAQ5UXsspLSLjjLfgdTnhmV0hpXfyNTs1Fgl5vuyk2Bg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792262803;
	bh=rmPw5AvAxAbbk211mHK9YPuCjJWwOu/r/Ks3V4GmUps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YAErSKk6VMNXdwt9mh9E2ac0y9qaM0rHlQBUbB68nWuPm5DmFnZqhS9GrkUKqjFYA
	 kGzpwgyi5Wu9hRVSs6AdOo84sFlRQkZP+YJIGnEecfNV1ZzTz296vnH91VNYQq8PA3
	 UOPVgLUzoJRfkvOvAeyhFVkLIsIL9PZyam1xCJC3I2hrWr2xNH/MGAP8icKXXIdKCD
	 wf0KtX+SRMhzv/b/GDUpZgGffrwx+xmXcPeWz6O/Bhap6/Eu89gV31US5ydltWWFyM
	 hT5mWZNBD6LSL0dIx0l20tt5uOaEJyX9BunK0puyliwiESDhrx2fB2gobqN3O2LDcb
	 bbsD9JbQLp4Bw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B66DA40913;
	Sat, 17 Oct 2026 18:46:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 346752A8
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 18:46:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 25623812BB
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 18:46:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gCXZsEHCUQHb for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 18:46:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 145FB812B9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792262799;
 b=DIW5TMazK3AFBEJFVkQaAuN7pyGG9SKvsilVe5XyA+8gzwT270VHjX4WQnbUP1s4ibgX
 aIxUYE+nQVNsiW/ZS9V2cpQcWWVzdsUGYFP2XYH77gBgt/RnuynOtroVyLVIOSdjTRjuY
 +j2vYPpd2x0+4ghYl2GljvNlGHac90IgUeBfZ00fKY1XTHf0G+Yez5+uD4y0tp1nP+Swr
 k1P/XmylB/DBU1XA3Yn/GQfkjbNRk4ylbyYn6GcV3ULP5Am9UbY2FwoBTid23TrOph/dD
 7exkkwcjb9zCMVPv1aTUNfd8V6wO9K/ydSkyDg2oISMx2oz84AwR6pN8bXm4qITIDbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792262799;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=rmPw5AvAxAbbk211mHK9YPuCjJWwOu/r/Ks3V4GmUps=;
 b=H8RhPv/ZOHPY4jQR/T4oCByhKqT65RIr75WI1m8kLDB6DEUdiAwF5RZCq4TGp8GRwiET
 JNV2gKjrZCbyLvDi9Y1vgmF09GOOXYp4RV7LVE0veSZtOUZOT+zSNAQT/51X4DrNhUJlm
 GPAGzDpvonzwVA4nFp9UYCx9SyH8eCVY4SG/TTHJgMGAEZn2je4q9qI5IeGs+/r3Jx6YQ
 iPJJGivRIj1dB6hiLq0weGGJoLl1Hk9NL2BwHno4rAT4SuHHfUv9SjTN5VLbIgXBtjqvB
 iWcwEf1Sl8Ot5z/Qs97KbSZ55wuQ7PW8oyWzrkXFvfL++8dpgVM56deJsF3+fqU1BJg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=dQAfnhJ6; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::132d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=dQAfnhJ6
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com
 [IPv6:2607:f8b0:4864:20::132d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 145FB812B9
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 18:46:38 +0000 (UTC)
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-30b6dad2382so2619394eec.0
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 11:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792262798; x=1792867598;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rmPw5AvAxAbbk211mHK9YPuCjJWwOu/r/Ks3V4GmUps=;
 b=dQAfnhJ6VyAskt2XftOxc3WPgD5ff8QUEJ8nHN49QdKv6Kob77HigVpJltTX6lCGqs
 OCtsq5HHcXxtKP0KSHYXh5uneOovqCk4RwQqAKiP+M+XQFTs3ueuoogmI+m0BqcfkVM8
 Cv+7zl8D5N/fRo9sOXNeKMSfrFugcasfaZQzP9y7jv5l2OhTOxVycZOl4w2IneetgSkY
 5NdFd47ecBnt5HKf4//ITIWO/SU5SjVjcM/QbK4AJTuvcq2i91zk6qy6QifoJ6VPr+fQ
 MN5xQGUxjYg690K7YNa7cMHcAa3LLehlr1FBWOTyrTmAI+c3O0kyHQOGCMrYiAtGtzJV
 X2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792262798; x=1792867598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rmPw5AvAxAbbk211mHK9YPuCjJWwOu/r/Ks3V4GmUps=;
 b=RH99oM6PPcWQrf/oCAEiOrQ0Pj/vMHzyTdsjk7Mg+7BWBQ+fgMsRlBaGARcqHbOfLs
 wzf8ta2Ey8di0YJwh9jNBOrRA2aSGqblR/OA1xRL7KH24uL98oxYjcKLnEN5c+ZJiDdg
 9UFrsnfhLBmW0/lv+Zy83Wy8gS98X58PXVmSKDTRqUelVw81/WQEVUhaCV4YSYoi/vIJ
 itt6qBvY93qrNdnybNk8Achyizg2xgfcxZCq4hufJ7fANxdpsUuKHHOCvFHB1edUIa5J
 4+cvpefXeV8csBkoZrFBbNHJ+NYjrqO6hooTA5wppTKEdNwflwHLoS4uramv2CoSyKRc
 WhHQ==
X-Gm-Message-State: AFq9FYJjjVhtd4I5CHR8EvEBbSb4OBGI+a0+ZSYB1lPeidNyI+SNpYV7
 lPYDaX6Dw092Nuo1zRZACIji/499VrrHQCFbcAr3Fc+hHX5Qk/4aA87xDhcR21Gv
X-Gm-Gg: AYBFou1/2tLErZy9GrvrK87nAQu6yDTlrClymhlCr3dkOVUfWJNG12LG3YUCAGMsXI+
 jjXOpizSNsts6xHAddJVnacinOrZtxFsz7HsPvPOU6lVg7qADMED0z067uodEKRIl7sYIuBbwU+
 vbQ3GnirGuPb88SrNw5SbGjqKd6AsuKL220IHMsAuHmGIuJZLrRAZwCCJVWCp/rWiEqwrMgz0jY
 U8MhF1IT605dhUmuUy05gRqd6VGPXEIutUb9wjbQzzv9t9a7QRO3fC9j7WDF6VsI53ywVHJPc0q
 jlgb3tIXbLw6DYKu5jNejkPJO8kW+MliKncRAuCabeFr1Bd1gxWSitL5oyl+btRMlUB3IWs6UXc
 Px0kCwj/0c26OhXPmxI0rmHvxV6M44c0qbO6ETkxc8fOW2JyIw+jAT1yPOlkAxoLb/hC+mIHVoD
 p4QqgZqpIdqDZxlT8TRzMglid0oe5C2W/IjMFaj1p8mV7Dpl6P3nPVpsczwsfrK/Aj2gWs2x+oe
 mRz4YUxcxcXiPcymwR9YxOCM47tocHfFxDbWHDrfbQa1u0C3qgyc5wyNdo9sfBvMWKNqE0TFFei
 WefjWzHxGqHztsrBhn+boJDKrMyT1sUqLuynrvZh2Bg794iUeKXWbA==
X-Received: by 2002:a05:7022:fe0c:b0:14b:1e78:a19f with SMTP id
 a92af1059eb24-1850c223833mr6216813c88.6.1792262797475; 
 Sat, 17 Oct 2026 11:46:37 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-18314b1722asm17228401c88.1.2026.10.17.11.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 11:46:36 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, trini@konsulko.com, visitorckw@gmail.com,
 sjg@chromium.org, xypron.glpk@gmx.de
Subject: [PATCH v3 5/5] test: dm: Add tests for the virtio RTC driver
Date: Sun, 18 Oct 2026 02:46:22 +0800
Message-ID: <20261017184622.3925389-6-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261017184622.3925389-1-alan.tseng.cs@gmail.com>
References: <20261017184622.3925389-1-alan.tseng.cs@gmail.com>
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
---
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

