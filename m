Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33866606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 03:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=k8lvfa7r;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ET85Fe5z
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E5B8C405F0;
	Mon,  2 Nov 2026 03:05:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2Z2v05koK95R; Mon,  2 Nov 2026 03:05:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B9877405E8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793588700;
	b=ksNkCt0hn2/8ll2bj60kiZn8DtoCvQzkfvDSbs5fXN0sZ1uQMWbOqJkbb88cTxQ+uiMh
	 ewlSsR4Xm62K8uzLM4TiSkl8VNBkimYkanxlJSxZAm4pgY/jeCm1IiiLGQxSyJDNWDwqj
	 N+sGGr6+C9Qj0x6k3OGTb8e84FCflDEdTS1yRTjVJ/tFDS7iR53rYYkx7nksRUUlcBml6
	 lAl6oKsT7VOfaCLCGWK0y4ER16dViqKsn5TsW4rci4E9EBqVjpwPkQsk+ZtdLi13Qvryh
	 okpNcOVu3kMWZsDQIBJY8ZQLug7iF3D+l1kTNUtbD5KjKpYUzLHh5yttqqpIwPXmBzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793588700;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WgWySmqVzefBr68RasY63tBHor/AiO6pCEMOIoMnxKA=;
	b=hnsUcUa/F2Foad22Zr06fx1UiMMcAAmSQFeIbsMQ9kMTyDt78Nau+q4S8qZp1bTk5sjv
	 nHXqmVoSRtaJBCy4+2USAx54uIabjEaRCZPhPEjHSIutu6DoDU+cHIUAbpCFCNeV0KE63
	 pxaW2bpEuwBb+M8jslQyzV8nWXClEilmcNXKI42qjWV1ftfhH8y/gD6B71860VnsgKghn
	 PiEkU1H5jXjRCN5+e4lyHBSVZtO9h/2+CgPqXhYuMBm/xoWOFBPL/7jLQcTX4KWH6yiB/
	 OVtvzjuh8PXozA+LdD61hsBeZeM/JLCt0LVPfVKHXXDBACHFPUFAkbVfGhDTelg8pAA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793588700;
	bh=WgWySmqVzefBr68RasY63tBHor/AiO6pCEMOIoMnxKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k8lvfa7rn2Te1xcG95ZbLmGOi3+4+UJlsa9YiNBiMWMscRO2PLrIocGE6CCYGDJCi
	 tb/xanT/4voHVrow6d055YMwMv9Er5rhzu9PD/Qn/qZTOy/RVJY1MOK2N91NG8afKh
	 DSPZcOOpeWQACPxoxVarYNxC0gKAQWy7rRSKgl6lAweMmWokozboRRJZBWSwaOOGbZ
	 1bo7dxVYf8UEPqKHtQooRgCzoZ4myIvgo0a3RjZqCTlzKGOe0vpd3D3Kfz5slNdKkj
	 xScNLm5MM2kPqp2FSomhTF0CsGw2Jv+rUqDYKq7FKtokpfTRFLygK4etRISuwhM8sp
	 dWxXuq+ZIUtAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9877405E8;
	Mon,  2 Nov 2026 03:05:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9DD32362
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 03:04:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8EBEE606FF
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 03:04:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ibR0o5W90kz0 for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 03:04:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 236D1606BA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793588697;
 b=lDQdbi4sZMc1BopXymv/7lc4BPVJ0x9zZLxymRMQAW9YzsmX+DlppM5Qzvgfg4R8JhL1
 zBp9/PHeBzXXNys6ikzynglf9Pwb6O3vWG4A0mUWuYYXGazBUI1TrdmFX5Ufja7zsiL6g
 0HI20vD5jIgHJI9rYN24kmnK2KA3W4FrxARcByQIpfHzpUUkI+0vmRfEYgxXLe3RGfTDL
 J86rDqMvVGq/oD9tBdZb5SZwZmQhVM70w2fN0M9EEYRLFMa3o7e7Asp8MVYs0ilG26Snq
 yhWg2XmAxnUomxhCR0bewhstIO+ufNz2UliGltzgtD90vjhAEuQF14uyrZwcFmJLjsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793588697;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=WgWySmqVzefBr68RasY63tBHor/AiO6pCEMOIoMnxKA=;
 b=kyxfqJshhjiMDLQ67kDZPcepzH5FS299qns8MYqb+9cHFGyKUNOi1J7hJldPlSToTwre
 UDefNyTkgXyPiYsBaUWDFtNAgxvfoIjhwID4q9NLSQ1qZjBKFrxoP0kKeuuojFz0+5WR5
 SG1iCBm8WuWnZzXJc8YWB2CnJeV/PqmxbQODCm62fGrdhxQY4o1XLIFkxRTeGe+ssGcEp
 9O1Gd2+xUoavzJW0YZ3Qa6gtY1vD6FD4XEqWQUQy0roqT6GhkBnK4p02QKwhQ7nFdVI/y
 t7c/9VMkONE9PtqYcFBJveLVXGsFyUPxx7AL+9OsIewCnJ0AChRSorCmgTj/3nE019Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ET85Fe5z; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=ET85Fe5z
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 236D1606BA
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 03:04:56 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3ab98332238so1288862a91.3
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 19:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793588696; x=1794193496;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WgWySmqVzefBr68RasY63tBHor/AiO6pCEMOIoMnxKA=;
 b=ET85Fe5z+VSPJjkR64MO8nDiQOG/UNCA2ujbca91UPrhx0ZWvswcI5fOP26SjHpgg6
 BXV3ZKsnIm2wus+mVd5vm3aGYId1sq8zv9Hx6+X0bBNA7iUBDcjDXmUwFpiVnGGUn3oa
 w4kz5woG81pbJ+/OS//Tvao2CYSLmWrGY7cOOGLhTNUUqi0ZJTSKYx89/IRDGDcf2zy/
 Rw+O3sXPDmL7S4SPn0uT3LLMMpDSmLQGzKQ3hDxbyr+fWgbjl4mvyqxcgPHfmEINauhI
 52t+cLZd7tRN9pDLDfKKdNUmfi35SgBw9a2y0nOWOmzWC3lFX88OzIKi7jVa+Zbbttbj
 y4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793588696; x=1794193496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WgWySmqVzefBr68RasY63tBHor/AiO6pCEMOIoMnxKA=;
 b=N5L8f4tKng6O22g0iv4cgt5K4eahPIYtj8YyLqz4bkx2MiSIHLk9FruTlwxY6GTdmB
 6DW3nhKP2yDNCOvWufaRNA52lqfBvbJ6DOTaqx0JFF+1qYglED1+MZ/iD75ASFu6elkH
 k3Bj94DzAh24pSAkJQcwwlvCfyLCCbtEHCIJJOL9GlPud0PEIXdYsg5DdIvkElrFq8ap
 twHGhs3RIVbFVAi6UxIeUKMOV253XHXqOZSe+DaTaNki9rO63NMllKtKsfpdHeR+5c0K
 9bXsqFm5460Pt37znLpbMBNPY5xHUDZKvigI6Az4p6f4iIS7+mo41C9mWJrmK0MGCBag
 G8mw==
X-Gm-Message-State: APuU4Z8ck4H6jsXmMecJIPMNxyotLC6cDlPI7mRBVwkhUq1gGkMCvVJq
 fu7DwMLjzW8XC2hPogIlael2sqa1tT5PdsQc+LxsJfYajEstGv5WfCcj5pToPdcw
X-Gm-Gg: AYBFou3IGPH6fNCVdUdatyBXhbFzEtcRqYrCtYwfNSbPLYzyV30dd6b1lJOIZyfR8ml
 TUcL7j7zV1BAi201MX1fQ2NLDXwZWcbj77CYshCf+zBc6UateqHcxeoNyDbq/bYYzG7zfHW/WC3
 oNYbKanlAoo1qo2cQwdJsMfGOVhyjF3mhqTb2kYmoVzhAprMmlyC20Q9dwZZsNZ+nUIaP5eFCkM
 G1gJ7j51P1aPDuJGGPJLSqJ9cmphz2ADOZWNr0Bx3vQlnZstoLo8hXE9ct7kXuEKc/GkmERJSQn
 zrkTuGqaxTThawhGzNPdEcK/r4xZJ+IqhEhk3VKQRQMQpnKtLssJirmBAP4WFXyulHoRyQXTgcd
 fKGY522Q8HaEUT1vyma3EFCgkyJ66zAe2x2talXM+NkrrfTHPKbskR55AUhweH5X3G2StDVFn+7
 NCPNHT9sxMZzslGFfS3HhZvThyrBPhL11YJ1Kp2p+/pZGjsP8sjkhvOa3M5H6OV4D1ZK7jK0LmG
 cHwZJVZv4Mrj6Z2ES4BuVi8G5fTQe8amxpEK3sSHBmmrgZhtFJ6SEis3dhCrF5REBIestCgwIvb
 1xX9mgB8oKKc2XF8Ap9mLEc2f9fAyoizWisgGk3A5NxS+4Y4OuF3kpjvlcpPEc+2RVyww7IIyzf
 dqOi/QF3aPOi/JZYmym59h8eysgrLv3QOPvkGw6/5YRgFUiQq2JKtujVNLJM6xAaz19Jdzhuf1V
 0UmW3xF1lZRWGz4o0LCdYUEAZQt8jbhA==
X-Received: by 2002:a17:90b:3807:b0:3ad:a232:403f with SMTP id
 98e67ed59e1d1-3ae897aa79emr7781729a91.56.1793588696147; 
 Sun, 01 Nov 2026 19:04:56 -0800 (PST)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae845432e4sm11995159a91.3.2026.11.01.19.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 19:04:55 -0800 (PST)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: bmeng.cn@gmail.com, trini@konsulko.com, visitorckw@gmail.com,
 sjg@chromium.org, xypron.glpk@gmx.de
Subject: [PATCH v6 5/6] test: dm: Add tests for the virtio RTC driver
Date: Mon,  2 Nov 2026 11:04:41 +0800
Message-ID: <238bec157299420966a2ea24a0d0cd221c24a9c5.1793588058.git.alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793588058.git.alan.tseng.cs@gmail.com>
References: <cover.1793588058.git.alan.tseng.cs@gmail.com>
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
 MAINTAINERS               |   1 +
 arch/sandbox/dts/test.dts |   5 +
 test/dm/Makefile          |   1 +
 test/dm/virtio_rtc.c      | 306 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 313 insertions(+)
 create mode 100644 test/dm/virtio_rtc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b82b91494..22070983d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1891,6 +1891,7 @@ VIRTIO RTC
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

