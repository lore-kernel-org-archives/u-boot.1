Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48DAC55174
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 20:19:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5DFF041146;
	Fri, 31 Jul 2026 20:19:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9vaTFDHjy0Wc; Fri, 31 Jul 2026 20:19:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F003C410E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785529182;
	bh=N9aGEzkLST31Cw6mR6RIHjPl6aPwaLeiBQtcs359c3E=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=al3LNBTbeXrETO9Y9PBo9hRmtfPXJyj/w+hDxaNaYX/dNPBemBkDOkGGVbDfSyksz
	 FQJcRLnkFetLOMM+431JPbqZG7+weeZMw0hUNfp25zazYnwQytDTXvRgdsyGknrH1h
	 ch9UkG5EKqvGaRDyfUS9C/OWnGsiWfzMdzuQd6TRxA0a6TEd/HkAzZjQS455DnE2t6
	 SYwi0htMwyHZ60SI8tPDMidC/MD2VibrqrJO04VXZpYYRbzF5tw3QEnS4R+8RZ1+pK
	 ZfoOKPfn9l3sAKB35PPD4qTMARBsPEqXSlKHCb8d9zGWEfvAF0byNrgz8kEXe2Gfqg
	 XXoq3uK/je+lg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F003C410E9;
	Fri, 31 Jul 2026 20:19:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5847F26F
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 20:19:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4A23940119
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 20:19:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KNdyNBiyIFZv for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 20:19:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22a; helo=mail-oi1-x22a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6E03C400F5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6E03C400F5
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6E03C400F5
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 20:19:39 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-495c63c4141so839144b6e.2
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 13:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785529178; x=1786133978;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N9aGEzkLST31Cw6mR6RIHjPl6aPwaLeiBQtcs359c3E=;
 b=aZ7mDzf811z5Ys5is7DkDe9fkQX6OUGSlG88PlOjUIvjizR1YnFYSqGz/Ta+BayFCX
 /f3a5zcl+3xOBVD26RDA3VhQ/FHytspYzycv+7qAzEFrByHdtsgB4udkNMs2Qe00PBvh
 L9I+ti522ePlmvS018i1bCVHPrEZX1vKzbpTD8Az2ygzO8bup6SougH3azaNRltKS/xh
 Twr7s/jWxUaEa9EDqO6+y6p1zEKa/9mutWycq4SM8ajcfsiLJ+OWgaALoujALSrh/0zl
 +k/MC2rMhL158vJa3VgSaveimdeTgJcMVl/Bx0X1N7TSWONXBztoFP/X2sMv07FDN4pW
 qbqA==
X-Gm-Message-State: AOJu0Yxff+Xy4kK2SHOt2G2kPrlM2uc6r7BCC8GJFFsZRUCEC5vyzJCf
 3nPLvbqVHrDFfdL6mX/gGAE/HG1D0qBWxScQPFoyT/xhBaz38YKYO/5hggkEO79aD4UNpE2dlvr
 FbALfjbU=
X-Gm-Gg: AR+sD13mlSSIzUEq803HhJhuNWN5TEXF5bzk9t+4fPHY7vyB6Q/AWkzHql9JFlIU9Av
 sdNVrAV/H9xrWcr9hLV5/qOuifeBuNKKvCnnSzk+gg/VtJ5Cco0jOrDxLS22t8GW9oc8NhZlNJU
 vCrWv4oM3olH6/17JWbPzgbOF14/idIhe0Q5JVhU4W6FmTIXq3cWPk2TTcKxl6pxWolrnprcFdO
 zhwlFGHHpUAeMOsBXsWHWHBRuN01iCwalONAHqo3Lmn6UL+KkgJhdzOrYO1fA8sF2aBKk38ifiQ
 998r805L2ZqRYYBe7fJsN7/hI/6EwsfF6ISlfybRKduPC/qpJDmguLlvTKgzSDCFOBsG65kO/1E
 SFp7Ngj3o48kKunXrElodJHkNB/vsQdym6zQu84YdK8EpeYSpMdKInpysBkky9TWGJtSLSijFTd
 yex0nvDoVuMo8ugtm1pZqg+YXSumwbvbteA9VvoE8t2s6STETpACo1Nevygnf12FweKZVnkln54
 9nkSXI5qWwKCTIuYcXHa98Wjfykq8McUfIA11i63H59k22fRQ7ewrv1pAjjjrd/rVEGVk0avDe9
 YAdZdQCEnkoNtDYqk+nUwbNpBuQSnw9sHQ==
X-Received: by 2002:a05:6808:1806:b0:495:d0dd:c6eb with SMTP id
 5614622812f47-4af5e29c90cmr2290551b6e.11.1785529178243; 
 Fri, 31 Jul 2026 13:19:38 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4af58f25e00sm1409258b6e.14.2026.07.31.13.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 13:19:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org
Cc: Randolph Sapp <rs@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] Gitlab CI: sage: Disable test_net_tftpboot_boot on Raspberry
 Pi 4 for now
Date: Fri, 31 Jul 2026 14:19:35 -0600
Message-ID: <20260731201935.2542305-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785529178; x=1786133978;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=N9aGEzkLST31Cw6mR6RIHjPl6aPwaLeiBQtcs359c3E=;
 b=k71wB7MVYvoOlFt/SH7LKEoptcP+LfWhQVjRqJNCzSOCxAcAGx6vEOauuF4vOTOirY
 bC2IVrjHVAqPY5g1RsZ1h2ptLlr82ph/Utvp4u15zpfPArMrfZASdbGQcpHCdxq3dc+n
 6PGVy9sXbqYMH3vucRyg7/vT9/ddzoMbuWMDY=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=k71wB7MV
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

With commit 623f6c5b6ab7 ("boot: image-fdt: free old dtb reservations")
we now get:
ERROR: freeing fdt memory region failed (addr=3ef667e0 size=36 flags=2): -1
ERROR: freeing fdt memory region failed (addr=3ef663a0 size=400 flags=2): -1
on console when booting, which is non-fatal but leads to the test
failing. Disable this test for now.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Randolph Sapp <rs@ti.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>
---
 .gitlab-ci-sage-lab.yml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci-sage-lab.yml b/.gitlab-ci-sage-lab.yml
index 90f97696f86c..9e1c2378c6ef 100644
--- a/.gitlab-ci-sage-lab.yml
+++ b/.gitlab-ci-sage-lab.yml
@@ -144,6 +144,9 @@ Raspberry Pi 4:
     LABGRID_EXPORTER: "sage-exporter-rpi4-1"
     LG_PLACE: "rpi4-1"
     TEST_PY_BD: "rpi_4"
+    # With commit 623f6c5b6ab7 we get "ERROR" messages that are
+    # harmless during OS boot but fail the test.
+    TEST_PY_TEST_SPEC: "not test_net_tftpboot_boot"
     OVERRIDE: "-a UNIT_TEST -a ~CMD_EFIDEBUG -a CMD_BOOTMENU -a CMD_LOG -a ~CMD_BOOTEFI_SELFTEST -a CMD_TFTPPUT -a FIT -a FIT_SIGNATURE -a FIT_BEST_MATCH -a SYS_BOOTM_LEN=0x4000000 -a BOOTSTAGE -a BOOTSTAGE_STASH -a CMD_BOOTSTAGE -a BOOTSTAGE_STASH_ADDR=0x02400000"
 
 Raspberry Pi 4 (rpi_arm64):
@@ -154,7 +157,9 @@ Raspberry Pi 4 (rpi_arm64):
     LG_PLACE: "rpi4-1"
     TEST_PY_BD: "rpi_arm64"
     # DHCP is not being run first, needs to be investigated.
-    TEST_PY_TEST_SPEC: "not test_efi_helloworld_net_http"
+    # With commit 623f6c5b6ab7 we get "ERROR" messages that are
+    # harmless during OS boot but fail the test.
+    TEST_PY_TEST_SPEC: "not test_efi_helloworld_net_http and not test_net_tftpboot_boot"
     OVERRIDE: "-a UNIT_TEST -a ~CMD_EFIDEBUG -a CMD_BOOTMENU -a CMD_LOG -a ~CMD_BOOTEFI_SELFTEST -a FIT -a FIT_SIGNATURE -a FIT_BEST_MATCH -a SYS_BOOTM_LEN=0x4000000 -a BOOTSTAGE -a BOOTSTAGE_STASH -a CMD_BOOTSTAGE -a BOOTSTAGE_STASH_ADDR=0x02400000"
 
 Raspberry Pi 4 (rpi_4_32b):
-- 
2.43.0

