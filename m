Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87113E63FE8
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 11:34:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A877183C14;
	Sun,  5 Apr 2026 13:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gspXCxeI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB57983C5E; Sun,  5 Apr 2026 13:34:46 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8484C8394E
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 13:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso2716377a34.0
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 04:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775388882; x=1775993682; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DQ2YPiicZEiGfq1gGw1TCUGe8aDcQ0nNtxSZ32ZlZ4Y=;
 b=gspXCxeIZtFTkGXq9d1g9bA/kLhOVUZopZRN04shSznjRFSAPpPfc2gtyusBWdScxA
 xpDHxmyeF6sx/7Lxb0snejpLmRZf2pXNej+lDutjM124Prw5CVHrQv6NzeZRSRzzD4Ps
 LHpnSWhlUguFv5NnueCBkPIHrenm2QiLHxgUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775388882; x=1775993682;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DQ2YPiicZEiGfq1gGw1TCUGe8aDcQ0nNtxSZ32ZlZ4Y=;
 b=CfASLkrPIvQ9tQ7Bvx77c2kxj/LND+DreC96Yijz5gktQ8rXyqnNwj+HW9dQ6S139D
 KM1S2Xd86iG3Dq+IgjK7CKTvCSqokzsvOHHL2te/zWF1tqQUgw1FQZW5yxY1MO7yYp5a
 /tLuV1NcWrVqGrgTE19DZo+kYMeWmRh9n4WlOfna4dVqHI9HjHEb9upF+mIWMW0nhbmV
 LyWenO70BLBw6iMKetTkXZS/2fJYxz13AZqUuv4abtOBn5sCl6sNc989+cUtQB73K6uv
 LxFFLLEEfsDNL++1w9qwZr34sxf+wJh+d3zBztpFp38zfy3f4msMqlx/VQ1RYU3hxQ/y
 1LLg==
X-Gm-Message-State: AOJu0Yy81f5oeWR1Ot5vt1/2XjfEKYi6oX6DsLbqR4FTNrOToeSVJbAR
 MpVzDwqT/RUHekF0bTcoe2KWFdtDPda3nHshEgvKv/Uk19rYZnCgw8CZt6er2vJRo0Y3XNP6KZk
 tCuuRyw==
X-Gm-Gg: AeBDietViZSo3hDlgnOzZGiGNtvt7sR3LB1CAS5okstu9ocZT1i2m9LfLIM+OA0AyD6
 JXEsIvdm5m+poLckoMlgRFSdrQ1sPuRcMhXrkLxMZWuaOBR29JIony/LnnfJMraM99arDPgCT/B
 4mmWd3ZVCfCGKOYkmnTfcBDcOj6Cbt40ha5NC0PLL62vG/9KkTjz8ltsqVDbaIY/+DLkPrt55CR
 /tgS0IZd3R5db0fe7gLyo1MCIZoyujeBeHST+kNMz0BjpGC50Bpq5Ttxwk4dIAEZghc1dDF5WXv
 EIttvHSWQA3xa4bxJ5XDrs+roRuubUmk9oOOxignu6mf+ToiCHX/foAmScC/52/XPAo/P12ZPG3
 xvuDtpoF1vvKRXSSRHQVCF9XrlElIaUui/2fWtE18DfQ4EnLzSaSDc90bbUEdjgIgA6nnaQKkIt
 4+lIMOl+mrzXfV6luoNg==
X-Received: by 2002:a05:6830:63ca:b0:7d7:ecda:cc3f with SMTP id
 46e09a7af769-7dbb6f3d283mr6102794a34.0.1775388882512; 
 Sun, 05 Apr 2026 04:34:42 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dba7159fd9sm8114027a34.7.2026.04.05.04.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 04:34:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Ryan=20Pers=C3=A9e?= <ryan.persee@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Martyn Welch <martyn.welch@collabora.com>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>
Subject: [PATCH v2] bootstd: efi: Handle prior-stage FDT in network path
Date: Sun,  5 Apr 2026 05:34:32 -0600
Message-ID: <20260405113436.1849007-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When CONFIG_OF_HAS_PRIOR_STAGE is enabled and fdtfile is not set,
efi_get_distro_fdt_name() returns -EALREADY to indicate the prior-stage
FDT should be used. The block-device EFI path handles this by setting
BOOTFLOWF_USE_PRIOR_FDT, but the network path treats it as an error,
causing the bootflow to stay in 'base' state with a -EALREADY error.

This also means fdt_addr_r is required even when no FDT download is
needed, giving a spurious  -EINVAL error.

Fix this by calling efi_get_distro_fdt_name() before checking
fdt_addr_r, and handling -EALREADY by setting BOOTFLOWF_USE_PRIOR_FDT
to skip the FDT download, matching the block-device behaviour.

THere is no test for this at present, since sandbox does not enable
CONFIG_OF_HAS_PRIOR_STAGE and lacks infra for network-based EFI boot.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Return early in the -EALREADY case instead of using a big else block

 boot/bootmeth_efi.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index f592fec07f6..e187dc39912 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -269,17 +269,22 @@ static int distro_efi_read_bootflow_net(struct bootflow *bflow)
 		return log_msg_ret("fi0", -ENOMEM);
 
 	/* read the DT file also */
+	ret = efi_get_distro_fdt_name(fname, sizeof(fname), 0);
+	if (ret == -EALREADY) {
+		/* Prior-stage FDT is used, no download needed */
+		bflow->flags |= BOOTFLOWF_USE_PRIOR_FDT;
+		bflow->state = BOOTFLOWST_READY;
+		return 0;
+	} else if (ret) {
+		return log_msg_ret("nam", ret);
+	}
+
 	fdt_addr_str = env_get("fdt_addr_r");
 	if (!fdt_addr_str)
 		return log_msg_ret("fdt", -EINVAL);
 	fdt_addr = hextoul(fdt_addr_str, NULL);
 	sprintf(file_addr, "%lx", fdt_addr);
 
-	/* We only allow the first prefix with PXE */
-	ret = efi_get_distro_fdt_name(fname, sizeof(fname), 0);
-	if (ret)
-		return log_msg_ret("nam", ret);
-
 	bflow->fdt_fname = strdup(fname);
 	if (!bflow->fdt_fname)
 		return log_msg_ret("fil", -ENOMEM);
-- 
2.43.0

base-commit: 1c1bfb1cf34bbb2a5717eb6995c55093279f9341
branch: bootstd-fix-us2
