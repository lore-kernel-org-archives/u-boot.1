Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C12C982D2
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:19:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD46D810F5;
	Thu, 17 Sep 2026 17:19:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8zQdjqqMys6I; Thu, 17 Sep 2026 17:19:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1818481109
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789665576;
	b=RdMPgyrSMoTGnaOZc+ywkzAbATZWz4nvZW9s+DDGUR4oCZ5rm7GgeG82uKJgLMp5EIoN
	 FkN4h2rYrKvgESjqvBqwidyFb4HjgGweveVer8tp2T+xHxsIjxYoidCe+oo0WCCUQDDmP
	 vCZKTCPbNG8Qas2aUFDzuzxh1ErDGA9SNrhLdBqp6qn8b1cKIIpimNlERyM/wEjS7zAT8
	 qZVdpHnC0wFx/oE0rxGAiLOOdUTJMQL2xN3WQIp+QFdCBmufp4S9QAOJ58a2SQLsGZEKb
	 ZR6ouUJS5RBkaE5npAy2Y3dwzdHHZehsvslJry8ax07qZjxj2zNjLeChEvgk1m5qvAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789665576;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AZ5apLd8qpNnB/3KpgWFG3QxL7V1Pqh7EBX6t7mRsRI=;
	b=UU7Lsq34mnTAOM7EeF+pzKCm0CxIUOc3oEvSsWbrwpqFC3kSDvpfDjdWCvSM9OaHlF+3
	 CjXePVirc49gmW/zlj5ORvI2XFvj/bUQKH5k48Xh7gkr8s4kteZTWve5BxPYmOw/SSwgQ
	 /qtPN1fHzO7+Nzsl8fJKQ4BQ7vG3aOK41dhQ4PwS8HpnJBpCEsQR3FUr++eny440jZU9m
	 hT1PvkF1KYB6Ac2E3gTmOUmUIilwQw706TX34xyscIBmvtqHucXxB0gABsaC1ZmVIm37f
	 E8y9FdW/rX2D2GuPIoOjqmzrD1kq1WcRvDtcLTbF/F2YaH8m7NyBwLvkiX3kLNVzpxw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789665576;
	bh=AZ5apLd8qpNnB/3KpgWFG3QxL7V1Pqh7EBX6t7mRsRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j2KqfPlTPZM9zOrCQzlTQG+yMCrkq+djnhGMizr/84dzBhN/vVBSkxKOW7HdylQvO
	 A8FdpTZ88Jsdy9wf4X+srCRCB+EbQT2Y4qtT4aUuMqSnHJqPbWW+5L4+Fv0RmDLMY6
	 Gb6FWZKw6S31l4jZ/96eEg+cHu/RrJzOnQmD4Xllljq80Xy4Hcy37hK7PkyM319jfu
	 AHghuhQXjpy9BBk73ehCcCdthzk5P4szlN/QJ+s49wsfSDmJwtEs8WuYZFDq1NUfCh
	 UWsJFnglpgG6AD7aQ8km1tkDnT4fgsTwu8eGbNA/XlKrYfIUg3PAGePufyrjYW8iF+
	 1dcdXYuEnrF3w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1818481109;
	Thu, 17 Sep 2026 17:19:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A0EC6422
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 930686084D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FAZaIKde-dII for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:18:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org BC29460B6B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789665527;
 b=sTjVq1EeqF7+7AWewbx3Jb3pp6XYnUoLUEWANEQ4i6bf7RecsjEwDd1ZTp2BMM+wFCew
 Kf9R4S9aRNWkRp6twTnOvYJyrjlQssmsIkC+1ljTHH4me0kEV6Hd+Uo96Bno07zyNqkQd
 DnAPwciusOJ0BYl5d5A0F+sXqh8U8L3KBjT5IsI7mFCSkqrMhp3Lj7+dcpugG63C/P4Fr
 elTOE6z8jcy8V4Wg56DWXm+GSc8BBFSIqScyP+5y/Fhkmy8H4C2j7CxF6t+fiB+Pz4+7j
 +XE2Ft3fRhSyE9JGdjPFtGPf1G4bCReruN0rESsgTA7KpMskN1a2khKVb8zie/c9Klw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789665527;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=AZ5apLd8qpNnB/3KpgWFG3QxL7V1Pqh7EBX6t7mRsRI=;
 b=dRsUt+/cJucq8Z7U1oaKc4XtlQtTzuti/SE/Ajq93HiOCnCeH7rsmcwb8CzBVEC1Kk/8
 0OmDcTbbLd3OsDhmcUTsPxO+GL4uol/pB5TMQomd4NVp00Rzey711xAC2hAm2CxUQWmAd
 5p4WQeEZwZW+6P+qpShMSjV2md8tzIztc/+mTGitTxym2Mx0rQM5DWjpeL9WAtFBgcjcg
 thGfWoyCpqVF67rjgt+R7mSqAf44W+w+/fuCzCHtyIoKyolCeD1Sv5w6gN+9gqfPZ8dx2
 n8unryHv6r/PeJyZwXmNw0SKBxGyWXkbXeYLVwQEFYb3RVOKa67r/QTS61i4CgsCLew==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=RGg4I2nZ; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=RGg4I2nZ
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id BC29460B6B
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:18:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E997143D;
 Thu, 17 Sep 2026 10:18:42 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4263E3F7B4;
 Thu, 17 Sep 2026 10:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789665526; bh=g9nL2gLtBEKwGyFY7WuiPyd2bEq74w5xLQ1SMDV1LaM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RGg4I2nZoUoSr5Wgb5bYPQba5HlqQ6X6nRCQAtIHDi/vf/2O/7s3EMBwOlXbTK063
 Em5ZocFyrqd4HRbMzlXhzKfFJqA+aq7d7DAWwo26Nf5fys3YgcgtqCc8nhZ9Nk0Fsw
 EWqNDiDo0i6Y9Cdg+fbX3K9RR29V3RK56ijVGgVI=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v6 06/24] arm_ffa: sandbox: Add FFA_MEM_SHARE tests
Date: Thu, 17 Sep 2026 18:17:52 +0100
Message-ID: <20260917171810.4122899-7-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
References: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 17:19:15 +0000
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

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Add positive and negative test cases

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
---
 test/dm/ffa.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/test/dm/ffa.c b/test/dm/ffa.c
index 593b7177fce..e80f9024b8b 100644
--- a/test/dm/ffa.c
+++ b/test/dm/ffa.c
@@ -2,7 +2,7 @@
 /*
  * Functional tests for UCLASS_FFA  class
  *
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2023, 2025-2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -13,6 +13,7 @@
 #include <asm/sandbox_arm_ffa.h>
 #include <asm/sandbox_arm_ffa_priv.h>
 #include <dm/test.h>
+#include <linux/sizes.h>
 #include <test/test.h>
 #include <test/ut.h>
 
@@ -141,6 +142,43 @@ static int test_partitions_and_comms(const char *service_uuid,
 	return 0;
 }
 
+static int  test_ffa_memory_share(bool test_ack, struct unit_test_state *uts)
+{
+	struct ffa_mem_ops_args args = {0};
+	struct ffa_mem_region_attributes attrs = {0};
+	static u8 buf[SZ_4K];
+	int ret;
+	struct udevice *dev;
+
+	ut_assertok(uclass_first_device_err(UCLASS_FFA, &dev));
+
+	args.attrs = &attrs;
+	args.nattrs = 1;
+	args.address = buf;
+	args.pg_cnt = 1;
+
+	if (test_ack) {
+		args.use_txbuf = true;
+
+		ut_assertok(ffa_memory_share(dev, &args));
+		ut_asserteq(HANDLE_LOW(args.g_handle), SANDBOX_MEM_HANDLE);
+		ut_asserteq(HANDLE_HIGH(args.g_handle), SANDBOX_MEM_HANDLE);
+	} else {
+		/* Do not use the TX buffer as a transaction buffer */
+		args.use_txbuf = false;
+		ret = ffa_memory_share(dev, &args);
+		ut_asserteq(-EPROTONOSUPPORT, ret);
+
+		/* No memory region address given */
+		args.use_txbuf = true;
+		args.address = NULL;
+		ret = ffa_memory_share(dev, &args);
+		ut_asserteq(-EINVAL, ret);
+	}
+
+	return 0;
+}
+
 static int dm_test_ffa_ack(struct unit_test_state *uts)
 {
 	struct ffa_priv *uc_priv;
@@ -195,6 +233,9 @@ static int dm_test_ffa_ack(struct unit_test_state *uts)
 	ut_assertok(sandbox_query_ffa_emul_state(FFA_RX_RELEASE, &func_data));
 	check_rxbuf_release_flag(rxbuf_flag, uts);
 
+	/* Test FFA_MEM_SHARE */
+	test_ffa_memory_share(true, uts);
+
 	return 0;
 }
 DM_TEST(dm_test_ffa_ack, UTF_SCAN_FDT | UTF_CONSOLE);
@@ -253,6 +294,9 @@ static int dm_test_ffa_nack(struct unit_test_state *uts)
 	part_id = uc_priv->partitions.descs[0].info.id;
 	ut_assertok(ffa_sync_send_receive(dev, part_id, &msg, 1));
 
+	/* Test FFA_MEM_SHARE */
+	test_ffa_memory_share(false, uts);
+
 	return 0;
 }
 DM_TEST(dm_test_ffa_nack, UTF_SCAN_FDT | UTF_CONSOLE);
-- 
2.43.0

