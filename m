Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE81C5CFCF
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 17:20:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD773407BC;
	Tue, 11 Aug 2026 17:20:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ucC9Ns4MYOd2; Tue, 11 Aug 2026 17:20:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org ECE0A4040F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786468825;
	bh=M/mCLy59AjvBXqS/EYMmNIKHeNnDxHftpx2qf9+hvPQ=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Eryk/3RfZ4mCUUyyJCNI+D0J/OODvyp+GWB5EH8SvGr6e243+I+1lQ9z3FXo+0jy4
	 4LP+8mKVcR3vU5+dL4eezFNzeJZ+XbnePG0m+ola3v3w5WxLgqbDDadi5sNwZCl7BQ
	 IfNPJ16kW2fBKx+Vn2V0F/8xE63F5lbgwDMcwIjhrh7tnz2ArMjiiCgejsr58RFy0R
	 IKhEbAvOYqxyZTXb8HtnOZmeAnQ/L9qIS/Fmvd5DQQP8/K4KuSkPvnCZhmLeptIjtV
	 empcVi6HbOJDkNyRIvODrN4jQAAgSx+qNC39jzvySPQ3Y7Dc+nPuGG/v2WjpvF8/SO
	 2xylVhxDH2G3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ECE0A4040F;
	Tue, 11 Aug 2026 17:20:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D40D49B
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 16:00:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0F76140086
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 16:00:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H5vl-TDL0Ak7 for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 16:00:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=aristo.chen@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 048EC40074
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 048EC40074
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 048EC40074
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 16:00:07 +0000 (UTC)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2C9AF3FBC3
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 16:00:06 +0000 (UTC)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cceabd70f5so1705025ad.1
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 09:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786464004; x=1787068804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=M/mCLy59AjvBXqS/EYMmNIKHeNnDxHftpx2qf9+hvPQ=;
 b=CQfSAfu47UBa57rntotNpZmnkAspOwLpHZ5woEMVUrslphGwnAwCCYASCzA6dB5HW5
 m+AsShHjUbe+qBcj5nFWmLTARIkJjJu0HA52QCkBmSSzx6+SNgVy5ExEuHAoXBhk3npx
 syfagsC3KStcaNs5625hkFfR/aCpeQww68++2bf9LRKz5roaIJG1ailWZ/kdmgZTzRGh
 lKsqoH3P5TPtNv2NWHfD0GMMAp4nqVeXJvrq76MecNyPqMloI8KggppCY7t9zMVHk6D7
 Dmy7fG2p5DLZIwiO86ZJNlZpEOLwctO28sSJERKkyiPE+VaP4WvTsi3YTDpYVcnsfLu7
 VmwQ==
X-Gm-Message-State: AOJu0Yy4LHk8a12hJndsMFPs493dTvg/Ed2uEGIcqNG7Rl86IShv4mAg
 qp8SM25lhk936jUH5cC9RiYqtlMQSFlDcm9JI14YoP6nJ8nheVpLPQ1x5n7sb+SLwovjo1Inxf7
 ba++pBikq4JbG8v7//LttNaxpjKgcv9C19b9vbA/fek9ZMWIvDnppTN9ijYwxKe3RAd+mASCEmw
 ALPm0qzKvfZ8k/DHvCfA==
X-Gm-Gg: AR+sD1365JG+MXVk3Y2Lfjtfglpf3nJJVR0vcxEFVGvf/Eww+Q8oz/7Pd+3ScSXoTVc
 SGl0n6MPHvd5vuHLI6oR7XxydpKkptkicK+2cyeE/Lob8Of5VM2kpFDccMNmC+ZsMy3Rn2oELTQ
 a3glHqtws18q8cjttjUgG8vWijWQlV8OGp64L/O0Qdh2ttVLQc6MF9kMr37v27DdDLQFbW0boBx
 EMheyE1T64ql/shsZCuhrI4uZYviX/Iyu9fu6hhvve/eRgL6QHvRZfsHeOpzeMKxYP9r49JRF62
 KWfGCtyDfiNv4nFrxs7ZUridkZYTZdmqxhQQ4wPWKiVpUo1wDYFu1FSwp915rBCSSrcSBf69rxQ
 eZr+LDu10IQ08a3vKUYIn77jcLGEBTcZ0NqZd8qB/8kOA41L6
X-Received: by 2002:a17:903:468e:b0:2ce:fa3a:45f7 with SMTP id
 d9443c01a7336-2d317904fb8mr57721915ad.16.1786464004466; 
 Tue, 11 Aug 2026 09:00:04 -0700 (PDT)
X-Received: by 2002:a17:903:468e:b0:2ce:fa3a:45f7 with SMTP id
 d9443c01a7336-2d317904fb8mr57720475ad.16.1786464003921; 
 Tue, 11 Aug 2026 09:00:03 -0700 (PDT)
Received: from noble-uboot.lxd (211-75-139-218.hinet-ip.hinet.net.
 [211.75.139.218]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3160f47easm10342485ad.64.2026.08.11.09.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 09:00:03 -0700 (PDT)
To: u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Aristo Chen <aristo.chen@canonical.com>,
 Denis Mukhin <dmukhin@ford.com>, Martin Schwan <m.schwan@phytec.de>
Subject: [PATCH v1 2/2] test: boot: Check that efi_mgr boot failures are
 reported
Date: Tue, 11 Aug 2026 15:40:57 +0000
Message-ID: <20260811155940.17698-3-aristo.chen@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811155940.17698-1-aristo.chen@canonical.com>
References: <20260811155940.17698-1-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 11 Aug 2026 17:20:21 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1786464006;
 bh=M/mCLy59AjvBXqS/EYMmNIKHeNnDxHftpx2qf9+hvPQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Gq1xaFzVqBVrOYZFpVjtbnA9fjJqmQPvGkRPNVYcqxpDA1AB5AENtJ/Tqq0d+DPoX
 8Ty5DCJsU2P/e0GZfZDPvbFCAY1UAL6980V/YcqEFyRQBS6xrKyyxXooz6uZ29zNCS
 /IUTX9WK1Xi64JFyPdJE2HHKMXrbdQAfzg1bXjJSf2nn46HbFKaix2rHspIV4ZUK0W
 7tuLLfXVmqQZ+MjX9P9VAlLXGgs63ajbDIxk3zUWWdQxYpxesjM/tW/ggGjGX5NsMp
 fA6+4XJJLaWH8FHvcSw0S3Pu/sQR4vF4kD/8aFrcp5XNRmClt+6oeTB3CElkEXIe7U
 kIAXdNkwFxBCFVtN7bbnolXrY18oXI+FNXkFed2H+JS5ogcbEY0W6UwM5da1tsqn+A
 q7yYjIFhbtzTyu3Sz8GZ9N2Luvwxji800QW1G5mXqEhsAHVnTX3zzXWpH3oswFIn+N
 2J6zXueFLx0+W+TbsozdLTaSwX3E643gVnqa1hyxhhb+MV0IDtG7AKJYZ8f3wKDLVM
 X+x3ZDt2PeR/IHoUPIcQRVCULNcXkIjU+JvX6cu/Z/CpRiolFgxv7mm2IH6B2UNVfO
 tWHkTKCx6tFWbF/VMoyvYsiccGvwSi+IxIAyIN7ZWMDirpAZUPDtRzNRSMrZPtgj1A
 SQqBlcaVp9lQVOuA/JO0xEhs=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=Gq1xaFzV
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
From: Aristo Chen via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Aristo Chen <aristo.chen@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Add a bootstd test for the error path of the efi_mgr bootmeth: point
BootOrder at a load option that does not exist and check that booting
the bootflow returns -EIO rather than the generic -EFAULT that
bootflow_boot() reports when a boot() method returns zero.

Running the real boot manager initialises the EFI subsystem in the
sandbox process, which would leak into later tests, so restart U-Boot
after this test in test_ut.py as is already done for other
session-changing tests.

Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
---
 test/boot/bootflow.c     | 35 +++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py |  3 ++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 1cc137c9700..2d80577921f 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -470,6 +470,41 @@ static int bootflow_system(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(bootflow_system, UTF_DM | UTF_SCAN_PDATA | UTF_SCAN_FDT |
 	     UTF_CONSOLE);
+
+/* Check that a failed 'efi_mgr' boot reports the boot manager's error */
+static int bootflow_efi_mgr_err(struct unit_test_state *uts)
+{
+	struct udevice *bootstd, *dev;
+	struct bootflow *bflow;
+	int ret;
+
+	if (!IS_ENABLED(CONFIG_EFI_BOOTMGR) || !IS_ENABLED(CONFIG_CMD_EFIDEBUG))
+		return -EAGAIN;
+	ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
+	ut_assertok(device_bind(bootstd, DM_DRIVER_GET(bootmeth_3efi_mgr),
+				"efi_mgr", 0, ofnode_null(), &dev));
+	ut_assertok(device_probe(dev));
+	sandbox_set_fake_efi_mgr_dev(dev, true);
+
+	bootstd_clear_glob();
+	ut_assertok(run_command("bootflow scan -H", 0));
+
+	/* Point BootOrder at a load option that does not exist */
+	ut_assertok(run_command("efidebug boot order 00ff", 0));
+
+	for (ret = bootflow_first_glob(&bflow); !ret;
+	     ret = bootflow_next_glob(&bflow)) {
+		if (!strcmp("efi_mgr", bflow->method->name))
+			break;
+	}
+	ut_assertok(ret);
+
+	/* The boot manager cannot load anything; its error must not be lost */
+	ut_asserteq(-EIO, bootflow_boot(bflow));
+
+	return 0;
+}
+BOOTSTD_TEST(bootflow_efi_mgr_err, UTF_DM | UTF_SCAN_PDATA | UTF_SCAN_FDT);
 #endif
 
 /* Check disabling a bootmethod if it requests it */
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index fa50c8008a5..787020e3e0c 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -643,7 +643,8 @@ def ut_ubman_fixture(ubman, ut_subtest):
 
     yield ubman
 
-    if ut_subtest in ("bootstd bootflow_cmd_boot", "bootstd bootflow_scan_boot"):
+    if ut_subtest in ("bootstd bootflow_cmd_boot", "bootstd bootflow_scan_boot",
+                      "bootstd bootflow_efi_mgr_err"):
         ubman.restart_uboot()
 
 
-- 
2.43.0

