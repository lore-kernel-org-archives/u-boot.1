Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8C5C02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:37:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8BCE80BA8;
	Wed, 15 Jan 2025 14:32:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bHfA1mFn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5802880BB0; Wed, 15 Jan 2025 14:32:15 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2976180BA2
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:32:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-84cdacbc3dbso521258239f.2
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947931; x=1737552731; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lYENOLwp4FOPOMltgISnnNNwdpn6ziqlc4hHoRdd8o0=;
 b=bHfA1mFnwXCucFA7k4EiVoYJp8cCfiY5xi1HJGJzmYYmcnDva2/1ZcL0H2zsQOsyYO
 nEv/Ng/IRvOVpoS5RAq9oNnAHGO5rQIi54lxvHKgttijfmQRalgwFIOj+kvu8rD4jKXw
 WBxLDHAR99LE4xiUVawY6hj7alJoOAOxrp6y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947931; x=1737552731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lYENOLwp4FOPOMltgISnnNNwdpn6ziqlc4hHoRdd8o0=;
 b=kj5kvqr6CtEr0mWEQnFTQ0ceJpBbG0tRAq8WCbi3fp8a0hfFw2q2fq2p8m4uCSKP8n
 hXezd0/Bx012mRCBWJEmTFaRNMyr/xV4eWkbh5ObLrk9SxcDzGiJxvVpKadivWJZvpMI
 YwlBkl2YZh1UuDm7aAgY63/gwYwyHh3N7PEwYpRXzR6FCIaARRoXySAKX15ML2uxmIMv
 dvpviOID2c+nwiHZ2FzPM2E+Vt08/As6wjS6sLC+ezMcxBoCLbwSrZfsqvKtt6oRS+w8
 m/er8eRoYmDhM//+pFA/Bq2mweo3oFh5/tRmpSCzBrMkpdgTwIzS7knsIJo7IWbkD1JB
 Jk3w==
X-Gm-Message-State: AOJu0YxOygpktaP4g6bsvTEH1Y0r9vfiBibCqd3icF9tBVIT6KGPSa4n
 TBA9SGZ2svzw1GO9taiTv5L35FYcx2/Nu7SOSsZe+2O6BtkrEc1BZmnLbobGjijm9FPCIkFq+NM
 =
X-Gm-Gg: ASbGncvmaejYqpLXYfFuwG2MfRQb2mSUtjDuSKpm4z3g5hMjLxTfJadfgejnEDpPWkz
 7xG7X5RoLPa39cTFcusE5/XRPdCc9tl3W2781lewVPcQz7x0WLFm1remOwvk6/eB1oLawS1a3NR
 YwfAx9NX+aQDj1+pNRWPhxRFCgRyBs9vC5uiUPZUG5cu9Ry8rrTt4/TYa6ATB3vB9muznO/Sf8u
 b/qBa28mMw0az29avvA/G7+YugvpQk+vtOMjguCKwPjs5j6KFbu93nedsh2ITWiSCG+873v2Eu/
 +pqP2p28bIbdymqrIA==
X-Google-Smtp-Source: AGHT+IEN3etCU9C+/rxMlXeZM0GonliinZuWJdJvI8vlnojO/OfGdigv6t9EPP8kKkl35nTHWjoWhQ==
X-Received: by 2002:a05:6602:400a:b0:835:3ffe:fe31 with SMTP id
 ca18e2360f4ac-84ce00a0987mr2793590139f.8.1736947931195; 
 Wed, 15 Jan 2025 05:32:11 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:32:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 30/43] test: Drop the function for running loadm tests
Date: Wed, 15 Jan 2025 06:31:00 -0700
Message-Id: <20250115133114.590375-31-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115133114.590375-1-sjg@chromium.org>
References: <20250115133114.590375-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Use the new suite-runner to run these tests instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/test/suites.h | 1 -
 test/cmd/loadm.c      | 9 ---------
 test/cmd_ut.c         | 2 +-
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/test/suites.h b/include/test/suites.h
index b96a78f7129..f6b33da5a28 100644
--- a/include/test/suites.h
+++ b/include/test/suites.h
@@ -32,7 +32,6 @@ int cmd_ut_category(const char *name, const char *prefix,
 
 int do_ut_bootstd(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
-int do_ut_loadm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_optee(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[]);
 int do_ut_overlay(struct cmd_tbl *cmdtp, int flag, int argc,
 		  char *const argv[]);
diff --git a/test/cmd/loadm.c b/test/cmd/loadm.c
index 78bb12ce88c..3c623aa655f 100644
--- a/test/cmd/loadm.c
+++ b/test/cmd/loadm.c
@@ -58,12 +58,3 @@ static int loadm_test_load (struct unit_test_state *uts)
 	return 0;
 }
 LOADM_TEST(loadm_test_load, UTF_CONSOLE);
-
-int do_ut_loadm(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
-{
-	struct unit_test *tests = UNIT_TEST_SUITE_START(loadm);
-	const int n_ents = UNIT_TEST_SUITE_COUNT(loadm);
-
-	return cmd_ut_category("loadm", "loadm_test_", tests, n_ents, argc,
-			       argv);
-}
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 39489ba0811..0a6284e4962 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -179,7 +179,7 @@ static struct suite suites[] = {
 	SUITE(hush),
 #endif
 #ifdef CONFIG_CMD_LOADM
-	SUITE_CMD(loadm, do_ut_loadm),
+	SUITE(loadm),
 #endif
 #ifdef CONFIG_CMD_PCI_MPS
 	SUITE_CMD(pci_mps, do_ut_pci_mps),
-- 
2.34.1

